within AixLib.Systems.HydraulicModules.Example;
model Pump "Test for unmixed pump circuit"
  extends Modelica.Icons.Example;

  package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);

  AixLib.Systems.HydraulicModules.Pump Unmixed(
    pipeModel="PlugFlowPipe",
    parameterPipe=DataBase.Pipes.Copper.Copper_35x1(),
    redeclare
      AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    length=1,
    pipe3(length=2),
    T_amb=293.15) annotation (Placement(transformation(
        extent={{-30,-30},{30,30}},
        rotation=90,
        origin={10,10})));

  AixLib.Fluid.FixedResistances.PressureDrop hydRes(
    m_flow(start=hydRes.m_flow_nominal),
    dp(start=hydRes.dp_nominal),
    m_flow_nominal=1,
    dp_nominal=100,
    redeclare package Medium = Medium)
    "Hydraulic resistance in distribution cirquit (shortcut pipe)" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,60})));
  AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-52,0},{-32,20}})));
  Modelica.Blocks.Sources.Ramp RPM_ramp(
    duration=500,
    startTime=180,
    height=3000)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  AixLib.Fluid.Sources.Boundary_pT   boundary(
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
  connect(Unmixed.hydraulicBus, hydraulicBus) annotation (Line(
      points={{-20,10},{-42,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(hydRes.port_b, Unmixed.port_a2)
    annotation (Line(points={{20,60},{28,60},{28,40}},     color={0,127,255}));
  connect(hydRes.port_a, Unmixed.port_b1)
    annotation (Line(points={{0,60},{-8,60},{-8,40}},    color={0,127,255}));
  connect(boundary.ports[1], Unmixed.port_a1)
    annotation (Line(points={{-8,-40},{-8,-20}}, color={0,127,255}));
  connect(boundary1.ports[1], Unmixed.port_b2)
    annotation (Line(points={{28,-40},{28,-20},{28,-20}}, color={0,127,255}));
  connect(RPM_ramp.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={{
          -79,10},{-60,10},{-60,10.05},{-41.95,10.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
    annotation (Placement(transformation(extent={{80,80},{100,100}})),
              Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{120,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    experiment(StopTime=800),
    Documentation(revisions="<html><ul>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    Transfer from ZUGABE to AixLib.
  </li>
</ul>
</html>"),
    __Dymola_Commands(file(ensureSimulated=true)=
        "Resources/Scripts/Dymola/Systems/HydraulicModules/Examples/Pump.mos"
        "Simulate and plot"));
end Pump;
