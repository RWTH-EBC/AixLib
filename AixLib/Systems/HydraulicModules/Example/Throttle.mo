within AixLib.Systems.HydraulicModules.Example;
model Throttle "Test for throttle circuit"
  import AixLib;
  extends Modelica.Icons.Example;

  AixLib.Systems.HydraulicModules.Throttle Throttle(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    val(Kv=10),
    pipe1(
      length=1,
      dIns=0.01,
      kIns=0.028),
    pipe2(
      length=1,
      dIns=0.01,
      kIns=0.028),
    T_amb=293.15,
    pipe3(
      length=1,
      dIns=0.01,
      kIns=0.028)) annotation (Placement(transformation(
        extent={{-30,-30},{30,30}},
        rotation=90,
        origin={10,10})));
  package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater
    annotation (choicesAllMatching=true);
  Modelica.Fluid.Sources.Boundary_pT boundary(
    nPorts=1,
    p=120000,
    T=323.15,
    redeclare package Medium = Medium)
              annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-8,-50})));

  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Sources.FixedBoundary boundary1(                nPorts=1,
      redeclare package Medium = Medium)                         annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={28,-50})));
  AixLib.Fluid.FixedResistances.PressureDrop hydRes(
    m_flow_nominal=8*996/3600,
    dp_nominal=8000,
    m_flow(start=hydRes.m_flow_nominal),
    dp(start=hydRes.dp_nominal),
    redeclare package Medium = Medium)
    "Hydraulic resistance in distribution cirquit (shortcut pipe)" annotation (Placement(
        transformation(
        extent={{-10,0},{10,20}},
        rotation=0,
        origin={10,50})));
  AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.Ramp valveOpening(              duration=500,
      startTime=180)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(Throttle.hydraulicBus, hydraulicBus) annotation (Line(
      points={{-20,10},{-26,10},{-26,0},{-30,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(valveOpening.y, hydraulicBus.valveSet) annotation (Line(points={{-59,0},
          {-58,0},{-58,0},{-30,0}},                 color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(hydRes.port_b, Throttle.port_a2)
    annotation (Line(points={{20,60},{28,60},{28,40}}, color={0,127,255}));
  connect(hydRes.port_a, Throttle.port_b1)
    annotation (Line(points={{0,60},{-8,60},{-8,40}},color={0,127,255}));
  connect(boundary.ports[1], Throttle.port_a1) annotation (Line(points={{-8,-40},
          {-8,-20}},                color={0,127,255}));
  connect(boundary1.ports[1], Throttle.port_b2) annotation (Line(points={{28,-40},
          {28,-20}},                   color={0,127,255}));
  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{120,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    experiment(StopTime=600),
    Documentation(revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Transfer from ZUGABE to AixLib.</li>
</ul>
</html>"));
end Throttle;
