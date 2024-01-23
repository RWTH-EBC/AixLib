within AixLib.Fluid.DistrictHeatingCooling.ReferenceNetworks;
model HydraulicValidationPlugFlow
  "Network with 2 supplies, 3 sinks, and 1 loop from Larock et al. 2000"
  extends Modelica.Icons.Example;

  package Medium = AixLib.Media.Water "Medium in the network";

  parameter Modelica.SIunits.Pressure pressureReference1 = 201450.8
    "Reference result for pressure at demand node B1";

  parameter Modelica.SIunits.Pressure pressureReference2 = 169453.5
    "Reference result for pressure at demand node B2";

  parameter Modelica.SIunits.Pressure pressureReference3 = 200612.4
    "Reference result for pressure at demand node B3";

  FixedResistances.PlugFlowPipe pipe2(
    redeclare package Medium = Medium,
    m_flow_nominal=29.8378,
    dh=0.15,
    length=100,
    nPorts=1,
    dIns=0.045,
    kIns=0.035)             "Pipe 2"
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  FixedResistances.PlugFlowPipe pipe1(
    redeclare package Medium = Medium,
    m_flow_nominal=59.7352,
    dh=0.2,
    length=355,
    nPorts=3,
    dIns=0.045,
    kIns=0.035)             "Pipe 1" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-40,50})));
  FixedResistances.PlugFlowPipe pipe4(
    redeclare package Medium = Medium,
    m_flow_nominal=1.7144,
    length=45,
    dh=0.11,
    nPorts=1,
    dIns=0.045,
    kIns=0.035)                               "Pipe 4"
    annotation (Placement(transformation(extent={{0,-38},{20,-18}})));
  FixedResistances.PlugFlowPipe pipe5(
    redeclare package Medium = Medium,
    m_flow_nominal=33.2923,
    dh=0.15,
    length=175,
    nPorts=2,
    dIns=0.045,
    kIns=0.035)                                 "Pipe 5"
    annotation (Placement(transformation(extent={{70,-70},{50,-50}})));
  Sources.Boundary_pT S1(
    redeclare package Medium = Medium,
    p=298900,
    nPorts=1) "Supply node S1" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,80})));
  Sources.Boundary_pT S2(
    redeclare package Medium = Medium,
    p=269020,
    nPorts=1) "Supply node S2" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-60})));
  Sources.MassFlowSource_T B1(
    redeclare package Medium = Medium,
    m_flow=-28.175,
    nPorts=1) "Demand node B1"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Sources.MassFlowSource_T B2(
    redeclare package Medium = Medium,
    m_flow=-42.213,
    nPorts=1)       "Demand node B2" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,80})));
  Sources.MassFlowSource_T B3(
    redeclare package Medium = Medium,
    m_flow=-22.6,
    nPorts=1)     "Demand node B3"
    annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
  Modelica.Blocks.Interfaces.RealOutput deviationPressure1(final unit="1")
    "Relative deviation of pressure at demand node B1"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput deviationPressure2(final unit="1")
    "Relative deviation of pressure at demand node B2"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput deviationPressure3(final unit="1")
    "Relative deviation of pressure at demand node B3"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));

  FixedResistances.PlugFlowPipe      pipe3(
    redeclare package Medium = Medium,
    m_flow_nominal=12.4528,
    dh=0.1,
    length=70,
    nPorts=1,
    dIns=0.045,
    kIns=0.035)
               "Pipe 3" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,4})));
  FixedResistances.PlugFlowPipe pipe6(
    redeclare package Medium = Medium,
    length=15,
    dh=0.15,
    m_flow_nominal=28.175,
    nPorts=1,
    dIns=0.045,
    kIns=0.035)
             "Pipe 6"                annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-60,30})));
  FixedResistances.PlugFlowPipe pipe7(
    redeclare package Medium = Medium,
    length=15,
    dh=0.15,
    m_flow_nominal=42.213,
    nPorts=2,
    dIns=0.045,
    kIns=0.035)
             "Pipe 7"                annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={20,50})));
  FixedResistances.PlugFlowPipe pipe8(
    redeclare package Medium = Medium,
    length=15,
    dh=0.15,
    m_flow_nominal=22.6,
    nPorts=2,
    dIns=0.045,
    kIns=0.035)
             "Pipe 8"                annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={22,-60})));
equation

  deviationPressure1 = (B1.ports[1].p - pressureReference1)/pressureReference1;
  deviationPressure2 = (B2.ports[1].p - pressureReference2)/pressureReference2;
  deviationPressure3 = (B3.ports[1].p - pressureReference3)/pressureReference3;

  connect(B1.ports[1], pipe6.port_a)
    annotation (Line(points={{-80,30},{-70,30}}, color={0,127,255}));
  connect(S1.ports[1], pipe1.port_a)
    annotation (Line(points={{-40,70},{-40,60}}, color={0,127,255}));
  connect(B2.ports[1], pipe7.port_a)
    annotation (Line(points={{20,70},{20,60}}, color={0,127,255}));
  connect(B3.ports[1], pipe8.port_a)
    annotation (Line(points={{0,-60},{12,-60}}, color={0,127,255}));
  connect(pipe5.port_a, S2.ports[1])
    annotation (Line(points={{70,-60},{80,-60}}, color={0,127,255}));
  connect(pipe2.port_a, pipe1.ports_b[1]) annotation (Line(points={{-20,30},{
          -30,30},{-30,40},{-37.3333,40}}, color={0,127,255}));
  connect(pipe6.ports_b[1], pipe1.ports_b[2]) annotation (Line(points={{-50,30},
          {-46,30},{-46,40},{-40,40}}, color={0,127,255}));
  connect(pipe1.ports_b[3], pipe4.port_a) annotation (Line(points={{-42.6667,40},
          {-42,40},{-42,-28},{0,-28}}, color={0,127,255}));
  connect(pipe2.ports_b[1], pipe7.ports_b[1]) annotation (Line(points={{0,30},{
          12,30},{12,40},{22,40}}, color={0,127,255}));
  connect(pipe7.ports_b[2], pipe3.ports_b[1]) annotation (Line(points={{18,40},
          {30,40},{30,14},{40,14}}, color={0,127,255}));
  connect(pipe3.port_a, pipe5.ports_b[1]) annotation (Line(points={{40,-6},{46,
          -6},{46,-62},{50,-62}}, color={0,127,255}));
  connect(pipe4.ports_b[1], pipe8.ports_b[1]) annotation (Line(points={{20,-28},
          {26,-28},{26,-58},{32,-58}}, color={0,127,255}));
  connect(pipe8.ports_b[2], pipe5.ports_b[2]) annotation (Line(points={{32,-62},
          {42,-62},{42,-58},{50,-58}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  One of the largest drawbacks of the reference network in <a href=
  \"AixLib.Fluid.DistrictHeatingCooling.ReferenceNetworks.HydraulicValidation\">
  AixLib.Fluid.DistrictHeatingCooling.ReferenceNetworks.HydraulicValidation</a>
  is that the source [Larock et al., 2000] does not specify any pipe
  lengths and diameters. This example approximates a similar network
  with comparable flows and pressures using the <a href=
  \"AixLib.Fluid.FixedResistances.HydraulicDiameter\">AixLib.Fluid.FixedResistances.HydraulicDiameter</a>
  model to represent the pipes.
</p>
<h4>
  Assumptions and limitations
</h4>
<p>
  While this model is far from perfect, it may be helpful as a starting
  point for developing new DHC component models.
</p>
<h4>
  Validation
</h4>
<p>
  Like in in <a href=
  \"AixLib.Fluid.DistrictHeatingCooling.ReferenceNetworks.HydraulicValidation\">
  AixLib.Fluid.DistrictHeatingCooling.ReferenceNetworks.HydraulicValidation</a>,
  the outputs compare the relative deviations between the calculated
  pressures at the demand nodes B1, B2, and B3 with the reference
  results given in Larock et al. [2000]. The results show deviations
  below 0.4 percent.
</p>
<h4>
  References
</h4>
<ul>
  <li>
    <a href=
    \"https://www.crcpress.com/Hydraulics-of-Pipeline-Systems/Larock-Jeppson-Watters/p/book/9780849318061\">
    Larock, Bruce E., Roland W. Jeppson, and Gary Z. Watters.
    <i>Hydraulics of pipeline systems</i>. Boca Raton, FL: CRC Press,
    2000.</a>
  </li>
  <li>AixLib issue <a href=
  \"https://github.com/RWTH-EBC/AixLib/issues/402\">#402</a>
  </li>
</ul>
</html>", revisions="<html>
<ul>
  <li>May 26, 2017, by Marcus Fuchs:<br/>
    Implemented for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/402\">issue 402</a>.
  </li>
</ul>
</html>"),
    experiment(StopTime=25200, Interval=900));
end HydraulicValidationPlugFlow;
