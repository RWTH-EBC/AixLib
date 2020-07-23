within AixLib.ThermalZones.HighOrder.Rooms.ASHRAE140;
model EastWestFacingWindows "windows facing south and west"
  extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoom(
    redeclare Components.WindowsDoors.Window_ASHRAE140 windowModel,
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

  parameter Modelica.SIunits.Temperature T0_Air=295.15 "Air"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));

  parameter Real eps_out=0.9 "emissivity of the outer surface"
    annotation (Dialog(group="Outer wall properties", descriptionLabel=true));

public
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outerWall_South(
    use_shortWaveRadIn=true,
    calcMethodIn=calcMethodIn,
    final WindowType=Type_Win,
    final windowModel=windowModel,
    final corrSolarGainWin=corrSolarGainWin,
    withDoor=false,
    wallPar=wallTypes.OW,
    T0=Tset,
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
    withWindow=false) annotation (Placement(transformation(extent={{-76,-36},{-62,44}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outerWall_West(
    use_shortWaveRadIn=true,
    use_shortWaveRadOut=true,
    calcMethodIn=calcMethodIn,
    wall_length=room_length,
    wall_height=room_height,
    final WindowType=Type_Win,
    final windowModel=windowModel,
    final corrSolarGainWin=corrSolarGainWin,
    withDoor=false,
    T0=Tset,
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
        extent={{-4,-24},{4,24}},
        rotation=-90,
        origin={26,78})));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outerWall_East(
    use_shortWaveRadIn=true,
    use_shortWaveRadOut=true,
    calcMethodIn=calcMethodIn,
    wall_length=room_length,
    wall_height=room_height,
    final WindowType=Type_Win,
    final windowModel=windowModel,
    final corrSolarGainWin=corrSolarGainWin,
    T0=Tset,
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
        extent={{-4.00001,-24},{4.00001,24}},
        rotation=90,
        origin={26,-68})));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outerWall_North(
    use_shortWaveRadIn=true,
    calcMethodIn=calcMethodIn,
    wall_height=room_height,
    final WindowType=Type_Win,
    final windowModel=windowModel,
    final corrSolarGainWin=corrSolarGainWin,
    U_door=5.25,
    solarDistribution=partialCoeffTable.coeffOWNorth,
    door_height=1,
    door_width=2,
    withDoor=false,
    T0=Tset,
    wall_length=room_width,
    outside=true,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    wallPar=wallTypes.OW,
    solar_absorptance=solar_absorptance_OW,
    surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
    calcMethodOut=calcMethodOut) annotation (Placement(transformation(extent={{74,-36},{60,44}})));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall ceiling(
    use_shortWaveRadIn=true,
    calcMethodIn=calcMethodIn,
    wall_length=room_length,
    wall_height=room_width,
    ISOrientation=3,
    solarDistribution=partialCoeffTable.coeffCeiling,
    final WindowType=Type_Win,
    final windowModel=windowModel,
    final corrSolarGainWin=corrSolarGainWin,
    withDoor=false,
    T0=Tset,
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
        origin={-32,78})));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall floor(
    use_shortWaveRadIn=true,
    calcMethodIn=calcMethodIn,
    wall_length=room_length,
    wall_height=room_width,
    final WindowType=Type_Win,
    final windowModel=windowModel,
    final corrSolarGainWin=corrSolarGainWin,
    withDoor=false,
    solarDistribution=partialCoeffTable.coeffFloor,
    T0=Tset,
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
        origin={-32,-64})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_ground
    annotation (Placement(transformation(extent={{-36,-100},{-28,-92}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation (Placement(
        transformation(extent={{-120,20},{-104,36}}), iconTransformation(extent=
           {{-120,20},{-100,40}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort[5] "N,E,S,W,Hor"
    annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=2) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={34,26})));

  parameter Components.Types.selectorCoefficients absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs06
    "Coefficients for interior solar absorptance of wall surface abs={0.6, 0.9, 0.1}";

  replaceable parameter Components.Types.CoeffTableEastWestWindow
    partialCoeffTable constrainedby Components.Types.PartialCoeffTable(final
      abs=absInnerWallSurf) annotation (Placement(transformation(extent={{78,78},
            {98,98}})), choicesAllMatching=true);


equation
  connect(floor.port_outside, Therm_ground)
    annotation (Line(points={{-32,-66.1003},{-32,-96}}, color={191,0,0}));
  connect(outerWall_South.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-76.35,33.3333},{-86,33.3333},{-86,28},{-112,28}},
                                                              color={0,0,127}));
  connect(outerWall_East.WindSpeedPort, WindSpeedPort) annotation (Line(points={{8.4,-72.2},{8.4,-80},{-86,-80},{-86,28},{-112,28}},
                                                               color={0,0,127}));
  connect(ceiling.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-23.2,
          80.1},{-23.2,88},{-86,88},{-86,28},{-112,28}}, color={0,0,127}));
  connect(outerWall_North.WindSpeedPort, WindSpeedPort) annotation (Line(points={{74.35,33.3333},{82,33.3333},{82,-80},{-86,-80},{-86,28},{-112,28}},
        color={0,0,127}));

  connect(outerWall_West.WindSpeedPort, WindSpeedPort) annotation (Line(points={
          {43.6,82.2},{43.6,88},{-86,88},{-86,28},{-112,28}}, color={0,0,127}));

  connect(SolarRadiationPort[3], outerWall_South.SolarRadiationPort)
    annotation (Line(points={{-110,60},{-86,60},{-86,40.6667},{-78.1,40.6667}},
        color={255,128,0}));
  connect(ceiling.SolarRadiationPort, SolarRadiationPort[5]) annotation (Line(
        points={{-21,80.6},{-21,88},{-86,88},{-86,68},{-110,68}}, color={255,128,
          0}));
  connect(outerWall_West.SolarRadiationPort, SolarRadiationPort[4]) annotation (
     Line(points={{48,83.2},{48,88},{-86,88},{-86,64},{-110,64}}, color={255,128,
          0}));
  connect(outerWall_North.SolarRadiationPort, SolarRadiationPort[1])
    annotation (Line(points={{76.1,40.6667},{82,40.6667},{82,-80},{-86,-80},{-86,52},{-110,52}},
                          color={255,128,0}));

  connect(outerWall_East.SolarRadiationPort, SolarRadiationPort[2]) annotation (
     Line(points={{4,-73.2},{4,-80},{-86,-80},{-86,56},{-110,56}}, color={255,128,
          0}));
  connect(multiSum.y, outerWall_West.solarRadWin) annotation (Line(points={{26.98,
          26},{28,26},{28,60},{43.6,60},{43.6,73.6}}, color={0,0,127}));
  connect(multiSum.y, ceiling.solarRadWin) annotation (Line(points={{26.98,26},{
          28,26},{28,60},{-22,60},{-22,75.8},{-23.2,75.8}}, color={0,0,127}));
  connect(multiSum.y, outerWall_South.solarRadWin) annotation (Line(points={{26.98,26},{28,26},{28,60},{-54,60},{-54,33.3333},{-61.3,33.3333}},
                                                                       color={0,
          0,127}));
  connect(multiSum.y, floor.solarRadWin) annotation (Line(points={{26.98,26},{28,26},{28,60},{-54,60},{-54,-56},{-40.8,-56},{-40.8,-61.8}},
                                                                     color={0,0,
          127}));
  connect(multiSum.y, outerWall_East.solarRadWin) annotation (Line(points={{26.98,26},{28,26},{28,60},{46,60},{46,-56},{8,-56},{8,-58},{8.4,-58},{8.4,-63.6}},
        color={0,0,127}));
  connect(multiSum.y, outerWall_North.solarRadWin) annotation (Line(points={{26.98,26},{28,26},{28,60},{46,60},{46,33.3333},{59.3,33.3333}},
                                                                    color={0,0,127}));

  connect(outerWall_West.solarRadWinTrans, multiSum.u[1]) annotation (Line(
        points={{13.6,73},{13.6,60},{46,60},{46,23.9},{40,23.9}}, color={0,0,127}));
  connect(outerWall_East.solarRadWinTrans, multiSum.u[2]) annotation (Line(
        points={{38.4,-63},{38.4,-56},{46,-56},{46,30},{38,30},{38,28.1},{40,28.1}},
        color={0,0,127}));
  connect(thermOutside, ceiling.port_outside) annotation (Line(points={{-100,100},
          {-68,100},{-68,88},{-32,88},{-32,80.1}}, color={191,0,0}));
  connect(thermOutside, outerWall_West.port_outside) annotation (Line(points={{-100,
          100},{-68,100},{-68,88},{26,88},{26,82.2}}, color={191,0,0}));
  connect(thermOutside, outerWall_North.port_outside) annotation (Line(points={{
          -100,100},{-68,100},{-68,88},{82,88},{82,4},{74.35,4}}, color={191,0,0}));
  connect(thermOutside, outerWall_East.port_outside) annotation (Line(points={{-100,100},{-68,100},{-68,88},{82,88},{82,-80},{26,-80},{26,-72.2}},
                                                                         color={
          191,0,0}));
  connect(thermOutside, outerWall_South.port_outside) annotation (Line(points={{
          -100,100},{-68,100},{-68,88},{82,88},{82,-80},{-86,-80},{-86,4},{-76.35,
          4}}, color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, floor.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{-32,-56},{-32,-62}},
        color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, outerWall_South.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{-54,-56},{-54,4},{-62,4}},
        color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, outerWall_East.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{26,-56},{26,-64}}, color=
         {191,0,0}));
  connect(thermStar_Demux.portConvRadComb, outerWall_North.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{46,-56},{46,4},{60,4}},
        color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, outerWall_West.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{46,-56},{46,60},{26,60},{
          26,74}}, color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, ceiling.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{46,-56},{46,60},{-32,60},
          {-32,76}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,92},{94,-92}},
          lineColor={215,215,215},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-86,76},{80,-80}},
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,26},{-86,-34}},
          lineColor={170,213,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-22,12},{22,-12}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="Window",
          textStyle={TextStyle.Bold},
          origin={-94,-2},
          rotation=90),
        Text(
          extent={{-54,-54},{54,-76}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="Length"),
        Text(
          extent={{-22,11},{22,-11}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="width",
          origin={65,0},
          rotation=90)}), Documentation(revisions="<html>
<ul>
  <li><i>July 1, 2020 </i> by Konstantina Xanhtopoulou:<br/><a href=\"https://github.com/RWTH-EBC/AixLib/issues/896\">#896</a>: Mainly added solar distribution fractions, extended from PartialRoom.</li>
 </ul>
 <ul>
 <li><i>March 9, 2015</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>


",         info="<html>
</html>"));
end EastWestFacingWindows;
