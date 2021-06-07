within AixLib.Systems.EONERC_MainBuilding.Examples.ForControllerTesting;
model simple_consumer_Q
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
        origin={-14,54})));
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
  Fluid.Sources.Boundary_pT          boundary1(
    redeclare package Medium = Medium,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={0,-36})));
  Fluid.Sources.Boundary_pT          boundary(
    redeclare package Medium = Medium,
    use_T_in=true,
    T=289.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-38,-34})));
  HydraulicModules.Controller.CtrMixVflowConstValve ctrMixVflowConstValve(
      k_pump=100, Td_pump=0)
    annotation (Placement(transformation(extent={{-54,-2},{-34,18}})));
  Modelica.Blocks.Interfaces.RealInput mflowset
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-124,-32},{-84,8}})));
  Modelica.Blocks.Interfaces.RealInput Q_load
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
  Modelica.Blocks.Interfaces.RealInput T_in "Prescribed boundary temperature"
    annotation (Placement(transformation(extent={{-122,-88},{-86,-52}}),
        iconTransformation(extent={{-122,-88},{-86,-52}})));
equation
  connect(admixCold1.port_b1,consumerCold1. port_a)
    annotation (Line(points={{-18,20},{-18,54},{-20,54}},
                                             color={0,127,255}));
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
  connect(ctrMixVflowConstValve.Mflowset, mflowset) annotation (Line(points={{-56,
          13.8},{-58,13.8},{-58,-12},{-104,-12}},     color={0,0,127}));
  connect(consumerCold1.port_b, senTem.port_a)
    annotation (Line(points={{-8,54},{-8,50},{-6,50},{-6,44}},
                                               color={0,127,255}));
  connect(senTem.port_b, admixCold1.port_a2)
    annotation (Line(points={{-6,24},{-6,20}}, color={0,127,255}));
  connect(senTem.T, T_consumer)
    annotation (Line(points={{5,34},{34,34},{34,0},{108,0}}, color={0,0,127}));
  connect(boundary.T_in, T_in) annotation (Line(points={{-50,-38},{-76,-38},{
          -76,-70},{-104,-70}}, color={0,0,127}));
  connect(Q_load, consumerCold1.Q_flow) annotation (Line(points={{-106,62},{-62,
          62},{-62,60},{-17.6,60}}, color={0,0,127}));
  annotation (experiment(
      StopTime=300000,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end simple_consumer_Q;
