within AixLib.Systems.EONERC_Testhall;
model EON_ERC_Testhall
  "Model of EON ERC Testhall including Monitoring Data and Weather Data from 25.Oct 2022 12am till 26.Oct 2023 12am"

  Fluid.Sources.Boundary_ph        EHA(redeclare package Medium = Media.Air,
      nPorts=1) "AirOut" annotation (Placement(transformation(
        extent={{-2,-2},{2,2}},
        rotation=180,
        origin={160,46})));
  Fluid.Sources.Boundary_pT            ODA(
    use_X_in=true,
    use_Xi_in=false,
    use_T_in=true,
    redeclare package Medium = AixLib.Media.Air,
    nPorts=1) "ODA"
    annotation (Placement(transformation(extent={{162,28},{158,32}})));
  Fluid.Sources.Boundary_pT        ret_c(
    redeclare package Medium = Media.Water,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{132,-4},{136,0}})));
  Fluid.Sources.Boundary_pT        sup_c(
    redeclare package Medium = Media.Water,
    p=115000,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{110,-4},{106,0}})));
    Modelica.Blocks.Sources.CombiTimeTable CoolerInput(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/DataBase/Cooler.txt"),
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    columns={2})
    annotation (Placement(transformation(extent={{92,-22},{104,-10}})));
  ModularAHU.GenericAHU                ahu(
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
      redeclare HydraulicModules.Injection hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        Kv=6.3,
        valveCharacteristic=AixLib.Fluid.Actuators.Valves.Data.LinearLinear(),
        pipe1(length=1.2),
        pipe2(length=0.1, nNodes=1),
        pipe3(length=0.1),
        pipe4(length=2.3),
        pipe5(
          length=2,
          fac=10,
          nNodes=1),
        pipe6(length=0.1),
        pipe7(length=1.3),
        pipe8(length=0.3),
        pipe9(length=0.3),
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per))),
      dynamicHX(nNodes=1)),
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
        pipe5(length=12, nNodes=1),
        pipe6(length=0.6)),
      dynamicHX(nNodes=1)))
    annotation (Placement(transformation(extent={{152,10},{66,54}})));
  ModularAHU.Controller.CtrAHUBasic                controlAHU(
    TFlowSet=310.15,
    TFrostProtect=273.15 + 8,
    ctrPh(
      useExternalTMea=false,
      k=0.001,
      rpm_pump=2300),
    ctrRh(k=0.01, Ti=1000),
    VFlowSet=3.08,
    dpMax=5000,
    useTwoFanCtr=true,
    k=10)  annotation (Placement(transformation(extent={{140,60},{120,80}})));
  BaseClass.CID.CID_approx cid
    annotation (Placement(transformation(extent={{32,-30},{52,-10}})));
  BaseClass.JetNozzle.JN_control_T_Hall jN
    annotation (Placement(transformation(extent={{16,30},{36,50}})));
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
  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
      computeWetBulbTemperature=false, filNam=
        ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Systems/EONERC_Testhall/DataBase/Aachen_251022_251023.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-162,72},{-142,92}})));
  BoundaryConditions.WeatherData.Bus
      weaBus "Weather data bus" annotation (Placement(transformation(extent={{-134,76},
            {-122,88}}),         iconTransformation(extent={{190,-10},{210,10}})));
  Utilities.Psychrometrics.X_pTphi x_pTphi
    annotation (Placement(transformation(extent={{114,92},{134,112}})));

  BaseClass.Distributor.Distributor_withoutReserve distributor_withoutReserve
    annotation (Placement(transformation(extent={{-106,-104},{76,-48}})));
  BaseClass.CPH.CPH cPH
    annotation (Placement(transformation(extent={{-52,-46},{-26,-14}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow cph_heatFlow(alpha=0)
    annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-65,-11})));
  Modelica.Blocks.Sources.CombiTimeTable QFlowHall2(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/DataBase/Hall2.txt"),
    columns=2:13,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    "12 - Qflow in W"
    annotation (Placement(transformation(extent={{-108,-20},{-88,0}})));
  Controller.ControlCPH controlCPH
    annotation (Placement(transformation(extent={{-96,-44},{-76,-24}})));
equation
  connect(CoolerInput.y[1],sup_c. T_in) annotation (Line(points={{104.6,-16},{
          112,-16},{112,-1.2},{110.4,-1.2}},   color={0,0,127}));
  connect(ODA.ports[1],ahu. port_a1)
    annotation (Line(points={{158,30},{152,30}},   color={0,127,255}));
  connect(ret_c.ports[1],ahu. port_b4) annotation (Line(points={{136,-2},{138,
          -2},{138,4},{101.182,4},{101.182,10}},
                                       color={0,127,255}));
  connect(sup_c.ports[1],ahu. port_a4) annotation (Line(points={{106,-2},{106,4},
          {109,4},{109,10}},
                           color={0,127,255}));
  connect(controlAHU.genericAHUBus,ahu. genericAHUBus) annotation (Line(
      points={{120,70.1},{109,70.1},{109,54.2}},
      color={255,204,51},
      thickness=0.5));
  connect(ahu.port_b1,cid. cid_sup_air) annotation (Line(points={{65.6091,30},{
          58,30},{58,-24.4},{51.8,-24.4}},   color={0,127,255}));
  connect(ahu.port_a2,cid. cid_ret_air) annotation (Line(points={{65.6091,46},{
          54,46},{54,42},{52,42},{52,-6},{56,-6},{56,-16.8},{51.6,-16.8}},
                                             color={0,127,255}));
  connect(jN.jn_ret_air, ahu.port_a2) annotation (Line(points={{35.6,43.2},{
          35.6,42},{54,42},{54,46},{65.6091,46}},
                                  color={0,127,255}));
  connect(ahu.port_b1, jN.jn_sup_air) annotation (Line(points={{65.6091,30},{42,
          30},{42,35.6},{35.8,35.6}}, color={0,127,255}));
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
  connect(jN.jn_sup_thermalzone, eON_ERC_Testhall.ports[1]) annotation (Line(
        points={{16,35},{16,34},{-2,34},{-2,26},{-25.56,26},{-25.56,31.2}},
        color={0,127,255}));
  connect(jN.jn_ret_thermalzone, eON_ERC_Testhall.ports[2]) annotation (Line(
        points={{16,43.2},{16,42},{2,42},{2,34},{-2,34},{-2,26},{-21.8,26},{
          -21.8,31.2}},
                  color={0,127,255}));
  connect(x_pTphi.phi, weaBus.relHum) annotation (Line(points={{112,96},{-128,
          96},{-128,82}},       color={0,0,127}));
  connect(x_pTphi.p_in, weaBus.pAtm)
    annotation (Line(points={{112,108},{-128,108},{-128,82}},
                                                            color={0,0,127}));
  connect(x_pTphi.T, weaBus.TDryBul) annotation (Line(points={{112,102},{-128,
          102},{-128,82}},      color={0,0,127}));
  connect(ODA.T_in, weaBus.TDryBul) annotation (Line(points={{162.4,30.8},{
          168.2,30.8},{168.2,82},{-128,82}},
                                       color={0,0,127}));
  connect(ODA.X_in, x_pTphi.X) annotation (Line(points={{162.4,29.2},{168,29.2},
          {168,102},{135,102}},       color={0,0,127}));
  connect(distributor_withoutReserve.cca_sup, cCA.cca_supprim) annotation (Line(
        points={{-20.1679,-57.7391},{-20.1679,12},{-96.74,12},{-96.74,18}},
        color={0,127,255}));
  connect(distributor_withoutReserve.cca_ret, cCA.cca_retprim) annotation (Line(
        points={{-16.5728,-57.7391},{-16.5728,12},{-88.6,12},{-88.6,18}}, color=
         {0,127,255}));
  connect(distributor_withoutReserve.cid_sup, cid.cid_sup_water) annotation (
      Line(points={{41.6222,-57.7391},{40.8,-57.7391},{40.8,-29.8}}, color={0,
          127,255}));
  connect(distributor_withoutReserve.cid_ret, cid.cid_ret_water) annotation (
      Line(points={{45.6667,-57.7391},{44.4,-57.7391},{44.4,-29.8}}, color={0,
          127,255}));
  connect(distributor_withoutReserve.rlt_h_sup, ahu.port_a5) annotation (Line(
        points={{64.7654,-60.1739},{64.7654,4},{93.3636,4},{93.3636,10}}, color=
         {0,127,255}));
  connect(distributor_withoutReserve.rlt_h_ret, ahu.port_b5) annotation (Line(
        points={{64.9901,-63.3391},{64.9901,-62},{85.9364,-62},{85.9364,10}},
        color={0,127,255}));
  connect(distributor_withoutReserve.rlt_ph_sup, ahu.port_a3) annotation (Line(
        points={{64.9901,-71.6174},{64.9901,-70},{120,-70},{120,-6},{128,-6},{
          128,-8},{140.273,-8},{140.273,10}}, color={0,127,255}));
  connect(ahu.port_b3, distributor_withoutReserve.rlt_ph_ret) annotation (Line(
        points={{132.455,10},{132.455,-75.2696},{64.9901,-75.2696}}, color={0,
          127,255}));
  connect(distributor_withoutReserve.cph_sup, cPH.cph_supprim) annotation (Line(
        points={{-36.7951,-57.7391},{-36,-57.7391},{-36,-58},{-38,-58},{-38,-52},
          {-43.6,-52},{-43.6,-46}}, color={0,127,255}));
  connect(distributor_withoutReserve.cph_ret, cPH.cph_retprim) annotation (Line(
        points={{-32.5259,-57.7391},{-32.5259,-54},{-34.8,-54},{-34.8,-46.2}},
        color={0,127,255}));
  connect(cph_heatFlow.port, cPH.heat_port_CPH) annotation (Line(points={{-56,-11},
          {-38.8,-11},{-38.8,-18}},                      color={191,0,0}));
  connect(QFlowHall2.y[12], cph_heatFlow.Q_flow) annotation (Line(points={{-87,
          -10},{-80.5,-10},{-80.5,-11},{-74,-11}}, color={0,0,127}));
  connect(controlCPH.distributeBus_CPH, cPH.distributeBus_CPH) annotation (Line(
      points={{-76.2,-34.1},{-76.2,-31.5},{-52,-31.5}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, controlCPH.T_amb) annotation (Line(
      points={{-128,82},{-128,38},{-142,38},{-142,-34},{-96.4,-34}},
      color={255,204,51},
      thickness=0.5));
  connect(ahu.port_b2, EHA.ports[1])
    annotation (Line(points={{152,46},{158,46}}, color={0,127,255}));
  connect(controlCPH.distributeBus_CPH, distributor_withoutReserve.distributeBus_DHS)
    annotation (Line(
      points={{-76.2,-34.1},{-71.6222,-34.1},{-71.6222,-70.2783}},
      color={255,204,51},
      thickness=0.5));
  connect(controlCCA.distributeBus_CCA, distributor_withoutReserve.distributeBus_DHS)
    annotation (Line(
      points={{-124.292,26.93},{-114,26.93},{-114,-50},{-71.6222,-50},{-71.6222,
          -70.2783}},
      color={255,204,51},
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-140},{180,
            140}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-140},{
            180,140}})),
    experiment(
      StartTime=1000000,
      StopTime=10000000,
      Interval=3600,
      __Dymola_Algorithm="Dassl"));
end EON_ERC_Testhall;
