within AixLib.Electrical.PVSystem;
model PVSystemDC
  "Model that determines the DC performance of a PV array"


replaceable parameter AixLib.DataBase.SolarElectric.PVBaseRecordNew data= AixLib.DataBase.SolarElectric.QPlusBFRG41285()
    "Choose a PV module record"
    annotation (choicesAllMatching);

 parameter Real n_mod
    "Number of connected PV modules"
    annotation (Dialog(group="Array size", tab="Array configuration"));

 parameter Real til(final quantity = "Angle",
   final unit = "rad",
   displayUnit = "deg")
   "Surface tilt. til=90 degree for walls; til=0 for ceilings; til=180 for roof"
   annotation (Dialog(group="Module orientation", tab="Array configuration"));

 parameter Real azi(final quantity = "Angle",
   final unit = "rad",
   displayUnit = "deg")
   "Module surface azimuth. azi=-90 degree if normal of surface outward unit points towards east; azi=0 if it points towards south"
   annotation (Dialog(group="Module orientation", tab="Array configuration"));

 parameter Real lat(final quantity = "Angle",
   final unit = "rad",
   displayUnit = "deg") "Latitude"
   annotation (Dialog(tab="Geographical info"));

 parameter Real lon(final quantity = "Angle",
   final unit = "rad",
   displayUnit = "deg") "Longitude"
   annotation (Dialog(tab="Geographical info"));

 parameter Real alt(final quantity="Length", final unit="m")
   "Site altitude in Meters, default= 1"
   annotation (Dialog(tab="Geographical info"));

 parameter Real timZon(final quantity="Time",
   final unit="s", displayUnit="h")
   "Time zone in seconds relative to GMT"
   annotation (Dialog(tab="Geographical info"));

 parameter Real  groRef(final unit="1")
   "Ground reflectance"
   annotation (Dialog(tab="Geographical info"));


 IVCharacteristics iVCharacteristics(
   data=data,
   n_mod = n_mod)
   "Model for determining the I-V characteristics of a PV array"
   annotation (Placement(transformation(extent={{10,-42},{30,-22}}, rotation=0)));

 CellTemperature cellTemperature(
   data=data)
   "Model for determining the cell temperature of a PV array"
   annotation (Placement(transformation(extent={{-40,56},{-20,76}}, rotation=0)));


 replaceable model IVCharacteristics =
    AixLib.Electrical.PVSystem.BaseClasses.PVModule5pAnalytical
    constrainedby
    AixLib.Electrical.PVSystem.BaseClasses.PartialIVCharacteristics
    "Model for determining the I-V characteristics of a PV array" annotation (choicesAllMatching=
    true);

 replaceable model CellTemperature =
    AixLib.Electrical.PVSystem.BaseClasses.CellTemperatureMountingCloseToGround
    constrainedby AixLib.Electrical.PVSystem.BaseClasses.PartialCellTemperature
    "Model for determining the cell temperature of a PV array" annotation (choicesAllMatching=
    true);


 Modelica.Blocks.Interfaces.RealOutput DCOutputPower(
  final quantity="Power",
  final unit="W")
  "DC output power of the PV array" annotation (Placement(transformation(extent={{100,-10},{120,10}})));


  BaseClasses.PVRadiationHorizontalTRY pVRadiationHorizontalTRY(
   final lat = lat,
   final lon = lon,
   final alt = alt,
   final til = til,
   final azi = azi,
   final groRef = groRef,
   final timZon = timZon)
   "Radiation and absorptance model for PV simulations"
    annotation (Placement(transformation(extent={{-78,-50},{-58,-30}})));

  BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-120,-22},{-80,18}}), iconTransformation(extent=
           {{-160,-4},{-140,16}})));
equation


  connect(pVRadiationHorizontalTRY.radTil, iVCharacteristics.radTil)
    annotation (Line(points={{-57,-46},{-24,-46},{-24,-40},{8,-40}},
                                                                 color={0,0,127}));
  connect(pVRadiationHorizontalTRY.absRadRat, iVCharacteristics.absRadRat)
    annotation (Line(points={{-57,-34},{-24,-34},{-24,-36},{8,-36}},
                                                                   color={0,0,127}));
  connect(pVRadiationHorizontalTRY.radTil, cellTemperature.radTil)
    annotation (Line(points={{-57,-46},{-54,-46},{-54,57.8},{-42,57.8}},
                                                                     color={0,0,127}));
  connect(iVCharacteristics.eta, cellTemperature.eta)
    annotation (Line(points={{31,-38},{76,-38},{76,-60},{-50,-60},{-50,61.8},{
          -42,61.8}},                                                                     color={0,0,127}));
  connect(cellTemperature.T_c, iVCharacteristics.T_c)
    annotation (Line(points={{-18,66},{-6,66},{-6,-28},{8,-28}}, color={0,0,127}));
  connect(iVCharacteristics.DCOutputPower, DCOutputPower)
    annotation (Line(points={{31,-26},{66,-26},{66,0},{110,0}}, color={0,0,127}));
  connect(cellTemperature.T_a, weaBus.TDryBul) annotation (Line(points={{-42,
          75.4},{-78,75.4},{-78,-2},{-100,-2}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(cellTemperature.winVel, weaBus.winSpe) annotation (Line(points={{-42,
          71.9},{-78,71.9},{-78,-2},{-100,-2}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(pVRadiationHorizontalTRY.radHorBea, weaBus.HDirNor) annotation (Line(
        points={{-80,-34},{-90,-34},{-90,-2},{-100,-2}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(pVRadiationHorizontalTRY.radHorDif, weaBus.HDifHor) annotation (Line(
        points={{-80,-46},{-90,-46},{-90,-2},{-100,-2}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(graphics={
     Rectangle(
      lineColor={0,0,0},
      fillColor={255,255,255},
      fillPattern=FillPattern.Solid,
      extent={{-100,100},{100,-100}}),
     Text(
      lineColor={0,0,0},
      extent={{-96,95},{97,-97}},
           textString="PV")}), Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Model that determines the DC performance of a PV array </p>
<h4><span style=\"color: #008000\">Concept</span></h4>
<p><b>IVCharacteristics</b>: Model for determining the I-V characteristics of a PV array</p>
<p><b>CellTemperature</b>: Model for determining the cell temperature of a PV array</p>
<p><b>Value selection for groRef</b>: </p>
<p>Default:&nbsp;0.2</p>
<p>Urban&nbsp;environment:&nbsp;0.14&nbsp;-&nbsp;0.22</p>
<p>Grass:&nbsp;0.15&nbsp;-&nbsp;0.25</p>
<p>Fresh&nbsp;grass:&nbsp;0.26</p>
<p>Fresh&nbsp;snow:&nbsp;0.82</p>
<p>Wet&nbsp;snow:&nbsp;0.55-0.75</p>
<p>Dry&nbsp;asphalt:&nbsp;0.09-0.15</p>
<p>Wet&nbsp;Asphalt:&nbsp;0.18</p>
<p>Concrete:&nbsp;0.25-0.35</p>
<p>Red&nbsp;tiles:&nbsp;0.33</p>
<p>Aluminum:&nbsp;0.85</p>
<p>Copper:&nbsp;0.74</p>
<p>New&nbsp;galvanized&nbsp;steel:&nbsp;0.35</p>
<p>Very&nbsp;dirty&nbsp;galvanized&nbsp;steel:&nbsp;0.08</p>
</html>"));
end PVSystemDC;
