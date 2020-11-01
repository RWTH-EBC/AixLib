within AixLib.ThermalZones.HighOrder.Rooms.ASHRAE140;
model EastWestFacingWindows "windows facing south and west"
  extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoom(
    redeclare replaceable model WindowModel = AixLib.ThermalZones.HighOrder.Components.WindowsDoors.Window_ASHRAE140,
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

  parameter Real eps_out=0.9 "emissivity of the outer surface"
    annotation (Dialog(group="Outer wall properties", descriptionLabel=true));

public
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outerWall_South(
    final energyDynamics=energyDynamicsWalls,
    use_shortWaveRadIn=true,
    calcMethodIn=calcMethodIn,
    final WindowType=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    withDoor=false,
    wallPar=wallTypes.OW,
    final T0=TWalls_start,
    solarDistribution=partialCoeffTable.coeffOWSouth,
    wall_length=room_width,
    solar_absorptance=solar_absorptance_OW,
    calcMethodOut=calcMethodOut,
    outside=true,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    windowarea=Win_Area,
    wall_height=room_height,
    surfaceType=AixLib.DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
    withWindow=false) annotation (Placement(transformation(
        extent={{-5,-35},{5,35}},
        rotation=90,
        origin={18,-68})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outerWall_West(
    final energyDynamics=energyDynamicsWalls,
    use_shortWaveRadIn=true,
    use_shortWaveRadOut=true,
    calcMethodIn=calcMethodIn,
    wall_length=room_length,
    wall_height=room_height,
    final WindowType=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    withDoor=false,
    final T0=TWalls_start,
    solarDistribution=partialCoeffTable.coeffOWWest,
    outside=true,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    wallPar=wallTypes.OW,
    solar_absorptance=solar_absorptance_OW,
    surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
    calcMethodOut=calcMethodOut,
    withWindow=true,
    windowarea=Win_Area*0.5) annotation (Placement(transformation(
        extent={{-5,-27},{5,27}},
        rotation=0,
        origin={-83,13})));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outerWall_East(
    final energyDynamics=energyDynamicsWalls,
    use_shortWaveRadIn=true,
    use_shortWaveRadOut=true,
    calcMethodIn=calcMethodIn,
    wall_length=room_length,
    wall_height=room_height,
    final WindowType=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final T0=TWalls_start,
    solarDistribution=partialCoeffTable.coeffOWEast,
    outside=true,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    wallPar=wallTypes.OW,
    solar_absorptance=solar_absorptance_OW,
    surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
    calcMethodOut=calcMethodOut,
    withWindow=true,
    windowarea=Win_Area*0.5) annotation (Placement(transformation(
        extent={{-5,-27},{5,27}},
        rotation=180,
        origin={69,13})));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outerWall_North(
    final energyDynamics=energyDynamicsWalls,
    use_shortWaveRadIn=true,
    calcMethodIn=calcMethodIn,
    wall_height=room_height,
    final WindowType=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    U_door=5.25,
    solarDistribution=partialCoeffTable.coeffOWNorth,
    door_height=1,
    door_width=2,
    withDoor=false,
    final T0=TWalls_start,
    wall_length=room_width,
    outside=true,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    wallPar=wallTypes.OW,
    solar_absorptance=solar_absorptance_OW,
    surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
    calcMethodOut=calcMethodOut) annotation (Placement(transformation(
        extent={{5.00001,-30},{-5.00001,30}},
        rotation=90,
        origin={18,69})));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall ceiling(
    final energyDynamics=energyDynamicsWalls,
    use_shortWaveRadIn=true,
    calcMethodIn=calcMethodIn,
    wall_length=room_length,
    wall_height=room_width,
    ISOrientation=3,
    solarDistribution=partialCoeffTable.coeffCeiling,
    final WindowType=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    withDoor=false,
    final T0=TWalls_start,
    wallPar=wallTypes.roof,
    outside=true,
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
    use_shortWaveRadIn=true,
    calcMethodIn=calcMethodIn,
    wall_length=room_length,
    wall_height=room_width,
    final WindowType=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    withDoor=false,
    solarDistribution=partialCoeffTable.coeffFloor,
    final T0=TWalls_start,
    wallPar=wallTypes.groundPlate_upp_half,
    solar_absorptance=solar_absorptance_OW,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    calcMethodOut=calcMethodOut) annotation (Placement(transformation(
        extent={{-2.00031,-12},{2.00003,12}},
        rotation=90,
        origin={-42,-68})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_ground
    annotation (Placement(transformation(extent={{-104,-104},{-96,-96}}), iconTransformation(extent={{-108,-108},{-92,-92}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation (Placement(
        transformation(extent={{-120,20},{-104,36}}), iconTransformation(extent=
           {{-120,20},{-100,40}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort[5] "N,E,S,W,Hor"
    annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=2) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={34,36})));

  parameter Components.Types.selectorCoefficients absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs06
    "Coefficients for interior solar absorptance of wall surface abs={0.6, 0.9, 0.1}";

  replaceable parameter Components.Types.CoeffTableEastWestWindow
    partialCoeffTable constrainedby Components.Types.PartialCoeffTable(final
      abs=absInnerWallSurf) annotation (Placement(transformation(extent={{78,78},
            {98,98}})), choicesAllMatching=true);


equation
  connect(floor.port_outside, Therm_ground)
    annotation (Line(points={{-42,-70.1003},{-42,-100},{-100,-100}},
                                                        color={191,0,0}));
  connect(outerWall_South.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-7.66667,-73.25},{-8,-73.25},{-8,-82},{-94,-82},{-94,28},{-112,28}},
                                                              color={0,0,127}));
  connect(outerWall_East.WindSpeedPort, WindSpeedPort) annotation (Line(points={{74.25,-6.8},{74.25,-6},{82,-6},{82,-82},{-94,-82},{-94,28},{-112,28}},
                                                               color={0,0,127}));
  connect(ceiling.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-33.2,82.1},{-33.2,88},{-94,88},{-94,28},{-112,28}},
                                                         color={0,0,127}));
  connect(outerWall_North.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-4,74.25},{82,74.25},{82,-82},{-94,-82},{-94,28},{-112,28}},
        color={0,0,127}));

  connect(outerWall_West.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-88.25,32.8},{-88.25,34},{-94,34},{-94,28},{-112,28}},
                                                              color={0,0,127}));

  connect(SolarRadiationPort[3], outerWall_South.SolarRadiationPort)
    annotation (Line(points={{-110,60},{-96,60},{-96,-84},{-14,-84},{-14,-74.5},{-14.0833,-74.5}},
        color={255,128,0}));
  connect(ceiling.SolarRadiationPort, SolarRadiationPort[5]) annotation (Line(
        points={{-31,82.6},{-31,88},{-94,88},{-94,68},{-110,68}}, color={255,128,
          0}));
  connect(outerWall_West.SolarRadiationPort, SolarRadiationPort[4]) annotation (
     Line(points={{-89.5,37.75},{-89.5,38},{-96,38},{-96,64},{-110,64}},
                                                                  color={255,128,
          0}));
  connect(outerWall_North.SolarRadiationPort, SolarRadiationPort[1])
    annotation (Line(points={{-9.5,75.5},{82,75.5},{82,-84},{-96,-84},{-96,52},{-110,52}},
                          color={255,128,0}));

  connect(outerWall_East.SolarRadiationPort, SolarRadiationPort[2]) annotation (
     Line(points={{75.5,-11.75},{75.5,-12},{82,-12},{82,-84},{-96,-84},{-96,56},{-110,56}},
                                                                   color={255,128,0}));
  connect(multiSum.y, outerWall_West.solarRadWin) annotation (Line(points={{26.98,36},{22,36},{22,46},{-54,46},{-54,32},{-77.5,32},{-77.5,32.8}},
                                                      color={0,0,127}));
  connect(multiSum.y, ceiling.solarRadWin) annotation (Line(points={{26.98,36},{22,36},{22,46},{-22,46},{-22,77.8},{-33.2,77.8}},
                                                            color={0,0,127}));
  connect(multiSum.y, outerWall_South.solarRadWin) annotation (Line(points={{26.98,36},{22,36},{22,46},{-54,46},{-54,-56},{-8,-56},{-8,-62.5},{-7.66667,-62.5}},
                                                                       color={0,
          0,127}));
  connect(multiSum.y, floor.solarRadWin) annotation (Line(points={{26.98,36},{22,36},{22,46},{-54,46},{-54,-56},{-50.8,-56},{-50.8,-65.8}},
                                                                     color={0,0,
          127}));
  connect(multiSum.y, outerWall_East.solarRadWin) annotation (Line(points={{26.98,36},{22,36},{22,46},{42,46},{42,-6},{63.5,-6},{63.5,-6.8}},
        color={0,0,127}));
  connect(multiSum.y, outerWall_North.solarRadWin) annotation (Line(points={{26.98,36},{22,36},{22,46},{-4,46},{-4,63.5}},
                                                                    color={0,0,127}));

  connect(outerWall_West.solarRadWinTrans, multiSum.u[1]) annotation (Line(
        points={{-76.75,-0.95},{-76.75,0},{-64,0},{-64,52},{46,52},{46,33.9},{40,33.9}},
                                                                  color={0,0,127}));
  connect(outerWall_East.solarRadWinTrans, multiSum.u[2]) annotation (Line(
        points={{62.75,26.95},{62.75,26},{46,26},{46,38.1},{40,38.1}},
        color={0,0,127}));
  connect(thermOutside, ceiling.port_outside) annotation (Line(points={{-100,100},{-68,100},{-68,88},{-42,88},{-42,82.1}},
                                                   color={191,0,0}));
  connect(thermOutside, outerWall_West.port_outside) annotation (Line(points={{-100,100},{-68,100},{-68,88},{-92,88},{-92,12},{-88.25,12},{-88.25,13}},
                                                      color={191,0,0}));
  connect(thermOutside, outerWall_North.port_outside) annotation (Line(points={{-100,100},{-68,100},{-68,88},{82,88},{82,74.25},{18,74.25}},
                                                                  color={191,0,0}));
  connect(thermOutside, outerWall_East.port_outside) annotation (Line(points={{-100,100},{-68,100},{-68,88},{82,88},{82,12},{74.25,12},{74.25,13}},
                                                                         color={
          191,0,0}));
  connect(thermOutside, outerWall_South.port_outside) annotation (Line(points={{-100,100},{-68,100},{-68,88},{82,88},{82,-80},{18,-80},{18,-73.25}},
               color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, floor.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{-42,-56},{-42,-66}},
        color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, outerWall_South.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{18,-56},{18,-63}},
        color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, outerWall_East.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{44,-56},{44,12},{64,12},{64,13}},
                                                                          color=
         {191,0,0}));
  connect(thermStar_Demux.portConvRadComb, outerWall_North.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{44,-56},{44,50},{18,50},{18,64}},
        color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, outerWall_West.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{44,-56},{44,50},{-62,50},{-62,14},{-78,14},{-78,13}},
                   color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, ceiling.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{44,-56},{44,50},{-42,50},{-42,78}},
                     color={191,0,0}));
  annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={215,215,215},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-85,85},{85,-85}},
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-24,11},{24,-11}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          origin={75,0},
          rotation=90,
          fontSize=47,
          textString="Width"),
        Text(
          extent={{-24,11},{24,-11}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          origin={0,-75},
          rotation=0,
          fontSize=47,
          textString="Length"),
        Rectangle(
          extent={{-7,30},{7,-30}},
          lineColor={170,213,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          origin={-92.5,0},
          rotation=360),
        Text(
          extent={{-30,-7},{30,7}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="Window",
          textStyle={TextStyle.Bold},
          origin={-92,-1},
          rotation=90),
        Rectangle(
          extent={{-7,30},{7,-30}},
          lineColor={170,213,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          origin={92.5,0},
          rotation=360),
        Text(
          extent={{-30,-7},{30,7}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="Window",
          textStyle={TextStyle.Bold},
          origin={92.5,0},
          rotation=90)}), Documentation(revisions="<html><ul>
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
end EastWestFacingWindows;
