within AixLib.Building.Benchmark.Test;
model Test_RLT

  Modelica.Fluid.Pipes.StaticPipe pipe(
    redeclare package Medium = Modelica.Media.Air.MoistAir,
    length=5,
    diameter=1)
    annotation (Placement(transformation(extent={{-90,-6},{-70,14}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{-172,10},{-152,30}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=273.15 + 20)
    annotation (Placement(transformation(extent={{-172,-4},{-152,16}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=0.01)
    annotation (Placement(transformation(extent={{-170,-18},{-150,2}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary1(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Air.MoistAir,
    use_m_flow_in=true,
    use_T_in=true,
    use_X_in=true)
    annotation (Placement(transformation(extent={{-126,-12},{-106,8}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=0.99)
    annotation (Placement(transformation(extent={{-170,-34},{-150,-14}})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol(
    nPorts=2,
    redeclare package Medium = Modelica.Media.Air.MoistAir,
    m_flow_nominal=1,
    V=1) annotation (Placement(transformation(extent={{-56,4},{-36,24}})));
  Modelica.Fluid.Pipes.StaticPipe pipe1(
    redeclare package Medium = Modelica.Media.Air.MoistAir,
    length=5,
    diameter=1)
    annotation (Placement(transformation(extent={{-28,-6},{-8,14}})));
  Modelica.Fluid.Pipes.StaticPipe pipe2(
    redeclare package Medium = Modelica.Media.Air.MoistAir,
    length=5,
    diameter=1) annotation (Placement(transformation(extent={{70,-6},{90,14}})));
  AixLib.Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Modelica.Media.Air.MoistAir,
    nPorts=1,
    T=293.15) annotation (Placement(transformation(extent={{170,-8},{150,12}})));
  Modelica.Fluid.Pipes.StaticPipe pipe3(
    redeclare package Medium = Modelica.Media.Air.MoistAir,
    length=5,
    diameter=1)
    annotation (Placement(transformation(extent={{118,-8},{138,12}})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol1(
    nPorts=2,
    redeclare package Medium = Modelica.Media.Air.MoistAir,
    m_flow_nominal=1,
    V=0.1) annotation (Placement(transformation(extent={{94,4},{114,24}})));
  Modelica.Blocks.Sources.Step step(
    height=0.01,
    offset=0.01,
    startTime=500)
    annotation (Placement(transformation(extent={{-44,64},{-24,84}})));
  AixLib.Fluid.Humidifiers.SprayAirWasher_X hum(
    redeclare package Medium = Modelica.Media.Air.MoistAir,
    m_flow_nominal=1,
    dp_nominal=0)
    annotation (Placement(transformation(extent={{46,22},{66,42}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempOutside1
                                                                          annotation(Placement(transformation(extent={{-116,34},
            {-96,54}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=273.15 + 30)
    annotation (Placement(transformation(extent={{-160,34},{-140,54}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=
        23000)
    annotation (Placement(transformation(extent={{-84,18},{-64,38}})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol3(
    nPorts=2,
    redeclare package Medium = Modelica.Media.Air.MoistAir,
    m_flow_nominal=1,
    V=1) annotation (Placement(transformation(extent={{0,4},{20,24}})));
  Modelica.Fluid.Pipes.StaticPipe pipe4(
    redeclare package Medium = Modelica.Media.Air.MoistAir,
    length=5,
    diameter=1) annotation (Placement(transformation(extent={{22,-6},{42,14}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(
                                                                             G=
        23000)
    annotation (Placement(transformation(extent={{-34,-38},{-14,-18}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempOutside2
                                                                          annotation(Placement(transformation(extent={{-70,-40},
            {-50,-20}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=273.15 + 35)
    annotation (Placement(transformation(extent={{-114,-40},{-94,-20}})));
  AixLib.Fluid.Humidifiers.SteamHumidifier_X hum1
    annotation (Placement(transformation(extent={{48,-36},{68,-16}})));
equation
  connect(boundary1.ports[1], pipe.port_a) annotation (Line(points={{-106,-2},{
          -104,-2},{-104,4},{-90,4}}, color={0,127,255}));
  connect(realExpression.y, boundary1.m_flow_in)
    annotation (Line(points={{-151,20},{-126,20},{-126,6}}, color={0,0,127}));
  connect(realExpression1.y, boundary1.T_in) annotation (Line(points={{-151,6},
          {-136,6},{-136,2},{-128,2}}, color={0,0,127}));
  connect(realExpression2.y, boundary1.X_in[1]) annotation (Line(points={{-149,
          -8},{-136,-8},{-136,-6},{-128,-6}}, color={0,0,127}));
  connect(realExpression3.y, boundary1.X_in[2]) annotation (Line(points={{-149,
          -24},{-128,-24},{-128,-6}}, color={0,0,127}));
  connect(pipe.port_b, vol.ports[1])
    annotation (Line(points={{-70,4},{-48,4}}, color={0,127,255}));
  connect(vol.ports[2], pipe1.port_a)
    annotation (Line(points={{-44,4},{-28,4}}, color={0,127,255}));
  connect(bou1.ports[1], pipe3.port_b)
    annotation (Line(points={{150,2},{138,2}}, color={0,127,255}));
  connect(pipe2.port_b, vol1.ports[1])
    annotation (Line(points={{90,4},{102,4}}, color={0,127,255}));
  connect(vol1.ports[2], pipe3.port_a) annotation (Line(points={{106,4},{110,4},
          {110,2},{118,2}}, color={0,127,255}));
  connect(hum.port_b, pipe2.port_a) annotation (Line(points={{66,32},{68,32},{
          68,4},{70,4}}, color={0,127,255}));
  connect(step.y, hum.X_w) annotation (Line(points={{-23,74},{34,74},{34,38},{
          44,38}}, color={0,0,127}));
  connect(realExpression4.y,tempOutside1. T)
    annotation (Line(points={{-139,44},{-118,44}}, color={0,0,127}));
  connect(thermalConductor.port_b, vol.heatPort)
    annotation (Line(points={{-64,28},{-56,28},{-56,14}}, color={191,0,0}));
  connect(tempOutside1.port, thermalConductor.port_a) annotation (Line(points={
          {-96,44},{-88,44},{-88,28},{-84,28}}, color={191,0,0}));
  connect(pipe1.port_b, vol3.ports[1])
    annotation (Line(points={{-8,4},{8,4}}, color={0,127,255}));
  connect(vol3.ports[2], pipe4.port_a)
    annotation (Line(points={{12,4},{22,4}}, color={0,127,255}));
  connect(pipe4.port_b, hum.port_a)
    annotation (Line(points={{42,4},{46,4},{46,32}}, color={0,127,255}));
  connect(thermalConductor1.port_b, vol3.heatPort)
    annotation (Line(points={{-14,-28},{0,-28},{0,14}}, color={191,0,0}));
  connect(realExpression5.y,tempOutside2. T)
    annotation (Line(points={{-93,-30},{-72,-30}}, color={0,0,127}));
  connect(tempOutside2.port, thermalConductor1.port_a) annotation (Line(points=
          {{-50,-30},{-42,-30},{-42,-28},{-34,-28}}, color={191,0,0}));
  annotation ();
end Test_RLT;
