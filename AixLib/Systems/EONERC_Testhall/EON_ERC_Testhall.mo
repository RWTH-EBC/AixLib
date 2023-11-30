within AixLib.Systems.EONERC_Testhall;
model EON_ERC_Testhall

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
    annotation (Placement(transformation(extent={{-94,-30},{-56,8}})));
  BaseClass.CPH.CPH cPH
    annotation (Placement(transformation(extent={{-178,-56},{-136,-16}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow cph_heatFlow(alpha=0)
    annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=270,
        origin={-171,33})));

  Modelica.Blocks.Sources.CombiTimeTable ambientAir(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/DataBase/AmbientAir.txt"),
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{264,-82},{244,-62}})));

    Modelica.Blocks.Sources.CombiTimeTable CoolerInput(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/DataBase/Cooler.txt"),
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    columns={2})
    annotation (Placement(transformation(extent={{168,-108},{156,-96}})));

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
      m2_flow_nominal=0.3,
      redeclare AixLib.Systems.HydraulicModules.Injection hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        Kv=6.3,
        valveCharacteristic=AixLib.Fluid.Actuators.Valves.Data.LinearLinear(),
        pipe1(length=1.2),
        pipe2(length=0.1),
        pipe3(length=0.1),
        pipe4(length=2.3),
        pipe5(length=2, fac=10),
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
      hydraulicModuleIcon="Admix",
      m2_flow_nominal=0.4,
      redeclare AixLib.Systems.HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        Kv=10,
        valveCharacteristic=
            AixLib.Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
          PumpInterface(pumpParam=
              AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN25_H05_12()),
        pipe1(length=10),
        pipe2(length=0.6),
        pipe3(length=2),
        pipe4(length=5.5, fac=10),
        pipe5(length=10.4),
        pipe6(length=0.6))))
    annotation (Placement(transformation(extent={{180,-60},{94,-16}})));

  Modelica.Blocks.Sources.CombiTimeTable QFlowHall2(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/DataBase/QflowHall2.txt"),
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{-210,40},{-190,60}})));

  Controller.ControlCCA controlCCA
    annotation (Placement(transformation(extent={{-124,-20},{-98,0}})));
  Controller.ControlCPH controlCPH
    annotation (Placement(transformation(extent={{-214,-50},{-194,-30}})));
  AixLib.Systems.ModularAHU.Controller.CtrAHUBasic controlAHU(
    TFlowSet=310.15,
    TFrostProtect=273.15 + 8,
    ctrPh(useExternalTMea=false, rpm_pump=2300),
    ctrRh(k=0.01, Ti=1000),
    VFlowSet=3.08,
    dpMax=5000,
    useTwoFanCtr=true,
    k=10)  annotation (Placement(transformation(extent={{176,-10},{156,10}})));
  BaseClass.Distributor.Distributor_withoutReserve distributor
    annotation (Placement(transformation(extent={{-146,-200},{118,-110}})));
  BaseClass.CID.CID_ConsumerWater cid
    annotation (Placement(transformation(extent={{52,-64},{72,-44}})));
  BaseClass.JetNozzle.JN_approxAirflow jn
    annotation (Placement(transformation(extent={{22,-26},{42,-6}})));
  ThermalZone.EON_ERC_Testhall.EON_ERC_Testhall eON_ERC_Testhall
    annotation (Placement(transformation(extent={{-46,12},{-4,54}})));
equation
  connect(cph_heatFlow.port, cPH.heat_port_CPH) annotation (Line(points={{-171,24},
          {-171,-10},{-156.677,-10},{-156.677,-21}},     color={191,0,0}));
  connect(CoolerInput.y[1], sup_c.T_in) annotation (Line(points={{155.4,-102},{
          148,-102},{148,-69.2},{144.4,-69.2}},color={0,0,127}));
  connect(EHA.ports[1], ahu.port_b2)
    annotation (Line(points={{194,-24},{180,-24}}, color={0,127,255}));
  connect(ODA.ports[1], ahu.port_a1)
    annotation (Line(points={{194,-40},{180,-40}}, color={0,127,255}));
  connect(ret_c.ports[1], ahu.port_b4) annotation (Line(points={{128,-72},{
          129.182,-72},{129.182,-60}}, color={0,127,255}));
  connect(sup_c.ports[1], ahu.port_a4) annotation (Line(points={{140,-70},{137,
          -70},{137,-60}}, color={0,127,255}));
  connect(controlAHU.genericAHUBus, ahu.genericAHUBus) annotation (Line(
      points={{156,0.1},{137,0.1},{137,-15.8}},
      color={255,204,51},
      thickness=0.5));
  connect(distributor.cph_sup, cPH.cph_supprim) annotation (Line(points={{
          -16.2815,-125.652},{-16.2815,-94},{-164.431,-94},{-164.431,-56}},
        color={0,127,255}));
  connect(distributor.cph_ret, cPH.cph_retprim) annotation (Line(points={{
          -12.0444,-125.652},{-12.0444,-90},{-150.215,-90},{-150.215,-56.25}},
        color={0,127,255}));
  connect(distributor.cca_sup, cCA.cca_supprim) annotation (Line(points={{37.4963,
          -124.87},{-14,-124.87},{-14,-42},{-81.46,-42},{-81.46,-30}},
        color={0,127,255}));
  connect(distributor.cca_ret, cCA.cca_retprim) annotation (Line(points={{42.0593,
          -125.261},{42.0593,-36},{-67.4,-36},{-67.4,-30}},         color={0,
          127,255}));
  connect(distributor.rlt_ph_sup, ahu.port_a3) annotation (Line(points={{102.03,
          -147.957},{102.03,-142},{172,-142},{172,-66},{168.273,-66},{168.273,
          -60}}, color={0,127,255}));
  connect(distributor.rlt_ph_ret, ahu.port_b3) annotation (Line(points={{102.03,
          -153.826},{102.03,-148},{172,-148},{172,-66},{160.455,-66},{160.455,
          -60}}, color={0,127,255}));
  connect(distributor.rlt_h_sup, ahu.port_a5) annotation (Line(points={{101.704,
          -129.565},{122,-129.565},{122,-86},{121.364,-86},{121.364,-60}},
        color={0,127,255}));
  connect(distributor.rlt_h_ret, ahu.port_b5) annotation (Line(points={{102.03,
          -134.652},{102.03,-126},{113.936,-126},{113.936,-60}}, color={0,127,
          255}));
  connect(controlCPH.distributeBus_CPH, cPH.distributeBus_CPH) annotation (
      Line(
      points={{-194.2,-40.1},{-194.2,-37.875},{-178,-37.875}},
      color={255,204,51},
      thickness=0.5));
  connect(controlCCA.distributeBus_CCA, cCA.dB_CCA) annotation (Line(
      points={{-104.2,-10.1},{-104.2,-11.76},{-94.38,-11.76}},
      color={255,204,51},
      thickness=0.5));

  connect(ambientAir.y[1], ODA.T_in) annotation (Line(points={{243,-72},{236,
          -72},{236,-39.2},{198.4,-39.2}}, color={0,0,127}));
  connect(QFlowHall2.y[1], cph_heatFlow.Q_flow)
    annotation (Line(points={{-189,50},{-171,50},{-171,42}}, color={0,0,127}));
  connect(ambientAir.y[1], controlCCA.T_amb) annotation (Line(points={{243,-72},
          {236,-72},{236,-80},{-128,-80},{-128,-10},{-124.6,-10}},
                      color={0,0,127}));
  connect(ahu.port_b1, cid.cid_sup_air) annotation (Line(points={{93.6091,-40},
          {84,-40},{84,-58.4},{71.8,-58.4}}, color={0,127,255}));
  connect(ahu.port_a2, cid.cid_ret_air) annotation (Line(points={{93.6091,-24},
          {80,-24},{80,-50.8},{71.6,-50.8}}, color={0,127,255}));
  connect(distributor.cid_sup, cid.cid_sup_water) annotation (Line(points={{68.1333,
          -125.652},{68.1333,-63.8},{60.8,-63.8}},         color={0,127,255}));
  connect(distributor.cid_ret, cid.cid_ret_water) annotation (Line(points={{74,
          -125.652},{74,-63.8},{64.4,-63.8}}, color={0,127,255}));
  connect(ahu.port_b1, jn.jn_sup_air) annotation (Line(points={{93.6091,-40},{
          78,-40},{78,-36},{48,-36},{48,-20.4},{41.8,-20.4}}, color={0,127,255}));
  connect(ahu.port_a2, jn.jn_ret_air) annotation (Line(points={{93.6091,-24},{
          52,-24},{52,-12.8},{41.6,-12.8}}, color={0,127,255}));
  connect(ambientAir.y[1], controlCPH.T_amb) annotation (Line(points={{243,-72},
          {236,-72},{236,-80},{-128,-80},{-128,-62},{-222,-62},{-222,-40},{
          -214.4,-40}}, color={0,0,127}));
  connect(controlCPH.distributeBus_CPH, distributor.distributeBus_DHS)
    annotation (Line(
      points={{-194.2,-40.1},{-188,-40.1},{-188,-104},{-96.1333,-104},{-96.1333,
          -145.804}},
      color={255,204,51},
      thickness=0.5));
  connect(controlCCA.distributeBus_CCA, distributor.distributeBus_DHS)
    annotation (Line(
      points={{-104.2,-10.1},{-104.2,-78.05},{-96.1333,-78.05},{-96.1333,
          -145.804}},
      color={255,204,51},
      thickness=0.5));
  connect(cCA.heat_port_CCA, eON_ERC_Testhall.heat_port_Thermalzone)
    annotation (Line(points={{-75,8.76},{-75,27.12},{-41.38,27.12}}, color={191,
          0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-240,-220},{300,100}})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-240,-220},{300,100}})),
    experiment(StopTime=100000, __Dymola_Algorithm="Dassl"));
end EON_ERC_Testhall;
