within AixLib.Systems.EONERC_MainBuilding.Examples;
package ForControllerTesting
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

  model GeothermalFieldSimpleFlowControl_test
    "Test of geothermal field model of E.ON ERC main building"
    extends Modelica.Icons.Example;
      package Medium = AixLib.Media.Water
      annotation (choicesAllMatching=true);

    Fluid.Sources.Boundary_pT          boundary1(
      redeclare package Medium = Medium, nPorts=1)
                annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={22,40})));
    AixLib.Systems.EONERC_MainBuilding.GeothermalFieldSimple gtf(
      redeclare package Medium = Medium,
      m_flow_nominal=10,
      T_amb=293.15)
               annotation (Placement(transformation(extent={{-20,-58},{20,-2}})));
    Controller.CtrGTFSimpleFlowCtrl ctrGTFSimpleFlowCtrl(
      k=500,
      Ti=20,
      Td=0) annotation (Placement(transformation(extent={{-64,-30},{-44,-10}})));
    Fluid.Sources.MassFlowSource_T        boundary5(
      redeclare package Medium = Medium,
      use_m_flow_in=true,
      use_T_in=true,
      nPorts=1,
      m_flow=1,
      T=300.15) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-32,48})));
    Fluid.Sensors.TemperatureTwoPort senTem(
      redeclare package Medium = Medium,
      allowFlowReversal=true,
      m_flow_nominal=10,
      m_flow_small=1E-4) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,16})));
    Modelica.Blocks.Interfaces.RealOutput Tout "Temperature of the passing fluid"
      annotation (Placement(transformation(extent={{98,8},{114,24}}),
          iconTransformation(extent={{98,8},{114,24}})));
    Modelica.Blocks.Sources.Constant const(k=5)
      annotation (Placement(transformation(extent={{-102,50},{-82,70}})));
    Modelica.Blocks.Sources.Constant const1(k=5)
      annotation (Placement(transformation(extent={{-108,-6},{-88,14}})));
    Modelica.Blocks.Sources.Constant const2(k=295)
      annotation (Placement(transformation(extent={{-102,20},{-82,40}})));
  equation
    connect(ctrGTFSimpleFlowCtrl.gtfBus, gtf.twoCircuitBus) annotation (Line(
        points={{-42.7,-20},{-44,-20},{-44,-19.675},{-20.1667,-19.675}},
        color={255,204,51},
        thickness=0.5));
    connect(boundary5.ports[1], gtf.port_a) annotation (Line(points={{-22,48},{
            -18,48},{-18,-2},{-16.6667,-2}}, color={0,127,255}));
    connect(gtf.port_b, senTem.port_a) annotation (Line(points={{16.6667,-2},{
            18,-2},{18,6},{20,6}},
                                color={0,127,255}));
    connect(senTem.port_b, boundary1.ports[1])
      annotation (Line(points={{20,26},{22,26},{22,30}}, color={0,127,255}));
    connect(senTem.T, Tout)
      annotation (Line(points={{31,16},{106,16}}, color={0,0,127}));
    connect(const.y, boundary5.m_flow_in) annotation (Line(points={{-81,60},{-62,
            60},{-62,56},{-44,56}}, color={0,0,127}));
    connect(const1.y, ctrGTFSimpleFlowCtrl.mflow_gtf) annotation (Line(points={{
            -87,4},{-76,4},{-76,-19.9},{-64.3,-19.9}}, color={0,0,127}));
    connect(const2.y, boundary5.T_in) annotation (Line(points={{-81,30},{-62,30},
            {-62,52},{-44,52}}, color={0,0,127}));
    annotation (experiment(StopTime=31536000),
                                           __Dymola_Commands(file(ensureSimulated=
             true)=
          "Resources/Scripts/Dymola/Systems/EONERC_MainBuilding/Validation/Simulate_and_plot_HeatpumpValidation.mos"
          "Simulate and plot"));
  end GeothermalFieldSimpleFlowControl_test;

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

  model EONERC_HP_and_consumer "Energy system of main building with controller"
    extends Modelica.Icons.Example;
    HydraulicModules.Controller.CtrMixVflowConstValve ctrMixVflowConstValve2(
      k_pump=1000,
      Ti_pump=30,
               Td_pump=0)
      annotation (Placement(transformation(extent={{-52,8},{-34,28}})));
    Controller.HeatPumpSystemVolumeFlowControl
                                    heatPumpSystemVolumeFlowControl1
      annotation (Placement(transformation(extent={{-50,90},{-8,140}})));
    HydraulicModules.Controller.CtrMixVflowConstValve ctrMixVflowConstValve1(k_pump=
          1000, Ti_pump=30)
      annotation (Placement(transformation(extent={{-52,34},{-34,54}})));
    HydraulicModules.Controller.CtrMixVflowConstValve ctrMixVflowConstValve3(
      k_pump=1000,
      Ti_pump=30,
               Td_pump=0)
      annotation (Placement(transformation(extent={{-52,60},{-34,80}})));
    BaseClasses.MainBus bus
      annotation (Placement(transformation(extent={{-4,22},{16,42}})));
    HeatPump_and_consumer heatPump_and_consumer
      annotation (Placement(transformation(extent={{-62,-102},{56,-14}})));
    BaseClasses.HeatpumpAndConsumerControllerBus heatpumpAndConsumerControllerBus
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  equation
    connect(heatPumpSystemVolumeFlowControl1.heatPumpSystemBus1, bus.hpSystemBus)
      annotation (Line(
        points={{-8,115.156},{-8,74.578},{6.05,74.578},{6.05,32.05}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(ctrMixVflowConstValve3.hydraulicBus, bus.consLtcBus) annotation (Line(
        points={{-32.74,70.2},{6.05,70.2},{6.05,32.05}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ctrMixVflowConstValve1.hydraulicBus, bus.consCold1Bus) annotation (
        Line(
        points={{-32.74,44.2},{-14.37,44.2},{-14.37,32.05},{6.05,32.05}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ctrMixVflowConstValve2.hydraulicBus, bus.consCold2Bus) annotation (
        Line(
        points={{-32.74,18.2},{-13.37,18.2},{-13.37,32.05},{6.05,32.05}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(heatPump_and_consumer.mainBus, bus) annotation (Line(
        points={{4.375,-14},{4.375,8},{6,8},{6,32}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(heatPumpSystemVolumeFlowControl1.pElHP,
      heatpumpAndConsumerControllerBus.pElHp) annotation (Line(points={{-51.68,
            138.438},{-51.68,139.219},{-99.95,139.219},{-99.95,0.05}}, color={0,0,
            127}), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(heatPumpSystemVolumeFlowControl1.vSetHS,
      heatpumpAndConsumerControllerBus.mfSetHpCon) annotation (Line(points={{-51.89,
            129.063},{-51.89,128.531},{-99.95,128.531},{-99.95,0.05}},
          color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(heatPumpSystemVolumeFlowControl1.vSetFreeCool,
      heatpumpAndConsumerControllerBus.mfSetFreeCool) annotation (Line(points={{
            -51.89,91.5625},{-51.89,91.7813},{-99.95,91.7813},{-99.95,0.05}},
          color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(ctrMixVflowConstValve3.Mflowset, heatpumpAndConsumerControllerBus.mfSetLTC)
      annotation (Line(points={{-53.8,75.8},{-53.8,75.9},{-99.95,75.9},{-99.95,
            0.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(ctrMixVflowConstValve1.Mflowset, heatpumpAndConsumerControllerBus.mfSetCold1)
      annotation (Line(points={{-53.8,49.8},{-53.8,49.9},{-99.95,49.9},{-99.95,
            0.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(ctrMixVflowConstValve2.Mflowset, heatpumpAndConsumerControllerBus.mfSetCold2)
      annotation (Line(points={{-53.8,23.8},{-98.9,23.8},{-98.9,0.05},{-99.95,
            0.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(heatPump_and_consumer.Tair, heatpumpAndConsumerControllerBus.tAmb)
      annotation (Line(points={{-62,-58},{-99.95,-58},{-99.95,0.05}}, color={0,0,
            127}), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(heatPumpSystemVolumeFlowControl1.vSetCS,
      heatpumpAndConsumerControllerBus.mfSetCsIn) annotation (Line(points={{-51.68,
            119.688},{-51.68,118.844},{-99.95,118.844},{-99.95,0.05}},
          color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(heatPumpSystemVolumeFlowControl1.vSetCold,
      heatpumpAndConsumerControllerBus.mfSetHpEva) annotation (Line(points={{-51.89,
            110.313},{-51.89,111.156},{-99.95,111.156},{-99.95,0.05}},
          color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(heatPumpSystemVolumeFlowControl1.vSetRecool,
      heatpumpAndConsumerControllerBus.mfSetReCool) annotation (Line(points={{-51.89,
            100.938},{-51.89,100.469},{-99.95,100.469},{-99.95,0.05}},
          color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    annotation (experiment(
        StopTime=21000,
        Interval=60,
        __Dymola_Algorithm="Dassl"));
  end EONERC_HP_and_consumer;

  model EONERC_MainBuilding_simple
    "Energy system of main building with controller"
    extends Modelica.Icons.Example;
    MainBuildingEnergySystem_simple mainBuildingEnergySystem_simple
      annotation (Placement(transformation(extent={{-54,-100},{72,-6}})));
    Controller.EON_ERC_simple_FlowControl eON_ERC_simple_FlowControl
      annotation (Placement(transformation(extent={{-54,42},{-18,86}})));
    BaseClasses.SimpleERCBus ctrlBus
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    BaseClasses.MainBus resBus
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  equation
    connect(eON_ERC_simple_FlowControl.mainBus, mainBuildingEnergySystem_simple.mainBus)
      annotation (Line(
        points={{-18,64},{16,64},{16,-6},{16.875,-6}},
        color={255,204,51},
        thickness=0.5));
    connect(eON_ERC_simple_FlowControl.simpleERCBus, ctrlBus) annotation (Line(
        points={{-54,64},{-78,64},{-78,0},{-100,0}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(ctrlBus.tAmb, mainBuildingEnergySystem_simple.Tair) annotation (Line(
        points={{-99.95,0.05},{-78,0.05},{-78,-53},{-54,-53}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(mainBuildingEnergySystem_simple.mainBus, resBus) annotation (Line(
        points={{16.875,-6},{16.875,0},{100,0}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    annotation (experiment(StopTime=31536000, Interval=59.9999616));
  end EONERC_MainBuilding_simple;

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
      use_T_in=true,
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
      annotation (Placement(transformation(extent={{-124,-32},{-84,8}})));
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
    Modelica.Blocks.Interfaces.RealInput T_in "Prescribed boundary temperature"
      annotation (Placement(transformation(extent={{-122,-88},{-86,-52}}),
          iconTransformation(extent={{-122,-88},{-86,-52}})));
  equation
    connect(admixCold1.port_b1,consumerCold1. port_a)
      annotation (Line(points={{-18,20},{-18,54},{-20,54}},
                                               color={0,127,255}));
    connect(Q_flow_FVU_cold.y,limiterFVUCold. u)
      annotation (Line(points={{7.2,74},{6.8,74}},     color={0,0,127}));
    connect(add1.y,consumerCold1. Q_flow)
      annotation (Line(points={{-14.4,68},{-17.6,68},{-17.6,60}},
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
    connect(ctrMixVflowConstValve.Mflowset, mflowset) annotation (Line(points={{-56,
            13.8},{-58,13.8},{-58,-12},{-104,-12}},     color={0,0,127}));
    connect(T_amb, Tair)
      annotation (Line(points={{-106,62},{-38,62}}, color={0,0,127}));
    connect(consumerCold1.port_b, senTem.port_a)
      annotation (Line(points={{-8,54},{-8,50},{-6,50},{-6,44}},
                                                 color={0,127,255}));
    connect(senTem.port_b, admixCold1.port_a2)
      annotation (Line(points={{-6,24},{-6,20}}, color={0,127,255}));
    connect(senTem.T, T_consumer)
      annotation (Line(points={{5,34},{34,34},{34,0},{108,0}}, color={0,0,127}));
    connect(boundary.T_in, T_in) annotation (Line(points={{-50,-38},{-76,-38},{
            -76,-70},{-104,-70}}, color={0,0,127}));
    annotation (experiment(
        StopTime=300000,
        Interval=60,
        __Dymola_Algorithm="Dassl"));
  end simple_consumer;

  model GeothermalFieldSimpleFlowControl
    "Test of geothermal field model of E.ON ERC main building"
    extends Modelica.Icons.Example;
      package Medium = AixLib.Media.Water
      annotation (choicesAllMatching=true);

    Fluid.Sources.Boundary_pT          boundary1(
      redeclare package Medium = Medium, nPorts=1)
                annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={22,40})));
    AixLib.Systems.EONERC_MainBuilding.GeothermalFieldSimple gtf(
      redeclare package Medium = Medium,
      m_flow_nominal=10,
      T_amb=293.15)
               annotation (Placement(transformation(extent={{-20,-58},{20,-2}})));
    Controller.CtrGTFSimpleFlowCtrl ctrGTFSimpleFlowCtrl(
      k=500,
      Ti=30,
      Td=0) annotation (Placement(transformation(extent={{-64,-30},{-44,-10}})));
    Fluid.Sources.MassFlowSource_T        boundary5(
      redeclare package Medium = Medium,
      use_m_flow_in=true,
      use_T_in=true,
      nPorts=1,
      m_flow=1,
      T=300.15) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-32,48})));
    Fluid.Sensors.TemperatureTwoPort senTem(
      redeclare package Medium = Medium,
      allowFlowReversal=true,
      m_flow_nominal=10,
      m_flow_small=1E-4) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,16})));
    Modelica.Blocks.Interfaces.RealOutput Tout "Temperature of the passing fluid"
      annotation (Placement(transformation(extent={{98,8},{114,24}}),
          iconTransformation(extent={{98,8},{114,24}})));
    Modelica.Blocks.Interfaces.RealInput mflow_gtf
      "Connector of setpoint input signal" annotation (Placement(transformation(
            extent={{-114,-28},{-96,-10}}), iconTransformation(extent={{-114,-28},
              {-96,-10}})));
    Modelica.Blocks.Interfaces.RealInput m_flow_in "Prescribed mass flow rate"
      annotation (Placement(transformation(extent={{-110,46},{-90,66}}),
          iconTransformation(extent={{-110,46},{-90,66}})));
    Modelica.Blocks.Interfaces.RealInput Tin "Prescribed boundary temperature"
      annotation (Placement(transformation(extent={{-110,18},{-94,34}}),
          iconTransformation(extent={{-110,18},{-94,34}})));
  equation
    connect(ctrGTFSimpleFlowCtrl.gtfBus, gtf.twoCircuitBus) annotation (Line(
        points={{-42.7,-20},{-44,-20},{-44,-19.675},{-20.1667,-19.675}},
        color={255,204,51},
        thickness=0.5));
    connect(boundary5.ports[1], gtf.port_a) annotation (Line(points={{-22,48},{
            -18,48},{-18,-2},{-16.6667,-2}}, color={0,127,255}));
    connect(gtf.port_b, senTem.port_a) annotation (Line(points={{16.6667,-2},{
            18,-2},{18,6},{20,6}},
                                color={0,127,255}));
    connect(senTem.port_b, boundary1.ports[1])
      annotation (Line(points={{20,26},{22,26},{22,30}}, color={0,127,255}));
    connect(senTem.T, Tout)
      annotation (Line(points={{31,16},{106,16}}, color={0,0,127}));
    connect(ctrGTFSimpleFlowCtrl.mflow_gtf, mflow_gtf) annotation (Line(points={{-64.3,
            -19.9},{-82.15,-19.9},{-82.15,-19},{-105,-19}},       color={0,0,127}));
    connect(boundary5.m_flow_in, m_flow_in)
      annotation (Line(points={{-44,56},{-100,56}}, color={0,0,127}));
    connect(boundary5.T_in, Tin) annotation (Line(points={{-44,52},{-64,52},{-64,
            26},{-102,26}}, color={0,0,127}));
    annotation (experiment(StopTime=31536000),
                                           __Dymola_Commands(file(ensureSimulated=
             true)=
          "Resources/Scripts/Dymola/Systems/EONERC_MainBuilding/Validation/Simulate_and_plot_HeatpumpValidation.mos"
          "Simulate and plot"));
  end GeothermalFieldSimpleFlowControl;

  model HeatExchanger_FlowControlled
    "Test of heat exachgner model of E.ON ERC main building"
    extends Modelica.Icons.Example;
      package Medium = AixLib.Media.Water
      annotation (choicesAllMatching=true);

    Fluid.Sources.Boundary_pT          boundary(
      redeclare package Medium = Medium,
      use_T_in=true,
      T=333.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-78,-18})));
    Fluid.Sources.Boundary_pT          boundary1(
      redeclare package Medium = Medium,
      T=303.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-78,10})));
    Fluid.Sources.Boundary_pT          boundary4(
      redeclare package Medium = Medium,
      use_T_in=true,
      T=303.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={20,-80})));
    Fluid.Sources.Boundary_pT          boundary5(
      redeclare package Medium = Medium,
      T=303.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={60,-80})));
    HeatExchangerSystem heatExchangerSystem(
      redeclare package Medium = Medium,
      m_flow_nominal=10,
      T_start=293.15)
      annotation (Placement(transformation(extent={{-40,-40},{68,40}})));
    Fluid.MixingVolumes.MixingVolume vol(
      redeclare package Medium = Medium,
      m_flow_nominal=2,
      V=0.1,
      nPorts=2) annotation (Placement(transformation(extent={{70,58},{50,78}})));
    BaseClasses.TwoCircuitBus hxBus1
      annotation (Placement(transformation(extent={{10,54},{30,74}})));
    Controller.CtrHXmflow ctrHXmflow(
      k=1,
      Ti=20,
      rpmPumpPrim=2500,
      rpmPumpSec=2500)
      annotation (Placement(transformation(extent={{-56,58},{-36,78}})));
    Modelica.Blocks.Interfaces.RealInput T_in_sec
      "Prescribed boundary temperature" annotation (Placement(transformation(
            extent={{-122,-102},{-100,-80}}), iconTransformation(extent={{-122,
              -102},{-100,-80}})));
    Modelica.Blocks.Interfaces.RealInput T_in_prim
      "Prescribed boundary temperature" annotation (Placement(transformation(
            extent={{-118,-32},{-98,-12}}),  iconTransformation(extent={{-118,-32},
              {-98,-12}})));
    Modelica.Blocks.Interfaces.RealInput mflowSet_prim
      "Connector of setpoint input signal" annotation (Placement(transformation(
            extent={{-122,62},{-100,84}}), iconTransformation(extent={{-122,62},{
              -100,84}})));
    Modelica.Blocks.Interfaces.RealInput mflowSet_sec
      "Connector of setpoint input signal" annotation (Placement(transformation(
            extent={{-126,26},{-100,52}}), iconTransformation(extent={{-126,26},{
              -100,52}})));
  equation
    connect(heatExchangerSystem.port_a1, boundary.ports[1]) annotation (Line(
          points={{-40,-8},{-56,-8},{-56,-18},{-68,-18}},
                                                      color={0,127,255}));
    connect(heatExchangerSystem.port_b1, boundary1.ports[1]) annotation (Line(
          points={{-40,8},{-56,8},{-56,10},{-68,10}},     color={0,127,255}));
    connect(boundary4.ports[1], heatExchangerSystem.port_a2) annotation (Line(
          points={{20,-70},{44.8571,-70},{44.8571,-40}}, color={0,127,255}));
    connect(boundary5.ports[1], heatExchangerSystem.port_b3) annotation (Line(
          points={{60,-70},{60,-39.2},{60.2857,-39.2}}, color={0,127,255}));
    connect(heatExchangerSystem.port_b2, vol.ports[1]) annotation (Line(points={{44.8571,
            40},{46,40},{46,60},{62,60},{62,58}},         color={0,127,255}));
    connect(heatExchangerSystem.port_a3, vol.ports[2]) annotation (Line(points={{60.2857,
            40},{60,40},{60,58},{58,58}},         color={0,127,255}));
    connect(heatExchangerSystem.hxBus, hxBus1) annotation (Line(
        points={{9.37143,40},{12,40},{12,64},{20,64}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ctrHXmflow.hxBus, heatExchangerSystem.hxBus) annotation (Line(
        points={{-34.9,68.1},{10.55,68.1},{10.55,40},{9.37143,40}},
        color={255,204,51},
        thickness=0.5));
    connect(boundary4.T_in, T_in_sec) annotation (Line(points={{24,-92},{-40,-92},
            {-40,-91},{-111,-91}}, color={0,0,127}));
    connect(boundary.T_in, T_in_prim)
      annotation (Line(points={{-90,-22},{-98,-22},{-98,-20},{-102,-20},{-102,-22},
            {-108,-22}},                              color={0,0,127}));
    connect(ctrHXmflow.mflowSet_prim, mflowSet_prim) annotation (Line(points={{
            -56,73.4},{-102,73.4},{-102,73},{-111,73}}, color={0,0,127}));
    connect(ctrHXmflow.mflowSet_sec, mflowSet_sec) annotation (Line(points={{-56,
            62.2},{-72,62.2},{-72,39},{-113,39}}, color={0,0,127}));
    annotation (experiment(StopTime=23400),__Dymola_Commands(file(ensureSimulated=
             true)=
          "Resources/Scripts/Dymola/Systems/EONERC_MainBuilding/Validation/Simulate_and_plot_HeatExchanger.mos"
          "Simulate and plot"));
  end HeatExchanger_FlowControlled;

  model HeatPumpSystemVolumeFlowControlled_Inputs
    "Validation of HeatpumpSystem"
    extends Modelica.Icons.Example;
      package Medium = AixLib.Media.Water
      annotation (choicesAllMatching=true);

    Fluid.Sources.Boundary_pT          boundary(
      redeclare package Medium = Medium,
      nPorts=1,
      T=303.15) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-100,20})));
    Fluid.Sources.MassFlowSource_T        boundary5(
      redeclare package Medium = Medium,
      use_m_flow_in=true,
      use_T_in=true,
      nPorts=1,
      m_flow=1,
      T=300.15) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-100,-20})));
    Fluid.Sources.Boundary_pT          boundary2(
      redeclare package Medium = Medium,
      T=285.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={100,-22})));
    Fluid.Sources.MassFlowSource_T        boundary3(
      redeclare package Medium = Medium,
      use_m_flow_in=true,
      m_flow=4,
      use_T_in=true,
      T=291.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={100,20})));
    HeatpumpSystem heatpumpSystem(redeclare package Medium = Medium,
      T_start_hot=311.15,
      T_start_cold=284.15)
      annotation (Placement(transformation(extent={{-80,-40},{80,28}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=270,
          origin={-128,-28})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1 annotation (
        Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=270,
          origin={126,30})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
      prescribedTemperature
      annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin2
      annotation (Placement(transformation(extent={{-8,-8},{8,8}},
          rotation=0,
          origin={-70,-70})));
    Controller.HeatPumpSystemVolumeFlowControl heatPumpSystemVolumeFlowControl
      annotation (Placement(transformation(extent={{-24,66},{-4,98}})));
    Modelica.Blocks.Sources.Constant const8(k=100)
      annotation (Placement(transformation(extent={{-54,80},{-46,88}})));
    Modelica.Blocks.Interfaces.RealInput pElHP "Connector of Real input signal 1"
      annotation (Placement(transformation(extent={{-110,96},{-92,114}}),
          iconTransformation(extent={{-110,96},{-92,114}})));
    Modelica.Blocks.Interfaces.RealInput vSetHS
      "Connector of second Real input signal" annotation (Placement(
          transformation(extent={{-110,80},{-90,100}}), iconTransformation(extent=
             {{-110,80},{-90,100}})));
    Modelica.Blocks.Interfaces.RealInput vSetCold
      "Connector of second Real input signal" annotation (Placement(
          transformation(extent={{-110,52},{-92,70}}), iconTransformation(extent=
              {{-110,52},{-92,70}})));
    Modelica.Blocks.Interfaces.RealInput vSetRecool
      "Connector of second Real input signal" annotation (Placement(
          transformation(extent={{-110,68},{-92,86}}), iconTransformation(extent=
              {{-110,68},{-92,86}})));
    Modelica.Blocks.Interfaces.RealInput vSetFreeCool
      "Connector of second Real input signal" annotation (Placement(
          transformation(extent={{-108,40},{-92,56}}), iconTransformation(extent=
              {{-108,40},{-92,56}})));
    Modelica.Blocks.Interfaces.RealInput tHotIn
      annotation (Placement(transformation(extent={{-180,-34},{-140,6}})));
    Modelica.Blocks.Interfaces.RealInput mHotIn "Prescribed mass flow rate"
      annotation (Placement(transformation(extent={{-180,-4},{-140,36}})));
    Modelica.Blocks.Interfaces.RealInput tColdIn
      annotation (Placement(transformation(extent={{164,40},{124,80}})));
    Modelica.Blocks.Interfaces.RealInput mColdIn "Prescribed mass flow rate"
      annotation (Placement(transformation(extent={{176,-14},{136,26}})));
    Modelica.Blocks.Interfaces.RealInput tAmb
      annotation (Placement(transformation(extent={{-180,-90},{-140,-50}})));
    BaseClasses.HeatPumpSystemBus bus
      annotation (Placement(transformation(extent={{18,72},{38,92}})));
  equation
    connect(boundary5.ports[1], heatpumpSystem.port_a2) annotation (Line(points={
            {-90,-20},{-80,-20},{-80,-9.77778}}, color={0,127,255}));
    connect(boundary.ports[1], heatpumpSystem.port_b2) annotation (Line(points={{
            -90,20},{-80,20},{-80,5.33333}}, color={0,127,255}));
    connect(toKelvin.Kelvin, boundary5.T_in)
      annotation (Line(points={{-128,-34.6},{-116,-34.6},{-116,-16},{-112,-16}},
                                                         color={0,0,127}));
    connect(toKelvin1.Kelvin, boundary3.T_in) annotation (Line(points={{126,23.4},
            {126,16},{112,16}},          color={0,0,127}));
    connect(prescribedTemperature.port, heatpumpSystem.T_outside) annotation (
        Line(points={{-20,-70},{-20,-54},{0,-54},{0,-36.2222}}, color={191,0,0}));
    connect(boundary3.ports[1], heatpumpSystem.port_a1) annotation (Line(points={{90,20},
            {88,20},{88,5.33333},{80,5.33333}},        color={0,127,255}));
    connect(heatpumpSystem.port_b1, boundary2.ports[1]) annotation (Line(points={{80,
            -9.77778},{80,0.11111},{90,0.11111},{90,-22}},     color={0,127,255}));
    connect(toKelvin2.Kelvin, prescribedTemperature.T)
      annotation (Line(points={{-61.2,-70},{-42,-70}}, color={0,0,127}));
    connect(heatPumpSystemVolumeFlowControl.heatPumpSystemBus1, heatpumpSystem.heatPumpSystemBus)
      annotation (Line(
        points={{-4,82.1},{0,82.1},{0,28}},
        color={255,204,51},
        thickness=0.5));
    connect(heatPumpSystemVolumeFlowControl.pElHP, pElHP) annotation (Line(points=
           {{-24.8,97},{-90,97},{-90,105},{-101,105}}, color={0,0,127}));
    connect(heatPumpSystemVolumeFlowControl.vSetHS, vSetHS) annotation (Line(
          points={{-24.9,91},{-86,91},{-86,90},{-100,90}}, color={0,0,127}));
    connect(heatPumpSystemVolumeFlowControl.vSetCold, vSetCold) annotation (Line(
          points={{-24.9,79},{-38.45,79},{-38.45,61},{-101,61}}, color={0,0,127}));
    connect(heatPumpSystemVolumeFlowControl.vSetRecool, vSetRecool) annotation (
        Line(points={{-24.9,73},{-62,73},{-62,77},{-101,77}}, color={0,0,127}));
    connect(heatPumpSystemVolumeFlowControl.vSetFreeCool, vSetFreeCool)
      annotation (Line(points={{-24.9,67},{-24.9,48},{-100,48}}, color={0,0,127}));
    connect(const8.y, heatPumpSystemVolumeFlowControl.vSetCS) annotation (Line(
          points={{-45.6,84},{-36,84},{-36,85},{-24.8,85}}, color={0,0,127}));
    connect(toKelvin.Celsius, tHotIn) annotation (Line(points={{-128,-20.8},{-144,
            -20.8},{-144,-14},{-160,-14}}, color={0,0,127}));
    connect(boundary5.m_flow_in, mHotIn) annotation (Line(points={{-112,-12},{
            -138,-12},{-138,18},{-160,18},{-160,16}}, color={0,0,127}));
    connect(toKelvin1.Celsius, tColdIn)
      annotation (Line(points={{126,37.2},{126,60},{144,60}}, color={0,0,127}));
    connect(boundary3.m_flow_in, mColdIn) annotation (Line(points={{112,12},{128,
            12},{128,8},{156,8},{156,6}}, color={0,0,127}));
    connect(toKelvin2.Celsius, tAmb)
      annotation (Line(points={{-79.6,-70},{-160,-70}}, color={0,0,127}));
    connect(heatpumpSystem.heatPumpSystemBus, bus) annotation (Line(
        points={{0,28},{0,82},{28,82}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    annotation (experiment(StopTime=23400), __Dymola_Commands(file(
            ensureSimulated=true)=
          "Resources/Scripts/Dymola/Systems/EONERC_MainBuilding/Validation/Simulate_and_plot_HeatpumpSystemValidation.mos"
          "Simulate and plot"));
  end HeatPumpSystemVolumeFlowControlled_Inputs;

  model HeatPumpSystemVolumeFlowControlled "Validation of HeatpumpSystem"
    extends Modelica.Icons.Example;
      package Medium = AixLib.Media.Water
      annotation (choicesAllMatching=true);

    Fluid.Sources.Boundary_pT          boundary(
      redeclare package Medium = Medium,
      nPorts=1,
      T=303.15) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-100,20})));
    Fluid.Sources.MassFlowSource_T        boundary5(
      redeclare package Medium = Medium,
      use_m_flow_in=true,
      use_T_in=true,
      nPorts=1,
      m_flow=1,
      T=300.15) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-100,-20})));
    Fluid.Sources.Boundary_pT          boundary2(
      redeclare package Medium = Medium,
      T=285.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={100,-22})));
    Fluid.Sources.MassFlowSource_T        boundary3(
      redeclare package Medium = Medium,
      use_m_flow_in=true,
      m_flow=4,
      use_T_in=true,
      T=291.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={100,20})));
    HeatpumpSystem heatpumpSystem(redeclare package Medium = Medium,
      T_start_hot=311.15,
      T_start_cold=284.15)
      annotation (Placement(transformation(extent={{-80,-40},{80,28}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=270,
          origin={-126,-14})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1 annotation (
        Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=270,
          origin={126,30})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
      prescribedTemperature
      annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin2
      annotation (Placement(transformation(extent={{-8,-8},{8,8}},
          rotation=0,
          origin={-70,-70})));
    Controller.HeatPumpSystemVolumeFlowControl heatPumpSystemVolumeFlowControl
      annotation (Placement(transformation(extent={{-24,66},{-4,98}})));
    Modelica.Blocks.Sources.Constant const(k=30)
      annotation (Placement(transformation(extent={{-92,88},{-78,102}})));
    Modelica.Blocks.Sources.Constant const1(k=5)
      annotation (Placement(transformation(extent={{-88,54},{-74,68}})));
    Modelica.Blocks.Sources.Constant const2(k=20)
      annotation (Placement(transformation(extent={{-110,-76},{-96,-62}})));
    Modelica.Blocks.Sources.Constant const3(k=20)
      annotation (Placement(transformation(extent={{-146,10},{-132,24}})));
    Modelica.Blocks.Sources.Constant const4(k=5)
      annotation (Placement(transformation(extent={{-132,44},{-118,58}})));
    Modelica.Blocks.Sources.Constant const5(k=15)
      annotation (Placement(transformation(extent={{122,-20},{136,-6}})));
    Modelica.Blocks.Sources.Constant const6(k=0)
      annotation (Placement(transformation(extent={{-58,48},{-44,62}})));
    Modelica.Blocks.Sources.Constant const7(k=20)
      annotation (Placement(transformation(extent={{74,50},{88,64}})));
    Modelica.Blocks.Sources.Constant const8(k=5)
      annotation (Placement(transformation(extent={{-106,66},{-92,80}})));
  equation
    connect(boundary5.ports[1], heatpumpSystem.port_a2) annotation (Line(points={
            {-90,-20},{-80,-20},{-80,-9.77778}}, color={0,127,255}));
    connect(boundary.ports[1], heatpumpSystem.port_b2) annotation (Line(points={{
            -90,20},{-80,20},{-80,5.33333}}, color={0,127,255}));
    connect(toKelvin.Kelvin, boundary5.T_in)
      annotation (Line(points={{-126,-20.6},{-116,-20.6},{-116,-16},{-112,-16}},
                                                         color={0,0,127}));
    connect(toKelvin1.Kelvin, boundary3.T_in) annotation (Line(points={{126,23.4},
            {126,16},{112,16}},          color={0,0,127}));
    connect(prescribedTemperature.port, heatpumpSystem.T_outside) annotation (
        Line(points={{-20,-70},{-20,-54},{0,-54},{0,-36.2222}}, color={191,0,0}));
    connect(boundary3.ports[1], heatpumpSystem.port_a1) annotation (Line(points={{90,20},
            {88,20},{88,5.33333},{80,5.33333}},        color={0,127,255}));
    connect(heatpumpSystem.port_b1, boundary2.ports[1]) annotation (Line(points={{80,
            -9.77778},{80,0.11111},{90,0.11111},{90,-22}},     color={0,127,255}));
    connect(toKelvin2.Kelvin, prescribedTemperature.T)
      annotation (Line(points={{-61.2,-70},{-42,-70}}, color={0,0,127}));
    connect(heatPumpSystemVolumeFlowControl.heatPumpSystemBus1, heatpumpSystem.heatPumpSystemBus)
      annotation (Line(
        points={{-4,82.1},{0,82.1},{0,28}},
        color={255,204,51},
        thickness=0.5));
    connect(const.y, heatPumpSystemVolumeFlowControl.pElHP) annotation (Line(
          points={{-77.3,95},{-46.65,95},{-46.65,97},{-24.8,97}},     color={0,0,
            127}));
    connect(const2.y, toKelvin2.Celsius) annotation (Line(points={{-95.3,-69},{
            -87.65,-69},{-87.65,-70},{-79.6,-70}}, color={0,0,127}));
    connect(const3.y, toKelvin.Celsius) annotation (Line(points={{-131.3,17},{
            -131.3,6.5},{-126,6.5},{-126,-6.8}}, color={0,0,127}));
    connect(const4.y, boundary5.m_flow_in) annotation (Line(points={{-117.3,51},{
            -117.3,19.5},{-112,19.5},{-112,-12}}, color={0,0,127}));
    connect(const5.y, boundary3.m_flow_in) annotation (Line(points={{136.7,-13},{
            136.7,-1.5},{112,-1.5},{112,12}}, color={0,0,127}));
    connect(const7.y, toKelvin1.Celsius) annotation (Line(points={{88.7,57},{
            107.35,57},{107.35,37.2},{126,37.2}}, color={0,0,127}));
    connect(const8.y, heatPumpSystemVolumeFlowControl.vSetCS) annotation (Line(
          points={{-91.3,73},{-58.65,73},{-58.65,85},{-24.8,85}}, color={0,0,127}));
    connect(heatPumpSystemVolumeFlowControl.vSetHS,
      heatPumpSystemVolumeFlowControl.vSetCS) annotation (Line(points={{-24.9,91},
            {-56,86},{-56,85},{-24.8,85}}, color={0,0,127}));
    connect(heatPumpSystemVolumeFlowControl.vSetCold,
      heatPumpSystemVolumeFlowControl.vSetCS) annotation (Line(points={{-24.9,79},
            {-60,80},{-58.65,80},{-58.65,85},{-24.8,85}}, color={0,0,127}));
    connect(const6.y, heatPumpSystemVolumeFlowControl.vSetRecool) annotation (
        Line(points={{-43.3,55},{-34.65,55},{-34.65,73},{-24.9,73}}, color={0,0,
            127}));
    connect(heatPumpSystemVolumeFlowControl.vSetFreeCool,
      heatPumpSystemVolumeFlowControl.vSetRecool) annotation (Line(points={{-24.9,
            67},{-34,56},{-34.65,56},{-34.65,73},{-24.9,73}}, color={0,0,127}));
    annotation (experiment(StopTime=23400), __Dymola_Commands(file(
            ensureSimulated=true)=
          "Resources/Scripts/Dymola/Systems/EONERC_MainBuilding/Validation/Simulate_and_plot_HeatpumpSystemValidation.mos"
          "Simulate and plot"));
  end HeatPumpSystemVolumeFlowControlled;

  model EONERC_Thermal_Zone "Test of ERC Thermal Zone"
      package MediumWater = AixLib.Media.Water
      annotation (choicesAllMatching=true);
      package MediumAir = AixLib.Media.AirIncompressible
      annotation (choicesAllMatching=true);
      extends Modelica.Icons.Example;
    parameter Real Tair = 293 "Air Temperature";
    Tabs2                     tabs1(
      redeclare package Medium = MediumWater,
      area=60*60,
      thickness=0.3,
      alpha=15,
      length=500)
      annotation (Placement(transformation(extent={{320,-196},{360,-156}})));
    ThermalZones.ReducedOrder.ThermalZone.ThermalZone thermalZone1(
      redeclare package Medium = MediumAir,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      zoneParam=BaseClasses.ERCMainBuilding_Office(),
      ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
              each der_T(fixed=true)))),
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      T_start=293.15,
      recOrSep=false,
      Heater_on=false,
      Cooler_on=false,
      nPorts=2) "Thermal zone"
      annotation (Placement(transformation(extent={{274,-116},{330,-58}})));
    BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
      calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
      computeWetBulbTemperature=false,
      filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
      "Weather data reader"
      annotation (Placement(transformation(extent={{160,-42},{180,-22}})));

    Modelica.Blocks.Sources.CombiTimeTable internalGains(
      extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      tableName="UserProfiles",
      fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/LowOrder_ExampleData/UserProfiles_18599_SIA_Besprechung_Sitzung_Seminar.txt"),
      columns={2,3,4},
      tableOnFile=false,
      table=[0,0,0.1,0,0; 3540,0,0.1,0,0; 3600,0,0.1,0,0; 7140,0,0.1,0,0; 7200,0,0.1,
          0,0; 10740,0,0.1,0,0; 10800,0,0.1,0,0; 14340,0,0.1,0,0; 14400,0,0.1,0,0;
          17940,0,0.1,0,0; 18000,0,0.1,0,0; 21540,0,0.1,0,0; 21600,0,0.1,0,0; 25140,
          0,0.1,0,0; 25200,0,0.1,0,0; 28740,0,0.1,0,0; 28800,0,0.1,0,0; 32340,0,0.1,
          0,0; 32400,0.6,0.6,1,1; 35940,0.6,0.6,1,1; 36000,1,1,1,1; 39540,1,1,1,1;
          39600,0.4,0.4,1,1; 43140,0.4,0.4,1,1; 43200,0,0.1,0,0; 46740,0,0.1,0,0;
          46800,0,0.1,0,0; 50340,0,0.1,0,0; 50400,0.6,0.6,1,1; 53940,0.6,0.6,1,1;
          54000,1,1,1,1; 57540,1,1,1,1; 57600,0.4,0.4,1,1; 61140,0.4,0.4,1,1; 61200,
          0,0.1,0,0; 64740,0,0.1,0,0; 64800,0,0.1,0,0; 68340,0,0.1,0,0; 68400,0,0.1,
          0,0; 71940,0,0.1,0,0; 72000,0,0.1,0,0; 75540,0,0.1,0,0; 75600,0,0.1,0,0;
          79140,0,0.1,0,0; 79200,0,0.1,0,0; 82740,0,0.1,0,0; 82800,0,0.1,0,0; 86340,
          0,0.1,0,0; 86400,0,0.1,0,0; 89940,0,0.1,0,0; 90000,0,0.1,0,0; 93540,0,0.1,
          0,0; 93600,0,0.1,0,0; 97140,0,0.1,0,0; 97200,0,0.1,0,0; 100740,0,0.1,0,0;
          100800,0,0.1,0,0; 104340,0,0.1,0,0; 104400,0,0.1,0,0; 107940,0,0.1,0,0;
          108000,0,0.1,0,0; 111540,0,0.1,0,0; 111600,0,0.1,0,0; 115140,0,0.1,0,0;
          115200,0,0.1,0,0; 118740,0,0.1,0,0; 118800,0.6,0.6,1,1; 122340,0.6,0.6,1,
          1; 122400,1,1,1,1; 125940,1,1,1,1; 126000,0.4,0.4,1,1; 129540,0.4,0.4,1,
          1; 129600,0,0.1,0,0; 133140,0,0.1,0,0; 133200,0,0.1,0,0; 136740,0,0.1,0,
          0; 136800,0.6,0.6,1,1; 140340,0.6,0.6,1,1; 140400,1,1,1,1; 143940,1,1,1,
          1; 144000,0.4,0.4,1,1; 147540,0.4,0.4,1,1; 147600,0,0.1,0,0; 151140,0,0.1,
          0,0; 151200,0,0.1,0,0; 154740,0,0.1,0,0; 154800,0,0.1,0,0; 158340,0,0.1,
          0,0; 158400,0,0.1,0,0; 161940,0,0.1,0,0; 162000,0,0.1,0,0; 165540,0,0.1,
          0,0; 165600,0,0.1,0,0; 169140,0,0.1,0,0; 169200,0,0.1,0,0; 172740,0,0.1,
          0,0; 172800,0,0.1,0,0; 176340,0,0.1,0,0; 176400,0,0.1,0,0; 179940,0,0.1,
          0,0; 180000,0,0.1,0,0; 183540,0,0.1,0,0; 183600,0,0.1,0,0; 187140,0,0.1,
          0,0; 187200,0,0.1,0,0; 190740,0,0.1,0,0; 190800,0,0.1,0,0; 194340,0,0.1,
          0,0; 194400,0,0.1,0,0; 197940,0,0.1,0,0; 198000,0,0.1,0,0; 201540,0,0.1,
          0,0; 201600,0,0.1,0,0; 205140,0,0.1,0,0; 205200,0.6,0.6,1,1; 208740,0.6,
          0.6,1,1; 208800,1,1,1,1; 212340,1,1,1,1; 212400,0.4,0.4,1,1; 215940,0.4,
          0.4,1,1; 216000,0,0.1,0,0; 219540,0,0.1,0,0; 219600,0,0.1,0,0; 223140,0,
          0.1,0,0; 223200,0.6,0.6,1,1; 226740,0.6,0.6,1,1; 226800,1,1,1,1; 230340,
          1,1,1,1; 230400,0.4,0.4,1,1; 233940,0.4,0.4,1,1; 234000,0,0.1,0,0; 237540,
          0,0.1,0,0; 237600,0,0.1,0,0; 241140,0,0.1,0,0; 241200,0,0.1,0,0; 244740,
          0,0.1,0,0; 244800,0,0.1,0,0; 248340,0,0.1,0,0; 248400,0,0.1,0,0; 251940,
          0,0.1,0,0; 252000,0,0.1,0,0; 255540,0,0.1,0,0; 255600,0,0.1,0,0; 259140,
          0,0.1,0,0; 259200,0,0.1,0,0; 262740,0,0.1,0,0; 262800,0,0.1,0,0; 266340,
          0,0.1,0,0; 266400,0,0.1,0,0; 269940,0,0.1,0,0; 270000,0,0.1,0,0; 273540,
          0,0.1,0,0; 273600,0,0.1,0,0; 277140,0,0.1,0,0; 277200,0,0.1,0,0; 280740,
          0,0.1,0,0; 280800,0,0.1,0,0; 284340,0,0.1,0,0; 284400,0,0.1,0,0; 287940,
          0,0.1,0,0; 288000,0,0.1,0,0; 291540,0,0.1,0,0; 291600,0.6,0.6,1,1; 295140,
          0.6,0.6,1,1; 295200,1,1,1,1; 298740,1,1,1,1; 298800,0.4,0.4,1,1; 302340,
          0.4,0.4,1,1; 302400,0,0.1,0,0; 305940,0,0.1,0,0; 306000,0,0.1,0,0; 309540,
          0,0.1,0,0; 309600,0.6,0.6,1,1; 313140,0.6,0.6,1,1; 313200,1,1,1,1; 316740,
          1,1,1,1; 316800,0.4,0.4,1,1; 320340,0.4,0.4,1,1; 320400,0,0.1,0,0; 323940,
          0,0.1,0,0; 324000,0,0.1,0,0; 327540,0,0.1,0,0; 327600,0,0.1,0,0; 331140,
          0,0.1,0,0; 331200,0,0.1,0,0; 334740,0,0.1,0,0; 334800,0,0.1,0,0; 338340,
          0,0.1,0,0; 338400,0,0.1,0,0; 341940,0,0.1,0,0; 342000,0,0.1,0,0; 345540,
          0,0.1,0,0; 345600,0,0.1,0,0; 349140,0,0.1,0,0; 349200,0,0.1,0,0; 352740,
          0,0.1,0,0; 352800,0,0.1,0,0; 356340,0,0.1,0,0; 356400,0,0.1,0,0; 359940,
          0,0.1,0,0; 360000,0,0.1,0,0; 363540,0,0.1,0,0; 363600,0,0.1,0,0; 367140,
          0,0.1,0,0; 367200,0,0.1,0,0; 370740,0,0.1,0,0; 370800,0,0.1,0,0; 374340,
          0,0.1,0,0; 374400,0,0.1,0,0; 377940,0,0.1,0,0; 378000,0.6,0.6,1,1; 381540,
          0.6,0.6,1,1; 381600,1,1,1,1; 385140,1,1,1,1; 385200,0.4,0.4,1,1; 388740,
          0.4,0.4,1,1; 388800,0,0.1,0,0; 392340,0,0.1,0,0; 392400,0,0.1,0,0; 395940,
          0,0.1,0,0; 396000,0.6,0.6,1,1; 399540,0.6,0.6,1,1; 399600,1,1,1,1; 403140,
          1,1,1,1; 403200,0.4,0.4,1,1; 406740,0.4,0.4,1,1; 406800,0,0.1,0,0; 410340,
          0,0.1,0,0; 410400,0,0.1,0,0; 413940,0,0.1,0,0; 414000,0,0.1,0,0; 417540,
          0,0.1,0,0; 417600,0,0.1,0,0; 421140,0,0.1,0,0; 421200,0,0.1,0,0; 424740,
          0,0.1,0,0; 424800,0,0.1,0,0; 428340,0,0.1,0,0; 428400,0,0.1,0,0; 431940,
          0,0.1,0,0; 432000,0,0,0,0; 435540,0,0,0,0; 435600,0,0,0,0; 439140,0,0,0,
          0; 439200,0,0,0,0; 442740,0,0,0,0; 442800,0,0,0,0; 446340,0,0,0,0; 446400,
          0,0,0,0; 449940,0,0,0,0; 450000,0,0,0,0; 453540,0,0,0,0; 453600,0,0,0,0;
          457140,0,0,0,0; 457200,0,0,0,0; 460740,0,0,0,0; 460800,0,0,0,0; 464340,0,
          0,0,0; 464400,0,0,0,0; 467940,0,0,0,0; 468000,0,0,0,0; 471540,0,0,0,0; 471600,
          0,0,0,0; 475140,0,0,0,0; 475200,0,0,0,0; 478740,0,0,0,0; 478800,0,0,0,0;
          482340,0,0,0,0; 482400,0,0,0,0; 485940,0,0,0,0; 486000,0,0,0,0; 489540,0,
          0,0,0; 489600,0,0,0,0; 493140,0,0,0,0; 493200,0,0,0,0; 496740,0,0,0,0; 496800,
          0,0,0,0; 500340,0,0,0,0; 500400,0,0,0,0; 503940,0,0,0,0; 504000,0,0,0,0;
          507540,0,0,0,0; 507600,0,0,0,0; 511140,0,0,0,0; 511200,0,0,0,0; 514740,0,
          0,0,0; 514800,0,0,0,0; 518340,0,0,0,0; 518400,0,0,0,0; 521940,0,0,0,0; 522000,
          0,0,0,0; 525540,0,0,0,0; 525600,0,0,0,0; 529140,0,0,0,0; 529200,0,0,0,0;
          532740,0,0,0,0; 532800,0,0,0,0; 536340,0,0,0,0; 536400,0,0,0,0; 539940,0,
          0,0,0; 540000,0,0,0,0; 543540,0,0,0,0; 543600,0,0,0,0; 547140,0,0,0,0; 547200,
          0,0,0,0; 550740,0,0,0,0; 550800,0,0,0,0; 554340,0,0,0,0; 554400,0,0,0,0;
          557940,0,0,0,0; 558000,0,0,0,0; 561540,0,0,0,0; 561600,0,0,0,0; 565140,0,
          0,0,0; 565200,0,0,0,0; 568740,0,0,0,0; 568800,0,0,0,0; 572340,0,0,0,0; 572400,
          0,0,0,0; 575940,0,0,0,0; 576000,0,0,0,0; 579540,0,0,0,0; 579600,0,0,0,0;
          583140,0,0,0,0; 583200,0,0,0,0; 586740,0,0,0,0; 586800,0,0,0,0; 590340,0,
          0,0,0; 590400,0,0,0,0; 593940,0,0,0,0; 594000,0,0,0,0; 597540,0,0,0,0; 597600,
          0,0,0,0; 601140,0,0,0,0; 601200,0,0,0,0; 604740,0,0,0,0])
      "Table with profiles for internal gains"
      annotation(Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=90,
          origin={327,-132})));

    ModularAHU.GenericAHU                genericAHU(
      redeclare package Medium1 = MediumAir,
      redeclare package Medium2 = MediumWater,
      T_amb=293.15,
      m1_flow_nominal=12000/3600*1.2,
      m2_flow_nominal=0.5,
      T_start=293.15,
      usePreheater=false,
      useHumidifierRet=false,
      useHumidifier=false,
      perheater(redeclare HydraulicModules.Admix hydraulicModule(
          parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
          length=1,
          Kv=6.3,
          redeclare
            HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
            PumpInterface(pump(redeclare
                Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per))), dynamicHX(
          dp1_nominal=50,
          dp2_nominal=1000,
          tau1=5,
          tau2=15,
          dT_nom=30,
          Q_nom=60000)),
      cooler(redeclare HydraulicModules.Admix hydraulicModule(
          parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
          length=1,
          Kv=6.3,
          redeclare
            HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
            PumpInterface(pump(redeclare
                Fluid.Movers.Data.Pumps.Wilo.Stratos50slash1to12 per))),
          dynamicHX(
          dp1_nominal=100,
          dp2_nominal=1000,
          tau1=5,
          tau2=10,
          dT_nom=15,
          Q_nom=150000)),
      heater(redeclare HydraulicModules.Admix hydraulicModule(
          parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
          length=1,
          Kv=6.3,
          redeclare
            HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
            PumpInterface(pump(redeclare
                Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per))), dynamicHX(
          dp1_nominal=100,
          dp2_nominal=5000,
          tau1=5,
          tau2=15,
          dT_nom=20,
          Q_nom=60000)),
      dynamicHX(
        dp1_nominal=150,
        dp2_nominal=150,
        dT_nom=2,
        Q_nom=50000),
      humidifier(
        dp_nominal=20,
        mWat_flow_nominal=1,
        TLiqWat_in=288.15),
      humidifierRet(
        dp_nominal=20,
        mWat_flow_nominal=0.5,
        TLiqWat_in=288.15))
      annotation (Placement(transformation(extent={{66,-162},{186,-96}})));
    Fluid.Sources.Boundary_pT boundaryOutsideAir(
      use_X_in=true,
      use_Xi_in=false,
      use_T_in=true,
      nPorts=1,
      redeclare package Medium = Media.Air,
      T=283.15) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={22,-162})));
    Fluid.Sources.Boundary_pT boundaryExhaustAir(redeclare package Medium =
          Media.Air, nPorts=1)
                            annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={22,-108})));
    Utilities.Psychrometrics.X_pTphi x_pTphi
      annotation (Placement(transformation(extent={{-20,-152},{0,-132}})));
    BoundaryConditions.WeatherData.Bus        weaBus
      "Weather data bus"
      annotation (Placement(transformation(extent={{206,-78},{240,-46}}),
      iconTransformation(extent={{-10,86},{10,106}})));
    BaseClasses.MainBus2ZoneMainBuilding                     mainBus annotation (
        Placement(transformation(extent={{102,8},{148,66}}),
          iconTransformation(extent={{-28,70},{32,126}})));
    Fluid.Sources.Boundary_pT          boundary4(
      redeclare package Medium = MediumWater,
      p=MediumWater.p_default,
      T=308.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{8,-8},{-8,8}},
          rotation=270,
          origin={302,-264})));
    Fluid.Sources.Boundary_pT          boundary1(
      redeclare package Medium = MediumWater,
      p=MediumWater.p_default,
      T=308.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{8,-8},{-8,8}},
          rotation=270,
          origin={332,-264})));
    Fluid.Sources.Boundary_pT          boundary2(
      redeclare package Medium = MediumWater,
      p=MediumWater.p_default,
      T=285.15,
      nPorts=2) annotation (Placement(transformation(
          extent={{8,-8},{-8,8}},
          rotation=270,
          origin={236,-222})));
    Fluid.Sources.Boundary_pT          boundary3(
      redeclare package Medium = MediumWater,
      p=MediumWater.p_default,
      T=285.15,
      nPorts=2) annotation (Placement(transformation(
          extent={{8,-8},{-8,8}},
          rotation=270,
          origin={212,-222})));
    Fluid.Sources.Boundary_pT          boundary5(
      redeclare package Medium = MediumWater,
      p=MediumWater.p_default,
      T=333.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{8,-8},{-8,8}},
          rotation=270,
          origin={146,-282})));
    Fluid.Sources.Boundary_pT          boundary6(
      redeclare package Medium = MediumWater,
      p=MediumWater.p_default,
      T=333.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{8,-8},{-8,8}},
          rotation=270,
          origin={168,-282})));
  equation
    connect(weaDat.weaBus,thermalZone1. weaBus) annotation (Line(
        points={{180,-32},{274,-32},{274,-69.6}},
        color={255,204,51},
        thickness=0.5));
    connect(weaDat.weaBus,weaBus)  annotation (Line(
        points={{180,-32},{223,-32},{223,-62}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(internalGains.y,thermalZone1. intGains) annotation (Line(points={{327,
            -124.3},{324.4,-124.3},{324.4,-111.36}},
                                              color={0,0,127}));
    connect(tabs1.heatPort,thermalZone1. intGainsConv) annotation (Line(points={{340,
            -154.182},{344,-154.182},{344,-85.84},{330.56,-85.84}},   color={191,
            0,0}));
    connect(boundaryOutsideAir.T_in,weaBus. TDryBul) annotation (Line(points={{10,-166},
            {-56,-166},{-56,-62},{223,-62}},           color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(thermalZone1.TAir,mainBus. TRoom1Mea) annotation (Line(points={{332.8,
            -63.8},{332,-63.8},{332,37.145},{125.115,37.145}},   color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(boundaryOutsideAir.T_in,x_pTphi. T) annotation (Line(points={{10,-166},
            {-32,-166},{-32,-142},{-22,-142}},                            color={
            0,0,127}));
    connect(x_pTphi.phi,weaBus. relHum) annotation (Line(points={{-22,-148},{-56,-148},
            {-56,-62},{223,-62}},                            color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(x_pTphi.p_in,weaBus. pAtm) annotation (Line(points={{-22,-136},{-56,-136},
            {-56,-62},{223,-62}},                            color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(x_pTphi.X,boundaryOutsideAir. X_in) annotation (Line(points={{1,-142},
            {4,-142},{4,-158},{10,-158}},           color={0,0,127}));
    connect(genericAHU.port_b1,thermalZone1. ports[1]) annotation (Line(points={{186.545,
            -132},{306,-132},{306,-107.88},{295.42,-107.88}},     color={0,127,
            255}));
    connect(genericAHU.port_a2,thermalZone1. ports[2]) annotation (Line(points={{186.545,
            -108},{242,-108},{242,-107.88},{308.58,-107.88}},   color={0,127,255}));
    connect(genericAHU.genericAHUBus,mainBus. ahu1Bus) annotation (Line(
        points={{126,-95.7},{126,37.145},{125.115,37.145}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(tabs1.tabsBus,mainBus. tabs1Bus) annotation (Line(
        points={{319.8,-177.636},{406,-177.636},{406,36},{125.115,36},{125.115,
            37.145}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(genericAHU.port_a1,boundaryOutsideAir. ports[1]) annotation (Line(
          points={{66,-132},{32,-132},{32,-162}},                         color={
            0,127,255}));
    connect(boundaryExhaustAir.ports[1],genericAHU. port_b2) annotation (Line(
          points={{32,-108},{66,-108}},                        color={0,127,255}));
    connect(boundary4.ports[1], tabs1.port_a1) annotation (Line(points={{302,-256},
            {302,-228},{324,-228},{324,-196}}, color={244,125,35}));
    connect(boundary1.ports[1], tabs1.port_b1)
      annotation (Line(points={{332,-256},{332,-196}}, color={244,125,35}));
    connect(boundary5.ports[1], genericAHU.port_a5) annotation (Line(points={{146,
            -274},{147.818,-274},{147.818,-162}}, color={238,46,47}));
    connect(boundary6.ports[1], genericAHU.port_b5) annotation (Line(points={{168,
            -274},{158.182,-274},{158.182,-162}}, color={238,46,47}));
    connect(boundary2.ports[1], tabs1.port_b2) annotation (Line(points={{237.6,
            -214},{356,-214},{356,-195.636}},
                                        color={0,127,255}));
    connect(boundary2.ports[2], genericAHU.port_b4) annotation (Line(points={{234.4,
            -214},{138,-214},{138,-162},{136.909,-162}}, color={0,127,255}));
    connect(boundary3.ports[1], genericAHU.port_a4) annotation (Line(points={{213.6,
            -214},{127,-214},{127,-162},{126,-162}}, color={0,127,255}));
    connect(boundary3.ports[2], tabs1.port_a2) annotation (Line(points={{210.4,-214},
            {348,-214},{348,-196}}, color={0,127,255}));
    annotation (experiment(StopTime=23400),__Dymola_Commands(file(ensureSimulated=
             true)=
          "Resources/Scripts/Dymola/Systems/EONERC_MainBuilding/Validation/Simulate_and_plot_HeatpumpValidation.mos"
          "Simulate and plot"),
      Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
      Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
  end EONERC_Thermal_Zone;
end ForControllerTesting;
