within AixLib.Systems.EONERC_Testhall.BaseClasses.Consumers;
model Buildings_Test_Hall_EON_ERC

   replaceable package MediumWater =
      AixLib.Media.Water
    "Medium in the heatingsystem/hydraulic" annotation(choicesAllMatching=true);
  replaceable package MediumAir =
      AixLib.Media.Air
    "Medium in the system" annotation(choicesAllMatching=true);

  Modelica.Blocks.Sources.Constant infiltration_rate_hall1(k=0)
    annotation (Placement(transformation(extent={{174,170},{194,190}})));
  Modelica.Blocks.Sources.Constant infiltration_rate_hall2(k=0)
    annotation (Placement(transformation(extent={{-84,170},{-64,190}})));
  AixLib.Fluid.Sources.Boundary_ph     AirOut_Hall2(
    redeclare package Medium = MediumAir,
    nPorts=1,
    p=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,164})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe_out_hall2(
    redeclare package Medium = MediumAir,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
    length=1,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,128})));
   AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone     Office5(
    redeclare package Medium = MediumAir,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
        VAir=60,
        AZone=18,
        lat=1.77,
        nOrientations=5,
        AWin={0,0,6,0,0},
        ATransparent={0,0,6,0,0},
        AExt={0,28,0,0,0},
        nExt=1,
        AInt=42,
        nInt=1,
        AFloor=37,
        nFloor=1,
        nRoof=1,
        nOrientationsRoof=1,
        useConstantACHrate=false,
        withAHU=false,
        HeaterOn=false,
        CoolerOn=false,
        withIdealThresholds=true),
    ROM(
      extWallRC(thermCapExt(each der_T(fixed=true))),
      intWallRC(thermCapInt(each der_T(fixed=true))),
      indoorPortExtWalls=false,
      indoorPortIntWalls=true),
    nPorts=2,
    T_start=295.35) "Thermal zone"
    annotation (Placement(transformation(extent={{1278,20},{1378,120}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://Testhall/DataBase/Weather/DEU_Dusseldorf.104000_IWEC.mos"))
    annotation (Placement(transformation(extent={{-160,42},{-140,62}})));

  AixLib.BoundaryConditions.WeatherData.Bus     weaBus annotation (Placement(
        transformation(extent={{-126,34},{-106,54}}), iconTransformation(extent=
           {{0,0},{0,0}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_port_rad_hall2
    "Radiative internal gains"
    annotation (Placement(transformation(extent={{70,-24},{90,-4}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_hall1[2](
      redeclare package Medium = MediumAir)
    "Auxilliary fluid inlets and outlets to indoor air volume"
    annotation (Placement(transformation(extent={{196,-24},{270,-4}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_port_rad_hall1
    "Radiative internal gains"
    annotation (Placement(transformation(extent={{290,-24},{310,-4}})));

  AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone     Office1(
    redeclare package Medium = MediumAir,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
        VAir=60,
        AZone=18,
        lat=1.77,
        nOrientations=5,
        AWin={0,0,6,0,0},
        ATransparent={0,0,6,0,0},
        AExt={0,15,12,0,0},
        nExt=1,
        AInt=45,
        nInt=1,
        AFloor=16,
        nFloor=1,
        nRoof=1,
        nOrientationsRoof=1,
        useConstantACHrate=false,
        withAHU=false,
        HeaterOn=false,
        CoolerOn=false,
        withIdealThresholds=false),
    ROM(
      extWallRC(thermCapExt(each der_T(fixed=true))),
      intWallRC(thermCapInt(each der_T(fixed=true))),
      indoorPortExtWalls=false,
      indoorPortIntWalls=true),
    redeclare model corG =
        AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
    nPorts=2,
    machinesSenHea(areaSurfaceMachinesTotal=0.1),
    T_start=291.15) "Thermal zone"
    annotation (Placement(transformation(extent={{400,20},{500,120}})));
  Modelica.Blocks.Sources.Constant infiltration_rate_office1(k=0)
    annotation (Placement(transformation(extent={{388,174},{408,194}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_office1[2](
      redeclare package Medium = MediumAir)
    "Auxilliary fluid inlets and outlets to indoor air volume"
    annotation (Placement(transformation(extent={{414,-24},{488,-4}})));
  AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone     Office2(
    redeclare package Medium = MediumAir,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
        VAir=60,
        AZone=18,
        lat=1.77,
        nOrientations=5,
        AWin={0,0,6,0,0},
        ATransparent={0,0,6,0,0},
        AExt={0,0,14,0,0},
        nExt=1,
        AInt=50,
        nInt=1,
        AFloor=18,
        nFloor=1,
        nRoof=1,
        nOrientationsRoof=1,
        useConstantACHrate=false,
        withAHU=false,
        HeaterOn=false,
        CoolerOn=false,
        withIdealThresholds=true),
    ROM(
      extWallRC(thermCapExt(each der_T(fixed=true))),
      intWallRC(thermCapInt(each der_T(fixed=true))),
      indoorPortExtWalls=false,
      indoorPortIntWalls=true),
    redeclare model corG =
        AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
    nPorts=2,
    machinesSenHea(areaSurfaceMachinesTotal=0.1),
    T_start=291.15) "Thermal zone"
    annotation (Placement(transformation(extent={{620,20},{722,120}})));
  AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone     Office3(
    redeclare package Medium = MediumAir,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
        VAir=60,
        AZone=18,
        lat=1.77,
        nOrientations=5,
        AWin={0,0,6,0,0},
        ATransparent={0,0,6,0,0},
        AExt={0,0,14,0,0},
        nExt=1,
        AInt=60,
        nInt=1,
        AFloor=18,
        nFloor=1,
        nRoof=1,
        nOrientationsRoof=1,
        useConstantACHrate=false,
        withAHU=false,
        HeaterOn=false,
        CoolerOn=false,
        withIdealThresholds=true),
    ROM(
      extWallRC(thermCapExt(each der_T(fixed=true))),
      intWallRC(thermCapInt(each der_T(fixed=true))),
      indoorPortExtWalls=false,
      indoorPortIntWalls=true),
    redeclare model corG =
        AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
    nPorts=2,
    T_start=291.15) "Thermal zone"
    annotation (Placement(transformation(extent={{840,22},{938,122}})));
  AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone     Office4(
    redeclare package Medium = MediumAir,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
        VAir=120,
        AZone=37,
        lat=1.77,
        nOrientations=5,
        AWin={0,0,12,0,0},
        ATransparent={0,0,12,0,0},
        AExt={0,30,0,0,0},
        nExt=1,
        AInt=100,
        nInt=1,
        AFloor=37,
        nFloor=1,
        nRoof=1,
        nOrientationsRoof=1,
        useConstantACHrate=false,
        withAHU=false,
        HeaterOn=false,
        CoolerOn=false,
        withIdealThresholds=true),
    ROM(
      extWallRC(thermCapExt(each der_T(fixed=true))),
      intWallRC(thermCapInt(each der_T(fixed=true))),
      indoorPortExtWalls=false,
      indoorPortIntWalls=true),
    nPorts=2,
    T_start=295.35) "Thermal zone"
    annotation (Placement(transformation(extent={{1060,20},{1160,120}})));
    AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone Hall2(
    redeclare package Medium = MediumAir,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
        VAir=3000,
        AZone=300,
        lat=1.77,
        nOrientations=5,
        AWin={0,0,0,0,0},
        ATransparent={0,0,0,0,0},
        RWin=0.0177,
        gWin=0.78,
        UWin=2.1,
        ratioWinConRad=0.09,
        AExt={0,0,0,0,0},
        nExt=1,
        AInt=140,
        nInt=1,
        AFloor=380,
        nFloor=1,
        ARoof=380,
        nRoof=1,
        nOrientationsRoof=1,
        specificPeople=1,
        activityDegree=3,
        fixedHeatFlowRatePersons=80,
        useConstantACHrate=false,
        withAHU=false,
        HeaterOn=false,
        CoolerOn=false,
        withIdealThresholds=false),
    ROM(
      extWallRC(thermCapExt(each der_T(fixed=true))),
      intWallRC(thermCapInt(each der_T(fixed=true))),
      indoorPortExtWalls=false,
      indoorPortIntWalls=true),
    redeclare model corG =
        AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
    nPorts=1,
    machinesSenHea(areaSurfaceMachinesTotal=10),
    T_start=291.15) "Thermal zone"
    annotation (Placement(transformation(extent={{-36,20},{64,120}})));
        //AWin={5,0,0,0,5},
        //AExt={0,175,140,175,0},

      AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone     Hall1(
    redeclare package Medium = MediumAir,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    zoneParam=Testhall.DataBase.ZoneParameter_Office_Parameterized(
        VAir=5000,
        AZone=500,
        lat=1.77,
        nOrientations=5,
        AWin={0,0,0,0,0},
        ATransparent={0,0,0,0,0},
        AExt={0,0,0,0,0},
        nExt=1,
        AInt=140,
        nInt=1,
        AFloor=640,
        nFloor=1,
        ARoof=790,
        nRoof=1,
        nOrientationsRoof=1,
        useConstantACHrate=false,
        withAHU=false,
        HeaterOn=false,
        CoolerOn=false,
        withIdealThresholds=false),
    ROM(
      extWallRC(thermCapExt(each der_T(fixed=true))),
      intWallRC(thermCapInt(each der_T(fixed=true))),
      indoorPortExtWalls=false,
      indoorPortIntWalls=true),
    redeclare model corG =
        AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
    nPorts=2,
    machinesSenHea(areaSurfaceMachinesTotal=50),
    T_start=291.15) "Thermal zone"
    annotation (Placement(transformation(extent={{180,20},{280,120}})));
        //withAirCap=true,
        //AWin={0,2,0,2,0},
        //AExt={0,320,90,310,0},

  Modelica.Blocks.Sources.Constant infiltration_rate_office2(k=0)
    annotation (Placement(transformation(extent={{614,140},{634,160}})));
  Modelica.Blocks.Sources.Constant infiltration_rate_office3(k=0)
    annotation (Placement(transformation(extent={{836,140},{856,160}})));
  Modelica.Blocks.Sources.Constant infiltration_rate_office4(k=0)
    annotation (Placement(transformation(extent={{1052,140},{1072,160}})));
  Modelica.Blocks.Sources.Constant infiltration_rate_office5(k=0)
    annotation (Placement(transformation(extent={{1274,140},{1294,160}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_office2[2](
      redeclare package Medium = MediumAir)
    "Auxilliary fluid inlets and outlets to indoor air volume"
    annotation (Placement(transformation(extent={{634,-24},{708,-4}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_office3[2](
      redeclare package Medium = MediumAir)
    "Auxilliary fluid inlets and outlets to indoor air volume"
    annotation (Placement(transformation(extent={{852,-24},{926,-4}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_office4[2](
      redeclare package Medium = MediumAir)
    "Auxilliary fluid inlets and outlets to indoor air volume"
    annotation (Placement(transformation(extent={{1074,-24},{1148,-4}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_office5[2](
      redeclare package Medium = MediumAir)
    "Auxilliary fluid inlets and outlets to indoor air volume"
    annotation (Placement(transformation(extent={{1294,-24},{1368,-4}})));
  Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus controlBus
    annotation (Placement(transformation(extent={{-102,-28},{-62,12}}),
        iconTransformation(extent={{0,0},{0,0}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_Humans(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
        0; 28740,0; 28800,0.2; 43200,0.2; 43260,0.2; 46800,0.2; 46860,0.2;
        64800,0.2; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{202,196},{222,216}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_Light(
                                       extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
        0; 28740,0; 28800,0.01; 64800,0.01; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{202,140},{222,160}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_machine(
                                             extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
        0.5; 28740,0.5; 28800,0.5; 64800,0.5; 64860,0.5; 86400,0.5])
    annotation (Placement(transformation(extent={{202,168},{222,188}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_Humans1(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
        0; 28740,0; 28800,0.04; 43200,0.04; 43260,0.04; 46800,0.04; 46860,0.04;
        64800,0.04; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{424,194},{444,214}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_Light1(
                                             extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
        0; 28740,0; 28800,0.01; 64800,0.01; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{424,138},{444,158}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_machine1(
                                             extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
        0.03; 28740,0.03; 28800,0.03; 64800,0.03; 64860,0.03; 86400,0.03])
    annotation (Placement(transformation(extent={{424,166},{444,186}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_Humans2(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
        0; 28740,0; 28800,0.12; 43200,0.12; 43260,0.12; 46800,0.12; 46860,0.12;
        64800,0.12; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{646,194},{666,214}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_Light2(
                                             extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
        0; 28740,0; 28800,0.01; 64800,0.01; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{646,138},{666,158}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_machine2(
                                             extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
        0.03; 28740,0.03; 28800,0.03; 64800,0.03; 64860,0.03; 86400,0.03])
    annotation (Placement(transformation(extent={{646,166},{666,186}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_Humans3(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
        0; 28740,0; 28800,0.12; 43200,0.12; 43260,0.12; 46800,0.12; 46860,0.12;
        64800,0.12; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{866,194},{886,214}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_Light3(
                                             extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
        0; 28740,0; 28800,0.01; 64800,0.01; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{866,138},{886,158}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_machine3(
                                             extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
        0.03; 28740,0.03; 28800,0.03; 64800,0.03; 64860,0.03; 86400,0.03])
    annotation (Placement(transformation(extent={{866,166},{886,186}})));
  Modelica.Blocks.Sources.Constant internal_gains[3](each k=0)
    annotation (Placement(transformation(extent={{1100,160},{1120,180}})));
  Modelica.Blocks.Sources.Constant internal_gains1[3](each k=0)
    annotation (Placement(transformation(extent={{1320,160},{1340,180}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_Humans4(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
        0; 28740,0; 28800,0.12; 43200,0.12; 43260,0.12; 46800,0.12; 46860,0.12;
        64800,0.12; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{-8,196},{12,216}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_Light4(
                                             extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
        0; 28740,0; 28800,0.01; 64800,0.01; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{-8,140},{12,160}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_machine4(
                                             extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table=[0,
        0.5; 28740,0.5; 28800,0.5; 64800,0.5; 64860,0.5; 86400,0.5])
    annotation (Placement(transformation(extent={{-8,168},{12,188}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping(     f=0.0005, n=3,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{240,196},{260,216}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping1(     f=0.0005, n=3,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{240,168},{260,188}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping2(     f=0.0005, n=3,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{240,140},{260,160}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping3(     f=0.0005, n=3,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{22,196},{42,216}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping4(     f=0.0005, n=3,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{22,168},{42,188}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping5(     f=0.0005, n=3,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{22,140},{42,160}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping6(
                                                             n=3, f=0.01,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{458,194},{478,214}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping7(n=3, f=0.01,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{460,138},{480,158}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping8(n=3, f=0.01,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{460,166},{480,186}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping9(
                                                             n=3, f=0.01,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{684,194},{704,214}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping10(
                                                              n=3, f=0.01,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{684,138},{704,158}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping11(
                                                              n=3, f=0.01,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{684,166},{704,186}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping12(
                                                             n=3, f=0.01,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{900,194},{920,214}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping13(
                                                              n=3, f=0.01,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{900,138},{920,158}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping14(
                                                              n=3, f=0.01,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{900,166},{920,186}})));
  BaseClass.DistributeBus distributeBus_Buildings
    annotation (Placement(transformation(extent={{-102,-60},{-62,-20}})));
equation
  connect(pipe_out_hall2.port_b, AirOut_Hall2.ports[1])
    annotation (Line(points={{70,138},{70,154}}, color={0,127,255}));
  connect(infiltration_rate_hall1.y, Hall1.ventRate)
    annotation (Line(points={{195,180},{195,49},{182,49}},  color={0,0,127}));
  connect(Hall2.intGainsRad, heat_port_rad_hall2) annotation (Line(points={{65,87},
          {70,87},{70,86},{80,86},{80,-14}},         color={191,0,0}));
  connect(Hall2.ports[1], pipe_out_hall2.port_a) annotation (Line(points={{14,
          34},{14,12},{70,12},{70,118}}, color={0,127,255}));
  connect(Hall1.ports[1:2], ports_hall1) annotation (Line(points={{235.875,34},
          {233,34},{233,-14}},
                          color={0,127,255}));
  connect(Hall1.intGainsRad, heat_port_rad_hall1) annotation (Line(points={{281,87},
          {300,87},{300,56},{300,-14}},               color={191,0,0}));
  connect(heat_port_rad_hall1, heat_port_rad_hall1)
    annotation (Line(points={{300,-14},{300,-14}}, color={191,0,0}));
  connect(infiltration_rate_office1.y, Office1.ventRate)
    annotation (Line(points={{409,184},{409,49},{402,49}},  color={0,0,127}));
  connect(Office1.ports[1:2], ports_office1) annotation (Line(points={{455.875,
          34},{451,34},{451,-14}},
                               color={0,127,255}));
  connect(infiltration_rate_office2.y, Office2.ventRate) annotation (Line(
        points={{635,150},{634,150},{634,49},{622.04,49}},color={0,0,127}));
  connect(infiltration_rate_office3.y, Office3.ventRate) annotation (Line(
        points={{857,150},{856,150},{856,51},{841.96,51}},color={0,0,127}));
  connect(infiltration_rate_office4.y, Office4.ventRate) annotation (Line(
        points={{1073,150},{1072,150},{1072,49},{1062,49}}, color={0,0,127}));
  connect(infiltration_rate_office5.y, Office5.ventRate) annotation (Line(
        points={{1295,150},{1295,49},{1280,49}}, color={0,0,127}));
  connect(Office2.ports[1:2], ports_office2) annotation (Line(points={{676.993,
          34},{671,34},{671,-14}}, color={0,127,255}));
  connect(Office3.ports[1:2], ports_office3) annotation (Line(points={{894.757,
          36},{900,36},{900,32},{889,32},{889,-14}}, color={0,127,255}));
  connect(Office5.ports[1:2], ports_office5) annotation (Line(points={{1333.88,
          34},{1331,34},{1331,-14}}, color={0,127,255}));
  connect(Office4.ports[1:2], ports_office4) annotation (Line(points={{1115.88,
          34},{1111,34},{1111,-14}}, color={0,127,255}));
  connect(Hall2.TAir, controlBus.Hall2_Air_m) annotation (Line(points={{69,110},
          {100,110},{100,-58},{-2,-58},{-2,-8},{-82,-8}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Hall1.TAir, controlBus.Hall1_Air_m) annotation (Line(points={{285,110},
          {330,110},{330,-58},{-2,-58},{-2,-8},{-82,-8}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Office1.TAir, controlBus.Office1_Air_m) annotation (Line(points={{505,
          110},{526,110},{526,-58},{-2,-58},{-2,-8},{-82,-8}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Office2.TAir, controlBus.Office2_Air_m) annotation (Line(points={{727.1,
          110},{752,110},{752,-58},{-2,-58},{-2,-8},{-82,-8}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Office3.TAir, controlBus.Office3_Air_m) annotation (Line(points={{942.9,
          112},{982,112},{982,-58},{-2,-58},{-2,-8},{-82,-8}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Office4.TAir, controlBus.Office4_Air_m) annotation (Line(points={{1165,
          110},{1192,110},{1192,-58},{-2,-58},{-2,-8},{-82,-8}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Office5.TAir, controlBus.Office5_Air_m) annotation (Line(points={{1383,
          110},{1420,110},{1420,-58},{-2,-58},{-2,-8},{-82,-8}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(internal_gains.y, Office4.intGains) annotation (Line(points={{1121,
          170},{1150,170},{1150,28}}, color={0,0,127}));
  connect(internal_gains1.y, Office5.intGains) annotation (Line(points={{1341,
          170},{1368,170},{1368,28}},                       color={0,0,127}));
  connect(Table_Humans.y[1], criticalDamping.u)
    annotation (Line(points={{223,206},{238,206}}, color={0,0,127}));
  connect(Table_Light.y[1], criticalDamping2.u)
    annotation (Line(points={{223,150},{238,150}}, color={0,0,127}));
  connect(Table_machine.y[1], criticalDamping1.u)
    annotation (Line(points={{223,178},{238,178}}, color={0,0,127}));
  connect(criticalDamping2.y, Hall1.intGains[3]) annotation (Line(points={{261,150},
          {270,150},{270,30}},               color={0,0,127}));
  connect(criticalDamping1.y, Hall1.intGains[2]) annotation (Line(points={{261,178},
          {270,178},{270,28}},               color={0,0,127}));
  connect(criticalDamping.y, Hall1.intGains[1]) annotation (Line(points={{261,206},
          {270,206},{270,26}},               color={0,0,127}));
  connect(Table_machine4.y[1], criticalDamping4.u)
    annotation (Line(points={{13,178},{20,178}}, color={0,0,127}));
  connect(Table_Light4.y[1], criticalDamping5.u)
    annotation (Line(points={{13,150},{20,150}}, color={0,0,127}));
  connect(Table_Humans4.y[1], criticalDamping3.u)
    annotation (Line(points={{13,206},{20,206}}, color={0,0,127}));
  connect(criticalDamping5.y, Hall2.intGains[3])
    annotation (Line(points={{43,150},{54,150},{54,30}}, color={0,0,127}));
  connect(criticalDamping4.y, Hall2.intGains[2])
    annotation (Line(points={{43,178},{54,178},{54,28}}, color={0,0,127}));
  connect(criticalDamping3.y, Hall2.intGains[1])
    annotation (Line(points={{43,206},{54,206},{54,26}}, color={0,0,127}));
  connect(Table_Humans1.y[1], criticalDamping6.u)
    annotation (Line(points={{445,204},{456,204}}, color={0,0,127}));
  connect(Table_machine1.y[1], criticalDamping8.u)
    annotation (Line(points={{445,176},{458,176}}, color={0,0,127}));
  connect(Table_Light1.y[1], criticalDamping7.u) annotation (Line(points={{445,148},
          {458,148}},                          color={0,0,127}));
  connect(criticalDamping7.y, Office1.intGains[3]) annotation (Line(points={{481,148},
          {490,148},{490,30}},                                       color={0,0,
          127}));
  connect(criticalDamping8.y, Office1.intGains[2]) annotation (Line(points={{481,176},
          {490,176},{490,28}},                   color={0,0,127}));
  connect(criticalDamping6.y, Office1.intGains[1]) annotation (Line(points={{479,204},
          {490,204},{490,26}},                   color={0,0,127}));
  connect(Table_Humans2.y[1], criticalDamping9.u)
    annotation (Line(points={{667,204},{682,204}}, color={0,0,127}));
  connect(Table_machine2.y[1], criticalDamping11.u)
    annotation (Line(points={{667,176},{682,176}}, color={0,0,127}));
  connect(Table_Light2.y[1], criticalDamping10.u)
    annotation (Line(points={{667,148},{682,148}}, color={0,0,127}));
  connect(criticalDamping10.y, Office2.intGains[3]) annotation (Line(points={{705,148},
          {712,148},{712,30},{711.8,30}},          color={0,0,127}));
  connect(criticalDamping11.y, Office2.intGains[2]) annotation (Line(points={{705,176},
          {712,176},{712,28},{711.8,28}},          color={0,0,127}));
  connect(criticalDamping9.y, Office2.intGains[1]) annotation (Line(points={{705,204},
          {712,204},{712,26},{711.8,26}},                              color={0,
          0,127}));
  connect(Table_Humans3.y[1], criticalDamping12.u)
    annotation (Line(points={{887,204},{898,204}}, color={0,0,127}));
  connect(Table_machine3.y[1], criticalDamping14.u)
    annotation (Line(points={{887,176},{898,176}}, color={0,0,127}));
  connect(Table_Light3.y[1], criticalDamping13.u)
    annotation (Line(points={{887,148},{898,148}}, color={0,0,127}));
  connect(criticalDamping13.y, Office3.intGains[3]) annotation (Line(points={{921,148},
          {928,148},{928,32},{928.2,32}},          color={0,0,127}));
  connect(criticalDamping14.y, Office3.intGains[2]) annotation (Line(points={{921,176},
          {928,176},{928,30},{928.2,30}},                              color={0,
          0,127}));
  connect(criticalDamping12.y, Office3.intGains[1]) annotation (Line(points={{921,204},
          {928,204},{928,28},{928.2,28}},          color={0,0,127}));
  connect(infiltration_rate_hall2.y, Hall2.ventRate) annotation (Line(points={{-63,180},
          {-60,180},{-60,49},{-34,49}},          color={0,0,127}));
  connect(weaBus, Hall2.weaBus) annotation (Line(
      points={{-116,44},{-78,44},{-78,100},{-36,100}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus, Hall1.weaBus) annotation (Line(
      points={{-116,44},{164,44},{164,100},{180,100}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus, Office1.weaBus) annotation (Line(
      points={{-116,44},{380,44},{380,100},{400,100}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus, Office2.weaBus) annotation (Line(
      points={{-116,44},{598,44},{598,100},{620,100}},
      color={255,204,51},
      thickness=0.5));
  connect(Office3.weaBus, weaBus) annotation (Line(
      points={{840,102},{818,102},{818,44},{-116,44}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus, Office4.weaBus) annotation (Line(
      points={{-116,44},{1042,44},{1042,100},{1060,100}},
      color={255,204,51},
      thickness=0.5));
  connect(Office5.weaBus, weaBus) annotation (Line(
      points={{1278,100},{1262,100},{1262,44},{-116,44}},
      color={255,204,51},
      thickness=0.5));
  connect(Hall2.ventTemp, weaBus.TDryBul) annotation (Line(points={{-34,62},{
          -74,62},{-74,44},{-116,44}}, color={0,0,127}));
  connect(Hall1.ventTemp, weaBus.TDryBul) annotation (Line(points={{182,62},{
          162,62},{162,44},{-116,44}}, color={0,0,127}));
  connect(Office1.ventTemp, weaBus.TDryBul) annotation (Line(points={{402,62},
          {380,62},{380,44},{-116,44}}, color={0,0,127}));
  connect(Office3.ventTemp, weaBus.TDryBul) annotation (Line(points={{841.96,
          64},{792,64},{792,44},{-116,44}}, color={0,0,127}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-140,52},{-130,52},{-130,44},{-116,44}},
      color={255,204,51},
      thickness=0.5));
  connect(Office2.ventTemp, weaBus.TDryBul) annotation (Line(points={{622.04,
          62},{254,62},{254,44},{-116,44}}, color={0,0,127}));
  connect(Office4.ventTemp, weaBus.TDryBul) annotation (Line(points={{1062,62},
          {1036,62},{1036,44},{-116,44}}, color={0,0,127}));
  connect(Office5.ventTemp, weaBus.TDryBul) annotation (Line(points={{1280,62},
          {1244,62},{1244,44},{-116,44}}, color={0,0,127}));
  connect(distributeBus_Buildings.control_buildings.Office1_Air_m, controlBus.Office1_Air_m)
    annotation (Line(
      points={{-82,-40},{-82,-24},{-82,-24},{-82,-8}},
      color={255,204,51},
      thickness=0.5));
  connect(distributeBus_Buildings.control_buildings.Office2_Air_m, controlBus.Office2_Air_m)
    annotation (Line(
      points={{-82,-40},{-82,-24},{-82,-24},{-82,-8}},
      color={255,204,51},
      thickness=0.5));
  connect(distributeBus_Buildings.control_buildings.Office3_Air_m, controlBus.Office3_Air_m)
    annotation (Line(
      points={{-82,-40},{-82,-24},{-82,-24},{-82,-8}},
      color={255,204,51},
      thickness=0.5));
  connect(distributeBus_Buildings.control_buildings.Office4_Air_m, controlBus.Office4_Air_m)
    annotation (Line(
      points={{-82,-40},{-82,-24},{-82,-24},{-82,-8}},
      color={255,204,51},
      thickness=0.5));
  connect(distributeBus_Buildings.control_buildings.Office5_Air_m, controlBus.Office5_Air_m)
    annotation (Line(
      points={{-82,-40},{-82,-24},{-82,-24},{-82,-8}},
      color={255,204,51},
      thickness=0.5));
  connect(distributeBus_Buildings.control_buildings.Hall1_Air_m, controlBus.Hall1_Air_m)
    annotation (Line(
      points={{-82,-40},{-82,-24},{-82,-24},{-82,-8}},
      color={255,204,51},
      thickness=0.5));
  connect(distributeBus_Buildings.control_buildings.Hall2_Air_m, controlBus.Hall2_Air_m)
    annotation (Line(
      points={{-82,-40},{-82,-24},{-82,-24},{-82,-8}},
      color={255,204,51},
      thickness=0.5));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,0},
            {1460,280}}), graphics={
        Rectangle(
          extent={{-58,262},{1448,0}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-8,252},{152,214}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{166,252},{326,214}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{340,252},{500,214}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{510,252},{670,214}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{682,252},{842,214}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{856,252},{1016,214}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{1032,252},{1192,214}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{1210,252},{1370,214}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-44,72},{130,8}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          fontSize=11,
          textString="Hall2"),
        Text(
          extent={{154,72},{328,8}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          fontSize=11,
          textString="Hall1"),
        Text(
          extent={{310,66},{584,8}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          fontSize=11,
          textString="O1"),
        Text(
          extent={{528,66},{802,8}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          fontSize=11,
          textString="O2"),
        Text(
          extent={{754,70},{1028,12}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          fontSize=11,
          textString="O3"),
        Text(
          extent={{968,72},{1242,14}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          fontSize=11,
          textString="O4"),
        Text(
          extent={{1192,72},{1466,14}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          fontSize=11,
          textString="O5")}),
                           Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,0},{1460,280}}), graphics={
        Rectangle(extent={{120,220},{340,10}},  lineColor={0,0,0}),
        Rectangle(extent={{-100,220},{120,10}}, lineColor={0,0,0}),
        Rectangle(extent={{340,220},{560,10}},  lineColor={0,0,0}),
        Rectangle(extent={{560,220},{780,10}},  lineColor={0,0,0}),
        Rectangle(extent={{780,220},{1000,10}}, lineColor={0,0,0}),
        Rectangle(extent={{1000,220},{1220,10}},lineColor={0,0,0}),
        Rectangle(extent={{1220,220},{1440,10}},lineColor={0,0,0})}));
end Buildings_Test_Hall_EON_ERC;
