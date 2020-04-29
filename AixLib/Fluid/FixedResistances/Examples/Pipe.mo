within AixLib.Fluid.FixedResistances.Examples;
model Pipe

  extends Modelica.Icons.Example;

   replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater "Medium in the system"                annotation(choicesAllMatching = true);

  Modelica.Fluid.Sources.MassFlowSource_T Source(
    redeclare package Medium = Medium,
    use_m_flow_in=false,
    use_T_in=true,
    m_flow=0.001,
    T=323.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-64,-10},{-44,10}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=3600,
    offset=273.15 + 40,
    startTime=400,
    height=40)
    annotation (Placement(transformation(extent={{-100,-6},{-80,14}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemp(T=293.15)
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Modelica.Fluid.Sources.FixedBoundary
                                  Sink(
    redeclare package Medium = Medium, nPorts=1)
    annotation (Placement(transformation(extent={{-11,-11},{11,11}},
        rotation=180,
        origin={79,1})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Sensors.Temperature temperatureAfter(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{14,-40},{34,-20}})));
  Modelica.Fluid.Sensors.Temperature temperatureBefore(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-52,-40},{-32,-20}})));
  AixLib.Fluid.FixedResistances.Pipe dynamicPipeEBCAggregated_Ambient_Loss_UC(
    length=2,
    redeclare package Medium = Medium,
    parameterPipe=DataBase.Pipes.Copper.Copper_6x1(),
    parameterIso=DataBase.Pipes.Insulation.Iso100pc(),
    diameter=dynamicPipeEBCAggregated_Ambient_Loss_UC.parameterPipe.d_i,
    nNodes=5,
    Heat_Loss_To_Ambient=true,
    isEmbedded=false,
    withInsulation=true,
    use_HeatTransferConvective=true)
    annotation (Placement(transformation(extent={{-14,-10},{6,10}})));
equation
  connect(ramp.y, Source.T_in) annotation (Line(
      points={{-79,4},{-66,4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dynamicPipeEBCAggregated_Ambient_Loss_UC.Star, fixedTemp.port)
    annotation (Line(
      points={{-5.4,5.6},{-5.4,30},{-30,30}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(Source.ports[1], dynamicPipeEBCAggregated_Ambient_Loss_UC.port_a)
    annotation (Line(
      points={{-44,0},{-14,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(temperatureBefore.port, dynamicPipeEBCAggregated_Ambient_Loss_UC.port_a)
    annotation (Line(
      points={{-42,-40},{-30,-40},{-30,0},{-14,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(dynamicPipeEBCAggregated_Ambient_Loss_UC.port_b, Sink.ports[1])
    annotation (Line(points={{6,0},{68,0},{68,1}},   color={0,127,255}));
  connect(temperatureAfter.port, dynamicPipeEBCAggregated_Ambient_Loss_UC.port_b)
    annotation (Line(points={{24,-40},{40,-40},{40,0},{6,0}},   color={0,127,255}));
  connect(fixedTemp.port, dynamicPipeEBCAggregated_Ambient_Loss_UC.heatPort_outside)
    annotation (Line(points={{-30,30},{-2.4,30},{-2.4,5.6}}, color={191,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Simple example to test the model for
  DynamicPipeEBCAggregated_Ambient_Loss
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Plot:
</p>
<ul>
  <li>x-axis: Time
  </li>
  <li>y-axis: temperatureBefore; temperatureAfter
  </li>
</ul>
</html>",
    revisions="<html><ul>
  <li>
    <i>April 25, 2017 &#160;</i> by Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>November 26, 2014 &#160;</i> by Roozbeh Sangi:<br/>
    Used for other model: Changed used pipe from DynamicPipeEBC1 to
    DynamicPipeEBCAggregated_Ambient_Loss
  </li>
  <li>
    <i>April 16, 2014 &#160;</i> by Ana Constantin:<br/>
    Formated documentation.
  </li>
  <li>
    <i>April 11, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>"),
    experiment(
      StopTime=10800,
      Interval=60,
      __Dymola_Algorithm="Lsodar"),
    experimentSetupOutput(events=false));
end Pipe;
