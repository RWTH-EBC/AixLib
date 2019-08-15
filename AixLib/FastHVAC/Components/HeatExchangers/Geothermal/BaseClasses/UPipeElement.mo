within AixLib.FastHVAC.Components.HeatExchangers.Geothermal.BaseClasses;
model UPipeElement
  "Heat capacity distributed. Small inner part inside of pipes, rest outward up until boreholeDiameter"
  import SI = Modelica.SIunits;

  /// Model parameters ///
    // General
  parameter SI.Temperature T_start "Initial Temperature of system" annotation (Dialog(group="General"));
  parameter FastHVAC.Media.BaseClasses.MediumSimple medium=
      FastHVAC.Media.WaterSimple()
    "Standard  charastics for water (heat capacity, density, thermal conductivity)"
    annotation (choicesAllMatching);

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
  Pipes.DynamicPipe           dynamicPipe1(
    medium=medium,
    T_0=T_start,
    length=length,
    diameter=pipeType.d_i,
    parameterPipe=pipeType,
    parameterIso=AixLib.DataBase.Pipes.Insulation.Iso0pc())
                 annotation (Placement(transformation(
        extent={{-24,-24},{24,24}},
        rotation=-90,
        origin={-40,54})));

  Pipes.DynamicPipe           dynamicPipe2(
    medium=medium,
    T_0=T_start,
    each length=length,
    each diameter=pipeType.d_i,
    each parameterPipe=pipeType,
    each parameterIso=AixLib.DataBase.Pipes.Insulation.Iso0pc())
                 annotation (Placement(transformation(
        extent={{-24,-24},{24,24}},
        rotation=90,
        origin={40,56})));

  Interfaces.EnthalpyPort_a             portDownIn
                "Inlet FluidPort of the downgoing pipe of the U-Pipe-Element"                                        annotation (Placement(transformation(extent={{-50,90},
            {-30,110}}),
                       iconTransformation(extent={{-40,90},{-20,110}})));
  Interfaces.EnthalpyPort_b             portUpOut
                "Outlet FluidPort of the upgoing pipe of the U-Pipe-Element"                                          annotation (Placement(transformation(extent={{30,90},
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
  Interfaces.EnthalpyPort_a             portUpIn
                "Inlet FluidPort of the upgoing pipe of the U-Pipe-Element"
    annotation (Placement(transformation(extent={{30,-30},{50,-10}}),
        iconTransformation(extent={{0,-20},{20,0}})));
  Interfaces.EnthalpyPort_b             portDownOut
                "Outlet FluidPort of the downgoing pipe of the U-Pipe-Element"
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}}),
        iconTransformation(extent={{-40,-20},{-20,0}})));
equation

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
  connect(dynamicPipe1.heatPort_outside, thermalCollector.port_a[1])
    annotation (Line(
      points={{-27.52,75.12},{-27.52,10},{-61.5,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(dynamicPipe2.heatPort_outside, thermalCollector.port_a[2])
    annotation (Line(
      points={{27.52,34.88},{18,34.88},{18,10},{-62.5,10}},
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
  connect(dynamicPipe1.heatPort_outside, cylindricHeatConduction1.port_b)
    annotation (Line(
      points={{-27.52,75.12},{-27.52,94},{-10,94},{-10,86.8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(dynamicPipe2.heatPort_outside, cylindricHeatConduction2.port_b)
    annotation (Line(
      points={{27.52,34.88},{27.52,74},{27.52,94},{10,94},{10,86.8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(portDownIn, dynamicPipe1.enthalpyPort_a1)
    annotation (Line(points={{-40,100},{-40,77.52}}, color={176,0,0}));
  connect(dynamicPipe1.enthalpyPort_b1, portDownOut)
    annotation (Line(points={{-40,30.48},{-40,-20}}, color={176,0,0}));
  connect(portUpIn, dynamicPipe2.enthalpyPort_a1)
    annotation (Line(points={{40,-20},{40,32.48}}, color={176,0,0}));
  connect(dynamicPipe2.enthalpyPort_b1, portUpOut)
    annotation (Line(points={{40,79.52},{40,100}}, color={176,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-120,
            -20},{80,100}},
        initialScale=0.2), graphics={Text(
          extent={{-50,118},{50,114}},
          lineColor={255,0,0},
          textString="Noch nicht für FastHVAC implementiert:
Doppel-U über nParallel=2 abgebildet")}),
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
