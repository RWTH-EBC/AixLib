within AixLib.Fluid.FixedResistances.Examples;
model SimplePipe

  extends Modelica.Icons.Example;

   replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater "Medium in the system"                annotation(choicesAllMatching = true);

  Modelica.Fluid.Sources.MassFlowSource_T Source(
    redeclare package Medium = Medium,
    use_m_flow_in=false,
    use_T_in=true,
    m_flow=0.3,
    T=323.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemp[simplePipe.nNodes](each T=
        278.15)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Fluid.Sources.FixedBoundary
                                  Sink(
    redeclare package Medium = Medium, nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={78,0})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  AixLib.Fluid.FixedResistances.SimplePipe simplePipe(
    redeclare package Medium = Medium,
    nNodes=4,
    dh=0.028,
    length=10,
    lambda=400,
    thickness=0.001,
    T_start=323.15,
    m_flow_nominal=0.5,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Sensors.TemperatureTwoPort              senTemIn(
    redeclare package Medium = Medium,
    m_flow_nominal=0.001,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Sensors.TemperatureTwoPort              senTemOut(
    redeclare package Medium = Medium,
    m_flow_nominal=0.001,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Ramp Tin(
    height=20,
    duration=0,
    offset=273.15 + 50,
    startTime=100) "Ramp pressure signal"
    annotation (Placement(transformation(extent={{-102,-6},{-82,14}})));
equation
  connect(Source.ports[1], senTemIn.port_a)
    annotation (Line(points={{-48,0},{-40,0}}, color={0,127,255}));
  connect(senTemIn.port_b, simplePipe.port_a)
    annotation (Line(points={{-20,0},{-10,0}}, color={0,127,255}));
  connect(simplePipe.port_b, senTemOut.port_a)
    annotation (Line(points={{10,0},{16,0},{16,0},{20,0}}, color={0,127,255}));
  connect(senTemOut.port_b, Sink.ports[1])
    annotation (Line(points={{40,0},{68,0}}, color={0,127,255}));
  connect(Tin.y, Source.T_in)
    annotation (Line(points={{-81,4},{-70,4}}, color={0,0,127}));
  connect(simplePipe.heatPorts, fixedTemp.port) annotation (Line(points={{0,5.2},
          {-4,5.2},{-4,38},{-20,38},{-20,50}}, color={127,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Simple example to test the model SimplePipe. The inlet temperature
  increases in a step after 100 seconds.
</p>
<h4>
  <span style=\"color: #008000\">Concept</span>
</h4>
<p>
  Plot:
</p>
<ul>
  <li>x-axis: Time
  </li>
  <li>y-axis: Inlet and Outlet temperature
  </li>
</ul>
</html>",
    revisions="<html><ul>
  <li>Mai 07, 2020, by Alexander Kümpel:<br/>
    First implementation
  </li>
</ul>
</html>"),
    experiment(Tolerance=1e-6,
      StopTime=10800,
      Interval=60,
      __Dymola_Algorithm="Lsodar"),
    experimentSetupOutput(events=false),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/FixedResistances/Examples/SimplePipe.mos"
        "Simulate and plot"));
end SimplePipe;
