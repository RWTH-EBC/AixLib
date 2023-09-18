within AixLib.Systems.EONERC_Testhall;
model Testhall_simpleConsumer

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
  BaseClass.Distributor.Distributor_withoutReserve distributor(redeclare
      package MediumWater = AixLib.Media.Water, redeclare package MediumAir =
        AixLib.Media.Air)
    annotation (Placement(transformation(extent={{-214,-216},{136,-120}})));
  BaseClass.JN.JN_simpel jN_TestBlock
    annotation (Placement(transformation(extent={{-104,26},{-72,46}})));
      AixLib.Systems.HydraulicModules.SimpleConsumer               Hall1(
    redeclare package Medium = AixLib.Media.Air,
    V=1e3,
    m_flow_nominal=3,
    T_start=291.15,
    functionality="Q_flow_input") "Thermal zone"
    annotation (Placement(transformation(extent={{-90,70},{-62,96}})));
      AixLib.Systems.HydraulicModules.SimpleConsumer Office(
    redeclare package Medium = AixLib.Media.Air,
    V=1e3,
    m_flow_nominal=0.8,
    T_start=291.15,
    functionality="Q_flow_input") "Thermal zone"
    annotation (Placement(transformation(extent={{62,72},{90,98}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow cca_PrescribedHeatFlow(alpha=0)
    annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=270,
        origin={-25,61})));
  Modelica.Blocks.Sources.TimeTable cca_heatflow(table=[0,2; 1382400,3.4;
        3888000,13.6; 6480000,17; 9072000,27; 11664000,13.6; 14256000,11;
        16848000,-6.8])
    "4 typische Heizbedarfe (2 Winter, 2 Sommer) je einen Tag lang"
    annotation (Placement(transformation(extent={{-54,98},{-34,118}})));
  Modelica.Blocks.Sources.TimeTable hall1_heatflow(table=[0,15.4; 1382400,35.86;
        3888000,22.44; 6480000,16.06; 9072000,16.28; 11664000,21.56; 14256000,9.9;
        16848000,0]) "Values for November till May"
    annotation (Placement(transformation(extent={{-140,120},{-120,140}})));
  Modelica.Blocks.Math.Gain gainjn(k=-1000)
    annotation (Placement(transformation(extent={{-106,124},{-94,136}})));
  Modelica.Blocks.Sources.TimeTable cid_heatflow(table=[0,4.5; 1382400,9;
        3888000,8.5; 6480000,7.9; 9072000,10.45; 11664000,8.3; 14256000,5;
        16848000,0.25])
    "Values for November till May"
    annotation (Placement(transformation(extent={{36,112},{56,132}})));
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
  Modelica.Blocks.Sources.CombiTimeTable roomTemp(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Systems/EONERC_Testhall/DataBase/RoomTemperatureNovtoMay.txt"),
    columns=2:9,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    "1-Office1,...5-Office5,6-Hall1,7-Hall2,8-AmbTemp"
    annotation (Placement(transformation(extent={{242,-56},{222,-36}})));

    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://Testhall/AnnahmenPlausibility/DataBase/txt/CoolerInput.txt"),
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
      redeclare AixLib.Systems.HydraulicModules.Injection hydraulicModule(
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
              AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN50() "Replace with AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN50_H05_16()"))),
    heater(
      hydraulicModuleIcon="Injection2WayValve",
      m2_flow_nominal=1.2,
      redeclare AixLib.Systems.HydraulicModules.Injection2WayValve
        hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        Kv=10,
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
          PumpInterface(pumpParam=
              AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN25_H1_8_V9() "Replace with AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN25_H05_12"),
        pipe1(length=10),
        pipe2(length=0.6),
        pipe3(length=2),
        pipe4(length=5.5),
        pipe5(length=0.4),
        pipe6(length=10),
        pipe7(length=0.6))))
    annotation (Placement(transformation(extent={{180,-60},{94,-16}})));
  Modelica.Blocks.Sources.CombiTimeTable HeatFlowHall2(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Systems/EONERC_Testhall/DataBase/HeatFlowNovtoMay.txt"),
    columns={11},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{-222,68},{-202,88}})));

  Modelica.Blocks.Math.Gain gaincph(k=-1000)
    annotation (Placement(transformation(extent={{-192,72},{-180,84}})));
  Controller.ControlCPH controlCPH
    annotation (Placement(transformation(extent={{-222,-52},{-202,-32}})));
  Controller.ControlCID controlCID
    annotation (Placement(transformation(extent={{14,30},{34,50}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                                   senRoomTemp(redeclare package Medium =
        AixLib.Media.Air, m_flow_nominal=0.8)
    annotation (Placement(transformation(extent={{90,64},{110,84}})));
  BaseClass.DistributeBus dB_CID annotation (Placement(transformation(extent={{
            110,90},{120,102}}), iconTransformation(extent={{96,26},{136,66}})));
  Controller.ControlCCA           controlCCA
    annotation (Placement(transformation(extent={{-74,12},{-48,32}})));
  AixLib.Systems.ModularAHU.Controller.CtrAHUBasic controlAHU(
    TFlowSet=310.15,
    ctrPh(rpm_pump=2300),
    ctrRh(k=0.015),
    VFlowSet=3.08,
    dpMax=2000,
    useTwoFanCtr=true,
    k=0.8) annotation (Placement(transformation(extent={{170,-10},{150,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senHallTemp(redeclare package Medium =
        AixLib.Media.Air, m_flow_nominal=3) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-54,60})));
  Controller.ControlJN controlJN
    annotation (Placement(transformation(extent={{-126,24},{-106,44}})));
  BaseClass.DistributeBus dB_JN annotation (Placement(transformation(extent={{
            -112,42},{-102,54}}), iconTransformation(extent={{96,26},{136,66}})));
equation
  connect(cID.air_out, Office.port_a)
    annotation (Line(points={{56,43.4},{56,85},{62,85}}, color={0,127,255}));
  connect(jN_TestBlock.heating_air_hall1, Hall1.port_a) annotation (Line(points=
         {{-95.6,42},{-96,42},{-96,83},{-90,83}}, color={0,127,255}));
  connect(cca_PrescribedHeatFlow.port, cCA.heat_port_CCA)
    annotation (Line(points={{-25,52},{-25,40.76}}, color={191,0,0}));
  connect(hall1_heatflow.y, gainjn.u)
    annotation (Line(points={{-119,130},{-107.2,130}}, color={0,0,127}));
  connect(gainjn.y, Hall1.Q_flow) annotation (Line(points={{-93.4,130},{-84.4,
          130},{-84.4,96}}, color={0,0,127}));
  connect(cph_PrescribedHeatFlow.port,cPH.heat_port_CPH)  annotation (Line(
        points={{-171,24},{-171,-10},{-156.677,-10},{-156.677,-21}}, color={191,
          0,0}));
  connect(cid_heatflow.y, gaincid.u) annotation (Line(points={{57,122},{70,122},
          {70,115},{69,115}}, color={0,0,127}));
  connect(Office.Q_flow, gaincid.y) annotation (Line(points={{67.6,98},{67.6,
          100},{69,100},{69,103.5}}, color={0,0,127}));
  connect(gaincca.y, cca_PrescribedHeatFlow.Q_flow)
    annotation (Line(points={{-25,73.5},{-25,70}}, color={0,0,127}));
  connect(gaincca.u, cca_heatflow.y)
    annotation (Line(points={{-25,85},{-25,108},{-33,108}}, color={0,0,127}));
  connect(roomTemp.y[8], ODA.T_in) annotation (Line(points={{221,-46},{204,-46},
          {204,-39.2},{198.4,-39.2}},                      color={0,0,127}));
  connect(combiTimeTable.y[1], sup_c.T_in) annotation (Line(points={{155.4,-78},
          {150,-78},{150,-69.2},{144.4,-69.2}}, color={0,0,127}));
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
  connect(ahu.port_b1, jN_TestBlock.air_RLT_SUP) annotation (Line(points={{
          93.6091,-40},{74,-40},{74,-12},{-81,-12},{-81,30}}, color={0,127,255}));
  connect(ahu.port_b5, distributor.rlt_h_rl) annotation (Line(points={{113.936,
          -60},{112,-60},{112,-114},{122,-114},{122,-146.296},{114.827,-146.296}},
        color={0,127,255}));
  connect(distributor.rlt_h_vl, ahu.port_a5) annotation (Line(points={{114.395,
          -140.87},{114.395,-140},{121.364,-140},{121.364,-60}}, color={0,127,
          255}));
  connect(distributor.rlt_ph_rl, ahu.port_b3) annotation (Line(points={{114.827,
          -166.748},{170,-166.748},{170,-66},{160.455,-66},{160.455,-60}},
        color={0,127,255}));
  connect(distributor.rlt_ph_vl, ahu.port_a3) annotation (Line(points={{114.827,
          -160.487},{170,-160.487},{170,-66},{168.273,-66},{168.273,-60}},
        color={0,127,255}));
  connect(HeatFlowHall2.y[1], gaincph.u)
    annotation (Line(points={{-201,78},{-193.2,78}}, color={0,0,127}));
  connect(gaincph.y, cph_PrescribedHeatFlow.Q_flow) annotation (Line(points={{-179.4,
          78},{-171,78},{-171,42}}, color={0,0,127}));
  connect(controlCPH.distributeBus_CPH, cPH.distributeBus_CPH) annotation (Line(
      points={{-202.2,-42.1},{-186,-42.1},{-186,-37.875},{-178,-37.875}},
      color={255,204,51},
      thickness=0.5));
  connect(distributor.cph_vl, cPH.cph_supprim) annotation (Line(points={{
          -42.0247,-136.696},{-42.0247,-106},{-164.431,-106},{-164.431,-56}},
        color={0,127,255}));
  connect(distributor.cph_rl, cPH.cph_retprim) annotation (Line(points={{
          -36.4074,-136.696},{-36.4074,-114},{-150.215,-114},{-150.215,-56.25}},
        color={0,127,255}));
  connect(distributor.jn_vl, jN_TestBlock.heating_water_in) annotation (Line(
        points={{-74.8642,-137.113},{-74.8642,8},{-91.4,8},{-91.4,30}}, color={
          0,127,255}));
  connect(controlCID.distributeBus_CID, cID.distributeBus_CID) annotation (Line(
      points={{33.8,39.9},{44,39.9},{44,30.59},{48.2,30.59}},
      color={255,204,51},
      thickness=0.5));
  connect(distributor.jn_rl, jN_TestBlock.heating_water_out) annotation (Line(
        points={{-68.8148,-137.113},{-68.8148,8},{-82,8},{-82,6},{-94.4,6},{
          -94.4,30}}, color={0,127,255}));
  connect(distributor.cca_rl, cCA.cca_retprim) annotation (Line(points={{35.321,
          -136.278},{34,-136.278},{34,-4},{-17.4,-4},{-17.4,2}}, color={0,127,
          255}));
  connect(distributor.cca_vl, cCA.cca_supprim) annotation (Line(points={{29.2716,
          -135.861},{28,-135.861},{28,-4},{-31.46,-4},{-31.46,2}},
        color={0,127,255}));
  connect(distributor.cid_rl, cID.cid_retprim) annotation (Line(points={{77.6667,
          -136.696},{76,-136.696},{76,12},{54.8,12},{54.8,18.2}},         color=
         {0,127,255}));
  connect(cID.cid_supprim, distributor.cid_vl) annotation (Line(points={{60.4,
          18.2},{60.4,-114},{69.8889,-114},{69.8889,-136.696}}, color={0,127,
          255}));
  connect(dB_CID, controlCID.distributeBus_CID) annotation (Line(
      points={{115,96},{114,96},{114,39.9},{33.8,39.9}},
      color={255,204,51},
      thickness=0.5));
  connect(senRoomTemp.T, dB_CID.control_cid.RoomTemp) annotation (Line(points={{100,85},
          {100,108},{115.025,108},{115.025,96.03}},
                                                 color={0,0,127}));
  connect(controlCCA.distributeBus_CCA, cCA.dB_CCA) annotation (Line(
      points={{-54.2,21.9},{-54.2,20.24},{-44.38,20.24}},
      color={255,204,51},
      thickness=0.5));
  connect(controlAHU.genericAHUBus, ahu.genericAHUBus) annotation (Line(
      points={{150,0.1},{137,0.1},{137,-15.8}},
      color={255,204,51},
      thickness=0.5));
  connect(Office.port_b, senRoomTemp.port_a)
    annotation (Line(points={{90,85},{90,74}}, color={0,127,255}));
  connect(senRoomTemp.port_b, ahu.port_a2) annotation (Line(points={{110,74},{
          112,74},{112,-8},{93.6091,-8},{93.6091,-24}},   color={0,127,255}));
  connect(Hall1.port_b, senHallTemp.port_a) annotation (Line(points={{-62,83},{
          -62,82},{-54,82},{-54,70}}, color={0,127,255}));
  connect(senHallTemp.port_b, ahu.port_a2) annotation (Line(points={{-54,50},{
          -54,44},{8,44},{8,-16},{84,-16},{84,-24},{93.6091,-24}}, color={0,127,
          255}));
  connect(controlJN.distributeBus_JN, jN_TestBlock.distributeBus_JN)
    annotation (Line(
      points={{-106.2,33.9},{-97.9,33.9}},
      color={255,204,51},
      thickness=0.5));
  connect(dB_JN, controlJN.distributeBus_JN) annotation (Line(
      points={{-107,48},{-107,40.95},{-106.2,40.95},{-106.2,33.9}},
      color={255,204,51},
      thickness=0.5));
  connect(senHallTemp.T, dB_JN.bus_jn.TempHall) annotation (Line(points={{-65,
          60},{-106.975,60},{-106.975,48.03}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-240,-220},{300,100}})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-240,-220},{300,100}})),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=200,
      __Dymola_Algorithm="Dassl"));
end Testhall_simpleConsumer;
