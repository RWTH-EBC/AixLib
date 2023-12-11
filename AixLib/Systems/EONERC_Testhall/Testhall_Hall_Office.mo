within AixLib.Systems.EONERC_Testhall;
model Testhall_Hall_Office

  AixLib.Fluid.Sources.Boundary_ph EHA(redeclare package Medium =
        AixLib.Media.Air, nPorts=1)
                "AirOut" annotation (Placement(transformation(
        extent={{-2,-2},{2,2}},
        rotation=180,
        origin={196,-24})));
  AixLib.Fluid.Sources.Boundary_pT     ODA(
    use_T_in=true,
    redeclare package Medium = AixLib.Media.Air,
    p=101325,
    nPorts=1) "ODA"
    annotation (Placement(transformation(extent={{198,-42},{194,-38}})));

  AixLib.Fluid.Sources.Boundary_pT ret_c(
    redeclare package Medium = AixLib.Media.Water,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{124,-74},{128,-70}})));
  AixLib.Fluid.Sources.Boundary_pT sup_c(
    redeclare package Medium = AixLib.Media.Water,
    p=115000,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{144,-72},{140,-68}})));
  BaseClass.CCA.CCA cCA
    annotation (Placement(transformation(extent={{-44,2},{-6,40}})));
  BaseClass.CPH.CPH cPH
    annotation (Placement(transformation(extent={{-178,-56},{-136,-16}})));
  BaseClass.CID.CID cID
    annotation (Placement(transformation(extent={{32,14},{100,56}})));
  BaseClass.JetNozzle.JN        jN
    annotation (Placement(transformation(extent={{-104,26},{-72,46}})));
  HydraulicModules.SimpleConsumer                       Hall1(
    redeclare package Medium = AixLib.Media.Air,
    m_flow_nominal=2.34,
    T_start=291.15,
    functionality="Q_flow_input") "Thermal zone"
    annotation (Placement(transformation(extent={{-90,72},{-62,98}})));
  HydraulicModules.SimpleConsumer                       Office(
    redeclare package Medium = AixLib.Media.Air,
    V=3,
    m_flow_nominal=0.66,
    T_start=291.15,
    functionality="Q_flow_input") "Thermal zone"
    annotation (Placement(transformation(extent={{62,72},{90,98}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow cca_PrescribedHeatFlow(alpha=0)
    annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=270,
        origin={-25,61})));
  Modelica.Blocks.Sources.TimeTable cca_heatflow(table=[0,2; 267840,7; 2678400,
        7; 5270400,15; 7948800,22; 10627200,36; 13132800,28; 15811200,7;
        18403200,0; 21081600,0; 23673600,0; 26352000,0; 29030400,7; 31536000,7])
    annotation (Placement(transformation(extent={{-54,98},{-34,118}})));
  Modelica.Blocks.Sources.TimeTable hall1_heatflow(table=[0,1; 600000,7;
        2678400,29; 5270400,19; 7948800,9.6; 10627200,5.8; 13132800,5.2;
        15811200,13; 18403200,1; 21081600,4; 23673600,0; 26352000,2.4; 29030400,
        21; 31536000,7])
    annotation (Placement(transformation(extent={{-140,120},{-120,140}})));
  Modelica.Blocks.Math.Gain gainjn(k=-1000*3)
    annotation (Placement(transformation(extent={{-106,124},{-94,136}})));
  Modelica.Blocks.Sources.TimeTable cid_heatflow(table=[0,0.5; 86400,3.5;
        2678400,9; 5270400,8.5; 7948800,7.9; 10627200,10.45; 13132800,8.3;
        15811200,5; 18403200,0.25; 21081600,1; 23673600,0; 26352000,0.6;
        29030400,7; 31536000,3.5])
    annotation (Placement(transformation(extent={{24,122},{44,142}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow cph_PrescribedHeatFlow(alpha=0)
    annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=270,
        origin={-171,33})));

  Modelica.Blocks.Math.Gain gaincid(k=-1000) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={69,109})));
  Modelica.Blocks.Math.Gain gaincca(k=-1000) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={-25,79})));
  Modelica.Blocks.Sources.CombiTimeTable ambientAir(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/DataBase/AmbientAir.txt"),
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{242,-56},{222,-36}})));

    Modelica.Blocks.Sources.CombiTimeTable CoolerInput(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/DataBase/Cooler.txt"),
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    columns={2})
    annotation (Placement(transformation(extent={{168,-84},{156,-72}})));

  AixLib.Systems.ModularAHU.GenericAHU ahu(
    redeclare package Medium1 = AixLib.Media.Air,
    redeclare package Medium2 = AixLib.Media.Water,
    T_amb=288.15,
    m1_flow_nominal=3.7,
    m2_flow_nominal=2.3,
    usePreheater=true,
    useHumidifierRet=false,
    useHumidifier=false,
    preheater(
      hydraulicModuleIcon="Injection",
      m2_flow_nominal=0.45,
      redeclare AixLib.Systems.HydraulicModules.Injection
        hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        Kv=6.3,
        valveCharacteristic=AixLib.Fluid.Actuators.Valves.Data.LinearLinear(),
        pipe1(length=1.2),
        pipe2(length=0.1),
        pipe3(length=0.1),
        pipe4(length=2.3),
        pipe5(length=2),
        pipe6(length=0.1),
        pipe7(length=1.3),
        pipe8(length=0.3),
        pipe9(length=0.3),
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)))),
    cooler(
      hydraulicModuleIcon="Injection2WayValve",
      m2_flow_nominal=5,
      redeclare AixLib.Systems.HydraulicModules.Injection2WayValve
        hydraulicModule(
        pipeModel="SimplePipe",
        length=1,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_6x1(),
        Kv=25,
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
          PumpInterface(pumpParam=
              AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN50_H05_16()))),
    heater(
      hydraulicModuleIcon="Injection2WayValve",
      m2_flow_nominal=1.2,
      redeclare AixLib.Systems.HydraulicModules.Injection2WayValve
        hydraulicModule(
        pipeModel="SimplePipe",
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        Kv=10,
        valve(flowCharacteristics=Fluid.Actuators.Valves.Data.Linear()),
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
          PumpInterface(pumpParam=
              AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN25_H05_12()),
        pipe1(length=10),
        pipe2(length=0.6),
        pipe3(length=2),
        pipe4(length=5.5),
        pipe5(length=0.4),
        pipe6(length=10),
        pipe7(length=0.6))))
    annotation (Placement(transformation(extent={{180,-60},{94,-16}})));

  Modelica.Blocks.Sources.CombiTimeTable QFlowHall2(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/DataBase/QflowHall2.txt"),
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{-210,40},{-190,60}})));

  Controller.Obsolete.ControlCID_Heizkurve controlCID
    annotation (Placement(transformation(extent={{16,28},{36,48}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                                   senRoomTemp(redeclare package Medium =
        AixLib.Media.Air, m_flow_nominal=0.66)
    annotation (Placement(transformation(extent={{92,62},{112,82}})));
  Controller.ControlCCA controlCCA
    annotation (Placement(transformation(extent={{-74,12},{-48,32}})));
  Controller.ControlCPH controlCPH
    annotation (Placement(transformation(extent={{-214,-50},{-194,-30}})));
  AixLib.Systems.ModularAHU.Controller.CtrAHUBasic controlAHU(
    TFlowSet=310.15,
    ctrPh(rpm_pump=2300),
    ctrRh(k=0.005, Ti=1000),
    VFlowSet=3.08,
    dpMax=5000,
    useTwoFanCtr=true,
    k=10)  annotation (Placement(transformation(extent={{176,-10},{156,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senHallTemp(redeclare package Medium =
        AixLib.Media.Air, m_flow_nominal=2.64)
                                            annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-54,60})));
  Controller.Obsolete.ControlJN_constHydrValve controlJN
    annotation (Placement(transformation(extent={{-132,36},{-112,56}})));
  BaseClass.Distributor.Distributor_withoutReserve distributor_withoutReserve
    annotation (Placement(transformation(extent={{-146,-196},{118,-100}})));
  BaseClass.DistributeBus distributeBus_jn annotation (Placement(transformation(
          extent={{-110,46},{-102,58}}), iconTransformation(extent={{-110,46},{
            -102,58}})));
  BaseClass.DistributeBus distributeBus_cid annotation (Placement(
        transformation(extent={{110,80},{120,94}}), iconTransformation(extent={
            {110,80},{120,94}})));
  Fluid.Sensors.TemperatureTwoPort senTAirOutCID(redeclare package Medium =
        AixLib.Media.Air, m_flow_nominal=0.66) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={44,72})));
  Fluid.Sensors.TemperatureTwoPort senTAirOutJN(redeclare package Medium =
        AixLib.Media.Air, m_flow_nominal=2.64) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-96,62})));
equation
  connect(cca_PrescribedHeatFlow.port, cCA.heat_port_CCA)
    annotation (Line(points={{-25,52},{-25,40.76}}, color={191,0,0}));
  connect(hall1_heatflow.y, gainjn.u)
    annotation (Line(points={{-119,130},{-107.2,130}}, color={0,0,127}));
  connect(gainjn.y, Hall1.Q_flow) annotation (Line(points={{-93.4,130},{-84.4,
          130},{-84.4,98}}, color={0,0,127}));
  connect(cph_PrescribedHeatFlow.port,cPH.heat_port_CPH)  annotation (Line(
        points={{-171,24},{-171,-10},{-156.677,-10},{-156.677,-21}}, color={191,
          0,0}));
  connect(cid_heatflow.y, gaincid.u) annotation (Line(points={{45,132},{69,132},
          {69,115}},          color={0,0,127}));
  connect(Office.Q_flow, gaincid.y) annotation (Line(points={{67.6,98},{67.6,
          100},{69,100},{69,103.5}}, color={0,0,127}));
  connect(gaincca.y, cca_PrescribedHeatFlow.Q_flow)
    annotation (Line(points={{-25,73.5},{-25,70}}, color={0,0,127}));
  connect(gaincca.u, cca_heatflow.y)
    annotation (Line(points={{-25,85},{-25,108},{-33,108}}, color={0,0,127}));
  connect(CoolerInput.y[1], sup_c.T_in) annotation (Line(points={{155.4,-78},{
          150,-78},{150,-69.2},{144.4,-69.2}}, color={0,0,127}));
  connect(EHA.ports[1], ahu.port_b2)
    annotation (Line(points={{194,-24},{180,-24}}, color={0,127,255}));
  connect(ODA.ports[1], ahu.port_a1)
    annotation (Line(points={{194,-40},{180,-40}}, color={0,127,255}));
  connect(ret_c.ports[1], ahu.port_b4) annotation (Line(points={{128,-72},{
          129.182,-72},{129.182,-60}}, color={0,127,255}));
  connect(sup_c.ports[1], ahu.port_a4) annotation (Line(points={{140,-70},{137,
          -70},{137,-60}}, color={0,127,255}));
  connect(ahu.port_b1, cID.air_in) annotation (Line(points={{93.6091,-40},{74.4,
          -40},{74.4,18.2}}, color={0,127,255}));
  connect(ahu.port_b1, jN.air_in) annotation (Line(points={{93.6091,-40},{74,-40},
          {74,-12},{-81,-12},{-81,30}}, color={0,127,255}));
  connect(controlAHU.genericAHUBus, ahu.genericAHUBus) annotation (Line(
      points={{156,0.1},{137,0.1},{137,-15.8}},
      color={255,204,51},
      thickness=0.5));
  connect(Office.port_b, senRoomTemp.port_a)
    annotation (Line(points={{90,85},{90,72},{92,72}},
                                               color={0,127,255}));
  connect(senRoomTemp.port_b, ahu.port_a2) annotation (Line(points={{112,72},{
          112,-8},{93.6091,-8},{93.6091,-24}},            color={0,127,255}));
  connect(Hall1.port_b, senHallTemp.port_a) annotation (Line(points={{-62,85},{
          -62,82},{-54,82},{-54,70}}, color={0,127,255}));
  connect(senHallTemp.port_b, ahu.port_a2) annotation (Line(points={{-54,50},{
          -54,44},{8,44},{8,-16},{84,-16},{84,-24},{93.6091,-24}}, color={0,127,
          255}));
  connect(controlJN.distributeBus_JN, distributeBus_jn) annotation (Line(
      points={{-112.2,45.9},{-106,45.9},{-106,52}},
      color={255,204,51},
      thickness=0.5));
  connect(senHallTemp.T, distributeBus_jn.bus_jn.TempHall) annotation (Line(
        points={{-65,60},{-98,60},{-98,52.03},{-105.98,52.03}}, color={0,0,127}));
  connect(distributeBus_cid, controlCID.distributeBus_CID) annotation (Line(
      points={{115,87},{116,87},{116,58},{31.8667,58},{31.8667,38.6923}},
      color={255,204,51},
      thickness=0.5));
  connect(distributor_withoutReserve.jn_vl, jN.heating_water_in) annotation (
      Line(points={{-41.0519,-117.113},{-40,-117.113},{-40,-14},{-91.4,-14},{
          -91.4,30}},
                color={0,127,255}));
  connect(distributor_withoutReserve.jn_rl, jN.heating_water_out) annotation (
     Line(points={{-36.4889,-117.113},{-36.4889,-8},{-94.4,-8},{-94.4,30}},
        color={0,127,255}));
  connect(distributor_withoutReserve.cph_sup, cPH.cph_supprim) annotation (Line(
        points={{-16.2815,-116.696},{-16.2815,-94},{-164.431,-94},{-164.431,-56}},
        color={0,127,255}));
  connect(distributor_withoutReserve.cph_ret, cPH.cph_retprim) annotation (Line(
        points={{-12.0444,-116.696},{-12.0444,-90},{-150.215,-90},{-150.215,
          -56.25}},
        color={0,127,255}));
  connect(distributor_withoutReserve.cca_sup, cCA.cca_supprim) annotation (Line(
        points={{37.4963,-115.861},{36,-115.861},{36,-10},{-31.46,-10},{-31.46,
          2}}, color={0,127,255}));
  connect(distributor_withoutReserve.cca_ret, cCA.cca_retprim) annotation (Line(
        points={{42.0593,-116.278},{42.0593,-4},{-17.4,-4},{-17.4,2}}, color={0,
          127,255}));
  connect(distributor_withoutReserve.cid_sup, cID.cid_supprim) annotation (Line(
        points={{68.1333,-116.696},{68.1333,8},{60.4,8},{60.4,18.2}}, color={0,
          127,255}));
  connect(distributor_withoutReserve.cid_ret, cID.cid_retprim) annotation (Line(
        points={{74,-116.696},{74,-94},{66,-94},{66,6},{54.8,6},{54.8,18.2}},
        color={0,127,255}));
  connect(distributor_withoutReserve.rlt_ph_sup, ahu.port_a3) annotation (Line(
        points={{102.03,-140.487},{102.03,-142},{172,-142},{172,-66},{168.273,
          -66},{168.273,-60}},
                          color={0,127,255}));
  connect(distributor_withoutReserve.rlt_ph_ret, ahu.port_b3) annotation (Line(
        points={{102.03,-146.748},{102.03,-148},{172,-148},{172,-66},{160.455,
          -66},{160.455,-60}},
                          color={0,127,255}));
  connect(distributor_withoutReserve.rlt_h_sup, ahu.port_a5) annotation (Line(
        points={{101.704,-120.87},{120,-120.87},{120,-120},{121.364,-120},{
          121.364,-60}}, color={0,127,255}));
  connect(distributor_withoutReserve.rlt_h_ret, ahu.port_b5) annotation (Line(
        points={{102.03,-126.296},{102.03,-126},{113.936,-126},{113.936,-60}},
        color={0,127,255}));
  connect(jN.distributeBus_JN, controlJN.distributeBus_JN) annotation (Line(
      points={{-97.9,33.9},{-100,33.9},{-100,36},{-110,36},{-110,45.9},{-112.2,
          45.9}},
      color={255,204,51},
      thickness=0.5));
  connect(controlCPH.distributeBus_CPH, cPH.distributeBus_CPH) annotation (
      Line(
      points={{-194.2,-40.1},{-194.2,-37.875},{-178,-37.875}},
      color={255,204,51},
      thickness=0.5));
  connect(controlCCA.distributeBus_CCA, cCA.dB_CCA) annotation (Line(
      points={{-54.2,21.9},{-54.2,20.24},{-44.38,20.24}},
      color={255,204,51},
      thickness=0.5));
  connect(controlCID.distributeBus_CID, cID.distributeBus_CID) annotation (Line(
      points={{31.8667,38.6923},{32,38.6923},{32,40},{38,40},{38,30},{48.2,30},
          {48.2,30.59}},
      color={255,204,51},
      thickness=0.5));

  connect(senRoomTemp.T, distributeBus_cid.bus_cid.RoomTemp) annotation (Line(
        points={{102,83},{102,87.035},{115.025,87.035}}, color={0,0,127}));
  connect(ambientAir.y[1], ODA.T_in) annotation (Line(points={{221,-46},{204,
          -46},{204,-39.2},{198.4,-39.2}}, color={0,0,127}));
  connect(QFlowHall2.y[1], cph_PrescribedHeatFlow.Q_flow)
    annotation (Line(points={{-189,50},{-171,50},{-171,42}}, color={0,0,127}));
  connect(ambientAir.y[1], controlCCA.T_amb) annotation (Line(points={{221,-46},
          {204,-46},{204,16},{102,16},{102,12},{-4,12},{-4,-6},{-74,-6},{-74,22}},
                      color={0,0,127}));
  connect(senTAirOutCID.port_a, cID.air_out)
    annotation (Line(points={{44,62},{56,62},{56,43.4}}, color={0,127,255}));
  connect(senTAirOutCID.port_b, Office.port_a)
    annotation (Line(points={{44,82},{44,85},{62,85}}, color={0,127,255}));
  connect(senTAirOutJN.port_b, Hall1.port_a) annotation (Line(points={{-96,72},
          {-96,76},{-90,76},{-90,85}}, color={0,127,255}));
  connect(senTAirOutJN.port_a, jN.air_out) annotation (Line(points={{-96,52},{
          -96,47},{-95.6,47},{-95.6,42}}, color={0,127,255}));
  connect(ambientAir.y[1], controlCID.T_amb) annotation (Line(points={{221,-46},
          {204,-46},{204,16},{102,16},{102,12},{10,12},{10,38.7692},{19.2,
          38.7692}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-240,-220},{300,100}})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-240,-220},{300,100}})),
    experiment(StopTime=100000, __Dymola_Algorithm="Dassl"));
end Testhall_Hall_Office;
