within AixLib.Building.Benchmark.Rooms;
model ConferenceRoom
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";
  Components.Walls.Wall SouthWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    withSunblind=false,
    withDoor=false,
    wall_length=5,
    windowarea=7.5,
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
    withDoor=true,
    door_height=2.125,
    door_width=1,
    WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
    wall_length=5,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=-90,
        origin={-52,60})));
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
    ISOrientation=2,
    wall_length=10,
    wall_height=5,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=90,
        origin={14,-62})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation = 90, origin = {-20, -26})));
  Components.Walls.ActiveWallPipeBased activeWallPipeBased(
    withDoor=false,
    ISOrientation=3,
    outside=true,
    WallType=DataBase.Walls.EnEV2009.Ceiling.CE_RO_EnEV2009_SM_loHalf_TBA(),
    wall_length=5,
    wall_height=10)
    annotation (Placement(transformation(
        extent={{-4,-24},{4,24}},
        rotation=-90,
        origin={4,60})));
  Fluid.MixingVolumes.MixingVolumeMoistAir vol(
                                     nPorts=2,
    m_flow_nominal=10,
    m_flow_small=0.001,
    allowFlowReversal=true,
    X_start={0.01,0.99},
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    redeclare package Medium = Medium_Air,
    p_start=100000,
    T_start=293.15,
    V=150)
    annotation (Placement(transformation(extent={{6,-12},{26,8}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToWorkshop
    annotation (Placement(transformation(extent={{4,-110},{24,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToOpenPlanOffice
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    HeatPort_ToMultiPersonOffice
    annotation (Placement(transformation(extent={{-38,90},{-18,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_OutdoorTemp
    annotation (Placement(transformation(extent={{-62,90},{-42,110}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_SouthWall annotation (
      Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=-90,
        origin={-82,-106})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_SouthWall annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-24,-110})));
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
  Modelica.Fluid.Interfaces.FluidPort_a Air_in(redeclare package Medium =
        Medium_Air)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-4},{110,16}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package Medium =
        Medium_Air)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,18},{110,38}})));
  Modelica.Blocks.Interfaces.RealInput mWat_ConferenceRoom
    "Water flow rate added into the medium"
    annotation (Placement(transformation(extent={{-116,80},{-92,104}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a AddPower_ConferenceRoom
    annotation (Placement(transformation(extent={{-110,60},{-90,80}})));
  Components.Walls.Wall EastWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    withSunblind=false,
    withDoor=false,
    wall_length=10,
    windowarea=15,
    T0=293.15) annotation (Placement(transformation(
        extent={{3.99999,-24},{-4.00002,24}},
        rotation=180,
        origin={-78,-12})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_WestWall annotation (
      Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=180,
        origin={-116,0})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_WestWall annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,-32})));
  Components.Walls.Wall WestWallToOpenPlanOffice(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    windowarea=60,
    withSunblind=false,
    outside=false,
    withDoor=true,
    door_height=2.125,
    door_width=1,
    wall_length=10,
    WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
    T0=293.15) annotation (Placement(transformation(
        extent={{3.99999,-24},{-4.00002,24}},
        rotation=0,
        origin={74,-20})));
equation
  connect(FloorToWorkshop.port_outside,HeatPort_ToWorkshop)
    annotation (Line(points={{14,-66.2},{14,-100}}, color={191,0,0}));
  connect(WestWallToMultiPersonOffice.port_outside,HeatPort_ToMultiPersonOffice)
    annotation (Line(points={{-52,64.2},{-52,80},{-28,80},{-28,100},{-28,100}},
                                                    color={191,0,0}));
  connect(SouthWall.WindSpeedPort,WindSpeedPort_SouthWall)  annotation (Line(
        points={{-69.6,-66.2},{-69.6,-80},{-82,-80},{-82,-106}}, color={0,0,127}));
  connect(SouthWall.SolarRadiationPort,SolarRadiationPort_SouthWall)
    annotation (Line(points={{-74,-67.2},{-74,-80},{-24,-80},{-24,-110}}, color=
         {255,128,0}));
  connect(SouthWall.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{-52,-58},{-52,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(FloorToWorkshop.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{14,-58},{14,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(WestWallToMultiPersonOffice.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{-52,56},{-52,48},{-60,48},{-60,-52},{-20.1,-52},{
          -20.1,-35.4}},
                   color={191,0,0}));
  connect(SouthWall.port_outside,HeatPort_OutdoorTemp)  annotation (Line(points=
         {{-52,-66.2},{-52,-80},{-90,-80},{-90,80},{-52,80},{-52,100}}, color={
          191,0,0}));
  connect(activeWallPipeBased.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{4,56},{4,48},{-60,48},{-60,-52},{-20.1,-52},{
          -20.1,-35.4}}, color={191,0,0}));
  connect(activeWallPipeBased.port_outside,HeatPort_OutdoorTemp)  annotation (
      Line(points={{4,64.2},{4,80},{-52,80},{-52,100}},   color={191,0,0}));
  connect(WindSpeedPort_Roof,activeWallPipeBased. WindSpeedPort) annotation (
      Line(points={{40,104},{40,80},{21.6,80},{21.6,64.2}}, color={0,0,127}));
  connect(activeWallPipeBased.SolarRadiationPort,SolarRadiationPort_Hor)
    annotation (Line(points={{26,65.2},{26,80},{70,80},{70,110}}, color={255,
          128,0}));
  connect(activeWallPipeBased.Heatport_TBA,Heatport_TBA)  annotation (Line(
        points={{21.6,55.8},{21.6,48},{100,48}}, color={191,0,0}));
  connect(Air_in,vol. ports[1]) annotation (Line(points={{100,6},{80,6},{80,28},
          {40,28},{40,-20},{14,-20},{14,-12}}, color={0,127,255}));
  connect(Air_out,vol. ports[2]) annotation (Line(points={{100,28},{40,28},{40,
          -20},{18,-20},{18,-12}}, color={0,127,255}));
  connect(vol.heatPort,thermStar_Demux. therm) annotation (Line(points={{6,-2},
          {-25.1,-2},{-25.1,-15.9}}, color={191,0,0}));
  connect(vol.mWat_flow, mWat_ConferenceRoom) annotation (Line(points={{4,6},{
          -20,6},{-20,80},{-90,80},{-90,92},{-104,92}}, color={0,0,127}));
  connect(thermStar_Demux.therm, AddPower_ConferenceRoom) annotation (Line(
        points={{-25.1,-15.9},{-25.1,80},{-26,80},{-26,80},{-90,80},{-90,70},{
          -100,70}}, color={191,0,0}));
  connect(WestWallToOpenPlanOffice.port_outside, HeatPort_ToOpenPlanOffice)
    annotation (Line(points={{78.2,-20},{100,-20}}, color={191,0,0}));
  connect(WestWallToOpenPlanOffice.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{70,-20},{60,-20},{60,-52},{-20.1,-52},{-20.1,
          -35.4}}, color={191,0,0}));
  connect(EastWall.SolarRadiationPort, SolarRadiationPort_WestWall) annotation (
     Line(points={{-83.2,-34},{-90,-34},{-90,-32},{-110,-32}}, color={255,128,0}));
  connect(EastWall.WindSpeedPort, WindSpeedPort_WestWall) annotation (Line(
        points={{-82.2,-29.6},{-90,-29.6},{-90,0},{-116,0}}, color={0,0,127}));
  connect(EastWall.port_outside, HeatPort_OutdoorTemp) annotation (Line(points=
          {{-82.2,-12},{-90,-12},{-90,80},{-52,80},{-52,100}}, color={191,0,0}));
  connect(EastWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-74,-12},{-60,-12},{-60,-52},{-20.1,-52},{-20.1,
          -35.4}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-4,46},{44,36}},
          lineColor={28,108,200},
          textString="Solar absorptance ist noch nicht richtig,
gucken wie das mit PV Anlage ist
")}));
end ConferenceRoom;
