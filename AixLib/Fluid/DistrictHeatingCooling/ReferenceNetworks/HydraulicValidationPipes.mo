within AixLib.Fluid.DistrictHeatingCooling.ReferenceNetworks;
model HydraulicValidationPipes
  "Network with 2 supplies, 3 sinks, and 1 loop from Larock et al. 2000"
  extends Modelica.Icons.Example;

  package Medium = AixLib.Media.Water "Medium in the network";

  parameter Modelica.SIunits.Pressure pressureReference1 = 201450.8
    "Reference result for pressure at demand node B1";

  parameter Modelica.SIunits.Pressure pressureReference2 = 169453.5
    "Reference result for pressure at demand node B2";

  parameter Modelica.SIunits.Pressure pressureReference3 = 200612.4
    "Reference result for pressure at demand node B3";

  FixedResistances.HydraulicDiameter
                                pipe2(
    redeclare package Medium = Medium,
    m_flow_nominal=29.8378,
    dh=0.15,
    length=100)             "Pipe 2"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  FixedResistances.HydraulicDiameter
                                pipe1(
    redeclare package Medium = Medium,
    m_flow_nominal=59.7352,
    dh=0.2,
    length=355)             "Pipe 1" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,50})));
  FixedResistances.HydraulicDiameter
                                pipe4(
    redeclare package Medium = Medium,
    m_flow_nominal=1.7144,
    length=45,
    dh=0.11)                                  "Pipe 4"
    annotation (Placement(transformation(extent={{-10,-38},{10,-18}})));
  FixedResistances.HydraulicDiameter
                                pipe5(
    redeclare package Medium = Medium,
    m_flow_nominal=33.2923,
    dh=0.15,
    length=175)                                 "Pipe 5"
    annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  Sources.Boundary_pT S1(
    redeclare package Medium = Medium,
    nPorts=1,
    p=298900) "Supply node S1" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,80})));
  Sources.Boundary_pT S2(
    redeclare package Medium = Medium,
    nPorts=1,
    p=269020) "Supply node S2" annotation (Placement(transformation(
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
    nPorts=1,
    m_flow=-42.213) "Demand node B2" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={10,62})));
  Sources.MassFlowSource_T B3(
    redeclare package Medium = Medium,
    nPorts=1,
    m_flow=-22.6) "Demand node B3"
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  Modelica.Blocks.Interfaces.RealOutput deviationPressure1(final unit="1")
    "Relative deviation of pressure at demand node B1"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput deviationPressure2(final unit="1")
    "Relative deviation of pressure at demand node B2"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput deviationPressure3(final unit="1")
    "Relative deviation of pressure at demand node B3"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));

  FixedResistances.HydraulicDiameter pipe3(
    redeclare package Medium = Medium,
    m_flow_nominal=12.4528,
    dh=0.1,
    length=70) "Pipe 3" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,4})));
equation

  deviationPressure1 = (B1.ports[1].p - pressureReference1)/pressureReference1;
  deviationPressure2 = (B2.ports[1].p - pressureReference2)/pressureReference2;
  deviationPressure3 = (B3.ports[1].p - pressureReference3)/pressureReference3;

  connect(S1.ports[1], pipe1.port_b)
    annotation (Line(points={{-70,70},{-70,60}}, color={0,127,255}));
  connect(pipe2.port_b, B2.ports[1]) annotation (Line(points={{-20,30},{-6,30},{
          10,30},{10,52}}, color={0,127,255}));
  connect(pipe4.port_b, pipe5.port_a) annotation (Line(points={{10,-28},{30,-28},
          {30,-60},{50,-60}}, color={0,127,255}));
  connect(pipe5.port_a, B3.ports[1])
    annotation (Line(points={{50,-60},{10,-60}}, color={0,127,255}));
  connect(pipe5.port_b, S2.ports[1])
    annotation (Line(points={{70,-60},{75,-60},{80,-60}}, color={0,127,255}));
  connect(pipe2.port_a, pipe4.port_a) annotation (Line(points={{-40,30},{-70,30},
          {-70,-28},{-10,-28}}, color={0,127,255}));
  connect(B1.ports[1], pipe1.port_a) annotation (Line(points={{-80,30},{-80,30},
          {-70,30},{-70,40}}, color={0,127,255}));
  connect(pipe2.port_a, pipe1.port_a)
    annotation (Line(points={{-40,30},{-70,30},{-70,40}}, color={0,127,255}));
  connect(pipe2.port_b, pipe3.port_b)
    annotation (Line(points={{-20,30},{30,30},{30,14}}, color={0,127,255}));
  connect(pipe3.port_a, pipe4.port_b)
    annotation (Line(points={{30,-6},{30,-28},{10,-28}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>One of the largest drawbacks of the reference network in <a
href=\"AixLib.Fluid.DistrictHeatingCooling.ReferenceNetworks.HydraulicValidation\">
AixLib.Fluid.DistrictHeatingCooling.ReferenceNetworks.HydraulicValidation</a> is
that the source [Larock et al., 2000] does not specify any pipe lengths and
diameters. This example approximates a similar network with comparable flows and
pressures using the <a href=\"AixLib.Fluid.FixedResistances.HydraulicDiameter\">
AixLib.Fluid.FixedResistances.HydraulicDiameter</a> model to represent the
pipes.</p>
<p>In addition, the original network connected the demand nodes directly into
the network nodes. To more closely approximate a test case for district heating,
additional pipes have been added to this model to represent the connection
pieces between the demand nodes and the rest of the network. </p>
<h4>Assumptions and limitations</h4>
<p>While this model is far from perfect, it may be helpful as a starting point
for developing new DHC component models. </p>
<h4>Validation</h4>
<p>Like in in <a
href=\"AixLib.Fluid.DistrictHeatingCooling.ReferenceNetworks.HydraulicValidation\">
AixLib.Fluid.DistrictHeatingCooling.ReferenceNetworks.HydraulicValidation</a>,
the outputs compare the relative deviations between the calculated pressures at
the demand nodes B1, B2, and B3 with the reference results given in Larock et
al. [2000]. The results show deviations below 5 percent. The deviation is mainly
caused by the newly introduced pipes 6-8. Without them, the deviations are below
0.4 percent. </p>
<h4>References</h4>
<ul>
<li><a href=\"https://www.crcpress.com/Hydraulics-of-Pipeline-Systems/Larock-Jeppson-Watters/p/book/9780849318061\">Larock, Bruce E., Roland W. Jeppson, and Gary Z. Watters. <i>Hydraulics of pipeline systems</i>. Boca Raton, FL: CRC Press, 2000.</a></li>
<li>AixLib issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/402\">#402</a></li>
</ul>
</html>", revisions="<html>
<ul>
  <li>
  May 26, 2017, by Marcus Fuchs:<br/>
  Implemented for <a href=\"https://github.com/RWTH-EBC/AixLib/issues/402\">issue 402</a>.
 </li>
</ul>
</html>"));
end HydraulicValidationPipes;
