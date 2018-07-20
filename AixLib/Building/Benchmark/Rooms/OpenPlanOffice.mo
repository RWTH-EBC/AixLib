within AixLib.Building.Benchmark.Rooms;
model OpenPlanOffice
replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";

  Components.Walls.Wall NorthWall(
    wall_length=40,
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    windowarea=60,
    withSunblind=false,
    withDoor=false,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    T0(displayUnit="degC") = 293.15)
               annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=-90,
        origin={-52,60})));
  Components.Walls.Wall SouthWall(
    wall_length=40,
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    windowarea=60,
    withSunblind=false,
    withDoor=false,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=90,
        origin={-52,-62})));
  Components.Walls.Wall WestWallToMultiPersonOffice(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    windowarea=60,
    withSunblind=false,
    outside=false,
    WallType=DataBase.Walls.EnEV2009.IW.IWneighbour_EnEV2009_S_half(),
    wall_length=20,
    withDoor=true,
    door_height=2.125,
    door_width=1,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=0,
        origin={-76,28})));
  Components.Walls.Wall EastWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    withSunblind=false,
    withDoor=false,
    wall_length=30,
    windowarea=45,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=180,
        origin={60,0})));
  Components.Walls.Wall WestWallToConferenceRoom(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    windowarea=60,
    withSunblind=false,
    outside=false,
    WallType=DataBase.Walls.EnEV2009.IW.IWneighbour_EnEV2009_S_half(),
    withDoor=true,
    door_height=2.125,
    door_width=1,
    wall_length=10,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=0,
        origin={-76,-28})));
  Components.Walls.Wall FloorToWorkshop(
    solar_absorptance=0.48,
    withWindow=true,
    redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    windowarea=60,
    withSunblind=false,
    withDoor=false,
    outside=false,
    WallType=DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf(),
    wall_length=30,
    wall_height=20,
    ISOrientation=2,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=90,
        origin={14,-62})));
  Components.Walls.Wall FloorToKitchen1(
    solar_absorptance=0.48,
    withWindow=true,
    redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    windowarea=60,
    withSunblind=false,
    withDoor=false,
    outside=false,
    WallType=DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf(),
    wall_length=30,
    wall_height=20,
    ISOrientation=2,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=90,
        origin={70,-62})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToKitchen
    annotation (Placement(transformation(extent={{60,-110},{80,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToWorkshop
    annotation (Placement(transformation(extent={{4,-110},{24,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToConferenceRoom
    annotation (Placement(transformation(extent={{-110,-38},{-90,-18}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    HeatPort_ToMultiPersonOffice
    annotation (Placement(transformation(extent={{-110,18},{-90,38}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_OutdoorTemp
    annotation (Placement(transformation(extent={{-62,90},{-42,110}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_EastWall annotation (
      Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=180,
        origin={104,-18})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_NorthWall annotation (
      Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={-20,104})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_SouthWall annotation (
      Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=-90,
        origin={-82,-106})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_NorthWall annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={10,110})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_EastWall annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-50})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_SouthWall annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-24,-110})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation = 90, origin = {-20, -26})));
  Components.Walls.ActiveWallPipeBased activeWallPipeBased(
    wall_length=40,
    wall_height=30,
    withDoor=false,
    ISOrientation=3,
    outside=true,
    WallType=DataBase.Walls.EnEV2009.Ceiling.CE_RO_EnEV2009_SM_loHalf_TBA())
    annotation (Placement(transformation(
        extent={{-4,-24},{4,24}},
        rotation=-90,
        origin={20,60})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_Roof annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={40,104})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_Hor annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={70,110})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b Heatport_TBA
    annotation (Placement(transformation(extent={{90,38},{110,58}})));
  Fluid.MixingVolumes.MixingVolumeMoistAir vol(
                                     nPorts=2,
    m_flow_nominal=10,
    V=3600,
    m_flow_small=0.001,
    allowFlowReversal=true,
    X_start={0.01,0.99},
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    redeclare package Medium = Medium_Air,
    p_start=100000,
    T_start=293.15)
    annotation (Placement(transformation(extent={{6,-12},{26,8}})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in(redeclare package Medium =
        Medium_Air)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-4},{110,16}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package Medium =
        Medium_Air)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,18},{110,38}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=0)
    annotation (Placement(transformation(extent={{-46,-2},{-26,18}})));
equation
  connect(FloorToKitchen1.port_outside, HeatPort_ToKitchen)
    annotation (Line(points={{70,-66.2},{70,-100}}, color={191,0,0}));
  connect(FloorToWorkshop.port_outside, HeatPort_ToWorkshop)
    annotation (Line(points={{14,-66.2},{14,-100}}, color={191,0,0}));
  connect(WestWallToConferenceRoom.port_outside, HeatPort_ToConferenceRoom)
    annotation (Line(points={{-80.2,-28},{-100,-28}}, color={191,0,0}));
  connect(WestWallToMultiPersonOffice.port_outside,
    HeatPort_ToMultiPersonOffice)
    annotation (Line(points={{-80.2,28},{-100,28}}, color={191,0,0}));
  connect(NorthWall.port_outside, HeatPort_OutdoorTemp)
    annotation (Line(points={{-52,64.2},{-52,100}}, color={191,0,0}));
  connect(SouthWall.WindSpeedPort, WindSpeedPort_SouthWall) annotation (Line(
        points={{-69.6,-66.2},{-69.6,-80},{-82,-80},{-82,-106}}, color={0,0,127}));
  connect(EastWall.WindSpeedPort, WindSpeedPort_EastWall) annotation (Line(
        points={{64.2,-17.6},{81.1,-17.6},{81.1,-18},{104,-18}}, color={0,0,127}));
  connect(NorthWall.SolarRadiationPort, SolarRadiationPort_NorthWall)
    annotation (Line(points={{-30,65.2},{-30,80},{10,80},{10,110}}, color={255,
          128,0}));
  connect(EastWall.SolarRadiationPort, SolarRadiationPort_EastWall) annotation (
     Line(points={{65.2,-22},{80,-22},{80,-50},{110,-50}}, color={255,128,0}));
  connect(SouthWall.SolarRadiationPort, SolarRadiationPort_SouthWall)
    annotation (Line(points={{-74,-67.2},{-74,-80},{-24,-80},{-24,-110}}, color=
         {255,128,0}));
  connect(SouthWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-52,-58},{-52,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(FloorToWorkshop.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{14,-58},{14,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(WestWallToConferenceRoom.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-72,-28},{-60,-28},{-60,-52},{-20.1,-52},{-20.1,
          -35.4}}, color={191,0,0}));
  connect(WestWallToMultiPersonOffice.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-72,28},{-60,28},{-60,-52},{-20.1,-52},{-20.1,
          -35.4}}, color={191,0,0}));
  connect(NorthWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-52,56},{-52,48},{-60,48},{-60,-52},{-20.1,-52},{
          -20.1,-35.4}}, color={191,0,0}));
  connect(FloorToKitchen1.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{70,-58},{70,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(EastWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{56,0},{50,0},{50,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(SouthWall.port_outside, HeatPort_OutdoorTemp) annotation (Line(points=
         {{-52,-66.2},{-52,-80},{-90,-80},{-90,80},{-52,80},{-52,100}}, color={
          191,0,0}));
  connect(EastWall.port_outside, HeatPort_OutdoorTemp) annotation (Line(points=
          {{64.2,0},{80,0},{80,80},{-52,80},{-52,100}}, color={191,0,0}));
  connect(NorthWall.WindSpeedPort, WindSpeedPort_NorthWall) annotation (Line(
        points={{-34.4,64.2},{-34.4,80},{-20,80},{-20,104}}, color={0,0,127}));
  connect(activeWallPipeBased.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{20,56},{20,48},{-60,48},{-60,-52},{-20.1,-52},{
          -20.1,-35.4}}, color={191,0,0}));
  connect(activeWallPipeBased.port_outside, HeatPort_OutdoorTemp) annotation (
      Line(points={{20,64.2},{20,80},{-52,80},{-52,100}}, color={191,0,0}));
  connect(WindSpeedPort_Roof, activeWallPipeBased.WindSpeedPort) annotation (
      Line(points={{40,104},{40,80},{37.6,80},{37.6,64.2}}, color={0,0,127}));
  connect(activeWallPipeBased.SolarRadiationPort, SolarRadiationPort_Hor)
    annotation (Line(points={{42,65.2},{42,70},{70,70},{70,110}}, color={255,
          128,0}));
  connect(activeWallPipeBased.Heatport_TBA, Heatport_TBA) annotation (Line(
        points={{37.6,55.8},{37.6,48},{100,48}}, color={191,0,0}));
  connect(Air_in, vol.ports[1]) annotation (Line(points={{100,6},{80,6},{80,28},
          {40,28},{40,-20},{14,-20},{14,-12}}, color={0,127,255}));
  connect(Air_out, vol.ports[2]) annotation (Line(points={{100,28},{40,28},{40,
          -20},{18,-20},{18,-12}}, color={0,127,255}));
  connect(realExpression.y, vol.mWat_flow)
    annotation (Line(points={{-25,8},{-12,8},{-12,6},{4,6}}, color={0,0,127}));
  connect(vol.heatPort, thermStar_Demux.therm) annotation (Line(points={{6,-2},
          {-25.1,-2},{-25.1,-15.9}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-30,36},{18,26}},
          lineColor={28,108,200},
          textString="Lüftung fehlt komplett"),               Text(
          extent={{-4,46},{44,36}},
          lineColor={28,108,200},
          textString="Solar absorptance ist noch nicht richtig,
gucken wie das mit PV Anlage ist
")}));
end OpenPlanOffice;
