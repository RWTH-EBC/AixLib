within AixLib.Fluid.HydraulicModules.Example;
model Throttle "Test for throttle circuit"
  import AixLib;
  extends Modelica.Icons.Example;

  AixLib.Fluid.HydraulicModules.Throttle Throttle(
    val( Kv=10, m_flow_nominal=0.5), redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
                                     annotation (Placement(
        transformation(
        extent={{-30,-30},{30,30}},
        rotation=90,
        origin={20,0})));

  Modelica.Fluid.Sources.Boundary_pT boundary(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    T=323.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-60})));

  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Sources.FixedBoundary boundary1(          redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
                                                                 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,-60})));
  AixLib.Fluid.FixedResistances.PressureDrop hydRes(
    m_flow_nominal=8*996/3600,
    dp_nominal=8000,
    m_flow(start=hydRes.m_flow_nominal),
    dp(start=hydRes.dp_nominal),
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "hydraulic resitance in distribution cirquit (shortcut pipe)" annotation (Placement(
        transformation(
        extent={{-10,0},{10,20}},
        rotation=0,
        origin={20,40})));
  AixLib.Fluid.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.Ramp valveOpening(              duration=500,
      startTime=180)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(Throttle.hydraulicBus, hydraulicBus) annotation (Line(
      points={{-10,1.77636e-015},{-26,1.77636e-015},{-26,0},{-30,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(valveOpening.y, hydraulicBus.valveSet) annotation (Line(points={{-59,0},
          {-58,0},{-58,0.05},{-29.95,0.05}},        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(hydRes.port_b, Throttle.port_a2)
    annotation (Line(points={{30,50},{38,50},{38,30}}, color={0,127,255}));
  connect(hydRes.port_a, Throttle.port_b1)
    annotation (Line(points={{10,50},{2,50},{2,30}}, color={0,127,255}));
  connect(boundary.ports[1], Throttle.port_a1) annotation (Line(points={{0,-50},
          {0,-40},{0,-30},{2,-30}}, color={0,127,255}));
  connect(boundary1.ports[1], Throttle.port_b2) annotation (Line(points={{40,-50},
          {40,-40},{40,-30},{38,-30}}, color={0,127,255}));
  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{120,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    experiment(StopTime=600),
    __Dymola_Commands);
end Throttle;
