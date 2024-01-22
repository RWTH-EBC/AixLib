within AixLib.Systems.HydraulicModules.Example;
model ThrottlePump "Test for unmixed throttle and pump circuit"
  extends Modelica.Icons.Example;

  package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);

  AixLib.Systems.HydraulicModules.ThrottlePump ThrottlePump(
    parameterPipe=DataBase.Pipes.Copper.Copper_40x1(),
    redeclare
      AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    length=1,
    Kv=6.3,
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
  AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Modelica.Blocks.Sources.Ramp valveOpening(              duration=500,
      startTime=180)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Constant RPM(k=2000)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
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
  connect(ThrottlePump.hydraulicBus, hydraulicBus) annotation (Line(
      points={{-20,10},{-50,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(ThrottlePump.port_b1, hydRes.port_a) annotation (Line(points={{-8,40},
          {-8,60},{0,60}},             color={0,127,255}));
  connect(ThrottlePump.port_a2, hydRes.port_b)
    annotation (Line(points={{28,40},{28,60},{20,60}},     color={0,127,255}));
  connect(valveOpening.y, hydraulicBus.valveSet) annotation (Line(points={{-79,
          10},{-64,10},{-64,10.05},{-49.95,10.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(ThrottlePump.port_a1, boundary.ports[1])
    annotation (Line(points={{-8,-20},{-8,-40},{-8,-40}}, color={0,127,255}));
  connect(ThrottlePump.port_b2, boundary1.ports[1])
    annotation (Line(points={{28,-20},{28,-40}}, color={0,127,255}));
  connect(RPM.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={{-79,40},
          {-49.95,40},{-49.95,10.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{120,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    experiment(StopTime=600),
    Documentation(revisions="<html><ul>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    Transfer from ZUGABE to AixLib.
  </li>
</ul>
</html>"),
    __Dymola_Commands(file(ensureSimulated=true)=
        "Resources/Scripts/Dymola/Systems/HydraulicModules/Examples/ThrottlePump.mos"
        "Simulate and plot"));
end ThrottlePump;
