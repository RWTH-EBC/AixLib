within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components;
model PlateHeatExchangerFixedEfficiency

  parameter Modelica.SIunits.SpecificHeatCapacity cp_air = 1005 "specific heat capacity of dry air";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_steam = 1860 "specific heat capacity of steam";
  parameter Modelica.SIunits.Density rho_air = 1.2 "Density of air";
  parameter Real epsEnabled = 0.85 "efficiency of the heat recovery system (0...1) if it is used";
  parameter Real epsDisabled = 0.1 "efficiency of the heat recovery system (0...1) if it is bypassed";

  constant Modelica.SIunits.SpecificEnthalpy r0 = 2500E3 "specific heat of vaporization at 0°C";

  Modelica.SIunits.SpecificEnthalpy h_airInOda "specific enthalpy of incoming outdoor air";
  Modelica.SIunits.SpecificEnthalpy h_airOutOda "specific enthalpy of outgoing outdoor air";

  Modelica.SIunits.SpecificEnthalpy h_airInEta "specific enthalpy of incoming exhaust air";
  Modelica.SIunits.SpecificEnthalpy h_airOutEta "specific enthalpy of outgoing exhaust air";

  Modelica.SIunits.Temperature T_airOutOda_max "maximum temperature of outdoor air outlet if HRS is used";
  Modelica.SIunits.Temperature T_airOutOda_min "minimum temperature of outdoor air outlet if HRS is bypassed";

  Modelica.SIunits.HeatFlowRate Q_flow "heat flow";

  replaceable model PartialPressureDrop =
    Components.PressureDrop.BaseClasses.partialPressureDrop annotation(choicesAllMatching=true);

  PartialPressureDrop partialPressureDrop(m_flow = m_flow_airInOda,
    rho = rho_air);

  PartialPressureDrop partialPressureDrop2(m_flow = m_flow_airInEta,
    rho = rho_air);

  Modelica.Blocks.Interfaces.RealInput m_flow_airInEta(
    final quantity = "MassFlowRate",
    final unit = "kg/s")
    "mass flow rate of incoming exhaust air"
    annotation (Placement(transformation(extent={{140,60},{100,100}}),
        iconTransformation(extent={{120,70},{100,90}})));
  Modelica.Blocks.Interfaces.RealInput T_airInEta(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "temperature of incoming exhaust air"
    annotation (Placement(transformation(extent={{140,30},{100,70}}),
        iconTransformation(extent={{120,40},{100,60}})));
  Modelica.Blocks.Interfaces.RealInput X_airInEta(
    final quantity = "MassFraction",
    final unit = "kg/kg")
    "absolute humidity of incoming exhaust air"
    annotation (Placement(transformation(extent={{140,0},{100,40}}),
        iconTransformation(extent={{120,10},{100,30}})));
 Modelica.Blocks.Interfaces.RealInput m_flow_airInOda(
    final quantity = "MassFlowRate",
    final unit = "kg/s") "mass flow rate of incoming outdoor air"
                                             annotation (Placement(transformation(
          extent={{-140,50},{-100,90}}), iconTransformation(extent={{-120,70},{-100,
            90}})));
  Modelica.Blocks.Interfaces.RealInput T_airInOda(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "temperature of incoming otudoor air"
                                          annotation (Placement(transformation(extent={{-140,20},
            {-100,60}}),          iconTransformation(extent={{-120,40},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput X_airInOda(
    final quantity = "MassFraction",
    final unit = "kg/kg") "absolute humidity of incoming outdoor air"
                                                annotation (Placement(transformation(
          extent={{-140,-10},{-100,30}}), iconTransformation(extent={{-120,10},{
            -100,30}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_airOutEta(
    final quantity = "MassFlowRate",
    final unit = "kg/s")
    "mass flow rate of outgoing exhaust air"
    annotation (Placement(transformation(extent={{-100,-30},{-120,-10}})));
  Modelica.Blocks.Interfaces.RealOutput T_airOutEta(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "temperature of outgoing exhaust air"
    annotation (Placement(transformation(extent={{-100,-60},{-120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput X_airOutEta(
    final quantity = "MassFraction",
    final unit = "kg/kg")
    "absolute humidity of outgoing exhaust air"
    annotation (Placement(transformation(extent={{-100,-90},{-120,-70}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_airOutOda(
    final quantity = "MassFlowRate",
    final unit = "kg/s")
    "mass flow rate of outgoing outdoor air"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealOutput T_airOutOda(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "temperature of outgoing outdoor air" annotation (Placement(transformation(extent={{100,-60},
            {120,-40}}),        iconTransformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput X_airOutOda(
    final quantity = "MassFraction",
    final unit = "kg/kg")
    "absolute humidity of outgoing outdoor air" annotation (Placement(transformation(
          extent={{100,-90},{120,-70}}),
                                       iconTransformation(extent={{100,-90},{120,
            -70}})));

  Modelica.Blocks.Interfaces.RealOutput dp "pressure difference"
    annotation (Placement(transformation(extent={{100,-112},{120,-92}})));
  Modelica.Blocks.Interfaces.BooleanInput hrsOn annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));
protected
  Modelica.Blocks.Sources.RealExpression T_out_max(y=T_airOutOda_max)
    annotation (Placement(transformation(extent={{8,12},{20,28}})));
  Utilities.Logical.SmoothSwitch switch1
    annotation (Placement(transformation(extent={{42,-10},{62,10}})));
  Modelica.Blocks.Sources.RealExpression T_out_min(y=T_airOutOda_min)
    annotation (Placement(transformation(extent={{8,-28},{20,-12}})));
equation

  //mass balances
  m_flow_airInOda - m_flow_airOutOda = 0;
  m_flow_airInEta - m_flow_airOutEta = 0;

  // mass balance moisture
  X_airInOda = X_airOutOda;
  X_airInEta = X_airOutEta;

  // sepcific enthalpies
  h_airInOda = cp_air * (T_airInOda - 273.15) + X_airInOda * (cp_steam * (T_airInOda - 273.15) + r0);
  h_airOutOda = cp_air * (T_airOutOda - 273.15) + X_airOutOda * (cp_steam * (T_airOutOda - 273.15) + r0);

  h_airInEta = cp_air * (T_airInEta - 273.15) + X_airInEta * (cp_steam * (T_airInEta - 273.15) + r0);
  h_airOutEta = cp_air * (T_airOutEta - 273.15) + X_airOutEta * (cp_steam * (T_airOutEta - 273.15) + r0);

  T_airOutOda_max = epsEnabled * (T_airInEta - T_airInOda) + T_airInOda;
  T_airOutOda_min = epsDisabled * (T_airInEta - T_airInOda) + T_airInOda;

  Q_flow = (m_flow_airInEta * h_airInEta - m_flow_airOutEta * h_airOutEta);
  Q_flow = -(m_flow_airInOda * h_airInOda - m_flow_airOutOda * h_airOutOda);

  partialPressureDrop.dp + partialPressureDrop2.dp = dp;

  connect(switch1.y, T_airOutOda) annotation (Line(points={{63,0},{80,0},{80,-50},
          {110,-50}}, color={0,0,127}));
  connect(T_out_max.y, switch1.u1) annotation (Line(points={{20.6,20},{30,20},{
          30,8},{40,8}}, color={0,0,127}));
  connect(T_out_min.y, switch1.u3) annotation (Line(points={{20.6,-20},{30,-20},
          {30,-8},{40,-8}}, color={0,0,127}));
  connect(hrsOn, switch1.u2)
    annotation (Line(points={{0,120},{0,0},{40,0}}, color={255,0,255}));
      annotation (
    preferredView="info",
    Documentation(info="<html>
<p>This model describes two streams of moist air where the exit temperature is calculated over a user set parameter.</p>
<p>If the maximum possible temperature at the outlet overshoots the set temperature for the supply air, it will be reduced to the set temperature for heating case. In summer it will be vice versa.</p>
    
<h4>Main equations</h4>

The temperature of the outgoing outdoor air is defined as:

<p align=\"center\"><i>T<sub>airOutOda</sub> = &epsilon; * (T<sub>airInEta</sub> - T<sub>airInOda</sub>) + T<sub>airInOda</sub></i></p>


<h4>Implementation</h4>
<p>This model uses inputs that need to be set by models that extend or instantiate this model. The following inputs need to be assigned: 
<ul>
<li>
<i>&epsilon;</i>, parameter to calculate exit temperature.
</li>
</ul>


</html>", revisions="<html>
<ul>
<li>May 2019, by Ervin Lejlic:<br>First implementation.</li>
<li>May 2019, by Martin Kremer:<br>Changed variable names for naming convention.</li>
<li>August 2019, by Martin Kremer:<br> Added limitation for temperature at outdoor outlet. </li>
<li>April 2020, by Martin Kremer:<br>Added efficiency for bypassed HRS. Changed limitation of temperature at outdoor outlet.</li>
</ul>
</html>"),                  Icon(coordinateSystem(preserveAspectRatio=false),
        graphics={
        Rectangle(
          extent={{-100,94},{100,-94}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Line(
          points={{-100,94},{100,-94}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{98,94},{-100,-92}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{100,92},{-98,-94}},
          color={0,0,0},
          thickness=0.5),
        Rectangle(
          extent={{-14,12},{14,-14}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-58,86},{54,66}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="%name")}),                                               Diagram(
        coordinateSystem(preserveAspectRatio=false)),
                    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PlateHeatExchangerFixedEfficiency;
