within AixLib.BoundaryConditions.InternalGains.CO2;
model CO2Balance "Calculation of CO2 concentration within a thermal zone"
  parameter Modelica.Units.SI.Area areaZon "Zone area";
  parameter Real actDeg = 1.8 "Activity degree (Met units)";
  parameter Modelica.Units.SI.Volume VZon "Zone volume";
  parameter Modelica.Units.SI.MassFraction XCO2_amb=6.12157E-4
    "Massfraction of CO2 in atmosphere (equals 403ppm)";
  parameter Modelica.Units.SI.Area areaBod=1.8
    "Body surface area source SIA 2024:2015";
  parameter Modelica.Units.SI.DensityOfHeatFlowRate metOnePerSit=58
    "Metabolic rate of a relaxed seated person in Met (1 Met = 58 W/m^2)";
  parameter Real spePeo(unit="1/(m.m)") = 0.05
    "Specific persons per square metre room area";


  Modelica.Blocks.Interfaces.RealInput XCO2(final quantity="MassFraction",
      final unit="kg/kg") "Massfraction of CO2 in room in kgCO2/kgTotalAir"
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}})));
  Modelica.Blocks.Interfaces.RealInput airExc(final quantity="VolumeFlowRate",
      final unit="1/h") "Total ventilation and infiltration rate in 1/h"
    annotation (Placement(transformation(extent={{-120,10},{-80,50}})));
  Modelica.Blocks.Interfaces.RealOutput mCO2_flow(final quantity="MassFlowRate",
      final unit="kg/s") "Incoming and outgoing CO2 massflow in kg/s"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealInput TAir(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "Air temperature of thermal zone" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,100})));
  Modelica.Blocks.Interfaces.RealInput uRel
    "relative number of people related to max. value" annotation (Placement(
        transformation(extent={{-120,60},{-80,100}}), iconTransformation(extent=
           {{-120,60},{-80,100}})));
  Modelica.Blocks.Interfaces.RealOutput CO2Con(min=0, max=1000000)
    "CO2 concentration in the thermal zone in ppm"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));

protected
  constant Modelica.Units.SI.MolarMass MolCO2=0.04401;
  constant Modelica.Units.SI.MolarMass MolAir=0.028949;
  constant Real CalEqu=5.617*3600*1000
    "caloric equivalent in J/m^3";
  constant Real ResQuo=0.83 "respiratory quotient in m^3_CO2/ m^3_O2";
  constant Modelica.Units.SI.Pressure pAir=101325;
  constant Modelica.Units.SI.Density rhoAir=1.2041;
  Real numPeo "Number of people in the thermal zone";
  Modelica.Units.SI.VolumeFlowRate VCO2OnePer_flow
    "Pure CO2 emission of an adult person";
  Modelica.Units.SI.DensityOfHeatFlowRate metOnePerAct
    "Metabolic heat production rate considering activity degree in W/m^2";
  Modelica.Units.SI.MassFlowRate mCO2Peo_flow;
  Modelica.Units.SI.MassFlowRate mAirExc_flow
    "Massflowrate of ventilation and infiltration in kg/s";
  Modelica.Units.SI.Density rhoCO2 "CO2 density";
  Modelica.Units.SI.MassFlowRate mCO2OnePer_flow
    "Emission CO2 of one Person in kg/s";

equation

  // ideal gas equation
  rhoCO2 = MolCO2*pAir/(Modelica.Constants.R*TAir);

  // CO2 emissions of people in the zone
  metOnePerAct = metOnePerSit*actDeg;
  VCO2OnePer_flow = ResQuo*metOnePerAct*areaBod/CalEqu*TAir/273.15;
  mCO2OnePer_flow = VCO2OnePer_flow*rhoCO2;
  numPeo = spePeo*areaZon*uRel;
  mCO2Peo_flow = mCO2OnePer_flow*numPeo;

  // CO2 balance
  mAirExc_flow = airExc/3600*rhoAir*VZon;
  mCO2_flow = mAirExc_flow*(XCO2_amb - XCO2) + mCO2Peo_flow;

  // calculation of concentration in the thermal zone in ppm
  CO2Con = XCO2*(MolAir/MolCO2)*1E6;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-88,90},{92,-90}},
          lineColor={215,215,215},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,170}),
        Rectangle(
          extent={{-76,2},{-60,-50}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-54,4},{2,-76}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{12,2},{28,-50}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-54,64},{0,10}},
          lineColor={95,95,95},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{12,78},{80,30}},
          lineColor={0,128,255},
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255}),
        Text(
          extent={{18,74},{72,32}},
          lineColor={0,128,255},
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255},
          textString="CO2")}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This model assumes co2 as an ideal gas to calculate the density of
  co2:
</p>
<p>
  rho_CO2 = p_Air * w_CO2 * M_Air / (R * T_Air)
</p>
<p>
  The delivered volume flow rate results to:
</p>
<p>
  V̇_CO2 = RQ * M * A_Body / CE * T_Air/ 273.15 K
</p>
<p>
  The zone is assumed to be occupied by men to determine the amount of
  CO2 emitted. For a different occupancy the default values must be
  replaced.
</p>
<h4>
  Examples
</h4>
<p>
  See <a href=
  \"AixLib.ThermalZones.ReducedOrder.Examples.ThermalZoneMoistCO2AirExchange\">
  AixLib.ThermalZones.ReducedOrder.Examples.ThermalZoneMoistCO2AirExchange</a>.
</p>
</html>", revisions="<html>
<ul>
  <li>August 27, 2020, by Katharina Breuer:<br/>
    First implementation
  </li>
</ul>
</html>"));
end CO2Balance;
