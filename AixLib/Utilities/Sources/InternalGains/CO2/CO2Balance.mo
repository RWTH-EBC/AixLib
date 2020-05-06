within AixLib.Utilities.Sources.InternalGains.CO2;
model CO2Balance
  parameter Modelica.SIunits.Area AreaZon "Zone area";
  parameter Real actDeg = 1.8 "Activity degree (Met units)";
  parameter Modelica.SIunits.Volume VZon "Zone volume";
  parameter Modelica.SIunits.MassFraction XCO2_amb=6.12157E-4
    "Massfraction of CO2 in atmosphere (equals 403ppm)";
  parameter Modelica.SIunits.Area AreaBod=1.8
    "Body surface area source SIA 2024:2015";
  parameter Modelica.SIunits.DensityOfHeatFlowRate metOnePerSit=58
    "Metabolic rate of a relaxed seated person  [1 Met = 58 W/m^2]";

  Modelica.Blocks.Interfaces.RealInput XCO2
    "Massfraction of CO2 in room [kgCO2/kgTotalAir]"
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}})));
  Modelica.Blocks.Interfaces.RealInput airExc
    "Total ventilation and infiltration rate in 1/h"
    annotation (Placement(transformation(extent={{-120,10},{-80,50}})));
  Modelica.Blocks.Interfaces.RealOutput mCO2_flow
    "Incoming and outgoing CO2 massflow [kg/s]"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealInput TAir "Air temperature of thermal zone"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,100})));
  Modelica.Blocks.Interfaces.RealInput spePeo
    "specific number of people in the thermal zone"
    annotation (Placement(transformation(extent={{-120,60},{-80,100}}),
        iconTransformation(extent={{-120,60},{-80,100}})));
  Modelica.Blocks.Interfaces.RealOutput CO2Con
    "CO2 concentration in the thermal zone in ppm"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));

protected
  constant Modelica.SIunits.MolarMass MolCO2=0.04401;
  constant Modelica.SIunits.MolarMass MolAir=0.028949;
  constant Real CalEqu=5.617*3600*1000 "caloric equivalent in J/m3";
  constant Real ResQuo=0.83 "respiratory quotient";
  constant Modelica.SIunits.Pressure pAir=101325;
  constant Modelica.SIunits.Density rhoAir=1.2041;
  Real numPeo "Number of people in the thermal zone";
  Modelica.SIunits.VolumeFlowRate VCO2OnePer_flow
    "Pure CO2 emission of an adult person";
  Modelica.SIunits.DensityOfHeatFlowRate metOnePerAct
    "Metabolic heat production rate considering activity degree [W/m^2]";
  Modelica.SIunits.MassFlowRate mCO2Peo_flow;
  Modelica.SIunits.MassFlowRate mAirExc_flow
    "Massflowrate of ventilation and infiltration [kg/s]";
  Modelica.SIunits.Density rhoCO2 "CO2 density";
  Modelica.SIunits.MassFlowRate mCO2OnePer_flow
    "Emission CO2 of one Person [kg/s]";

equation

  // ideal gas equation
  rhoCO2 = MolCO2*pAir/(Modelica.Constants.R*TAir);

  // CO2 emissions of people in the zone
  metOnePerAct = metOnePerSit*actDeg;
  VCO2OnePer_flow = ResQuo*metOnePerAct*AreaBod/CalEqu*TAir/273.15;
  mCO2OnePer_flow = VCO2OnePer_flow*rhoCO2;
  numPeo = spePeo*AreaZon;
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
          textString="CO2")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end CO2Balance;
