within AixLib.Systems.HydraulicModules.Example;
model Throttle "Test for ummixed throttle circuit"
  extends Modelica.Icons.Example;

  package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);

  AixLib.Systems.HydraulicModules.Throttle Throttle(
    redeclare package Medium = Medium,
    parameterPipe=DataBase.Pipes.Copper.Copper_28x1(),
    m_flow_nominal=1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_amb=293.15,
    length=1,
    Kv=6.3,
    pipe3(length=2)) annotation (Placement(transformation(
        extent={{-30,-30},{30,30}},
        rotation=90,
        origin={10,10})));

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
    annotation (Placement(transformation(extent={{-52,0},{-32,20}})));
  Modelica.Blocks.Sources.Ramp valveOpening(              duration=500,
      startTime=180)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  AixLib.Fluid.Sources.Boundary_pT   boundary(
    p=boundary1.p + 1000,
    T=323.15,
    redeclare package Medium = Medium,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-8,-50})));
  AixLib.Fluid.Sources.Boundary_pT   boundary1(
    T=323.15,
    redeclare package Medium = Medium,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={28,-50})));
equation
  connect(Throttle.hydraulicBus, hydraulicBus) annotation (Line(
      points={{-20,10},{-42,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(hydRes.port_b, Throttle.port_a2)
    annotation (Line(points={{20,60},{28,60},{28,40}}, color={0,127,255}));
  connect(hydRes.port_a, Throttle.port_b1)
    annotation (Line(points={{0,60},{-8,60},{-8,40}},color={0,127,255}));
  connect(Throttle.port_a1, boundary.ports[1])
    annotation (Line(points={{-8,-20},{-8,-40}}, color={0,127,255}));
  connect(Throttle.port_b2, boundary1.ports[1])
    annotation (Line(points={{28,-20},{28,-40}}, color={0,127,255}));
  connect(valveOpening.y, hydraulicBus.valveSet) annotation (Line(points={{-79,
          10},{-41.95,10},{-41.95,10.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{120,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    experiment(StopTime=1000),
    Documentation(revisions="<html><ul>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    Transfer from ZUGABE to AixLib.
  </li>
</ul>
</html>"),
    __Dymola_Commands(file(ensureSimulated=true)=
        "Resources/Scripts/Dymola/Systems/HydraulicModules/Examples/Throttle.mos"
        "Simulate and plot"));
end Throttle;
