within AixLib.Systems.EONERC_MainBuilding.Examples.ForControllerTesting;
model SwitchingUnitAndConsumerTest "Test of Switching Units and Consumer"
  extends Modelica.Icons.Example;
    package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);
  parameter Real Tair = 293 "Air Temperature";
  AixLib.Systems.EONERC_MainBuilding.SwitchingUnit switchingUnit(redeclare
      package Medium = Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-18,-22},{18,22}},
        rotation=-90,
        origin={14,-36})));
  Fluid.Sources.Boundary_pT          boundary2(
    redeclare package Medium = Medium,
    T=280.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=-90,
        origin={34,-86})));
  Fluid.Sources.Boundary_pT          boundary3(
    redeclare package Medium = Medium,
    p=boundary2.p,
    T=280.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=-90,
        origin={12,-86})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    m_flow_nominal=4,
    V=0.1,
    nPorts=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-32,-38})));
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
        origin={22,52})));
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
        extent={{-13,-17},{13,17}},
        rotation=90,
        origin={21,11})));
  Modelica.Blocks.Nonlinear.Limiter limiterFVUCold(uMax=100000, uMin=0)
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={40,82})));
  Modelica.Blocks.Sources.RealExpression Q_flow_FVU_cold(y=(20*73)/3600*1.2*1005
        *(Tair - 284.15)*0.8)
                    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={54,82})));
  Modelica.Blocks.Sources.RealExpression Q_flow_CCA_cold(y=3000*(Tair - 293.15))
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={54,72})));
  Modelica.Blocks.Math.Add add1 annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={28,76})));
  Modelica.Blocks.Nonlinear.Limiter limiterCCACold(uMax=100000, uMin=0)
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={40,72})));
  HydraulicModules.Controller.CtrMixVflowConstValve ctrMixVflowConstValve(
    k_pump=1000,
    Ti_pump=30,
             Td_pump=0)
    annotation (Placement(transformation(extent={{-56,50},{-36,70}})));
  Controller.CtrSWU_flow ctrSWU_flow(k=1, Ti=60)
    annotation (Placement(transformation(extent={{-56,22},{-36,42}})));
  Modelica.Blocks.Sources.Constant const(k=6)
    annotation (Placement(transformation(extent={{-98,72},{-78,92}})));
  Modelica.Blocks.Sources.IntegerConstant integerConstant(k=2)
    annotation (Placement(transformation(extent={{-100,6},{-80,26}})));
  Modelica.Blocks.Sources.Constant const1(k=3)
    annotation (Placement(transformation(extent={{-98,42},{-78,62}})));
equation
  connect(boundary2.ports[1], switchingUnit.port_b1)
    annotation (Line(points={{34,-80},{34,-54},{32.3333,-54}},
                                               color={0,127,255}));
  connect(boundary3.ports[1], switchingUnit.port_a2)
    annotation (Line(points={{12,-80},{12,-54},{10.3333,-54}},
                                                 color={0,127,255}));
  connect(switchingUnit.port_b3, vol.ports[1]) annotation (Line(points={{-8,-28.8},
          {-22,-28.8},{-22,-40}},     color={0,127,255}));
  connect(vol.ports[2], switchingUnit.port_a3) annotation (Line(points={{-22,-36},
          {-22,-43.2},{-8,-43.2}},   color={0,127,255}));
  connect(admixCold1.port_b1,consumerCold1. port_a)
    annotation (Line(points={{10.8,24},{10.8,52},{16,52}},
                                             color={0,127,255}));
  connect(Q_flow_FVU_cold.y,limiterFVUCold. u)
    annotation (Line(points={{45.2,82},{44.8,82}},   color={0,0,127}));
  connect(add1.y,consumerCold1. Q_flow)
    annotation (Line(points={{23.6,76},{18.4,76},{18.4,58}},color={0,0,127}));
  connect(add1.u2,limiterFVUCold. y) annotation (Line(points={{32.8,78.4},{32.8,
          80.2},{35.6,80.2},{35.6,82}},         color={0,0,127}));
  connect(add1.u1,limiterCCACold. y) annotation (Line(points={{32.8,73.6},{34,73.6},
          {34,72},{35.6,72}},          color={0,0,127}));
  connect(Q_flow_CCA_cold.y,limiterCCACold. u)
    annotation (Line(points={{45.2,72},{44.8,72}},   color={0,0,127}));
  connect(ctrMixVflowConstValve.hydraulicBus,admixCold1. hydraulicBus)
    annotation (Line(
      points={{-34.6,60.2},{4,60.2},{4,11}},
      color={255,204,51},
      thickness=0.5));
  connect(admixCold1.port_a1, switchingUnit.port_b2) annotation (Line(points={{10.8,-2},
          {10.3333,-2},{10.3333,-18}},     color={0,127,255}));
  connect(switchingUnit.port_a1, admixCold1.port_b2) annotation (Line(points={{32.3333,
          -18},{32,-18},{32,-2},{31.2,-2}}, color={0,127,255}));
  connect(consumerCold1.port_b, admixCold1.port_a2) annotation (Line(points={{28,
          52},{30,52},{30,24},{31.2,24}}, color={0,127,255}));
  connect(ctrSWU_flow.sWUBus, switchingUnit.sWUBus) annotation (Line(
      points={{-36,32},{56,32},{56,-35.82},{36.3667,-35.82}},
      color={255,204,51},
      thickness=0.5));
  connect(integerConstant.y, ctrSWU_flow.mode) annotation (Line(points={{-79,16},
          {-66,16},{-66,26.6},{-56,26.6}}, color={255,127,0}));
  connect(const1.y, ctrSWU_flow.mFlowHxGtf) annotation (Line(points={{-77,52},{
          -66,52},{-66,37.4},{-56,37.4}}, color={0,0,127}));
  connect(const.y, ctrMixVflowConstValve.Mflowset) annotation (Line(points={{
          -77,82},{-68,82},{-68,65.8},{-58,65.8}}, color={0,0,127}));
  annotation (experiment(StopTime=23400),__Dymola_Commands(file(ensureSimulated=
           true)=
        "Resources/Scripts/Dymola/Systems/EONERC_MainBuilding/Validation/Simulate_and_plot_HeatpumpValidation.mos"
        "Simulate and plot"));
end SwitchingUnitAndConsumerTest;
