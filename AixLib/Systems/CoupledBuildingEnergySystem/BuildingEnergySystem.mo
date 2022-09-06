within AixLib.Systems.CoupledBuildingEnergySystem;
model BuildingEnergySystem
  extends Modelica.Icons.Example;
  parameter Real kVal=0.2 "Gain of controller";
  parameter Modelica.Units.SI.Time TiVal=1800
    "Time constant of Integrator block";
  parameter Real kHP=0.1 "Gain of controller";
  parameter Modelica.Units.SI.Time TiHP=500 "Time constant of Integrator block";
  parameter Modelica.Units.SI.Volume V=0.2 "Volume of tank";

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

  Modelica.Blocks.Continuous.LimPID PI[nRooms](
    each final controllerType=Modelica.Blocks.Types.SimpleController.PI,
    each final k=kVal,
    each final Ti=TiVal,
    each final yMax=1,
    final yMin=val.l)
    annotation (Placement(transformation(extent={{20,80},{40,100}})));

  Fluid.Sources.Boundary_pT        sin(
    nPorts=1,
    redeclare package Medium = MediumEva)
              "Fluid sink on source side"
    annotation (Placement(transformation(extent={{-280,-100},{-260,-80}})));
  Fluid.Sources.MassFlowSource_T   sou(
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = MediumEva,
    T=283.15) "Fluid source on source side"
    annotation (Placement(transformation(extent={{-140,-80},{-160,-60}})));
  HeatPumpSystems.HeatPumpSystem heatPumpSystem(
    TEva_nominal=263.15,
    dTCon=8,
    redeclare package Medium_con = MediumHydraulic,
    redeclare package Medium_eva = MediumEva,
    use_conPum=true,
    use_evaPum=false,
    redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to8 perCon,
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
    scalingFactor=1,
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
    P_el_nominal=heatPumpSystem.QCon_nominal/3,
    redeclare model PerDataHea =
        AixLib.DataBase.HeatPump.PerformanceData.VCLibMap,
    redeclare function HeatingCurveFunction =
        Controls.SetPoints.Functions.HeatingCurveFunction (TOffNig=0, TDesign=328.15),
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

  Modelica.Blocks.Sources.Constant NaturalVentilation[5](each k=0.1)
    annotation (Placement(transformation(extent={{100,60},{79,81}})));
  BoundaryConditions.WeatherData.Old.WeatherTRY.Weather        Weather(
    Latitude=49.5,
    Longitude=8.5,
    GroundReflection=0.2,
    tableName="wetter",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    SOD=AixLib.DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_RoofN_Roof_S(),
    Wind_dir=false,
    Wind_speed=true,
    Air_temp=true,
    fileName="modelica://AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt",
    WeatherData(tableOnFile=false, table=weatherDataDay.weatherData))
    annotation (Placement(transformation(extent={{300,58},{231,103}})));

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
    UValOutDoors=2.9) annotation (Placement(transformation(extent={{121,-47},
            {216,48}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempOutside
    annotation (Placement(transformation(extent={{160,60},{139.5,80}})));
  Utilities.Interfaces.Adaptors.ConvRadToCombPort heatStarToCombHeaters[nRooms]
    annotation (Placement(transformation(extent={{100,-17},{78,0}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature tempGround[5](T=fill(273.15
         + 9, 5))
    annotation (Placement(transformation(extent={{140,-80},{160,-60}})));
  Modelica.Blocks.Interfaces.RealOutput TAirRooms[10](each unit="K", each
      displayUnit="degC")                                            annotation(Placement(transformation(extent={{300,-49},
            {320,-29}}),                                                                                                                   iconTransformation(extent={{101,-7},{117,9}})));
  Fluid.HeatExchangers.Radiators.Radiator radiator[nRooms](
    redeclare package Medium = MediumHydraulic,
    m_flow_nominal=mRad_flow_nominal,
    each selectable=false,
    each final radiatorType=
        AixLib.DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment.Radiator_Bedroom(),
    each RT_nom={328.15,318.15,293.15},
    each calc_dT=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp.log)
                                                           annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={52,10})));

  Fluid.Storage.BufferStorage bufferStorage(
    redeclare package Medium = MediumHydraulic,
    redeclare package MediumHC1 = MediumHydraulic,
    redeclare package MediumHC2 = MediumHydraulic,
    m1_flow_nominal=heatPumpSystem.mFlow_conNominal,
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
    annotation (Placement(transformation(extent={{-102,-52},{-60,0}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature tempBasement(T=291.15)
    annotation (Placement(transformation(extent={{-100,-100},{-79,-79}})));
  Fluid.Movers.PumpsPolynomialBased.PumpHeadControlled pumpHeadControlledRad(
      redeclare package Medium = MediumHydraulic,
    m_flow_nominal=sum(mRad_flow_nominal),
    pumpParam=AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN25_H1_8_V9())
                                                  "Pump to radiators"
    annotation (Placement(transformation(extent={{-60,22},{-40,42}})));
  Fluid.MixingVolumes.MixingVolume returnVol(
    final V=VHydraulic/2,
    final nPorts=nRooms+1,
    redeclare each final package Medium = MediumHydraulic,
    each final m_flow_nominal=sum(mRad_flow_nominal)) "Volume of return flow"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-30,-70})));

  Fluid.MixingVolumes.MixingVolume supVol(
    final V=VHydraulic/2,
    final nPorts=nRooms+1,
    redeclare each final package Medium = MediumHydraulic,
    each final m_flow_nominal=sum(mRad_flow_nominal)) "Volume of supply flow"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,30})));
  Fluid.Movers.PumpsPolynomialBased.BaseClasses.PumpBus pumpBusRad
    annotation (Placement(transformation(extent={{-60,48},{-40,68}})));
  Fluid.Actuators.Valves.TwoWayLinear val[nRooms](redeclare package Medium =
        MediumHydraulic, m_flow_nominal=mRad_flow_nominal,
    each dpValve_nominal=100)
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstantPumpOn(k=true)
    annotation (Placement(transformation(extent={{-120,42},{-100,62}})));
  Modelica.Blocks.Sources.Constant constPumpHPSOn1(k=pumpHeadControlledRad.pumpParam.nMax)
    annotation (Placement(transformation(extent={{-120,80},{-100,100}})));
  Modelica.Blocks.Sources.Constant TRoomSet[nRooms](final k={293.15,293.15,295.15,
        293.15,291.15,293.15,297.15,293.15})
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  Modelica.Blocks.Sources.Constant constPumpHPSOn2(k=heatPumpSystem.mFlow_evaNominal)
    annotation (Placement(transformation(extent={{-180,-100},{-160,-80}})));
  Fluid.Sources.Boundary_pT        sin1(redeclare package Medium =
        MediumHydraulic, nPorts=1)
              "Fluid sink on source side"
    annotation (Placement(transformation(extent={{-280,-40},{-260,-20}})));
  Modelica.Blocks.Sources.RealExpression realExpression[nRooms](final y={OFD.groundFloor_Building.Livingroom.airload.heatPort.T,
        OFD.groundFloor_Building.Hobby.airload.heatPort.T,OFD.groundFloor_Building.WC_Storage.airload.heatPort.T,
        OFD.groundFloor_Building.Kitchen.airload.heatPort.T,OFD.upperFloor_Building.Bedroom.airload.heatPort.T,
        OFD.upperFloor_Building.Children1.airload.heatPort.T,OFD.upperFloor_Building.Bath.airload.heatPort.T,
        OFD.upperFloor_Building.Children2.airload.heatPort.T})  annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,54})));
  Modelica.Blocks.Sources.RealExpression realExpressionTAirs[10](y={OFD.groundFloor_Building.Livingroom.airload.heatPort.T,
        OFD.groundFloor_Building.Hobby.airload.heatPort.T,OFD.groundFloor_Building.Corridor.airload.heatPort.T,
        OFD.groundFloor_Building.WC_Storage.airload.heatPort.T,OFD.groundFloor_Building.Kitchen.airload.heatPort.T,
        OFD.upperFloor_Building.Bedroom.airload.heatPort.T,OFD.upperFloor_Building.Children1.airload.heatPort.T,
        OFD.upperFloor_Building.Corridor.airload.heatPort.T,OFD.upperFloor_Building.Bath.airload.heatPort.T,
        OFD.upperFloor_Building.Children2.airload.heatPort.T})   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={268,-40})));
  Modelica.Blocks.Interfaces.RealOutput dTComfort[8] annotation (Placement(
        transformation(extent={{300,-69},{320,-49}}), iconTransformation(extent
          ={{101,-7},{117,9}})));
  Modelica.Blocks.Continuous.Integrator integrator[nRooms]
    annotation (Placement(transformation(extent={{260,-70},{280,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpression1
                                                       [nRooms](final y=PI.u_s
         .- PI.u_m)                                             annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={238,-60})));
  Modelica.Blocks.Continuous.Integrator integratorEl
    annotation (Placement(transformation(extent={{260,-100},{280,-80}})));
  Modelica.Blocks.Interfaces.RealOutput Wel(each unit="J") annotation (
      Placement(transformation(extent={{300,-91},{320,-71}}),
        iconTransformation(extent={{101,-7},{117,9}})));
  Modelica.Blocks.Sources.RealExpression realExpressionPel(final y=
        heatPumpSystem.heatPump.sigBus.PelMea) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={238,-90})));
protected
  parameter Real heiToDiaRatio=2 "Ratio of height to diameter";
  parameter Integer nRooms = 8 "Number of rooms";
  parameter Modelica.Units.SI.Height hTank=dTank*heiToDiaRatio "Height of storage";
  parameter Modelica.Units.SI.Diameter dTank=(V*4/(heiToDiaRatio*Modelica.Constants.pi)) "Inner diameter of storage";
equation

  connect(sin.ports[1],heatPumpSystem. port_b2) annotation (Line(points={{-260,
          -90},{-228,-90},{-228,-69.7143},{-220,-69.7143}},
                                       color={0,127,255}));
  connect(sou.ports[1],heatPumpSystem. port_a2)
    annotation (Line(points={{-160,-70},{-170,-70},{-170,-69.7143},{-180,
          -69.7143}},                                     color={0,127,255}));
  connect(Weather.WindSpeed,OFD. WindSpeedPort) annotation (Line(points={{228.7,
          94},{108,94},{108,42},{106,42},{106,33.75},{116.25,33.75}},
                                                          color={0,0,127}));
  connect(tempOutside.port,OFD. thermOutside) annotation (Line(points={{139.5,70},
          {121,70},{121,47.05}},         color={191,0,0}));
  connect(tempOutside.T,Weather. AirTemp) annotation (Line(points={{162.05,70},{
          222,70},{222,87.25},{228.7,87.25}},
                                            color={0,0,127}));
  connect(Weather.SolarRadiation_OrientedSurfaces[1],OFD. North) annotation (
      Line(points={{283.44,55.75},{272,55.75},{272,14.75},{218.85,14.75}},
                                                              color={255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[2],OFD. East) annotation (
      Line(points={{283.44,55.75},{272,55.75},{272,0.5},{218.85,0.5}},
                                                                color={255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[3],OFD. South) annotation (
      Line(points={{283.44,55.75},{272,55.75},{272,-13.75},{218.85,-13.75}},
                                                                color={255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[4],OFD. West) annotation (
      Line(points={{283.44,55.75},{272,55.75},{272,-12},{226,-12},{226,-28},{218.85,
          -28}},                                                  color={255,128,
          0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[5],OFD. SolarRadiationPort_RoofN)
    annotation (Line(points={{283.44,55.75},{272,55.75},{272,43.25},{218.85,43.25}},
                                                                          color=
         {255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[6],OFD. SolarRadiationPort_RoofS)
    annotation (Line(points={{283.44,55.75},{272,55.75},{272,29},{218.85,29}},
                                                                          color=
         {255,128,0}));
  connect(NaturalVentilation[1].y,OFD. AirExchangePort[1]) annotation (Line(
        points={{77.95,70.5},{78,70.5},{78,22.0909},{116.25,22.0909}},
                                                                     color={0,0,
          127}));
  connect(NaturalVentilation[1].y,OFD. AirExchangePort[6]) annotation (Line(
        points={{77.95,70.5},{78,70.5},{78,24.25},{116.25,24.25}}, color={0,0,127}));
  connect(NaturalVentilation[2].y,OFD. AirExchangePort[2]) annotation (Line(
        points={{77.95,70.5},{78,70.5},{78,22.5227},{116.25,22.5227}},
                                                                   color={0,0,127}));
  connect(NaturalVentilation[2].y,OFD. AirExchangePort[7]) annotation (Line(
        points={{77.95,70.5},{78,70.5},{78,24.6818},{116.25,24.6818}},
                                                                   color={0,0,127}));
  connect(NaturalVentilation[3].y,OFD. AirExchangePort[4]) annotation (Line(
        points={{77.95,70.5},{78,70.5},{78,23.3864},{116.25,23.3864}},
                                                                   color={0,0,127}));
  connect(NaturalVentilation[3].y,OFD. AirExchangePort[9]) annotation (Line(
        points={{77.95,70.5},{78,70.5},{78,25.5455},{116.25,25.5455}},
                                                                   color={0,0,127}));
  connect(NaturalVentilation[4].y,OFD. AirExchangePort[5]) annotation (Line(
        points={{77.95,70.5},{78,70.5},{78,23.8182},{116.25,23.8182}},
                                                                   color={0,0,127}));
  connect(NaturalVentilation[4].y,OFD. AirExchangePort[10]) annotation (Line(
        points={{77.95,70.5},{78,70.5},{78,25.9773},{116.25,25.9773}},
                                                                   color={0,0,127}));
  connect(NaturalVentilation[5].y,OFD. AirExchangePort[3]) annotation (Line(
        points={{77.95,70.5},{78,70.5},{78,22.9545},{116.25,22.9545}},
                                                                   color={0,0,127}));
  connect(NaturalVentilation[5].y,OFD. AirExchangePort[8]) annotation (Line(
        points={{77.95,70.5},{78,70.5},{78,25.1136},{116.25,25.1136}},
                                                                   color={0,0,127}));
  connect(NaturalVentilation[5].y, OFD. AirExchangePort[11]) annotation (Line(
        points={{77.95,70.5},{78,70.5},{78,26.4091},{116.25,26.4091}},
                                                                   color={0,0,127}));
  connect(tempGround.port,OFD. groundTemp) annotation (Line(points={{160,-70},{160,
          -68},{168.5,-68},{168.5,-47}},
                              color={191,0,0}));
  connect(OFD.uppFloDown,OFD. groFloUp) annotation (Line(points={{121,11.9},{109,
          11.9},{109,0.5},{121,0.5}},                                                                        color={191,0,0}));
  connect(OFD.groFloDown,OFD. groPlateUp) annotation (Line(points={{121,-26.1},{
          115,-26.1},{115,-26},{109,-26},{109,-37.5},{121,-37.5}},                                                                       color={191,0,0}));
  connect(heatStarToCombHeaters[1].portConvRadComb, OFD.heatingToRooms[1]) annotation (Line(points={{100,
          -8.5},{100,-14.9591},{121,-14.9591}},                                                                                                             color={191,0,0}));
  connect(heatStarToCombHeaters[2].portConvRadComb, OFD.heatingToRooms[2]) annotation (Line(points={{100,
          -8.5},{100,-14.5273},{121,-14.5273}},                                                                                                             color={191,0,0}));
  connect(heatStarToCombHeaters[3].portConvRadComb, OFD.heatingToRooms[4]) annotation (Line(points={{100,
          -8.5},{100,-13.6636},{121,-13.6636}},                                                                                                             color={191,0,0}));
  connect(heatStarToCombHeaters[4].portConvRadComb, OFD.heatingToRooms[5]) annotation (Line(points={{100,
          -8.5},{100,-13.2318},{121,-13.2318}},                                                                                                             color={191,0,0}));
  connect(heatStarToCombHeaters[5].portConvRadComb, OFD.heatingToRooms[6]) annotation (Line(points={{100,
          -8.5},{100,-12.8},{121,-12.8}},                                                                                                                   color={191,0,0}));
  connect(heatStarToCombHeaters[6].portConvRadComb, OFD.heatingToRooms[7]) annotation (Line(points={{100,
          -8.5},{100,-12.3682},{121,-12.3682}},                                                                                                       color={191,0,0}));
  connect(heatStarToCombHeaters[7].portConvRadComb, OFD.heatingToRooms[9]) annotation (Line(points={{100,
          -8.5},{100,-11.5045},{121,-11.5045}},                                                                                                             color={191,0,0}));
  connect(heatStarToCombHeaters[8].portConvRadComb, OFD.heatingToRooms[10]) annotation (Line(points={{100,
          -8.5},{100,-11.0727},{121,-11.0727}},                                                                                                             color={191,0,0}));

  connect(radiator.RadiativeHeat, heatStarToCombHeaters.portRad) annotation (
      Line(points={{56,12},{56,-3.1875},{78,-3.1875}},             color={0,0,0}));
  connect(Weather.AirTemp, heatPumpSystem.T_oda) annotation (Line(points={{228.7,
          87.25},{228.7,86},{214,86},{214,100},{-132,100},{-132,0},{-232,0},{
          -232,-32.6357},{-223,-32.6357}},
        color={0,0,127}));
  connect(bufferStorage.TTop, heatPumpSystem.TAct) annotation (Line(points={{-102,
          -3.12},{-102,-2},{-223,-2},{-223,-23.9357}},
        color={0,0,127}));
  connect(tempBasement.port, bufferStorage.heatportOutside) annotation (Line(
        points={{-79,-89.5},{-50,-89.5},{-50,-24.44},{-60.525,-24.44}}, color={191,
          0,0}));
  connect(pumpHeadControlledRad.port_a, bufferStorage.fluidportTop2)
    annotation (Line(points={{-60,32},{-74.4375,32},{-74.4375,0.26}}, color={0,127,
          255}));
  connect(returnVol.ports[1], bufferStorage.fluidportBottom2) annotation (Line(
        points={{-30,-60},{-30,-54},{-54,-54},{-54,-58},{-74.9625,-58},{-74.9625,
          -52.26}}, color={0,127,255}));
  connect(supVol.ports[1], pumpHeadControlledRad.port_b) annotation (Line(
        points={{-10,20},{-10,14},{-34,14},{-34,32},{-40,32}}, color={0,127,255}));
 for i in 1:nRooms loop
  connect(radiator[i].port_b, returnVol.ports[i+1]) annotation (Line(points={{62,10},
            {62,-54},{-30,-54},{-30,-60}},        color={0,127,255}));
  connect(supVol.ports[i+1], val[i].port_a)
    annotation (Line(points={{-10,20},{-6,20},{-6,10},{0,10}},
                                                          color={0,127,255}));
 end for;

  connect(sou.T_in, Weather.AirTemp) annotation (Line(points={{-138,-66},{-122,
          -66},{-122,0},{-130,0},{-130,100},{216,100},{216,87.25},{228.7,87.25}},
                                                         color={0,0,127}));
  connect(heatPumpSystem.port_b1, bufferStorage.fluidportTop1) annotation (Line(
        points={{-180,-44.8571},{-172,-44.8571},{-172,6},{-88.35,6},{-88.35,
          0.26}},
        color={0,127,255}));
  connect(pumpHeadControlledRad.pumpBus, pumpBusRad) annotation (Line(
      points={{-50,42},{-50,58}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));

  connect(radiator.ConvectiveHeat, heatStarToCombHeaters.portConv) annotation (
      Line(points={{50,12},{50,-14},{64,-14},{64,-13.8125},{78,-13.8125}},
                                                                 color={191,0,0}));
  connect(val.port_b, radiator.port_a)
    annotation (Line(points={{20,10},{42,10}}, color={0,127,255}));
  connect(booleanConstantPumpOn.y, pumpBusRad.onSet) annotation (Line(points={{-99,52},
          {-66,52},{-66,58.05},{-49.95,58.05}},                color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(constPumpHPSOn1.y, pumpBusRad.rpmSet) annotation (Line(points={{-99,90},
          {-49.95,90},{-49.95,58.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(constPumpHPSOn2.y, sou.m_flow_in) annotation (Line(points={{-159,-90},
          {-144,-90},{-144,-88},{-138,-88},{-138,-62}}, color={0,0,127}));
  connect(sin1.ports[1], heatPumpSystem.port_a1) annotation (Line(points={{-260,
          -30},{-248,-30},{-248,-38},{-230,-38},{-230,-44.8571},{-220,-44.8571}},
                                                            color={0,127,255}));
  connect(heatPumpSystem.port_a1, bufferStorage.fluidportBottom1) annotation (
      Line(points={{-220,-44.8571},{-230,-44.8571},{-230,-38},{-248,-38},{-248,
          28},{-112,28},{-112,-62},{-88.0875,-62},{-88.0875,-52.52}}, color={0,
          127,255}));
  connect(PI.y, val.y) annotation (Line(points={{41,90},{46,90},{46,30},{10,30},
          {10,22}}, color={0,0,127}));
  connect(TRoomSet.y, PI.u_s)
    annotation (Line(points={{1,90},{18,90}}, color={0,0,127}));
  connect(realExpressionTAirs.y, TAirRooms) annotation (Line(points={{279,-40},
          {294,-40},{294,-39},{310,-39}},color={0,0,127}));
  connect(realExpression.y, PI.u_m)
    annotation (Line(points={{30,65},{30,78}}, color={0,0,127}));
  connect(integrator.y, dTComfort) annotation (Line(points={{281,-60},{294,-60},
          {294,-59},{310,-59}}, color={0,0,127}));
  connect(integrator.u, realExpression1.y)
    annotation (Line(points={{258,-60},{249,-60}}, color={0,0,127}));
  connect(integratorEl.y, Wel) annotation (Line(points={{281,-90},{292,-90},{
          292,-81},{310,-81}}, color={0,0,127}));
  connect(realExpressionPel.y, integratorEl.u)
    annotation (Line(points={{249,-90},{258,-90}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-300,-100},
            {300,100}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-300,-100},{300,100}}), graphics={                                                                                           Rectangle(extent={{73,-40},
              {112,-100}},                                                                                                                                                                lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{76,-54},
              {112,-92}},                                                                                                                                                            lineColor={0,0,255},
          textString="1-Bedroom
2-Child1
3-Corridor
4-Bath
5-Child2",horizontalAlignment=TextAlignment.Left),                                                                                                                                                                                                        Text(extent={{95,-52},
              {111,-41}},                                                                                                                                                                               lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "UF"), Rectangle(extent={{30,-40},
              {72,-100}},                                                                                                                                                                                     lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{55,-52},
              {71,-41}},                                                                                                                                                              lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "GF"),                                                                                                                       Text(extent={{33,-54},
              {72,-91}},                                                                                                                                                                                lineColor={0,0,255},
          textString="1-Livingroom
2-Hobby
3-Corridor
4-WC
5-Kitchen",
          horizontalAlignment=TextAlignment.Left)}),
    experiment(
      StopTime=432000,
      Interval=900.00288,
      __Dymola_Algorithm="Dassl"));
end BuildingEnergySystem;
