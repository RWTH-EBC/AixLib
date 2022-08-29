within AixLib.Systems.HydraulicModules;
model SimpleConsumer_old "Simple Consumer"
  extends AixLib.Fluid.Interfaces.PartialTwoPort;
  import    Modelica.Units.SI;

  parameter Real kA(unit="W/K")=1 "Heat transfer coefficient times area [W/K]" annotation (Dialog(enable = functionality=="T_fixed" or functionality=="T_input"));
  parameter SI.Temperature T_fixed=293.15  "Ambient temperature for convection" annotation (Dialog(enable = functionality=="T_fixed"));
  parameter SI.HeatCapacity capacity=1 "Capacity of the material";
  parameter SI.Volume V=0.001 "Volume of water";
  parameter SI.HeatFlowRate Q_flow_fixed = 0 "Prescribed heat flow" annotation (Dialog(enable = functionality=="Q_flow_fixed"));
  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);
  parameter Boolean energy_calculation=true  "= true, if remaining/missing energy as output";
  parameter Boolean fixed_return_T=true  "= true, if fixed return temperature, false if variable";

  parameter SI.MassFlowRate m_flow_nominal(min=0) "Nominal mass flow rate";
  parameter SI.Temperature T_start
    "Initialization temperature" annotation(Dialog(tab="Advanced"));
  parameter String functionality "Choose between different functionalities" annotation (choices(
              choice="T_fixed",
              choice="T_input",
              choice="Q_flow_fixed",
              choice="Q_flow_input"),Dialog(enable=true));
  parameter Integer demandType   "Choose between heating and cooling functionality" annotation (choices(
              choice=1 "use as heating consumer",
              choice=-1 "use as cooling consumer"),Dialog(enable=true));
  parameter SI.PressureDifference dp_nominalPumpConsumer=if pump.rho_default < 500
       then 500 else 10000
    "Nominal pressure raise, used for default pressure curve if not specified in record per";
  parameter Real k_ControlConsumerPump "Gain of controller";
  parameter SI.Time Ti_ControlConsumerPump
    "Time constant of Integrator block";
  parameter Modelica.Units.SI.TemperatureDifference dT_maxNominalReturn = 5 "maximum undercooling/overheating based on nominal return temperature";
  parameter Boolean show_T=false
    "= true, if actual temperature at port is computed";

  SI.Temperature TReturn = if fixed_return_T then T_return else T_returnSet;
  Modelica.Units.SI.HeatFlowRate Q_flow_max;
  Fluid.MixingVolumes.MixingVolume volume(
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    final V=V,
    final T_start=T_start,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    nPorts=2)                          annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,10})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection
 if functionality == "T_input" or functionality == "T_fixed"
    annotation (Placement(transformation(
        origin={10,70},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature if functionality == "T_input" or functionality == "T_fixed"
                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,80})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=kA) if functionality == "T_input"
     or functionality == "T_fixed"                            annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,78})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=T_fixed)
 if functionality == "T_fixed"                                annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,80})));
  Modelica.Blocks.Interfaces.RealInput T if functionality == "T_input"
                                         annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={80,100})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
 if functionality == "Q_flow_input" or functionality == "Q_flow_fixed"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-12,40})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=Q_flow_fixed)
 if functionality == "Q_flow_fixed"                           annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,80})));
  Modelica.Blocks.Interfaces.RealInput Q_flow if functionality == "Q_flow_input"
    "Consumed heat flow, positive for heating or cooling"
                                              annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,120}), iconTransformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,100})));
  Fluid.Movers.SpeedControlled_y     pump(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    T_start=T_start,
    allowFlowReversal=allowFlowReversal,
    show_T=show_T,
    redeclare Fluid.Movers.Data.Generic per(pressure(V_flow={0,m_flow_nominal/
            1000,m_flow_nominal/500}, dp={dp_nominalPumpConsumer/0.8,
            dp_nominalPumpConsumer,0}), motorCooledByFluid=false),
    addPowerToMedium=false,
    y_start=0.5)
    annotation (Placement(transformation(extent={{-40,10},{-20,-10}})));

  Modelica.Blocks.Continuous.LimPID PIPump(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k_ControlConsumerPump,
    Ti=Ti_ControlConsumerPump,
    yMax=1,
    yMin=0.05,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.5)
               annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-50,-40})));
  Fluid.Sensors.TemperatureTwoPort senTemReturn(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start)
                    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={48,0})));
  Fluid.Sensors.TemperatureTwoPort senTemFlow(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start)
                    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,0})));

  Modelica.Blocks.Interfaces.RealInput T_returnSet if not fixed_return_T annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
  Modelica.Blocks.Math.Gain gain2(k=demandType)
    "Used to reverse direction of operation of controller"
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
  Modelica.Blocks.Math.Gain gain(k=demandType)
    "Used to reverse direction of operation of controller"
    annotation (Placement(transformation(extent={{20,-70},{0,-50}})));
  Modelica.Blocks.Math.Gain gain1(k=-demandType) if functionality == "Q_flow_input"
     or functionality == "Q_flow_fixed"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-38,40})));

  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter
    annotation (Placement(transformation(extent={{-88,32},{-72,48}})));
  Modelica.Blocks.Sources.RealExpression ExpressionQ_flow_min(y=0)
    annotation (Placement(transformation(extent={{-124,20},{-104,40}})));
  Modelica.Blocks.Sources.RealExpression ExpressionQ_flow_max(y=Q_flow_max)
    annotation (Placement(transformation(extent={{-124,36},{-104,56}})));
  Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-66,-10},{-46,10}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flowReal
    if functionality == "Q_flow_input" and not energy_calculation
    "Consumed real heat flow, positive for heating or cooling" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={118,46}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,52})));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state";
  parameter Modelica.Fluid.Types.Dynamics massDynamics=volume.energyDynamics
    "Type of mass balance: dynamic (3 initialization options) or steady state";
  Modelica.Blocks.Math.Sum power_sum(nin=2) if energy_calculation
    annotation (Placement(transformation(extent={{166,16},{186,36}})));
  Modelica.Blocks.Continuous.Integrator energy_integrator if energy_calculation
    annotation (Placement(transformation(extent={{204,16},{224,36}})));
  Modelica.Blocks.Interfaces.RealOutput energy_remaining
    if functionality == "Q_flow_input" and energy_calculation
    "Consumed real heat flow, positive for heating or cooling" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={258,26}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,52})));
  Modelica.Blocks.Sources.RealExpression T_return_const(y=T_return) if fixed_return_T
    annotation (Placement(transformation(extent={{-102,-78},{-82,-58}})));
equation
  if demandType==1 then
    Q_flow_max = max(0, senMasFlo.m_flow * Medium.cp_const * (senTemFlow.T - (TReturn - dT_maxNominalReturn)));
  else
    Q_flow_max = max(0, senMasFlo.m_flow * Medium.cp_const * (TReturn + dT_maxNominalReturn - senTemFlow.T));
  end if;

  connect(convection.fluid,prescribedTemperature. port)
    annotation (Line(points={{10,80},{30,80}},   color={191,0,0},
      pattern=LinePattern.Dash));
  connect(realExpression.y,convection. Gc)
    annotation (Line(points={{-19,78},{-10,78},{-10,70},{0,70}},
                                               color={0,0,127}));
  connect(realExpression1.y, prescribedTemperature.T)
    annotation (Line(points={{79,80},{52,80}},         color={0,0,127},
      pattern=LinePattern.Dash));
  connect(prescribedTemperature.T, T)
    annotation (Line(points={{52,80},{60,80},{60,120}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(volume.ports[1], pump.port_b)
    annotation (Line(points={{1,0},{-20,0}},  color={0,127,255}));
  connect(volume.ports[2], senTemReturn.port_a)
    annotation (Line(points={{-1,0},{38,0}}, color={0,127,255}));
  connect(port_b, senTemReturn.port_b)
    annotation (Line(points={{100,0},{58,0}}, color={0,127,255}));
  connect(port_a, senTemFlow.port_a)
    annotation (Line(points={{-100,0},{-90,0}}, color={0,127,255}));
  connect(PIPump.y, pump.y)
    annotation (Line(points={{-39,-40},{-30,-40},{-30,-12}},
                                                          color={0,0,127}));
  connect(PIPump.u_s, gain2.y)
    annotation (Line(points={{-62,-40},{-79,-40}}, color={0,0,127}));
  connect(senTemReturn.T, gain.u)
    annotation (Line(points={{48,-11},{48,-60},{22,-60}}, color={0,0,127}));
  connect(gain.y, PIPump.u_m)
    annotation (Line(points={{-1,-60},{-50,-60},{-50,-52}}, color={0,0,127}));
  connect(realExpression2.y, gain1.u) annotation (Line(
      points={{-79,80},{-60,80},{-60,40},{-50,40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(gain1.y, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{-27,40},{-22,40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(gain2.u, T_returnSet) annotation (Line(points={{-102,-40},{-120,-40},
          {-120,90},{0,90},{0,120}}, color={0,0,127}));
  connect(senMasFlo.port_a, senTemFlow.port_b)
    annotation (Line(points={{-66,0},{-70,0}}, color={0,127,255}));
  connect(senMasFlo.port_b, pump.port_a)
    annotation (Line(points={{-46,0},{-40,0}}, color={0,127,255}));
  connect(variableLimiter.y, gain1.u)
    annotation (Line(points={{-71.2,40},{-50,40}}, color={0,0,127}));
  connect(Q_flow, variableLimiter.u) annotation (Line(points={{-60,120},{-60,98},
          {-142,98},{-142,76},{-98,76},{-98,40},{-89.6,40}},
                                         color={0,0,127}));
  connect(ExpressionQ_flow_max.y, variableLimiter.limit1) annotation (Line(
        points={{-103,46},{-94,46},{-94,46.4},{-89.6,46.4}}, color={0,0,127}));
  connect(ExpressionQ_flow_min.y, variableLimiter.limit2) annotation (Line(
        points={{-103,30},{-94,30},{-94,33.6},{-89.6,33.6}}, color={0,0,127}));
  connect(variableLimiter.y, Q_flowReal) annotation (Line(points={{-71.2,40},{-58,
          40},{-58,46},{118,46}},     color={0,0,127}));
  connect(prescribedHeatFlow.port, volume.heatPort)
    annotation (Line(points={{-2,40},{18,40},{18,10},{10,10}}, color={191,0,0}));
  if energy_calculation then
    connect(power_sum.y, energy_integrator.u) annotation (Line(points={{187,26},{194.5,
            26},{194.5,26},{202,26}}, color={0,0,127}));
    connect(Q_flow, power_sum.u[2]) annotation (Line(points={{-60,120},{-60,56},
            {94,56},{94,26.5},{164,26.5}},
                                   color={0,0,127}));
    connect(power_sum.u[1], variableLimiter.y) annotation (Line(points={{164,25.5},
            {62,25.5},{62,50},{-50,50},{-50,40},{-71.2,40}},
                                                        color={0,0,127}));
  end if;

  connect(energy_remaining, energy_integrator.y)
    annotation (Line(points={{258,26},{225,26}}, color={0,0,127}));
  connect(T_return_const.y, PIPump.u_s)
    annotation (Line(points={{-81,-68},{-62,-68},{-62,-40}}, color={0,0,127}));
   annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                   Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Text(
          extent={{-56,18},{56,-18}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="CONSUMER")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  Model with a simple consumer. The consumed power depends either on
  the temperature (T_fixed or T_input) and the convective coefficient
  kA or the power is prescribed (Q_flow_input or _Q_flow_fixed). It is
  possible to choose between these options with the parameter
  \"functionality\".
</p>
<ul>
  <li>August 31, 2020, by Alexander Kümpel:<br/>
    Remove pipes
  </li>
  <li>October 31, 2019, by Alexander Kümpel:<br/>
    Add more options
  </li>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    Transfer from ZUGABE to AixLib
  </li>
  <li>
    <i>2016-03-06 &#160;</i> by Peter Matthes:<br/>
    added documentation
  </li>
  <li>
    <i>2016-02-17 &#160;</i> by Rohit Lad:<br/>
    implemented simple consumers model
  </li>
</ul>
</html>"));
end SimpleConsumer_old;
