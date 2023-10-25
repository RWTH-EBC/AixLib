within AixLib.Systems.EONERC_Testhall.BaseClasses.Consumers;
model Buildings

   replaceable package MediumWater =
      AixLib.Media.Water
    "Medium in the heatingsystem/hydraulic" annotation(choicesAllMatching=true);
  replaceable package MediumAir =
      AixLib.Media.Air
    "Medium in the system" annotation(choicesAllMatching=true);

        //AWin={5,0,0,0,5},
        //AExt={0,175,140,175,0},

        //withAirCap=true,
        //AWin={0,2,0,2,0},
        //AExt={0,320,90,310,0},

   AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone     Office5(
    redeclare package Medium = AixLib.Media.Air,
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
    redeclare model corG =
        AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
    use_MechanicalAirExchange=true,
    T_start=295.35,
    nPorts=2)       "Thermal zone"
    annotation (Placement(transformation(extent={{1316,120},{1416,220}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource("modelica://Testhall/DataBase/Weather/DEU_Dusseldorf.104000_IWEC.mos"))
    annotation (Placement(transformation(extent={{-232,160},{-212,180}})));

  Modelica.Blocks.Sources.Constant ventRate5(each k=0)
    annotation (Placement(transformation(extent={{1250,228},{1270,248}})));
  AixLib.BoundaryConditions.WeatherData.Bus     weaBus annotation (Placement(
        transformation(extent={{-198,152},{-178,172}}),
                                                      iconTransformation(extent=
           {{0,0},{0,0}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_office5[2](
      redeclare package Medium = AixLib.Media.Air)
    "Auxilliary fluid inlets and outlets to indoor air volume"
    annotation (Placement(transformation(extent={{1336,102},{1410,122}}),
        iconTransformation(extent={{1294,-12},{1368,8}})));
  Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus control_building
    annotation (Placement(transformation(extent={{664,22},{684,42}}),     iconTransformation(extent={{-48,56},
            {-28,76}})));
  BaseClass.DistributeBus distributeBus_Buildings
    annotation (Placement(transformation(extent={{652,-18},{692,22}}),  iconTransformation(extent={{-54,-6},
            {-14,34}})));
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
    use_MechanicalAirExchange=true,
    nPorts=2,
    T_start=295.35) "Thermal zone"
    annotation (Placement(transformation(extent={{1094,120},{1194,220}})));
  Modelica.Blocks.Sources.Constant ventRate4(each k=0)
    annotation (Placement(transformation(extent={{1038,228},{1058,248}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_office4[2](
      redeclare package Medium = AixLib.Media.Air)
    "Auxilliary fluid inlets and outlets to indoor air volume"
    annotation (Placement(transformation(extent={{1110,96},{1184,116}}),
        iconTransformation(extent={{1068,-8},{1142,12}})));
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
    use_MechanicalAirExchange=true,
    nPorts=2,
    T_start=291.15) "Thermal zone"
    annotation (Placement(transformation(extent={{908,120},{1006,220}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_office3[2](
      redeclare package Medium = AixLib.Media.Air)
    "Auxilliary fluid inlets and outlets to indoor air volume"
    annotation (Placement(transformation(extent={{920,90},{994,110}}),
        iconTransformation(extent={{854,-10},{928,10}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_Humans3(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      table=[0,0; 28740,0; 28800,0.12; 43200,0.12; 43260,0.12; 46800,0.12; 46860,
        0.12; 64800,0.12; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{894,-22},{914,-2}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_Light3(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      table=[0,0; 28740,0; 28800,0.01; 64800,0.01; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{894,-78},{914,-58}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_machine3(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      table=[0,0.03; 28740,0.03; 28800,0.03; 64800,0.03; 64860,0.03; 86400,0.03])
    annotation (Placement(transformation(extent={{894,-50},{914,-30}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping12(
    n=3,
    f=0.01,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{928,-22},{948,-2}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping13(
    n=3,
    f=0.01,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{928,-78},{948,-58}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping14(
    n=3,
    f=0.01,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{928,-50},{948,-30}})));
  Modelica.Blocks.Sources.Constant ventRate3(each k=0)
    annotation (Placement(transformation(extent={{842,238},{862,258}})));
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
    use_MechanicalAirExchange=true,
    nPorts=2,
    machinesSenHea(areaSurfaceMachinesTotal=0.1),
    T_start=291.15) "Thermal zone"
    annotation (Placement(transformation(extent={{692,120},{794,220}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_office2[2](
      redeclare package Medium = AixLib.Media.Air)
    "Auxilliary fluid inlets and outlets to indoor air volume"
    annotation (Placement(transformation(extent={{702,96},{776,116}}),
        iconTransformation(extent={{622,-12},{696,8}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_Humans2(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      table=[0,0; 28740,0; 28800,0.12; 43200,0.12; 43260,0.12; 46800,0.12; 46860,
        0.12; 64800,0.12; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{710,-20},{730,0}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_Light2(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      table=[0,0; 28740,0; 28800,0.01; 64800,0.01; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{710,-76},{730,-56}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_machine2(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      table=[0,0.03; 28740,0.03; 28800,0.03; 64800,0.03; 64860,0.03; 86400,0.03])
    annotation (Placement(transformation(extent={{710,-48},{730,-28}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping9(
    n=3,
    f=0.01,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{748,-20},{768,0}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping10(
    n=3,
    f=0.01,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{748,-76},{768,-56}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping11(
    n=3,
    f=0.01,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{748,-48},{768,-28}})));
  Modelica.Blocks.Sources.Constant ventRate2(each k=0)
    annotation (Placement(transformation(extent={{638,234},{658,254}})));
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
    use_MechanicalAirExchange=true,
    nPorts=2,
    machinesSenHea(areaSurfaceMachinesTotal=0.1),
    T_start=291.15) "Thermal zone"
    annotation (Placement(transformation(extent={{486,120},{586,220}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_office1[2](
      redeclare package Medium = AixLib.Media.Air)
    "Auxilliary fluid inlets and outlets to indoor air volume"
    annotation (Placement(transformation(extent={{500,98},{574,118}}),
        iconTransformation(extent={{406,-12},{480,8}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_Humans1(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      table=[0,0; 28740,0; 28800,0.04; 43200,0.04; 43260,0.04; 46800,0.04; 46860,
        0.04; 64800,0.04; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{486,-24},{506,-4}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_Light1(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      table=[0,0; 28740,0; 28800,0.01; 64800,0.01; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{486,-80},{506,-60}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_machine1(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      table=[0,0.03; 28740,0.03; 28800,0.03; 64800,0.03; 64860,0.03; 86400,0.03])
    annotation (Placement(transformation(extent={{486,-52},{506,-32}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping6(
    n=3,
    f=0.01,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{520,-24},{540,-4}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping7(
    n=3,
    f=0.01,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{522,-80},{542,-60}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping8(
    n=3,
    f=0.01,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{522,-52},{542,-32}})));
  Modelica.Blocks.Sources.Constant ventRate1(each k=0)
    annotation (Placement(transformation(extent={{430,222},{450,242}})));
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
    use_MechanicalAirExchange=true,
    nPorts=2,
    machinesSenHea(areaSurfaceMachinesTotal=50),
    T_start=291.15) "Thermal zone"
    annotation (Placement(transformation(extent={{278,120},{378,220}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_hall1[2](
      redeclare package Medium = AixLib.Media.Air)
    "Auxilliary fluid inlets and outlets to indoor air volume" annotation (
      Placement(transformation(extent={{290,100},{364,120}}),
        iconTransformation(extent={{198,-12},{272,8}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_Humans(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      table=[0,0; 28740,0; 28800,0.2; 43200,0.2; 43260,0.2; 46800,0.2; 46860,0.2;
        64800,0.2; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{282,-24},{302,-4}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_Light(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      table=[0,0; 28740,0; 28800,0.01; 64800,0.01; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{282,-80},{302,-60}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_machine(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      table=[0,0.5; 28740,0.5; 28800,0.5; 64800,0.5; 64860,0.5; 86400,0.5])
    annotation (Placement(transformation(extent={{282,-52},{302,-32}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping(
    f=0.0005,
    n=3,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{320,-24},{340,-4}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping1(
    f=0.0005,
    n=3,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{320,-52},{340,-32}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping2(
    f=0.0005,
    n=3,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{320,-80},{340,-60}})));
  Modelica.Blocks.Sources.Constant ventRate_hall1(each k=0)
    annotation (Placement(transformation(extent={{230,228},{250,248}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_port_rad_hall1
    "Radiative internal gains"
    annotation (Placement(transformation(extent={{388,-8},{408,12}}),
        iconTransformation(extent={{290,-8},{310,12}})));
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
    use_MechanicalAirExchange=true,
    nPorts=1,
    machinesSenHea(areaSurfaceMachinesTotal=10),
    T_start=291.15) "Thermal zone"
    annotation (Placement(transformation(extent={{-18,120},{82,220}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_Humans4(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      table=[0,0; 28740,0; 28800,0.12; 43200,0.12; 43260,0.12; 46800,0.12;
        46860,0.12; 64800,0.12; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_Light4(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      table=[0,0; 28740,0; 28800,0.01; 64800,0.01; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{-8,-84},{12,-64}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_machine4(extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      table=[0,0.5; 28740,0.5; 28800,0.5; 64800,0.5; 64860,0.5; 86400,0.5])
    annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping3(
    f=0.0005,
    n=3,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{22,-28},{42,-8}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping4(
    f=0.0005,
    n=3,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{22,-56},{42,-36}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping5(
    f=0.0005,
    n=3,
    x_start={0,0,0})
    annotation (Placement(transformation(extent={{22,-84},{42,-64}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_port_rad_hall2
    "Radiative internal gains"
    annotation (Placement(transformation(extent={{94,-12},{114,8}}),
        iconTransformation(extent={{30,-8},{50,12}})));
  Modelica.Blocks.Sources.Constant ventRate_hall2(each k=0)
    annotation (Placement(transformation(extent={{-82,238},{-62,258}})));
  AixLib.Fluid.Sources.Boundary_ph     AirOut_Hall2(
    redeclare package Medium = MediumAir,
    nPorts=1,
    p=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-48,84})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe_out_hall2(
    redeclare package Medium = MediumAir,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
    length=1,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-4,84})));
equation

  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-212,170},{-202,170},{-202,162},{-188,162}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus,Office5. weaBus) annotation (Line(
      points={{-188,162},{-142,162},{-142,200},{1316,200}},
      color={255,204,51},
      thickness=0.5));
  connect(ventRate5.y, Office5.ventRate) annotation (Line(points={{1271,238},{1296,
          238},{1296,149},{1318,149}}, color={0,0,127}));
  connect(weaBus.TDryBul,Office5. ventTemp) annotation (Line(
      points={{-188,162},{1318,162}},
      color={255,204,51},
      thickness=0.5));
  connect(Office5.ports[1:2], ports_office5) annotation (Line(points={{1371.88,
          134},{1373,134},{1373,112}},          color={0,127,255}));
  connect(Office5.TAir, control_building.Office5_Air_m)
    annotation (Line(points={{1421,210},{1452.5,210},{1452.5,32},{674,32}},    color={0,0,127}));
  connect(distributeBus_Buildings.control_building, control_building)
    annotation (Line(
      points={{672.1,2.1},{674,2.1},{674,32}},
      color={255,204,51},
      thickness=0.5));
  connect(ventRate4.y, Office4.ventRate) annotation (Line(points={{1059,238},{1059,
          148},{1092,148},{1092,150},{1096,150},{1096,149}}, color={0,0,127}));
  connect(weaBus, Office4.weaBus) annotation (Line(
      points={{-188,162},{-142,162},{-142,200},{1094,200}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, Office4.ventTemp) annotation (Line(
      points={{-188,162},{1096,162}},
      color={255,204,51},
      thickness=0.5));
  connect(ports_office4, Office4.ports[1:2]) annotation (Line(points={{1147,106},
          {1147,134},{1149.88,134}}, color={0,127,255}));
  connect(Office4.TAir, control_building.Office4_Air_m) annotation (Line(
        points={{1199,210},{1257.5,210},{1257.5,32},{674,32}}, color={0,0,127}));
  connect(ports_office3, Office3.ports[1:2]) annotation (Line(points={{957,100},
          {957,134},{962.757,134}}, color={0,127,255}));
  connect(weaBus, Office3.weaBus) annotation (Line(
      points={{-188,162},{-142,162},{-142,200},{908,200}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, Office3.ventTemp) annotation (Line(
      points={{-188,162},{909.96,162}},
      color={255,204,51},
      thickness=0.5));
  connect(Table_Humans3.y[1],criticalDamping12. u)
    annotation (Line(points={{915,-12},{926,-12}}, color={0,0,127}));
  connect(Table_machine3.y[1],criticalDamping14. u)
    annotation (Line(points={{915,-40},{926,-40}}, color={0,0,127}));
  connect(Table_Light3.y[1],criticalDamping13. u)
    annotation (Line(points={{915,-68},{926,-68}}, color={0,0,127}));
  connect(criticalDamping12.y, Office3.intGains[1]) annotation (Line(points={{949,-12},
          {996,-12},{996,126},{996.2,126}},      color={0,0,127}));
  connect(criticalDamping14.y, Office3.intGains[2]) annotation (Line(points={{949,
          -40},{996,-40},{996,128},{996.2,128}}, color={0,0,127}));
  connect(criticalDamping13.y, Office3.intGains[3]) annotation (Line(points={{949,-68},
          {996,-68},{996,130},{996.2,130}},      color={0,0,127}));
  connect(ventRate3.y, Office3.ventRate) annotation (Line(points={{863,248},{878,
          248},{878,149},{909.96,149}}, color={0,0,127}));
  connect(Office3.TAir, control_building.Office3_Air_m) annotation (Line(
        points={{1010.9,210},{1042,210},{1042,32},{674,32}}, color={0,0,127}));
  connect(Office2.ports[1:2], ports_office2) annotation (Line(points={{748.993,
          134},{748.993,130},{739,130},{739,106}},
                                              color={0,127,255}));
  connect(Table_Humans2.y[1],criticalDamping9. u)
    annotation (Line(points={{731,-10},{746,-10}}, color={0,0,127}));
  connect(Table_machine2.y[1],criticalDamping11. u)
    annotation (Line(points={{731,-38},{746,-38}}, color={0,0,127}));
  connect(Table_Light2.y[1],criticalDamping10. u)
    annotation (Line(points={{731,-66},{746,-66}}, color={0,0,127}));
  connect(criticalDamping9.y, Office2.intGains[1]) annotation (Line(points={{769,-10},
          {784,-10},{784,126},{783.8,126}},      color={0,0,127}));
  connect(criticalDamping11.y, Office2.intGains[2]) annotation (Line(points={{769,
          -38},{769,-40},{783.8,-40},{783.8,128}}, color={0,0,127}));
  connect(criticalDamping10.y, Office2.intGains[3]) annotation (Line(points={{769,-66},
          {769,-65},{783.8,-65},{783.8,130}},      color={0,0,127}));
  connect(ventRate2.y, Office2.ventRate) annotation (Line(points={{659,244},{672,
          244},{672,149},{694.04,149}}, color={0,0,127}));
  connect(weaBus, Office2.weaBus) annotation (Line(
      points={{-188,162},{-142,162},{-142,200},{692,200}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, Office2.ventTemp) annotation (Line(
      points={{-188,162},{252,162},{252,162},{694.04,162}},
      color={255,204,51},
      thickness=0.5));
  connect(Office2.TAir, control_building.Office2_Air_m) annotation (Line(
        points={{799.1,210},{828,210},{828,32},{674,32}}, color={0,0,127}));
  connect(ports_office1, Office1.ports[1:2]) annotation (Line(points={{537,108},
          {541.875,108},{541.875,134}},
                                      color={0,127,255}));
  connect(Table_Humans1.y[1],criticalDamping6. u)
    annotation (Line(points={{507,-14},{518,-14}}, color={0,0,127}));
  connect(Table_machine1.y[1],criticalDamping8. u)
    annotation (Line(points={{507,-42},{520,-42}}, color={0,0,127}));
  connect(Table_Light1.y[1],criticalDamping7. u) annotation (Line(points={{507,-70},
          {520,-70}},                          color={0,0,127}));
  connect(criticalDamping7.y, Office1.intGains[3]) annotation (Line(points={{543,-70},
          {576,-70},{576,130}},                                      color={0,0,
          127}));
  connect(criticalDamping8.y, Office1.intGains[2]) annotation (Line(points={{543,-42},
          {576,-42},{576,128}},                  color={0,0,127}));
  connect(criticalDamping6.y, Office1.intGains[1]) annotation (Line(points={{541,-14},
          {576,-14},{576,126}},                  color={0,0,127}));
  connect(ventRate1.y, Office1.ventRate) annotation (Line(points={{451,232},{451,
          150},{488,150},{488,149}}, color={0,0,127}));
  connect(Office1.TAir, control_building.Office1_Air_m) annotation (Line(
        points={{591,210},{632,210},{632,32},{674,32}}, color={0,0,127}));
  connect(weaBus, Office1.weaBus) annotation (Line(
      points={{-188,162},{-142,162},{-142,200},{486,200}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, Office1.ventTemp) annotation (Line(
      points={{-188,162},{488,162}},
      color={255,204,51},
      thickness=0.5));
  connect(ports_hall1, Hall1.ports[1:2]) annotation (Line(points={{327,110},{
          327,121},{333.875,121},{333.875,134}},
                                           color={0,127,255}));
  connect(Table_Humans.y[1],criticalDamping. u)
    annotation (Line(points={{303,-14},{318,-14}}, color={0,0,127}));
  connect(Table_Light.y[1],criticalDamping2. u)
    annotation (Line(points={{303,-70},{318,-70}}, color={0,0,127}));
  connect(Table_machine.y[1],criticalDamping1. u)
    annotation (Line(points={{303,-42},{318,-42}}, color={0,0,127}));
  connect(criticalDamping.y, Hall1.intGains[1])
    annotation (Line(points={{341,-14},{368,-14},{368,126}}, color={0,0,127}));
  connect(criticalDamping1.y, Hall1.intGains[2])
    annotation (Line(points={{341,-42},{368,-42},{368,128}}, color={0,0,127}));
  connect(criticalDamping2.y, Hall1.intGains[3])
    annotation (Line(points={{341,-70},{368,-70},{368,130}}, color={0,0,127}));
  connect(ventRate_hall1.y, Hall1.ventRate) annotation (Line(points={{251,238},
          {251,148},{280,148},{280,149}}, color={0,0,127}));
  connect(weaBus, Hall1.weaBus) annotation (Line(
      points={{-188,162},{-142,162},{-142,200},{278,200}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, Hall1.ventTemp) annotation (Line(
      points={{-188,162},{280,162}},
      color={255,204,51},
      thickness=0.5));
  connect(Hall1.TAir, control_building.Hall1_Air_m) annotation (Line(points={{383,210},
          {430.5,210},{430.5,32},{674,32}},           color={0,0,127}));
  connect(Hall1.intGainsRad, heat_port_rad_hall1) annotation (Line(points={{379,
          187},{379,187.5},{398,187.5},{398,2}}, color={191,0,0}));
  connect(Table_machine4.y[1],criticalDamping4. u)
    annotation (Line(points={{13,-46},{20,-46}}, color={0,0,127}));
  connect(Table_Light4.y[1],criticalDamping5. u)
    annotation (Line(points={{13,-74},{20,-74}}, color={0,0,127}));
  connect(Table_Humans4.y[1],criticalDamping3. u)
    annotation (Line(points={{13,-18},{20,-18}}, color={0,0,127}));
  connect(criticalDamping5.y, Hall2.intGains[3])
    annotation (Line(points={{43,-74},{72,-74},{72,130}},color={0,0,127}));
  connect(criticalDamping4.y, Hall2.intGains[2])
    annotation (Line(points={{43,-46},{72,-46},{72,128}},color={0,0,127}));
  connect(criticalDamping3.y, Hall2.intGains[1])
    annotation (Line(points={{43,-18},{72,-18},{72,126}},color={0,0,127}));
  connect(Hall2.intGainsRad, heat_port_rad_hall2) annotation (Line(points={{83,
          187},{83,185.5},{104,185.5},{104,-2}}, color={191,0,0}));
  connect(weaBus, Hall2.weaBus) annotation (Line(
      points={{-188,162},{-142,162},{-142,200},{-18,200}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, Hall2.ventTemp) annotation (Line(
      points={{-188,162},{-16,162}},
      color={255,204,51},
      thickness=0.5));
  connect(ventRate_hall2.y, Hall2.ventRate) annotation (Line(points={{-61,248},
          {-40,248},{-40,149},{-16,149}}, color={0,0,127}));
  connect(Hall2.TAir, control_building.Hall2_Air_m) annotation (Line(points={{87,210},
          {164,210},{164,32},{674,32}},          color={0,0,127}));
  connect(pipe_out_hall2.port_b,AirOut_Hall2. ports[1])
    annotation (Line(points={{-14,84},{-38,84}}, color={0,127,255}));
  connect(pipe_out_hall2.port_a, Hall2.ports[1])
    annotation (Line(points={{6,84},{32,84},{32,134}}, color={0,127,255}));
  connect(criticalDamping12.y, Office4.intGains[1]) annotation (Line(points={{
          949,-12},{996,-12},{996,76},{1204,76},{1204,126},{1184,126}}, color={
          0,0,127}));
  connect(criticalDamping14.y, Office4.intGains[2]) annotation (Line(points={{
          949,-40},{949,-28},{996,-28},{996,76},{1204,76},{1204,128},{1184,128}},
        color={0,0,127}));
  connect(criticalDamping13.y, Office4.intGains[3]) annotation (Line(points={{
          949,-68},{949,-28},{996,-28},{996,76},{1204,76},{1204,130},{1184,130}},
        color={0,0,127}));
  connect(criticalDamping12.y, Office5.intGains[1]) annotation (Line(points={{
          949,-12},{996,-12},{996,76},{1204,76},{1204,78},{1420,78},{1420,126},
          {1406,126}}, color={0,0,127}));
  connect(criticalDamping14.y, Office5.intGains[2]) annotation (Line(points={{
          949,-40},{949,-28},{996,-28},{996,76},{1420,76},{1420,128},{1406,128}},
        color={0,0,127}));
  connect(criticalDamping13.y, Office5.intGains[3]) annotation (Line(points={{
          949,-68},{949,-28},{996,-28},{996,76},{1420,76},{1420,130},{1406,130}},
        color={0,0,127}));
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
          extent={{-160,0},{1460,280}})));
end Buildings;
