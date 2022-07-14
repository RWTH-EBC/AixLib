within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.BaseClasses;
partial model PartialCooler
  "BaseClass for cooling heat exchangers in air handling units"

  // parameters
  parameter Modelica.SIunits.SpecificHeatCapacity c_wat = 4180 "specific heat capacity of water" annotation (HideResult = (use_T_set));
  parameter Modelica.SIunits.SpecificHeatCapacity cp_air = 1005 "specific heat capacity of dry air";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_steam = 1860 "specific heat capacity of steam";
  parameter Modelica.SIunits.Density rho_air = 1.2 "Density of air";

  parameter Boolean use_T_set=false "if true, a set temperature is used to calculate the necessary heat flow rate";

  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal(min=0) = 45E3 "maximum cooling power of cooler (design point)";

  // constants
  constant Modelica.SIunits.SpecificEnthalpy r0 = 2500E3 "specific heat of vaporization at 0°C";

  // Variables
  Modelica.SIunits.SpecificEnthalpy h_airIn "specific enthalpy of incoming air";
  Modelica.SIunits.SpecificEnthalpy h_airOut "specific enthalpy of outgoing air";

  Modelica.SIunits.HeatFlowRate Q_flow "heat flow";

  replaceable model PartialPressureDrop =
      Components.PressureDrop.BaseClasses.partialPressureDrop annotation(choicesAllMatching=true);

      PartialPressureDrop partialPressureDrop(m_flow = m_flow_airIn,
      rho = rho_air);

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
  Modelica.Blocks.Interfaces.RealOutput Q "heat flow rate"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealInput u(min=0,max=1) if not use_T_set "input connector scaling heat flow rate [0..1]" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={40,110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,100})));
protected
  Modelica.SIunits.MassFlowRate mb_flow "mass flow over boundary";
  Modelica.Blocks.Interfaces.RealInput T_intern "internal temperature";
  Modelica.Blocks.Interfaces.RealInput X_intern "internal mass fraction";
  Modelica.Blocks.Interfaces.RealInput u_intern "internal input connector for heat flow scaling";
  Modelica.Blocks.Math.Min min_T if use_T_set
    annotation (Placement(transformation(extent={{-48,68},{-36,80}})));
equation

  // mass balances
  m_flow_airIn - m_flow_airOut = mb_flow;

  mb_flow = m_flow_airIn * (1-X_airIn) * (X_airIn - X_airOut); // condensate

  // heat flows
  Q_flow = (m_flow_airIn * h_airIn - m_flow_airOut * h_airOut);
  Q = Q_flow;
  if not use_T_set then
    Q_flow = u_intern * Q_flow_nominal;
    T_intern = T_airIn;
  else
    T_airOut = T_intern;
    u_intern = 0;
  end if;

  // sepcific enthalpies
  h_airIn = cp_air * (T_airIn - 273.15) + X_airIn * (cp_steam * (T_airIn - 273.15) + r0);
  h_airOut = cp_air * (T_airOut - 273.15) + X_airOut * (cp_steam * (T_airOut - 273.15) + r0);

  partialPressureDrop.dp = dp;

  // conditional connectors
  connect(min_T.y,T_intern);
  connect(u, u_intern);

  // connectors
  connect(T_set, min_T.u1) annotation (Line(points={{0,110},{0,86},{-56,86},{-56,
          77.6},{-49.2,77.6}}, color={0,0,127}));
  connect(T_airIn, min_T.u2) annotation (Line(points={{-120,40},{-80,40},{-80,70.4},
          {-49.2,70.4}}, color={0,0,127}));
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
    Removed internal PID. Output temperature and humidity are now
    directly set to set temperature.
  </li>
</ul>
</html>"));
end PartialCooler;
