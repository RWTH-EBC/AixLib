within AixLib.Systems.HydraulicModules.Example;
model Injection "Test for injection circuit"
  extends Modelica.Icons.Example;

  package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);

  AixLib.Systems.HydraulicModules.Injection Injection(
    parameterPipe=DataBase.Pipes.Copper.Copper_35x1_5(),
    redeclare
      AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    valveCharacteristic=Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
    pipe8(length=0.5),
    length=1,
    Kv=10,
    pipe9(length=0.5),
    T_amb=293.15) annotation (Placement(transformation(
        extent={{-30,-30},{30,30}},
        rotation=90,
        origin={10,10})));

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
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
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

  connect(hydraulicBus,Injection. hydraulicBus) annotation (Line(
      points={{-40,10},{-20,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-12,3},{-12,3}}));
  connect(hydRes.port_b, Injection.port_a2)
    annotation (Line(points={{20,60},{28,60},{28,40}},     color={0,127,255}));
  connect(hydRes.port_a, Injection.port_b1)
    annotation (Line(points={{0,60},{-8,60},{-8,40}},    color={0,127,255}));
  connect(boundary.ports[1], Injection.port_a1)
    annotation (Line(points={{-8,-40},{-8,-20}}, color={0,127,255}));
  connect(boundary1.ports[1], Injection.port_b2)
    annotation (Line(points={{28,-40},{28,-20},{28,-20}}, color={0,127,255}));
  connect(valveOpening.y, hydraulicBus.valveSet) annotation (Line(points={{-79,
          10},{-62,10},{-62,10.05},{-39.95,10.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(RPM.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={{-79,50},
          {-39.95,50},{-39.95,10.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
                           annotation (Placement(transformation(
        extent={{-24,-24},{24,24}},
        rotation=90,
        origin={20,20})),
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=800),
    Documentation(revisions="<html><ul>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    Transfer from ZUGABE to AixLib.
  </li>
</ul>
</html>"),
    __Dymola_Commands(file(ensureSimulated=true)=
        "Resources/Scripts/Dymola/Systems/HydraulicModules/Examples/Injection.mos"
        "SImulate and plot"));
end Injection;
