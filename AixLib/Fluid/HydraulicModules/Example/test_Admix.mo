within AixLib.Fluid.HydraulicModules.Example;
model test_Admix "test for admix circuit"
  extends Modelica.Icons.Example;

  Admix admix(redeclare package Medium = Medium, pump(redeclare
        AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per),
    pipe6(length=1))                             "hydronic module 1"
    annotation (Placement(transformation(
        extent={{-28,-28},{28,28}},
        rotation=90,
        origin={24,18})));
  replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater
    annotation (__Dymola_choicesAllMatching=true);
  Modelica.Fluid.Sources.Boundary_pT boundary(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    T=323.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={8,-36})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    T=323.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={40,-36})));

  AixLib.Fluid.FixedResistances.PressureDrop hydRes(
    m_flow_nominal=8*996/3600,
    dp_nominal=8000,
    m_flow(start=hydRes.m_flow_nominal),
    dp(start=hydRes.dp_nominal),
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "hydraulic resitance in distribution cirquit (shortcut pipe)" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={24,62})));
  Modelica.Blocks.Sources.Ramp valveOpening(              duration=500,
      startTime=180)
    annotation (Placement(transformation(extent={{-96,8},{-76,28}})));
  AixLib.Fluid.HydraulicModules.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-52,8},{-32,28}})));
  Modelica.Blocks.Sources.Constant RPM(k=2000)
    annotation (Placement(transformation(extent={{-96,42},{-76,62}})));
equation

  connect(valveOpening.y, hydraulicBus.valveSet) annotation (Line(points={{-75,18},
          {-58,18},{-58,18.05},{-41.95,18.05}},     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(hydraulicBus, admix.hydraulicBus) annotation (Line(
      points={{-42,18},{-4,18}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(RPM.y, hydraulicBus.rpm_Input) annotation (Line(points={{-75,52},{-42,
          52},{-42,36},{-41.95,36},{-41.95,18.05}},      color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(boundary.ports[1], admix.port_a1)
    annotation (Line(points={{8,-26},{7.2,-26},{7.2,-10}}, color={0,127,255}));
  connect(boundary1.ports[1], admix.port_b2) annotation (Line(points={{40,-26},
          {40,-10},{40.8,-10}}, color={0,127,255}));
  connect(admix.port_a2, hydRes.port_b)
    annotation (Line(points={{40.8,46},{40.8,62},{34,62}}, color={0,127,255}));
  connect(admix.port_b1, hydRes.port_a) annotation (Line(points={{7.2,46},{8,46},
          {8,62},{14,62}}, color={0,127,255}));
  annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1000),
    __Dymola_Commands,
    Documentation(revisions="<html>
<ul>
<li>October 25,2017, by Alexander K&uuml;mpel:<br>Transfered to AixLib from ZUGABE.</li>
<li>March 7,2017, by Peter Matthes:<br>Renamed and updated plot script.</li>
<li>March 7,2017, by Peter Matthes:<br>Renamed model instances after renaming of modules.</li>
<li>February 2,2017, by Peter Matthes:<br>implemented</li>
</ul>
</html>", info="<html>
<p>Model that demonstrates the use of the admix circuit. The inlet mass flow (port_a1) increases when the three-way-valve opens whereas the outlet massflow varies less. </p>
</html>"));
end test_Admix;
