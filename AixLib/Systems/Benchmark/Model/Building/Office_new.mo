within AixLib.Systems.Benchmark.Model.Building;
model Office_new
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
  Modelica.Blocks.Interfaces.RealInput SolarRadIn[4] annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-106,70})));
  Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = AixLib.Media.Air,
    V=10,
    nPorts=2,
    m_flow_nominal=3.375)
               annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={25,-73})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in[5](redeclare package Medium =
       AixLib.Media.Air)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{72,-110},{92,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package Medium =
       AixLib.Media.Air)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{22,-110},{42,-90}})));
  ThermalZones.ReducedOrder.RC.FourElements
                  thermalZoneFourElements(
    VAir=2700,
    hConExt=2.5,
    hConWin=1.3,
    gWin=1,
    ratioWinConRad=0.09,
    nExt=4,
    RExt={0.05,2.857,0.48,0.0294},
    CExt={1000,1030,1000,1000},
    hRad=5,
    AInt=90,
    hConInt=2.5,
    nInt=2,
    RInt={0.175,0.0294},
    CInt={1000,1000},
    RWin=0.01282,
    RExtRem=0.00001,
    AFloor=900,
    hConFloor=2.5,
    nFloor=4,
    RFloor={1.5,0.1087,1.1429,0.0429},
    RFloorRem=0.00001,
    CFloor={8400,575000,4944,120000},
    ARoof=900,
    hConRoof=2.5,
    nRoof=4,
    RRoof={0.44444,0.06957,0.02941,0.00001},
    RRoofRem=0.0001,
    CRoof={2472,368000,18000,0.000001},
    nOrientations=4,
    AWin={60,0,60,60},
    ATransparent={48,0,48,48},
    AExt={30,0,30,30},
    redeclare package Medium = AixLib.Media.Air,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nPorts=6)                                                  annotation (Placement(transformation(extent={{-18,-22},
            {30,14}})));
equation
  connect(vol1.ports[1],Air_out)   annotation (Line(points={{32,-74.4},{32,-100}},
                                      color={0,127,255}));
  connect(Air_out, Air_out)
    annotation (Line(points={{32,-100},{32,-100}}, color={0,127,255}));
  connect(port_windows, thermalZoneFourElements.window) annotation (Line(points=
         {{-100,16},{-60,16},{-60,0},{-18,0}}, color={191,0,0}));
  connect(port_walls, thermalZoneFourElements.extWall) annotation (Line(points={
          {-100,-18},{-60,-18},{-60,-8},{-18,-8}}, color={191,0,0}));
  connect(port_floor, thermalZoneFourElements.floor) annotation (Line(points={{0,
          -100},{4,-100},{4,-22},{6,-22}}, color={191,0,0}));
  connect(vol1.ports[2], thermalZoneFourElements.ports[1]) annotation (Line(
        points={{32,-71.6},{26,-71.6},{26,-21.95},{18.4583,-21.95}}, color={0,127,
          255}));
  connect(Air_in, thermalZoneFourElements.ports[2:6]) annotation (Line(points={{82,-100},
          {52,-100},{52,-21.95},{23.5417,-21.95}},          color={0,127,255}));
  connect(port_IntConvGains, thermalZoneFourElements.intGainsConv) annotation (
      Line(points={{100,-18},{66,-18},{66,0},{30,0}}, color={191,0,0}));
  connect(port_IntRadGains, thermalZoneFourElements.intGainsRad) annotation (
      Line(points={{100,16},{66,16},{66,4},{30,4}}, color={191,0,0}));
  connect(port_roof, thermalZoneFourElements.roof) annotation (Line(points={{0,100},
          {4,100},{4,14},{4.9,14}}, color={191,0,0}));
  connect(SolarRadIn[1], thermalZoneFourElements.solRad[1]) annotation (Line(
        points={{-106,55},{-62,55},{-62,10.25},{-19,10.25}}, color={0,0,127}));
  connect(SolarRadIn[2], thermalZoneFourElements.solRad[2]) annotation (Line(
        points={{-106,65},{-62,65},{-62,10.75},{-19,10.75}}, color={0,0,127}));
  connect(SolarRadIn[3], thermalZoneFourElements.solRad[3]) annotation (Line(
        points={{-106,75},{-62,75},{-62,11.25},{-19,11.25}}, color={0,0,127}));
  connect(SolarRadIn[4], thermalZoneFourElements.solRad[4]) annotation (Line(
        points={{-106,85},{-64,85},{-64,11.75},{-19,11.75}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Office_new;
