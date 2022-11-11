within AixLib.Systems.CoupledBuildingEnergySystem;
model BuildingEnergySystem
  extends Modelica.Icons.Example;
  parameter Real kVal=0.2 "Gain of controller";
  parameter Modelica.Units.SI.Time TiVal=1800
    "Time constant of Integrator block";
  parameter Real kHP=0.01
                         "Gain of controller";
  parameter Modelica.Units.SI.Time TiHP=300 "Time constant of Integrator block";
  parameter Modelica.Units.SI.Volume V=0.1 "Volume of tank";

  parameter Modelica.Units.SI.HeatFlowRate QBui_flow_nominal[nRooms]={1125.6167,
      570.6886,680.91516,810.3087,793.1851,562.0106,675.3329,639.1092}
                                                                     "Nominal heat load of building";
  parameter AixLib.DataBase.Weather.TRYWeatherBaseDataDefinition weatherDataDay = AixLib.DataBase.Weather.TRYWinterDay();
    replaceable package MediumHydraulic = AixLib.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium
    annotation (choicesAllMatching=true);
  replaceable package MediumEva = AixLib.Media.Air constrainedby
    Modelica.Media.Interfaces.PartialMedium
    annotation (choicesAllMatching=true);
  parameter Modelica.Units.SI.MassFlowRate mRad_flow_nominal[nRooms] = QBui_flow_nominal/(4184*10)
    "Nominal mass flow rate of each radiator";
  parameter Modelica.Units.SI.Volume VHydraulic=0.01
                                                "Volume of hydraulic pipes";
  parameter Modelica.Units.SI.TemperatureDifference dTOffNight=5
    "Nigthly offset";
  parameter Modelica.Units.SI.Temperature TRoomMax=297.15  "Room with maximal temperature";
  Modelica.Blocks.Continuous.LimPID PI[nRooms](
    each final controllerType=Modelica.Blocks.Types.SimpleController.PI,
    each final k=kVal,
    each final Ti=TiVal,
    each final yMax=1,
    final yMin=val.l) "Simple PI control"
    annotation (Placement(transformation(extent={{20,80},{40,100}})));

  Fluid.Sources.Boundary_pT        sin(
    nPorts=1,
    redeclare package Medium = MediumEva)
              "Fluid sink on source side"
    annotation (Placement(transformation(extent={{-260,-80},{-240,-60}})));
  Fluid.Sources.MassFlowSource_T   sou(
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = MediumEva,
    T=283.15) "Fluid source on source side"
    annotation (Placement(transformation(extent={{-148,-80},{-168,-60}})));
  HeatPumpSystems.HeatPumpSystem heaPumSys(
    TEva_nominal=263.15,
    dTCon=8,
    redeclare package Medium_con = MediumHydraulic,
    redeclare package Medium_eva = MediumEva,
    use_conPum=true,
    use_evaPum=false,
    redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to8 perCon,
    heatingCurveRecord=
        AixLib.DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day23_Night10(),
    TRoom_nominal=TRoomMax,
    dataTable=AixLib.DataBase.HeatPump.EN255.Vitocal350BWH113(),
    use_deFro=false,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    refIneFre_constant=0.01,
    dpEva_nominal=0,
    deltaM_con=0.1,
    use_opeEnvFroRec=false,
    tableUpp=[-20,55; -10,60; -5,65; 30,65],
    minIceFac=0,
    use_chiller=true,
    calcPel_deFro=100,
    minRunTime(displayUnit="min"),
    minLocTime(displayUnit="min"),
    use_antLeg=false,
    use_refIne=true,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    minTimeAntLeg(displayUnit="min") = 900,
    scalingFactor=2,
    use_tableData=false,
    dpCon_nominal=0,
    use_conCap=true,
    CCon=3000,
    use_evaCap=true,
    CEva=3000,
    Q_flow_nominal=5000,
    cpEva=1004,
    cpCon=4184,
    use_secHeaGen=false,
    redeclare model TSetToNSet =
        AixLib.Controls.HeatPump.BaseClasses.InverterControlledHP (
        hys=5,
        k=kHP,
        Ti=TiHP),
    use_sec=true,
    QCon_nominal=sum(QBui_flow_nominal),
    P_el_nominal=heaPumSys.QCon_nominal/3,
    redeclare model PerDataHea =
        AixLib.DataBase.HeatPump.PerformanceData.VCLibMap,
    redeclare function HeatingCurveFunction =
        Controls.SetPoints.Functions.HeatingCurveFunction (TOffNig=5, TDesign=297.15),
    use_minRunTime=true,
    use_minLocTime=true,
    use_runPerHou=true,
    pre_n_start=true,
    TCon_nominal=328.15,
    TCon_start=313.15,
    TEva_start=283.15,
    use_revHP=false,
    VCon=0.004,
    VEva=0.004)
    annotation (Placement(transformation(extent={{-220,-78},{-180,-20}})));

  Modelica.Blocks.Sources.Constant natInf[11](each final k=0.1)
    "Constant natural infliltration rate" annotation (Placement(transformation(
        extent={{10.5,-10.5},{-10.5,10.5}},
        rotation=180,
        origin={109.5,18.5})));
  BoundaryConditions.WeatherData.Old.WeatherTRY.Weather wea(
    Latitude=49.5,
    Longitude=8.5,
    GroundReflection=0.2,
    tableName="wetter",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    SOD=AixLib.DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_RoofN_Roof_S(),

    Wind_dir=false,
    Wind_speed=true,
    Air_temp=true,
    fileName=
        "modelica://AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt",

    WeatherData(tableOnFile=false, table=weatherDataDay.weatherData))
    annotation (Placement(transformation(extent={{298,70},{229,115}})));

  ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope.WholeHouseBuildingEnvelope        OFD(
    redeclare DataBase.Walls.Collections.OFD.WSchV1995Heavy wallTypes,
    energyDynamicsWalls=Modelica.Fluid.Types.Dynamics.FixedInitial,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T0_air=294.15,
    TWalls_start=292.15,
    redeclare model WindowModel =
        ThermalZones.HighOrder.Components.WindowsDoors.WindowSimple,
    redeclare DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995 Type_Win,
    redeclare model CorrSolarGainWin =
        ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorGSimple,
    use_infiltEN12831=true,
    n50=4,
    withDynamicVentilation=false,
    UValOutDoors=2.9) annotation (Placement(transformation(extent={{161,-39},{256,
            56}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature temOut
    "Varying outdoor air temperature"
    annotation (Placement(transformation(extent={{200,70},{179.5,90}})));
  Utilities.Interfaces.Adaptors.ConvRadToCombPort heaStaToComHea[nRooms]
    "Combine rad and conv ports"
    annotation (Placement(transformation(extent={{128,-17},{106,0}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temGro[5](each final T=
       282.65) "Constant ground temperature"
    annotation (Placement(transformation(extent={{182,-80},{202,-60}})));
  Modelica.Blocks.Interfaces.RealOutput TAirRooms[10](each unit="K", each
      displayUnit="degC")                                            annotation(Placement(transformation(extent={{300,-49},
            {320,-29}}),                                                                                                                   iconTransformation(extent={{101,-7},{117,9}})));
  Fluid.HeatExchangers.Radiators.Radiator rad[nRooms](
    redeclare package Medium = MediumHydraulic,
    m_flow_nominal=mRad_flow_nominal,
    each selectable=false,
    each final radiatorType=
        AixLib.DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment.Radiator_Bedroom(),
    NominalPower=QBui_flow_nominal .* 1.2,
    each RT_nom={328.15,318.15,293.15},
    each calc_dT=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp.log)
    "Radiators" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={58,-10})));

  Fluid.Storage.BufferStorage bufSto(
    redeclare package Medium = MediumHydraulic,
    redeclare package MediumHC1 = MediumHydraulic,
    redeclare package MediumHC2 = MediumHydraulic,
    m1_flow_nominal=heaPumSys.mFlow_conNominal,
    m2_flow_nominal=sum(mRad_flow_nominal),
    mHC1_flow_nominal=0,
    mHC2_flow_nominal=0,
    useHeatingCoil1=false,
    useHeatingCoil2=false,
    useHeatingRod=false,
    redeclare AixLib.DataBase.Storage.BufferStorageBaseDataDefinition data(
      hTank=hTank,
      hLowerPortDemand=0,
      hUpperPortDemand=hTank,
      hLowerPortSupply=0,
      hUpperPortSupply=hTank,
      hHC1Up=hTank,
      hHC1Low=0,
      hHC2Up=hTank,
      lambdaWall=50,
      lambdaIns=0.045,
      hHC2Low=0,
      hHR=0,
      dTank=dTank,
      sWall(displayUnit="mm") = 0.005,
      sIns(displayUnit="mm") = 0.02,
      hTS1=0,
      hTS2=3,
      rhoIns=373,
      cIns=1000,
      rhoWall=373,
      cWall=1000,
      roughness=2.5e-5,
      pipeHC1=AixLib.DataBase.Pipes.Copper.Copper_14x1(),
      pipeHC2=AixLib.DataBase.Pipes.Copper.Copper_14x1(),
      lengthHC1=0,
      lengthHC2=0),
    redeclare model HeatTransfer =
        AixLib.Fluid.Storage.BaseClasses.HeatTransferBuoyancyWetter)
    annotation (Placement(transformation(extent={{-108,-40},{-76,0}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temBas(final T=291.15)
    "Constant basement temperature" annotation (Placement(transformation(
        extent={{-10.5,-10.5},{10.5,10.5}},
        rotation=0,
        origin={-89.5,-69.5})));
  Fluid.Movers.PumpsPolynomialBased.PumpHeadControlled pumHeaCtrlRad(
    redeclare package Medium = MediumHydraulic,
    m_flow_nominal=sum(mRad_flow_nominal),
    pumpParam=AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN25_H1_8_V9())
    "Pump to radiators"
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Fluid.MixingVolumes.MixingVolume retVol(
    final V=VHydraulic/2,
    final nPorts=nRooms + 1,
    redeclare each final package Medium = MediumHydraulic,
    each final m_flow_nominal=sum(mRad_flow_nominal)) "Volume of return flow"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-70})));

  Fluid.MixingVolumes.MixingVolume supVol(
    final V=VHydraulic/2,
    final nPorts=nRooms+1,
    redeclare each final package Medium = MediumHydraulic,
    each final m_flow_nominal=sum(mRad_flow_nominal)) "Volume of supply flow"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,10})));
  Fluid.Movers.PumpsPolynomialBased.BaseClasses.PumpBus pumBusRad
    "Bus for the radiator pump"
    annotation (Placement(transformation(extent={{-80,48},{-60,68}})));
  Fluid.Actuators.Valves.TwoWayLinear val[nRooms](redeclare package Medium =
        MediumHydraulic, m_flow_nominal=mRad_flow_nominal,
    each dpValve_nominal=100) "Thermostatic valve"
    annotation (Placement(transformation(extent={{28,10},{48,30}})));
  Modelica.Blocks.Sources.BooleanConstant booConPumOn(k=true)
    "Pump is always on"
    annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
  Modelica.Blocks.Sources.Constant conPumpAlwOnMax(k=pumHeaCtrlRad.pumpParam.nMax)
    "Pump is runs always at maximum speed"
    annotation (Placement(transformation(extent={{-156,50},{-136,70}})));
  Modelica.Blocks.Sources.Constant TRooSet[nRooms](final k={293.15,293.15,
        295.15,293.15,291.15,293.15,297.15,293.15}) "Room set-temperatures"
    annotation (Placement(transformation(extent={{-266,50},{-246,70}})));
  Modelica.Blocks.Sources.Constant conPumSouOn(k=heaPumSys.mFlow_evaNominal)
    "Constant mass flow rate for evaporator"
    annotation (Placement(transformation(extent={{-180,-100},{-160,-80}})));
  Fluid.Sources.Boundary_pT preBou(redeclare package Medium = MediumHydraulic,
      nPorts=1) "Pressure boundary"
    annotation (Placement(transformation(extent={{-262,-54},{-242,-34}})));
  Modelica.Blocks.Sources.RealExpression reaExpTRoo[nRooms](final y={OFD.groundFloor_Building.Livingroom.airload.heatPort.T,
        OFD.groundFloor_Building.Hobby.airload.heatPort.T,OFD.groundFloor_Building.WC_Storage.airload.heatPort.T,
        OFD.groundFloor_Building.Kitchen.airload.heatPort.T,OFD.upperFloor_Building.Bedroom.airload.heatPort.T,
        OFD.upperFloor_Building.Children1.airload.heatPort.T,OFD.upperFloor_Building.Bath.airload.heatPort.T,
        OFD.upperFloor_Building.Children2.airload.heatPort.T})
    "Room temperature measurements" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,60})));
  Modelica.Blocks.Sources.RealExpression realExpressionTAirs[10](y={OFD.groundFloor_Building.Livingroom.airload.heatPort.T,
        OFD.groundFloor_Building.Hobby.airload.heatPort.T,OFD.groundFloor_Building.Corridor.airload.heatPort.T,
        OFD.groundFloor_Building.WC_Storage.airload.heatPort.T,OFD.groundFloor_Building.Kitchen.airload.heatPort.T,
        OFD.upperFloor_Building.Bedroom.airload.heatPort.T,OFD.upperFloor_Building.Children1.airload.heatPort.T,
        OFD.upperFloor_Building.Corridor.airload.heatPort.T,OFD.upperFloor_Building.Bath.airload.heatPort.T,
        OFD.upperFloor_Building.Children2.airload.heatPort.T})   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={280,-40})));
  Modelica.Blocks.Interfaces.RealOutput dTComfort[8] annotation (Placement(
        transformation(extent={{300,-69},{320,-49}}), iconTransformation(extent=
           {{101,-7},{117,9}})));
  Modelica.Blocks.Continuous.Integrator integrator[nRooms]
    annotation (Placement(transformation(extent={{260,-70},{280,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpression1
                                                       [nRooms](final y=abs(PI.u_s
         .- PI.u_m))                                            annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={238,-60})));
  Modelica.Blocks.Continuous.Integrator integratorEl
    annotation (Placement(transformation(extent={{260,-100},{280,-80}})));
  Modelica.Blocks.Interfaces.RealOutput Wel(each unit="J") annotation (
      Placement(transformation(extent={{300,-91},{320,-71}}),
        iconTransformation(extent={{101,-7},{117,9}})));
  Modelica.Blocks.Sources.RealExpression realExpressionPel(final y=heaPumSys.heatPump.sigBus.PelMea)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={238,-90})));
  Modelica.Blocks.Sources.Pulse offNight[nRooms](
    each final amplitude=dTOffNight,
    each final width=(heaPumSys.night_hour - heaPumSys.day_hour)/24*100,
    each final period=86400,
    each final nperiod=-1,
    each final offset=-dTOffNight,
    each final startTime=heaPumSys.day_hour*3600) "Night setback"
    annotation (Placement(transformation(extent={{-240,80},{-220,100}})));
  Modelica.Blocks.Math.Add add[nRooms](each final k1=+1, each final k2=+1)
    annotation (Placement(transformation(extent={{-200,74},{-180,94}})));

  Modelica.Blocks.Sources.RealExpression reaExpTRooMax(final y=OFD.upperFloor_Building.Bath.airload.heatPort.T)
    "Maximal room temperature is in bath" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-250,-10})));
protected
  parameter Real heiToDiaRatio=2 "Ratio of height to diameter";
  parameter Integer nRooms = 8 "Number of rooms";
  parameter Modelica.Units.SI.Height hTank=dTank*heiToDiaRatio "Height of storage";
  parameter Modelica.Units.SI.Diameter dTank=(V*4/(heiToDiaRatio*Modelica.Constants.pi)) "Inner diameter of storage";
equation

  connect(sin.ports[1], heaPumSys.port_b2) annotation (Line(points={{-240,-70},
          {-228,-70},{-228,-69.7143},{-220,-69.7143}},color={0,127,255}));
  connect(sou.ports[1], heaPumSys.port_a2) annotation (Line(points={{-168,-70},
          {-170,-70},{-170,-69.7143},{-180,-69.7143}},color={0,127,255}));
  connect(wea.WindSpeed, OFD.WindSpeedPort) annotation (Line(points={{226.7,106},
          {148,106},{148,41.75},{156.25,41.75}}, color={0,0,127}));
  connect(temOut.port, OFD.thermOutside) annotation (Line(points={{179.5,80},{
          161,80},{161,55.05}},
                            color={191,0,0}));
  connect(temOut.T, wea.AirTemp) annotation (Line(points={{202.05,80},{220,80},
          {220,99.25},{226.7,99.25}}, color={0,0,127}));
  connect(wea.SolarRadiation_OrientedSurfaces[1], OFD.North) annotation (Line(
        points={{281.44,67.75},{272,67.75},{272,22.75},{258.85,22.75}}, color={
          255,128,0}));
  connect(wea.SolarRadiation_OrientedSurfaces[2], OFD.East) annotation (Line(
        points={{281.44,67.75},{272,67.75},{272,8.5},{258.85,8.5}}, color={255,
          128,0}));
  connect(wea.SolarRadiation_OrientedSurfaces[3], OFD.South) annotation (Line(
        points={{281.44,67.75},{272,67.75},{272,-5.75},{258.85,-5.75}}, color={
          255,128,0}));
  connect(wea.SolarRadiation_OrientedSurfaces[4], OFD.West) annotation (Line(
        points={{281.44,67.75},{272,67.75},{272,-4},{266,-4},{266,-20},{258.85,
          -20}}, color={255,128,0}));
  connect(wea.SolarRadiation_OrientedSurfaces[5], OFD.SolarRadiationPort_RoofN)
    annotation (Line(points={{281.44,67.75},{272,67.75},{272,51.25},{258.85,
          51.25}}, color={255,128,0}));
  connect(wea.SolarRadiation_OrientedSurfaces[6], OFD.SolarRadiationPort_RoofS)
    annotation (Line(points={{281.44,67.75},{272,67.75},{272,37},{258.85,37}},
        color={255,128,0}));

  connect(temGro.port, OFD.groundTemp) annotation (Line(points={{202,-70},{
          208.5,-70},{208.5,-39}},
                             color={191,0,0}));
  connect(OFD.uppFloDown,OFD. groFloUp) annotation (Line(points={{161,19.9},{161,
          8.5}},                                                                                             color={191,0,0}));
  connect(OFD.groFloDown,OFD. groPlateUp) annotation (Line(points={{161,-18.1},{
          161,-29.5}},                                                                                                                   color={191,0,0}));
  connect(heaStaToComHea[1].portConvRadComb, OFD.heatingToRooms[1]) annotation (
     Line(points={{128,-8.5},{128,-6.95909},{161,-6.95909}},            color={191,
          0,0}));
  connect(heaStaToComHea[2].portConvRadComb, OFD.heatingToRooms[2]) annotation (
     Line(points={{128,-8.5},{128,-6.52727},{161,-6.52727}},            color={191,
          0,0}));
  connect(heaStaToComHea[3].portConvRadComb, OFD.heatingToRooms[4]) annotation (
     Line(points={{128,-8.5},{128,-5.66364},{161,-5.66364}},            color={191,
          0,0}));
  connect(heaStaToComHea[4].portConvRadComb, OFD.heatingToRooms[5]) annotation (
     Line(points={{128,-8.5},{128,-5.23182},{161,-5.23182}},            color={191,
          0,0}));
  connect(heaStaToComHea[5].portConvRadComb, OFD.heatingToRooms[6]) annotation (
     Line(points={{128,-8.5},{128,-4.8},{161,-4.8}},            color={191,0,0}));
  connect(heaStaToComHea[6].portConvRadComb, OFD.heatingToRooms[7]) annotation (
     Line(points={{128,-8.5},{128,-4.36818},{161,-4.36818}},            color={191,
          0,0}));
  connect(heaStaToComHea[7].portConvRadComb, OFD.heatingToRooms[9]) annotation (
     Line(points={{128,-8.5},{128,-3.50455},{161,-3.50455}},            color={191,
          0,0}));
  connect(heaStaToComHea[8].portConvRadComb, OFD.heatingToRooms[10])
    annotation (Line(points={{128,-8.5},{128,-3.07273},{161,-3.07273}},
        color={191,0,0}));

  connect(rad.RadiativeHeat, heaStaToComHea.portRad) annotation (Line(points={{60,-14},
          {60,-8},{68,-8},{68,-3.1875},{106,-3.1875}},     color={0,0,0}));
  connect(wea.AirTemp, heaPumSys.T_oda) annotation (Line(points={{226.7,99.25},
          {226.7,122},{-276,122},{-276,-52},{-238,-52},{-238,-32.6357},{-223,
          -32.6357}}, color={0,0,127}));
  connect(temBas.port, bufSto.heatportOutside) annotation (Line(points={{-79,
          -69.5},{-79,-70},{-70,-70},{-70,-18.8},{-76.4,-18.8}},
                                       color={191,0,0}));
  connect(pumHeaCtrlRad.port_a, bufSto.fluidportTop2) annotation (Line(points={{-40,20},
          {-87,20},{-87,0.2}},           color={0,127,255}));
  connect(retVol.ports[1], bufSto.fluidportBottom2) annotation (Line(points={{
          1.9984e-15,-60},{1.9984e-15,-52},{-87.4,-52},{-87.4,-40.2}},
                                                       color={0,127,255}));
  connect(supVol.ports[1], pumHeaCtrlRad.port_b)
    annotation (Line(points={{1.9984e-15,20},{-20,20}},
                                                 color={0,127,255}));
 for i in 1:nRooms loop
    connect(rad[i].port_b, retVol.ports[i + 1]) annotation (Line(points={{58,-20},
            {58,-54},{1.77636e-15,-54},{1.77636e-15,-60}},
                                           color={0,127,255}));
  connect(supVol.ports[i+1], val[i].port_a)
    annotation (Line(points={{1.77636e-15,20},{28,20}},   color={0,127,255}));
 end for;

  connect(sou.T_in, wea.AirTemp) annotation (Line(
      points={{-146,-66},{-126,-66},{-126,-98},{-276,-98},{-276,122},{216,122},
          {216,99.25},{226.7,99.25}},
      color={0,0,127},
      thickness=0.5));
  connect(heaPumSys.port_b1, bufSto.fluidportTop1) annotation (Line(points={{-180,
          -44.8571},{-166,-44.8571},{-166,6},{-97.6,6},{-97.6,0.2}},   color={0,
          127,255}));
  connect(pumHeaCtrlRad.pumpBus, pumBusRad) annotation (Line(
      points={{-30,30},{-30,52},{-70,52},{-70,58}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));

  connect(rad.ConvectiveHeat, heaStaToComHea.portConv) annotation (Line(points={{60,-8},
          {68,-8},{68,-13.8125},{106,-13.8125}},        color={191,0,0}));
  connect(val.port_b, rad.port_a)
    annotation (Line(points={{48,20},{58,20},{58,0}}, color={0,127,255}));
  connect(booConPumOn.y, pumBusRad.onSet) annotation (Line(points={{-99,60},{
          -66,60},{-66,58.05},{-69.95,58.05}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(conPumpAlwOnMax.y, pumBusRad.rpmSet) annotation (Line(points={{-135,60},
          {-130,60},{-130,72},{-69.95,72},{-69.95,58.05}},
                                       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(conPumSouOn.y, sou.m_flow_in) annotation (Line(points={{-159,-90},{
          -134,-90},{-134,-62},{-146,-62}},
                                       color={0,0,127}));
  connect(preBou.ports[1], heaPumSys.port_a1) annotation (Line(points={{-242,
          -44},{-242,-44.8571},{-220,-44.8571}},
                                            color={0,127,255}));
  connect(heaPumSys.port_a1, bufSto.fluidportBottom1) annotation (Line(points={{-220,
          -44.8571},{-232,-44.8571},{-232,-8},{-158,-8},{-158,-46},{-97.4,-46},
          {-97.4,-40.4}},       color={0,127,255}));
  connect(PI.y, val.y) annotation (Line(points={{41,90},{46,90},{46,70},{38,70},
          {38,32}}, color={0,0,127}));
  connect(realExpressionTAirs.y, TAirRooms) annotation (Line(points={{291,-40},
          {294,-40},{294,-39},{310,-39}},color={0,0,127}));
  connect(reaExpTRoo.y, PI.u_m)
    annotation (Line(points={{30,71},{30,78}}, color={0,0,127}));
  connect(integrator.y, dTComfort) annotation (Line(points={{281,-60},{294,-60},
          {294,-59},{310,-59}}, color={0,0,127}));
  connect(integrator.u, realExpression1.y)
    annotation (Line(points={{258,-60},{249,-60}}, color={0,0,127}));
  connect(integratorEl.y, Wel) annotation (Line(points={{281,-90},{292,-90},{
          292,-81},{310,-81}}, color={0,0,127}));
  connect(realExpressionPel.y, integratorEl.u)
    annotation (Line(points={{249,-90},{258,-90}}, color={0,0,127}));
  connect(add.y, PI.u_s)
    annotation (Line(points={{-179,84},{10,84},{10,90},{18,90}},
                                               color={0,0,127}));
  connect(add.u2, TRooSet.y) annotation (Line(points={{-202,78},{-206,78},{-206,
          60},{-245,60}}, color={0,0,127}));
  connect(offNight.y, add.u1)
    annotation (Line(points={{-219,90},{-202,90}},         color={0,0,127}));
  connect(reaExpTRooMax.y, heaPumSys.TAct) annotation (Line(points={{-239,-10},
          {-230,-10},{-230,-23.9357},{-223,-23.9357}},
                                                color={0,0,127}));
  connect(natInf.y, OFD.AirExchangePort) annotation (Line(points={{121.05,18.5},
          {146,18.5},{146,32.25},{156.25,32.25}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-280,
            -100},{300,120}})),
                          Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-280,-100},{300,120}}), graphics={                                                                                           Rectangle(extent={{129,-40},
              {168,-100}},                                                                                                                                                                lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{132,-54},
              {168,-92}},                                                                                                                                                            lineColor={0,0,255},
          textString="1-Bedroom
2-Child1
3-Corridor
4-Bath
5-Child2",horizontalAlignment=TextAlignment.Left),                                                                                                                                                                                                        Text(extent={{151,-52},
              {167,-41}},                                                                                                                                                                               lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "UF"), Rectangle(extent={{86,-40},
              {128,-100}},                                                                                                                                                                                    lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{111,-52},
              {127,-41}},                                                                                                                                                             lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "GF"),                                                                                                                       Text(extent={{89,-54},
              {128,-91}},                                                                                                                                                                               lineColor={0,0,255},
          textString="1-Livingroom
2-Hobby
3-Corridor
4-WC
5-Kitchen",
          horizontalAlignment=TextAlignment.Left),
        Rectangle(
          extent={{-274,40},{-128,-100}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Text(
          extent={{-284,40},{-124,22}},
          textColor={28,108,200},
          textString="Energy conversion"),
        Rectangle(
          extent={{-124,40},{-60,-100}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Text(
          extent={{-140,-84},{-40,-100}},
          textColor={28,108,200},
          textString="Storage"),
        Rectangle(
          extent={{-56,40},{18,-100}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Text(
          extent={{-50,-70},{40,-100}},
          textColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textString="Heat
distribution"),
        Rectangle(
          extent={{22,40},{82,-100}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Text(
          extent={{26,-54},{84,-114}},
          textColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textString="Heat
transfer"),
        Rectangle(
          extent={{86,62},{300,-100}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Text(
          extent={{90,76},{148,16}},
          textColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textString="Building
envelope"),
        Rectangle(
          extent={{-168,120},{82,44}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Text(
          extent={{-190,120},{-90,104}},
          textColor={28,108,200},
          textString="Control"),
        Rectangle(
          extent={{86,120},{300,66}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Text(
          extent={{68,118},{168,102}},
          textColor={28,108,200},
          textString="Weather"),
        Rectangle(
          extent={{-274,120},{-172,44}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Text(
          extent={{-302,118},{-202,102}},
          textColor={28,108,200},
          textString="User")}),
    experiment(
      StopTime=432000,
      Interval=900.00288,
      __Dymola_Algorithm="Dassl"));
end BuildingEnergySystem;
