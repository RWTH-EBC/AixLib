within AixLib.Building.Benchmark.Rooms;
model ConferenceRoom_v2
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";
  Components.Walls.Wall FloorToWorkshop(
    solar_absorptance=0.48,
    withWindow=true,
    redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    windowarea=60,
    withSunblind=false,
    withDoor=false,
    outside=false,
    ISOrientation=2,
    wall_length=10,
    wall_height=5,
    WallType=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=90,
        origin={-32,-62})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation = 90, origin = {-20, -26})));
  Components.Walls.ActiveWallPipeBased activeWallPipeBased(
    withDoor=false,
    ISOrientation=3,
    outside=true,
    wall_length=5,
    wall_height=10,
    WallType=DataBase.Walls.EnEV2009.Ceiling.CE_RO_EnEV2009_SM_TBA())
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
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToGround
    annotation (Placement(transformation(extent={{-42,-110},{-22,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToOpenPlanOffice
    annotation (Placement(transformation(extent={{20,-110},{40,-90}})));
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
  Components.Walls.Wall NorthWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    withSunblind=false,
    withDoor=false,
    wall_length=10,
    windowarea=20,
    T0=293.15) annotation (Placement(transformation(
        extent={{3.99999,-24},{-4.00002,24}},
        rotation=90,
        origin={-60,60})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_NorthWall annotation (
      Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=90,
        origin={-40,106})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_NorthWall annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={10,110})));
  Components.Walls.Wall WestWallToOpenPlanOffice(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    windowarea=60,
    withSunblind=false,
    outside=false,
    door_height=2.125,
    door_width=1,
    WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
    wall_length=20,
    withDoor=false,
    T0=293.15) annotation (Placement(transformation(
        extent={{3.99999,-24},{-4.00002,24}},
        rotation=-90,
        origin={30,-62})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{8,12},{28,32}})));
  BusSystem.Bus_measure measureBus
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature2
                          annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-60,88})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature1
                          annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={4,88})));
equation
  connect(FloorToWorkshop.port_outside, HeatPort_ToGround) annotation (Line(
        points={{-32,-66.2},{-32,-76},{-32,-76},{-32,-84},{-32,-84},{-32,-100}},
        color={191,0,0}));
  connect(FloorToWorkshop.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{-32,-58},{-32,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(activeWallPipeBased.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{4,56},{4,48},{-60,48},{-60,-52},{-20.1,-52},{
          -20.1,-35.4}}, color={191,0,0}));
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
    annotation (Line(points={{30,-66.2},{30,-66.2},{30,-98},{30,-98},{30,-100},
          {30,-100}},                               color={191,0,0}));
  connect(WestWallToOpenPlanOffice.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{30,-58},{30,-52},{-20.1,-52},{-20.1,-35.4}},
                   color={191,0,0}));
  connect(NorthWall.SolarRadiationPort, SolarRadiationPort_NorthWall)
    annotation (Line(points={{-82,65.2},{-82,66},{-82,66},{-82,64},{-82,80},{10,
          80},{10,110},{10,110}}, color={255,128,0}));
  connect(NorthWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-60,56},{-60,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(temperatureSensor.port, thermStar_Demux.therm) annotation (Line(
        points={{8,22},{0,22},{0,-2},{-25.1,-2},{-25.1,-15.9}}, color={191,0,0}));
  connect(temperatureSensor.T, measureBus.RoomTemp_Conferenceroom) annotation (
      Line(points={{28,22},{40,22},{40,-52},{-80,-52},{-80,-52},{-90,-52},{-90,
          -59.9},{-99.9,-59.9}}, color={0,0,127}));
  connect(vol.X_w, measureBus.X_Conferenceroom) annotation (Line(points={{28,-6},
          {40,-6},{40,-52},{-80,-52},{-90,-52},{-90,-59.9},{-99.9,-59.9}},
        color={0,0,127}));
  connect(prescribedTemperature2.port, NorthWall.port_outside)
    annotation (Line(points={{-60,82},{-60,64.2}}, color={191,0,0}));
  connect(prescribedTemperature1.port, activeWallPipeBased.port_outside)
    annotation (Line(points={{4,82},{4,64.2}}, color={191,0,0}));
  connect(prescribedTemperature1.T, measureBus.AirTemp) annotation (Line(points=
         {{4,95.2},{4,100},{-20,100},{-20,48},{-60,48},{-60,-59.9},{-99.9,-59.9}},
        color={0,0,127}));
  connect(prescribedTemperature2.T, measureBus.AirTemp) annotation (Line(points={{-60,
          95.2},{-86,95.2},{-86,48},{-60,48},{-60,-59.9},{-99.9,-59.9}},
        color={0,0,127}));
  connect(NorthWall.WindSpeedPort, WindSpeedPort_NorthWall) annotation (Line(
        points={{-77.6,64.2},{-77.6,80},{-40,80},{-40,106}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-4,46},{44,36}},
          lineColor={28,108,200},
          textString="Solar absorptance ist noch nicht richtig,
gucken wie das mit PV Anlage ist
")}));
end ConferenceRoom_v2;
