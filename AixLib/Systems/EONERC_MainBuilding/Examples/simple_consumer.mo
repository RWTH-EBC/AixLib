within AixLib.Systems.EONERC_MainBuilding.Examples;
model simple_consumer
  extends Modelica.Icons.Example;
      package Medium = AixLib.Media.Water annotation (choicesAllMatching=true);
  HydraulicModules.SimpleConsumer consumerCold1(
    allowFlowReversal=true,
    kA=312000/6,
    V=5,
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    functionality="Q_flow_input",
    T_start=293.15) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-12,54})));
  HydraulicModules.Admix admixCold1(
    T_start=293.15,
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          Fluid.Movers.Data.Pumps.Wilo.VeroLine80slash115dash2comma2slash2 per,
          energyDynamics=admixCold1.energyDynamics)),
    redeclare package Medium = Medium,
    m_flow_nominal=5,
    T_amb=298.15,
    dIns=0.01,
    kIns=0.028,
    d=0.1,
    pipe1(length=5),
    pipe2(length=5),
    pipe3(length=4),
    pipe4(length=5),
    pipe5(length=5),
    pipe6(length=1),
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    length=1,
    Kv=63) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-12,10})));
  Modelica.Blocks.Nonlinear.Limiter limiterFVUCold(uMax=100000, uMin=0)
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={2,74})));
  Modelica.Blocks.Sources.RealExpression Q_flow_FVU_cold(y=(20*73)/3600*1.2*1005
        *(Tair - 284.15)*0.8)
                    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={16,74})));
  Modelica.Blocks.Sources.RealExpression Q_flow_CCA_cold(y=3000*(Tair - 293.15))
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={16,64})));
  Modelica.Blocks.Math.Add add1 annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={-10,68})));
  Modelica.Blocks.Nonlinear.Limiter limiterCCACold(uMax=100000, uMin=0)
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={2,64})));
  Fluid.Sources.Boundary_pT          boundary1(
    redeclare package Medium = Medium,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={0,-36})));
  Fluid.Sources.Boundary_pT          boundary(
    redeclare package Medium = Medium,
    use_T_in=false,
    T=289.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-38,-34})));
  Modelica.Blocks.Interfaces.RealOutput Tair "Connector of Real output signal"
    annotation (Placement(transformation(extent={{-48,52},{-28,72}})));
  HydraulicModules.Controller.CtrMixVflowConstValve ctrMixVflowConstValve(
      k_pump=100, Td_pump=0)
    annotation (Placement(transformation(extent={{-54,-2},{-34,18}})));
  Modelica.Blocks.Interfaces.RealInput mflowset
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-124,-64},{-84,-24}})));
  Modelica.Blocks.Interfaces.RealInput T_amb
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-126,42},{-86,82}})));
  Fluid.Sensors.TemperatureTwoPort senTem(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    m_flow_nominal=10,
    m_flow_small=1E-4) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-6,34})));
  Modelica.Blocks.Interfaces.RealOutput T_consumer
    "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{98,-10},{118,10}})));
equation
  connect(admixCold1.port_b1,consumerCold1. port_a)
    annotation (Line(points={{-18,20},{-18,54}},
                                             color={0,127,255}));
  connect(Q_flow_FVU_cold.y,limiterFVUCold. u)
    annotation (Line(points={{7.2,74},{6.8,74}},     color={0,0,127}));
  connect(add1.y,consumerCold1. Q_flow)
    annotation (Line(points={{-14.4,68},{-15.6,68},{-15.6,60}},
                                                            color={0,0,127}));
  connect(add1.u2,limiterFVUCold. y) annotation (Line(points={{-5.2,70.4},{-5.2,
          72.2},{-2.4,72.2},{-2.4,74}},         color={0,0,127}));
  connect(add1.u1,limiterCCACold. y) annotation (Line(points={{-5.2,65.6},{-4,
          65.6},{-4,64},{-2.4,64}},    color={0,0,127}));
  connect(Q_flow_CCA_cold.y,limiterCCACold. u)
    annotation (Line(points={{7.2,64},{6.8,64}},     color={0,0,127}));
  connect(boundary.ports[1], admixCold1.port_a1)
    annotation (Line(points={{-28,-34},{-18,-34},{-18,0}}, color={0,127,255}));
  connect(boundary1.ports[1], admixCold1.port_b2) annotation (Line(points={{
          1.9984e-15,-26},{4,-26},{4,0},{-6,0}},
                                      color={0,127,255}));
  connect(ctrMixVflowConstValve.hydraulicBus, admixCold1.hydraulicBus)
    annotation (Line(
      points={{-32.6,8.2},{-22,8.2},{-22,10}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrMixVflowConstValve.Mflowset, mflowset) annotation (Line(points={{
          -56,13.8},{-58,13.8},{-58,-44},{-104,-44}}, color={0,0,127}));
  connect(T_amb, Tair)
    annotation (Line(points={{-106,62},{-38,62}}, color={0,0,127}));
  connect(consumerCold1.port_b, senTem.port_a)
    annotation (Line(points={{-6,54},{-6,44}}, color={0,127,255}));
  connect(senTem.port_b, admixCold1.port_a2)
    annotation (Line(points={{-6,24},{-6,20}}, color={0,127,255}));
  connect(senTem.T, T_consumer)
    annotation (Line(points={{5,34},{34,34},{34,0},{108,0}}, color={0,0,127}));
  annotation (experiment(
      StopTime=300000,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end simple_consumer;
