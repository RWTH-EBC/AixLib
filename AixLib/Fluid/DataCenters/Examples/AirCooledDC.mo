within AixLib.Fluid.DataCenters.Examples;
model AirCooledDC
  extends Modelica.Icons.Example;
  ServerRoomAirCooled serverRoomAirCooled(redeclare package Medium =
        Modelica.Media.Air.SimpleAir, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe_FMain(
    isCircular=false,
    nNodes=4,
    length=10,
    diameter=1,
    redeclare package Medium = Modelica.Media.Air.SimpleAir,
    crossArea=1,
    perimeter=5)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe_RMain(
    isCircular=false,
    nNodes=4,
    length=10,
    diameter=1,
    redeclare package Medium = Modelica.Media.Air.SimpleAir,
    crossArea=1,
    perimeter=5)
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,-40})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=295.15)
    annotation (Placement(transformation(extent={{-52,30},{-32,50}})));
  Sources.MassFlowSource_T boundary(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Air.SimpleAir,
    m_flow=5,
    T=291.15)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Sources.FixedBoundary bou(nPorts=1, redeclare package Medium =
        Modelica.Media.Air.SimpleAir)
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  Modelica.Blocks.Sources.Sine sine[2](
    amplitude=30,
    offset=70,
    freqHz=1/1800)
    annotation (Placement(transformation(extent={{-50,10},{-40,20}})));
equation
  connect(pipe_FMain.port_b, serverRoomAirCooled.port_a)
    annotation (Line(points={{-30,0},{-16.3636,0}}, color={0,127,255}));
  connect(serverRoomAirCooled.port_b, pipe_RMain.port_a)
    annotation (Line(points={{20,0},{40,0},{40,-30}}, color={0,127,255}));
  connect(fixedTemperature.port, serverRoomAirCooled.equalAirTemp) annotation (
      Line(points={{-32,40},{-26,40},{-26,18},{-18.1818,18}}, color={191,0,0}));
  connect(boundary.ports[1], pipe_FMain.port_a)
    annotation (Line(points={{-60,0},{-56,0},{-50,0}}, color={0,127,255}));
  connect(bou.ports[1], pipe_RMain.port_b)
    annotation (Line(points={{20,-70},{40,-70},{40,-50}}, color={0,127,255}));
  connect(sine.y, serverRoomAirCooled.CPUutilization) annotation (Line(points={
          {-39.5,15},{-28,15},{-28,10},{-18.1818,10}}, color={0,0,127}));
  annotation (experiment(StopTime=86400, Interval=100));
end AirCooledDC;
