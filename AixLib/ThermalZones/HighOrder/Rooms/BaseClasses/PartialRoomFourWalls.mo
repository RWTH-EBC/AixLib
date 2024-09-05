within AixLib.ThermalZones.HighOrder.Rooms.BaseClasses;
partial model PartialRoomFourWalls
  "Partial room model for a room with 4 walls, 1 ceiling and 1 floor"
  extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoom(
    redeclare replaceable model WindowModel =
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.Window_ASHRAE140,
    redeclare DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140 Type_Win,
    room_V=room_length*room_width*room_height);

  parameter Modelica.Units.SI.Length room_length=6 "length"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Height room_height=2.7 "height"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Length room_width=8 "width"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));

  parameter Modelica.Units.SI.Area Win_Area=12 "Window area " annotation (
      Dialog(
      group="Windows",
      descriptionLabel=true));

  parameter Boolean use_shortWaveRadIn=true
    "Use bus connector for incoming shortwave radiation"
    annotation (Dialog(tab="Inner walls", group="Shortwave Radiation"));
  parameter Boolean use_shortWaveRadOut=true
    "Use bus connector for outgoing shortwave radiation"
    annotation (Dialog(tab="Inner walls", group="Shortwave Radiation", enable=use_shortWaveRadIn));
  parameter Boolean use_dynamicShortWaveRadMethod=false
    "True = dynamic as holistic approach, false = static approach to obtain the same values as provided in tables of the ASHREA"
    annotation (Dialog(tab="Inner walls", group="Shortwave Radiation", enable=
          use_shortWaveRadIn));

  parameter Components.Types.selectorCoefficients absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs06
    "Coefficients for interior solar absorptance of wall surface abs={0.6, 0.9, 0.1}"
    annotation (Dialog(tab="Inner walls", group="Shortwave Radiation", enable=
          use_shortWaveRadIn and not use_dynamicShortWaveRadMethod));

  replaceable parameter
    ThermalZones.HighOrder.Components.Types.CoeffTableEastWestWindow coeffTableSolDistrFractions
    constrainedby
    AixLib.ThermalZones.HighOrder.Components.Types.PartialCoeffTable(final abs=absInnerWallSurf)
    "Record holding the values to reproduce the tables"
    annotation (choicesAllMatching=true, Dialog(tab="Inner walls", group="Shortwave Radiation", enable=
          use_shortWaveRadIn and not use_dynamicShortWaveRadMethod),
                                                                Placement(transformation(extent={{78,78},{98,98}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall wallSouth(
    use_shortWaveRadIn=use_shortWaveRadIn,
    use_shortWaveRadOut=use_shortWaveRadOut,
    energyDynamics=energyDynamicsWalls,
    radLongCalcMethod=radLongCalcMethod,
    T_ref=T_ref,
    calcMethodIn=calcMethodIn,
    WindowType=Type_Win,
    redeclare model WindowModel = WindowModel,
    redeclare model CorrSolarGainWin = CorrSolarGainWin,
    T0=TWalls_start,
    wall_length=room_width,
    solar_absorptance=solar_absorptance_OW,
    calcMethodOut=calcMethodOut,
    withSunblind=use_sunblind,
    Blinding=1 - ratioSunblind,
    LimitSolIrr=solIrrThreshold,
    TOutAirLimit=TOutAirLimit,
    wall_height=room_height,
    surfaceType=AixLib.DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster())
    annotation (Placement(transformation(
        extent={{-5,-35},{5,35}},
        rotation=90,
        origin={18,-68})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall wallWest(
    use_shortWaveRadIn=use_shortWaveRadIn,
    use_shortWaveRadOut=use_shortWaveRadOut,
    energyDynamics=energyDynamicsWalls,
    radLongCalcMethod=radLongCalcMethod,
    T_ref=T_ref,
    calcMethodIn=calcMethodIn,
    wall_length=room_length,
    wall_height=room_height,
    WindowType=Type_Win,
    redeclare model WindowModel = WindowModel,
    redeclare model CorrSolarGainWin = CorrSolarGainWin,
    T0=TWalls_start,
    withSunblind=use_sunblind,
    Blinding=1 - ratioSunblind,
    LimitSolIrr=solIrrThreshold,
    TOutAirLimit=TOutAirLimit,
    solar_absorptance=solar_absorptance_OW,
    surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
    calcMethodOut=calcMethodOut) annotation (Placement(transformation(
        extent={{-5,-27},{5,27}},
        rotation=0,
        origin={-83,13})));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall wallEast(
    use_shortWaveRadIn=use_shortWaveRadIn,
    use_shortWaveRadOut=use_shortWaveRadOut,
    energyDynamics=energyDynamicsWalls,
    radLongCalcMethod=radLongCalcMethod,
    T_ref=T_ref,
    calcMethodIn=calcMethodIn,
    wall_length=room_length,
    wall_height=room_height,
    WindowType=Type_Win,
    redeclare model WindowModel = WindowModel,
    redeclare model CorrSolarGainWin = CorrSolarGainWin,
    T0=TWalls_start,
    withSunblind=use_sunblind,
    Blinding=1 - ratioSunblind,
    LimitSolIrr=solIrrThreshold,
    TOutAirLimit=TOutAirLimit,
    solar_absorptance=solar_absorptance_OW,
    surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
    calcMethodOut=calcMethodOut) annotation (Placement(transformation(
        extent={{-5,-27},{5,27}},
        rotation=180,
        origin={69,13})));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall wallNorth(
    use_shortWaveRadIn=use_shortWaveRadIn,
    use_shortWaveRadOut=use_shortWaveRadOut,
    energyDynamics=energyDynamicsWalls,
    radLongCalcMethod=radLongCalcMethod,
    T_ref=T_ref,
    calcMethodIn=calcMethodIn,
    wall_height=room_height,
    WindowType=Type_Win,
    redeclare model WindowModel = WindowModel,
    redeclare model CorrSolarGainWin = CorrSolarGainWin,
    T0=TWalls_start,
    wall_length=room_width,
    withSunblind=use_sunblind,
    Blinding=1 - ratioSunblind,
    LimitSolIrr=solIrrThreshold,
    TOutAirLimit=TOutAirLimit,
    solar_absorptance=solar_absorptance_OW,
    surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
    calcMethodOut=calcMethodOut) annotation (Placement(transformation(
        extent={{5.00001,-30},{-5.00001,30}},
        rotation=90,
        origin={18,69})));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall ceiling(
    use_shortWaveRadIn=use_shortWaveRadIn,
    use_shortWaveRadOut=use_shortWaveRadOut,
    energyDynamics=energyDynamicsWalls,
    radLongCalcMethod=radLongCalcMethod,
    T_ref=T_ref,
    calcMethodIn=calcMethodIn,
    wall_length=room_length,
    wall_height=room_width,
    WindowType=Type_Win,
    redeclare model WindowModel = WindowModel,
    redeclare model CorrSolarGainWin = CorrSolarGainWin,
    T0=TWalls_start,
    withSunblind=use_sunblind,
    Blinding=1 - ratioSunblind,
    LimitSolIrr=solIrrThreshold,
    TOutAirLimit=TOutAirLimit,
    solar_absorptance=solar_absorptance_OW,
    surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
    calcMethodOut=calcMethodOut) annotation (Placement(transformation(
        extent={{-2,-12},{2,12}},
        rotation=270,
        origin={-42,80})));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall floor(
    use_shortWaveRadIn=use_shortWaveRadIn,
    use_shortWaveRadOut=use_shortWaveRadOut,
    outside=false,
    energyDynamics=energyDynamicsWalls,
    radLongCalcMethod=radLongCalcMethod,
    T_ref=T_ref,
    calcMethodIn=calcMethodIn,
    wall_length=room_length,
    wall_height=room_width,
    WindowType=Type_Win,
    redeclare model WindowModel = WindowModel,
    redeclare model CorrSolarGainWin = CorrSolarGainWin,
    T0=TWalls_start,
    solar_absorptance=solar_absorptance_OW,
    withSunblind=use_sunblind,
    Blinding=1 - ratioSunblind,
    LimitSolIrr=solIrrThreshold,
    TOutAirLimit=TOutAirLimit,
    calcMethodOut=calcMethodOut) annotation (Placement(transformation(
        extent={{-2.00031,-12},{2.00003,12}},
        rotation=90,
        origin={-42,-68})));

    Utilities.Interfaces.SolarRad_in   SolarRadiationPort[5] "N,E,S,W,Hor"
      annotation (Placement(transformation(extent={{-120,46},{-100,66}}),
        iconTransformation(extent={{-120,46},{-100,66}})));
    Modelica.Blocks.Interfaces.RealInput WindSpeedPort
      annotation (Placement(transformation(extent={{-116,28},{-100,44}}),
          iconTransformation(extent={{-120,-16},{-100,4}})));
  Utilities.HeatTransfer.SolarRadInRoom solarRadInRoom(
    final use_dynamicMethod=use_dynamicShortWaveRadMethod,
    final nWalls=4,
    final nWin=nWin,
    final nFloors=1,
    final nCei=1,
    final floor_length=room_length,
    final floor_width=room_height,
    final staticCoeffTable=coeffTableSolDistrFractions) if use_shortWaveRadIn and nWin > 0
    annotation (Placement(transformation(extent={{-50,26},{-30,46}})));
  Modelica.Blocks.Interfaces.RealOutput transShoWaveRadWin(final quantity="Power", final unit="W") if use_shortWaveRadOut annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-110})));

  Modelica.Blocks.Math.MultiSum multiSum(nu=nWin) if use_shortWaveRadOut annotation (Placement(transformation(
        extent={{2,-2},{-2,2}},
        rotation=90,
        origin={60,-96})));
protected
  Utilities.Interfaces.ShortRadSurf shortRadSurf[nWin] if use_shortWaveRadOut
                                                       annotation (Placement(transformation(extent={{58,-92},
            {62,-88}}),                                                                                                  iconTransformation(extent={{58,-92},
            {62,-88}})));
protected
  parameter Boolean usesWindow[4] = {wallEast.withWindow, wallSouth.withWindow, wallWest.withWindow, wallNorth.withWindow};
  parameter Integer usesWindowInt[4] = {if usesWindow[i] then 1 else 0 for i in 1:size(usesWindow, 1)};
  parameter Integer nWin=sum(usesWindowInt)
    "Number of windows in room transmitting shortwave radiation";
initial equation
  assert(use_UFH <> use_shortWaveRadIn, "Underfloor heating does not allow shortwave radiation, as floor model is disabled", AssertionLevel.error);
equation
  connect(wallSouth.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-7.66667,
          -73.25},{-8,-73.25},{-8,-82},{-94,-82},{-94,36},{-108,36}}, color={0,
          0,127}));
  connect(wallEast.WindSpeedPort, WindSpeedPort) annotation (Line(points={{
          74.25,-6.8},{74.25,-6},{82,-6},{82,-82},{-94,-82},{-94,36},{-108,36}},
        color={0,0,127}));
  connect(ceiling.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-33.2,
          82.1},{-33.2,88},{-94,88},{-94,36},{-108,36}}, color={0,0,127}));
  connect(wallNorth.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-4,
          74.25},{82,74.25},{82,-82},{-94,-82},{-94,36},{-108,36}}, color={0,0,
          127}));

  connect(wallWest.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-88.25,
          32.8},{-88.25,34},{-94,34},{-94,36},{-108,36}}, color={0,0,127}));

  connect(SolarRadiationPort[3],wallSouth. SolarRadiationPort) annotation (Line(
        points={{-110,56},{-96,56},{-96,-84},{-14,-84},{-14,-74.5},{-14.0833,
          -74.5}}, color={255,128,0}));
  connect(ceiling.SolarRadiationPort, SolarRadiationPort[5]) annotation (Line(
        points={{-31,82.6},{-31,88},{-94,88},{-94,60},{-110,60}}, color={255,128,
          0}));
  connect(wallWest.SolarRadiationPort, SolarRadiationPort[4]) annotation (Line(
        points={{-89.5,37.75},{-89.5,38},{-96,38},{-96,58},{-110,58}}, color={
          255,128,0}));
  connect(wallNorth.SolarRadiationPort, SolarRadiationPort[1]) annotation (Line(
        points={{-9.5,75.5},{82,75.5},{82,-84},{-96,-84},{-96,52},{-110,52}},
        color={255,128,0}));

  connect(wallEast.SolarRadiationPort, SolarRadiationPort[2]) annotation (Line(
        points={{75.5,-11.75},{75.5,-12},{82,-12},{82,-84},{-96,-84},{-96,54},{-110,
          54}},      color={255,128,0}));

  connect(thermStar_Demux.portConvRadComb, floor.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{-42,-56},{-42,-66}},
        color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb,wallSouth. thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{18,-56},{18,-63}}, color=
         {191,0,0}));
  connect(thermStar_Demux.portConvRadComb,wallEast. thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{44,-56},{44,12},{64,12},
          {64,13}}, color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb,wallNorth. thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{44,-56},{44,50},{18,50},
          {18,64}}, color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb,wallWest. thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{44,-56},{44,50},{-62,50},
          {-62,14},{-78,14},{-78,13}}, color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, ceiling.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{44,-56},{44,50},{-42,50},{-42,78}},
                     color={191,0,0}));
  // Shortwave radiation
  if (wallEast.withWindow and use_shortWaveRadOut) then
    connect(solarRadInRoom.win_in[sum(usesWindowInt[1:1])], wallEast.shortRadWin) annotation (Line(points={{-51,36},
            {-54,36},{-54,46},{44,46},{44,26.275},{64.25,26.275}},   color={0,0,0}, pattern=LinePattern.Dash));
  end if;
  if (wallSouth.withWindow and use_shortWaveRadOut) then
    connect(solarRadInRoom.win_in[sum(usesWindowInt[1:2])], wallSouth.shortRadWin) annotation (Line(points={{-51,36},
            {-54,36},{-54,-56},{44,-56},{44,46},{-54,46},{-54,-63.25},{35.2083,
            -63.25}},                                         color={0,0,0}, pattern=LinePattern.Dash));
  end if;
  if (wallWest.withWindow and use_shortWaveRadOut) then
    connect(solarRadInRoom.win_in[sum(usesWindowInt[1:3])], wallWest.shortRadWin) annotation (Line(points={{-51,36},
          {-54,36},{-54,-0.275},{-78.25,-0.275}},                      color={0,0,0}, pattern=LinePattern.Dash));
  end if;
  if (wallNorth.withWindow and use_shortWaveRadOut) then
    connect(solarRadInRoom.win_in[sum(usesWindowInt[1:4])], wallNorth.shortRadWin) annotation (Line(points={{-51,36},
          {-54,36},{-54,64.25},{32.75,64.25}},           color={0,0,0}, pattern=LinePattern.Dash));
  end if;
  connect(solarRadInRoom.walls[1], wallEast.shortRadWall) annotation (Line(points={{-29,
          41.625},{44,41.625},{44,-4.775},{64,-4.775}},
                                                      color={0,0,0}, pattern=LinePattern.Dash));
  connect(solarRadInRoom.walls[2], wallSouth.shortRadWall) annotation (Line(points={{-29,
          41.875},{-20,41.875},{-20,38},{46,38},{46,-56},{-5.04167,-56},{-5.04167,
          -63}},                                                     color={0,0,0}, pattern=LinePattern.Dash));
  connect(solarRadInRoom.walls[3], wallWest.shortRadWall) annotation (Line(points={{-29,
          42.125},{-20,42.125},{-20,46},{-54,46},{-54,30.775},{-78,30.775}},
                                                          color={0,0,0}, pattern=LinePattern.Dash));
  connect(solarRadInRoom.walls[4], wallNorth.shortRadWall) annotation (Line(points={{-29,
          42.375},{-1.75,42.375},{-1.75,64}},
                                            color={0,0,0}, pattern=LinePattern.Dash));
  connect(solarRadInRoom.floors[1], floor.shortRadWall) annotation (Line(points={{-29,38},
          {46,38},{46,-56},{-49.9,-56},{-49.9,-66}},                     color={0,0,0}, pattern=LinePattern.Dash));
  connect(solarRadInRoom.ceilings[1], ceiling.shortRadWall) annotation (Line(points={{-29,34},
          {-20,34},{-20,48},{-34.1,48},{-34.1,78}}, color={0,0,0}, pattern=LinePattern.Dash));
  for i in 1:nWin loop
    connect(shortRadSurf[i].Q_flow_ShoRadFroSur, multiSum.u[i]) annotation (Line(points={{60.01,
            -89.99},{60.01,-90},{60,-90},{60,-94}},                                                                                              color={0,0,0}));
  end for;
  connect(multiSum.y, transShoWaveRadWin) annotation (Line(points={{60,-98.34},
          {60,-110}},                                                                                                              color={0,0,127}));
  connect(solarRadInRoom.win_in, shortRadSurf) annotation (Line(
      points={{-51,36},{-54,36},{-54,-56},{60,-56},{60,-90}},
      color={0,0,0},
      pattern=LinePattern.Dash), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false)),
                          Documentation(revisions="<html><ul>
  <li>February, 2022 by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1123\">#1123</a>)
</ul>
</html>",  info="<html>
<p>This model provides common interfaces for the most frequently used room in a building, one with four walls, a floor and a ceiling.</p>
<p>To build up your own room, just extend this model and specify if the walls are inner or outer walls, have windows etc. Connect the heat ports to e.g. thermOuter for outside walls and add new heat ports to exchange heat with other sources, such as anothers room inner wall.</p>
<p>See the various examples in RoomEmpiricalValidation or ASHRAE140 to see how to use this model.</p>
<p>Note that all default values are by design not final. This means you have full control over the parametrization of your high-order room model.</p>
</html>"));
end PartialRoomFourWalls;
