within AixLib.Utilities.Sources.InternalGains.Examples.InternalGains;
model CO2Balance
  extends Modelica.Icons.Example;
  CO2.CO2Balance cO2Change(
    AreaZon=20,
    actDeg=2,
    VZon=40) annotation (Placement(transformation(extent={{-30,-36},{26,14}})));
  Modelica.Blocks.Sources.Constant const1(k=2)
    annotation (Placement(transformation(extent={{-92,-22},{-72,-2}})));
  Modelica.Blocks.Sources.Step step(
    height=0.5,
    offset=0.1,
    startTime=3600)
    annotation (Placement(transformation(extent={{-96,46},{-76,66}})));
  Modelica.Blocks.Sources.Constant TAir(k=293)
    annotation (Placement(transformation(extent={{-44,66},{-24,86}})));
  Fluid.MixingVolumes.MixingVolumeMoistAir vol(
    redeclare package Medium = Media.Air,
    V=40,
    use_C_flow=true,
    nPorts=1) annotation (Placement(transformation(extent={{76,-98},{92,-82}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=vol.C[1])
    annotation (Placement(transformation(extent={{-96,-72},{-76,-52}})));
  Fluid.Sensors.PPM senPPM(redeclare package Medium = Media.Air)
    annotation (Placement(transformation(extent={{-86,-96},{-66,-76}})));
equation
  connect(cO2Change.spePeo, step.y) annotation (Line(points={{-30,9},{-50,9},{
          -50,56},{-75,56}},         color={0,0,127}));
  connect(cO2Change.airExc, const1.y) annotation (Line(points={{-30,-3.5},{-64,
          -3.5},{-64,-12},{-71,-12}},color={0,0,127}));
  connect(TAir.y, cO2Change.TAir) annotation (Line(points={{-23,76},{-2,76},{-2,
          14}},                            color={0,0,127}));
  connect(vol.C_flow[1], cO2Change.mCO2_flow) annotation (Line(points={{74.4,
          -94.8},{38,-94.8},{38,4},{28.8,4}}, color={0,0,127}));
  connect(realExpression.y, cO2Change.XCO2) annotation (Line(points={{-75,-62},
          {-54,-62},{-54,-16},{-30,-16}}, color={0,0,127}));
  connect(senPPM.port, vol.ports[1]) annotation (Line(points={{-76,-96},{-56,
          -96},{-56,-98},{84,-98}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=7200, Interval=60));
end CO2Balance;
