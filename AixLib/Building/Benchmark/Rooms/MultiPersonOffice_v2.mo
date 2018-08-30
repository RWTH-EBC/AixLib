within AixLib.Building.Benchmark.Rooms;
model MultiPersonOffice_v2
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";
  Components.Walls.Wall SouthWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    withSunblind=false,
    withDoor=false,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    T0(displayUnit="degC") = 293.15,
    wall_length=20,
    windowarea=40)
               annotation (Placement(transformation(
        extent={{3.99999,-24},{-4.00002,24}},
        rotation=-90,
        origin={28,-62})));
  Components.Walls.Wall FloorToGround(
    solar_absorptance=0.48,
    withWindow=true,
    redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    windowarea=60,
    withSunblind=false,
    withDoor=false,
    outside=false,
    ISOrientation=2,
    wall_length=20,
    wall_height=5,
    WallType=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
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
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToGround
    annotation (Placement(transformation(extent={{-38,-110},{-18,-90}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_SouthWall annotation (
      Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=-90,
        origin={40,-104})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_SouthWall annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={90,-110})));
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
    annotation (Placement(transformation(extent={{88,60},{108,80}})));
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
  Components.Walls.Wall EastWallToOpenPlanOffice(
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
        extent={{3.99999,-24},{-4.00002,24}},
        rotation=0,
        origin={70,-6})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToOpenPlanOffice
    annotation (Placement(transformation(extent={{90,-52},{110,-32}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{8,12},{28,32}})));
  BusSystem.Bus_measure measureBus
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={14,-80})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature1
                          annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={20,88})));
equation
  connect(FloorToGround.port_outside, HeatPort_ToGround)
    annotation (Line(points={{-28,-66.2},{-28,-100}}, color={191,0,0}));
  connect(SouthWall.SolarRadiationPort,SolarRadiationPort_SouthWall)
    annotation (Line(points={{50,-67.2},{50,-80},{90,-80},{90,-92},{90,-92},{90,
          -110},{90,-110}},                                         color={255,
          128,0}));
  connect(FloorToGround.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-28,-58},{-28,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(SouthWall.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{28,-58},{28,-52},{-20,-52},{-20,-52},{-20.1,-52},
          {-20.1,-35.4}},color={191,0,0}));
  connect(SouthWall.WindSpeedPort,WindSpeedPort_SouthWall)  annotation (Line(
        points={{45.6,-66.2},{45.6,-74},{46,-74},{46,-80},{40,-80},{40,-104}},
                                                             color={0,0,127}));
  connect(activeWallPipeBased.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{20,56},{20,48},{-60,48},{-60,-52},{-20.1,-52},{
          -20.1,-35.4}}, color={191,0,0}));
  connect(WindSpeedPort_Roof,activeWallPipeBased. WindSpeedPort) annotation (
      Line(points={{40,104},{40,80},{37.6,80},{37.6,64.2}}, color={0,0,127}));
  connect(activeWallPipeBased.SolarRadiationPort,SolarRadiationPort_Hor)
    annotation (Line(points={{42,65.2},{42,70},{70,70},{70,110}}, color={255,
          128,0}));
  connect(activeWallPipeBased.Heatport_TBA,Heatport_TBA)  annotation (Line(
        points={{37.6,55.8},{37.6,48},{38,48},{38,48},{70,48},{70,70},{98,70}},
                                                 color={191,0,0}));
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
  connect(EastWallToOpenPlanOffice.port_outside, HeatPort_ToOpenPlanOffice)
    annotation (Line(points={{74.2,-6},{80,-6},{80,-42},{100,-42}},
                                                  color={191,0,0}));
  connect(EastWallToOpenPlanOffice.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{66,-6},{64,-6},{64,-8},{60,-8},{60,-52},{-20.1,
          -52},{-20.1,-35.4}}, color={191,0,0}));
  connect(temperatureSensor.T, measureBus.RoomTemp_Multipersonoffice)
    annotation (Line(points={{28,22},{40,22},{40,-52},{-74,-52},{-86,-52},{-86,
          -59.9},{-99.9,-59.9}}, color={0,0,127}));
  connect(vol.X_w, measureBus.X_Multipersonoffice) annotation (Line(points={{28,
          -6},{40,-6},{40,-52},{-74,-52},{-86,-52},{-86,-59.9},{-99.9,-59.9}},
        color={0,0,127}));
  connect(temperatureSensor.port, thermStar_Demux.therm) annotation (Line(
        points={{8,22},{-4,22},{-4,-2},{-25.1,-2},{-25.1,-15.9}}, color={191,0,
          0}));
  connect(prescribedTemperature.port,SouthWall. port_outside)
    annotation (Line(points={{20,-80},{20,-80},{28,-80},{28,-80},{28,-66},{28,
          -66},{28,-66.2}},                        color={191,0,0}));
  connect(prescribedTemperature1.port, activeWallPipeBased.port_outside)
    annotation (Line(points={{20,82},{20,64.2}}, color={191,0,0}));
  connect(prescribedTemperature.T, measureBus.AirTemp) annotation (Line(points={{6.8,-80},
          {6,-80},{6,-80},{4,-80},{0,-80},{0,-52},{-60,-52},{-60,48},{-60,48},{
          -60,-59.9},{-99.9,-59.9}},
                   color={0,0,127}));
  connect(prescribedTemperature1.T, measureBus.AirTemp) annotation (Line(points=
         {{20,95.2},{20,98},{-8,98},{-8,48},{-60,48},{-60,-59.9},{-99.9,-59.9}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-4,46},{44,36}},
          lineColor={28,108,200},
          textString="Solar absorptance ist noch nicht richtig,
gucken wie das mit PV Anlage ist
")}));
end MultiPersonOffice_v2;
