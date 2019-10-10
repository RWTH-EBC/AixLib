within AixLib.Systems.Benchmark.Model.Building;
model Office_new
 ThermalZones.ReducedOrder.RC.FourElements thermalZoneFourElements(
    each hRad=5,
    each hConvWin=1.3,
    each gWin=1,
    each ratioWinConRad=0.09,
    each hConvExt=2.5,
    each nExt=4,
    each RExtRem=0,
    each hConvInt=2.5,
    each nInt=2,
    each hConvFloor=2.5,
    each nFloor=4,
    each RFloorRem=0,
    each hConvRoof=2.5,
    each RRoofRem=0,
    each nRoof=4,
    RExt={0.05,2.857,0.48,0.0294},
    CExt={1000,1030,1000,1000},
    CInt={1000,1000},
    RFloor={1.5,0.1087,1.1429,0.0429},
    CFloor={8400,575000,4944,120000},
    CRoof={2472,368000,18000,1},
    each indoorPortWin=false,
    each indoorPortExtWalls=false,
    each indoorPortIntWalls=false,
    each indoorPortFloor=false,
    each indoorPortRoof=false,
    VAir=2700,
    AInt=90,
    AFloor=900,
    ARoof=900,
    RRoof={0.4444,0.06957,0.02941,0.0001},
    RWin=0.01923,
    RInt={0.175,0.0294},
    nOrientations=2,
    AWin={90,90},
    ATransparent={72,72},
    AExt={45,45},
    nPorts=6)
    annotation (Placement(transformation(extent={{-24,-22},{24,14}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_roof
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_walls
    annotation (Placement(transformation(extent={{-110,-28},{-90,-8}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_windows
    annotation (Placement(transformation(extent={{-110,6},{-90,26}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_floor
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_IntConvGains
    annotation (Placement(transformation(extent={{90,-28},{110,-8}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_IntRadGains
    annotation (Placement(transformation(extent={{90,6},{110,26}})));
  Modelica.Blocks.Interfaces.RealInput SolarRadIn[2] annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-108,64})));
  Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = Medium_Air,
    V=10,
    nPorts=2,
    m_flow_nominal=3.375)
               annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={25,-73})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in[5](redeclare package Medium =
        Medium_Air)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{72,-110},{92,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package Medium =
        Medium_Air)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{22,-110},{42,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_TBA
    annotation (Placement(transformation(extent={{-102,-106},{-82,-86}})));
equation
  connect(thermalZoneFourElements.roof, port_roof) annotation (Line(points={{
          -1.1,14},{0,14},{0,100},{0,100}}, color={191,0,0}));
  connect(thermalZoneFourElements.intGainsRad, port_IntRadGains) annotation (
      Line(points={{24,4},{62,4},{62,16},{100,16}}, color={191,0,0}));
  connect(thermalZoneFourElements.intGainsConv, port_IntConvGains) annotation (
      Line(points={{24,0},{60,0},{60,-18},{100,-18}}, color={191,0,0}));
  connect(thermalZoneFourElements.floor, port_floor)
    annotation (Line(points={{0,-22},{0,-22},{0,-100}}, color={191,0,0}));
  connect(port_windows, thermalZoneFourElements.window) annotation (Line(points
        ={{-100,16},{-62,16},{-62,0},{-24,0}}, color={191,0,0}));
  connect(port_walls, thermalZoneFourElements.extWall) annotation (Line(points=
          {{-100,-18},{-62,-18},{-62,-8},{-24,-8}}, color={191,0,0}));
  connect(SolarRadIn[1], thermalZoneFourElements.solRad[1]) annotation (Line(
        points={{-108,54},{-108,64},{-32,64},{-32,10.5},{-25,10.5}}, color={0,0,
          127}));
  connect(SolarRadIn[2], thermalZoneFourElements.solRad[2]) annotation (Line(
        points={{-108,74},{-108,66},{-100,66},{-100,64},{-32,64},{-32,11.5},{
          -25,11.5}}, color={0,0,127}));
  connect(vol1.ports[1],Air_out)   annotation (Line(points={{32,-74.4},{32,-100}},
                                      color={0,127,255}));
  connect(Air_in, thermalZoneFourElements.ports[1:5]) annotation (Line(points={
          {82,-100},{82,-61},{16.525,-61},{16.525,-21.95}}, color={0,127,255}));
  connect(vol1.ports[2], thermalZoneFourElements.ports[6]) annotation (Line(
        points={{32,-71.6},{13,-71.6},{13,-21.95},{17.5417,-21.95}}, color={0,
          127,255}));
  connect(Air_out, Air_out)
    annotation (Line(points={{32,-100},{32,-100}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Office_new;
