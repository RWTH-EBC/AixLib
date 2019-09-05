within AixLib.Electrical.PVSystem;
model PVSystemDC
  "Model that determines the DC performance of a PV array"


 parameter AixLib.DataBase.SolarElectric.PVBaseRecordNew data
    "Choose a PV module record"
    annotation (Dialog(group="Module type", tab="Array configuration"));

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
   "Ground refelctance"
   annotation (Dialog(tab="Geographical info"));

// Guidance for value selection of groRef (PVSyst)

    //Default 0.2
    //Urban environment 0.14 – 0.22
    //Grass 0.15 – 0.25 / Fresh grass 0.26
    //Fresh snow 0.82
    //Wet snow 0.55-0.75
    //Dry asphalt 0.09-0.15
    //Wet Asphalt 0.18
    //Concrete 0.25-0.35
    //Red tiles 0.33
    //Aluminum 0.85
    //Copper 0.74
    //New galvanized steel 0.35
    //Very dirty galvanized steel 0.08



 Modelica.Blocks.Interfaces.RealInput radHorBea(final quantity="Irradiance",
   final unit= "W/m2")
   "Beam solar radiation on the horizontal surface"
   annotation (Placement(transformation(extent={{-142,-48},{-100,-6}}),iconTransformation(extent={{-140,-46},{-100,-6}})));

 Modelica.Blocks.Interfaces.RealInput radHorDif(final quantity="Irradiance",
   final unit= "W/m2")
   "Diffuse solar radiation on the horizontal surface"
   annotation (Placement(transformation(extent={{-140,-100},{-100,-60}}), iconTransformation(extent={{-140,-100},{-100,
            -60}})));


 Modelica.Blocks.Interfaces.RealInput T_a(final quantity=
    "Temp_C", final unit="K")
    "Ambient temperature"
    annotation (Placement(transformation(extent={{-140,50},{-100,100}}),iconTransformation(extent={{-140,60},{-100,100}})));

 Modelica.Blocks.Interfaces.RealInput winVel(final quantity= "Velocity",
    final unit= "m/s")
    "Wind velocity"
    annotation (Placement(transformation(extent={{-140,-2},{-100,48}}), iconTransformation(extent={{-140,8},{-100,48}})));


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
    annotation (Placement(transformation(extent={{-74,-34},{-54,-14}})));

equation


  connect(pVRadiationHorizontalTRY.radTil, iVCharacteristics.radTil)
    annotation (Line(points={{-53,-30},{-46,-30},{-46,-40},{8,-40}},
                                                                 color={0,0,127}));
  connect(pVRadiationHorizontalTRY.absRadRat, iVCharacteristics.absRadRat)
    annotation (Line(points={{-53,-18},{-40,-18},{-40,-36},{8,-36}},
                                                                   color={0,0,127}));
  connect(pVRadiationHorizontalTRY.radTil, cellTemperature.radTil)
    annotation (Line(points={{-53,-30},{-50,-30},{-50,57.8},{-42,57.8}},
                                                                     color={0,0,127}));
  connect(iVCharacteristics.eta, cellTemperature.eta)
    annotation (Line(points={{31,-38},{36,-38},{36,-60},{-90,-60},{-90,61.8},{-42,61.8}}, color={0,0,127}));
  connect(cellTemperature.T_c, iVCharacteristics.T_c)
    annotation (Line(points={{-18,66},{-6,66},{-6,-28},{8,-28}}, color={0,0,127}));
  connect(iVCharacteristics.DCOutputPower, DCOutputPower)
    annotation (Line(points={{31,-26},{66,-26},{66,0},{110,0}}, color={0,0,127}));
  connect(cellTemperature.T_a, T_a)
    annotation (Line(points={{-42,75.4},{-66,75.4},{-66,75},{-120,75}}, color={0,0,127}));
  connect(cellTemperature.winVel, winVel)
    annotation (Line(points={{-42,71.9},{-68,71.9},{-68,72},{-94,72},{-94,23},{-120,23}}, color={0,0,127}));
  connect(pVRadiationHorizontalTRY.radHorDif, radHorDif)
    annotation (Line(points={{-76,-30},{-80,-30},{-80,-80},{-120,-80}}, color={0,0,127}));
  connect(pVRadiationHorizontalTRY.radHorBea, radHorBea)
    annotation (Line(points={{-76,-18},{-80,-18},{-80,-27},{-121,-27}},
                                                                      color={0,0,127}));
  annotation (Icon(graphics={
     Rectangle(
      lineColor={0,0,0},
      fillColor={255,255,255},
      fillPattern=FillPattern.Solid,
      extent={{-100,100},{100,-100}}),
     Text(
      lineColor={0,0,0},
      extent={{-96,95},{97,-97}},
           textString="PV")}));
end PVSystemDC;
