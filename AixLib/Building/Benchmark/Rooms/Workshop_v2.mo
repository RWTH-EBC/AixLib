within AixLib.Building.Benchmark.Rooms;
model Workshop_v2
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";
  Components.Walls.Wall NorthWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    windowarea=60,
    withSunblind=false,
    withDoor=false,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    wall_length=30,
    T0(displayUnit="degC") = 288.15)
               annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=-90,
        origin={-52,60})));
  Components.Walls.Wall SouthWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    windowarea=60,
    withSunblind=false,
    withDoor=false,
    wall_length=30,
    T0=288.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=90,
        origin={-52,-62})));
  Components.Walls.Wall WestWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    withSunblind=false,
    withDoor=false,
    wall_length=30,
    windowarea=60,
    T0=288.15) annotation (Placement(transformation(
        extent={{3.99999,-24},{-4.00002,24}},
        rotation=180,
        origin={-80,0})));
  Components.Walls.Wall WestWallToCanteen(
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
    wall_length=30,
    withDoor=false,
    T0=288.15) annotation (Placement(transformation(
        extent={{3.99999,-24},{-4.00002,24}},
        rotation=0,
        origin={72,-10})));
  Components.Walls.Wall FloorToGround(
    solar_absorptance=0.48,
    withWindow=true,
    redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    windowarea=60,
    withSunblind=false,
    withDoor=false,
    outside=false,
    wall_length=30,
    ISOrientation=2,
    WallType=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    wall_height=30,
    T0=288.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=90,
        origin={28,-62})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation = 90, origin = {-20, -26})));
  Components.Walls.ActiveWallPipeBased activeWallPipeBased(
    wall_height=30,
    withDoor=false,
    ISOrientation=3,
    wall_length=30,
    outside=true,
    WallType=DataBase.Walls.EnEV2009.Ceiling.CE_RO_EnEV2009_SM_TBA(),
    withWindow=false,
    solar_absorptance=0.24,
    T0=288.15)
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
    V=2700,
    p_start=100000,
    T_start=288.15)
    annotation (Placement(transformation(extent={{6,-12},{26,8}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToGround
    annotation (Placement(transformation(extent={{18,-110},{38,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToCanteen
    annotation (Placement(transformation(extent={{90,-42},{110,-22}})));
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
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_WestWall annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,-32})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_SouthWall annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-24,-110})));
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
  Modelica.Blocks.Interfaces.RealInput mWat_Workshop
    "Water flow rate added into the medium"
    annotation (Placement(transformation(extent={{-116,80},{-92,104}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a AddPower_Workshop
    annotation (Placement(transformation(extent={{-110,60},{-90,80}})));
  BusSystem.Bus_measure measureBus
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{8,14},{28,34}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature1
                          annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-52,90})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature2
                          annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-92,32})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=-90,
        origin={-52,-88})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_Roof annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={40,104})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_Roof annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={70,110})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature3
                          annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={20,88})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1
    annotation (Placement(transformation(extent={{10,-46},{30,-26}})));
equation
  connect(FloorToGround.port_outside, HeatPort_ToGround)
    annotation (Line(points={{28,-66.2},{28,-100}}, color={191,0,0}));
  connect(SouthWall.WindSpeedPort,WindSpeedPort_SouthWall)  annotation (Line(
        points={{-69.6,-66.2},{-69.6,-80},{-82,-80},{-82,-106}}, color={0,0,127}));
  connect(WestWall.WindSpeedPort,WindSpeedPort_WestWall)  annotation (Line(
        points={{-84.2,-17.6},{-88,-17.6},{-88,-18},{-90,-18},{-90,0},{-116,0}},
                                                                 color={0,0,127}));
  connect(NorthWall.SolarRadiationPort,SolarRadiationPort_NorthWall)
    annotation (Line(points={{-30,65.2},{-30,80},{10,80},{10,110}}, color={255,
          128,0}));
  connect(WestWall.SolarRadiationPort,SolarRadiationPort_WestWall)  annotation (
     Line(points={{-85.2,-22},{-90,-22},{-90,-32},{-110,-32}},
                                                           color={255,128,0}));
  connect(SouthWall.SolarRadiationPort,SolarRadiationPort_SouthWall)
    annotation (Line(points={{-74,-67.2},{-74,-80},{-24,-80},{-24,-110}}, color=
         {255,128,0}));
  connect(SouthWall.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{-52,-58},{-52,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(FloorToGround.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{28,-58},{28,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(NorthWall.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{-52,56},{-52,48},{-60,48},{-60,-52},{-20.1,-52},{
          -20.1,-35.4}}, color={191,0,0}));
  connect(WestWall.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{-76,4.44089e-016},{-68,4.44089e-016},{-68,0},{-60,
          0},{-60,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(NorthWall.WindSpeedPort,WindSpeedPort_NorthWall)  annotation (Line(
        points={{-34.4,64.2},{-34.4,80},{-20,80},{-20,104}}, color={0,0,127}));
  connect(activeWallPipeBased.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{20,56},{20,48},{-60,48},{-60,-52},{-20.1,-52},{
          -20.1,-35.4}}, color={191,0,0}));
  connect(activeWallPipeBased.Heatport_TBA,Heatport_TBA)  annotation (Line(
        points={{37.6,55.8},{37.6,48},{100,48}}, color={191,0,0}));
  connect(Air_in,vol. ports[1]) annotation (Line(points={{100,6},{80,6},{80,28},
          {40,28},{40,-20},{14,-20},{14,-12}}, color={0,127,255}));
  connect(Air_out,vol. ports[2]) annotation (Line(points={{100,28},{40,28},{40,
          -20},{18,-20},{18,-12}}, color={0,127,255}));
  connect(vol.heatPort,thermStar_Demux. therm) annotation (Line(points={{6,-2},
          {-25.1,-2},{-25.1,-15.9}}, color={191,0,0}));
  connect(vol.mWat_flow, mWat_Workshop) annotation (Line(points={{4,6},{-20,6},
          {-20,80},{-90,80},{-90,92},{-104,92}}, color={0,0,127}));
  connect(thermStar_Demux.therm, AddPower_Workshop) annotation (Line(points={{
          -25.1,-15.9},{-25.1,80},{-24,80},{-24,80},{-90,80},{-90,70},{-100,70}},
        color={191,0,0}));
  connect(WestWallToCanteen.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{68,-10},{60,-10},{60,-52},{-20.1,-52},{-20.1,
          -35.4}}, color={191,0,0}));
  connect(HeatPort_ToCanteen, WestWallToCanteen.port_outside) annotation (Line(
        points={{100,-32},{88,-32},{88,-10},{76.2,-10}}, color={191,0,0}));
  connect(temperatureSensor.T, measureBus.RoomTemp_Workshop) annotation (Line(
        points={{28,24},{40,24},{40,-52},{-90,-52},{-90,-59.9},{-99.9,-59.9}},
                   color={0,0,127}));
  connect(vol.X_w, measureBus.X_Workshop) annotation (Line(points={{28,-6},{40,
          -6},{40,-52},{-80,-52},{-90,-52},{-90,-59.9},{-99.9,-59.9}}, color={0,
          0,127}));
  connect(temperatureSensor.port, thermStar_Demux.therm) annotation (Line(
        points={{8,24},{-6,24},{-6,-2},{-25.1,-2},{-25.1,-15.9}}, color={191,0,
          0}));
  connect(prescribedTemperature1.port, NorthWall.port_outside)
    annotation (Line(points={{-52,84},{-52,64.2}}, color={191,0,0}));
  connect(prescribedTemperature2.port, WestWall.port_outside) annotation (Line(
        points={{-86,32},{-86,16},{-86,0},{-84.2,0}}, color={191,0,0}));
  connect(prescribedTemperature.port, SouthWall.port_outside)
    annotation (Line(points={{-52,-82},{-52,-66.2}}, color={191,0,0}));
  connect(prescribedTemperature.T, measureBus.AirTemp) annotation (Line(points=
          {{-52,-95.2},{-52,-98},{-24,-98},{-24,-52},{-60,-52},{-60,-60},{-80,
          -60},{-80,-59.9},{-99.9,-59.9}}, color={0,0,127}));
  connect(prescribedTemperature2.T, measureBus.AirTemp) annotation (Line(points=
         {{-99.2,32},{-104,32},{-104,48},{-60,48},{-60,-59.9},{-99.9,-59.9}},
        color={0,0,127}));
  connect(prescribedTemperature1.T, measureBus.AirTemp) annotation (Line(points=
         {{-52,97.2},{-52,102},{-80,102},{-80,48},{-60,48},{-60,-59.9},{-99.9,
          -59.9}}, color={0,0,127}));
  connect(activeWallPipeBased.WindSpeedPort, WindSpeedPort_Roof) annotation (
      Line(points={{37.6,64.2},{37.6,80.1},{40,80.1},{40,104}}, color={0,0,127}));
  connect(SolarRadiationPort_Roof, activeWallPipeBased.SolarRadiationPort)
    annotation (Line(points={{70,110},{70,80},{42,80},{42,65.2}}, color={255,
          128,0}));
  connect(prescribedTemperature3.port, activeWallPipeBased.port_outside)
    annotation (Line(points={{20,82},{20,64.2}}, color={191,0,0}));
  connect(prescribedTemperature3.T, measureBus.AirTemp) annotation (Line(points=
         {{20,95.2},{20,98},{10,98},{10,80},{-20,80},{-20,48},{-60,48},{-60,
          -59.9},{-99.9,-59.9}}, color={0,0,127}));
  connect(temperatureSensor1.port, thermStar_Demux.star) annotation (Line(
        points={{10,-36},{-2,-36},{-2,-34},{-2,-34},{-2,-15.6},{-14.2,-15.6}},
        color={191,0,0}));
  connect(temperatureSensor1.T, measureBus.StrahlungTemp_Workshop) annotation (
      Line(points={{30,-36},{40,-36},{40,-52},{-60,-52},{-60,-59.9},{-99.9,
          -59.9}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Workshop_v2;
