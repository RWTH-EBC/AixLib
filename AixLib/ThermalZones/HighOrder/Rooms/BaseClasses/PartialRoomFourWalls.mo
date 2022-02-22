within AixLib.ThermalZones.HighOrder.Rooms.BaseClasses;
partial model PartialRoomFourWalls
  "Partial room model for a room with 4 walls, 1 ceiling and 1 floor"
  extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoom(
    redeclare replaceable model WindowModel =
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.Window_ASHRAE140,
    redeclare DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140 Type_Win,
    room_V=room_length*room_width*room_height);

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

  parameter Boolean use_shortWaveRadIn=true
    "Use bus connector for incoming shortwave radiation"
    annotation (Dialog(tab="Inner walls", group="Shortwave Radiation"));
  parameter Boolean use_shortWaveRadOut=true
    "Use bus connector for outgoing shortwave radiation"
    annotation (Dialog(tab="Inner walls", group="Shortwave Radiation", enable=use_shortWaveRadIn));
  parameter Boolean use_dynamicShoWaveMethod=false
    "True = dynamic as holistic approach, false = static approach to obtain the same values as provided in tables of the ASHREA"
    annotation (Dialog(tab="Inner walls", group="Shortwave Radiation", enable=
          use_shortWaveRadIn));
  parameter Integer nWin=2
    "Number of windows in room transmitting shortwave radiation"
    annotation (Dialog(tab="Inner walls", group="Shortwave Radiation", enable=use_shortWaveRadIn));
  replaceable parameter
    ThermalZones.HighOrder.Components.Types.PartialCoeffTable staticCoeffTable
    constrainedby
    AixLib.ThermalZones.HighOrder.Components.Types.PartialCoeffTable
    "Record holding the values to reproduce the tables"
    annotation (choicesAllMatching=true, Dialog(tab="Inner walls", group="Shortwave Radiation", enable=
          use_shortWaveRadIn and not use_dynamicShoWaveMethod));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall wallSouth(
    final use_shortWaveRadIn=use_shortWaveRadIn,
    final use_shortWaveRadOut=use_shortWaveRadOut,
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
    final use_shortWaveRadIn=use_shortWaveRadIn,
    final use_shortWaveRadOut=use_shortWaveRadOut,
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
    final use_shortWaveRadIn=use_shortWaveRadIn,
    final use_shortWaveRadOut=use_shortWaveRadOut,
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
    final use_shortWaveRadIn=use_shortWaveRadIn,
    final use_shortWaveRadOut=use_shortWaveRadOut,
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
    final use_shortWaveRadIn=use_shortWaveRadIn,
    final use_shortWaveRadOut=use_shortWaveRadOut,
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
    final use_shortWaveRadIn=use_shortWaveRadIn,
    final use_shortWaveRadOut=use_shortWaveRadOut,
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
    final use_dynamicMethod=use_dynamicShoWaveMethod,
    final nWin=nWin,
    final nWalls=4,
    final nFloors=1,
    final nCei=1,
    final floor_length=room_length,
    final floor_width=room_height,
    final staticCoeffTable=staticCoeffTable) if use_shortWaveRadIn
    annotation (Placement(transformation(extent={{-50,26},{-30,46}})));

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
        points={{-31,82.6},{-31,88},{-94,88},{-94,64},{-110,64}}, color={255,128,
          0}));
  connect(wallWest.SolarRadiationPort, SolarRadiationPort[4]) annotation (Line(
        points={{-89.5,37.75},{-89.5,38},{-96,38},{-96,60},{-110,60}}, color={
          255,128,0}));
  connect(wallNorth.SolarRadiationPort, SolarRadiationPort[1]) annotation (Line(
        points={{-9.5,75.5},{82,75.5},{82,-84},{-96,-84},{-96,48},{-110,48}},
        color={255,128,0}));

  connect(wallEast.SolarRadiationPort, SolarRadiationPort[2]) annotation (Line(
        points={{75.5,-11.75},{75.5,-12},{82,-12},{82,-84},{-96,-84},{-96,52},{
          -110,52}}, color={255,128,0}));

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
  connect(wallEast.shortRadWin, solarRadInRoom.win_in[1]) annotation (Line(points={{64.25,
          26.275},{44,26.275},{44,46},{-54,46},{-54,36},{-51,36}},   color={0,0,0}, pattern=LinePattern.Dash));
  connect(wallSouth.shortRadWin, solarRadInRoom.win_in[2]) annotation (Line(points={{35.2083,
          -63.25},{35.2083,-56},{44,-56},{44,46},{-54,46},{-54,36},{-51,36}},
                                                              color={0,0,0}, pattern=LinePattern.Dash));
  connect(wallWest.shortRadWin, solarRadInRoom.win_in[3]) annotation (Line(points={{-78.25,
          -0.275},{-54,-0.275},{-54,36},{-51,36}},                     color={0,0,0}, pattern=LinePattern.Dash));
  connect(wallNorth.shortRadWin, solarRadInRoom.win_in[4]) annotation (Line(points={{32.75,
          64.25},{32.75,46},{-54,46},{-54,36},{-51,36}}, color={0,0,0}, pattern=LinePattern.Dash));
  connect(solarRadInRoom.walls[1], wallEast.shortRadWall) annotation (Line(points={{-29,
          41.25},{44,41.25},{44,-4.775},{64,-4.775}}, color={0,0,0}, pattern=LinePattern.Dash));
  connect(solarRadInRoom.walls[2], wallSouth.shortRadWall) annotation (Line(points={{-29,
          41.75},{-20,41.75},{-20,38},{46,38},{46,-56},{-5.04167,-56},{-5.04167,
          -63}},                                                     color={0,0,0}, pattern=LinePattern.Dash));
  connect(solarRadInRoom.walls[3], wallWest.shortRadWall) annotation (Line(points={{-29,
          42.25},{-20,42.25},{-20,46},{-54,46},{-54,30.775},{-78,30.775}},
                                                          color={0,0,0}, pattern=LinePattern.Dash));
  connect(solarRadInRoom.walls[4], wallNorth.shortRadWall) annotation (Line(points={{-29,
          42.75},{-1.75,42.75},{-1.75,64}}, color={0,0,0}, pattern=LinePattern.Dash));
  connect(solarRadInRoom.floors[1], floor.shortRadWall) annotation (Line(points={{-29,38},
          {46,38},{46,-56},{-49.9,-56},{-49.9,-66}},                     color={0,0,0}, pattern=LinePattern.Dash));
  connect(solarRadInRoom.ceilings[1], ceiling.shortRadWall) annotation (Line(points={{-29,34},
          {-22,34},{-22,48},{-34.1,48},{-34.1,78}}, color={0,0,0}, pattern=LinePattern.Dash));
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