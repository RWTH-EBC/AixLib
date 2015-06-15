within AixLib.Fluid.MixingVolumes;
model HydraulicSeparator
  import Modelica.Blocks.Math;
  import AixLib;

    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the component"                                                             annotation (choicesAllMatching = true);

    ///////////////////////////////////////////////////////////////////////////
    //Geometric parameters                                                   //
    ///////////////////////////////////////////////////////////////////////////
  parameter Modelica.SIunits.VolumeFlowRate pumpMaxVolumeFlow=0.003
    "Maximum VolumeFlowRate of either primary or secondary Pump";
  parameter Modelica.SIunits.Velocity vmaxExchange=0.2
    "Maximum velocity of the exchange-flow between top and bottom of the Hydraulic Separator";
  parameter Modelica.SIunits.Diameter DFlange "Diameter of the flanges";
  parameter Modelica.SIunits.Diameter D = sqrt(pumpMaxVolumeFlow*4/(Modelica.Constants.pi*vmaxExchange))
    "Diameter of the main-body";

    ///////////////////////////////////////////////////////////////////////////
    //Pipes including main body and flanges                                  //
    ///////////////////////////////////////////////////////////////////////////
  AixLib.Fluid.FixedResistances.StaticPipe staticPipe_primary_return(
    redeclare package Medium = Medium,
    D=DFlange,
    l=0.05,
    m_flow_small=1e-4)
    annotation (Placement(transformation(extent={{-28,-70},{-48,-50}})));
  AixLib.Fluid.FixedResistances.StaticPipe staticPipe_primary_flow(
    D=DFlange,
    l=0.05,
    m_flow_small=1e-4,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-54,50},{-34,70}})));
  AixLib.Fluid.FixedResistances.StaticPipe staticPipe4(D=D, l=1.5*D,
    m_flow_small=1e-4,
    redeclare package Medium = Medium)                               annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,26})));
  AixLib.Fluid.FixedResistances.StaticPipe staticPipe5(D=D, l=1.5*D,
    m_flow_small=1e-4,
    redeclare package Medium = Medium)                               annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-26})));

  AixLib.Fluid.FixedResistances.Pipe pipe_secondary_flow(
    D=DFlange,
    l=0.05,
    m_flow_small=1e-4,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{48,-70},{28,-50}})));
  AixLib.Fluid.FixedResistances.Pipe pipe_secondary_return(
    D=DFlange,
    l=0.05,
    m_flow_small=1e-4,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{28,70},{48,50}})));

    ///////////////////////////////////////////////////////////////////////////
    //Measurement of water exchanged between primary and secondary circuit   //
    ///////////////////////////////////////////////////////////////////////////
  AixLib.Fluid.Sensors.MassFlowRate massFlowSensor(redeclare package Medium =
        Medium)                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,0})));

  Modelica.Blocks.Interfaces.RealOutput waterExchange annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,90})));

    ///////////////////////////////////////////////////////////////////////////
    //Thermal Conductor to simulate heat exchange between layers when there  //
    //is no exchange of mass between primary and secondary circuit           //
    ///////////////////////////////////////////////////////////////////////////
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=0.59*(D
        ^2/4*Modelica.Constants.pi)/(3*D))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={38,2})));
///////////////////////////////////////////////////////////////////////////
    //Ports/ Flanges                                                         //
    ///////////////////////////////////////////////////////////////////////////
  Modelica.Fluid.Interfaces.FluidPort_a port_a_primary(redeclare package Medium
      = Medium)
    annotation (Placement(transformation(extent={{-114,50},{-94,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_secondary(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{94,-70},{114,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_secondary(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{94,50},{114,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_primary(redeclare package Medium
      = Medium)
    annotation (Placement(transformation(extent={{-114,-70},{-94,-50}})));
equation
  connect(staticPipe4.port_a, massFlowSensor.port_b) annotation (Line(
      points={{-5.55112e-016,16},{0,16},{0,10},{5.55112e-016,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(massFlowSensor.port_a, staticPipe5.port_b) annotation (Line(
      points={{0,-10},{0,-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(massFlowSensor.m_flow, waterExchange) annotation (Line(
      points={{-11,0},{-16,0},{-16,84},{0,84},{0,90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(thermalConductor.port_b, pipe_secondary_return.heatport) annotation (
      Line(
      points={{38,12},{38,55}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalConductor.port_a, pipe_secondary_flow.heatport) annotation (
      Line(
      points={{38,-8},{38,-55}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(staticPipe4.port_b, pipe_secondary_return.port_a) annotation (Line(
      points={{0,36},{0,60},{28,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(staticPipe5.port_a, pipe_secondary_flow.port_b) annotation (Line(
      points={{0,-36},{0,-60},{28,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(staticPipe_primary_flow.port_b, pipe_secondary_return.port_a)
    annotation (Line(
      points={{-34,60},{28,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(staticPipe_primary_return.port_a, pipe_secondary_flow.port_b)
    annotation (Line(
      points={{-28,-60},{28,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_a_primary, staticPipe_primary_flow.port_a) annotation (Line(
      points={{-104,60},{-54,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe_secondary_return.port_b, port_b_secondary) annotation (Line(
      points={{48,60},{104,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_a_secondary, pipe_secondary_flow.port_a) annotation (Line(
      points={{104,-60},{48,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(staticPipe_primary_return.port_b, port_b_primary) annotation (Line(
      points={{-48,-60},{-104,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-34,70},{34,-80}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),
        Polygon(
          points={{-34,70},{-34,-40},{34,20},{34,70},{-34,70}},
          lineColor={255,0,0},
          smooth=Smooth.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,60},{-34,40}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{60,60},{34,40}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{60,-40},{34,-60}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,-40},{-34,-60}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,60},{-34,60},{-34,70},{34,70},{34,60},{60,60},{60,40},{34,
              40},{34,-40},{60,-40},{60,-60},{34,-60},{34,-80},{-34,-80},{-34,-60},
              {-60,-60},{-60,-40},{-34,-40},{-34,40},{-60,40},{-60,60}},
          lineColor={0,0,0},
          smooth=Smooth.None)}),Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>The component Hydraulic Separator is used to hydraulically decouple the heating circuit from the consumer circuit. It is basically a big cylinder with four flanges to mount the primary and secondary circuit. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<p>There is no pressure-drop inside the water volume because of the weight of the water.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>A Hydraulic Separator should have a diameter that allows a maximum velocity of 0.2 m/s (vmaxExchange) for the water exchanged between the top and bottom layer in order to prevent turbulences. The diameter of the main body is therefore calculated with the help of the maximum VolumeFlowRate in either primary or secondary circuit. This is done by the model itself. The height of the Hydraulic Separator is calculated according to VDMA 24770 also depending on the maximum VolumeFlowRate. The model therefore simulates a Hydraulic Separator which is suitable for the circuit used. The size of the flanges has to be set by the user. </p>
<p><br><b><font style=\"color: #008000; \">References</font></b></p>
<p><a href=\"http://www.sinusverteiler.com/files/ausgleich_von_last_und_leistung_01.pdf\">Catalogue Sinusverteiler (Explanation of design and function)</a> </p>
<p><b><font style=\"color: #008000; \">Example Results</font></b> </p>
<p><a href=\"AixLib.Fluid.MixingVolumes.Examples.HydraulicSeparator\">AixLib.Fluid.MixingVolumes.Examples.HydraulicSeparator</a></p>
</html>",
        revisions="<html>
<p>26.11.2014, by <i>Roozbeh Sangi</i>: implemented </p>
</html>"));
end HydraulicSeparator;
