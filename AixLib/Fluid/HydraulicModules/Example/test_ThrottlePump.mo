within AixLib.Fluid.HydraulicModules.Example;
model test_ThrottlePump "Test for throttle circuit"
  extends Modelica.Icons.Example;

  ThrottlePump throttle(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, pump(redeclare
        AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))
                                                          annotation (Placement(
        transformation(
        extent={{-18,-18},{18,18}},
        rotation=90,
        origin={-6,6})));

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
        origin={-8,40})));
  AixLib.Fluid.HydraulicModules.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-62,-4},{-42,16}})));
  Modelica.Blocks.Sources.Ramp valveOpening(              duration=500,
      startTime=180)
    annotation (Placement(transformation(extent={{-98,6},{-78,26}})));
  Modelica.Blocks.Sources.Constant RPM(k=2000)
    annotation (Placement(transformation(extent={{-98,42},{-78,62}})));
equation
  connect(boundary.ports[1], throttle.port_fwrdIn)
    annotation (Line(points={{-30,-20},{-16.8,-20},{-16.8,-12}},
                                                           color={0,127,255}));
  connect(throttle.port_rtrnOut, boundary1.ports[1])
    annotation (Line(points={{4.8,-12},{4.8,-20},{10,-20}},
                                                        color={0,127,255}));
  connect(throttle.port_fwrdOut, hydRes.port_a) annotation (Line(points={{-16.8,
          24},{-18,24},{-18,40}},     color={0,127,255}));
  connect(throttle.port_rtrnIn, hydRes.port_b) annotation (Line(points={{4.8,24},
          {4,24},{4,40},{2,40}},     color={0,127,255}));
  connect(throttle.hydraulicBus, hydraulicBus) annotation (Line(
      points={{-24,-1.2},{-36,-1.2},{-36,6},{-52,6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(valveOpening.y, hydraulicBus.valveSet) annotation (Line(points={{-77,16},
          {-58,16},{-58,6.05},{-51.95,6.05}},       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(RPM.y, hydraulicBus.rpm_Input) annotation (Line(points={{-77,52},
          {-54,52},{-54,54},{-51.95,54},{-51.95,6.05}}, color={0,0,127}),
      Text(
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
end test_ThrottlePump;
