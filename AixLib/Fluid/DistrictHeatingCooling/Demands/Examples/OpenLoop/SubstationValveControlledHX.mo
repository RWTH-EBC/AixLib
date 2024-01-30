within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples.OpenLoop;
model SubstationValveControlledHX
  import AixLib;
  extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Water "Fluid in the pipes";
  AixLib.Fluid.Sources.Boundary_pT Flow(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1,
    use_p_in=true) "Flow Pipe" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-56,-44})));
  AixLib.Fluid.Sources.Boundary_pT Return(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1,
    p=200000) "Return Pipe" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={44,70})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=1000,
    f=1/3600,
    offset=2000,
    startTime=0)
    annotation (Placement(transformation(extent={{-4,-40},{16,-20}})));
  Modelica.Blocks.Sources.Constant const(k=288.15)
    annotation (Placement(transformation(extent={{-44,72},{-24,92}})));
  Modelica.Blocks.Sources.Ramp ramp(
    startTime=3600,
    height=20,
    duration=200000,
    offset=323.15)
    annotation (Placement(transformation(extent={{-100,-84},{-80,-64}})));
  AixLib.Fluid.DistrictHeatingCooling.Demands.OpenLoop.ValveControlledHX
    valveControlledHX(
    redeclare package Medium = Medium,
    Q_flow_nominal=3000,
    TReturn=303.15)
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Blocks.Sources.Sine FlowPressure(
    startTime=0,
    amplitude=20000,
    offset=450000,
    f=1/1800)
    annotation (Placement(transformation(extent={{-98,-20},{-78,0}})));
equation
  connect(ramp.y, Flow.T_in)
    annotation (Line(points={{-79,-74},{-60,-74},{-60,-56}}, color={0,0,127}));
  connect(const.y, Return.T_in)
    annotation (Line(points={{-23,82},{40,82}}, color={0,0,127}));
  connect(Flow.ports[1], valveControlledHX.port_a)
    annotation (Line(points={{-56,-34},{-56,20},{-10,20}}, color={0,127,255}));
  connect(valveControlledHX.port_b, Return.ports[1])
    annotation (Line(points={{10,20},{44,20},{44,60}}, color={0,127,255}));
  connect(sine.y, valveControlledHX.Q_flow_input) annotation (Line(points={{17,
          -30},{17,-4},{-22,-4},{-22,28},{-10.8,28}}, color={0,0,127}));
  connect(FlowPressure.y, Flow.p_in) annotation (Line(points={{-77,-10},{-70,
          -10},{-70,-64},{-64,-64},{-64,-56}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, Interval=60));
end SubstationValveControlledHX;
