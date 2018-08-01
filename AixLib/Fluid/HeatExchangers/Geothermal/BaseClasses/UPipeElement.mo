within AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses;
model UPipeElement
  "Heat capacity distributed. Small inner part inside of pipes, rest outward up until boreholeDiameter"
  import SI = Modelica.SIunits;

  /// Model parameters ///
    // General
    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Used medium"                                                                      annotation (Dialog(group="General"), choicesAllMatching=true);
    parameter SI.Temperature T_start "Initial Temperature of system" annotation (Dialog(group="General"));

    // Borehole
    parameter SI.Diameter boreholeDiameter = 0.135 "Diameter of borehole" annotation(Dialog(group="Borehole"));
    parameter SI.Diameter pipeCentreReferenceCircle = 0.075
    "Diameter of the reference cirle on which the centre of each pipe is arranged" annotation(Dialog(group="Borehole"));

    parameter SI.Density fillingDensity = fillingDensity
    "Density of borehole filling"                                                      annotation(Dialog(group="Borehole"));
    parameter SI.SpecificHeatCapacity fillingHeatCapacity = fillingHeatCapacity
    "Specific heatcapacity of borehole filling"                                                              annotation(Dialog(group="Borehole"));
    parameter SI.ThermalConductivity fillingThermalConductivity = fillingThermalConductivity
    "Thermal conductivity of borehole filling"                                                                   annotation(Dialog(group="Borehole"));

    // Pipes
    parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition pipeType=pipeType
    "Type of pipe" annotation (Dialog(group="Pipes"), choicesAllMatching=true);
    parameter Integer nParallel = 2 "1: U-Pipe, 2: Double-U-Pipe" annotation (Dialog(group="Pipes"));
    parameter SI.Length length = 1 "Length of the pipe element" annotation(Dialog(group="Pipes"));

    // Implicit values

    Real pi = Modelica.Constants.pi;

  /// Object Generation ///
  FixedResistances.Pipe pipeDown(
    redeclare package Medium = Medium,
    length=length,
    diameter=pipeType.d_i,
    height_ab=-length,
    parameterPipe=pipeType,
    parameterIso=AixLib.DataBase.Pipes.Insulation.Iso0pc(),
    T_start=T_start,
    nNodes=2,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_vb,
    nParallel=nParallel,
    use_HeatTransferConvective=true,
    Heat_Loss_To_Ambient=true,
    redeclare model HeatTransferConvective =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer,
    isEmbedded=true,
    alpha_i=500)                      annotation (Placement(transformation(
        extent={{-24,-24},{24,24}},
        rotation=-90,
        origin={-40,56})));

  FixedResistances.Pipe pipeUp(
    redeclare package Medium = Medium,
    each length=length,
    each diameter=pipeType.d_i,
    each height_ab=length,
    each use_HeatTransferConvective=true,
    each parameterPipe=pipeType,
    each parameterIso=AixLib.DataBase.Pipes.Insulation.Iso0pc(),
    T_start=T_start,
    nNodes=2,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_vb,
    nParallel=nParallel,
    Heat_Loss_To_Ambient=true,
    redeclare model HeatTransferConvective =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer,
    isEmbedded=true,
    alpha_i=500)         annotation (Placement(transformation(
        extent={{-24,-24},{24,24}},
        rotation=90,
        origin={40,56})));

  Modelica.Fluid.Interfaces.FluidPort_a portDownIn(redeclare package Medium =
        Medium) "Inlet FluidPort of the downgoing pipe of the U-Pipe-Element"                                        annotation (Placement(transformation(extent={{-50,90},
            {-30,110}}),
                       iconTransformation(extent={{-40,90},{-20,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b portUpOut(redeclare package Medium =
        Medium) "Outlet FluidPort of the upgoing pipe of the U-Pipe-Element"                                          annotation (Placement(transformation(extent={{30,90},
            {50,110}}),
        iconTransformation(extent={{0,90},{20,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a externalHeatPort
    annotation (Placement(transformation(extent={{-124,70},{-104,90}}),
        iconTransformation(extent={{-80,40},{-60,60}})));

  Utilities.HeatTransfer.CylindricHeatTransfer                       cylindricLoad(
    length=length,
    rho=fillingDensity,
    c=fillingHeatCapacity,
    d_out=pipeCentreReferenceCircle - pipeType.d_o,
    T0=T_start,
    d_in=0.0001) "Cylindric Load inside the reference circle of the pipes"
    annotation (Placement(transformation(extent={{-10,26},{10,46}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector
    thermalCollector(m=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-72,10})));
  Utilities.HeatTransfer.CylindricHeatTransfer                       cylindricHeatTransfer(
    rho=fillingDensity,
    c=fillingHeatCapacity,
    d_out=boreholeDiameter,
    lambda=fillingThermalConductivity,
    T0=T_start,
    length=length,
    d_in=sqrt((2*nParallel*pipeType.d_o*pipeType.d_o) + ((
        pipeCentreReferenceCircle - pipeType.d_o)*(pipeCentreReferenceCircle -
        pipeType.d_o))))
    "Heat transfer from the pipes towards the borehole outside"
    annotation (Placement(transformation(extent={{-92,58},{-72,78}})));
  Utilities.HeatTransfer.CylindricHeatConduction                       cylindricHeatConduction1(
    lambda=fillingThermalConductivity,
    length=length,
    d_in=0.001,
    d_out=pipeCentreReferenceCircle - pipeType.d_o)
    "From downwards pipe towards the centre of the borehole"
    annotation (Placement(transformation(extent={{-20,68},{0,88}})));
  Utilities.HeatTransfer.CylindricHeatConduction                       cylindricHeatConduction2(
    lambda=fillingThermalConductivity,
    length=length,
    d_in=0.001,
    d_out=pipeCentreReferenceCircle - pipeType.d_o)
    "From upwards pipe towards the centre of the borehole"
    annotation (Placement(transformation(extent={{0,68},{20,88}})));
  Modelica.Fluid.Interfaces.FluidPort_a portUpIn(redeclare package Medium =
        Medium) "Inlet FluidPort of the upgoing pipe of the U-Pipe-Element"
    annotation (Placement(transformation(extent={{30,-30},{50,-10}}),
        iconTransformation(extent={{0,-20},{20,0}})));
  Modelica.Fluid.Interfaces.FluidPort_b portDownOut(redeclare package Medium =
        Medium) "Outlet FluidPort of the downgoing pipe of the U-Pipe-Element"
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}}),
        iconTransformation(extent={{-40,-20},{-20,0}})));
equation

  connect(portDownIn, pipeDown.port_a) annotation (Line(
      points={{-40,100},{-40,80.96}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(portUpOut, pipeUp.port_b) annotation (Line(
      points={{40,100},{40,80.96}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipeDown.port_b, portDownOut) annotation (Line(
      points={{-40,31.04},{-40,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(portUpIn, pipeUp.port_a) annotation (Line(
      points={{40,-20},{40,31.04}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(cylindricHeatConduction1.port_a,cylindricLoad.port_a)  annotation (
      Line(
      points={{-10,78.4},{-6,78.4},{-6,36},{0,36}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(cylindricHeatConduction2.port_a,cylindricLoad.port_a)  annotation (
      Line(
      points={{10,78.4},{6,78.4},{6,36},{0,36}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pipeDown.heatPort_outside, thermalCollector.port_a[1]) annotation (
      Line(
      points={{-26.56,52.16},{-26.56,34},{-26.56,10},{-61.5,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pipeUp.heatPort_outside, thermalCollector.port_a[2]) annotation (Line(
      points={{26.56,59.84},{18,59.84},{18,10},{-62.5,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalCollector.port_b,cylindricHeatTransfer.port_a)  annotation (
      Line(
      points={{-82,10},{-82,68}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(cylindricHeatTransfer.port_b, externalHeatPort) annotation (Line(
      points={{-82,76.8},{-98,76.8},{-98,80},{-114,80}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pipeDown.heatPort_outside,cylindricHeatConduction1.port_b)
    annotation (Line(
      points={{-26.56,52.16},{-26.56,94},{-10,94},{-10,86.8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pipeUp.heatPort_outside,cylindricHeatConduction2.port_b)
    annotation (Line(
      points={{26.56,59.84},{26.56,74},{26.56,94},{10,94},{10,86.8}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-120,
            -20},{80,100}},
        initialScale=0.2), graphics={Text(
          extent={{-50,118},{50,114}},
          lineColor={255,0,0},
          textString="Doppel-U über nParallel=2 abgebildet")}),
                                   Icon(coordinateSystem(preserveAspectRatio=true,
          extent={{-120,-20},{80,100}},
        initialScale=0.2), graphics={
        Rectangle(
          extent={{0,100},{20,-10}},
          pattern=LinePattern.None,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={47,51,253}),
        Rectangle(
          extent={{-40,100},{-20,-10}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={47,51,253})}),
    Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>This submodel is used to create an axially discretized model of a U-Pipe or Double-U-Pipe borehole heat exchanger </p>
<p>It&rsquo;s based on two <b>DynamicPipeEBC</b> models as well as <b>CylindricLoad</b>, <b>CylindricHeatTransfer</b> and <b>CylindricHeatConduction</b> out of the HVAC Library. All other objects are standard Modelica models. </p>
<p>This model is not used by itself but serves as one axial element in the bigger model UPipe </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Assumptions </span></h4>
<ol>
<li>A Double-U-Pipe is created by using the parameter <i>nParallel</i> of <b>DynamicPipeEBC</b> </li>
<li>The heat capacity or mass of the borehole filling is distributed between two areas. A smaller part is assumed between the pipes. The actual sizes derives from the <i>pipeReferenceCircle</i> as well as the diameter of the pipes. The correct corresponding second part is assumed between the outer diameter of the borehole and a calculated inner diameter that does not correspond with any real geometry. </li>
</ol>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Source:</p>
<ul>
<li>Model developed as part of DA025 &QUOT;Modellierung und Simulation eines LowEx-Geb&auml;udes in der objektorientierten Programmiersprache Modelica&QUOT; by Tim Comanns</li>
</ul>
</html>",
      revisions="<html>
<p><ul>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL</li>
<li><i>January 29, 2014&nbsp;</i> by Ana Constantin:<br/>Added to HVAC, formated and upgraded to current version of Dymola/Modelica</li>
<li><i>March 13, 2012&nbsp;</i> by Tim Comanns (supervisor: Ana Constantin):<br/>Implemented.</li>
</ul></p>
</html>"));
end UPipeElement;
