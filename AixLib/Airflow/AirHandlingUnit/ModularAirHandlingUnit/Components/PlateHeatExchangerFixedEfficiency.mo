within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components;
model PlateHeatExchangerFixedEfficiency

  parameter Modelica.SIunits.SpecificHeatCapacity cp_air = 1005 "specific heat capacity of dry air";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_steam = 1860 "specific heat capacity of steam";
  parameter Modelica.SIunits.Density rho_air = 1.2 "Density of air";

  constant Modelica.SIunits.SpecificEnthalpy r0 = 2500E3 "specific heat of vaporization at 0°C";

  Modelica.SIunits.SpecificEnthalpy h_airInOda "specific enthalpy of incoming outdoor air";
  Modelica.SIunits.SpecificEnthalpy h_airOutOda "specific enthalpy of outgoing outdoor air";

  Modelica.SIunits.SpecificEnthalpy h_airInEta "specific enthalpy of incoming exhaust air";
  Modelica.SIunits.SpecificEnthalpy h_airOutEta "specific enthalpy of outgoing exhaust air";

  Modelica.SIunits.Temperature T_airOutOda_max "maximum temperature ot oudoor air outlet";

  Modelica.SIunits.HeatFlowRate Q_flow "heat flow";

   parameter Real epsilon = 0.85 "efficiency of the heat recovery system (0...1)";

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
    final unit = "kg/s")
    "mass flow rate of incoming outdoor air" annotation (Placement(transformation(
          extent={{-140,50},{-100,90}}), iconTransformation(extent={{-120,70},{-100,
            90}})));
  Modelica.Blocks.Interfaces.RealInput T_airInOda(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "temperature of incoming otudoor air" annotation (Placement(transformation(extent={{-140,20},
            {-100,60}}),          iconTransformation(extent={{-120,40},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput X_airInOda(
    final quantity = "MassFraction",
    final unit = "kg/kg")
    "absolute humidity of incoming outdoor air" annotation (Placement(transformation(
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

  Modelica.Blocks.Interfaces.RealInput T_set(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "Set temperature of supply air. Is used to limit heat recovery."
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={0,110})));
  Modelica.Blocks.Interfaces.RealOutput dp "pressure difference"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  Modelica.Blocks.Math.Min min
    annotation (Placement(transformation(extent={{-4,2},{16,22}})));
  Modelica.Blocks.Sources.RealExpression maxTairOut(y=T_airOutOda_max)
    annotation (Placement(transformation(extent={{-56,-8},{-36,12}})));
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=2,
      pre_y_start=true)
    annotation (Placement(transformation(extent={{-8,-42},{12,-22}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{40,-42},{60,-22}})));
  Modelica.Blocks.Math.Max max
    annotation (Placement(transformation(extent={{-6,-76},{14,-56}})));
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

      T_airOutOda_max = epsilon * (T_airInEta - T_airInOda) + T_airInOda;

      Q_flow = (m_flow_airInEta * h_airInEta - m_flow_airOutEta * h_airOutEta);
      Q_flow = -(m_flow_airInOda * h_airInOda - m_flow_airOutOda * h_airOutOda);

      partialPressureDrop.dp + partialPressureDrop2.dp = dp;

  connect(T_set, min.u1) annotation (Line(points={{0,110},{0,40},{-26,40},{-26,18},
          {-6,18}}, color={0,0,127}));
  connect(maxTairOut.y, min.u2) annotation (Line(points={{-35,2},{-20,2},{-20,6},
          {-6,6}}, color={0,0,127}));
  connect(T_set, onOffController.reference) annotation (Line(points={{0,110},{0,
          40},{-58,40},{-58,-26},{-10,-26}}, color={0,0,127}));
  connect(onOffController.y, switch1.u2)
    annotation (Line(points={{13,-32},{38,-32}}, color={255,0,255}));
  connect(min.y, switch1.u1) annotation (Line(points={{17,12},{30,12},{30,-24},{
          38,-24}}, color={0,0,127}));
  connect(T_set, max.u2) annotation (Line(points={{0,110},{0,40},{-58,40},{-58,-72},
          {-8,-72}}, color={0,0,127}));
  connect(max.y, switch1.u3) annotation (Line(points={{15,-66},{26,-66},{26,-40},
          {38,-40}}, color={0,0,127}));
  connect(switch1.y, T_airOutOda) annotation (Line(points={{61,-32},{74,-32},{74,
          -50},{110,-50}}, color={0,0,127}));
  connect(T_airInOda, onOffController.u) annotation (Line(points={{-120,40},{-58,
          40},{-58,-38},{-10,-38}}, color={0,0,127}));
  connect(maxTairOut.y, max.u1) annotation (Line(points={{-35,2},{-20,2},{-20,-10},
          {-58,-10},{-58,-60},{-8,-60}}, color={0,0,127}));
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
