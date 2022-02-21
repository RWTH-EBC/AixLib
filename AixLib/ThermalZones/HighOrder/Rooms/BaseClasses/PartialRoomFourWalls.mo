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
      roofRoomUpFloor=DataBase.Walls.ASHRAE140.DummyDefinition()),
      final room_V=room_length*room_width*room_height);

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


  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_South(
    final energyDynamics=energyDynamicsWalls,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    final calcMethodIn=calcMethodIn,
    final WindowType=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final T0=TWalls_start,
    final wall_length=room_width,
    final solar_absorptance=solar_absorptance_OW,
    final calcMethodOut=calcMethodOut,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    final wall_height=room_height,
    surfaceType=AixLib.DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster())
    annotation (Placement(transformation(
        extent={{-5,-35},{5,35}},
        rotation=90,
        origin={18,-68})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_West(
    final energyDynamics=energyDynamicsWalls,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    final calcMethodIn=calcMethodIn,
    final wall_length=room_length,
    final wall_height=room_height,
    final WindowType=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final T0=TWalls_start,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    final solar_absorptance=solar_absorptance_OW,
    surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
    final calcMethodOut=calcMethodOut) annotation (Placement(transformation(
        extent={{-5,-27},{5,27}},
        rotation=0,
        origin={-83,13})));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_East(
    final energyDynamics=energyDynamicsWalls,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    final calcMethodIn=calcMethodIn,
    final wall_length=room_length,
    final wall_height=room_height,
    final WindowType=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final T0=TWalls_start,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    final solar_absorptance=solar_absorptance_OW,
    surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
    final calcMethodOut=calcMethodOut) annotation (Placement(transformation(
        extent={{-5,-27},{5,27}},
        rotation=180,
        origin={69,13})));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_North(
    final energyDynamics=energyDynamicsWalls,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    final calcMethodIn=calcMethodIn,
    final wall_height=room_height,
    final WindowType=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final T0=TWalls_start,
    final wall_length=room_width,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    final solar_absorptance=solar_absorptance_OW,
    surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
    final calcMethodOut=calcMethodOut) annotation (Placement(transformation(
        extent={{5.00001,-30},{-5.00001,30}},
        rotation=90,
        origin={18,69})));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall ceiling(
    final energyDynamics=energyDynamicsWalls,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    final calcMethodIn=calcMethodIn,
    final wall_length=room_length,
    final wall_height=room_width,
    final WindowType=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final T0=TWalls_start,
    final wallPar=wallTypes.roof,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    final solar_absorptance=solar_absorptance_OW,
    surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
    final calcMethodOut=calcMethodOut) annotation (Placement(transformation(
        extent={{-2,-12},{2,12}},
        rotation=270,
        origin={-42,80})));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall floor(
    outside=false,
    final energyDynamics=energyDynamicsWalls,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    final calcMethodIn=calcMethodIn,
    final wall_length=room_length,
    final wall_height=room_width,
    final WindowType=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final T0=TWalls_start,
    final wallPar=wallTypes.groundPlate_upp_half,
    final solar_absorptance=solar_absorptance_OW,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    final calcMethodOut=calcMethodOut) annotation (Placement(transformation(
        extent={{-2.00031,-12},{2.00003,12}},
        rotation=90,
        origin={-42,-68})));

    Utilities.Interfaces.SolarRad_in   SolarRadiationPort[5] "N,E,S,W,Hor"
      annotation (Placement(transformation(extent={{-120,46},{-100,66}}),
        iconTransformation(extent={{-120,46},{-100,66}})));
    Modelica.Blocks.Interfaces.RealInput WindSpeedPort
      annotation (Placement(transformation(extent={{-116,28},{-100,44}}),
          iconTransformation(extent={{-120,-16},{-100,4}})));
equation
  connect(Wall_South.WindSpeedPort, WindSpeedPort) annotation (Line(points={{
          -7.66667,-73.25},{-8,-73.25},{-8,-82},{-94,-82},{-94,36},{-108,36}},
                                                                      color={0,
          0,127}));
  connect(Wall_East.WindSpeedPort, WindSpeedPort) annotation (Line(points={{74.25,
          -6.8},{74.25,-6},{82,-6},{82,-82},{-94,-82},{-94,36},{-108,36}},
        color={0,0,127}));
  connect(ceiling.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-33.2,
          82.1},{-33.2,88},{-94,88},{-94,36},{-108,36}}, color={0,0,127}));
  connect(Wall_North.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-4,
          74.25},{82,74.25},{82,-82},{-94,-82},{-94,36},{-108,36}}, color={0,0,
          127}));

  connect(Wall_West.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-88.25,
          32.8},{-88.25,34},{-94,34},{-94,36},{-108,36}}, color={0,0,127}));

  connect(SolarRadiationPort[3], Wall_South.SolarRadiationPort) annotation (
      Line(points={{-110,56},{-96,56},{-96,-84},{-14,-84},{-14,-74.5},{-14.0833,
          -74.5}}, color={255,128,0}));
  connect(ceiling.SolarRadiationPort, SolarRadiationPort[5]) annotation (Line(
        points={{-31,82.6},{-31,88},{-94,88},{-94,64},{-110,64}}, color={255,128,
          0}));
  connect(Wall_West.SolarRadiationPort, SolarRadiationPort[4]) annotation (Line(
        points={{-89.5,37.75},{-89.5,38},{-96,38},{-96,60},{-110,60}}, color={
          255,128,0}));
  connect(Wall_North.SolarRadiationPort, SolarRadiationPort[1]) annotation (
      Line(points={{-9.5,75.5},{82,75.5},{82,-84},{-96,-84},{-96,48},{-110,48}},
        color={255,128,0}));

  connect(Wall_East.SolarRadiationPort, SolarRadiationPort[2]) annotation (Line(
        points={{75.5,-11.75},{75.5,-12},{82,-12},{82,-84},{-96,-84},{-96,52},{
          -110,52}}, color={255,128,0}));

  connect(thermStar_Demux.portConvRadComb, floor.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{-42,-56},{-42,-66}},
        color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, Wall_South.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{18,-56},{18,-63}}, color=
         {191,0,0}));
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
