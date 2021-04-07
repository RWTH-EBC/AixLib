within AixLib.ThermalZones.ReducedOrder.ThermalZone;
model ThermalZone_TABS "Thermal zone containing moisture balance"
  extends
    AixLib.ThermalZones.ReducedOrder.ThermalZone.BaseClasses.PartialThermalZone;

  replaceable model corG = SolarGain.CorrectionGDoublePane
    constrainedby
    AixLib.ThermalZones.ReducedOrder.SolarGain.BaseClasses.PartialCorrectionG
    "Model for correction of solar transmission"
    annotation(choicesAllMatching=true);
  parameter Integer internalGainsMode = 1
     "decides which internal gains model for persons is used";
  parameter Boolean use_AirExchange = false
    "Consider infiltration and ventilation by setting true";

  // Heater/ cooler parameters
  parameter Boolean recOrSep=true "Use record or seperate parameters"
    annotation (Dialog(tab="HeaterCooler", group="Modes"), choices(choice =  false
        "Seperate",choice = true "Record",radioButtons = true));
  parameter Boolean Heater_on=true "Activates the heater"
    annotation (Dialog(tab="HeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real h_heater_Panel=0 "Upper limit controller output of the heater"
    annotation (Dialog(tab="HeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real l_heater_Panel=0 "Lower limit controller output of the heater"
    annotation (Dialog(tab="HeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real h_heater_Rem=0 "Upper limit controller output of the heater"
    annotation (Dialog(tab="HeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real l_heater_Rem=0 "Lower limit controller output of the heater"
    annotation (Dialog(tab="HeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real KR_heater_Panel = 0.1 "Gain of the panel heating controller" annotation(Dialog(tab = "HeaterCooler", group = "Heater",enable=not recOrSep));
  parameter Modelica.SIunits.Time TN_heater_Panel = 4 "Time constant of the panel heating controller" annotation(Dialog(tab = "HeaterCooler", group = "Heater",enable=not recOrSep));
  parameter Real KR_heater_Rem = 0.1 "Gain of the heating controller for radiative and convective heating system" annotation(Dialog(tab = "HeaterCooler", group = "Heater",enable=not recOrSep));
  parameter Modelica.SIunits.Time TN_heater_Rem = 4 "Time constant of the heating controller for radiative and convective heating system" annotation(Dialog(tab = "HeaterCooler", group = "Heater",enable=not recOrSep));

  //DELETE
  parameter Modelica.SIunits.Power p_heater_Panel = 0
  "Limited power for panel heating" annotation(Dialog(tab = "HeaterCooler", group = "Heater"));
  parameter Modelica.SIunits.Power p_heater_Rem = 0
  "Limited power for radiative and convective heating system" annotation(Dialog(tab = "HeaterCooler", group = "Heater"));

  parameter Real share_Heater_TabsExt(min=0, max=1) = 0
    "contribution from a system installed in the core of one or several exterior building components to heating load" annotation(Dialog(tab = "HeaterCooler", group = "Heater"));
  parameter Real share_Heater_TabsInt(min=0, max=1) = 0
    "contribution from a system installed in the core of one or several interior building components to heating load" annotation(Dialog(tab = "HeaterCooler", group = "Heater"));
  parameter Real share_Heater_PanelExt(min=0, max=1) = 0
    "contribution from any heated surfaces of one or several exterior building components to heating load" annotation(Dialog(tab = "HeaterCooler", group = "Heater"));
  parameter Real share_Heater_PanelInt(min=0, max=1) = 0
    "contribution from any heated surfaces of one or several interior building components to heating load" annotation(Dialog(tab = "HeaterCooler", group = "Heater"));
  parameter Real share_Heater_RadExt(min=0, max=1) = 0
    "radiant contribution of one or several exterior building components to heating load" annotation(Dialog(tab = "HeaterCooler", group = "Heater"));
  parameter Real share_Heater_RadInt(min=0, max=1) = 0
    "radiant contribution of one or several interior building components to heating load" annotation(Dialog(tab = "HeaterCooler", group = "Heater"));
  parameter Real share_Heater_Conv(min=0, max=1) = 0
    "convective contribution to heating load" annotation(Dialog(tab = "HeaterCooler", group = "Heater"));
  parameter Boolean Cooler_on=true "Activates the cooler"
    annotation (Dialog(tab="HeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real h_cooler_Panel=0 "Upper limit controller output of the cooler"
    annotation (Dialog(tab="HeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real l_cooler_Panel=0 "Lower limit controller output of the cooler"
    annotation (Dialog(tab="HeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real h_cooler_Rem=0 "Upper limit controller output of the cooler"
    annotation (Dialog(tab="HeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real l_cooler_Rem=0 "Lower limit controller output of the cooler"
    annotation (Dialog(tab="HeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real KR_cooler_Panel = 0.1 "Gain of the panel cooling controller" annotation(Dialog(tab = "HeaterCooler", group = "Cooler",enable=not recOrSep));
  parameter Modelica.SIunits.Time TN_cooler_Panel = 4 "Time constant of the panel cooling controller" annotation(Dialog(tab = "HeaterCooler", group = "Cooler",enable=not recOrSep));
  parameter Real KR_cooler_Rem = 0.1 "Gain of the cooling controller for radiative and convective cooling system" annotation(Dialog(tab = "HeaterCooler", group = "Cooler",enable=not recOrSep));
  parameter Modelica.SIunits.Time TN_cooler_Rem = 4 "Time constant of the cooling controller for radiative and convective cooling system" annotation(Dialog(tab = "HeaterCooler", group = "Cooler",enable=not recOrSep));

  // DELETE
  parameter Modelica.SIunits.Power p_cooler_Panel = 0
  "Limited power for panel cooling" annotation(Dialog(tab = "HeaterCooler", group = "Cooler"));
  parameter Modelica.SIunits.Power p_cooler_Rem = 0
  "Limited power for radiative and convective cooling system" annotation(Dialog(tab = "HeaterCooler", group = "Cooler"));

  parameter Real share_Cooler_TabsExt(min=0, max=1) = 0
    "contribution from a system installed in the core of one or several exterior building components to cooling load" annotation(Dialog(tab = "HeaterCooler", group = "Cooler"));
  parameter Real share_Cooler_TabsInt(min=0, max=1) = 0
    "contribution from a system installed in the core of one or several interior building components to cooling load" annotation(Dialog(tab = "HeaterCooler", group = "Cooler"));
  parameter Real share_Cooler_PanelExt(min=0, max=1) = 0
    "contribution from any cooled surfaces of one or several exterior building components to cooling load" annotation(Dialog(tab = "HeaterCooler", group = "Cooler"));
  parameter Real share_Cooler_PanelInt(min=0, max=1) = 0
    "contribution from any cooled surfaces of one or several interior building components to cooling load" annotation(Dialog(tab = "HeaterCooler", group = "Cooler"));
  parameter Real share_Cooler_RadExt(min=0, max=1) = 0
    "radiant contribution of one or several exterior building components to cooling load" annotation(Dialog(tab = "HeaterCooler", group = "Cooler"));
  parameter Real share_Cooler_RadInt(min=0, max=1) = 0
    "radiant contribution of one or several interior building components to cooling load" annotation(Dialog(tab = "HeaterCooler", group = "Cooler"));
  parameter Real share_Cooler_Conv(min=0, max=1) = 0
    "convective contribution to cooling load" annotation(Dialog(tab = "HeaterCooler", group = "Cooler"));

  // CO2 parameters
  parameter Modelica.SIunits.MassFraction XCO2_amb=6.12157E-4
    "Massfraction of CO2 in atmosphere (equals 403ppm)"
    annotation (Dialog(tab="CO2", enable=use_C_flow));
  parameter Modelica.SIunits.Area areaBod=1.8
    "Body surface area source SIA 2024:2015"
    annotation (Dialog(tab="CO2", enable=use_C_flow));
  parameter Modelica.SIunits.DensityOfHeatFlowRate metOnePerSit=58
    "Metabolic rate of a relaxed seated person  [1 Met = 58 W/m^2]"
    annotation (Dialog(tab="CO2", enable=use_C_flow));

  AixLib.BoundaryConditions.InternalGains.Humans.HumanSensibleHeatTemperatureDependent humanSenHeaDependent(
    final ratioConvectiveHeat=zoneParam.ratioConvectiveHeatPeople,
    final roomArea=zoneParam.AZone,
    final specificPersons=zoneParam.specificPeople,
    final activityDegree=zoneParam.activityDegree,
    final specificHeatPerPerson=zoneParam.fixedHeatFlowRatePersons) if ATot > 0 and internalGainsMode == 1 annotation (Placement(transformation(extent={{56,-34},
            {76,-14}})));

  AixLib.BoundaryConditions.InternalGains.Humans.HumanSensibleHeatTemperatureIndependent humanSenHeaIndependent(
    final ratioConvectiveHeat=zoneParam.ratioConvectiveHeatPeople,
    final roomArea=zoneParam.AZone,
    final specificPersons=zoneParam.specificPeople,
    final specificHeatPerPerson=zoneParam.fixedHeatFlowRatePersons) if ATot > 0 and internalGainsMode == 2 annotation (Placement(transformation(extent={{56,-34},
            {76,-14}})));

  AixLib.BoundaryConditions.InternalGains.Humans.HumanTotalHeatTemperatureDependent humanTotHeaDependent(
    final ratioConvectiveHeat=zoneParam.ratioConvectiveHeatPeople,
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
    final UWin=zoneParam.UWin) if
    sum(zoneParam.ATransparent) > 0 "Correction factor for solar transmission"
    annotation (Placement(transformation(extent={{-16,43},{-4,55}})));
  EquivalentAirTemperature.VDI6007WithWindow eqAirTempWall(
    withLongwave=true,
    final n=zoneParam.nOrientations,
    final wfWall=zoneParam.wfWall,
    final wfWin=zoneParam.wfWin,
    final wfGro=zoneParam.wfGro,
    final hConWallOut=zoneParam.hConWallOut,
    final hRad=zoneParam.hRadWall,
    final use_sunblind=sum(zoneParam.ATransparent) > 0,
    final hConWinOut=zoneParam.hConWinOut,
    final aExt=zoneParam.aExt,
    final TGro=zoneParam.TSoil) if (sum(zoneParam.AExt) + sum(zoneParam.AWin)) > 0
    "Computes equivalent air temperature"
    annotation (Placement(transformation(extent={{-38,10},{-26,22}})));
  EquivalentAirTemperature.VDI6007 eqAirTempRoof(
    final wfGro=0,
    final n=zoneParam.nOrientationsRoof,
    final aExt=zoneParam.aRoof,
    final wfWall=zoneParam.wfRoof,
    final hConWallOut=zoneParam.hConRoofOut,
    final hRad=zoneParam.hRadRoof,
    final wfWin=fill(0, zoneParam.nOrientationsRoof),
    final TGro=273.15) if zoneParam.ARoof > 0
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
    each final lat=zoneParam.lat,
    final azi=zoneParam.aziExtWalls,
    final til=zoneParam.tiltExtWalls)
    "Calculates diffuse solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-84,10},{-68,26}})));
  BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTilWall[zoneParam.nOrientations](
    each final lat=zoneParam.lat,
    final azi=zoneParam.aziExtWalls,
    final til=zoneParam.tiltExtWalls)
    "Calculates direct solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-84,31},{-68,48}})));
  BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTilRoof[zoneParam.nOrientationsRoof](
    each final lat=zoneParam.lat,
    final azi=zoneParam.aziRoof,
    final til=zoneParam.tiltRoof)
    "Calculates direct solar radiation on titled surface for roof"
    annotation (Placement(transformation(extent={{-84,82},{-68,98}})));
  Utilities.Sources.HeaterCoolerVDI6007AC1.HeaterCoolerWithTabs6007C1 heaterCoolerWithTabs6007C1(
    each h_heater_Panel=h_heater_Panel,
    each l_heater_Panel=l_heater_Panel,
    each h_heater_Rem=h_heater_Rem,
    each l_heater_Rem=l_heater_Rem,
    each KR_heater_Panel=KR_heater_Panel,
    each TN_heater_Panel=TN_heater_Panel,
    each KR_heater_Rem=KR_heater_Rem,
    each TN_heater_Rem=TN_heater_Rem,
    each share_Heater_TabsExt=share_Heater_TabsExt,
    each share_Heater_TabsInt=share_Heater_TabsInt,
    each share_Heater_PanelExt=share_Heater_PanelExt,
    each share_Heater_PanelInt=share_Heater_PanelInt,
    each share_Heater_RadExt=share_Heater_RadExt,
    each share_Heater_RadInt=share_Heater_RadInt,
    each share_Heater_Conv=share_Heater_Conv,
    each h_cooler_Panel=h_cooler_Panel,
    each l_cooler_Panel=l_cooler_Panel,
    each h_cooler_Rem=h_cooler_Rem,
    each l_cooler_Rem=l_cooler_Rem,
    each KR_cooler_Panel=KR_cooler_Panel,
    each TN_cooler_Panel=TN_cooler_Panel,
    each KR_cooler_Rem=KR_cooler_Rem,
    each TN_cooler_Rem=TN_cooler_Rem,
    each share_Cooler_TabsExt=share_Cooler_TabsExt,
    each share_Cooler_TabsInt=share_Cooler_TabsInt,
    each share_Cooler_PanelExt=share_Cooler_PanelExt,
    each share_Cooler_PanelInt=share_Cooler_PanelInt,
    each share_Cooler_RadExt=share_Cooler_RadExt,
    each share_Cooler_RadInt=share_Cooler_RadInt,
    each share_Cooler_Conv=share_Cooler_Conv,
    final zoneParam=zoneParam,
    each recOrSep=recOrSep,
    each Heater_on=Heater_on,
    each Cooler_on=Cooler_on,
    each staOrDyn=not zoneParam.withIdealThresholds) if (ATot > 0 or zoneParam.VAir
     > 0) and (recOrSep and (zoneParam.HeaterOn or zoneParam.CoolerOn)) or (
    not recOrSep and (Heater_on or Cooler_on))
    annotation (Placement(transformation(extent={{66,26},{84,38}})));
  Utilities.Sources.HeaterCoolerVDI6007AC1.tabsHeaterCoolerController
    tabsHeaterCoolerController(
    zoneParam=zoneParam, recOrSep=recOrSep)  annotation (Placement(transformation(extent={{76,10},{90,24}})));
  Utilities.Sources.HeaterCooler.HeaterCoolerController heaterCoolerController(zoneParam=
       zoneParam) if zoneParam.withIdealThresholds
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=0,
        origin={67,17})));
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
  SolarGain.SimpleExternalShading simpleExternalShading(
    final nOrientations=zoneParam.nOrientations,
    final maxIrrs=zoneParam.maxIrr,
    final gValues=zoneParam.shadingFactor) if
    sum(zoneParam.ATransparent) > 0
    annotation (Placement(transformation(extent={{4,44},{10,50}})));

  // Air Exchange
  Controls.VentilationController.VentilationController ventCont(
    final useConstantOutput=zoneParam.useConstantACHrate,
    final baseACH=zoneParam.baseACH,
    final maxUserACH=zoneParam.maxUserACH,
    final maxOverheatingACH=zoneParam.maxOverheatingACH,
    final maxSummerACH=zoneParam.maxSummerACH,
    final winterReduction=zoneParam.winterReduction,
    final Tmean_start=zoneParam.T_start) if
       (ATot > 0 or zoneParam.VAir > 0) and use_AirExchange
    "Calculates natural venitlation and infiltration"
    annotation (Placement(transformation(extent={{-68,-34},{-48,-14}})));
  Utilities.Psychrometrics.MixedTemperature mixedTemp if
       (ATot > 0 or zoneParam.VAir > 0) and use_AirExchange
    "Mixes temperature of infiltration flow and mechanical ventilation flow"
    annotation (Placement(transformation(extent={{-66,-14},{-46,4}})));
  HighOrder.Components.DryAir.VarAirExchange airExc(final V=zoneParam.VAir) if
       (ATot > 0 or zoneParam.VAir > 0) and use_AirExchange and not use_moisture_balance
    "Heat flow due to ventilation"
    annotation (Placement(transformation(extent={{-22,-12},{-6,4}})));

  Modelica.Blocks.Interfaces.RealInput ventTemp(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) if (ATot > 0 or zoneParam.VAir > 0) and use_AirExchange
    "Ventilation and infiltration temperature"
    annotation (Placement(
        transformation(extent={{-128,-60},{-88,-20}}), iconTransformation(
          extent={{-106,-26},{-86,-6}})));
  Modelica.Blocks.Interfaces.RealInput ventRate(final quantity="VolumeFlowRate",
      final unit="1/h") if (ATot > 0 or zoneParam.VAir > 0) and use_AirExchange
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
    zoneParam.VAir > 0) and use_moisture_balance and not use_AirExchange
    annotation (Placement(transformation(extent={{-40,-68},{-28,-56}})));
  Modelica.Blocks.Math.MultiSum SumQLat2_flow(nu=3) if (ATot > 0 or
    zoneParam.VAir > 0) and use_moisture_balance and use_AirExchange
    annotation (Placement(transformation(extent={{-40,-68},{-28,-56}})));
  BoundaryConditions.InternalGains.Moisture.MoistureGains moistureGains(
    final roomArea=zoneParam.AZone,
    final specificMoistureProduction=zoneParam.internalGainsMoistureNoPeople) if
       ATot > 0 and use_moisture_balance
    "Internal moisture gains by plants, etc."
    annotation (Dialog(enable=use_moisture_balance, tab="Moisture"),
      Placement(transformation(extent={{-70,-78},{-60,-68}})));
  Modelica.Blocks.Sources.Constant noMoisturePerson(k=0) if
       internalGainsMode <> 3 and use_moisture_balance
    annotation (Placement(transformation(extent={{-58,-66},{-50,-58}})));
  Modelica.Blocks.Interfaces.RealOutput X_w if
       (ATot > 0 or zoneParam.VAir > 0) and use_moisture_balance
    "Humidity output" annotation (Placement(transformation(extent={{100,-80},{
            120,-60}}),
                    iconTransformation(extent={{100,-80},{120,-60}})));
  Modelica.Blocks.Interfaces.RealInput ventHum(
    final quantity="MassFraction",
    final unit="kg/kg",
    min=0) if (ATot > 0 or zoneParam.VAir > 0) and use_moisture_balance and use_AirExchange
    "Ventilation and infiltration humidity" annotation (Placement(
        transformation(extent={{-128,-108},{-88,-68}}), iconTransformation(
          extent={{-106,-82},{-84,-60}})));
  HighOrder.Components.MoistAir.VarMoistAirExchange airExcMoi(final V=zoneParam.VAir) if
    (ATot > 0 or zoneParam.VAir > 0) and use_AirExchange and use_moisture_balance
    "Heat flow due to ventilation"
    annotation (Placement(transformation(extent={{-22,-12},{-6,4}})));

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
    annotation (Placement(transformation(extent={{20,-74},{34,-60}})));
  Modelica.Blocks.Interfaces.RealOutput CO2Con if (ATot > 0 or zoneParam.VAir
     > 0) and use_C_flow "CO2 concentration in the thermal zone in ppm"
    annotation (Placement(transformation(extent={{100,-100},{120,-80}}),
        iconTransformation(extent={{100,-100},{120,-80}})));

  Modelica.Blocks.Sources.RealExpression XCO2(y=ROM.volMoiAir.C[1]) if (ATot >
    0 or zoneParam.VAir > 0) and use_C_flow
    "Mass fraction of co2 in ROM in kg_CO2/ kg_TotalAir"
    annotation (Placement(transformation(extent={{-8,-74},{10,-60}})));

  // protected: ThermalZone
protected
    Modelica.Blocks.Sources.Constant hConRoof(final k=(zoneParam.hConRoofOut + zoneParam.hRadRoof)*zoneParam.ARoof)
    "Outdoor coefficient of heat transfer for roof" annotation (Placement(transformation(extent={{-14,68},
            {-6,76}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConRoof if
    zoneParam.ARoof > 0
    "Outdoor convective heat transfer of roof"
    annotation (Placement(transformation(extent={{5,5},{-5,-5}},rotation=0,
    origin={5,83})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemRoof if
    zoneParam.ARoof > 0
    "Prescribed temperature for roof outdoor surface temperature"
    annotation (Placement(transformation(extent={{-4.5,-4},{4.5,4}},
                                                                rotation=0,
    origin={-9.5,84})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemFloor if
    zoneParam.AFloor > 0
    "Prescribed temperature for floor plate outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
    rotation=90,origin={48,36})));
  Modelica.Blocks.Sources.Constant TSoil(final k=zoneParam.TSoil) if
    zoneParam.AFloor > 0
    "Outdoor surface temperature for floor plate"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
    rotation=180,origin={39,22})));
  Modelica.Blocks.Sources.Constant hConWall(final k=(zoneParam.hConWallOut + zoneParam.hRadWall)*sum(zoneParam.AExt))
    "Outdoor coefficient of heat transfer for walls" annotation (Placement(transformation(extent={{4,-4},{
            -4,4}},                                                                                               rotation=180,
        origin={-2,16})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWall if
    sum(zoneParam.AExt) > 0
    "Outdoor convective heat transfer of walls"
    annotation (Placement(transformation(extent={{26,24},{16,14}})));
  Modelica.Blocks.Sources.Constant hConWin(final k=(zoneParam.hConWinOut + zoneParam.hRadWall)*sum(zoneParam.AWin))
    "Outdoor coefficient of heat transfer for windows" annotation (Placement(transformation(extent={{4,-4},{-4,4}}, rotation=90,
        origin={22,48})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWin if
    sum(zoneParam.AWin) > 0
    "Outdoor convective heat transfer of windows"
    annotation (Placement(transformation(extent={{26,30},{16,40}})));
  Modelica.Blocks.Math.Add solRadRoof[zoneParam.nOrientationsRoof]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{-58,82},{-48,92}})));
  Modelica.Blocks.Math.Add solRadWall[zoneParam.nOrientations]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{-54,22},{-44,32}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemWall if
    sum(zoneParam.AExt) > 0
    "Prescribed temperature for exterior walls outdoor surface temperature"
    annotation (Placement(transformation(extent={{-18,16},{-10,24}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemWin if
    sum(zoneParam.AWin) > 0
    "Prescribed temperature for windows outdoor surface temperature"
    annotation (Placement(transformation(extent={{4,31},{12,38}})));

  // protected: AirExchange
  Modelica.Blocks.Math.Add addInfVen if
       (ATot > 0 or zoneParam.VAir > 0) and use_AirExchange
    "Combines infiltration and ventilation"
    annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-34,-28})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemVen if
       (ATot > 0 or zoneParam.VAir > 0) and use_AirExchange
    "Prescribed temperature for ventilation"
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-34,-4})));

  // protected: MoistAir
  Modelica.Blocks.Sources.RealExpression humVolAirROM(y=ROM.volMoiAir.X_w) if
       (ATot > 0 or zoneParam.VAir > 0) and use_moisture_balance
    annotation (Placement(transformation(extent={{-70,-58},{-60,-42}})));

public
  BoundaryConditions.SolarIrradiation.DiffusePerez HDifTilRoof[zoneParam.nOrientationsRoof](
    each final outSkyCon=false,
    each final outGroCon=false,
    each final lat=zoneParam.lat,
    final azi=zoneParam.aziRoof,
    final til=zoneParam.tiltRoof)
    "Calculates diffuse solar radiation on titled surface for roof"
    annotation (Placement(transformation(extent={{-84,61},{-68,77}})));
equation
  connect(intGains[2], machinesSenHea.uRel) annotation (Line(points={{80,-100},{
          80,-94},{78,-94},{78,-88},{48,-88},{48,-46.5},{56,-46.5}}, color={0,0,
          127}));
  connect(intGains[3], lights.uRel) annotation (Line(points={{80,-86.6667},{80,
          -86},{50,-86},{50,-68.5},{56,-68.5}},
                                           color={0,0,127}));
  connect(lights.convHeat, ROM.intGainsConv) annotation (Line(points={{75,-62.8},
          {92,-62.8},{92,78},{86,78}}, color={191,0,0}));
  connect(machinesSenHea.convHeat, ROM.intGainsConv) annotation (Line(points={{75,
          -40.8},{92,-40.8},{92,78},{86,78}}, color={191,0,0}));
  connect(intGains[1], humanSenHeaDependent.uRel) annotation (Line(points={{80,
          -113.333},{80,-92},{46,-92},{46,-24},{56,-24}},
                                                color={0,0,127}));
  connect(humanSenHeaDependent.convHeat, ROM.intGainsConv) annotation (Line(
        points={{75,-18},{92,-18},{92,78},{86,78}}, color={191,0,0}));
  connect(ROM.intGainsConv, humanSenHeaDependent.TRoom) annotation (Line(points=
         {{86,78},{92,78},{92,-10},{57,-10},{57,-15}}, color={191,0,0}));
  connect(humanSenHeaDependent.radHeat, ROM.intGainsRad) annotation (Line(
        points={{75,-30},{94,-30},{94,82},{86,82}}, color={95,95,95}));
  connect(intGains[1], humanSenHeaIndependent.uRel) annotation (Line(points={{80,
          -113.333},{80,-92},{46,-92},{46,-24},{56,-24}}, color={0,0,127}));
  connect(humanSenHeaIndependent.convHeat, ROM.intGainsConv) annotation (Line(
        points={{75,-18},{92,-18},{92,78},{86,78}}, color={191,0,0}));
  connect(ROM.intGainsConv, humanSenHeaIndependent.TRoom) annotation (Line(
        points={{86,78},{92,78},{92,-10},{57,-10},{57,-15}}, color={191,0,0}));
  connect(humanSenHeaIndependent.radHeat, ROM.intGainsRad) annotation (Line(
        points={{75,-30},{94,-30},{94,82},{86,82}}, color={95,95,95}));
  connect(intGains[1], humanTotHeaDependent.uRel) annotation (Line(points={{80,
          -113.333},{80,-92},{46,-92},{46,-24},{56,-24}},
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
      points={{-100,34},{-86,34},{-86,10},{-60,10},{-60,16},{-39.2,16}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul, eqAirTempWall.TDryBul) annotation (Line(
      points={{-100,34},{-86,34},{-86,10},{-60,10},{-60,12.4},{-39.2,12.4}},
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
      points={{-100,34},{-86,34},{-86,60},{-46,60},{-46,68.4},{-41.2,68.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TBlaSky, eqAirTempRoof.TBlaSky) annotation (Line(
      points={{-100,34},{-86,34},{-86,60},{-46,60},{-46,72},{-41.2,72}},
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
  connect(TSoil.y, preTemFloor.T)
    annotation (Line(points={{43.4,22},{48,22},{48,28.8}}, color={0,0,127}));
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

  connect(heaterCoolerController.heaterActive, heaterCoolerWithTabs6007C1.heaterActive)
    annotation (Line(points={{72.74,18.4},{72.74,23.2},{78.825,23.2},{78.825,27.68}},
        color={255,0,255}));
  connect(heaterCoolerController.coolerActive, heaterCoolerWithTabs6007C1.coolerActive)
    annotation (Line(points={{72.74,15.6},{72.74,21.8},{71.0625,21.8},{71.0625,27.68}},
        color={255,0,255}));
  connect(tabsHeaterCoolerController.tabsHeatingPower,
    heaterCoolerWithTabs6007C1.tabsHeatingPower) annotation (Line(points={{88.74,
          18.4},{82,18.4},{82,18},{74,18},{74,24},{68,24},{68,33.2},{66,33.2}},
        color={0,0,127}));
  connect(tabsHeaterCoolerController.tabsCoolingPower,
    heaterCoolerWithTabs6007C1.tabsCoolingPower) annotation (Line(points={{88.74,
          15.6},{82,15.6},{82,16},{74,16},{74,24},{68,24},{68,30},{66,30},{66,30.8}},
        color={0,0,127}));
  connect(TSetHeat, heaterCoolerWithTabs6007C1.setPointHeat) annotation (Line(
        points={{-108,-16},{-84,-16},{-84,6},{76.2375,6},{76.2375,27.68}}, color=
         {0,0,127}));
  connect(TSetCool, heaterCoolerWithTabs6007C1.setPointCool) annotation (Line(
        points={{-108,8},{-108,16},{74,16},{74,6},{-82,6},{-82,27.68},{73.65,27.68}},
        color={0,0,127}));
  connect(heaterCoolerWithTabs6007C1.heatingPower, PHeater) annotation (Line(
        points={{80.625,34.4},{96,34.4},{96,0},{110,0}}, color={0,0,127}));
  connect(heaterCoolerWithTabs6007C1.coolingPower, PCooler) annotation (Line(
        points={{80.625,31.64},{82,31.64},{82,32},{98,32},{98,-20},{110,-20}},
        color={0,0,127}));
  connect(TAir, heaterCoolerWithTabs6007C1.TAir) annotation (Line(points={{110,80},
          {88,80},{88,38},{66.5625,38}}, color={0,0,127}));
  connect(TRad, heaterCoolerWithTabs6007C1.TRad) annotation (Line(points={{110,60},
          {90,60},{90,38},{68.25,38}}, color={0,0,127}));
  connect(heaterCoolerWithTabs6007C1.heatCoolTabsExt, ROM.tabsExtWalls)
    annotation (Line(points={{70.5,37.76},{70.5,38.88},{80.8,38.88},{80.8,56}},
        color={191,0,0}));
  connect(heaterCoolerWithTabs6007C1.heatCoolRadExt, ROM.hkRadExtWalls)
    annotation (Line(points={{76.125,37.76},{76.125,38.88},{86,38.88},{86,56}},
        color={191,0,0}));
  connect(heaterCoolerWithTabs6007C1.heatCoolPanelExt, ROM.fhkExtWalls)
    annotation (Line(points={{73.3125,37.76},{73.3125,39.88},{86,39.88},{86,58.6}},
        color={191,0,0}));
  connect(heaterCoolerWithTabs6007C1.heatCoolConv, ROM.hkConv) annotation (Line(
        points={{78.9375,37.76},{78.9375,38.88},{86,38.88},{86,61}}, color={191,0,
          0}));
  connect(heaterCoolerWithTabs6007C1.heatCoolPanelInt, ROM.fhkIntWalls)
    annotation (Line(points={{74.7188,37.76},{74.7188,38.88},{86,38.88},{86,
          63.4}},
        color={191,0,0}));
  connect(heaterCoolerWithTabs6007C1.heatCoolRadInt, ROM.hkRadIntWalls)
    annotation (Line(points={{77.5313,37.76},{77.5313,39.88},{86,39.88},{86,
          65.8}},
        color={191,0,0}));
  connect(heaterCoolerWithTabs6007C1.heatCoolTabsInt, ROM.tabsIntWalls)
    annotation (Line(points={{71.9063,37.76},{71.9063,38},{72,38},{72,40},{86,
          40},{86,72}},
                    color={191,0,0}));
  connect(weaBus, tabsHeaterCoolerController.weaBus) annotation (Line(
      points={{-100,34},{-88,34},{-88,10},{76,10},{76,20.01},{77.61,20.01}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, heaterCoolerController.weaBus) annotation (Line(
      points={{-100,34},{-86,34},{-86,10},{58,10},{58,20.01},{61.61,20.01}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
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
      points={{-49,-24},{-41.2,-24},{-41.2,-24.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(intGains[1], ventCont.relOccupation) annotation (Line(points={{80,
          -113.333},{80,-92},{46,-92},{46,-36},{-68,-36},{-68,-30}},     color=
          {0,0,127}));
  connect(ventRate, addInfVen.u2) annotation (Line(points={{-108,-64},{-74,-64},
          {-74,-34},{-42,-34},{-42,-31.6},{-41.2,-31.6}},
                                      color={0,0,127}));
  connect(ventCont.y, mixedTemp.flowRate_flow2) annotation (Line(points={{-49,-24},
          {-46,-24},{-46,-12},{-65.6,-12},{-65.6,-11.3}},       color={0,0,127}));
  connect(ventRate, mixedTemp.flowRate_flow1) annotation (Line(points={{-108,-64},
          {-74,-64},{-74,-2.3},{-65.6,-2.3}},color={0,0,127}));
  connect(ventTemp, mixedTemp.temperature_flow1) annotation (Line(points={{-108,
          -40},{-76,-40},{-76,2.02},{-65.6,2.02}},   color={0,0,127}));
  connect(ROM.TAir, ventCont.Tzone) annotation (Line(points={{87,90},{56,90},{56,
          0},{-2,0},{-2,-14},{-72,-14},{-72,-18},{-68,-18}},      color={0,0,
          127}));
  connect(preTemVen.port, airExc.port_a)
    annotation (Line(points={{-30,-4},{-22,-4}},             color={191,0,0}));
  connect(mixedTemp.mixedTemperatureOut, preTemVen.T)
    annotation (Line(points={{-46,-5},{-42,-5},{-42,-4},{-38.8,-4}},
                                                     color={0,0,127}));
  connect(addInfVen.y, airExc.ventRate) annotation (Line(points={{-27.4,-28},{
          -24,-28},{-24,-10},{-21.2,-10},{-21.2,-9.12}},           color={0,0,
          127}));
  connect(airExc.port_b, ROM.intGainsConv) annotation (Line(points={{-6,-4},{92,
          -4},{92,78},{86,78}},                color={191,0,0}));
  connect(weaBus.TDryBul, mixedTemp.temperature_flow2) annotation (Line(
      points={{-100,34},{-86,34},{-86,10},{-78,10},{-78,-6.8},{-65.6,-6.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul, ventCont.Tambient) annotation (Line(
      points={{-100,34},{-86,34},{-86,10},{-78,10},{-78,-24},{-68,-24}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  if internalGainsMode == 3 then
    connect(humanTotHeaDependent.QLat_flow, SumQLat1_flow.u[1]) annotation (
        Line(points={{75.6,-16},{92,-16},{92,-4},{8,-4},{8,-54},{-42,-54},{-42,-59.9},
            {-40,-59.9}}, color={0,0,127}));
    connect(humanTotHeaDependent.QLat_flow, SumQLat2_flow.u[1]) annotation (
        Line(points={{75.6,-16},{92,-16},{92,-4},{8,-4},{8,-54},{-42,-54},{-42,-59.2},
            {-40,-59.2}}, color={0,0,127}));
  else
    connect(noMoisturePerson.y, SumQLat1_flow.u[1]) annotation (Line(points={{-49.6,
            -62},{-40,-62},{-40,-59.9}}, color={0,0,127}));
    connect(noMoisturePerson.y, SumQLat2_flow.u[1]) annotation (Line(points={{-49.6,
            -62},{-40,-62},{-40,-59.2}}, color={0,0,127}));
  end if;
  connect(moistureGains.QLat_flow, SumQLat1_flow.u[2]) annotation (Line(points={{-59.5,
          -73},{-52,-73},{-52,-74},{-46,-74},{-46,-64.1},{-40,-64.1}},    color=
         {0,0,127}));
  connect(moistureGains.QLat_flow, SumQLat2_flow.u[2]) annotation (Line(points={
          {-59.5,-73},{-52,-73},{-52,-74},{-46,-74},{-46,-62},{-40,-62}}, color=
         {0,0,127}));
  connect(SumQLat1_flow.y, ROM.QLat_flow) annotation (Line(points={{-26.98,-62},
          {2,-62},{2,4},{32,4},{32,62},{37,62}}, color={0,0,127}));
  connect(SumQLat2_flow.y, ROM.QLat_flow) annotation (Line(points={{-26.98,-62},
          {2,-62},{2,4},{32,4},{32,62},{37,62}}, color={0,0,127}));
  connect(humVolAirROM.y, X_w) annotation (Line(points={{-59.5,-50},{4,-50},{4,
          -6},{96,-6},{96,-70},{110,-70}},
                                       color={0,0,127}));
  connect(addInfVen.y, cO2Balance.airExc) annotation (Line(points={{-27.4,-28},{
          -24,-28},{-24,-40},{12,-40},{12,-64.9},{20,-64.9}},
                                                            color={0,0,127}));
  connect(cO2Balance.uRel, intGains[1]) annotation (Line(points={{20,-61.4},{20,
          -50},{46,-50},{46,-113.333},{80,-113.333}},            color={0,0,127}));
  connect(cO2Balance.TAir, TAir) annotation (Line(points={{27,-60},{26,-60},{26,
          0},{96,0},{96,80},{110,80}},
                         color={0,0,127}));
  connect(cO2Balance.CO2Con, CO2Con) annotation (Line(points={{34.7,-71.2},{40,
          -71.2},{40,-82},{94,-82},{94,-90},{110,-90}},
                               color={0,0,127}));
  connect(cO2Balance.XCO2, XCO2.y) annotation (Line(points={{20,-68.4},{20,-67},
          {10.9,-67}}, color={0,0,127}));
  connect(ROM.C_flow[1], cO2Balance.mCO2_flow) annotation (Line(points={{37,84},
          {34,84},{34,-6},{50,-6},{50,-62.8},{34.7,-62.8}}, color={0,0,127}));

  connect(airExcMoi.port_a, preTemVen.port)
    annotation (Line(points={{-22,-4},{-30,-4}}, color={191,0,0}));
  connect(airExcMoi.ventRate, addInfVen.y) annotation (Line(points={{-21.2,
          -9.12},{-24,-9.12},{-24,-28},{-27.4,-28}}, color={0,0,127}));
  connect(airExcMoi.HumIn, ventHum) annotation (Line(points={{-21.2,-8},{-44,-8},
          {-44,-88},{-108,-88}}, color={0,0,127}));
  connect(airExcMoi.port_b, ROM.intGainsConv) annotation (Line(points={{-6,-4},
          {58,-4},{58,78},{86,78}}, color={191,0,0}));
  connect(airExcMoi.QLat_flow, SumQLat2_flow.u[3]) annotation (Line(points={{
          -5.68,-8.96},{-6,-8.96},{-6,-40},{-42,-40},{-42,-64.8},{-40,-64.8}},
        color={0,0,127}));
  connect(humVolAirROM.y, airExcMoi.HumOut) annotation (Line(points={{-59.5,-50},
          {-4,-50},{-4,0},{-6,0},{-6,0.16},{-6.8,0.16}}, color={0,0,127}));
  annotation (Documentation(revisions="<html>
<ul>
<li>November 20, 2020, by Katharina Breuer:<br>Combine thermal zone models</li>
<li>August 27, 2020, by Katharina Breuer:<br>Add co2 balance</li>
<li>January 09, 2020, by David Jansen:<br>Integration of ideal heater and cooler into the thermal zone. </li>
<li>July 10, 2019, by David Jansen and Martin Kremer:<br>Integration of changeable internal gain models for humans. </li>
<li>April, 2019, by Martin Kremer:<br>Add moisture balance</li>
<li>March 01, 2019, by Niklas Huelsenbeck:<br>Integration of new Internal Gains models, HumanSensibleHeatAreaSpecific and MachinesAreaSpecific </li>
<li>September 27, 2016, by Moritz Lauster:<br>Reimplementation based on Annex60 and MSL models. </li>
<li>March, 2012, by Moritz Lauster:<br>First implementation.</li>
</ul>
</html>", info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>Comprehensive ready-to-use model for thermal zones, combining caclulation core, handling of solar radiation and internal gains. Core model is a <a href=\"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">AixLib.ThermalZones.ReducedOrder.RC.FourElements</a> model. Conditional removements of the core model are passed-through and related models on thermal zone level are as well conditional. All models for solar radiation are part of Annex60 library. Internal gains are part of AixLib.</p>
<p>Models for infiltration and natural ventilation, moisture and CO2 balance are conditional and can be activated by setting the parameters true. Moisture is considered in internal gains.</p>
<h4>Typical use and important parameters </h4>
<p>All parameters are collected in one <a href=\"AixLib.DataBase.ThermalZones.ZoneBaseRecord\">AixLib.DataBase.ThermalZones.ZoneBaseRecord</a> record. Further parameters for medium, initialization and dynamics originate from <a href=\"AixLib.Fluid.Interfaces.LumpedVolumeDeclarations\">AixLib.Fluid.Interfaces.LumpedVolumeDeclarations</a>. A typical use case is a single thermal zone connected via heat ports and fluid ports to a heating system. The thermal zone model serves as boundary condition for the heating system and calculates the room&apos;s reaction to external and internal heat sources. The model is used as thermal zone core model in <a href=\"AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone\">AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone</a> </p>
<p>Dependent on the paramter <span style=\"font-family: Courier New;\">internalGainsMode</span> different models for internal gains by humans will be used. For a correct moisture balance the paramter should be set to <span style=\"font-family: Courier New;\">3</span>. Otherwise no moisture gain from persons will be considered. Using CO2 balance trace substances in the media package must be activated. For example <span style=\"font-family: Courier New;\">AixLib.Media.Air(extraPropertiesNames={&quot;C_Flow&quot;})</span> can be used.</p>
<p><b><span style=\"color: #008000;\">Assumptions</span></b> </p>
<p>There is no moisture exchange through the walls or windows. Only moisture exchange is realized by the internal gains, through the fluid ports and over the ventilation moisture. This leads to a steady increase of moisture in the room, when there is no ventilation. </p>
<p>The moisture balance was formulated considering the latent heat with the aim, that the temperature is not influenced by the moisture.For this reason every humidity source is assumed to be in gaseous state. </p>
<h4>Accuracy </h4>
<p>Due to usage of constant heat capacaty for steam and constant heat of evaporation, the temperature is slightly influenced. Comparing the ThermalZone with dry air to the ThermalZone with moist air, the maximum difference between the simulated air temperature in the zone is 0.07 K for weather data from San Francisco and using the zoneParam for office buildings. See therefore: <a href=\"AixLib.ThermalZones.ReducedOrder.Examples.ComparisonThermalZoneMoistAndDryAir\">ExampleComparisonMoistAndDryAir</a> </p>
<h4>References </h4>
<p>For automatic generation of thermal zone and multizone models as well as for datasets, see <a href=\"https://github.com/RWTH-EBC/TEASER\">https://github.com/RWTH-EBC/TEASER</a> </p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms. </li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>. </li>
</ul>
<h4>Examples </h4>
<p>See <a href=\"AixLib.ThermalZones.ReducedOrder.Examples.ThermalZone\">AixLib.ThermalZones.ReducedOrder.Examples.ThermalZone</a>. </p>
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
          extent={{-72,-42},{-22,-80}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-48,-42},{-30,-50}},
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
          extent={{-12,-42},{38,-80}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-10,-72},{8,-80}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="CO2")}));
end ThermalZone_TABS;
