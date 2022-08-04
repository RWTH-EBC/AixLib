within AixLib.Fluid.MixingVolumes;
model HydraulicSeparator
  import Modelica.Blocks.Math;
  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);
  parameter Boolean allowFlowReversal=true;

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal
    "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));

    ///////////////////////////////////////////////////////////////////////////
    //Geometric parameters                                                   //
    ///////////////////////////////////////////////////////////////////////////
  parameter Modelica.Units.SI.VolumeFlowRate pumpMaxVolumeFlow
    "Maximum VolumeFlowRate of either primary or secondary Pump";
  parameter Modelica.Units.SI.Velocity vmaxExchange=0.2
    "Maximum velocity of the exchange-flow between top and bottom of the Hydraulic Separator";
  parameter Modelica.Units.SI.Diameter DFlange "Diameter of the flanges";
  parameter Modelica.Units.SI.Diameter D=sqrt(pumpMaxVolumeFlow*4/(Modelica.Constants.pi
      *vmaxExchange))
    "Diameter of the main-body (Calculated by the model to not exceed vmaxExchang)";

    ///////////////////////////////////////////////////////////////////////////
    //Initialization of temperatures                                         //
    ///////////////////////////////////////////////////////////////////////////
  parameter Modelica.Units.SI.Temperature T_top=293.15
    "Initial temperature in the top" annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Temperature T_bottom=293.15
    "Initial temperature in the bottom"
    annotation (Dialog(tab="Initialization"));

    ///////////////////////////////////////////////////////////////////////////
    //Measurement of water exchanged between primary and secondary circuit   //
    ///////////////////////////////////////////////////////////////////////////
  Modelica.Blocks.Interfaces.RealOutput waterExchange
    "Measurement of water exchanged between primary and secondary circuit"
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,90})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        Medium)        annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={2,2})));

    ///////////////////////////////////////////////////////////////////////////
    //Ports/ Flanges                                                         //
    ///////////////////////////////////////////////////////////////////////////
  Modelica.Fluid.Interfaces.FluidPort_a port_a_primary(redeclare package Medium =
        Medium) "Top-flange primary circuit" annotation (Placement(
        transformation(extent={{-110,40},{-90,60}}), iconTransformation(extent={
            {-110,40},{-90,60}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_secondary(redeclare package Medium =
               Medium) "Bottom-flange secondary circuit" annotation (Placement(
        transformation(extent={{90,-60},{110,-40}}), iconTransformation(extent={
            {90,-60},{110,-40}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_secondary(redeclare package Medium =
               Medium) "Top-flange secondary circuit" annotation (Placement(
        transformation(extent={{90,40},{110,60}}), iconTransformation(extent={{90,
            40},{110,60}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_primary(redeclare package Medium =
        Medium) "Bottom-flange primary circuit" annotation (Placement(
        transformation(extent={{-110,-60},{-90,-40}}), iconTransformation(
          extent={{-110,-60},{-90,-40}})));

    ///////////////////////////////////////////////////////////////////////////
    //Pipes including main body and flanges                                  //
    ///////////////////////////////////////////////////////////////////////////
  Modelica.Fluid.Pipes.StaticPipe primaryFlow(
    diameter=DFlange,
    length=0.05,
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-54,40},{-34,60}})));
  Modelica.Fluid.Pipes.StaticPipe primaryReturn(
    diameter=DFlange,
    length=0.05,
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-36,-60},{-56,-40}})));

  Modelica.Fluid.Pipes.StaticPipe pipe4(diameter=D, length=1.5*D,
    redeclare package Medium = Medium,
    height_ab=1.5*D) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={2,-32})));
  Modelica.Fluid.Pipes.StaticPipe pipe5(length=1.5*D,
    redeclare package Medium = Medium,
    height_ab=1.5*D,
    diameter=D)      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={2,26})));
  Modelica.Fluid.Pipes.DynamicPipe      secondaryFlow(
    diameter=DFlange,
    length=0.05,
    redeclare package Medium = Medium,
    use_T_start=true,
    T_start=T_bottom,
    allowFlowReversal=allowFlowReversal,
    use_HeatTransfer=true)
    annotation (Placement(transformation(extent={{58,-60},{38,-40}})));
  Modelica.Fluid.Pipes.DynamicPipe      secondaryReturn(
    diameter=DFlange,
    length=0.05,
    redeclare package Medium = Medium,
    use_T_start=true,
    T_start=T_top,
    allowFlowReversal=allowFlowReversal,
    use_HeatTransfer=true)
    annotation (Placement(transformation(extent={{38,60},{58,40}})));
    ///////////////////////////////////////////////////////////////////////////
    //Thermal Conductor to simulate heat exchange between layers when there  //
    //is no exchange of mass between primary and secondary circuit           //
    ///////////////////////////////////////////////////////////////////////////
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=0.59*(D
        ^2/4*Modelica.Constants.pi)/(3*D))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={48,2})));

    ///////////////////////////////////////////////////////////////////////////
    //Volumes determining time scale of dynamic behaviour                    //
    ///////////////////////////////////////////////////////////////////////////
  MixingVolume                        volume2(
    redeclare package Medium = Medium,
    nPorts=2,
    T_start=T_bottom,
    V=(Modelica.Constants.pi/4)*D*D*DFlange*0.5,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-10,64})));
  MixingVolume                        volume1(
    redeclare package Medium = Medium,
    nPorts=2,
    T_start=T_bottom,
    V=(Modelica.Constants.pi/4)*D*D*DFlange*0.5,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-8,-68})));

equation
  connect(port_a_primary, primaryFlow.port_a) annotation (Line(
      points={{-100,50},{-54,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_b_primary, primaryReturn.port_b) annotation (Line(
      points={{-100,-50},{-56,-50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(massFlowRate.m_flow, waterExchange) annotation (Line(
      points={{-9,2},{-22,2},{-22,90},{0,90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(massFlowRate.port_b, pipe5.port_a) annotation (Line(
      points={{2,12},{2,16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe4.port_b, massFlowRate.port_a) annotation (Line(
      points={{2,-22},{2,-8}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(secondaryReturn.port_b, port_b_secondary) annotation (Line(
      points={{58,50},{100,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(secondaryFlow.port_a, port_a_secondary) annotation (Line(
      points={{58,-50},{100,-50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(secondaryFlow.port_b, pipe4.port_a) annotation (Line(
      points={{38,-50},{2,-50},{2,-42}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume1.ports[1], pipe4.port_a) annotation (Line(
      points={{-10,-58},{-10,-50},{2,-50},{2,-42}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(primaryReturn.port_a, volume1.ports[2]) annotation (Line(
      points={{-36,-50},{-12,-50},{-12,-58},{-6,-58}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(primaryFlow.port_b, volume2.ports[1]) annotation (Line(
      points={{-34,50},{-12,50},{-12,54}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume2.ports[2], secondaryReturn.port_a) annotation (Line(
      points={{-8,54},{-12,54},{-12,50},{38,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe5.port_b, secondaryReturn.port_a) annotation (Line(
      points={{2,36},{2,50},{38,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(secondaryReturn.heatPorts[1], thermalConductor.port_b)
    annotation (Line(points={{48.1,45.6},{48,12}}, color={127,0,0}));
  connect(secondaryFlow.heatPorts[1], thermalConductor.port_a)
    annotation (Line(points={{47.9,-45.6},{48,-8}}, color={127,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),                Icon(coordinateSystem(
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
          smooth=Smooth.None)}),Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The component HydraulicSeparator is used to hydraulically decouple
  the heating circuit from the consumer circuit. It is basically a big
  cylinder with four flanges to mount the primary and secondary
  circuit.
</p>
<h4>
  <span style=\"color:#008000\">Assumptions</span>
</h4>
<p>
  The HydraulicSeparator is a vertical zylinder with two flanges
  attached to the top and two attached to the bottom.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  A HydraulicSeparator should have a diameter that allows a maximum
  velocity of 0.2 m/s (vmaxExchange)for the water exchanged between the
  top and bottom layer in order to prevent turbulences. The diameter of
  the main body is therefore calculated with the help of the maximum
  VolumeFlowRate in either primary or secondary circuit. This is done
  by the model itself. The height of the HydraulicSeparator is
  calculated according to VDMA 24770 also depending on the maximum
  VolumeFlowRate. The model therefore simulates a HydraulicSeparator
  which is suitable for the circuit used. The size of the flanges has
  to be set by the user.
</p>
<p>
  <br/>
  <b><span style=\"color: #008000\">References</span></b>
</p>
<p>
  <a href=
  \"http://www.sinusverteiler.com/files/ausgleich_von_last_und_leistung_01.pdf\">
  Catalogue Sinusverteiler (Explanation of design and function)</a>
</p>
</html>",
        revisions="<html><ul>
  <li>
    <i>October 11, 2016&#160;</i> by Marcus Fuchs:<br/>
    Transferred alternative version
  </li>
  <li>
    <i>November 26, 2014&#160;</i> by Roozbeh Sangi:<br/>
    implemented
  </li>
</ul>
</html>"));
end HydraulicSeparator;
