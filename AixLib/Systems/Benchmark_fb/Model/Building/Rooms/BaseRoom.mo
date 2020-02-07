within AixLib.Systems.Benchmark_fb.Model.Building.Rooms;
model BaseRoom
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";
  AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort thermStar_Demux annotation(Placement(transformation(extent={{-13,10},
            {13,-10}},                                                                                                            rotation = 90, origin={-22,-33})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall activeWallPipeBased(
    withDoor=false,
    ISOrientation=3,
    outside=true,
    wall_length=20,
    wall_height=5,
    WallType=AixLib.Systems.Benchmark_fb.Benchmark_DataBase.CE_RO_EnEV2009_SM_TBA(),
    solar_absorptance=0.48)
    annotation (Placement(transformation(
        extent={{-4,-24},{4,24}},
        rotation=-90,
        origin={40,60})));
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
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_Roof annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={60,100})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_Hor annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={90,110})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b Heatport_TBA
    annotation (Placement(transformation(extent={{90,60},{110,80}})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in(redeclare package Medium =
        Medium_Air)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package Medium =
        Medium_Air)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Interfaces.RealInput mFlow_Water
    "Water flow rate added into the medium"
    annotation (Placement(transformation(extent={{-112,78},{-88,102}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a AddPower_System
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  BusSystems.Bus_measure measureBus
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature1
                          annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={30,80})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
equation
  connect(WindSpeedPort_Roof,activeWallPipeBased. WindSpeedPort) annotation (
      Line(points={{60,100},{60,80},{57.6,80},{57.6,64.2}}, color={0,0,127}));
  connect(activeWallPipeBased.SolarRadiationPort,SolarRadiationPort_Hor)
    annotation (Line(points={{62,65.2},{62,84},{90,84},{90,110}}, color={255,
          128,0}));
  connect(Air_in,vol. ports[1]) annotation (Line(points={{100,0},{50,0},{50,-20},
          {28,-20}},                           color={0,127,255}));
  connect(Air_out,vol. ports[2]) annotation (Line(points={{100,40},{50,40},{50,
          -20},{32,-20}},          color={0,127,255}));
  connect(vol.mWat_flow, mFlow_Water) annotation (Line(points={{18,-2},{-10,-2},
          {-10,80},{-80,80},{-80,90},{-100,90}}, color={0,0,127}));
  connect(temperatureSensor.T, measureBus.RoomTemp_Multipersonoffice)
    annotation (Line(points={{40,20},{50,20},{50,-52},{-50,-52},{-50,-59.9},{
          -99.9,-59.9}},         color={0,0,127}));
  connect(vol.X_w, measureBus.X_Multipersonoffice) annotation (Line(points={{42,-14},
          {50,-14},{50,-52},{-50,-52},{-50,-59.9},{-99.9,-59.9}},
        color={0,0,127}));
  connect(prescribedTemperature1.port, activeWallPipeBased.port_outside)
    annotation (Line(points={{36,80},{40,80},{40,64.2}},
                                                 color={191,0,0}));
  connect(prescribedTemperature1.T, measureBus.AirTemp) annotation (Line(points={{22.8,80},
          {10,80},{10,48},{-50,48},{-50,-59.9},{-99.9,-59.9}},
        color={0,0,127}));
  connect(temperatureSensor1.T, measureBus.StrahlungTemp_Multipersonoffice)
    annotation (Line(points={{40,-40},{50,-40},{50,-52},{-50,-52},{-50,-59.9},{
          -99.9,-59.9}},                       color={0,0,127}));
  connect(temperatureSensor1.port, thermStar_Demux.portRad) annotation (Line(
        points={{20,-40},{4,-40},{4,-19.48},{-14.75,-19.48}}, color={191,0,0}));
  connect(vol.heatPort, thermStar_Demux.portConv) annotation (Line(points={{20,
          -10},{-4,-10},{-4,-19.87},{-28.375,-19.87}}, color={191,0,0}));
  connect(temperatureSensor.port, thermStar_Demux.portConv) annotation (Line(
        points={{20,20},{-4,20},{-4,-19.87},{-28.375,-19.87}}, color={191,0,0}));
  connect(thermStar_Demux.portConv, AddPower_System) annotation (Line(points={{
          -28.375,-19.87},{-28.375,19.065},{-100,19.065},{-100,60}}, color={191,
          0,0}));
  connect(thermStar_Demux.portConvRadComb, activeWallPipeBased.thermStarComb_inside)
    annotation (Line(points={{-20.375,-45.74},{-20.375,6.13},{40,6.13},{40,56}},
        color={191,0,0}));
  connect(Heatport_TBA, activeWallPipeBased.port_outside) annotation (Line(
        points={{100,70},{72,70},{72,64.2},{40,64.2}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BaseRoom;
