within AixLib.Systems.HydraulicModules.Example;
model Injection "Test for injection circuit"
  import AixLib;
  extends Modelica.Icons.Example;

  AixLib.Systems.HydraulicModules.Injection Injection(
    pipe4(
      dIns=0.01,
      kIns=0.028,
      length=1),
    pipe5(
      dIns=0.01,
      kIns=0.028,
      length=1),
    pipe6(
      length=1,
      dIns=0.01,
      kIns=0.028),
    pipe7(
      length=0.5,
      dIns=0.01,
      kIns=0.028),
    pipe8(
      length=1,
      dIns=0.01,
      kIns=0.028),
    pipe9(
      length=1,
      dIns=0.01,
      kIns=0.028),
    redeclare package Medium = Medium,
    redeclare
      AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      basicPumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
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
    T_amb=293.15) annotation (Placement(transformation(
        extent={{-30,-30},{30,30}},
        rotation=90,
        origin={10,10})));
  package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater
    annotation (choicesAllMatching=true);
  Modelica.Fluid.Sources.Boundary_pT boundary(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    T=323.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-10,-50})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    T=323.15,
    nPorts=1,
    redeclare package Medium = Medium)
              annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={28,-50})));

  AixLib.Fluid.FixedResistances.PressureDrop hydRes(
    m_flow_nominal=8*996/3600,
    dp_nominal=8000,
    m_flow(start=hydRes.m_flow_nominal),
    dp(start=hydRes.dp_nominal),
    redeclare package Medium = Medium)
    "Hydraulic resistance in distribution cirquit (shortcut pipe)" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,60})));
  Modelica.Blocks.Sources.Ramp valveOpening(              duration=500,
      startTime=180)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Constant RPM(k=2000)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  BaseClasses.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
equation

  connect(valveOpening.y,hydraulicBus. valveSet) annotation (Line(points={{-79,10},
          {-60,10},{-60,20},{-50,20},{-50,20},{-40,20}},
                                                    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(hydraulicBus,Injection. hydraulicBus) annotation (Line(
      points={{-40,20},{-22,20},{-22,10},{-19.7,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-12,3},{-12,3}}));
  connect(boundary.ports[1], Injection.port_a1) annotation (Line(points={{-10,-40},
          {-10,-20},{-8,-20}},                                   color={0,127,255}));
  connect(boundary1.ports[1], Injection.port_b2) annotation (Line(points={{28,-40},
          {28,-20}},                      color={0,127,255}));
  connect(hydRes.port_b, Injection.port_a2)
    annotation (Line(points={{20,60},{28,60},{28,40}},     color={0,127,255}));
  connect(hydRes.port_a, Injection.port_b1)
    annotation (Line(points={{0,60},{-8,60},{-8,40}},    color={0,127,255}));
  connect(RPM.y, hydraulicBus.pumpBus.rpm_Input) annotation (Line(points={{-79,50},
          {-56,50},{-56,46},{-39.95,46},{-39.95,20.05}},     color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
                           annotation (Placement(transformation(
        extent={{-24,-24},{24,24}},
        rotation=90,
        origin={20,20})),
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=800),
    Documentation(revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Transfer from ZUGABE to AixLib.</li>
</ul>
</html>"));
end Injection;
