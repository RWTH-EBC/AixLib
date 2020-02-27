within AixLib.Electrical.PVSystem;
model PVSystem
  "Model that determines the DC performance of a Silicium-based PV array"

replaceable parameter AixLib.DataBase.SolarElectric.PVBaseRecord data
    "Choose a PV module record" annotation (choicesAllMatching);
replaceable model IVCharacteristics =
    AixLib.Electrical.PVSystem.BaseClasses.PartialIVCharacteristics
    "Model for determining the I-V characteristics of a PV array" annotation (choicesAllMatching=
    true);

replaceable model CellTemperature =
    AixLib.Electrical.PVSystem.BaseClasses.PartialCellTemperature
    "Model for determining the cell temperature of a PV array" annotation (choicesAllMatching=
    true);

 parameter Real n_mod
    "Number of connected PV modules";
 parameter Modelica.SIunits.Angle til
 "Surface's tilt angle (0:flat)"
  annotation (Dialog(group="Geometry"));
 parameter Modelica.SIunits.Angle azi
   "Surface's azimut angle (0:South)"
   annotation (Dialog(group="Geometry"));
 parameter Modelica.SIunits.Angle lat
 "Location's Latitude"
   annotation (Dialog(group="Location"));
 parameter Modelica.SIunits.Angle lon
 "Location's Longitude"
   annotation (Dialog(group="Location"));
 parameter Real alt(final quantity="Length", final unit="m")
   "Site altitude in Meters, default= 1"
   annotation (Dialog(group="Location"));
 parameter Modelica.SIunits.Time timZon(displayUnit="h")
    "Time zone. Should be equal with timZon in ReaderTMY3, if PVSystem and ReaderTMY3 are used together." annotation (Dialog(group="Location"));
 parameter Real groRef(final unit="1") = 0.2
  "Ground reflectance (default=0.2)
  Urban environment: 0.14 - 0.22
  Grass: 0.15 - 0.25
  Fresh grass: 0.26
  Fresh snow: 0.82
  Wet snow: 0.55-0.75
  Dry asphalt: 0.09-0.15
  Wet Asphalt: 0.18
  Concrete: 0.25-0.35
  Red tiles: 0.33
  Aluminum: 0.85
  Copper: 0.74
  New galvanized steel: 0.35
  Very dirty galvanized steel: 0.08"
  annotation (Dialog(group="Location"));

  parameter Boolean use_ParametersGlaz=false
    "= false if standard values for glazing can be used" annotation(choices(checkBox=true));

  parameter Real glaExtCoe(final unit="1/m") = 4
  "Glazing extinction coefficient (for glass = 4)" annotation(Dialog(enable=
          use_ParametersGlaz));

  parameter Real glaThi(final unit="m") = 0.002
  "Glazing thickness (for most cells = 0.002 m)" annotation(Dialog(enable=
          use_ParametersGlaz));

  parameter Real refInd(final unit="1", min=0) = 1.526
  "Effective index of refraction of the cell cover (glass = 1.526)" annotation(Dialog(enable=
          use_ParametersGlaz));

  IVCharacteristics iVCharacteristics(n_mod=n_mod, data=data)
    "Model for determining the I-V characteristics of a PV array" annotation (
      Placement(transformation(extent={{10,-42},{30,-22}}, rotation=0)));

  CellTemperature cellTemperature(data=data)
    "Model for determining the cell temperature of a PV array" annotation (
      Placement(transformation(extent={{-40,56},{-20,76}}, rotation=0)));

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
   final timZon = timZon,
    glaExtCoe=glaExtCoe,
    glaThi=glaThi,
    refInd=refInd)
   "Radiation and absorptance model for PV simulations"
    annotation (Placement(transformation(extent={{-32,-50},{-12,-30}})));

  BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-122,-4},{-82,36}}),  iconTransformation(extent={{-128,-4},
            {-108,16}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-78,-94},{-58,-74}})));
equation

  connect(pVRadiationHorizontalTRY.radTil, iVCharacteristics.radTil)
    annotation (Line(points={{-11,-46},{-24,-46},{-24,-40},{8,-40}},
                                                                 color={0,0,127}));
  connect(pVRadiationHorizontalTRY.absRadRat, iVCharacteristics.absRadRat)
    annotation (Line(points={{-11,-34},{-2,-34},{-2,-36},{8,-36}}, color={0,0,127}));
  connect(pVRadiationHorizontalTRY.radTil, cellTemperature.radTil)
    annotation (Line(points={{-11,-46},{-54,-46},{-54,57.8},{-42,57.8}},
                                                                     color={0,0,127}));
  connect(iVCharacteristics.eta, cellTemperature.eta)
    annotation (Line(points={{31,-38},{76,-38},{76,-60},{-50,-60},{-50,61.8},{
          -42,61.8}},                                                                     color={0,0,127}));
  connect(cellTemperature.T_c, iVCharacteristics.T_c)
    annotation (Line(points={{-18,66},{-6,66},{-6,-28},{8,-28}}, color={0,0,127}));
  connect(iVCharacteristics.DCOutputPower, DCOutputPower)
    annotation (Line(points={{31,-26},{66,-26},{66,0},{110,0}}, color={0,0,127}));
  connect(weaBus.winSpe, cellTemperature.winVel) annotation (Line(
      points={{-102,16},{-72,16},{-72,71.9},{-42,71.9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.TDryBul, cellTemperature.T_a) annotation (Line(
      points={{-102,16},{-72,16},{-72,75.4},{-42,75.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(pVRadiationHorizontalTRY.radHorDif, weaBus.HDifHor) annotation (Line(
        points={{-34,-46},{-94,-46},{-94,16},{-102,16}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add.u1, weaBus.HGloHor) annotation (Line(points={{-80,-78},{-80,16},{-102,
          16}},                color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add.u2, weaBus.HDifHor) annotation (Line(points={{-80,-90},{-84,-90},{
          -84,16},{-102,16}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add.y, pVRadiationHorizontalTRY.radHorBea) annotation (Line(points={{-57,
          -84},{-46,-84},{-46,-34},{-34,-34}}, color={0,0,127}));
  annotation (Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),      Polygon(points={{-80,-80},{-40,80},{80,80},{40,-80},
              {-80,-80}}, lineColor={0,0,0}),
        Line(points={{-60,-76},{-20,76}}, color={0,0,0}),
        Line(points={{-34,-76},{6,76}}, color={0,0,0}),
        Line(points={{-8,-76},{32,76}}, color={0,0,0}),
        Line(points={{16,-76},{56,76}}, color={0,0,0}),
        Line(points={{-38,60},{68,60}}, color={0,0,0}),
        Line(points={{-44,40},{62,40}}, color={0,0,0}),
        Line(points={{-48,20},{58,20}}, color={0,0,0}),
        Line(points={{-54,0},{52,0}}, color={0,0,0}),
        Line(points={{-60,-20},{46,-20}}, color={0,0,0}),
        Line(points={{-64,-40},{42,-40}}, color={0,0,0}),
        Line(points={{-70,-60},{36,-60}}, color={0,0,0})}),
                               Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Model that determines the DC performance of a PV array. </p>
<h4><span style=\"color: #008000\">Concept</span></h4>
<p>Model consists of a model determining the <b>IV Characteristic</b>, a model to calculate the <b>cell temperature</b> and a model to calculate the irradiance and absorption ratio for the PV module.</p>
<p><b>IVCharacteristics</b>: Model for determining the I-V characteristics of a PV array based on Batzelis et al., De Soto et al. and Boyd.</p>
<p><br>Two cell temperature models are implemented and should be chosen depending on the module&acute;s topology. </p>
<p><b>CellTemperature models</b>: Model for determining the cell temperature of a PV module</p>
<ol>
<li><b>CellTemperatureOpenRack:</b> Module is installed on open rack based on Duffie et al.</li>
<li><b>CellTemperatureMountingCloseToGround: </b>Module is installed close to ground (e.g. on roof) based on King et al.</li>
</ol>
<h4>Known limitations</h4>
<p>Model does not include line losses and decreasing panel efficiency due to shading!</p>
<p>Some parameter combinations result in high peaks for variables such as V_mp, I_mp and T_c. The output power is therefore limited to the reasonable values 0 and P_mp0*1.05, with 5 &percnt; being a common tolerance for power at MPP.</p>
<h4>References</h4>
<p>A Method for the analytical extraction of the Single-Diode PV model parameters. by Batzelis, Efstratios I. ; Papathanassiou, Stavros A.</p>
<p>Improvement and validation of a model for photovoltaic array performance. by De Soto, W. ; Klein, S. A. ; Beckman, W. A.</p>
<p>Performance Data from the NIST Photovoltaic Arrays and Weather Station. by Boyd, M.</p>
<p>SANDIA REPORT SAND 2004-3535 Unlimited Release Printed December 2004 Photovoltaic Array Performance Model. (2005). by King, D. L. et al. </p>
<p>Solar engineering of thermal processes. by Duffie, John A. ; Beckman, W. A. </p>
</html>"));
end PVSystem;
