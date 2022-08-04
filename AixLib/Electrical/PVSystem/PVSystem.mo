within AixLib.Electrical.PVSystem;
model PVSystem
  "Model that determines the DC performance of a Silicium-based PV array"

 replaceable parameter AixLib.DataBase.SolarElectric.PVBaseDataDefinition data
 constrainedby AixLib.DataBase.SolarElectric.PVBaseDataDefinition
 "PV Panel data definition"
                           annotation (choicesAllMatching);

 replaceable model IVCharacteristics =
    AixLib.Electrical.PVSystem.BaseClasses.PartialIVCharacteristics
    "Model for determining the I-V characteristics of a PV array" annotation (choicesAllMatching=
    true);

 replaceable model CellTemperature =
    AixLib.Electrical.PVSystem.BaseClasses.PartialCellTemperature
    "Model for determining the cell temperature of a PV array" annotation (choicesAllMatching=
    true, Dialog(tab="Mounting"));

 parameter Real n_mod
    "Number of connected PV modules";
  parameter Modelica.Units.SI.Angle til "Surface's tilt angle (0:flat)"
    annotation (Dialog(tab="Mounting"));
  parameter Modelica.Units.SI.Angle azi "Surface's azimut angle (0:South)"
    annotation (Dialog(tab="Mounting"));
  parameter Modelica.Units.SI.Angle lat "Location's Latitude"
    annotation (Dialog(tab="Location"));
  parameter Modelica.Units.SI.Angle lon "Location's Longitude"
    annotation (Dialog(tab="Location"));
 parameter Real alt(final quantity="Length", final unit="m")
   "Site altitude in Meters, default= 1"
   annotation (Dialog(tab="Location"));
  parameter Modelica.Units.SI.Time timZon(displayUnit="h")
    "Time zone. Should be equal with timZon in ReaderTMY3, if PVSystem and ReaderTMY3 are used together."
    annotation (Dialog(tab="Location"));
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
  annotation (Dialog(tab="Location"));

  parameter Boolean use_ParametersGlaz=false
    "= false if standard values for glazing can be used" annotation(choices(checkBox=true),Dialog(tab="Glazing"));

  parameter Real glaExtCoe(final unit="1/m") = 4
  "Glazing extinction coefficient (for glass = 4)" annotation(Dialog(enable=
          use_ParametersGlaz, tab="Glazing"));

  parameter Real glaThi(final unit="m") = 0.002
  "Glazing thickness (for most cells = 0.002 m)" annotation(Dialog(enable=
          use_ParametersGlaz, tab="Glazing"));

  parameter Real refInd(final unit="1", min=0) = 1.526
  "Effective index of refraction of the cell cover (glass = 1.526)" annotation(Dialog(enable=
          use_ParametersGlaz, tab="Glazing"));

  IVCharacteristics iVCharacteristics(final n_mod=n_mod,
  final data=data)
    "Model for determining the I-V characteristics of a PV array" annotation (
      Placement(transformation(extent={{10,-42},{30,-22}}, rotation=0)));

  CellTemperature cellTemperature(final data=data)
    "Model for determining the cell temperature of a PV array" annotation (
      Placement(transformation(extent={{-40,56},{-20,76}}, rotation=0)));

 Modelica.Blocks.Interfaces.RealOutput DCOutputPower(
  final quantity="Power",
  final unit="W")
  "DC output power of the PV array" annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  BaseClasses.PVRadiationHorizontal    pVRadiationHorizontalTRY(
   final lat = lat,
   final lon = lon,
   final alt = alt,
   final til = til,
   final azi = azi,
   final groRef = groRef,
   final timZon = timZon,
   final glaExtCoe=glaExtCoe,
   final glaThi=glaThi,
   final refInd=refInd)
   "Radiation and absorptance model for PV simulations"
    annotation (Placement(transformation(extent={{-84,-30},{-64,-10}})));

  BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-122,-20},{-82,20}}), iconTransformation(extent={{-128,-4},
            {-108,16}})));
equation

  connect(pVRadiationHorizontalTRY.radTil, iVCharacteristics.radTil)
    annotation (Line(points={{-63,-26},{-24,-26},{-24,-40},{8,-40}},
                                                                 color={0,0,127}));
  connect(pVRadiationHorizontalTRY.absRadRat, iVCharacteristics.absRadRat)
    annotation (Line(points={{-63,-14},{-22,-14},{-22,-36},{8,-36}},
                                                                   color={0,0,127}));
  connect(pVRadiationHorizontalTRY.radTil, cellTemperature.radTil)
    annotation (Line(points={{-63,-26},{-50,-26},{-50,58},{-46,58},{-46,57.8},{
          -42,57.8}},                                                color={0,0,127}));
  connect(iVCharacteristics.eta, cellTemperature.eta)
    annotation (Line(points={{31,-38},{76,-38},{76,-60},{-50,-60},{-50,61.8},{
          -42,61.8}},                                                                     color={0,0,127}));
  connect(cellTemperature.T_c, iVCharacteristics.T_c)
    annotation (Line(points={{-18,66},{-6,66},{-6,-28},{8,-28}}, color={0,0,127}));
  connect(iVCharacteristics.DCOutputPower, DCOutputPower)
    annotation (Line(points={{31,-26},{66,-26},{66,0},{110,0}}, color={0,0,127}));
  connect(weaBus.winSpe, cellTemperature.winVel) annotation (Line(
      points={{-102,0},{-72,0},{-72,71.9},{-42,71.9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.TDryBul, cellTemperature.T_a) annotation (Line(
      points={{-102,0},{-72,0},{-72,75.4},{-42,75.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.HGloHor, pVRadiationHorizontalTRY.radHor) annotation (Line(
      points={{-102,0},{-96,0},{-96,-14},{-86,-14}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
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
                               Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Model that determines the DC performance of a PV array.
</p>
<h4>
  Concept
</h4>
<p>
  Model consists of a model determining the IV Characteristic, a model
  to calculate the cell temperature and a model to calculate the
  irradiance and absorption ratio for the PV module.
</p>
<h4>
  1. IV Characteristic:
</h4>
<p>
  Model for determining the I-V characteristics of a PV array based on
  Batzelis et al., De Soto et al. and Boyd.
</p>
<h4>
  2. Cell Temperature calculation:
</h4>
<p>
  Two cell temperature models are implemented and should be chosen
  depending on the module's topology:
</p>
<p>
  CellTemperatureOpenRack:
</p>
<p>
  Module is installed on open rack based on Duffie et al.. Here, the
  resulting cell temperature is usually lower compared to the cell
  temperature model <i>CellTemperatureMountingCloseToGround</i>
  resulting in higher efficiencies.
</p>
<p>
  CellTemperatureMountingCloseToGround:
</p>
<p>
  Module is installed close to ground (e.g. on roof) based on King et
  al.
</p>
<p>
  CellTemperatureMountingContactToGround:
</p>
<p>
  Module is installed in contact to ground (e.g. integrated in roof)
  based on King et al.
</p>
<p>
  If line losses are not known, the model
  CellTemperatureMountingCloseToGround can be used for a more
  conservative estimation of PV DC power output. This is due to the
  fact that line losses are not included in the calculation process.
</p>
<h4>
  Known limitations
</h4>
<ul>
  <li>Model does not include line losses and decreasing panel
  efficiency due to shading! This leads to the fact that model usually
  overestimates real DC power.
  </li>
  <li>Some parameter combinations result in high peaks for variables
  such as V_mp, I_mp and T_c. The output power is therefore limited to
  the reasonable values 0 and P_mp0*1.05, with 5 &amp;percnt; being a
  common tolerance for power at MPP.
  </li>
</ul>
<h4>
  References
</h4>
<p>
  A Method for the analytical extraction of the Single-Diode PV model
  parameters. by Batzelis, Efstratios I. ; Papathanassiou, Stavros A.
</p>
<p>
  Improvement and validation of a model for photovoltaic array
  performance. by De Soto, W. ; Klein, S. A. ; Beckman, W. A.
</p>
<p>
  Performance Data from the NIST Photovoltaic Arrays and Weather
  Station. by Boyd, M.
</p>
<p>
  SANDIA REPORT SAND 2004-3535 Unlimited Release Printed December 2004
  Photovoltaic Array Performance Model. (2005). by King, D. L. et al.
</p>
<p>
  Solar engineering of thermal processes. by Duffie, John A. ; Beckman,
  W. A.
</p>
</html>",
revisions="<html><ul>
  <li>
    <i>May 6, 2021&#160;</i> by Laura Maier:<br/>
    Finalization of the model
  </li>
  <li>
    <i>April, 2020&#160;</i> by Arnold Fütterer:<br/>
    General changes to align the model with AixLib standards (see
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/767\">issue
    767</a>).
  </li>
  <li>
    <i>August, 2019&#160;</i> by Michael Kratz:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/767\">issue 767</a>).
  </li>
</ul>
</html>"));
end PVSystem;
