within AixLib.Systems.HydraulicModules.Example;
model ThrottlePump "Test for throttle circuit"
  import AixLib;
  extends Modelica.Icons.Example;

  AixLib.Systems.HydraulicModules.ThrottlePump ThrottlePump(
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
    pipe3(
      length=1,
      dIns=0.01,
      kIns=0.028),
    pipe4(
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
    T=323.15,
    nPorts=1,
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
        origin={30,-50})));
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
  AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.Ramp valveOpening(              duration=500,
      startTime=180)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.Constant RPM(k=2000)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
equation
  connect(ThrottlePump.hydraulicBus, hydraulicBus) annotation (Line(
      points={{-20,10},{-38,10},{-38,0},{-50,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(valveOpening.y, hydraulicBus.valveSet) annotation (Line(points={{-79,0},
          {-58,0},{-58,0},{-50,0}},                 color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(ThrottlePump.port_b1, hydRes.port_a) annotation (Line(points={{-8,40},
          {-8,60},{0,60}},             color={0,127,255}));
  connect(ThrottlePump.port_a2, hydRes.port_b)
    annotation (Line(points={{28,40},{28,60},{20,60}},     color={0,127,255}));
  connect(boundary1.ports[1], ThrottlePump.port_b2) annotation (Line(points={{30,-40},
          {30,-20},{28,-20}},                   color={0,127,255}));
  connect(boundary.ports[1], ThrottlePump.port_a1) annotation (Line(points={{-8,-40},
          {-8,-20}},                               color={0,127,255}));
  connect(RPM.y, hydraulicBus.pumpBus.rpm_Input) annotation (Line(points={{-79,
          40},{-49.95,40},{-49.95,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
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
end ThrottlePump;
