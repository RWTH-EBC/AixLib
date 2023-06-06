within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.BaseClasses;
partial model PartialHeater
  "BaseClass for heat exchangers in air handling units"

  // parameters
  parameter Modelica.Units.SI.SpecificHeatCapacity c_wat = 4180 "specific heat capacity of water" annotation (HideResult = (use_T_set));
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_air = 1005 "specific heat capacity of dry air";
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_steam = 1860 "specific heat capacity of steam";
  parameter Modelica.Units.SI.Density rho_air = 1.2 "Density of air";

  parameter Boolean use_T_set=false "if true, a set temperature is used to calculate the necessary heat flow rate";

  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal = 45E3 "maximum heat output of heater at design point. Only used, if use_T_set = true" annotation (HideResult = (not use_T_set));

  // constants
  constant Modelica.Units.SI.SpecificEnthalpy r0 = 2500E3 "specific heat of vaporization at 0°C";

  // Variables
  Modelica.Units.SI.SpecificEnthalpy h_airIn "specific enthalpy of incoming air";
  Modelica.Units.SI.SpecificEnthalpy h_airOut "specific enthalpy of outgoing air";

  Modelica.Units.SI.MassFlowRate m_flow_dryairIn "mass flow rate of incoming dry air";
  Modelica.Units.SI.MassFlowRate m_flow_dryairOut "mass flow rate of outgoing dry air";

  Modelica.Units.SI.CoefficientOfHeatTransfer k_air "convective heat transfer coefficient"
                                                                                          annotation(enable=false,HideResult = (use_T_set));

  Modelica.Units.SI.HeatFlowRate Q_flow "heat flow";

  Modelica.Blocks.Interfaces.RealInput m_flow_airIn(
    final quantity = "MassFlowRate",
    final unit = "kg/s")
    "mass flow rate of incoming air"
    annotation (Placement(transformation(extent={{-140,50},{-100,90}}),
        iconTransformation(extent={{-120,70},{-100,90}})));
  Modelica.Blocks.Interfaces.RealInput T_airIn(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "Temperature of incoming air"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}}),
        iconTransformation(extent={{-120,40},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput X_airIn(
    final quantity = "MassFraction",
    final unit = "kg/kg")
    "absolute humidity of incoming air"
    annotation (Placement(transformation(extent={{-140,-10},{-100,30}}),
        iconTransformation(extent={{-120,10},{-100,30}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_airOut(
    final quantity = "MassFlowRate",
    final unit = "kg/s") "mass flow rate of outgoing air"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput T_airOut(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "temperature of outgoing air"
    annotation (Placement(transformation(extent={{100,40},{120,60}}),
        iconTransformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput X_airOut(
    final quantity = "MassFraction",
    final unit = "kg/kg") "absolute humidity of outgoing air"
    annotation (Placement(transformation(extent={{100,10},{120,30}}),
        iconTransformation(extent={{100,10},{120,30}})));

  Modelica.Blocks.Interfaces.RealInput T_set if use_T_set annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,100})));

  Modelica.Blocks.Interfaces.RealOutput dp "pressure difference"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  replaceable model PartialPressureDrop =
      Components.PressureDrop.BaseClasses.partialPressureDrop annotation(choicesAllMatching=true);

      PartialPressureDrop partialPressureDrop(m_flow = m_flow_airIn,
      rho = rho_air);

  Modelica.Blocks.Interfaces.RealOutput Q "heat flow rate"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealInput u(min=0, max=1)
    if not use_T_set "input connector scaling heat flow rate [0..1]" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={48,110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,100})));
protected
  parameter Real Q_in=0 "dummy heat flow rate, if use_T_set = false";
  Modelica.Blocks.Interfaces.RealInput Q_in_internal "internal heat flow rate";
  Modelica.Blocks.Interfaces.RealInput T_intern "internal temperature";
  Modelica.Blocks.Math.Max max
    annotation (Placement(transformation(extent={{-18,74},{-8,84}})));
equation

  // mass balances
  m_flow_airIn - m_flow_airOut = 0;
  m_flow_dryairIn - m_flow_dryairOut = 0;
  m_flow_dryairIn * (1 + X_airIn) = m_flow_airIn;

  // heat flows
  Q_flow = -(m_flow_dryairIn * h_airIn - m_flow_dryairOut * h_airOut);
  Q = Q_flow;

  if not use_T_set then
    Q_in_internal = Q_in;
    Q_flow = u * Q_flow_nominal;
  else
    Q_flow = Q_in_internal;
  end if;

  // sepcific enthalpies
  h_airIn = cp_air * (T_airIn - 273.15) + X_airIn * (cp_steam * (T_airIn - 273.15) + r0);
  h_airOut = cp_air * (T_intern - 273.15) + X_airOut * (cp_steam * (T_intern - 273.15) + r0);

  T_airOut = T_intern;

  partialPressureDrop.dp = dp;

  // Conditional connectors
  connect(max.y,T_intern);

  // Connectors
  connect(T_set, max.u1) annotation (Line(points={{0,110},{0,88},{-22,88},{-22,82},
          {-19,82}}, color={0,0,127}));
  connect(T_airIn, max.u2) annotation (Line(points={{-120,40},{-80,40},{-80,76},
          {-19,76}}, color={0,0,127}));
  annotation (Icon(graphics={
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
        Text(
          extent={{-14,66},{62,48}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="%name")}), Documentation(info="<html><p>
  This partial model provides a idealized heat exchanger. The model
  considers the convective heat transfer from the heat transfer surface
  in the air stream. Moreover the heat capacity of the heating surface
  and the housing of the heat exchanger is considered.
</p>
</html>", revisions="<html>
<ul>
  <li>April, 2019, by Martin Kremer:<br/>
    First implementation.
  </li>
  <li>August, 2019, by Martin Kremer:<br/>
    Added possibility to use set temperature.
  </li>
  <li>December, 2019, by Martin Kremer:<br/>
    Removed internal PID. Output temperature is now directly set to set
    temperature.
  </li>
</ul>
</html>"));
end PartialHeater;
