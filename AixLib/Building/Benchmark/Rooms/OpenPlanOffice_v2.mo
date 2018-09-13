within AixLib.Building.Benchmark.Rooms;
model OpenPlanOffice_v2
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
    wall_length=40,
    windowarea=80,
    Model=1)   annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=-90,
        origin={-52,60})));
  Components.Walls.Wall SouthWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    withSunblind=false,
    withDoor=false,
    wall_length=30,
    windowarea=60,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=90,
        origin={-52,-62})));
  Components.Walls.Wall EastWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    withSunblind=false,
    withDoor=false,
    wall_length=30,
    windowarea=60,
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
    door_height=2.125,
    door_width=1,
    WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
    withDoor=false,
    wall_length=20,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=0,
        origin={-76,26})));
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
    wall_height=45,
    WallType=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=90,
        origin={14,-62})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToGround
    annotation (Placement(transformation(extent={{4,-110},{24,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToConferenceRoom
    annotation (Placement(transformation(extent={{-110,16},{-90,36}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    HeatPort_ToMultiPersonOffice
    annotation (Placement(transformation(extent={{60,-110},{80,-90}})));
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
    wall_height=30,
    withDoor=false,
    ISOrientation=3,
    outside=true,
    wall_length=45,
    WallType=DataBase.Walls.EnEV2009.Ceiling.CE_RO_EnEV2009_SM_TBA(),
    solar_absorptance=0.48)
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
    m_flow_small=0.001,
    allowFlowReversal=true,
    X_start={0.01,0.99},
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    redeclare package Medium = Medium_Air,
    p_start=100000,
    T_start=293.15,
    V=4050)
    annotation (Placement(transformation(extent={{6,-12},{26,8}})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in(redeclare package Medium =
        Medium_Air)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-4},{110,16}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package Medium =
        Medium_Air)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,18},{110,38}})));
  Modelica.Blocks.Interfaces.RealInput mWat_OpenPlanOffice
    "Water flow rate added into the medium"
    annotation (Placement(transformation(extent={{-116,80},{-92,104}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a AddPower_OpenPlanOffice
    annotation (Placement(transformation(extent={{-110,60},{-90,80}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{8,12},{28,32}})));
  BusSystem.Bus_measure measureBus
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-52,88})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature1
                          annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={20,88})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature2
                          annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-52,-88})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature3
                          annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={80,0})));
  Components.Walls.Wall WestWallToMultiPersonOffice(
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
    withDoor=false,
    wall_length=30,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=90,
        origin={70,-62})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToCanteen
    annotation (Placement(transformation(extent={{-110,-36},{-90,-16}})));
  Components.Walls.Wall WestWallToConferenceRoom1(
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
    withDoor=false,
    wall_length=30,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=0,
        origin={-76,-26})));
  WallTemp wallTemp2(AngeFactor=0.4328) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-34,38})));
  WallTemp wallTemp(AngeFactor=0.0358)
    annotation (Placement(transformation(extent={{-56,22},{-48,30}})));
  WallTemp wallTemp4(AngeFactor=0.459) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=-90,
        origin={14,-40})));
  WallTemp wallTemp5(AngeFactor=0.013) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={60,-34})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=4, k={1,1,1,1})
    annotation (Placement(transformation(extent={{36,-88},{24,-74}})));
  WallTemp wallTemp6(AngeFactor=0.013)
    annotation (Placement(transformation(extent={{-56,-30},{-48,-22}})));
  WallTemp wallTemp1(AngeFactor=0.0358) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=270,
        origin={70,-46})));
equation
  connect(FloorToGround.port_outside, HeatPort_ToGround)
    annotation (Line(points={{14,-66.2},{14,-100}}, color={191,0,0}));
  connect(WestWallToConferenceRoom.port_outside, HeatPort_ToConferenceRoom)
    annotation (Line(points={{-80.2,26},{-100,26}},   color={191,0,0}));
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
  connect(FloorToGround.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{14,-58},{14,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(WestWallToConferenceRoom.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-72,26},{-60,26},{-60,-52},{-20.1,-52},{-20.1,
          -35.4}}, color={191,0,0}));
  connect(NorthWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-52,56},{-52,48},{-60,48},{-60,-52},{-20.1,-52},{
          -20.1,-35.4}}, color={191,0,0}));
  connect(EastWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{56,0},{50,0},{50,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(NorthWall.WindSpeedPort, WindSpeedPort_NorthWall) annotation (Line(
        points={{-34.4,64.2},{-34.4,80},{-20,80},{-20,104}}, color={0,0,127}));
  connect(activeWallPipeBased.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{20,56},{20,48},{-60,48},{-60,-52},{-20.1,-52},{
          -20.1,-35.4}}, color={191,0,0}));
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
  connect(vol.heatPort, thermStar_Demux.therm) annotation (Line(points={{6,-2},
          {-25.1,-2},{-25.1,-15.9}}, color={191,0,0}));
  connect(vol.mWat_flow, mWat_OpenPlanOffice) annotation (Line(points={{4,6},{
          -20,6},{-20,80},{-90,80},{-90,92},{-104,92}}, color={0,0,127}));
  connect(thermStar_Demux.therm, AddPower_OpenPlanOffice) annotation (Line(
        points={{-25.1,-15.9},{-25.1,70},{-100,70}}, color={191,0,0}));
  connect(temperatureSensor.T, measureBus.RoomTemp_Openplanoffice) annotation (
      Line(points={{28,22},{40,22},{40,-52},{-80,-52},{-90,-52},{-90,-59.9},{
          -99.9,-59.9}}, color={0,0,127}));
  connect(vol.X_w, measureBus.X_OpenplanOffice) annotation (Line(points={{28,-6},
          {40,-6},{40,-52},{-80,-52},{-90,-52},{-90,-59.9},{-99.9,-59.9}},
        color={0,0,127}));
  connect(temperatureSensor.port, thermStar_Demux.therm) annotation (Line(
        points={{8,22},{-4,22},{-4,-2},{-25.1,-2},{-25.1,-15.9}}, color={191,0,
          0}));
  connect(prescribedTemperature3.port, EastWall.port_outside)
    annotation (Line(points={{74,0},{64.2,0}}, color={191,0,0}));
  connect(prescribedTemperature2.port, SouthWall.port_outside)
    annotation (Line(points={{-52,-82},{-52,-66.2}}, color={191,0,0}));
  connect(prescribedTemperature.port, NorthWall.port_outside)
    annotation (Line(points={{-52,82},{-52,64.2}}, color={191,0,0}));
  connect(prescribedTemperature1.port, activeWallPipeBased.port_outside)
    annotation (Line(points={{20,82},{20,64.2},{20,64.2}}, color={191,0,0}));
  connect(prescribedTemperature.T, measureBus.AirTemp) annotation (Line(points=
          {{-52,95.2},{-52,100},{-80,100},{-80,54},{-60,54},{-60,-59.9},{-99.9,
          -59.9}}, color={0,0,127}));
  connect(prescribedTemperature1.T, measureBus.AirTemp) annotation (Line(points=
         {{20,95.2},{20,98},{-6,98},{-6,48},{-60,48},{-60,-59.9},{-99.9,-59.9}},
        color={0,0,127}));
  connect(prescribedTemperature3.T, measureBus.AirTemp) annotation (Line(points=
         {{87.2,0},{90,0},{90,-52},{-60,-52},{-60,-59.9},{-99.9,-59.9}}, color=
          {0,0,127}));
  connect(prescribedTemperature2.T, measureBus.AirTemp) annotation (Line(points=
         {{-52,-95.2},{-52,-98},{-24,-98},{-24,-52},{-60,-52},{-60,-59.9},{
          -99.9,-59.9}}, color={0,0,127}));
  connect(WestWallToMultiPersonOffice.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{70,-58},{70,-52},{-20,-52},{-20,-44},{-20.1,-44},
          {-20.1,-35.4}}, color={191,0,0}));
  connect(WestWallToMultiPersonOffice.port_outside,
    HeatPort_ToMultiPersonOffice)
    annotation (Line(points={{70,-66.2},{70,-100}}, color={191,0,0}));
  connect(WestWallToConferenceRoom1.port_outside, HeatPort_ToCanteen)
    annotation (Line(points={{-80.2,-26},{-86,-26},{-86,-26},{-86,-26},{-86,-26},
          {-100,-26}}, color={191,0,0}));
  connect(WestWallToConferenceRoom1.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-72,-26},{-60,-26},{-60,-52},{-20.1,-52},{-20.1,
          -35.4}}, color={191,0,0}));
  connect(wallTemp5.thermStarComb1, EastWall.thermStarComb_inside) annotation (
      Line(points={{56,-34},{50,-34},{50,0},{56,0}}, color={191,0,0}));
  connect(wallTemp1.thermStarComb1, WestWallToMultiPersonOffice.thermStarComb_inside)
    annotation (Line(points={{70,-50},{70,-58}}, color={191,0,0}));
  connect(wallTemp4.thermStarComb1, FloorToGround.thermStarComb_inside)
    annotation (Line(points={{14,-44},{14,-58}}, color={191,0,0}));
  connect(wallTemp6.thermStarComb1, WestWallToConferenceRoom1.thermStarComb_inside)
    annotation (Line(points={{-56,-26},{-72,-26}}, color={191,0,0}));
  connect(wallTemp.thermStarComb1, WestWallToConferenceRoom.thermStarComb_inside)
    annotation (Line(points={{-56,26},{-72,26}}, color={191,0,0}));
  connect(wallTemp2.thermStarComb1, activeWallPipeBased.thermStarComb_inside)
    annotation (Line(points={{-34,42},{-34,48},{20,48},{20,56},{20,56}}, color=
          {191,0,0}));
  connect(wallTemp2.WallTempWithFactor, measureBus.CeilingTemp_Openplanoffice)
    annotation (Line(points={{-34,34},{-34,-52},{-60,-52},{-60,-59.9},{-99.9,
          -59.9}}, color={0,0,127}));
  connect(wallTemp.WallTempWithFactor, multiSum.u[1]) annotation (Line(points={{-48,26},
          {-40,26},{-40,-52},{44,-52},{44,-77.325},{36,-77.325}},        color=
          {0,0,127}));
  connect(wallTemp6.WallTempWithFactor, multiSum.u[2]) annotation (Line(points={{-48,-26},
          {-40,-26},{-40,-52},{44,-52},{44,-78},{44,-78},{36,-78},{36,-79.775}},
                       color={0,0,127}));
  connect(wallTemp5.WallTempWithFactor, multiSum.u[3]) annotation (Line(points={{64,-34},
          {78,-34},{78,-36},{78,-36},{78,-52},{44,-52},{44,-82.225},{36,-82.225}},
                       color={0,0,127}));
  connect(wallTemp1.WallTempWithFactor, multiSum.u[4]) annotation (Line(points={{70,-42},
          {70,-34},{78,-34},{78,-52},{44,-52},{44,-84.675},{36,-84.675}},
        color={0,0,127}));
  connect(wallTemp4.WallTempWithFactor, measureBus.FloorTemp_Openplanoffice)
    annotation (Line(points={{14,-36},{14,-30},{0,-30},{0,-52},{-60,-52},{-60,
          -60},{-99.9,-60},{-99.9,-59.9}}, color={0,0,127}));
  connect(multiSum.y, measureBus.WallTemp_Openplanoffice) annotation (Line(
        points={{22.98,-81},{-14,-81},{-14,-52},{-60,-52},{-60,-59.9},{-99.9,
          -59.9}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end OpenPlanOffice_v2;
