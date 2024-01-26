within AixLib.Systems.EONERC_Testhall;
model EON_ERC_Testhall
  "Model of EON ERC Testhall including Monitoring Data and Weather Data from 25.Oct 2022 12am till 26.Oct 2023 12am"

  Fluid.Sources.Boundary_ph        EHA(redeclare package Medium = Media.Air,
      nPorts=1) "AirOut" annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={173,23})));
  Fluid.Sources.Boundary_pT            ODA(
    use_X_in=true,
    use_Xi_in=false,
    use_T_in=true,
    redeclare package Medium = AixLib.Media.Air,
    nPorts=1) "ODA"
    annotation (Placement(transformation(extent={{176,-32},{166,-22}})));
  Fluid.Sources.Boundary_pT        sup_c(
    redeclare package Medium = Media.Water,
    p=115000,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{5,-5},{-5,5}},
        rotation=270,
        origin={126,-47})));
    Modelica.Blocks.Sources.CombiTimeTable CoolerInput(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/DataBase/Cooler.txt"),
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    columns={2})
    annotation (Placement(transformation(extent={{144,-62},{134,-52}})));
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
    annotation (Placement(transformation(extent={{160,-22},{80,18}})));
  Subsystems.CeilingInjectionDiffusor.CIDSystem_approx cid
    annotation (Placement(transformation(extent={{28,-44},{48,-24}})));
  Subsystems.JetNozzle.JN jN
    annotation (Placement(transformation(extent={{60,-2},{40,18}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow thermalzone_intGains_rad(alpha=0)
    annotation (Placement(transformation(
        extent={{5,-5},{-5,5}},
        rotation=0,
        origin={37,65})));
  Modelica.Blocks.Sources.Constant intGains_rad(k=0)
    annotation (Placement(transformation(extent={{64,60},{54,70}})));
  Subsystems.ConcreteCoreActivation.CCASystem cCA(
    injection(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_54x1(),
        PumpInterface(pumpParam=
            AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN50_H1_10(
            maxMinHeight=[0.00,10.26,0.900; 0.38,10.32,0.909; 0.76,10.37,0.918;
            1.14,10.43,0.928; 1.52,10.49,0.937; 1.90,10.55,0.946; 2.28,10.60,
            0.850; 2.66,10.64,0.712; 3.03,10.68,0.574; 3.41,10.44,0.435; 3.79,
            9.96,0.297; 4.17,9.46,0.000; 4.55,8.95,0.000; 4.93,8.44,0.000; 5.31,
            7.94,0.000; 5.69,7.47,0.000; 6.07,7.01,0.000; 6.45,6.58,0.000; 6.83,
            6.15,0.000; 7.21,5.74,0.000; 7.59,5.34,0.000; 7.97,4.94,0.000; 8.34,
            4.48,0.000; 8.72,4.00,0.000; 9.10,3.54,0.000; 9.48,3.08,0.000; 9.86,
            2.63,0.000; 10.24,2.11,0.000; 10.62,1.55,0.000; 11.00,1.00,0.000]))),

    concreteCoreActivation(alpha=10, pipe(parameterPipe=
            AixLib.DataBase.Pipes.Copper.Copper_35x1(), length=35)),
    m_flow_nominal=2,
    T_start_hydraulic=323.15,
    T_start=293.15)
    annotation (Placement(transformation(extent={{-10,-2},{10,18}})));
  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
      computeWetBulbTemperature=false, filNam=
        ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Systems/EONERC_Testhall/DataBase/Aachen_251022_251023.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-120,58},{-100,78}})));
  BoundaryConditions.WeatherData.Bus
      weaBus "Weather data bus" annotation (Placement(transformation(extent={{-10,90},
            {10,110}}),          iconTransformation(extent={{-20,80},{20,120}})));
  Utilities.Psychrometrics.X_pTphi x_pTphi
    annotation (Placement(transformation(extent={{140,58},{160,78}})));

  Subsystems.DistrictHeatingStation.DHS_substation dhs(m_flow_nominal=3)
    annotation (Placement(transformation(extent={{-42,-88},{0,-62}})));
  Subsystems.CeilingPanelHeaters.CPHSystem cPH(
    m_flow_nominal=0.2,
    radiantCeilingPanelHeater(genericPipe(parameterPipe=
            AixLib.DataBase.Pipes.Copper.Copper_22x1())),
    cph_Valve(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1()),
    cph_Throttle(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_22x1()))
    annotation (Placement(transformation(extent={{-82,-42},{-62,-8}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow cph_heatFlow(alpha=0)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,8})));
  Modelica.Blocks.Sources.CombiTimeTable QFlowHall2(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/DataBase/Hall2.txt"),
    columns=2:13,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    "12 - Qflow in W"
    annotation (Placement(transformation(extent={{-130,-2},{-110,18}})));
  Controller controller(controlAHU(ctrPh(k=0.005), ctrRh(Ti=500)))
    annotation (Placement(transformation(extent={{-130,-90},{-110,-70}})));
ThermalZones.ReducedOrder.ThermalZone.ThermalZone testhall(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    internalGainsMode=1,
    use_C_flow=false,
    use_moisture_balance=false,
    redeclare package Medium = AixLib.Media.Air,
    redeclare
      ThermalZone.TeaserOutput.EON_ERC_Testhall.EON_ERC_Testhall_DataBase.EON_ERC_Testhall_Hall1
      zoneParam(
      T_start=288.15,
      AExt={95.91,389.64,711.0,629.0,389.64},
      specificPeople=0.01,
      activityDegree=1,
      fixedHeatFlowRatePersons=40,
      ratioConvectiveHeatPeople=0.2,
      internalGainsMachinesSpecific=1,
      lightingPowerSpecific=0.2,
      HeaterOn=false),
    redeclare model corG =
        ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
    use_MechanicalAirExchange=false,
    use_NaturalAirExchange=false,
    nPorts=2) "ThermalZone of Testhall"
    annotation (Placement(transformation(extent={{-20,38},{20,78}})));
  Modelica.Blocks.Sources.CombiTimeTable tableInternalGains(
    tableOnFile=true,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="Internals",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Systems/EONERC_Testhall/ThermalZone/TeaserOutput/EON_ERC_Testhall/InternalGains_EON_ERC_Testhall.txt"),
    columns=2:4)
    "Profiles for internal gains"
    annotation (Placement(transformation(extent={{-30,22},{-20,32}})));

  Fluid.Sources.Boundary_pT        ret_c(
    redeclare package Medium = Media.Water,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{-5,-5},{5,5}},
        rotation=90,
        origin={109,-47})));
  Subsystems.BaseClasses.Interfaces.MainBus mainBus annotation (Placement(
        transformation(extent={{-30,-44},{-10,-24}}),
                                                   iconTransformation(extent={{-20,
            -120},{20,-80}})));
  Subsystems.BaseClasses.Interfaces.ZoneBus zoneBus annotation (Placement(
        transformation(extent={{80,60},{100,80}}), iconTransformation(extent={{-264,
            4},{-224,44}})));
  Modelica.Blocks.Sources.CombiTimeTable Office_RoomTemp(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Systems/EONERC_Testhall/DataBase/Office_Hall_Temp.txt"),
    columns=2:8,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    y(unit "K"))
    annotation (Placement(transformation(extent={{50,40},{60,50}})));

  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_mea(unit="K")
    "Connector of Real output signals" annotation (Placement(transformation(
          extent={{72,40},{82,50}}), iconTransformation(extent={{62,36},{82,56}})));

equation
  connect(CoolerInput.y[1],sup_c. T_in) annotation (Line(points={{133.5,-57},{128,
          -57},{128,-53}},                     color={0,0,127}));
  connect(ODA.ports[1],ahu. port_a1)
    annotation (Line(points={{166,-27},{166,-28},{164,-28},{164,-4},{162,-4},{162,
          -3.81818},{160,-3.81818}},               color={0,127,255}));
  connect(ret_c.ports[1],ahu. port_b4) annotation (Line(points={{109,-42},{108,
          -42},{108,-36},{112.727,-36},{112.727,-22}},
                                       color={0,127,255}));
  connect(sup_c.ports[1],ahu. port_a4) annotation (Line(points={{126,-42},{126,-36},
          {120,-36},{120,-22}},
                           color={0,127,255}));
  connect(ahu.port_b1, cid.port_a1) annotation (Line(points={{79.6364,-3.81818},
          {74,-3.81818},{74,-4},{70,-4},{70,-14},{34,-14},{34,-24}},
                                                                 color={0,127,
          255}));
  connect(ahu.port_a2, cid.port_b1) annotation (Line(points={{79.6364,10.7273},
          {66,10.7273},{66,-14},{42,-14},{42,-24}},
                                               color={0,127,255}));
  connect(jN.port_b2, ahu.port_a2) annotation (Line(points={{60,13},{60,14},{66,
          14},{66,10.7273},{79.6364,10.7273}}, color={0,127,255}));
  connect(ahu.port_b1, jN.port_a1) annotation (Line(points={{79.6364,-3.81818},
          {74,-3.81818},{74,-4},{70,-4},{70,3},{60,3}}, color={0,127,255}));
  connect(intGains_rad.y,thermalzone_intGains_rad. Q_flow) annotation (Line(
        points={{53.5,65},{42,65}},                 color={0,0,127}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-100,68},{-66,68},{-66,100},{0,100}},
      color={255,204,51},
      thickness=0.5));
  connect(x_pTphi.phi, weaBus.relHum) annotation (Line(points={{138,62},{120,62},
          {120,100},{0,100}},   color={0,0,127}));
  connect(x_pTphi.p_in, weaBus.pAtm)
    annotation (Line(points={{138,74},{120,74},{120,100},{0,100}},
                                                            color={0,0,127}));
  connect(x_pTphi.T, weaBus.TDryBul) annotation (Line(points={{138,68},{120,68},
          {120,100},{0,100}},   color={0,0,127}));
  connect(ODA.T_in, weaBus.TDryBul) annotation (Line(points={{177,-25},{180,-25},
          {180,100},{0,100}},          color={0,0,127}));
  connect(ODA.X_in, x_pTphi.X) annotation (Line(points={{177,-29},{180,-29},{180,
          68},{161,68}},              color={0,0,127}));
  connect(cph_heatFlow.port, cPH.heat_port_CPH) annotation (Line(points={{-80,8},
          {-72,8},{-72,-8}},                             color={191,0,0}));
  connect(QFlowHall2.y[12], cph_heatFlow.Q_flow) annotation (Line(points={{-109,8},
          {-100,8}},                               color={0,0,127}));
  connect(weaBus.TDryBul,controller. T_amb) annotation (Line(
      points={{0,100},{-66,100},{-66,38},{-140,38},{-140,-80},{-132,-80}},
      color={255,204,51},
      thickness=0.5));
  connect(ahu.port_b2, EHA.ports[1])
    annotation (Line(points={{160,10.7273},{160,12},{164,12},{164,23},{168,23}},
                                                 color={0,127,255}));
  connect(dhs.port_b, cid.port_a2) annotation (Line(points={{-0.2625,-65.9},{34,
          -65.9},{34,-44}}, color={0,127,255}));
  connect(dhs.port_a, cid.port_b2) annotation (Line(points={{-0.2625,-84.1},{-0.2625,
          -84},{42,-84},{42,-44}}, color={0,127,255}));
  connect(dhs.port_b, ahu.port_a5) annotation (Line(points={{-0.2625,-65.9},{
          100,-65.9},{100,-32},{106,-32},{106,-22},{105.455,-22}},
                                                               color={0,127,255}));
  connect(dhs.port_a, ahu.port_b5) annotation (Line(points={{-0.2625,-84.1},{98,
          -84.1},{98,-22},{98.5455,-22}}, color={0,127,255}));
  connect(dhs.port_a, ahu.port_b3) annotation (Line(points={{-0.2625,-84.1},{
          146,-84.1},{146,-42},{140,-42},{140,-22},{141.818,-22}},
                                                               color={0,127,255}));
  connect(dhs.port_b, ahu.port_a3) annotation (Line(points={{-0.2625,-65.9},{
          150,-65.9},{150,-22},{149.091,-22}},
                                           color={0,127,255}));
  connect(dhs.port_b, cPH.port_a) annotation (Line(points={{-0.2625,-65.9},{14,-65.9},
          {14,-50},{-76,-50},{-76,-42},{-77,-42}}, color={0,127,255}));
  connect(dhs.port_a, cPH.port_b) annotation (Line(points={{-0.2625,-84.1},{10,-84.1},
          {10,-54},{-67,-54},{-67,-42}}, color={0,127,255}));
  connect(dhs.port_b, cCA.port_a) annotation (Line(points={{-0.2625,-65.9},{2,-65.9},
          {2,-42},{-3,-42},{-3,-2}}, color={0,127,255}));
  connect(cCA.port_b, dhs.port_a) annotation (Line(points={{3,-2.2},{4,-2.2},{4,
          -84.1},{-0.2625,-84.1}}, color={0,127,255}));
  connect(tableInternalGains.y, testhall.intGains)
    annotation (Line(points={{-19.5,27},{16,27},{16,41.2}},
                                                          color={0,0,127}));
  connect(jN.port_a2, testhall.ports[1]) annotation (Line(points={{40,13},{34,13},
          {34,30},{2,30},{2,43.6},{-2.35,43.6}},      color={0,127,255}));
  connect(jN.port_b1, testhall.ports[2]) annotation (Line(points={{40,3},{26,3},
          {26,22},{-2,22},{-2,43.6},{2.35,43.6}},          color={0,127,255}));
  connect(thermalzone_intGains_rad.port, testhall.intGainsRad)
    annotation (Line(points={{32,65},{32,64.8},{20.4,64.8}},color={191,0,0}));
  connect(cCA.heat_port_CCA, testhall.intGainsConv) annotation (Line(points={{0,18},{
          0,32},{32,32},{32,60},{20.4,60},{20.4,58.8}},      color={191,0,0}));
  connect(weaBus, testhall.weaBus) annotation (Line(
      points={{0,100},{-40,100},{-40,70},{-20,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(controller.mainBus, mainBus) annotation (Line(
      points={{-110,-80},{-106,-80},{-106,-56},{-32,-56},{-32,-34},{-20,-34}},
      color={255,204,51},
      thickness=0.5));
  connect(dhs.dhsBus, mainBus.bus_dhs) annotation (Line(
      points={{-21,-62},{-21,-33.95},{-19.95,-33.95}},
      color={255,204,51},
      thickness=0.5));
  connect(cPH.cphBus, mainBus.bus_cph) annotation (Line(
      points={{-82,-24.8786},{-90,-24.8786},{-90,-56},{-32,-56},{-32,-33.95},{
          -19.95,-33.95}},
      color={255,204,51},
      thickness=0.5));
  connect(cCA.ccaBus, mainBus.bus_cca) annotation (Line(
      points={{-10,8},{-19.95,8},{-19.95,-33.95}},
      color={255,204,51},
      thickness=0.5));
  connect(cid.cIDBus, mainBus.bus_cid) annotation (Line(
      points={{28,-34},{16,-34},{16,-33.95},{-19.95,-33.95}},
      color={255,204,51},
      thickness=0.5));
  connect(jN.jNBus, mainBus.bus_jn) annotation (Line(
      points={{50,18},{50,24},{20,24},{20,-33.95},{-19.95,-33.95}},
      color={255,204,51},
      thickness=0.5));
  connect(ahu.genericAHUBus, mainBus.bus_ahu) annotation (Line(
      points={{120,18.1818},{120,24},{20,24},{20,-33.95},{-19.95,-33.95}},
      color={255,204,51},
      thickness=0.5));
  connect(testhall.TAir, zoneBus.zoneTemp) annotation (Line(points={{22,74},{90,
          74},{90,70.05},{90.05,70.05}}, color={0,0,127}));
  connect(zoneBus, mainBus.bus_zone) annotation (Line(
      points={{90,70},{92,70},{92,24},{20,24},{20,-33.95},{-19.95,-33.95}},
      color={255,204,51},
      thickness=0.5));
  connect(Office_RoomTemp.y[6], ZoneTemp_mea) annotation (Line(points={{60.5,45},
          {67.25,45},{67.25,45},{77,45}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{180,100}}),
                    graphics={Bitmap(
          extent={{-180,-140},{180,140}},
          imageSource=
              "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",
          fileName=
              "U:/EBC_ALLE/Vorlagen/Piktogramme_EBC/ERC-Gebäude/Halle.png")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{180,
            100}}), graphics={
        Rectangle(
          extent={{-170,-60},{-98,-98}},
          lineColor={244,125,35},
          lineThickness=1,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-134,28},{-54,-52}},
          lineColor={244,125,35},
          lineThickness=1,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-130,-38},{-106,-50}},
          textColor={0,0,0},
          textString="CPH"),
        Rectangle(
          extent={{-50,-58},{32,-100}},
          lineColor={244,125,35},
          lineThickness=1,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-50,-88},{-26,-100}},
          textColor={0,0,0},
          textString="DHS"),
        Rectangle(
          extent={{24,28},{182,-56}},
          lineColor={244,125,35},
          lineThickness=1,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{54,-32},{96,-52}},
          textColor={0,0,0},
          textString="Air System"),
        Rectangle(
          extent={{-38,92},{26,36}},
          lineColor={244,125,35},
          lineThickness=1,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-36,92},{2,80}},
          textColor={0,0,0},
          textString="Envelope"),
        Rectangle(
          extent={{-34,20},{14,-18}},
          lineColor={244,125,35},
          lineThickness=1,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-34,20},{-10,8}},
          textColor={0,0,0},
          textString="CCA"),
        Text(
          extent={{-164,-86},{-134,-98}},
          textColor={0,0,0},
          textString="Control")}),
    experiment(
      StartTime=7500000,
      StopTime=12500000,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end EON_ERC_Testhall;
