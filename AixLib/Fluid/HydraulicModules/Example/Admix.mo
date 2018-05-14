within AixLib.Fluid.HydraulicModules.Example;
model Admix "Test for admix circuit"
  import AixLib;
  extends Modelica.Icons.Example;

  AixLib.Fluid.HydraulicModules.Admix Admix(
    redeclare package Medium = Medium,
    redeclare
      AixLib.Fluid.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      basicPumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
    val(Kv=10, m_flow_nominal=0.5)) annotation (Placement(transformation(
        extent={{-25,-23},{25,23}},
        rotation=90,
        origin={15,27})));
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
        origin={2,-28})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    nPorts=1,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    T=323.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={36,-28})));

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
  Modelica.Blocks.Sources.Constant RPM(k=2000)
    annotation (Placement(transformation(extent={{-98,44},{-78,64}})));
  BaseClasses.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-52,6},{-32,26}})));
equation

  connect(valveOpening.y,hydraulicBus. valveSet) annotation (Line(points={{-77,
          16},{-58,16},{-58,16.05},{-41.95,16.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(RPM.y, hydraulicBus.rpm_Input) annotation (Line(points={{-77,54},
          {-41.95,54},{-41.95,16.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(hydraulicBus, Admix.hydraulicBus) annotation (Line(
      points={{-42,16},{-24,16},{-24,27},{-8,27}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(Admix.port_b1, hydRes.port_a)
    annotation (Line(points={{2.22222,52},{6,52},{6,64}}, color={0,127,255}));
  connect(Admix.port_a2, hydRes.port_b) annotation (Line(points={{32.8889,52},{
          28,52},{28,64},{26,64}}, color={0,127,255}));
  connect(Admix.port_a1, boundary.ports[1])
    annotation (Line(points={{2.22222,2},{2,2},{2,-18}}, color={0,127,255}));
  connect(Admix.port_b2, boundary1.ports[1])
    annotation (Line(points={{32.8889,2},{36,2},{36,-18}}, color={0,127,255}));
  annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=800),
    __Dymola_Commands,
    Documentation(revisions="<html>
<ul>
<li><i>2017-03-08 &nbsp;</i> by Peter Matthes:<br>Renamed and updated plot script 'pump test'. Solves Issue #28</li>
<li><i>2017-03-07 &nbsp;</i> by Peter Matthes:<br>Renamed and updated plot script.</li>
<li><i>2017-03-07 &nbsp;</i> by Peter Matthes:<br>Renamed model instances after renaming of modules.</li>
<li><i>2017-02-09 &nbsp;</i> by Peter Matthes:<br>implemented</li>
</ul>
</html>"));
end Admix;
