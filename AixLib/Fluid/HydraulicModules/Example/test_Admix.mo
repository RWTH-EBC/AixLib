within AixLib.Fluid.HydraulicModules.Example;
model test_Admix "test for admix circuit"
  extends Modelica.Icons.Example;

  Admix admix(redeclare package Medium = Medium, pump(redeclare
        AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))
                                                 "hydronic module 1"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={16,26})));
  replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater
    annotation (__Dymola_choicesAllMatching=true);
  Modelica.Fluid.Sources.Boundary_pT boundary(
    nPorts=1,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    T=323.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-6,-24})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    nPorts=1,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    T=323.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={42,-24})));

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
        origin={16,64})));
  Modelica.Blocks.Sources.Ramp valveOpening(              duration=500,
      startTime=180)
    annotation (Placement(transformation(extent={{-98,6},{-78,26}})));
  AixLib.Fluid.HydraulicModules.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-52,6},{-32,26}})));
  Modelica.Blocks.Sources.Constant RPM(k=2000)
    annotation (Placement(transformation(extent={{-98,42},{-78,62}})));
equation

  connect(boundary.ports[1], admix.port_fwrdIn) annotation (Line(points={{-6,-14},
          {-2,-14},{-2,6},{4,6}}, color={0,127,255}));
  connect(boundary1.ports[1], admix.port_rtrnOut) annotation (Line(points={{42,
          -14},{34,-14},{34,6},{28,6}}, color={0,127,255}));
  connect(admix.port_fwrdOut, hydRes.port_a)
    annotation (Line(points={{4,46},{4,64},{6,64}}, color={0,127,255}));
  connect(admix.port_rtrnIn, hydRes.port_b) annotation (Line(points={{28,46},
          {30,46},{30,62},{30,64},{26,64}}, color={0,127,255}));
  connect(valveOpening.y, hydraulicBus.valveSet) annotation (Line(points={{-77,
          16},{-58,16},{-58,16.05},{-41.95,16.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(hydraulicBus, admix.hydraulicBus) annotation (Line(
      points={{-42,16},{-24,16},{-24,18},{-4,18}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(RPM.y, hydraulicBus.rpm_Input) annotation (Line(points={{-77,52},
          {-54,52},{-54,54},{-41.95,54},{-41.95,16.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400),
    __Dymola_Commands,
    Documentation(revisions="<html>
<ul>
<li><i>2017-03-08 &nbsp;</i> by Peter Matthes:<br>Renamed and updated plot script 'pump test'. Solves Issue #28</li>
<li><i>2017-03-07 &nbsp;</i> by Peter Matthes:<br>Renamed and updated plot script.</li>
<li><i>2017-03-07 &nbsp;</i> by Peter Matthes:<br>Renamed model instances after renaming of modules.</li>
<li><i>2017-02-09 &nbsp;</i> by Peter Matthes:<br>implemented</li>
</ul>
</html>"));
end test_Admix;
