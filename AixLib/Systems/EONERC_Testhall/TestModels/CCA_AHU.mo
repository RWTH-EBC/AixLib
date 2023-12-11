within AixLib.Systems.EONERC_Testhall.TestModels;
model CCA_AHU

  Fluid.Sources.Boundary_ph        EHA(redeclare package Medium = Media.Air,
      nPorts=1) "AirOut" annotation (Placement(transformation(
        extent={{-2,-2},{2,2}},
        rotation=180,
        origin={204,46})));
  Fluid.Sources.Boundary_pT            ODA(
    use_X_in=true,
    use_Xi_in=false,
    use_T_in=true,
    redeclare package Medium = AixLib.Media.Air,
    nPorts=1) "ODA"
    annotation (Placement(transformation(extent={{206,28},{202,32}})));
  Fluid.Sources.Boundary_pT        ret_c(
    redeclare package Medium = Media.Water,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{132,-4},{136,0}})));
  Fluid.Sources.Boundary_pT        sup_c(
    redeclare package Medium = Media.Water,
    p=115000,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{152,-2},{148,2}})));
    Modelica.Blocks.Sources.CombiTimeTable CoolerInput(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/DataBase/Cooler.txt"),
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    columns={2})
    annotation (Placement(transformation(extent={{176,-38},{164,-26}})));
  ModularAHU.GenericAHU                ahu(
    redeclare package Medium1 = Media.Air,
    redeclare package Medium2 = Media.Water,
    T_amb=288.15,
    m1_flow_nominal=3.7,
    m2_flow_nominal=2.3,
    usePreheater=true,
    useHumidifierRet=false,
    useHumidifier=false,
    preheater(
      hydraulicModuleIcon="Injection",
      m2_flow_nominal=0.3,
      redeclare HydraulicModules.Injection hydraulicModule(
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
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)))),
    cooler(
      hydraulicModuleIcon="Injection2WayValve",
      m2_flow_nominal=5,
      redeclare HydraulicModules.Injection2WayValve hydraulicModule(
        pipeModel="SimplePipe",
        length=1,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_6x1(),
        Kv=25,
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
          PumpInterface(pumpParam=
              AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN50_H05_16()))),
    heater(
      hydraulicModuleIcon="Admix",
      m2_flow_nominal=0.4,
      redeclare HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        Kv=10,
        valveCharacteristic=
            AixLib.Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
          PumpInterface(pumpParam=
              AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN25_H05_12()),
        pipe1(length=10),
        pipe2(length=0.6),
        pipe3(length=2),
        pipe4(length=5.5, fac=10),
        pipe5(length=10.4),
        pipe6(length=0.6))))
    annotation (Placement(transformation(extent={{188,10},{102,54}})));
  ModularAHU.Controller.CtrAHUBasic                controlAHU(
    TFlowSet=310.15,
    TFrostProtect=273.15 + 8,
    ctrPh(useExternalTMea=false, rpm_pump=2300),
    ctrRh(k=0.01, Ti=1000),
    VFlowSet=3.08,
    dpMax=5000,
    useTwoFanCtr=true,
    k=10)  annotation (Placement(transformation(extent={{184,60},{164,80}})));
  BaseClass.CID.CID_approx cid
    annotation (Placement(transformation(extent={{52,2},{72,22}})));
  Fluid.Sources.Boundary_pT                   bound_sup1(
    redeclare package Medium = AixLib.Media.Water,
    p=310000,
    use_T_in=true,
    nPorts=1)       annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={52,-18})));
  Fluid.Sources.Boundary_pT bound_ret1(redeclare package Medium =
        AixLib.Media.Water, nPorts=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={80,-18})));
  Fluid.Sources.Boundary_pT                   bound_sup2(
    redeclare package Medium = AixLib.Media.Water,
    p=310000,
    use_T_in=true,
    nPorts=1)       annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={88,-42})));
  Fluid.Sources.Boundary_pT bound_ret2(redeclare package Medium = Media.Water,
      nPorts=1)                       annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={116,-42})));
  Fluid.Sources.Boundary_pT                   bound_sup3(
    redeclare package Medium = AixLib.Media.Water,
    p=310000,
    use_T_in=true,
    nPorts=1)       annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={166,-56})));
  Fluid.Sources.Boundary_pT bound_ret3(redeclare package Medium =
        AixLib.Media.Water, nPorts=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={194,-56})));
  BaseClass.JetNozzle.JN_control_T_Hall jN_approxAirflow_2_1
    annotation (Placement(transformation(extent={{38,34},{58,54}})));
  ThermalZone.EON_ERC_Testhall eON_ERC_Testhall
    annotation (Placement(transformation(extent={{-40,30},{-8,60}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow thermalzone_intGains_rad(alpha=0)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-54,50})));
  Modelica.Blocks.Sources.Constant intGains_rad(k=0)
    annotation (Placement(transformation(extent={{-82,48},{-72,58}})));
  BaseClass.CCA.CCA cCA
    annotation (Placement(transformation(extent={{-104,18},{-82,38}})));
  Controller.ControlCCA controlCCA
    annotation (Placement(transformation(extent={{-138,20},{-120,34}})));
  Fluid.Sources.Boundary_pT                   bound_sup(
    redeclare package Medium = AixLib.Media.Water,
    p=310000,
    use_T_in=true,
    nPorts=1)       annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-108,-6})));
  Fluid.Sources.Boundary_pT bound_ret(redeclare package Medium =
        AixLib.Media.Water, nPorts=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={-80,-6})));
  Modelica.Blocks.Sources.Constant intGains_rad1(k=55 + 273.15)
    annotation (Placement(transformation(extent={{-140,-14},{-130,-4}})));
  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
      computeWetBulbTemperature=false, filNam=
        ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Systems/EONERC_Testhall/DataBase/Aachen_251022_251023.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-162,72},{-142,92}})));
  BoundaryConditions.WeatherData.Bus
      weaBus "Weather data bus" annotation (Placement(transformation(extent={{-134,76},
            {-122,88}}),         iconTransformation(extent={{190,-10},{210,10}})));
  Utilities.Psychrometrics.X_pTphi x_pTphi
    annotation (Placement(transformation(extent={{200,82},{220,102}})));
equation
  connect(CoolerInput.y[1],sup_c. T_in) annotation (Line(points={{163.4,-32},{
          156,-32},{156,0.8},{152.4,0.8}},     color={0,0,127}));
  connect(EHA.ports[1],ahu. port_b2)
    annotation (Line(points={{202,46},{188,46}},   color={0,127,255}));
  connect(ODA.ports[1],ahu. port_a1)
    annotation (Line(points={{202,30},{188,30}},   color={0,127,255}));
  connect(ret_c.ports[1],ahu. port_b4) annotation (Line(points={{136,-2},{
          137.182,-2},{137.182,10}},   color={0,127,255}));
  connect(sup_c.ports[1],ahu. port_a4) annotation (Line(points={{148,0},{145,0},
          {145,10}},       color={0,127,255}));
  connect(controlAHU.genericAHUBus,ahu. genericAHUBus) annotation (Line(
      points={{164,70.1},{145,70.1},{145,54.2}},
      color={255,204,51},
      thickness=0.5));
  connect(ahu.port_b1,cid. cid_sup_air) annotation (Line(points={{101.609,30},{
          90,30},{90,7.6},{71.8,7.6}},       color={0,127,255}));
  connect(ahu.port_a2,cid. cid_ret_air) annotation (Line(points={{101.609,46},{
          76,46},{76,15.2},{71.6,15.2}},     color={0,127,255}));
  connect(jN_approxAirflow_2_1.jn_ret_air, ahu.port_a2) annotation (Line(points={{57.6,
          47.2},{57.6,46},{101.609,46}},       color={0,127,255}));
  connect(ahu.port_b1, jN_approxAirflow_2_1.jn_sup_air) annotation (Line(points={{101.609,
          30},{64,30},{64,39.6},{57.8,39.6}},          color={0,127,255}));
  connect(intGains_rad.y,thermalzone_intGains_rad. Q_flow) annotation (Line(
        points={{-71.5,53},{-68,53},{-68,50},{-60,50}},
                                                    color={0,0,127}));
  connect(thermalzone_intGains_rad.port,eON_ERC_Testhall. intGainsRad_port)
    annotation (Line(points={{-48,50},{-48,48.6},{-39.68,48.6}},
                                                              color={191,0,0}));
  connect(controlCCA.distributeBus_CCA,cCA. dB_CCA) annotation (Line(
      points={{-124.292,26.93},{-124.292,27.6},{-104.22,27.6}},
      color={255,204,51},
      thickness=0.5));
  connect(cCA.heat_port_CCA,eON_ERC_Testhall. intGainsConv_port) annotation (
      Line(points={{-93,38.4},{-93,43.5},{-39.68,43.5}}, color={191,0,0}));
  connect(intGains_rad1.y,bound_sup. T_in) annotation (Line(points={{-129.5,-9},
          {-122.35,-9},{-122.35,-8.4},{-115.2,-8.4}},   color={0,0,127}));
  connect(weaDat.weaBus, eON_ERC_Testhall.weaBus) annotation (Line(
      points={{-142,82},{-44,82},{-44,54.6},{-39.68,54.6}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-142,82},{-128,82}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, controlCCA.T_amb) annotation (Line(
      points={{-128,82},{-128,38},{-142,38},{-142,27},{-138,27}},
      color={255,204,51},
      thickness=0.5));
  connect(intGains_rad1.y, bound_sup1.T_in) annotation (Line(points={{-129.5,-9},
          {-120,-9},{-120,-20.4},{44.8,-20.4}}, color={0,0,127}));
  connect(intGains_rad1.y, bound_sup2.T_in) annotation (Line(points={{-129.5,-9},
          {-120,-9},{-120,-20},{38,-20},{38,-44.4},{80.8,-44.4}}, color={0,0,127}));
  connect(intGains_rad1.y, bound_sup3.T_in) annotation (Line(points={{-129.5,-9},
          {-120,-9},{-120,-20},{38,-20},{38,-44},{74,-44},{74,-58.4},{158.8,-58.4}},
        color={0,0,127}));
  connect(jN_approxAirflow_2_1.jn_sup_thermalzone, eON_ERC_Testhall.ports[1])
    annotation (Line(points={{38,39},{38,38},{-2,38},{-2,24},{-25.56,24},{-25.56,
          31.2}}, color={0,127,255}));
  connect(jN_approxAirflow_2_1.jn_ret_thermalzone, eON_ERC_Testhall.ports[2])
    annotation (Line(points={{38,47.2},{38,46},{2,46},{2,38},{-2,38},{-2,24},{-21.8,
          24},{-21.8,31.2}}, color={0,127,255}));
  connect(x_pTphi.phi, weaBus.relHum) annotation (Line(points={{198,86},{-116,86},
          {-116,82},{-128,82}}, color={0,0,127}));
  connect(x_pTphi.p_in, weaBus.pAtm)
    annotation (Line(points={{198,98},{-128,98},{-128,82}}, color={0,0,127}));
  connect(x_pTphi.T, weaBus.TDryBul) annotation (Line(points={{198,92},{-118,92},
          {-118,82},{-128,82}}, color={0,0,127}));
  connect(ODA.T_in, weaBus.TDryBul) annotation (Line(points={{206.4,30.8},{222.2,
          30.8},{222.2,82},{-128,82}}, color={0,0,127}));
  connect(ODA.X_in, x_pTphi.X) annotation (Line(points={{206.4,29.2},{206.4,
          60.6},{221,60.6},{221,92}}, color={0,0,127}));
  connect(bound_sup.ports[1], cCA.cca_supprim) annotation (Line(points={{-102,
          -6},{-96.74,-6},{-96.74,18}}, color={0,127,255}));
  connect(bound_ret.ports[1], cCA.cca_retprim) annotation (Line(points={{-86,-6},
          {-86,-4},{-88.6,-4},{-88.6,18}}, color={0,127,255}));
  connect(bound_sup1.ports[1], cid.cid_sup_water) annotation (Line(points={{58,
          -18},{60.8,-18},{60.8,2.2}}, color={0,127,255}));
  connect(bound_ret1.ports[1], cid.cid_ret_water) annotation (Line(points={{74,
          -18},{64.4,-18},{64.4,2.2}}, color={0,127,255}));
  connect(bound_sup2.ports[1], ahu.port_a5) annotation (Line(points={{94,-42},{
          102,-42},{102,4},{129.364,4},{129.364,10}}, color={0,127,255}));
  connect(bound_ret2.ports[1], ahu.port_b5) annotation (Line(points={{110,-42},
          {104,-42},{104,4},{121.936,4},{121.936,10}}, color={0,127,255}));
  connect(bound_ret3.ports[1], ahu.port_b3) annotation (Line(points={{188,-56},
          {180,-56},{180,10},{168.455,10}}, color={0,127,255}));
  connect(bound_sup3.ports[1], ahu.port_a3) annotation (Line(points={{172,-56},
          {174,-56},{174,10},{176.273,10}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{140,
            140}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{
            140,140}})),
    experiment(
      StartTime=25660800,
      StopTime=28080000,
      Interval=3600,
      __Dymola_Algorithm="Dassl"));
end CCA_AHU;
