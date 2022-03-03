within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.BaseClasses;
partial model PartialCooler
  "BaseClass for cooling heat exchangers in air handling units"

  // parameters
  parameter Modelica.SIunits.SpecificHeatCapacity c_wat = 4180 "specific heat capacity of water" annotation (HideResult = (use_T_set));
  parameter Modelica.SIunits.SpecificHeatCapacity cp_air = 1005 "specific heat capacity of dry air";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_steam = 1860 "specific heat capacity of steam";
  parameter Modelica.SIunits.SpecificHeatCapacity c_steel = 920 "specific heat capacity of heat exchanger material" annotation (HideResult = (use_T_set));
  parameter Modelica.SIunits.Density rho_air = 1.2 "Density of air";

  parameter Modelica.SIunits.Mass m_steel = 3 "mass of heat exchanger" annotation (HideResult = (use_T_set));

  parameter Modelica.SIunits.Length length=0.3 "length of heat exchanger in flow direction" annotation (HideResult = (use_T_set));
  parameter Modelica.SIunits.Length width=0.6 "width of heat exchanger vertical to flow direction" annotation (HideResult = (use_T_set));
  parameter Real nFins=60 "number of parallel heat exchanger plates (fins)" annotation (HideResult = (use_T_set));
  parameter Modelica.SIunits.Area area=length*width*nFins "heat exchange surface area"
                                                                                      annotation(enable=false,HideResult = (use_T_set));
  parameter Modelica.SIunits.Length delta = 0.002 "thickness of exchange plate" annotation (HideResult = (use_T_set));
  parameter Modelica.SIunits.ThermalConductivity lambda = 670 "thermal conduction of exchange plate" annotation (HideResult = (use_T_set));
  //parameter Modelica.SIunits.CoefficientOfHeatTransfer k_air = 60 "convective heat transfer coefficient";

  parameter Boolean use_T_set=false "if true, a set temperature is used to calculate the necessary heat flow rate";
  parameter Boolean use_X_set=false "if true, a set humidity is used to calculate the necessary heat flow rate";
  parameter Real eff=0.8 "cooling/dehumidification efficiency of cooler [0...1]";

  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal = 45E3 "maximum heat output of heater at design point. Only used, if use_T_set = true";

  // constants
  constant Modelica.SIunits.SpecificEnthalpy r0 = 2500E3 "specific heat of vaporization at 0°C";

  // Variables
  Modelica.SIunits.SpecificEnthalpy h_airIn "specific enthalpy of incoming air";
  Modelica.SIunits.SpecificEnthalpy h_airOut "specific enthalpy of outgoing air";

  Modelica.SIunits.CoefficientOfHeatTransfer k_air "convective heat transfer coefficient" annotation(enable=false,HideResult = (use_T_set));

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

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=
        lambda*area/delta) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-12,-54})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if not use_T_set
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
        iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=m_steel
        *c_steel) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={34,-28})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-12,-6})));
  Modelica.Blocks.Sources.RealExpression convectiveHeatTransferCoefficient(y=
        k_air*area)
    annotation (Placement(transformation(extent={{-66,-16},{-46,4}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-48,22},{-28,42}})));
  Modelica.Blocks.Sources.RealExpression T_air(y=(T_airIn + T_airOut)/2)
    annotation (Placement(transformation(extent={{8,46},{-12,66}})));
  Modelica.Blocks.Interfaces.RealInput T_set if use_T_set annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,100})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-12,20})));
  Modelica.Blocks.Interfaces.RealInput X_set if use_X_set and use_T_set annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={50,110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,100})));

  Modelica.Blocks.Interfaces.RealOutput dp "pressure difference"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealOutput Q "heat flow rate"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.SIunits.Temperature T_Sur "temperature of cooling surface";
  Modelica.SIunits.MassFraction X_Sur "absolute humidity at cooling surface";
  Modelica.SIunits.SpecificEnthalpy h_Sur "specific enthalpy at cooling surface";
  Modelica.SIunits.Pressure p_satSur "saturation pressure at cooling surface";
protected
  Modelica.SIunits.MassFlowRate mb_flow "mass flow over boundary";
  Modelica.Blocks.Interfaces.RealInput Q_in_internal "internal heat flow rate";
  Modelica.Blocks.Interfaces.RealInput T_intern "internal temperature";
  Modelica.Blocks.Interfaces.RealInput X_intern "internal mass fraction";
  parameter Real Q_in=0 "dummy heat flow rate, if use_T_set = false";
  Modelica.Blocks.Math.Min min_T if use_T_set
    annotation (Placement(transformation(extent={{-48,68},{-36,80}})));
  Modelica.Blocks.Math.Min min_X if use_X_set
    annotation (Placement(transformation(extent={{20,68},{32,80}})));
equation

  // mass balances
  m_flow_airIn - m_flow_airOut = mb_flow;

  mb_flow = m_flow_airIn / (1+X_airIn) * (X_airIn - X_airOut); // condensate

  // heat flows
  Q_flow = (m_flow_airIn * h_airIn - m_flow_airOut * h_airOut);
  Q = Q_flow;

  if not use_T_set then
    Q_in_internal = Q_in;
    Q_flow = -heatFlowSensor.Q_flow;
  else
    Q_flow = Q_in_internal;
  end if;

  // sepcific enthalpies
  h_airIn = cp_air * (T_airIn - 273.15) + X_airIn * (cp_steam * (T_airIn - 273.15) + r0);
  h_airOut = cp_air * (T_airOut - 273.15) + X_airOut * (cp_steam * (T_airOut - 273.15) + r0);
  h_Sur = cp_air * (T_Sur - 273.15) + X_Sur * (cp_steam * (T_Sur - 273.15) + r0);

  if not use_X_set then
    T_airOut = T_intern;
  else
    (T_airIn - T_Sur)/max(X_airIn - X_Sur,0.00009) = (T_airIn - T_airOut)/max(X_airIn - X_airOut,0.00001);
    eff = (h_airIn - h_airOut)/max(h_airIn - h_Sur,0.0001);
    p_satSur = AixLib.Utilities.Psychrometrics.Functions.saturationPressure(T_Sur);
    X_Sur = AixLib.Utilities.Psychrometrics.Functions.X_pW(p_satSur);
  end if;

  X_airOut = X_intern;

  partialPressureDrop.dp = dp;

  // conditional connectors
  connect(min_T.y,T_intern);
  connect(min_X.y,X_intern);

  // connectors
  connect(heatPort, thermalConductor.port_b)
    annotation (Line(points={{0,-100},{0,-82},{-12,-82},{-12,-64}},
                                                    color={191,0,0}));
  connect(thermalConductor.port_a, heatCapacitor.port)
    annotation (Line(points={{-12,-44},{-12,-28},{24,-28}}, color={191,0,0}));
  connect(heatCapacitor.port, convection.solid)
    annotation (Line(points={{24,-28},{-12,-28},{-12,-16}}, color={191,0,0}));
  connect(convectiveHeatTransferCoefficient.y, convection.Gc)
    annotation (Line(points={{-45,-6},{-22,-6}}, color={0,0,127}));
  connect(T_air.y, prescribedTemperature.T) annotation (Line(points={{-13,56},{-60,
          56},{-60,32},{-50,32}}, color={0,0,127}));
  connect(prescribedTemperature.port, heatFlowSensor.port_b)
    annotation (Line(points={{-28,32},{-12,32},{-12,30}}, color={191,0,0}));
  connect(heatFlowSensor.port_a, convection.fluid)
    annotation (Line(points={{-12,10},{-12,4}}, color={191,0,0}));
  connect(T_set, min_T.u1) annotation (Line(points={{0,110},{0,86},{-56,86},{-56,
          77.6},{-49.2,77.6}}, color={0,0,127}));
  connect(X_set, min_X.u1) annotation (Line(points={{50,110},{50,86},{14,86},{14,
          77.6},{18.8,77.6}}, color={0,0,127}));
  connect(T_airIn, min_T.u2) annotation (Line(points={{-120,40},{-80,40},{-80,70.4},
          {-49.2,70.4}}, color={0,0,127}));
  connect(X_airIn, min_X.u2) annotation (Line(points={{-120,10},{-80,10},{-80,60},
          {-20,60},{-20,70.4},{18.8,70.4}}, color={0,0,127}));
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
