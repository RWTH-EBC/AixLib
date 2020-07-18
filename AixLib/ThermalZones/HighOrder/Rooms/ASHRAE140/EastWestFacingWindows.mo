within AixLib.ThermalZones.HighOrder.Rooms.ASHRAE140;
model EastWestFacingWindows "windows facing south and west"
  extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoom(
    redeclare DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes(
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

    parameter Modelica.SIunits.Length room_length=6 "length" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
    parameter Modelica.SIunits.Height room_height=2.7 "height" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
    parameter Modelica.SIunits.Length room_width=8 "width"
                                                          annotation (Dialog(group = "Dimensions", descriptionLabel = true));

    parameter Modelica.SIunits.Area Win_Area= 12 "Window area " annotation (Dialog(group = "Windows", descriptionLabel = true, enable = withWindow1));

    parameter Modelica.SIunits.Temperature T0_Air=295.15 "Air"
                                                              annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

    parameter Real eps_out=0.9 "emissivity of the outer surface" annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));

    parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple Win=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140()
      "choose a Window type" annotation(Dialog(group="Windows"),choicesAllMatching= true);
    parameter Boolean shortWaveRad_method = true "Dynamic for holistic approach, static to obtain the same values as provided in tables of the ASHREA" annotation(Dialog(tab = "Short wave radiation", compact = true, descriptionLabel = false), choices(choice = true "Dynamic", choice = false "Static", radioButtons = true));
    parameter Components.Types.selectorCoefficients abs=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs09
    "Coefficients for interior solar absorptance of wall surface abs={0.6, 0.9, 0.1}" annotation(choicesAllMatching=true, Dialog(tab = "Short wave radiation", enable=not shortWaveRad_method));

public
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outerWall_South(
    use_shortWaveRadIn=true,
    withDoor=false,
    wallPar=wallTypes.OW,
    T0=Tset,
    wall_length=room_width,
    solar_absorptance=solar_absorptance_OW,
    calcMethodOut=2,
    outside=true,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    windowarea=Win_Area,
    wall_height=room_height,
    surfaceType=AixLib.DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
    WindowType=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140(),
    withWindow=false)
    annotation (Placement(transformation(extent={{-76,-36},{-62,44}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outerWall_West(
    use_shortWaveRadIn=true,
    use_shortWaveRadOut=true,
    wall_length=room_length,
    wall_height=room_height,
    redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
    withDoor=false,
    T0=Tset,
    outside=true,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    wallPar=wallTypes.OW,
    solar_absorptance=solar_absorptance_OW,
    surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
    calcMethodOut=2,
    withWindow=true,
    WindowType=Win,
    windowarea=Win_Area*0.5) annotation (Placement(transformation(
        extent={{-4,-24},{4,24}},
        rotation=-90,
        origin={26,78})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outerWall_East(
    use_shortWaveRadIn=true,
    use_shortWaveRadOut=true,
    wall_length=room_length,
    wall_height=room_height,
    redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
    T0=Tset,
    outside=true,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    wallPar=wallTypes.OW,
    solar_absorptance=solar_absorptance_OW,
    surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
    calcMethodOut=2,
    withWindow=true,
    WindowType=Win,
    windowarea=Win_Area*0.5) annotation (Placement(transformation(
        extent={{-4.00001,-24},{4.00001,24}},
        rotation=90,
        origin={26,-68})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outerWall_North(
    use_shortWaveRadIn=true,
    wall_height=room_height,
    U_door=5.25,
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
    calcMethodOut=2)
    annotation (Placement(transformation(extent={{74,-36},{60,44}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall ceiling(
    use_shortWaveRadIn=true,
    wall_length=room_length,
    wall_height=room_width,
    ISOrientation=3,
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
    calcMethodOut=2) annotation (Placement(transformation(
        extent={{-2,-12},{2,12}},
        rotation=270,
        origin={-32,78})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall floor(
    use_shortWaveRadIn=true,
    wall_length=room_length,
    wall_height=room_width,
    withDoor=false,
    T0=Tset,
    wallPar=wallTypes.groundPlate_upp_half,
    solar_absorptance=solar_absorptance_OW,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    calcMethodOut=2) annotation (Placement(transformation(
        extent={{-2.00031,-12},{2.00003,12}},
        rotation=90,
        origin={-32,-64})));

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_ground
      annotation (Placement(transformation(extent={{-36,-100},{-28,-92}})));
    Modelica.Blocks.Interfaces.RealInput WindSpeedPort
      annotation (Placement(transformation(extent={{-120,20},{-104,36}}),
          iconTransformation(extent={{-120,20},{-100,40}})));
    Utilities.Interfaces.SolarRad_in   SolarRadiationPort[5] "N,E,S,W,Hor"
      annotation (Placement(transformation(extent={{-120,50},{-100,70}})));


  Utilities.HeatTransfer.SolarRadInRoom solarRadInRoom(
    final method=shortWaveRad_method,
    nWin=2, nWalls=4,
    redeclare Components.Types.CoeffTableEastWestWindow staticCoeffTable(final abs=abs))
    annotation (Placement(transformation(extent={{-50,36},{-30,56}})));

equation
    connect(floor.port_outside, Therm_ground) annotation (Line(
        points={{-32,-66.1003},{-32,-96}},
        color={191,0,0}));
    connect(outerWall_South.WindSpeedPort, WindSpeedPort) annotation (Line(
        points={{-76.35,33.3333},{-86,33.3333},{-86,28},{-112,28}},
        color={0,0,127}));
    connect(outerWall_East.WindSpeedPort, WindSpeedPort) annotation (Line(
        points={{8.4,-72.2},{8.4,-80},{-86,-80},{-86,28},{-112,28}},
        color={0,0,127}));
    connect(ceiling.WindSpeedPort, WindSpeedPort) annotation (Line(
        points={{-23.2,80.1},{-23.2,88},{-86,88},{-86,28},{-112,28}},
        color={0,0,127}));
    connect(outerWall_North.WindSpeedPort, WindSpeedPort) annotation (Line(
        points={{74.35,33.3333},{82,33.3333},{82,-80},{-86,-80},{-86,28},{-112,
          28}},
        color={0,0,127}));

    connect(outerWall_West.WindSpeedPort, WindSpeedPort) annotation (Line(
        points={{43.6,82.2},{43.6,88},{-86,88},{-86,28},{-112,28}},
        color={0,0,127}));

    connect(SolarRadiationPort[3], outerWall_South.SolarRadiationPort)
      annotation (Line(
        points={{-110,60},{-86,60},{-86,40.6667},{-78.1,40.6667}},
        color={255,128,0}));
    connect(ceiling.SolarRadiationPort, SolarRadiationPort[5]) annotation (
        Line(
        points={{-21,80.6},{-21,88},{-86,88},{-86,68},{-110,68}},
        color={255,128,0}));
    connect(outerWall_West.SolarRadiationPort, SolarRadiationPort[4]) annotation (
       Line(
        points={{48,83.2},{48,88},{-86,88},{-86,64},{-110,64}},
        color={255,128,0}));
    connect(outerWall_North.SolarRadiationPort, SolarRadiationPort[1])
      annotation (Line(
        points={{76.1,40.6667},{82,40.6667},{82,-80},{-86,-80},{-86,52},{-110,
          52}},
        color={255,128,0}));

    connect(outerWall_East.SolarRadiationPort, SolarRadiationPort[2]) annotation (
       Line(
        points={{4,-73.2},{4,-80},{-86,-80},{-86,56},{-110,56}},
        color={255,128,0}));

  connect(thermOutside, ceiling.port_outside) annotation (Line(points={{-100,
          100},{-68,100},{-68,88},{-32,88},{-32,80.1}}, color={191,0,0}));
  connect(thermOutside, outerWall_West.port_outside) annotation (Line(points={{
          -100,100},{-68,100},{-68,88},{26,88},{26,82.2}}, color={191,0,0}));
  connect(thermOutside, outerWall_North.port_outside) annotation (Line(points={
          {-100,100},{-68,100},{-68,88},{82,88},{82,4},{74.35,4}}, color={191,0,
          0}));
  connect(thermOutside, outerWall_East.port_outside) annotation (Line(points={{-100,
          100},{-68,100},{-68,88},{82,88},{82,-80},{26,-80},{26,-72.2}},
        color={191,0,0}));
  connect(thermOutside, outerWall_South.port_outside) annotation (Line(points={
          {-100,100},{-68,100},{-68,88},{82,88},{82,-80},{-86,-80},{-86,4},{
          -76.35,4}}, color={191,0,0}));
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
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{46,-56},{46,60},{26,60},
          {26,74}}, color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, ceiling.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-6,-8},{-6,-56},{46,-56},{46,60},{-32,60},
          {-32,76}}, color={191,0,0}));
  connect(solarRadInRoom.floors[1], floor.shortRadWall) annotation (Line(points={{-29,48},
          {-24,48},{-24,58},{-54,58},{-54,-56},{-40,-56},{-40,-60},{-39.9,-60},
          {-39.9,-62}},
                   color={0,0,0}));
  connect(solarRadInRoom.ceilings[1], ceiling.shortRadWall) annotation (Line(
        points={{-29,44},{-24,44},{-24,60},{-24.1,60},{-24.1,76}},       color=
          {0,0,0}));
  connect(solarRadInRoom.win_in[1], outerWall_West.shortRadWin) annotation (
      Line(points={{-51,45.5},{-52,45.5},{-52,58},{14,58},{14,74.2},{14.2,74.2}},
                                                        color={0,0,0}));
  connect(solarRadInRoom.win_in[2], outerWall_East.shortRadWin) annotation (
      Line(points={{-51,46.5},{-52,46.5},{-52,58},{44,58},{44,-54},{38,-54},{38,-64.2},{37.8,-64.2}},
                                                                          color=
         {0,0,0}));
  connect(outerWall_East.shortRadWall, solarRadInRoom.walls[1]) annotation (Line(points={{10.2,
          -64},{12,-64},{12,-54},{44,-54},{44,51.25},{-29,51.25}},
                                            color={0,0,0}));
  connect(outerWall_South.shortRadWall, solarRadInRoom.walls[2]) annotation (Line(points={{-62,
          30.3333},{-58,30.3333},{-58,30},{-54,30},{-54,58},{-12,58},{-12,51.75},
          {-29,51.75}},                                                 color={0,0,0}));
  connect(outerWall_West.shortRadWall, solarRadInRoom.walls[3])
    annotation (Line(points={{41.8,74},{42,74},{42,52.25},{-29,52.25}}, color={0,0,0}));
  connect(outerWall_North.shortRadWall, solarRadInRoom.walls[4]) annotation (Line(points={{60,
          30.3333},{54,30.3333},{54,30},{44,30},{44,52.75},{-29,52.75}},
                                                   color={0,0,0}));
    annotation ( Icon(coordinateSystem(extent={{-100,-100},
              {100,100}}, preserveAspectRatio=false),
                                        graphics={
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
            rotation=90)}),
      Documentation(revisions="<html>
 <ul>
 <li><i>March 9, 2015</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>",  info="<html>
</html>"));
end EastWestFacingWindows;
