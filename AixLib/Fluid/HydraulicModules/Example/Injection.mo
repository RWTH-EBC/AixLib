within AixLib.Fluid.HydraulicModules.Example;
model Injection "Test for injection circuit"
  import AixLib;
  extends Modelica.Icons.Example;

  AixLib.Fluid.HydraulicModules.Injection Injection(
    redeclare package Medium = Medium,
    redeclare
      AixLib.Fluid.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      basicPumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
    val(Kv=10, m_flow_nominal=0.5)) annotation (Placement(transformation(
        extent={{-26,-26},{26,26}},
        rotation=90,
        origin={20,20})));
                           annotation (Placement(transformation(
        extent={{-24,-24},{24,24}},
        rotation=90,
        origin={20,20})));
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
        origin={0,-30})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    T=323.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={40,-30})));

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
        origin={20,60})));
  Modelica.Blocks.Sources.Ramp valveOpening(              duration=500,
      startTime=180)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Constant RPM(k=2000)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  BaseClasses.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
equation

  connect(valveOpening.y,hydraulicBus. valveSet) annotation (Line(points={{-79,10},
          {-60,10},{-60,20},{-50,20},{-50,20.05},{-39.95,20.05}},
                                                    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(RPM.y, hydraulicBus.rpm_Input) annotation (Line(points={{-79,50},{-39.95,
          50},{-39.95,20.05}},         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(hydraulicBus,Injection. hydraulicBus) annotation (Line(
      points={{-40,20},{-5.74,20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-12,3},{-12,3}}));
  connect(boundary.ports[1], Injection.port_a1) annotation (Line(points={{0,-20},
          {0,-12},{6,-12},{6,-6},{4.4,-6}},                      color={0,127,255}));
  connect(boundary1.ports[1], Injection.port_b2) annotation (Line(points={{40,-20},
          {40,-12},{35.6,-12},{35.6,-6}}, color={0,127,255}));
  connect(hydRes.port_b, Injection.port_a2)
    annotation (Line(points={{30,60},{35.6,60},{35.6,46}}, color={0,127,255}));
  connect(hydRes.port_a, Injection.port_b1)
    annotation (Line(points={{10,60},{4.4,60},{4.4,46}}, color={0,127,255}));
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
end Injection;
