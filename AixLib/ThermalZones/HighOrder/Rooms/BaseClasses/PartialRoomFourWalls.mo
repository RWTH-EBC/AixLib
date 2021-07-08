within AixLib.ThermalZones.HighOrder.Rooms.BaseClasses;
partial model PartialRoomFourWalls
  "Partial room model for a room with 4 walls, 1 ceiling and 1 floor"
  extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoom(
    redeclare replaceable model WindowModel =
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.Window_ASHRAE140,
    redeclare DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140 Type_Win,
      redeclare DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls
      wallTypes(
      roof=DataBase.Walls.ASHRAE140.RO_Case600(),
      OW=DataBase.Walls.ASHRAE140.OW_Case600(),
      IW_vert_half_a=DataBase.Walls.ASHRAE140.DummyDefinition(),
      IW_vert_half_b=DataBase.Walls.ASHRAE140.DummyDefinition(),
      IW_hori_upp_half=DataBase.Walls.ASHRAE140.DummyDefinition(),
      IW_hori_low_half=DataBase.Walls.ASHRAE140.DummyDefinition(),
      IW_hori_att_upp_half=DataBase.Walls.ASHRAE140.DummyDefinition(),
      IW_hori_att_low_half=DataBase.Walls.ASHRAE140.DummyDefinition(),
      groundPlate_upp_half=DataBase.Walls.ASHRAE140.FL_Case600(),
      groundPlate_low_half=DataBase.Walls.ASHRAE140.DummyDefinition(),
      IW2_vert_half_a=DataBase.Walls.ASHRAE140.DummyDefinition(),
      IW2_vert_half_b=DataBase.Walls.ASHRAE140.DummyDefinition(),
      roofRoomUpFloor=DataBase.Walls.ASHRAE140.DummyDefinition()), final room_V=
       room_length*room_width*room_height);

  parameter Modelica.SIunits.Length room_length=6 "length"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Height room_height=2.7 "height"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length room_width=8 "width"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));

  parameter Modelica.SIunits.Area Win_Area=12 "Window area " annotation (Dialog(
      group="Windows",
      descriptionLabel=true,
      enable=withWindow1));

  parameter Components.Types.selectorCoefficients absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs06
    "Coefficients for interior solar absorptance of wall surface abs={0.6, 0.9, 0.1}"
    annotation (Dialog(tab = "Short wave radiation"));

  parameter Boolean use_dynamicShortWaveRadMethod = true "True = dynamic as holistic approach, false = static approach to obtain the same values as provided in tables of the ASHREA"
    annotation(Dialog(tab = "Short wave radiation"));

  replaceable parameter Components.Types.CoeffTableEastWestWindow coeffTableSolDistrFractions
    constrainedby Components.Types.PartialCoeffTable(final abs=absInnerWallSurf)
    "Tables of solar distribution fractions"
    annotation (Dialog(tab = "Short wave radiation", enable=not use_dynamicShortWaveRadMethod), choicesAllMatching=true, Placement(transformation(extent={{78,78},{98,98}})));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_South(
    final energyDynamics=energyDynamicsWalls,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    calcMethodIn=calcMethodIn,
    final WindowType=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final T0=TWalls_start,
    wall_length=room_width,
    solar_absorptance=solar_absorptance_OW,
    calcMethodOut=calcMethodOut,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    wall_height=room_height,
    surfaceType=AixLib.DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster())
    annotation (Placement(transformation(
        extent={{-5,-35},{5,35}},
        rotation=90,
        origin={18,-68})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_West(
    final energyDynamics=energyDynamicsWalls,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    calcMethodIn=calcMethodIn,
    wall_length=room_length,
    wall_height=room_height,
    final WindowType=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final T0=TWalls_start,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    solar_absorptance=solar_absorptance_OW,
    surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
    calcMethodOut=calcMethodOut) annotation (Placement(transformation(
        extent={{-5,-27},{5,27}},
        rotation=0,
        origin={-83,13})));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_East(
    final energyDynamics=energyDynamicsWalls,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    calcMethodIn=calcMethodIn,
    wall_length=room_length,
    wall_height=room_height,
    final WindowType=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final T0=TWalls_start,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    solar_absorptance=solar_absorptance_OW,
    surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
    calcMethodOut=calcMethodOut) annotation (Placement(transformation(
        extent={{-5,-27},{5,27}},
        rotation=180,
        origin={69,13})));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_North(
    final energyDynamics=energyDynamicsWalls,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    calcMethodIn=calcMethodIn,
    wall_height=room_height,
    final WindowType=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    U_door=5.25,
    door_height=1,
    door_width=2,
    final T0=TWalls_start,
    wall_length=room_width,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    solar_absorptance=solar_absorptance_OW,
    surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
    calcMethodOut=calcMethodOut) annotation (Placement(transformation(
        extent={{5.00001,-30},{-5.00001,30}},
        rotation=90,
        origin={18,69})));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall ceiling(
    final energyDynamics=energyDynamicsWalls,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    calcMethodIn=calcMethodIn,
    wall_length=room_length,
    wall_height=room_width,
    ISOrientation=3,
    final WindowType=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final T0=TWalls_start,
    wallPar=wallTypes.roof,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    solar_absorptance=solar_absorptance_OW,
    surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
    calcMethodOut=calcMethodOut) annotation (Placement(transformation(
        extent={{-2,-12},{2,12}},
        rotation=270,
        origin={-42,80})));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall floor(
    final energyDynamics=energyDynamicsWalls,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    calcMethodIn=calcMethodIn,
    wall_length=room_length,
    wall_height=room_width,
    final WindowType=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final T0=TWalls_start,
    wallPar=wallTypes.groundPlate_upp_half,
    solar_absorptance=solar_absorptance_OW,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    calcMethodOut=calcMethodOut) annotation (Placement(transformation(
        extent={{-2.00031,-12},{2.00003,12}},
        rotation=90,
        origin={-42,-68})));

  Utilities.HeatTransfer.SolarRadInRoom solarRadInRoom(
    final use_dynamicMethod=use_dynamicShortWaveRadMethod,
    nWin=2,
    nWalls=4,
    nFloors=1,
    nCei=1,
    final staticCoeffTable=coeffTableSolDistrFractions) annotation (Placement(transformation(extent={{-50,36},{-30,56}})));

  Modelica.Blocks.Math.MultiSum multiSum(nu=2) annotation (Placement(transformation(
        extent={{2,-2},{-2,2}},
        rotation=90,
        origin={48,-96})));
    Utilities.Interfaces.SolarRad_in   SolarRadiationPort[5] "N,E,S,W,Hor"
      annotation (Placement(transformation(extent={{-120,22},{-100,42}}),
        iconTransformation(extent={{-120,22},{-100,42}})));
    Modelica.Blocks.Interfaces.RealInput WindSpeedPort
      annotation (Placement(transformation(extent={{-116,18},{-100,34}}),
          iconTransformation(extent={{-120,-16},{-100,4}})));
  Modelica.Blocks.Interfaces.RealOutput transShoWaveRadWin(final quantity="Power",
      final unit="W")                                                                              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={54,-108})));
protected
  Utilities.Interfaces.ShortRadSurf shortRadSurf[2] annotation (Placement(transformation(extent={{58,-96},{62,-92}}), iconTransformation(extent={{58,-96},{62,-92}})));
equation
  connect(Wall_South.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-7.66667,
          -73.25},{-8,-73.25},{-8,-82},{-94,-82},{-94,26},{-108,26}}, color={0,
          0,127}));
  connect(Wall_East.WindSpeedPort, WindSpeedPort) annotation (Line(points={{
          74.25,-6.8},{74.25,-6},{82,-6},{82,-82},{-94,-82},{-94,26},{-108,26}},
        color={0,0,127}));
  connect(ceiling.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-33.2,
          82.1},{-33.2,88},{-94,88},{-94,26},{-108,26}}, color={0,0,127}));
  connect(Wall_North.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-4,
          74.25},{82,74.25},{82,-82},{-94,-82},{-94,26},{-108,26}}, color={0,0,
          127}));

  connect(Wall_West.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-88.25,
          32.8},{-88.25,34},{-94,34},{-94,26},{-108,26}}, color={0,0,127}));

  connect(SolarRadiationPort[3], Wall_South.SolarRadiationPort) annotation (
      Line(points={{-110,32},{-96,32},{-96,-84},{-14,-84},{-14,-74.5},{-14.0833,
          -74.5}}, color={255,128,0}));
  connect(ceiling.SolarRadiationPort, SolarRadiationPort[5]) annotation (Line(
        points={{-31,82.6},{-31,88},{-94,88},{-94,40},{-110,40}}, color={255,128,
          0}));
  connect(Wall_West.SolarRadiationPort, SolarRadiationPort[4]) annotation (Line(
        points={{-89.5,37.75},{-89.5,38},{-96,38},{-96,36},{-110,36}}, color={
          255,128,0}));
  connect(Wall_North.SolarRadiationPort, SolarRadiationPort[1]) annotation (
      Line(points={{-9.5,75.5},{82,75.5},{82,-84},{-96,-84},{-96,24},{-110,24}},
        color={255,128,0}));

  connect(Wall_East.SolarRadiationPort, SolarRadiationPort[2]) annotation (Line(
        points={{75.5,-11.75},{75.5,-12},{82,-12},{82,-84},{-96,-84},{-96,28},{
          -110,28}}, color={255,128,0}));

  connect(thermStar_Demux.portConvRadComb, floor.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{-42,-56},{-42,-66}},
        color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, Wall_South.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{18,-56},{18,-63}}, color
        ={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, Wall_East.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{44,-56},{44,12},{64,12},
          {64,13}}, color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, Wall_North.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{44,-56},{44,50},{18,50},
          {18,64}}, color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, Wall_West.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{44,-56},{44,50},{-62,50},
          {-62,14},{-78,14},{-78,13}}, color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, ceiling.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{44,-56},{44,50},{-42,50},{-42,78}},
                     color={191,0,0}));
  connect(solarRadInRoom.floors[1], floor.shortRadWall) annotation (Line(points={{-29,48},
          {-24,48},{-24,58},{-54,58},{-54,-56},{-40,-56},{-40,-60},{-49.9,-60},
          {-49.9,-66}},
                   color={0,0,0}));
  connect(solarRadInRoom.ceilings[1], ceiling.shortRadWall) annotation (Line(
        points={{-29,44},{-24,44},{-24,60},{-34.1,60},{-34.1,78}},       color=
          {0,0,0}));
  connect(solarRadInRoom.win_in[1], Wall_West.shortRadWin) annotation (Line(
        points={{-51,45.5},{-52,45.5},{-52,58},{14,58},{14,-0.275},{-78.25,-0.275}},
        color={0,0,0}));
  connect(solarRadInRoom.win_in[2], Wall_East.shortRadWin) annotation (Line(
        points={{-51,46.5},{-52,46.5},{-52,58},{44,58},{44,26.275},{64.25,
          26.275}}, color={0,0,0}));
  connect(Wall_East.shortRadWall, solarRadInRoom.walls[1]) annotation (Line(
        points={{64,-4.775},{12,-4.775},{12,-54},{44,-54},{44,51.25},{-29,51.25}},
        color={0,0,0}));
  connect(Wall_South.shortRadWall, solarRadInRoom.walls[2]) annotation (Line(
        points={{-5.04167,-63},{-58,-63},{-58,30},{-54,30},{-54,58},{-12,58},{-12,
          51.75},{-29,51.75}}, color={0,0,0}));
  connect(Wall_West.shortRadWall, solarRadInRoom.walls[3]) annotation (Line(
        points={{-78,30.775},{42,30.775},{42,52.25},{-29,52.25}}, color={0,0,0}));
  connect(Wall_North.shortRadWall, solarRadInRoom.walls[4]) annotation (Line(
        points={{-1.75,64},{54,64},{54,30},{44,30},{44,52.75},{-29,52.75}},
        color={0,0,0}));
  connect(Wall_West.shortRadWin, shortRadSurf[1]) annotation (Line(points={{-78.25,
          -0.275},{-78.25,0},{-76,0},{-76,-88},{60,-88},{60,-95}}, color={0,0,0}),
      Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Wall_East.shortRadWin, shortRadSurf[2]) annotation (Line(points={{
          64.25,26.275},{60,26.275},{60,-93}}, color={0,0,0}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(shortRadSurf[1].Q_flow_ShoRadFroSur, multiSum.u[1]) annotation (Line(points={{60.01,-93.995},{54,-93.995},{54,-92},{47.3,-92},{47.3,-94}},
                                                                                                                                                 color={0,0,0}));
  connect(shortRadSurf[2].Q_flow_ShoRadFroSur, multiSum.u[2]) annotation (Line(points={{60.01,-93.985},{54,-93.985},{54,-92},{48.7,-92},{48.7,-94}},
                                                                                                                                                 color={0,0,0}));
  connect(multiSum.y, transShoWaveRadWin) annotation (Line(points={{48,-98.34},{
          48,-100},{54,-100},{54,-108}},                                                                                         color={0,0,127}));
  annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false)),
                          Documentation(revisions="<html><ul>
  <li>
    <i>July 1, 2020</i> by Konstantina Xanhtopoulou:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/896\">#896</a>:
    Mainly added solar distribution fractions, extended from
    PartialRoom.
  </li>
</ul>
<ul>
  <li>
    <i>March 9, 2015</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>


",         info="<html>
</html>"));
end PartialRoomFourWalls;
