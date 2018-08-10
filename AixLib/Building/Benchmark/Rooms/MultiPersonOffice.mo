within AixLib.Building.Benchmark.Rooms;
model MultiPersonOffice
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";
  Components.Walls.Wall NorthWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    withSunblind=false,
    withDoor=false,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    T0(displayUnit="degC") = 293.15,
    wall_length=5,
    windowarea=7.5)
               annotation (Placement(transformation(
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
    wall_length=20,
    wall_height=5,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=90,
        origin={-28,-62})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation = 90, origin = {-20, -26})));
  Components.Walls.ActiveWallPipeBased activeWallPipeBased(
    withDoor=false,
    ISOrientation=3,
    outside=true,
    wall_length=20,
    wall_height=5,
    WallType=DataBase.Walls.EnEV2009.Ceiling.CE_RO_EnEV2009_SM_TBA())
    annotation (Placement(transformation(
        extent={{-4,-24},{4,24}},
        rotation=-90,
        origin={20,60})));
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
    V=300)
    annotation (Placement(transformation(extent={{6,-12},{26,8}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToWorkshop
    annotation (Placement(transformation(extent={{-38,-110},{-18,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToConferenceRoom
    annotation (Placement(transformation(extent={{16,-110},{36,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_OutdoorTemp
    annotation (Placement(transformation(extent={{-62,90},{-42,110}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_WestWall annotation (
      Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=180,
        origin={-116,0})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_NorthWall annotation (
      Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={-20,104})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_NorthWall annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={10,110})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_WestWall annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,-32})));
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
  Modelica.Blocks.Interfaces.RealInput mWat_MultiPersonOffice
    "Water flow rate added into the medium"
    annotation (Placement(transformation(extent={{-116,80},{-92,104}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a AddPower_MultiPersonOffice
    annotation (Placement(transformation(extent={{-110,60},{-90,80}})));
  Components.Walls.Wall WestWallToConferenceRoom(
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
        rotation=90,
        origin={26,-62})));
  Components.Walls.Wall WestWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    withSunblind=false,
    withDoor=false,
    wall_length=20,
    windowarea=30,
    T0=293.15) annotation (Placement(transformation(
        extent={{3.99999,-24},{-4.00002,24}},
        rotation=180,
        origin={-76,0})));
  Components.Walls.Wall EastWallToOpenPlanOffice(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    windowarea=60,
    withSunblind=false,
    outside=false,
    wall_length=20,
    withDoor=true,
    door_height=2.125,
    door_width=1,
    WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
    T0=293.15) annotation (Placement(transformation(
        extent={{3.99999,-24},{-4.00002,24}},
        rotation=0,
        origin={70,-6})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToOpenPlanOffice
    annotation (Placement(transformation(extent={{90,-16},{110,4}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{8,12},{28,32}})));
  BusSystem.measureBus measureBus
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
equation
  connect(FloorToWorkshop.port_outside,HeatPort_ToWorkshop)
    annotation (Line(points={{-28,-66.2},{-28,-100}},
                                                    color={191,0,0}));
  connect(NorthWall.port_outside,HeatPort_OutdoorTemp)
    annotation (Line(points={{-52,64.2},{-52,100}}, color={191,0,0}));
  connect(NorthWall.SolarRadiationPort,SolarRadiationPort_NorthWall)
    annotation (Line(points={{-30,65.2},{-30,80},{10,80},{10,110}}, color={255,
          128,0}));
  connect(FloorToWorkshop.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{-28,-58},{-28,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(NorthWall.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{-52,56},{-52,48},{-60,48},{-60,-52},{-20.1,-52},{
          -20.1,-35.4}}, color={191,0,0}));
  connect(NorthWall.WindSpeedPort,WindSpeedPort_NorthWall)  annotation (Line(
        points={{-34.4,64.2},{-34.4,80},{-20,80},{-20,104}}, color={0,0,127}));
  connect(activeWallPipeBased.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{20,56},{20,48},{-60,48},{-60,-52},{-20.1,-52},{
          -20.1,-35.4}}, color={191,0,0}));
  connect(activeWallPipeBased.port_outside,HeatPort_OutdoorTemp)  annotation (
      Line(points={{20,64.2},{20,80},{-52,80},{-52,100}}, color={191,0,0}));
  connect(WindSpeedPort_Roof,activeWallPipeBased. WindSpeedPort) annotation (
      Line(points={{40,104},{40,80},{37.6,80},{37.6,64.2}}, color={0,0,127}));
  connect(activeWallPipeBased.SolarRadiationPort,SolarRadiationPort_Hor)
    annotation (Line(points={{42,65.2},{42,70},{70,70},{70,110}}, color={255,
          128,0}));
  connect(activeWallPipeBased.Heatport_TBA,Heatport_TBA)  annotation (Line(
        points={{37.6,55.8},{37.6,48},{100,48}}, color={191,0,0}));
  connect(Air_in,vol. ports[1]) annotation (Line(points={{100,6},{80,6},{80,28},
          {40,28},{40,-20},{14,-20},{14,-12}}, color={0,127,255}));
  connect(Air_out,vol. ports[2]) annotation (Line(points={{100,28},{40,28},{40,
          -20},{18,-20},{18,-12}}, color={0,127,255}));
  connect(vol.heatPort,thermStar_Demux. therm) annotation (Line(points={{6,-2},
          {-25.1,-2},{-25.1,-15.9}}, color={191,0,0}));
  connect(vol.mWat_flow, mWat_MultiPersonOffice) annotation (Line(points={{4,6},
          {-20,6},{-20,80},{-90,80},{-90,92},{-104,92}}, color={0,0,127}));
  connect(thermStar_Demux.therm, AddPower_MultiPersonOffice) annotation (Line(
        points={{-25.1,-15.9},{-25.1,70},{-100,70}}, color={191,0,0}));
  connect(WestWallToConferenceRoom.port_outside, HeatPort_ToConferenceRoom)
    annotation (Line(points={{26,-66.2},{26,-100}}, color={191,0,0}));
  connect(WestWallToConferenceRoom.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{26,-58},{26,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(EastWallToOpenPlanOffice.port_outside, HeatPort_ToOpenPlanOffice)
    annotation (Line(points={{74.2,-6},{100,-6}}, color={191,0,0}));
  connect(EastWallToOpenPlanOffice.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{66,-6},{64,-6},{64,-8},{60,-8},{60,-52},{-20.1,
          -52},{-20.1,-35.4}}, color={191,0,0}));
  connect(WestWall.port_outside, HeatPort_OutdoorTemp) annotation (Line(points=
          {{-80.2,4.44089e-016},{-86,4.44089e-016},{-86,0},{-90,0},{-90,80},{
          -52,80},{-52,100}}, color={191,0,0}));
  connect(WestWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-72,0},{-60,0},{-60,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(WestWall.WindSpeedPort, WindSpeedPort_WestWall) annotation (Line(
        points={{-80.2,-17.6},{-90,-17.6},{-90,0},{-116,0}}, color={0,0,127}));
  connect(WestWall.SolarRadiationPort, SolarRadiationPort_WestWall) annotation (
     Line(points={{-81.2,-22},{-90,-22},{-90,-32},{-110,-32}}, color={255,128,0}));
  connect(temperatureSensor.T, measureBus.RoomTemp_Multipersonoffice)
    annotation (Line(points={{28,22},{40,22},{40,-52},{-74,-52},{-86,-52},{-86,
          -59.9},{-99.9,-59.9}}, color={0,0,127}));
  connect(vol.X_w, measureBus.X_Multipersonoffice) annotation (Line(points={{28,
          -6},{40,-6},{40,-52},{-74,-52},{-86,-52},{-86,-59.9},{-99.9,-59.9}},
        color={0,0,127}));
  connect(temperatureSensor.port, thermStar_Demux.therm) annotation (Line(
        points={{8,22},{-4,22},{-4,-2},{-25.1,-2},{-25.1,-15.9}}, color={191,0,
          0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-4,46},{44,36}},
          lineColor={28,108,200},
          textString="Solar absorptance ist noch nicht richtig,
gucken wie das mit PV Anlage ist
")}));
end MultiPersonOffice;
