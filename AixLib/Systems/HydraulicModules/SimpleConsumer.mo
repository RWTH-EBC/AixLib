within AixLib.Systems.HydraulicModules;
model SimpleConsumer
  extends AixLib.Systems.HydraulicModules.BaseClasses.SimpleConsumer_base(
      allowFlowReversal=false,
   volume(nPorts=2));
  parameter Boolean hasPump=false   "circuit has Pump" annotation (Dialog(group = "Pump"), choices(checkBox = true));
  parameter Boolean show_T=false "= true, if actual temperature at port is computed"
    annotation (Dialog(enable = hasPump, group = "Pump"));
  //parameter Modelica.SIunits.PressureDifference dp_nominalPumpConsumer=if rho_default < 500
  //     then 500 else 10000
  //  "Nominal pressure raise, used for default pressure curve if not specified in record per"
  //  annotation (Dialog(enable = hasPump, group = "Pump"));
  parameter Modelica.SIunits.PressureDifference dp_nominalPumpConsumer= if hasFeedback then dp_Valve+max(dpFixed_nominal) else 10000
    "Nominal pressure raise, used for default pressure curve if not specified in record per"
    annotation (Dialog(enable = hasPump, group = "Pump"));
  parameter Real k_ControlConsumerPump(min=Modelica.Constants.small)=1 "Gain of controller"
    annotation (Dialog(enable = hasPump, group = "Pump"));
  parameter Modelica.SIunits.Time Ti_ControlConsumerPump(min=Modelica.Constants.small)=1 "Time constant of Integrator block"
    annotation (Dialog(enable = hasPump, group = "Pump"));
  parameter Boolean hasFeedback = false "circuit has Feedback" annotation (Dialog(group = "Feedback"), choices(checkBox = true));

  parameter Real k_ControlConsumerValve(min=Modelica.Constants.small)=1 "Gain of controller"
    annotation (Dialog(enable = hasFeedback, group = "Feedback"));
  parameter Modelica.SIunits.Time Ti_ControlConsumerValve(min=Modelica.Constants.small)=1 "Time constant of Integrator block"
    annotation (Dialog(enable = hasFeedback, group = "Feedback"));
  parameter Modelica.SIunits.PressureDifference dp_Valve = 0 "Pressure Difference set in regulating valve for pressure equalization in heating system" annotation (Dialog(enable = hasFeedback, group="Feedback"));
  parameter Modelica.SIunits.PressureDifference dpFixed_nominal[2] = {0,0} "Nominal additional pressure drop e.g. for distributor" annotation (Dialog(enable = hasFeedback, group="Feedback"));

protected
  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default);
  parameter Modelica.SIunits.Density rho_default=Medium.density(sta_default)
    "Density, used to compute fluid volume";

public
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
    annotation (Placement(transformation(extent={{-28,10},{-8,-10}})));
  Modelica.Blocks.Math.Gain gain(k=demandType)
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
        rotation=180,
        origin={-28,-28})));
  Modelica.Blocks.Continuous.LimPID PIValve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k_ControlConsumerValve,
    Ti=Ti_ControlConsumerValve,
    yMax=1,
    yMin=0.05,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.5) if hasFeedback
               annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={-60,34})));
  Modelica.Blocks.Sources.RealExpression TSet_Return(y=demandType*TReturn)
    annotation (Placement(transformation(extent={{-62,-38},{-42,-18}})));
  Modelica.Blocks.Sources.RealExpression TSet_Flow(y=demandType*TFlow)
    annotation (Placement(transformation(extent={{-26,24},{-46,44}})));
  Modelica.Blocks.Math.Gain gain2(k=demandType) if hasFeedback
    "Used to reverse direction of operation of controller"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-60,20})));
  Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val(
    redeclare package Medium = Medium,
    m_flow_nominal= m_flow_nominal,
    from_dp=false,
    dpValve_nominal=dp_Valve,
    dpFixed_nominal=dpFixed_nominal) if hasFeedback
    annotation (Placement(transformation(extent={{-94,-10},{-74,10}})));
equation

  if hasPump then
    connect(senMasFlo.port_b, pump.port_a)
      annotation (Line(points={{-30,0},{-28,0}}, color={0,127,255}));
    connect(pump.port_b, volume.ports[2])
      annotation (Line(points={{-8,0},{-1.77636e-15,0}},  color={0,127,255}));
    connect(PIPump.y, pump.y) annotation (Line(points={{-21.4,-28},{-18,-28},{-18,
            -12}},                                                             color={0,0,127}));
    connect(PIPump.u_m, gain.y) annotation (Line(points={{-28,-35.2},{-28,-40},{
            60,-40},{60,-24},{63.6,-24}},
                            color={0,0,127}));
  else
    connect(senMasFlo.port_b, volume.ports[2]);
  end if;

  connect(TSet_Return.y, PIPump.u_s) annotation (Line(points={{-41,-28},{-35.2,-28}},
                        color={0,0,127}));
  connect(gain.u, senTReturn.T) annotation (Line(points={{72.8,-24},{80,-24},{
            80,-11}},                                                                     color={0,0,127}));
  if hasFeedback then
    connect(PIValve.u_s, TSet_Flow.y)
    annotation (Line(points={{-52.8,34},{-47,34}}, color={0,0,127}));
    connect(senTFlow.T, gain2.u)
    annotation (Line(points={{-60,11},{-60,15.2}}, color={0,0,127}));
    connect(gain2.y, PIValve.u_m)
    annotation (Line(points={{-60,24.4},{-60,26.8}}, color={0,0,127}));
  else
    connect(port_a, senTFlow.port_a);
  end if;

  connect(port_a, val.port_1)
    annotation (Line(points={{-100,0},{-94,0}}, color={0,127,255}));
  connect(val.port_3, senTReturn.port_b) annotation (Line(points={{-84,-10},{-84,
          -54},{90,-54},{90,0}}, color={0,127,255}));
  connect(PIValve.y, val.y)
    annotation (Line(points={{-66.6,34},{-84,34},{-84,12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SimpleConsumer;
