within AixLib.ThermalZones.ReducedOrder.Validation.VDI6007.VDI6007_C1;
model TRY_TABS "VDI 6007 Test Case 3 model"
  extends Modelica.Icons.Example;

  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord RoomRecord=
      BaseClasses.RoomTypes.RoomType_M()
  annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);
 parameter Modelica.SIunits.Temperature T_start=295.15;
 parameter Modelica.SIunits.Area ATabs=16;
 parameter Modelica.SIunits.Power PowerTabs=-1168;

  RC.TwoElements thermalZoneTwoElements(
    redeclare package Medium = Modelica.Media.Air.SimpleAir,
    T_start=T_start,
    VAir=RoomRecord.VAir,
    hRad=RoomRecord.hRad,
    nOrientations=RoomRecord.nOrientations,
    AWin=RoomRecord.AWin,
    ATransparent=RoomRecord.ATransparent,
    hConWin=RoomRecord.hConWin,
    RWin=RoomRecord.RWin,
    gWin=RoomRecord.gWin,
    ratioWinConRad=RoomRecord.ratioWinConRad,
    AExt=RoomRecord.AExt,
    hConExt=RoomRecord.hConExt,
    nExt=RoomRecord.nExt,
    RExt=RoomRecord.RExt,
    RExtRem=RoomRecord.RExtRem,
    CExt=RoomRecord.CExt,
    AInt=RoomRecord.AInt,
    hConInt=RoomRecord.hConInt,
    nInt=RoomRecord.nInt,
    RInt=RoomRecord.RInt,
    CInt=RoomRecord.CInt,
    extWallRC(thermCapExt(each der_T(fixed=true))),
    intWallRC(thermCapInt(each der_T(fixed=true))))
    "Thermal zone"
    annotation (Placement(transformation(extent={{44,-2},{92,34}})));
  Modelica.Blocks.Sources.CombiTimeTable intGai(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,0,0,0,0,0,0; 3600,0,0,0,0,0,0; 7200,0,0,0,0,0,0; 10800,0,0,0,0,0,0;
        14400,0,0,0,0,0,0; 18000,0,0,0,0,0,0; 21600,0,0,0,0,0,0; 25200,0,0,0,0,0,
        0; 25200,80,80,75,75,120,120; 28800,160,160,150,150,120,120; 32400,160,160,
        150,150,120,120; 36000,160,160,150,150,120,120; 39600,160,160,150,150,120,
        120; 43200,80,80,75,75,120,120; 46800,160,160,150,150,120,120; 50400,160,
        160,150,150,120,120; 54000,160,160,150,150,120,120; 57600,80,80,75,75,120,
        120; 61200,0,0,0,0,60,60; 61200,0,0,0,0,0,0; 64800,0,0,0,0,0,0; 72000,0,
        0,0,0,0,0; 75600,0,0,0,0,0,0; 79200,0,0,0,0,0,0; 82800,0,0,0,0,0,0; 86400,
        0,0,0,0,0,0],
    columns={2,3,4,5,6,7})
    "Table with internal gains"
    annotation (Placement(transformation(extent={{8,-50},{24,-34}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SonConv
    "Convective heat flow machines"
    annotation (Placement(transformation(extent={{54,-82},{74,-62}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perRad
    "Radiative heat flow persons"
    annotation (Placement(transformation(extent={{54,-100},{74,-80}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perCon
    "Convective heat flow persons"
    annotation (Placement(transformation(extent={{52,-44},{72,-24}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow IluConv
    "Convective heat flow machines"
    annotation (Placement(transformation(extent={{54,-64},{74,-44}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow IluRad
    "Radiative heat flow persons"
    annotation (Placement(transformation(extent={{54,-136},{74,-116}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SonRad
    "Radiative heat flow persons"
    annotation (Placement(transformation(extent={{54,-118},{74,-98}})));
  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=
        "D:/dja-dco/Git Projekts/AixLib/AixLib/ThermalZones/ReducedOrder/Validation/VDI6007/VDI6007_C1/BaseClasses/DEU_BW_Mannheim_107290_TRY2010_12_Jahr_BBSR.mos")
    "Weather data reader"
    annotation (Placement(transformation(extent={{-168,20},{-148,40}})));

  SolarGain.CorrectionGDoublePane
       corGMod(final n=RoomRecord.nOrientations, final UWin=RoomRecord.UWin) if
    sum(RoomRecord.ATransparent) > 0 "Correction factor for solar transmission"
    annotation (Placement(transformation(extent={{-56,7},{-44,19}})));
  EquivalentAirTemperature.VDI6007WithWindow eqAirTempWall(
    withLongwave=true,
    final n=RoomRecord.nOrientations,
    final wfWall=RoomRecord.wfWall,
    final wfWin=RoomRecord.wfWin,
    final wfGro=RoomRecord.wfGro,
    final hConWallOut=RoomRecord.hConWallOut,
    final hRad=RoomRecord.hRadWall,
    final hConWinOut=RoomRecord.hConWinOut,
    final aExt=RoomRecord.aExt,
    final TGro=RoomRecord.TSoil) if (sum(RoomRecord.AExt) + sum(RoomRecord.AWin)) > 0
    "Computes equivalent air temperature"
    annotation (Placement(transformation(extent={{-78,-26},{-66,-14}})));
  BoundaryConditions.SolarIrradiation.DiffusePerez HDifTilWall[RoomRecord.nOrientations](
    each final outSkyCon=true,
    each final outGroCon=true,
    each final lat=RoomRecord.lat,
    final azi=RoomRecord.aziExtWalls,
    final til=RoomRecord.tiltExtWalls)
    "Calculates diffuse solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-124,-26},{-108,-10}})));
  BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTilWall[RoomRecord.nOrientations](
    each final lat=RoomRecord.lat,
    final azi=RoomRecord.aziExtWalls,
    final til=RoomRecord.tiltExtWalls)
    "Calculates direct solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-124,-5},{-108,12}})));
  SolarGain.SimpleExternalShading simpleExternalShading(
    final nOrientations=RoomRecord.nOrientations,
    final maxIrrs=RoomRecord.maxIrr,
    final gValues=RoomRecord.shadingFactor) if
    sum(RoomRecord.ATransparent) > 0
    annotation (Placement(transformation(extent={{-36,8},{-30,14}})));
  BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(
    transformation(extent={{-159,-22},{-125,10}}),
                                                 iconTransformation(
    extent={{-110,50},{-90,70}})));
  Modelica.Blocks.Math.MultiSum
                            multiSum(k={0.5,0.5,-1}, nu=3)
    "Reverses ventilation rate"
    annotation (Placement(transformation(extent={{214,45},{228,59}})));
  Modelica.Blocks.Sources.Constant ToKelvin(k=273.15)
    "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(
    transformation(
    extent={{-4,-4},{4,4}},
    rotation=0,
    origin={178,44})));
  Modelica.Blocks.Math.Mean OutOpTemp(f=1/3600)
    "Hourly mean of indoor air temperature"
    annotation (Placement(transformation(extent={{246,46},{258,58}})));
  Modelica.Blocks.Math.Mean OutAirTemp(f=1/3600)
    "Hourly mean of indoor air temperature"
    annotation (Placement(transformation(extent={{274,-78},{286,-66}})));
  Modelica.Blocks.Math.Sum  sum2(nin=2)
    "Conversion to kg/s"
    annotation (Placement(transformation(extent={{246,-80},{260,-65}})));
  Modelica.Blocks.Sources.Constant ToCelsius(k=-273.15)
    "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(
    transformation(
    extent={{-4,-4},{4,4}},
    rotation=0,
    origin={230,-88})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={172,-112})));
  Modelica.Blocks.Math.Mean OutCoolingLoad(f=1/3600)
    "Hourly mean of indoor air temperature"
    annotation (Placement(transformation(extent={{196,-118},{208,-106}})));
  Modelica.Blocks.Sources.CombiTimeTable SollTemp(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,299.15; 3600,299.15; 7200,299.15; 10800,299.15; 14400,299.15;
        18000,299.15; 21600,299.15; 21600,294.15; 25200,294.15; 28800,294.15;
        32400,294.15; 36000,294.15; 39600,294.15; 43200,294.15; 46800,294.15;
        50400,294.15; 54000,294.15; 57600,294.15; 61200,294.15; 61200,299.15;
        64800,299.15; 72000,299.15; 75600,299.15; 79200,299.15; 82800,299.15;
        86400,299.15],
    columns={2}) "Table with internal gains"
    annotation (Placement(transformation(extent={{-136,-128},{-120,-112}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{142,-24},{162,-4}})));

  Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Controlled_TABS
    controlled_TABS(
    RoomNo=1,
    area={ATabs},
    HeatLoad={PowerTabs},
    Spacing={0.35},
    wallTypeFloor={
        Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Flooring.FLpartition_EnEV2009_SM_upHalf_UFH_Laminate()},

    wallTypeCeiling={
        Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH()},

    PipeRecord={
        Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Piping.PBpipe()},

    Controlled=true,
    Reduced=true)
    annotation (Placement(transformation(extent={{-82,-174},{-22,-114}})));
  Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Reduced.RCTABS rCTABS(
    UpperTABS=
        Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.FloorLayers.FLground_EnEV2009_SML_upHalf_UFH(),

    LowerTABS=
        Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH(),

    A=ATabs,
    OrientationTabs=-0.017453292519943,
    T_start=T_start)
                    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,-150})));
protected
  Modelica.Blocks.Sources.Constant hConWall1(final k=(RoomRecord.hConWallOut +
        RoomRecord.hRadWall)*sum(RoomRecord.AExt))
    "Outdoor coefficient of heat transfer for walls" annotation (Placement(transformation(extent={{4,-4},{
            -4,4}},                                                                                               rotation=180,
        origin={-42,-20})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWall1 if
    sum(RoomRecord.AExt) > 0
    "Outdoor convective heat transfer of walls"
    annotation (Placement(transformation(extent={{-14,-10},{-24,-20}})));
  Modelica.Blocks.Sources.Constant hConWin(final k=(RoomRecord.hConWinOut +
        RoomRecord.hRadWall)*sum(RoomRecord.AWin))
    "Outdoor coefficient of heat transfer for windows" annotation (Placement(transformation(extent={{4,-4},{-4,4}}, rotation=90,
        origin={-18,12})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWin if
    sum(RoomRecord.AWin) > 0
    "Outdoor convective heat transfer of windows"
    annotation (Placement(transformation(extent={{-14,-6},{-24,4}})));
  Modelica.Blocks.Math.Add solRadWall[RoomRecord.nOrientations]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{-94,-14},{-84,-4}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemWall if
    sum(RoomRecord.AExt) > 0
    "Prescribed temperature for exterior walls outdoor surface temperature"
    annotation (Placement(transformation(extent={{-58,-20},{-50,-12}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemWin if
    sum(RoomRecord.AWin) > 0
    "Prescribed temperature for windows outdoor surface temperature"
    annotation (Placement(transformation(extent={{-36,-5},{-28,2}})));
protected
  Modelica.Thermal.HeatTransfer.Components.Convection convTABS(dT(start=0))    "Convective heat transfer of exterior walls"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=0,
        origin={110,-150})));
equation
  connect(intGai.y[1],perRad. Q_flow)
    annotation (Line(points={{24.8,-42},{40,-42},{40,-90},{54,-90}},
                                               color={0,0,127}));
  connect(intGai.y[2],perCon. Q_flow)
    annotation (Line(points={{24.8,-42},{40,-42},{40,-34},{52,-34}},
                                           color={0,0,127}));
  connect(intGai.y[3],SonConv. Q_flow)
    annotation (Line(points={{24.8,-42},{40,-42},{40,-72},{54,-72}},
                                           color={0,0,127}));
  connect(perCon.port, thermalZoneTwoElements.intGainsConv)
    annotation (
    Line(points={{72,-34},{100,-34},{100,20},{92,20}},        color={191,
    0,0}));
  connect(SonConv.port, thermalZoneTwoElements.intGainsConv)
    annotation (
    Line(points={{74,-72},{100,-72},{100,20},{92,20}},
                                                     color={191,0,0}));
  connect(IluConv.port, thermalZoneTwoElements.intGainsConv) annotation (Line(
        points={{74,-54},{100,-54},{100,20},{92,20}},
                                                    color={191,0,0}));
  connect(intGai.y[4], SonRad.Q_flow) annotation (Line(points={{24.8,-42},{40,-42},
          {40,-108},{54,-108}}, color={0,0,127}));
  connect(intGai.y[5], IluConv.Q_flow) annotation (Line(points={{24.8,-42},{40,-42},
          {40,-54},{54,-54}}, color={0,0,127}));
  connect(intGai.y[6], IluRad.Q_flow) annotation (Line(points={{24.8,-42},{40,
          -42},{40,-126},{54,-126}},
                                color={0,0,127}));
  connect(eqAirTempWall.TEqAirWin,preTemWin. T) annotation (Line(points={{-65.4,
          -17.72},{-64,-17.72},{-64,-6},{-38,-6},{-38,-1.5},{-36.8,-1.5}},
                                                                   color={0,0,127}));
  connect(eqAirTempWall.TEqAir,preTemWall. T) annotation (Line(points={{-65.4,-20},
          {-60,-20},{-60,-16},{-58.8,-16}},
                                         color={0,0,127}));
  connect(HDirTilWall.H,corGMod. HDirTil) annotation (Line(points={{-107.2,3.5},
          {-98,3.5},{-98,16},{-78,16},{-78,16.6},{-57.2,16.6}},  color={0,0,127}));
  connect(HDirTilWall.H,solRadWall. u1) annotation (Line(points={{-107.2,3.5},{-98,
          3.5},{-98,-6},{-95,-6}},  color={0,0,127}));
  connect(HDirTilWall.inc,corGMod. inc) annotation (Line(points={{-107.2,0.1},{-104,
          0.1},{-104,0},{-100,0},{-100,9.4},{-57.2,9.4}},   color={0,0,127}));
  connect(HDifTilWall.H,solRadWall. u2) annotation (Line(points={{-107.2,-18},{-100,
          -18},{-100,-12},{-95,-12}},
                                  color={0,0,127}));
  connect(HDifTilWall.HGroDifTil,corGMod. HGroDifTil) annotation (Line(points={{-107.2,
          -22.8},{-102,-22.8},{-102,12},{-80,12},{-80,11.8},{-57.2,11.8}},
        color={0,0,127}));
  connect(solRadWall.y,eqAirTempWall. HSol) annotation (Line(points={{-83.5,-9},
          {-82,-9},{-82,-16.4},{-79.2,-16.4}},
                                             color={0,0,127}));
  connect(weaBus.TBlaSky,eqAirTempWall. TBlaSky) annotation (Line(
      points={{-142,-6},{-126,-6},{-126,-26},{-100,-26},{-100,-20},{-79.2,-20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul,eqAirTempWall. TDryBul) annotation (Line(
      points={{-142,-6},{-126,-6},{-126,-26},{-100,-26},{-100,-23.6},{-79.2,-23.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(HDifTilWall.HSkyDifTil,corGMod. HSkyDifTil) annotation (Line(points={{-107.2,
          -13.2},{-104,-13.2},{-104,14},{-80,14},{-80,14.2},{-57.2,14.2}},
        color={0,0,127}));
 for i in 1:RoomRecord.nOrientations loop
    connect(weaBus, HDifTilWall[i].weaBus) annotation (Line(
        points={{-142,-6},{-86,-6},{-86,-18},{-124,-18}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(HDirTilWall[i].weaBus, weaBus) annotation (Line(
        points={{-124,3.5},{-86,3.5},{-86,-6},{-142,-6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
  end for;
  connect(preTemWall.port, theConWall1.fluid) annotation (Line(points={{-50,-16},
          {-22,-16},{-22,-15},{-24,-15}}, color={191,0,0}));
  connect(preTemWin.port,theConWin. fluid)
    annotation (Line(points={{-28,-1.5},{-24,-1.5},{-24,-1}},
                                                           color={191,0,0}));
  connect(hConWall1.y, theConWall1.Gc) annotation (Line(points={{-37.6,-20},{-19,
          -20}},           color={0,0,127}));
  connect(hConWin.y,theConWin. Gc)
    annotation (Line(points={{-18,7.6},{-18,4},{-19,4}}, color={0,0,127}));
  connect(corGMod.solarRadWinTrans,simpleExternalShading. solRadWin)
    annotation (Line(points={{-43.4,13},{-37.7,13},{-37.7,12.92},{-36.12,12.92}},
        color={0,0,127}));
  connect(solRadWall.y,simpleExternalShading. solRadTot) annotation (Line(
        points={{-83.5,-9},{-78,-9},{-78,6},{-40,6},{-40,12},{-36.06,12},{-36.06,
          11.06}},
        color={0,0,127}));
  connect(simpleExternalShading.shadingFactor,eqAirTempWall. sunblind)
    annotation (Line(points={{-29.94,8.6},{-30,8.6},{-30,4},{-72,4},{-72,-12.8}},
        color={0,0,127}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-148,30},{-148,-6},{-142,-6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(theConWall1.solid, thermalZoneTwoElements.extWall) annotation (Line(
        points={{-14,-15},{16,-15},{16,12},{44,12}}, color={191,0,0}));
  connect(theConWin.solid, thermalZoneTwoElements.window) annotation (Line(
        points={{-14,-1},{12,-1},{12,20},{44,20}}, color={191,0,0}));
  connect(simpleExternalShading.corrIrr, thermalZoneTwoElements.solRad)
    annotation (Line(points={{-30.06,11.24},{-29.03,11.24},{-29.03,31},{43,31}},
        color={0,0,127}));
  connect(thermalZoneTwoElements.TRad,multiSum. u[1]) annotation (Line(points={{93,28},
          {148,28},{148,55.2667},{214,55.2667}},        color={0,0,127}));
  connect(thermalZoneTwoElements.TAir,multiSum. u[2]) annotation (Line(points={{93,32},
          {126,32},{126,52},{214,52}},        color={0,0,127}));
  connect(ToKelvin.y,multiSum. u[3]) annotation (Line(points={{182.4,44},{190,
          44},{190,48},{214,48},{214,48.7333}},
                                            color={0,0,127}));
  connect(OutOpTemp.u,multiSum. y) annotation (Line(points={{244.8,52},{229.19,
          52}},                    color={0,0,127}));
  connect(sum2.y,OutAirTemp. u) annotation (Line(points={{260.7,-72.5},{270,
          -72.5},{270,-72},{272.8,-72}},
                         color={0,0,127}));
  connect(sum2.u[1],ToCelsius. y) annotation (Line(points={{244.6,-73.25},{
          238.4,-73.25},{238.4,-88},{234.4,-88}},
                                  color={0,0,127}));
  connect(thermalZoneTwoElements.TAir,sum2. u[2]) annotation (Line(points={{93,32},
          {220,32},{220,-72},{240,-72},{240,-71.75},{244.6,-71.75}},
                                             color={0,0,127}));
  connect(heatFlowSensor.Q_flow, OutCoolingLoad.u) annotation (Line(points={{182,
          -112},{194.8,-112}},                         color={0,0,127}));
  connect(perRad.port, port_a)
    annotation (Line(points={{74,-90},{152,-90},{152,-14}}, color={191,0,0}));
  connect(SonRad.port, port_a) annotation (Line(points={{74,-108},{114,-108},{
          114,-106},{152,-106},{152,-14}}, color={191,0,0}));
  connect(IluRad.port, port_a) annotation (Line(points={{74,-126},{152,-126},{
          152,-14}}, color={191,0,0}));
  connect(thermalZoneTwoElements.intGainsRad, port_a) annotation (Line(points={
          {92,24},{128,24},{128,16},{152,16},{152,-14}}, color={191,0,0}));
  connect(SollTemp.y[1], controlled_TABS.T_Soll[1])
    annotation (Line(points={{-119.2,-120},{-83.2,-120}}, color={0,0,127}));
  connect(controlled_TABS.T_Room[1], thermalZoneTwoElements.TAir) annotation (
      Line(points={{-83.2,-129},{-106,-129},{-106,-184},{190,-184},{190,32},{93,
          32}}, color={0,0,127}));
  connect(heatFlowSensor.port_b, thermalZoneTwoElements.intGainsConv)
    annotation (Line(points={{172,-102},{172,20},{92,20}}, color={191,0,0}));
  connect(rCTABS.port_int,convTABS. solid)
    annotation (Line(points={{60,-150},{100,-150}},color={191,0,0}));
  connect(convTABS.fluid, heatFlowSensor.port_a) annotation (Line(points={{120,
          -150},{172,-150},{172,-122}}, color={191,0,0}));
  connect(rCTABS.alpha_TABS, convTABS.Gc) annotation (Line(points={{39,-142},{
          30,-142},{30,-134},{92,-134},{92,-160},{110,-160}}, color={0,0,127}));
  connect(rCTABS.TAir, thermalZoneTwoElements.TAir) annotation (Line(points={{
          39,-146},{30,-146},{30,-184},{190,-184},{190,32},{93,32}}, color={0,0,
          127}));
  connect(controlled_TABS.heatFloor[1], rCTABS.port_heat) annotation (Line(
        points={{-52,-114},{8,-114},{8,-160},{50,-160}}, color={191,0,0}));
  annotation ( Documentation(info="<html>
  <p>Test Case 3 of the VDI 6007 Part 1: Calculation of indoor air
  temperature excited by a convective heat source for room version L.</p>
  <h4>Boundary conditions</h4>
  <ul>
  <li>constant outdoor air temperature 22&deg;C</li>
  <li>no solar or short-wave radiation on the exterior wall</li>
  <li>no solar or short-wave radiation through the windows</li>
  <li>no long-wave radiation exchange between exterior wall, windows
  and ambient environment</li>
  </ul>
  <p>This test validates basic functionalities.</p>
  </html>", revisions="<html>
  <ul>
  <li>
  July 11, 2019, by Katharina Brinkmann:<br/>
  Renamed <code>alphaWall</code> to <code>hConWall</code>
  </li>
  <li>
  July 7, 2016, by Moritz Lauster:<br/>
  Added automatic check against validation thresholds.
  </li>
  <li>
  January 11, 2016, by Moritz Lauster:<br/>
  Implemented.
  </li>
  </ul>
  </html>"),experiment(
      StartTime=21081600,
      StopTime=21168000,
      Interval=3600,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
  __Dymola_Commands(file=
  "modelica://AixLib/Resources/Scripts/Dymola/ThermalZones/ReducedOrder/Validation/VDI6007/TestCase3.mos"
        "Simulate and plot"),
    Diagram(coordinateSystem(extent={{-180,-200},{300,80}}),  graphics={
        Polygon(
          points={{-10,-26},{-128,-26},{-128,22},{-64,22},{-64,-10},{-10,-10},{-10,
              -26}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-112,26},{-84,14}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Exterior Walls"),
        Polygon(
          points={{-62,22},{-10,22},{-10,-8},{-62,-8},{-62,0},{-62,-8},{-62,22}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-37,23},{-20,16}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Windows")}),
    Icon(coordinateSystem(extent={{-180,-200},{300,80}})));
end TRY_TABS;
