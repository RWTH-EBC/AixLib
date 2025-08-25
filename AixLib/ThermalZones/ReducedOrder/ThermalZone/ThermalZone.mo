within AixLib.ThermalZones.ReducedOrder.ThermalZone;
model ThermalZone "Thermal zone containing moisture balance"
  extends
    AixLib.ThermalZones.ReducedOrder.ThermalZone.BaseClasses.PartialThermalZone;

  replaceable model corG = SolarGain.CorrectionGDoublePane
    constrainedby
    AixLib.ThermalZones.ReducedOrder.SolarGain.BaseClasses.PartialCorrectionG
    "Model for correction of solar transmission"
    annotation(choicesAllMatching=true);
  parameter Integer internalGainsMode = 1
     "decides which internal gains model for persons is used";
  parameter Boolean use_MechanicalAirExchange = false
    "Consider mechanical ventilation by setting true";
  parameter Boolean use_NaturalAirExchange = use_MechanicalAirExchange
    "Consider natural infiltration and ventilation by setting true";

  // Heater/ cooler parameters
  parameter Boolean recOrSep=true "Use record or seperate parameters"
    annotation (Dialog(tab="IdealHeaterCooler", group="Modes"), choices(choice =  false
        "Seperate",choice = true "Record",radioButtons = true));
  parameter Boolean Heater_on=true "Activates the heater"
    annotation (Dialog(tab="IdealHeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real h_heater=0 "Upper limit controller output of the heater"
    annotation (Dialog(tab="IdealHeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real l_heater=0 "Lower limit controller output of the heater"
    annotation (Dialog(tab="IdealHeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real KR_heater=1000 "Gain of the heating controller"
    annotation (Dialog(tab="IdealHeaterCooler", group="Heater", enable=not recOrSep));
  parameter Modelica.Units.SI.Time TN_heater=1
    "Time constant of the heating controller" annotation (Dialog(
      tab="IdealHeaterCooler",
      group="Heater",
      enable=not recOrSep));
  parameter Boolean Cooler_on=true "Activates the cooler"
    annotation (Dialog(tab="IdealHeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real h_cooler=0 "Upper limit controller output of the cooler"
    annotation (Dialog(tab="IdealHeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real l_cooler=0 "Lower limit controller output of the cooler"
    annotation (Dialog(tab="IdealHeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real KR_cooler=1000 "Gain of the cooling controller"
    annotation (Dialog(tab="IdealHeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Modelica.Units.SI.Time TN_cooler=1
    "Time constant of the cooling controller" annotation (Dialog(
      tab="IdealHeaterCooler",
      group="Cooler",
      enable=not recOrSep));

  // CO2 parameters
  parameter Modelica.Units.SI.MassFraction XCO2_amb=6.12157E-4
    "Massfraction of CO2 in atmosphere (equals 403ppm)"
    annotation (Dialog(tab="CO2", enable=use_C_flow));
  parameter Modelica.Units.SI.Area areaBod=1.8
    "Body surface area source SIA 2024:2015"
    annotation (Dialog(tab="CO2", enable=use_C_flow));
  parameter Modelica.Units.SI.DensityOfHeatFlowRate metOnePerSit=58
    "Metabolic rate of a relaxed seated person  [1 Met = 58 W/m^2]"
    annotation (Dialog(tab="CO2", enable=use_C_flow));

  // Pool parameters
  replaceable package MediumPoolWater = AixLib.Media.Water
   "Medium in the component"  annotation (choices(choice(redeclare package
          Medium =
            AixLib.Media.Water
              "Water")), Dialog(enable=use_pools,tab="Moisture", group="Pools"));
  parameter Integer nPools(min=1)=1  "Number of pools in thermal zone" annotation(Dialog(enable=use_pools,tab="Moisture", group="Pools"));
  replaceable parameter  AixLib.DataBase.Pools.IndoorSwimmingPoolBaseDataDefinition poolParam[nPools]=
     fill(DataBase.Pools.IndoorSwimmingPoolDummy(), nPools) if use_pools
    "Setup for swimming pools" annotation (Dialog(
      enable=use_pools,
      tab="Moisture",
      group="Pools"));
  replaceable parameter AixLib.DataBase.Walls.WallBaseDataDefinition poolWallParam[nPools] = fill(DataBase.Walls.ASHRAE140.DummyDefinition(), nPools) if use_pools "Setup for swimming pool walls"
                                                                                                                                                                                                  annotation(Dialog(enable=use_pools,tab="Moisture", group="Pools"));

  replaceable parameter DataBase.ThermalZones.ZoneBaseRecord zoneParam
    "Choose setup for this zone" annotation (choicesAllMatching=true);

  replaceable AixLib.BoundaryConditions.InternalGains.Humans.HumanSensibleHeatTemperatureDependent humanSenHeaDependent(
    final ratioConv=zoneParam.ratioConvectiveHeatPeople,
    final roomArea=zoneParam.AZone,
    final specificPersons=zoneParam.specificPeople,
    final activityDegree=zoneParam.activityDegree,
    final specificHeatPerPerson=zoneParam.fixedHeatFlowRatePersons) if ATot > 0 and internalGainsMode == 1 annotation (Placement(transformation(extent={{56,-34},
            {76,-14}})));

  replaceable AixLib.BoundaryConditions.InternalGains.Humans.HumanSensibleHeatTemperatureIndependent humanSenHeaIndependent(
    final ratioConv=zoneParam.ratioConvectiveHeatPeople,
    final roomArea=zoneParam.AZone,
    final specificPersons=zoneParam.specificPeople,
    final specificHeatPerPerson=zoneParam.fixedHeatFlowRatePersons) if ATot > 0 and internalGainsMode == 2 annotation (Placement(transformation(extent={{56,-34},
            {76,-14}})));

  replaceable AixLib.BoundaryConditions.InternalGains.Humans.HumanTotalHeatTemperatureDependent humanTotHeaDependent(
    final ratioConv=zoneParam.ratioConvectiveHeatPeople,
    final roomArea=zoneParam.AZone,
    final specificPersons=zoneParam.specificPeople,
    final activityDegree=zoneParam.activityDegree,
    final specificHeatPerPerson=zoneParam.fixedHeatFlowRatePersons) if ATot > 0 and internalGainsMode == 3 annotation (Placement(transformation(extent={{56,-34},
            {76,-14}})));

  replaceable AixLib.BoundaryConditions.InternalGains.Machines.MachinesAreaSpecific machinesSenHea(
    final ratioConv=zoneParam.ratioConvectiveHeatMachines,
    final intGainsMachinesRoomAreaSpecific=zoneParam.internalGainsMachinesSpecific,
    final roomArea=zoneParam.AZone) if ATot > 0 "Internal gains from machines" annotation (Placement(transformation(extent={{56,-56},
            {76,-37}})));
  replaceable AixLib.BoundaryConditions.InternalGains.Lights.LightsAreaSpecific lights(
    final ratioConv=zoneParam.ratioConvectiveHeatLighting,
    final lightingPowerRoomAreaSpecific=zoneParam.lightingPowerSpecific,
    final roomArea=zoneParam.AZone) if ATot > 0 "Internal gains from light" annotation (Placement(transformation(extent={{56,-78},
            {76,-59}})));

  corG corGMod(
    final n=zoneParam.nOrientations,
    final UWin=zoneParam.UWin)
    "Correction factor for solar transmission"
    annotation (Placement(transformation(extent={{-16,43},{-4,55}})));
  replaceable EquivalentAirTemperature.VDI6007WithWindow eqAirTempWall(
    withLongwave=true,
    final n=zoneParam.nOrientations,
    final wfWall=zoneParam.wfWall,
    final wfWin=zoneParam.wfWin,
    final wfGro=zoneParam.wfGro,
    final hConWallOut=zoneParam.hConWallOut,
    final hRad=zoneParam.hRadWall,
    TGroundFromInput=true,
    final hConWinOut=zoneParam.hConWinOut,
    final aExt=zoneParam.aExt) if (sum(zoneParam.AExt) + sum(zoneParam.AWin)) > 0
    "Computes equivalent air temperature"
    annotation (Placement(transformation(extent={{-38,10},{-26,22}})));

  replaceable EquivalentAirTemperature.VDI6007 eqAirTempRoof(
    final wfGro=0,
    final n=zoneParam.nOrientationsRoof,
    final aExt=zoneParam.aRoof,
    final wfWall=zoneParam.wfRoof,
    final hConWallOut=zoneParam.hConRoofOut,
    final hRad=zoneParam.hRadRoof,
    final wfWin=fill(0, zoneParam.nOrientationsRoof),
    TGroundFromInput=true) if zoneParam.ARoof > 0
    "Computes equivalent air temperature for roof"
    annotation (Placement(transformation(extent={{-40,66},{-28,78}})));
  Modelica.Blocks.Sources.Constant constSunblindRoof[zoneParam.nOrientationsRoof](
     each k=0)
     "Sets sunblind signal to zero (open)"
     annotation (Placement(
        transformation(
        extent={{3,-3},{-3,3}},
        rotation=90,
        origin={-36,95})));
  BoundaryConditions.SolarIrradiation.DiffusePerez HDifTilWall[zoneParam.nOrientations](
    each final outSkyCon=true,
    each final outGroCon=true,
    final azi=zoneParam.aziExtWalls,
    final til=zoneParam.tiltExtWalls)
    "Calculates diffuse solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-84,10},{-68,26}})));
  replaceable BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTilWall[zoneParam.nOrientations](
     final azi=zoneParam.aziExtWalls, final til=zoneParam.tiltExtWalls)
    "Calculates direct solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-84,31},{-68,48}})));
  replaceable BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTilRoof[zoneParam.nOrientationsRoof](
     final azi=zoneParam.aziRoof, final til=zoneParam.tiltRoof)
    "Calculates direct solar radiation on titled surface for roof"
    annotation (Placement(transformation(extent={{-84,82},{-68,98}})));

  Utilities.Sources.HeaterCooler.HeaterCoolerPIFraRadDamped
                                                heaterCooler(
    each h_heater=h_heater,
    each l_heater=l_heater,
    each KR_heater=KR_heater,
    each TN_heater=TN_heater,
    each h_cooler=h_cooler,
    each l_cooler=l_cooler,
    each KR_cooler=KR_cooler,
    each TN_cooler=TN_cooler,
    final zoneParam=zoneParam,
    each recOrSep=recOrSep,
    each Heater_on=Heater_on,
    each Cooler_on=Cooler_on,
    each staOrDyn=not zoneParam.withIdealThresholds)
      if (ATot > 0 or zoneParam.VAir > 0) and (recOrSep and (zoneParam.HeaterOn or zoneParam.CoolerOn)) or (
        not recOrSep and (Heater_on or Cooler_on))
      "Heater Cooler with PI control"
    annotation (Placement(transformation(extent={{62,32},{84,52}})));
  Utilities.Sources.HeaterCooler.HeaterCoolerController heaterCoolerController(zoneParam=
       zoneParam) if zoneParam.withIdealThresholds
    annotation (Placement(transformation(extent={{-9,-8},{9,8}},
        rotation=0,
        origin={69,18})));
  Modelica.Blocks.Interfaces.RealInput TSetCool(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) if ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
           "Set point for cooler" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-108,8}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-96,40})));
  Modelica.Blocks.Interfaces.RealInput TSetHeat(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) if ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on))
           "Set point for heater" annotation (Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-108,-16}),iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-96,12})));
  Modelica.Blocks.Interfaces.RealOutput PHeater(final quantity="HeatFlowRate",
      final unit="W") if (ATot > 0 or zoneParam.VAir > 0) and ((recOrSep and
    zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    "Power for heating" annotation (Placement(transformation(extent={{100,-10},
            {120,10}}), iconTransformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealOutput PCooler(final quantity="HeatFlowRate",
      final unit="W") if (ATot > 0 or zoneParam.VAir > 0) and ((recOrSep and
    zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    "Power for cooling" annotation (Placement(transformation(extent={{100,-30},
            {120,-10}}), iconTransformation(extent={{100,-50},{120,-30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a izeHeaFlow[zoneParam.nIze]
    if sum(zoneParam.AIze) > 0
    "surface heat port for nz borders - inner surface if zone index is higher than index of other zone, outer if lower"
    annotation (Placement(transformation(extent={{94,86},{114,106}})));
  replaceable SolarGain.SimpleExternalShading simpleExternalShading(
    final nOrientations=zoneParam.nOrientations,
    final maxIrrs=zoneParam.maxIrr,
    final gValues=zoneParam.shadingFactor)
    annotation (Placement(transformation(extent={{4,44},{10,50}})));

  // Air Exchange
  Controls.VentilationController.VentilationController ventCont(
    final useConstantOutput=zoneParam.useConstantACHrate,
    final baseACH=zoneParam.baseACH,
    final maxUserACH=zoneParam.maxUserACH,
    final maxOverheatingACH=zoneParam.maxOverheatingACH,
    final maxSummerACH=zoneParam.maxSummerACH,
    final winterReduction=zoneParam.winterReduction,
    final Tmean_start=zoneParam.T_start) if (ATot > 0 or zoneParam.VAir > 0)
     and use_NaturalAirExchange
    "Calculates natural venitlation and infiltration"
    annotation (Placement(transformation(extent={{-66,-34},{-50,-18}})));
  Utilities.Psychrometrics.MixedTemperature mixedTemp if (ATot > 0 or zoneParam.VAir
     > 0) and use_NaturalAirExchange and use_MechanicalAirExchange
    "Mixes temperature of infiltration flow and mechanical ventilation flow"
    annotation (Placement(transformation(extent={{-56,-4},{-48,4}})));
  HighOrder.Components.DryAir.VarAirExchange airExc(final V=zoneParam.VAir)
    if (ATot > 0 or zoneParam.VAir > 0) and  (use_NaturalAirExchange or use_MechanicalAirExchange) and not use_moisture_balance
    "Heat flow due to ventilation"
    annotation (Placement(transformation(extent={{-22,-14},{-6,2}})));

  Modelica.Blocks.Interfaces.RealInput ventTemp(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) if (ATot > 0 or zoneParam.VAir > 0) and use_MechanicalAirExchange
    "Ventilation and infiltration temperature"
    annotation (Placement(
        transformation(extent={{-128,-60},{-88,-20}}), iconTransformation(
          extent={{-106,-26},{-86,-6}})));
  Modelica.Blocks.Interfaces.RealInput ventRate(final quantity="VolumeFlowRate",
      final unit="1/h") if (ATot > 0 or zoneParam.VAir > 0) and use_MechanicalAirExchange
    "Ventilation and infiltration rate"
    annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-108,-64}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-96,-42})));

  // Moisture
  Modelica.Blocks.Math.MultiSum SumQLat1_flow(nu=2) if (ATot > 0 or
    zoneParam.VAir > 0) and use_moisture_balance and not (use_NaturalAirExchange or use_MechanicalAirExchange)
    annotation (Placement(transformation(extent={{-48,-58},{-38,-48}})));
  Modelica.Blocks.Math.MultiSum SumQLat2_flow(nu=3) if (ATot > 0 or zoneParam.VAir >
    0) and use_moisture_balance and (use_NaturalAirExchange or
    use_MechanicalAirExchange)
    annotation (Placement(transformation(extent={{-48,-58},{-38,-48}})));
  BoundaryConditions.InternalGains.Moisture.MoistureGains moistureGains(
    final roomArea=zoneParam.AZone,
    final specificMoistureProduction=zoneParam.internalGainsMoistureNoPeople)
    if ATot > 0 and use_moisture_balance
    "Internal moisture gains by plants, etc."
    annotation (Dialog(enable=use_moisture_balance, tab="Moisture"),
      Placement(transformation(extent={{-70,-68},{-62,-60}})));
  Modelica.Blocks.Sources.Constant noMoisturePerson(k=0)
    if internalGainsMode <> 3 and use_moisture_balance
    annotation (Placement(transformation(extent={{-70,-58},{-62,-50}})));
  Modelica.Blocks.Interfaces.RealOutput X_w
    if (ATot > 0 or zoneParam.VAir > 0) and use_moisture_balance
    "Humidity output" annotation (Placement(transformation(extent={{100,-80},{
            120,-60}}),
                    iconTransformation(extent={{100,-80},{120,-60}})));
  Modelica.Blocks.Interfaces.RealInput ventHum(
    final quantity="MassFraction",
    final unit="kg/kg",
    min=0) if (ATot > 0 or zoneParam.VAir > 0) and use_moisture_balance and use_MechanicalAirExchange
    "Ventilation and infiltration humidity" annotation (Placement(
        transformation(extent={{-128,-108},{-88,-68}}), iconTransformation(
          extent={{-110,-84},{-88,-62}})));
  HighOrder.Components.MoistAir.VarMoistAirExchange airExcMoi(final V=zoneParam.VAir) if (ATot
     > 0 or zoneParam.VAir > 0) and (use_NaturalAirExchange or
    use_MechanicalAirExchange) and use_moisture_balance
    "Heat flow due to ventilation"
    annotation (Placement(transformation(extent={{-22,-14},{-6,2}})));

  // CO2
  BoundaryConditions.InternalGains.CO2.CO2Balance cO2Balance(
    areaZon=zoneParam.AZone,
    actDeg=zoneParam.activityDegree,
    VZon=zoneParam.VAir,
    spePeo=zoneParam.specificPeople,
    final XCO2_amb=XCO2_amb,
    final areaBod=areaBod,
    final metOnePerSit=metOnePerSit) if (ATot > 0 or zoneParam.VAir > 0) and
    use_C_flow
    annotation (Placement(transformation(extent={{16,-74},{32,-58}})));
  Modelica.Blocks.Interfaces.RealOutput CO2Con if (ATot > 0 or zoneParam.VAir
     > 0) and use_C_flow "CO2 concentration in the thermal zone in ppm"
    annotation (Placement(transformation(extent={{100,-100},{120,-80}}),
        iconTransformation(extent={{100,-100},{120,-80}})));

  Modelica.Blocks.Sources.RealExpression XCO2(y=ROM.volMoiAir.C[1]) if (ATot >
    0 or zoneParam.VAir > 0) and use_C_flow
    "Mass fraction of co2 in ROM in kg_CO2/ kg_TotalAir"
    annotation (Placement(transformation(extent={{-8,-74},{10,-60}})));

  BoundaryConditions.SolarIrradiation.DiffusePerez HDifTilRoof[zoneParam.nOrientationsRoof](
    each final outSkyCon=false,
    each final outGroCon=false,
    final azi=zoneParam.aziRoof,
    final til=zoneParam.tiltRoof)
    "Calculates diffuse solar radiation on titled surface for roof"
    annotation (Placement(transformation(extent={{-84,61},{-68,77}})));
  Modelica.Blocks.Interfaces.RealOutput QIntGains_flow[3](each final quantity="HeatFlowRate",
      each final unit="W") if ATot > 0
    "Heat flow based on internal gains from lights[1], machines[2], and persons[3]"
                                                           annotation (
      Placement(transformation(extent={{100,-50},{120,-30}}),
        iconTransformation(extent={{100,-50},{120,-30}})));

    // Pools
  Fluid.Pools.IndoorSwimmingPool indoorSwimmingPool[nPools](poolParam=poolParam,
    poolWallParam = poolWallParam,
    redeclare package WaterMedium = MediumPoolWater,
    each energyDynamics=energyDynamics)
    if (ATot > 0 or zoneParam.VAir > 0) and use_moisture_balance and use_pools
    annotation (Placement(transformation(extent={{-54,-82},{-40,-70}})));
  Modelica.Blocks.Math.MultiSum SumQPool(nu=nPools) if (ATot > 0 or zoneParam.VAir >
    0) and use_moisture_balance and use_pools
    annotation (Placement(transformation(extent={{-28,-82},{-20,-74}})));
  Modelica.Blocks.Math.MultiSum SumPPool(nu=nPools) if (ATot > 0 or zoneParam.VAir >
    0) and use_moisture_balance  and use_pools
    annotation (Placement(transformation(extent={{-28,-82},{-20,-74}})));
  Modelica.Blocks.Math.MultiSum SumPool_m_flow_add(nu=nPools) if (ATot > 0 or
    zoneParam.VAir > 0) and use_moisture_balance and use_pools
    annotation (Placement(transformation(extent={{-28,-82},{-20,-74}})));
  Modelica.Blocks.Interfaces.RealInput timeOpe
    if (ATot > 0 or zoneParam.VAir > 0) and use_moisture_balance and use_pools
    "Input profiles for opening hours for pools" annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-58,-108}),
        iconTransformation(extent={{-12,-12},{12,12}},
        rotation=90,
        origin={-70,-84})));


  // protected: ThermalZone

  Fluid.Pools.BaseClasses.AirFlowMoistureToROM airFlowMoistureToROM(
    redeclare package AirMedium = Medium,
    energyDynamics=energyDynamics,
    nPools=nPools,
    m_flow_air_nominal=5,
    VAirLay=zoneParam.VAir)
    if (ATot > 0 or zoneParam.VAir > 0) and use_moisture_balance and use_pools
    annotation (Placement(transformation(extent={{-66,-76},{-60,-70}})));

protected
    Modelica.Blocks.Sources.Constant hConRoof(final k=(zoneParam.hConRoofOut + zoneParam.hRadRoof)*zoneParam.ARoof)
    "Outdoor coefficient of heat transfer for roof" annotation (Placement(transformation(extent={{-14,68},
            {-6,76}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConRoof
 if zoneParam.ARoof > 0
    "Outdoor convective heat transfer of roof"
    annotation (Placement(transformation(extent={{5,5},{-5,-5}},rotation=0,
    origin={5,83})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemRoof
 if zoneParam.ARoof > 0
    "Prescribed temperature for roof outdoor surface temperature"
    annotation (Placement(transformation(extent={{-4.5,-4},{4.5,4}},
                                                                rotation=0,
    origin={-9.5,84})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemFloor
 if zoneParam.AFloor > 0
    "Prescribed temperature for floor plate outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
    rotation=90,origin={48,36})));
  AixLib.BoundaryConditions.GroundTemperature.Options TSoi(
    final datSou=zoneParam.TSoiDatSou,
    final TMea=zoneParam.TSoil,
    final offTime=zoneParam.TSoiOffTim,
    final ampTGro=zoneParam.TSoiAmp,
    final filDatSou=zoneParam.TSoiFil)
    "Outdoor surface temperature for floor plate" annotation (Placement(
        transformation(extent={{4,-4},{-4,4}}, rotation=180)));
  Modelica.Blocks.Sources.Constant hConWall(final k=(zoneParam.hConWallOut + zoneParam.hRadWall)*sum(zoneParam.AExt))
    "Outdoor coefficient of heat transfer for walls" annotation (Placement(transformation(extent={{4,-4},{
            -4,4}},                                                                                               rotation=180,
        origin={-2,16})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWall
 if sum(zoneParam.AExt) > 0
    "Outdoor convective heat transfer of walls"
    annotation (Placement(transformation(extent={{26,24},{16,14}})));
  Modelica.Blocks.Sources.Constant hConWin(final k=(zoneParam.hConWinOut + zoneParam.hRadWall)*sum(zoneParam.AWin))
    "Outdoor coefficient of heat transfer for windows" annotation (Placement(transformation(extent={{4,-4},{-4,4}}, rotation=90,
        origin={22,48})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWin
 if sum(zoneParam.AWin) > 0
    "Outdoor convective heat transfer of windows"
    annotation (Placement(transformation(extent={{26,30},{16,40}})));
  Modelica.Blocks.Math.Add solRadRoof[zoneParam.nOrientationsRoof]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{-58,82},{-48,92}})));
  Modelica.Blocks.Math.Add solRadWall[zoneParam.nOrientations]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{-54,22},{-44,32}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemWall
 if sum(zoneParam.AExt) > 0
    "Prescribed temperature for exterior walls outdoor surface temperature"
    annotation (Placement(transformation(extent={{-18,16},{-10,24}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemWin
 if sum(zoneParam.AWin) > 0
    "Prescribed temperature for windows outdoor surface temperature"
    annotation (Placement(transformation(extent={{4,31},{12,38}})));

  // protected: AirExchange

  Modelica.Blocks.Math.Add addInfVen if (ATot > 0 or zoneParam.VAir > 0) and
    use_NaturalAirExchange and use_MechanicalAirExchange
    "Combines infiltration and ventilation"
    annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-35,-27})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemVen if (ATot >
    0 or zoneParam.VAir > 0) and (use_MechanicalAirExchange or use_NaturalAirExchange)
    "Prescribed temperature for ventilation"
    annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-35,-1})));

  // protected: MoistAir
  Modelica.Blocks.Sources.RealExpression humVolAirROM(y=ROM.volMoiAir.X_w)
    if (ATot > 0 or zoneParam.VAir > 0) and use_moisture_balance
    annotation (Placement(transformation(extent={{-28,-56},{-20,-40}})));




  // protected: Outputs
  Modelica.Blocks.Sources.RealExpression QIntGainsInternalDep_flow[3](y={-lights.convHeat.Q_flow
         - lights.radHeat.Q_flow,-machinesSenHea.radHeat.Q_flow -
        machinesSenHea.convHeat.Q_flow, -humanSenHeaDependent.radHeat.Q_flow -
        humanSenHeaDependent.convHeat.Q_flow}) if ATot > 0 and internalGainsMode == 1
    annotation (Placement(transformation(extent={{94,-46},{98,-34}})));
  Modelica.Blocks.Sources.RealExpression QIntGainsInternalInd_flow[3](y={-lights.convHeat.Q_flow
         - lights.radHeat.Q_flow,-machinesSenHea.radHeat.Q_flow -
        machinesSenHea.convHeat.Q_flow, -humanSenHeaIndependent.radHeat.Q_flow -
        humanSenHeaIndependent.convHeat.Q_flow}) if ATot > 0 and internalGainsMode == 2
    annotation (Placement(transformation(extent={{94,-46},{98,-34}})));
  Modelica.Blocks.Sources.RealExpression QIntGainsInternalTot_flow[3](y={-lights.convHeat.Q_flow
         - lights.radHeat.Q_flow,-machinesSenHea.radHeat.Q_flow -
        machinesSenHea.convHeat.Q_flow, -humanTotHeaDependent.radHeat.Q_flow -
        humanTotHeaDependent.convHeat.Q_flow}) if ATot > 0 and internalGainsMode == 3
    annotation (Placement(transformation(extent={{94,-46},{98,-34}})));
  Utilities.Psychrometrics.MixedHumidity mixedHumidity if (ATot > 0 or
    zoneParam.VAir > 0) and use_NaturalAirExchange and
    use_MechanicalAirExchange and use_moisture_balance
    "Mixes humidity of infiltration flow and mechanical ventilation flow"
    annotation (Placement(transformation(extent={{-56,-12},{-48,-4}})));
  Utilities.Psychrometrics.X_pTphi x_pTphi if (ATot > 0 or zoneParam.VAir > 0)
     and use_NaturalAirExchange and use_moisture_balance
    annotation (Placement(transformation(extent={{-70,-14},{-64,-8}})));

equation
  connect(intGains[2], machinesSenHea.uRel) annotation (Line(points={{80,-100},{
          80,-94},{78,-94},{78,-88},{48,-88},{48,-46.5},{56,-46.5}}, color={0,0,
          127}));
  connect(intGains[3], lights.uRel) annotation (Line(points={{80,-93.3333},{80,
          -86},{50,-86},{50,-68.5},{56,-68.5}},
                                           color={0,0,127}));
  connect(lights.convHeat, ROM.intGainsConv) annotation (Line(points={{75,-62.8},
          {92,-62.8},{92,78},{86,78}}, color={191,0,0}));
  connect(machinesSenHea.convHeat, ROM.intGainsConv) annotation (Line(points={{75,
          -40.8},{92,-40.8},{92,78},{86,78}}, color={191,0,0}));
  connect(intGains[1], humanSenHeaDependent.uRel) annotation (Line(points={{80,
          -106.667},{80,-92},{46,-92},{46,-24},{56,-24}},
                                                color={0,0,127}));
  connect(humanSenHeaDependent.convHeat, ROM.intGainsConv) annotation (Line(
        points={{75,-18},{92,-18},{92,78},{86,78}}, color={191,0,0}));
  connect(ROM.intGainsConv, humanSenHeaDependent.TRoom) annotation (Line(points=
         {{86,78},{92,78},{92,-10},{57,-10},{57,-15}}, color={191,0,0}));
  connect(humanSenHeaDependent.radHeat, ROM.intGainsRad) annotation (Line(
        points={{75,-30},{94,-30},{94,82},{86,82}}, color={95,95,95}));
  connect(intGains[1], humanSenHeaIndependent.uRel) annotation (Line(points={{80,
          -106.667},{80,-92},{46,-92},{46,-24},{56,-24}}, color={0,0,127}));
  connect(humanSenHeaIndependent.convHeat, ROM.intGainsConv) annotation (Line(
        points={{75,-18},{92,-18},{92,78},{86,78}}, color={191,0,0}));
  connect(ROM.intGainsConv, humanSenHeaIndependent.TRoom) annotation (Line(
        points={{86,78},{92,78},{92,-10},{57,-10},{57,-15}}, color={191,0,0}));
  connect(humanSenHeaIndependent.radHeat, ROM.intGainsRad) annotation (Line(
        points={{75,-30},{94,-30},{94,82},{86,82}}, color={95,95,95}));
  connect(intGains[1], humanTotHeaDependent.uRel) annotation (Line(points={{80,
          -106.667},{80,-92},{46,-92},{46,-24},{56,-24}},
                                                color={0,0,127}));
  connect(humanTotHeaDependent.convHeat, ROM.intGainsConv) annotation (Line(
        points={{75,-18},{92,-18},{92,78},{86,78}}, color={191,0,0}));
  connect(ROM.intGainsConv, humanTotHeaDependent.TRoom) annotation (Line(points=
         {{86,78},{92,78},{92,-10},{57,-10},{57,-15}}, color={191,0,0}));
  connect(humanTotHeaDependent.radHeat, ROM.intGainsRad) annotation (Line(
        points={{75,-30},{94,-30},{94,82},{86,82}}, color={95,95,95}));
  connect(machinesSenHea.radHeat, ROM.intGainsRad) annotation (Line(points={{75,
          -52.2},{94,-52.2},{94,82},{86,82}}, color={95,95,95}));
  connect(lights.radHeat, ROM.intGainsRad) annotation (Line(points={{75,-74.2},{
          94,-74.2},{94,82},{86,82}}, color={95,95,95}));
  connect(eqAirTempWall.TEqAirWin, preTemWin.T) annotation (Line(points={{-25.4,
          18.28},{-24,18.28},{-24,30},{2,30},{2,34.5},{3.2,34.5}}, color={0,0,127}));
  connect(eqAirTempWall.TEqAir, preTemWall.T) annotation (Line(points={{-25.4,16},
          {-20,16},{-20,20},{-18.8,20}}, color={0,0,127}));
  connect(HDirTilWall.H, corGMod.HDirTil) annotation (Line(points={{-67.2,39.5},
          {-58,39.5},{-58,52},{-38,52},{-38,52.6},{-17.2,52.6}}, color={0,0,127}));
  connect(HDirTilWall.H, solRadWall.u1) annotation (Line(points={{-67.2,39.5},{-58,
          39.5},{-58,30},{-55,30}}, color={0,0,127}));
  connect(HDirTilWall.inc, corGMod.inc) annotation (Line(points={{-67.2,36.1},{-64,
          36.1},{-64,36},{-60,36},{-60,45.4},{-17.2,45.4}}, color={0,0,127}));
  connect(HDifTilWall.H, solRadWall.u2) annotation (Line(points={{-67.2,18},{-60,
          18},{-60,24},{-55,24}}, color={0,0,127}));
  connect(HDifTilWall.HGroDifTil, corGMod.HGroDifTil) annotation (Line(points={{
          -67.2,13.2},{-62,13.2},{-62,48},{-40,48},{-40,47.8},{-17.2,47.8}},
        color={0,0,127}));
  connect(solRadWall.y, eqAirTempWall.HSol) annotation (Line(points={{-43.5,27},
          {-42,27},{-42,19.6},{-39.2,19.6}}, color={0,0,127}));
  connect(weaBus.TBlaSky, eqAirTempWall.TBlaSky) annotation (Line(
      points={{-99.915,34.08},{-86,34.08},{-86,10},{-60,10},{-60,16},{-39.2,16}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul, eqAirTempWall.TDryBul) annotation (Line(
      points={{-99.915,34.08},{-86,34.08},{-86,10},{-60,10},{-60,12.4},{-39.2,12.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(HDifTilWall.HSkyDifTil, corGMod.HSkyDifTil) annotation (Line(points={{
          -67.2,22.8},{-64,22.8},{-64,50},{-40,50},{-40,50.2},{-17.2,50.2}},
        color={0,0,127}));
  connect(theConWin.solid, ROM.window) annotation (Line(points={{26,35},{28,35},
          {28,78},{38,78}}, color={191,0,0}));
  connect(theConWall.solid, ROM.extWall) annotation (Line(points={{26,19},{29,19},
          {29,70},{38,70}}, color={191,0,0}));
  connect(weaBus.TDryBul, eqAirTempRoof.TDryBul) annotation (Line(
      points={{-99.915,34.08},{-86,34.08},{-86,60},{-46,60},{-46,68.4},{-41.2,68.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TBlaSky, eqAirTempRoof.TBlaSky) annotation (Line(
      points={{-99.915,34.08},{-86,34.08},{-86,60},{-46,60},{-46,72},{-41.2,72}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(HDirTilRoof.H, solRadRoof.u1)
    annotation (Line(points={{-67.2,90},{-59,90}}, color={0,0,127}));
  connect(HDifTilRoof.H, solRadRoof.u2) annotation (Line(points={{-67.2,69},{-64,
          69},{-64,84},{-59,84}}, color={0,0,127}));
  connect(solRadRoof.y, eqAirTempRoof.HSol) annotation (Line(points={{-47.5,87},
          {-44,87},{-44,75.6},{-41.2,75.6}}, color={0,0,127}));
  connect(constSunblindRoof.y, eqAirTempRoof.sunblind) annotation (Line(points={
          {-36,91.7},{-36,79.2},{-34,79.2}}, color={0,0,127}));
  connect(TSoi.TGroOut, preTemFloor.T)
    annotation (Line(points={{4.4,0},{48,0},{48,28.8}}, color={0,0,127}));
  connect(preTemFloor.port, ROM.floor)
    annotation (Line(points={{48,42},{48,56},{62,56}}, color={191,0,0}));
  connect(preTemRoof.port, theConRoof.fluid)
    annotation (Line(points={{-5,84},{0,84},{0,83}}, color={191,0,0}));
  connect(theConRoof.Gc, hConRoof.y)
    annotation (Line(points={{5,78},{5,72},{-5.6,72}}, color={0,0,127}));
  connect(eqAirTempRoof.TEqAir, preTemRoof.T) annotation (Line(points={{-27.4,72},
          {-27.4,84},{-14.9,84}}, color={0,0,127}));
  connect(theConRoof.solid, ROM.roof) annotation (Line(points={{10,83},{14,83},{
          14,92},{60.9,92}}, color={191,0,0}));
  for i in 1:zoneParam.nOrientations loop
    connect(weaBus, HDifTilWall[i].weaBus) annotation (Line(
        points={{-100,34},{-100,34},{-86,34},{-86,18},{-84,18}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(HDirTilWall[i].weaBus, weaBus) annotation (Line(
        points={{-84,39.5},{-86,39.5},{-86,46},{-86,34},{-100,34}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
  end for;
  for i in 1:zoneParam.nOrientationsRoof loop
    connect(weaBus, HDifTilRoof[i].weaBus) annotation (Line(
        points={{-100,34},{-86,34},{-86,69},{-84,69}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(weaBus, HDirTilRoof[i].weaBus) annotation (Line(
        points={{-100,34},{-86,34},{-86,90},{-84,90}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
  end for;
  connect(preTemWall.port, theConWall.fluid) annotation (Line(points={{-10,20},{
          18,20},{18,19},{16,19}}, color={191,0,0}));
  connect(preTemWin.port, theConWin.fluid)
    annotation (Line(points={{12,34.5},{16,34.5},{16,35}}, color={191,0,0}));
  connect(hConWall.y, theConWall.Gc)
    annotation (Line(points={{2.4,16},{21,16},{21,14}}, color={0,0,127}));
  connect(hConWin.y, theConWin.Gc)
    annotation (Line(points={{22,43.6},{22,40},{21,40}}, color={0,0,127}));
  connect(heaterCoolerController.heaterActive, heaterCooler.heaterActive)
    annotation (Line(points={{76.38,19.6},{80,19.6},{80,28},{80.48,28},{80.48,34.8}},
        color={255,0,255}));
  connect(heaterCoolerController.coolerActive, heaterCooler.coolerActive)
    annotation (Line(points={{76.38,16.4},{76.38,16},{66,16},{66,26},{65.3,26},{
          65.3,34.8}}, color={255,0,255}));
  connect(TSetHeat, heaterCooler.setPointHeat) annotation (Line(points={{-108,-16},
          {-86,-16},{-86,6},{74,6},{74,18},{75.42,18},{75.42,34.8}}, color={0,0,
          127}));
  connect(TSetCool, heaterCooler.setPointCool) annotation (Line(points={{-108,8},
          {70,8},{70,16},{70.36,16},{70.36,34.8}}, color={0,0,127}));
  connect(heaterCooler.coolingPower, PCooler) annotation (Line(points={{84,41.4},
          {84,-2},{98,-2},{98,-20},{110,-20}}, color={0,0,127}));
  connect(heaterCooler.heatingPower, PHeater) annotation (Line(points={{84,46},{
          90,46},{90,0},{110,0}}, color={0,0,127}));
  connect(weaBus, heaterCoolerController.weaBus) annotation (Line(
      points={{-100,34},{-86,34},{-86,10},{58,10},{58,21.44},{62.07,21.44}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heaterCooler.heatCoolRoom, intGainsConv) annotation (Line(points={{82.9,38},
          {96,38},{96,20},{104,20}},     color={191,0,0}));
  connect(corGMod.solarRadWinTrans, simpleExternalShading.solRadWin)
    annotation (Line(points={{-3.4,49},{2.3,49},{2.3,48.92},{3.88,48.92}},
        color={0,0,127}));
  connect(solRadWall.y, simpleExternalShading.solRadTot) annotation (Line(
        points={{-43.5,27},{-38,27},{-38,42},{0,42},{0,48},{3.94,48},{3.94,47.06}},
        color={0,0,127}));
  connect(simpleExternalShading.shadingFactor, eqAirTempWall.sunblind)
    annotation (Line(points={{10.06,44.6},{10,44.6},{10,40},{-32,40},{-32,23.2}},
        color={0,0,127}));
  connect(simpleExternalShading.corrIrr, ROM.solRad) annotation (Line(points={{9.94,
          47.24},{9.94,52},{26,52},{26,89},{37,89}}, color={0,0,127}));

  connect(ventCont.y, addInfVen.u1) annotation (Line(
      points={{-50.8,-26},{-46,-26},{-46,-24},{-41,-24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(intGains[1], ventCont.relOccupation) annotation (Line(points={{80,
          -106.667},{80,-92},{46,-92},{46,-36},{-66,-36},{-66,-30.8}},   color=
          {0,0,127}));
  connect(ventRate, addInfVen.u2) annotation (Line(points={{-108,-64},{-76,-64},
          {-76,-34},{-44,-34},{-44,-30},{-41,-30}},
                                      color={0,0,127}));
  connect(ventRate, mixedTemp.flowRate_flow1) annotation (Line(points={{-108,
          -64},{-76,-64},{-76,1.2},{-55.84,1.2}},
                                             color={0,0,127}));
  connect(ventTemp, mixedTemp.temperature_flow1) annotation (Line(points={{-108,
          -40},{-78,-40},{-78,3.12},{-55.84,3.12}},  color={0,0,127}));
  connect(ROM.TAir, ventCont.Tzone) annotation (Line(points={{87,90},{56,90},{
          56,0},{-2,0},{-2,-16},{-72,-16},{-72,-21.2},{-66,-21.2}},
                                                                  color={0,0,
          127}));
  connect(preTemVen.port, airExc.port_a)
    annotation (Line(points={{-32,-1},{-26,-1},{-26,-6},{-22,-6}},
                                                             color={191,0,0}));
  connect(addInfVen.y, airExc.ventRate) annotation (Line(points={{-29.5,-27},{-24,
          -27},{-24,-12},{-21.2,-12},{-21.2,-11.12}},              color={0,0,
          127}));
  connect(airExc.port_b, ROM.intGainsConv) annotation (Line(points={{-6,-6},{58,
          -6},{58,-2},{92,-2},{92,78},{86,78}},color={191,0,0}));
  connect(weaBus.TDryBul, mixedTemp.temperature_flow2) annotation (Line(
      points={{-99.915,34.08},{-86,34.08},{-86,10},{-80,10},{-80,-0.8},{-55.84,-0.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul, ventCont.Tambient) annotation (Line(
      points={{-99.915,34.08},{-86,34.08},{-86,10},{-80,10},{-80,-26},{-66,-26}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  if internalGainsMode == 3 then
    connect(humanTotHeaDependent.QLat_flow, SumQLat1_flow.u[1]) annotation (
        Line(points={{75.6,-16},{82,-16},{82,-20},{0,-20},{0,-56},{-32,-56},{-32,
            -42},{-54,-42},{-54,-53.875},{-48,-53.875}},
                          color={0,0,127}));
    connect(humanTotHeaDependent.QLat_flow, SumQLat2_flow.u[1]) annotation (
        Line(points={{75.6,-16},{82,-16},{82,-20},{0,-20},{0,-56},{-32,-56},{
            -32,-42},{-54,-42},{-54,-54},{-48,-54},{-48,-54.1667}},
                          color={0,0,127}));
  else
    connect(noMoisturePerson.y, SumQLat1_flow.u[1]) annotation (Line(points={{-61.6,
            -54},{-54,-54},{-54,-53.875},{-48,-53.875}},
                                         color={0,0,127}));
    connect(noMoisturePerson.y, SumQLat2_flow.u[1]) annotation (Line(points={{-61.6,
            -54},{-54,-54},{-54,-54.1667},{-48,-54.1667}},
                                         color={0,0,127}));
  end if;

  if sum(zoneParam.AIze) > 0 then
    connect(ROM.ize, izeHeaFlow) annotation (Line(points={{80.5,92},{80,92},{80,
            96},{104,96}},     color={191,0,0}));
  end if;

if use_NaturalAirExchange and not use_MechanicalAirExchange then
    connect(weaBus.TDryBul, preTemVen.T) annotation (Line(
      points={{-99.915,34.08},{-86,34.08},{-86,10},{-42,10},{-42,-1},{-38.6,-1}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dash), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
    connect(ventCont.y, cO2Balance.airExc) annotation (Line(
      points={{-50.8,-26},{-46,-26},{-46,-34},{12,-34},{12,-63.6},{16,-63.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
    connect(ventCont.y, airExcMoi.ventRate) annotation (Line(
      points={{-50.8,-26},{-46,-26},{-46,-12},{-30,-12},{-30,-11.12},{-21.2,-11.12}},
      color={0,0,127},
      pattern=LinePattern.Dash));
    connect(ventCont.y, airExc.ventRate) annotation (Line(
      points={{-50.8,-26},{-46,-26},{-46,-12},{-30,-12},{-30,-11.12},{-21.2,-11.12}},
      color={0,0,127},
      pattern=LinePattern.Dash));
    connect(x_pTphi.X[1], airExcMoi.HumIn) annotation (Line(
      points={{-63.7,-11},{-62,-11},{-62,-10},{-21.2,-10}},
      color={0,0,127},
      pattern=LinePattern.Dash));
elseif use_MechanicalAirExchange and not use_NaturalAirExchange then
    connect(ventRate, cO2Balance.airExc) annotation (Line(
      points={{-108,-64},{-76,-64},{-76,-34},{12,-34},{12,-63.6},{16,-63.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
    connect(ventRate, airExc.ventRate) annotation (Line(
      points={{-108,-64},{-76,-64},{-76,-34},{-24,-34},{-24,-11.12},{-21.2,-11.12}},
      color={0,0,127},
      pattern=LinePattern.Dash));
    connect(ventRate, airExcMoi.ventRate) annotation (Line(
      points={{-108,-64},{-76,-64},{-76,-34},{-24,-34},{-24,-11.12},{-21.2,-11.12}},
                     color={0,0,127},pattern=LinePattern.Dash));
    connect(ventTemp, preTemVen.T) annotation (Line(
      points={{-108,-40},{-78,-40},{-78,4},{-44,4},{-44,-1},{-38.6,-1}},
      color={0,0,127},pattern=LinePattern.Dash));
    connect(ventHum, airExcMoi.HumIn) annotation (Line(
      points={{-108,-88},{-74,-88},{-74,-4},{-46,-4},{-46,-6},{-30,-6},{-30,-10},
              {-21.2,-10}},
      color={0,0,127},
      pattern=LinePattern.Dash));
else
     connect(addInfVen.y, cO2Balance.airExc) annotation (Line(points={{-29.5,-27},
            {-24,-27},{-24,-34},{12,-34},{12,-63.6},{16,-63.6}},
                                                            color={0,0,127}));
     connect(addInfVen.y, airExc.ventRate) annotation (Line(points={{-29.5,-27},
            {-24,-27},{-24,-11.12},{-21.2,-11.12}},  color={0,0,127}));
     connect(addInfVen.y, airExcMoi.ventRate) annotation (Line(points={{-29.5,
            -27},{-24,-27},{-24,-11.12},{-21.2,-11.12}},
                                                     color={0,0,127}));
     connect(mixedTemp.mixedTemperatureOut, preTemVen.T)  annotation (Line(points={{-48,0},
            {-44,0},{-44,-1},{-38.6,-1}},            color={0,0,127}));
     connect(mixedHumidity.mixedHumidityOut, airExcMoi.HumIn) annotation (Line(
        points={{-48,-8},{-34,-8},{-34,-10},{-21.2,-10}},
                                                        color={0,0,127}));
end if;

  connect(moistureGains.QLat_flow, SumQLat1_flow.u[2]) annotation (Line(points={{-61.6,
          -64},{-54,-64},{-54,-52.125},{-48,-52.125}},                    color=
         {0,0,127}));
  connect(moistureGains.QLat_flow, SumQLat2_flow.u[2]) annotation (Line(points={{-61.6,
          -64},{-54,-64},{-54,-53},{-48,-53}},                            color=
         {0,0,127}));
  connect(SumQLat1_flow.y, ROM.QLat_flow) annotation (Line(points={{-37.15,-53},
          {6,-53},{6,-44},{30,-44},{30,62},{37,62}},
                                                 color={0,0,127}));
  connect(SumQLat2_flow.y, ROM.QLat_flow) annotation (Line(points={{-37.15,-53},
          {6,-53},{6,-44},{30,-44},{30,62},{37,62}},
                                                 color={0,0,127}));
  connect(humVolAirROM.y, X_w) annotation (Line(points={{-19.6,-48},{52,-48},{52,
          -8},{86,-8},{86,-76},{96,-76},{96,-70},{110,-70}},
                                       color={0,0,127}));
  connect(cO2Balance.uRel, intGains[1]) annotation (Line(points={{16,-59.6},{16,
          -54},{46,-54},{46,-106.667},{80,-106.667}},            color={0,0,127}));
  connect(cO2Balance.TAir, TAir) annotation (Line(points={{24,-58},{26,-58},{26,
          0},{96,0},{96,80},{110,80}},
                         color={0,0,127}));
  connect(cO2Balance.CO2Con, CO2Con) annotation (Line(points={{32.8,-70.8},{40,-70.8},
          {40,-82},{94,-82},{94,-90},{110,-90}},
                               color={0,0,127}));
  connect(cO2Balance.XCO2, XCO2.y) annotation (Line(points={{16,-67.6},{16,-67},
          {10.9,-67}}, color={0,0,127}));
  connect(ROM.C_flow[1], cO2Balance.mCO2_flow) annotation (Line(points={{37,84},
          {34,84},{34,-62},{32.8,-62},{32.8,-61.2}},        color={0,0,127}));
  connect(airExcMoi.port_a, preTemVen.port)    annotation (Line(points={{-22,-6},
          {-26,-6},{-26,-1},{-32,-1}},           color={191,0,0}));
  connect(airExcMoi.port_b, ROM.intGainsConv) annotation (Line(points={{-6,-6},
          {58,-6},{58,78},{86,78}}, color={191,0,0}));
  connect(airExcMoi.QLat_flow, SumQLat2_flow.u[3]) annotation (Line(points={{-5.68,
          -10.96},{0,-10.96},{0,-56},{-32,-56},{-32,-42},{-54,-42},{-54,
          -51.8333},{-48,-51.8333}},
        color={0,0,127}));
  connect(humVolAirROM.y, airExcMoi.HumOut) annotation (Line(points={{-19.6,-48},
          {-2,-48},{-2,-1.84},{-6.8,-1.84}},             color={0,0,127}));
  connect(ventHum, mixedHumidity.humidity_flow1) annotation (Line(points={{-108,
          -88},{-74,-88},{-74,-4.88},{-55.84,-4.88}}, color={0,0,127}));
  connect(ventRate, mixedHumidity.flowRate_flow1) annotation (Line(points={{-108,
          -64},{-76,-64},{-76,-6.8},{-55.84,-6.8}}, color={0,0,127}));
  connect(ventCont.y, mixedHumidity.flowRate_flow2) annotation (Line(points={{-50.8,
          -26},{-46,-26},{-46,-12},{-60,-12},{-60,-10.8},{-55.84,-10.8}},
                                                                        color={0,
          0,127}));
  connect(ventCont.y, mixedTemp.flowRate_flow2) annotation (Line(points={{-50.8,
          -26},{-46,-26},{-46,-12},{-60,-12},{-60,-2.8},{-55.84,-2.8}},
                                                                   color={0,0,127}));
  connect(x_pTphi.X[1], mixedHumidity.humidity_flow2) annotation (Line(points={{-63.7,
          -11},{-62,-11},{-62,-8.8},{-55.84,-8.8}},     color={0,0,127}));
  connect(weaBus.pAtm, x_pTphi.p_in) annotation (Line(
      points={{-99.915,34.08},{-86,34.08},{-86,10},{-80,10},{-80,-9.2},{-70.6,-9.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.TDryBul, x_pTphi.T) annotation (Line(
      points={{-99.915,34.08},{-86,34.08},{-86,10},{-80,10},{-80,-11},{-70.6,-11}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.relHum, x_pTphi.phi) annotation (Line(
      points={{-99.915,34.08},{-86,34.08},{-86,10},{-80,10},{-80,-12.8},{-70.6,-12.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(QIntGainsInternalDep_flow.y, QIntGains_flow) annotation (Line(points={{98.2,
          -40},{110,-40}},                   color={0,0,127}));
  connect(QIntGainsInternalInd_flow.y, QIntGains_flow) annotation (Line(points={{98.2,
          -40},{110,-40}},                   color={0,0,127}));
  connect(QIntGainsInternalTot_flow.y, QIntGains_flow) annotation (Line(points={{98.2,
          -40},{110,-40}},                   color={0,0,127}));
  connect(TSoi.TGroOut, eqAirTempWall.TGro_in) annotation (Line(points={{4.4,0},
          {48,0},{48,8.8},{-32,8.8}}, color={0,0,127}));
  connect(TSoi.TGroOut, eqAirTempRoof.TGro_in) annotation (Line(points={{4.4,0},
          {48,0},{48,28},{36,28},{36,62},{-34,62},{-34,64.8}}, color={0,0,127}));

  if use_pools then
    for i in 1:nPools loop
      connect(indoorSwimmingPool[i].radPool, ROM.intGainsRad) annotation (Line(points={{-44.9,
              -70},{-44,-70},{-44,-68},{-36,-68},{-36,-88},{96,-88},{96,82},{86,
              82}},color={0,0,0}));
      connect(indoorSwimmingPool[i].convPool, ROM.intGainsConv) annotation (Line(
        points={{-41.82,-69.76},{-41.82,-70},{-42,-70},{-42,-66},{-10,-66},{-10,
              -40},{20,-40},{20,-6},{58,-6},{58,78},{86,78}},
                        color={191,0,0}));
      connect(indoorSwimmingPool[i].TAir, ROM.TAir) annotation (Line(points={{-51.69,
              -69.82},{-51.69,-62},{-16,-62},{-16,-52},{26,-52},{26,0},{98,0},{98,
              90},{87,90}},
        color={0,0,127}));
      connect(TSoi.TGroOut, indoorSwimmingPool[i].TSoil) annotation (Line(
            points={{4.4,0},{46,0},{46,-8},{36,-8},{36,-84},{-16,-84},{-16,-68},
              {-34,-68},{-34,-73.18},{-39.79,-73.18}}, color={0,0,127}));
      connect(indoorSwimmingPool[i].QPool, SumQPool.u[i]) annotation (Line(points={{-39.44,
              -76.36},{-39.44,-78},{-28,-78}},                color={0,0,127}));
      connect(indoorSwimmingPool[i].PPool, SumPPool.u[i]) annotation (Line(points={{-39.44,
              -80.56},{-32,-80.56},{-32,-78},{-28,-78}},
                                                   color={0,0,127}));
      connect(indoorSwimmingPool[i].m_flow_add_out, SumPool_m_flow_add.u[i])   annotation (Line(points={{-39.44,
              -81.52},{-32,-81.52},{-32,-78},{-28,-78}},                                                                                        color={0,0,
          127}));
      connect(intGains[1], indoorSwimmingPool[i].uRelPer) annotation (Line(points={{80,
              -106.667},{80,-94},{-62,-94},{-62,-77.62},{-54.49,-77.62}},
                                        color={0,0,127}));
      connect(indoorSwimmingPool[i].timeOpe, timeOpe) annotation (Line(points={{-54.42,
              -79.48},{-54.42,-78},{-58,-78},{-58,-108}},
                                                     color={0,0,127}));
      connect(humVolAirROM.y, indoorSwimmingPool[i].X_w) annotation (Line(points={{-19.6,
          -48},{-18,-48},{-18,-64},{-49.03,-64},{-49.03,-69.82}}, color={0,0,127}));
      connect(airFlowMoistureToROM.port_b, ROM.ports[1+nPorts]) annotation (Line(
            points={{-65.94,-73.72},{-65.94,-74},{-72,-74},{-72,8},{58,8},{58,
              50},{77,50},{77,56.05}}, color={0,127,255}));
      connect(airFlowMoistureToROM.port_a, ROM.ports[2+nPorts]) annotation (Line(
            points={{-66,-72.28},{-72,-72.28},{-72,8},{58,8},{58,50},{77,50},{
              77,56.05}}, color={0,127,255}));
    end for;
  end if;

  connect(indoorSwimmingPool.QEva, airFlowMoistureToROM.QEva) annotation (Line(
        points={{-54.28,-71.8},{-57.23,-71.8},{-57.23,-71.92},{-60.18,-71.92}},
        color={0,0,127}));
  connect(indoorSwimmingPool.m_flow_eva, airFlowMoistureToROM.m_flow_eva)
    annotation (Line(points={{-54.42,-73.24},{-57.25,-73.24},{-57.25,-74.11},{-60.15,
          -74.11}}, color={0,0,127}));
  connect(heaterCooler.heaPorRad, ROM.intGainsRad) annotation (Line(points={{82.9,
          33},{92,33},{92,82},{86,82}}, color={191,0,0}));
   annotation (Documentation(revisions="<html><ul>
  <li>April 20, 2023, by Philip Groesdonk:<br/>
  Added five element RC model (for heat exchange with neighboured zones) and
  an option choice for set temperatures of soil, i.e. floor element outdoor 
  surface temperatures. This is for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1080\">issue 1080</a>.
  </li>
  <li>November 20, 2020, by Katharina Breuer:<br/>
    Combine thermal zone models
  </li>
  <li>August 27, 2020, by Katharina Breuer:<br/>
    Add co2 balance
  </li>
  <li>January 09, 2020, by David Jansen:<br/>
    Integration of ideal heater and cooler into the thermal zone.
  </li>
  <li>July 10, 2019, by David Jansen and Martin Kremer:<br/>
    Integration of changeable internal gain models for humans.
  </li>
  <li>April, 2019, by Martin Kremer:<br/>
    Add moisture balance
  </li>
  <li>March 01, 2019, by Niklas Huelsenbeck:<br/>
    Integration of new Internal Gains models,
    HumanSensibleHeatAreaSpecific and MachinesAreaSpecific
  </li>
  <li>September 27, 2016, by Moritz Lauster:<br/>
    Reimplementation based on Annex60 and MSL models.
  </li>
  <li>March, 2012, by Moritz Lauster:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  Comprehensive ready-to-use model for thermal zones, combining
  caclulation core, handling of solar radiation and internal gains.
  Core model is a <a href=
  \"AixLib.ThermalZones.ReducedOrder.RC.FiveElements\">AixLib.ThermalZones.ReducedOrder.RC.FiveElements</a>
  model. Conditional removals of the core model are passed-through
  and related models on thermal zone level are as well conditional. All
  models for solar radiation are part of IBPSA library. Internal
  gains are part of AixLib.
</p>
<p>
  Models for infiltration and natural ventilation, moisture and CO2
  balance are conditional and can be activated by setting the
  parameters true. Moisture is considered in internal gains.
</p>
<h4>
  Typical use and important parameters
</h4>
<p>
  All parameters are collected in one <a href=
  \"AixLib.DataBase.ThermalZones.ZoneBaseRecord\">AixLib.DataBase.ThermalZones.ZoneBaseRecord</a>
  record. Further parameters for medium, initialization and dynamics
  originate from <a href=
  \"AixLib.Fluid.Interfaces.LumpedVolumeDeclarations\">AixLib.Fluid.Interfaces.LumpedVolumeDeclarations</a>.
  A typical use case is a single thermal zone connected via heat ports
  and fluid ports to a heating system. The thermal zone model serves as
  boundary condition for the heating system and calculates the room's
  reaction to external and internal heat sources. The model is used as
  thermal zone core model in <a href=
  \"AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone\">
  AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone</a>
</p>
<p>
  Dependent on the paramter <span style=
  \"font-family: Courier New;\">internalGainsMode</span> different models
  for internal gains by humans will be used. For a correct moisture
  balance the paramter should be set to <span style=
  \"font-family: Courier New;\">3</span>. Otherwise no moisture gain from
  persons will be considered. Using CO2 balance trace substances in the
  media package must be activated. For example <span style=
  \"font-family: Courier New;\">AixLib.Media.Air(extraPropertiesNames={\"C_Flow\"})</span>
  can be used.
</p>
<p>
  <b><span style=\"color: #008000;\">Assumptions</span></b>
</p>
<p>
  There is no moisture exchange through the walls or windows. Only
  moisture exchange is realized by the internal gains, through the
  fluid ports and over the ventilation moisture. This leads to a steady
  increase of moisture in the room, when there is no ventilation.
</p>
<p>
  The moisture balance was formulated considering the latent heat with
  the aim, that the temperature is not influenced by the moisture.For
  this reason every humidity source is assumed to be in gaseous state.
</p>
<h4>
  Accuracy
</h4>
<p>
  Due to usage of constant heat capacaty for steam and constant heat of
  evaporation, the temperature is slightly influenced. Comparing the
  ThermalZone with dry air to the ThermalZone with moist air, the
  maximum difference between the simulated air temperature in the zone
  is 0.07 K for weather data from San Francisco and using the zoneParam
  for office buildings. See therefore: <a href=
  \"AixLib.ThermalZones.ReducedOrder.Examples.ComparisonThermalZoneMoistAndDryAir\">
  ExampleComparisonMoistAndDryAir</a>
</p>
<h4>
  References
</h4>
<p>
  For automatic generation of thermal zone and multizone models as well
  as for datasets, see <a href=
  \"https://github.com/RWTH-EBC/TEASER\">https://github.com/RWTH-EBC/TEASER</a>
</p>
<ul>
  <li>German Association of Engineers: Guideline VDI 6007-1, March
  2012: Calculation of transient thermal response of rooms and
  buildings - Modelling of rooms.
  </li>
  <li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D.
  (2014): Low order thermal network models for dynamic simulations of
  buildings on city district scale. In: Building and Environment 73, p.
  223–231. DOI: <a href=
  \"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>.
  </li>
</ul>
<h4>
  Examples
</h4>
<p>
  See <a href=
  \"AixLib.ThermalZones.ReducedOrder.Examples.ThermalZone\">AixLib.ThermalZones.ReducedOrder.Examples.ThermalZone</a>.
</p>
</html>"), Diagram(graphics={
        Polygon(
          points={{30,10},{-88,10},{-88,58},{-24,58},{-24,26},{30,26},{30,10}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{42,-10},{92,-10},{92,-86},{42,-86},{42,-86},{42,-82},{42,-10}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{65,-7},{90,-18}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Internal Gains"),
        Polygon(
          points={{30,100},{-88,100},{-88,60},{30,60},{30,100},{30,100},{30,100}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-72,62},{-44,50}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Exterior Walls"),
        Text(
          extent={{-8,98},{8,92}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Roof"),
        Polygon(
          points={{32,50},{56,50},{56,10},{32,10},{32,28},{32,26},{32,50}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{33,49},{54,42}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Floor Plate"),
        Polygon(
          points={{-22,58},{30,58},{30,28},{-22,28},{-22,36},{-22,28},{-22,58}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{3,59},{20,52}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Windows"),
        Rectangle(
          extent={{60,50},{90,10}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{58,48},{82,40}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="Heating
Cooling"),
        Rectangle(
          extent={{-72,-40},{-14,-86}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-72,-40},{-56,-48}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="Moisture"),
        Rectangle(
          extent={{-72,6},{-2,-38}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-24,-25},{-1,-36}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Ventilation
Infiltration
"),     Rectangle(
          extent={{-12,-40},{38,-80}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-10,-72},{8,-80}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="CO2")}));
end ThermalZone;
