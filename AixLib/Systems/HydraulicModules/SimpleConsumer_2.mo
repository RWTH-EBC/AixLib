within AixLib.Systems.HydraulicModules;
model SimpleConsumer_2
  extends AixLib.Systems.HydraulicModules.BaseClasses.SimpleConsumer_base(
      volume(nPorts=2));
  parameter Integer demandType   "Choose between heating and cooling functionality" annotation (choices(
              choice=1 "use as heating consumer",
              choice=-1 "use as cooling consumer"),Dialog(enable=true));
  parameter Boolean hasPump = false "circuit has Pump";
  parameter Boolean fixed_TReturn=true  "= true, if fixed return temperature, false if variable";
  parameter SI.Temperature T_return=293.15  "Return temperature" annotation (Dialog(enable = fixed_TReturn));

  Modelica.Blocks.Math.Gain gain1(k=-demandType) if functionality == "Q_flow_input"
     or functionality == "Q_flow_fixed"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-28,40})));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter
    annotation (Placement(transformation(extent={{-64,30},{-44,50}})));
  Modelica.Blocks.Sources.RealExpression Exp_Q_flow_max(y=Q_flow_max)
    annotation (Placement(transformation(extent={{-98,38},{-78,58}})));
  Modelica.Blocks.Sources.RealExpression Exp_Q_flow_min(y=0)
    annotation (Placement(transformation(extent={{-98,22},{-78,42}})));
  Fluid.Movers.SpeedControlled_y     pump(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    T_start=T_start,
    allowFlowReversal=allowFlowReversal,
    show_T=show_T,
    redeclare Fluid.Movers.Data.Generic per(pressure(V_flow={0,m_flow_nominal/1000,
            m_flow_nominal/500}, dp={dp_nominalPumpConsumer/0.8,
            dp_nominalPumpConsumer,0}), motorCooledByFluid=false),
    addPowerToMedium=false,
    y_start=0.5) if hasPump
    annotation (Placement(transformation(extent={{-32,10},{-12,-10}})));
  Modelica.Blocks.Math.Gain gain(k=demandType) if hasPump
    "Used to reverse direction of operation of controller"
    annotation (Placement(transformation(extent={{72,-28},{64,-20}})));
  Modelica.Blocks.Continuous.LimPID PIPump(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k_ControlConsumerPump,
    Ti=Ti_ControlConsumerPump,
    yMax=1,
    yMin=0.05,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.5) if hasPump
               annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=270,
        origin={-22,-24})));
  Modelica.Blocks.Sources.RealExpression TSet_Return(
    y= if fixed_TReturn then T_return else T_ReturnSet)
    annotation (Placement(transformation(extent={{-54,-50},{-34,-30}})));
  Modelica.Blocks.Interfaces.RealInput T_ReturnSet if not fixed_TReturn annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-104,-96}),
                         iconTransformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-96,-80})));
equation
  connect(gain1.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-21.4,40},{-16,40}}, color={0,0,127}));
  connect(Q_realExp.y, gain1.u) annotation (Line(points={{-41,60},{-40,60},{-40,
          40},{-35.2,40}}, color={0,0,127}, pattern=LinePattern.Dash));
  connect(variableLimiter.y, gain1.u) annotation (Line(points={{-43,40},{-35.2,40}},   color={0,0,127}, pattern=LinePattern.Dash));
  connect(Q_flow, variableLimiter.u) annotation (Line(points={{-60,120},{-60,100},
          {-72,100},{-72,40},{-66,40}}, color={0,0,127}));
  connect(Exp_Q_flow_max.y, variableLimiter.limit1)
    annotation (Line(points={{-77,48},{-66,48}}, color={0,0,127}));
  connect(Exp_Q_flow_min.y, variableLimiter.limit2)
    annotation (Line(points={{-77,32},{-66,32}}, color={0,0,127}));
  connect(senMasFlo.port_b, pump.port_a)
    annotation (Line(points={{-44,0},{-32,0}}, color={0,127,255}));
  if hasPump then
    connect(pump.port_b, volume.ports[2])
      annotation (Line(points={{-12,0},{-1.77636e-15,0}}, color={0,127,255}));
    connect(gain.u, senTReturn.T) annotation (Line(points={{72.8,-24},{80,-24},
            {80,-11}},                                                                    color={0,0,127}));
    connect(PIPump.y, pump.y) annotation (Line(points={{-22,-17.4},{-22,-12}}, color={0,0,127}));
    connect(PIPump.u_m, gain.y) annotation (Line(points={{-14.8,-24},{63.6,-24}},
                            color={0,0,127}));
  else
    connect(senTFlow.port_b, pump.port_a);
  end if;

  connect(TSet_Return.y, PIPump.u_s) annotation (Line(points={{-33,-40},{-22,
          -40},{-22,-31.2}},
                        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SimpleConsumer_2;
