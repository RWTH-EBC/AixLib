within AixLib.Fluid.HydraulicModules.Example;
model test_Unmixed "Test for unmixed circuit"
  extends Modelica.Icons.Example;

  Unmixed unmixed(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, pump(redeclare
        AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to4 per))
                                                          annotation (
      Placement(transformation(
        extent={{-18,-18},{18,18}},
        rotation=90,
        origin={-8,14})));

  Modelica.Fluid.Sources.Boundary_pT boundary(
    nPorts=1,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    T=323.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-30,-30})));

  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Sources.FixedBoundary boundary1(nPorts=1, redeclare package
              Medium =
               Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,-30})));
  AixLib.Fluid.FixedResistances.PressureDrop hydRes(
    m_flow(start=hydRes.m_flow_nominal),
    dp(start=hydRes.dp_nominal),
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    dp_nominal=100)
    "hydraulic resitance in distribution cirquit (shortcut pipe)" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-8,40})));
  AixLib.Fluid.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-62,-4},{-42,16}})));
  Modelica.Blocks.Sources.Ramp RPM_ramp(
    duration=500,
    startTime=180,
    height=3000)
    annotation (Placement(transformation(extent={{-98,6},{-78,26}})));
equation
  connect(boundary.ports[1], unmixed.port_fwrdIn)
    annotation (Line(points={{-30,-20},{-18.8,-20},{-18.8,-4}},
                                                           color={0,127,255}));
  connect(unmixed.port_rtrnOut, boundary1.ports[1])
    annotation (Line(points={{2.8,-4},{2.8,-20},{10,-20}},
                                                        color={0,127,255}));
  connect(unmixed.port_fwrdOut, hydRes.port_a) annotation (Line(points={{-18.8,
          32},{-18,32},{-18,40}},     color={0,127,255}));
  connect(unmixed.port_rtrnIn, hydRes.port_b) annotation (Line(points={{2.8,32},
          {4,32},{4,40},{2,40}}, color={0,127,255}));
  connect(unmixed.hydraulicBus, hydraulicBus) annotation (Line(
      points={{-26,6.8},{-36,6.8},{-36,6},{-52,6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(RPM_ramp.y, hydraulicBus.rpm_Input) annotation (Line(points={{-77,
          16},{-64,16},{-64,6.05},{-51.95,6.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{120,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    experiment(StopTime=600),
    __Dymola_Commands);
end test_Unmixed;
