within AixLib.FastHVAC.Components.HeatExchangers.Geothermal.BoreHoleHeatExchanger;
model UPipe "Discretized UPipe consisting of n UPipeElements"
  import SI = Modelica.SIunits;

  /// Model parameters ///
    // General
    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Used medium"                                                                      annotation (Dialog(group="General"), choicesAllMatching=true);
    parameter SI.Temperature T_start "Initial Temperature of UPipe-System"          annotation(Dialog(group="General"));
    parameter Integer n = 5 "Number of discretizations in axial direction" annotation(Dialog(group="General"));

    // Borehole
    parameter SI.Length boreholeDepth "Total depth of the borehole" annotation(Dialog(group="Borehole"));
    parameter SI.Diameter boreholeDiameter "Total diameter of the borehole" annotation(Dialog(group="Borehole"));
    parameter AixLib.DataBase.Materials.FillingMaterials.FillingMaterialBaseRecord boreholeFilling
    "Filling of the borehole"
    annotation (Dialog(group="Borehole"), choicesAllMatching=true);

    // Pipes
    parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition pipeType "Type of pipe" annotation (Dialog(group="Pipes"), choicesAllMatching=true);
    parameter Integer nParallel = 2 "1: U-Pipe, 2: Double-U-Pipe" annotation (Dialog(group="Pipes"));
    parameter SI.Diameter pipeCentreReferenceCircle = boreholeDiameter/2
    "Diameter of the reference circle on which the centres of all the pipes are arranged"               annotation(Dialog(group="Pipes"));

    // Deflection
    parameter Real zeta = 0.237
    "Pressure loss coefficient for pipe deflection at bottom of borehole"                                     annotation(Dialog(group="Deflection"));
    parameter Real m_flow_nominal = 5
    "nominal mass flow"                                     annotation(Dialog(group="Deflection"));

public
    Fluid.HeatExchangers.Geothermal.BaseClasses.UPipeElement uPipeElement[n](
    redeclare package Medium = Medium,
    each T_start=T_start,
    each fillingDensity=boreholeFilling.density,
    each fillingHeatCapacity=boreholeFilling.heatCapacity,
    each fillingThermalConductivity=boreholeFilling.thermalConductivity,
    each boreholeDiameter=boreholeDiameter,
    each pipeCentreReferenceCircle=pipeCentreReferenceCircle,
    each pipeType=pipeType,
    each length=boreholeDepth/n,
    each nParallel=nParallel)
    annotation (Placement(transformation(extent={{-41,-10},{33,34}})));

  Interfaces.EnthalpyPort_a enthalpyPort_a1
    annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
  Interfaces.EnthalpyPort_b enthalpyPort_b1
                annotation (Placement(transformation(extent={{10,70},{30,90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    thermalConnectors2Ground[n] annotation (Placement(transformation(extent=
           {{-50,10},{-30,30}}), iconTransformation(extent={{-50,10},{-30,
            30}})));

equation
  for i in 1:n-1 loop
    // periodical connection of the discretized elements
    connect(uPipeElement[i].portDownOut, uPipeElement[i+1].portDownIn);
    connect(uPipeElement[i].portUpIn, uPipeElement[i+1].portUpOut);
  end for;

  for i in 1:n loop
    // periodical connection of the heat port of each pipeElement
    connect(uPipeElement[i].externalHeatPort, thermalConnectors2Ground[i]);
  end for;

    // connecting the first element to the models in/out-port
  connect(enthalpyPort_a1, uPipeElement[1].portDownIn);
  connect(uPipeElement[1].portUpOut, enthalpyPort_b1);

    // connecting the last element to the deflection
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-80,-80},
            {80,80}})),           Icon(coordinateSystem(preserveAspectRatio=true,
          extent={{-80,-80},{80,80}}), graphics={
        Ellipse(
          extent={{-30,-68},{30,-8}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{-30,80},{-10,-40}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{10,80},{30,-40}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder),
        Ellipse(
          extent={{-10,-30},{10,-50}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,80},{10,-40}},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          lineColor={0,0,0}),
        Rectangle(
          extent={{-14,-52},{14,-72}},
          pattern=LinePattern.None,
          fillColor={255,255,0},
          fillPattern=FillPattern.Sphere,
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-12,-70},{-12,-54},{12,-70},{12,-54}},
          smooth=Smooth.None,
          color={0,0,0},
          thickness=1),
        Rectangle(
          extent={{-50,-12},{-30,8}},
          fillPattern=FillPattern.Solid,
          fillColor={184,0,0},
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-50,32},{-30,52}},
          fillPattern=FillPattern.Solid,
          fillColor={184,0,0},
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Text(
          extent={{12,36},{-12,68}},
          fillColor={184,0,0},
          fillPattern=FillPattern.Solid,
          textString="n",
          lineColor={0,0,0})}),
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview </span></h4>
<p>The model enables the creation of a borehole heat exchanger that is axially discretized. </p>
<p>It&rsquo;s primarily based on a multiple instantiation of the <b>UPipeElement</b> model and one instance of the <b>HydResistance</b> model out of the HVAC Library. </p>
<p>This model is created and thermally connected to a ground model to simulate one borehole heat exchanger. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Assumptions </span></h4>
<p>The deflection at the bottom of the heat exchanger is assumed by a hydraulic resistance with the pressure loss coefficient of a 180&deg; pipe bend. </p>
<h4><span style=\"color:#008000\">Known Limitations </span></h4>
<p>A thermal vertical connection between the borehole fillings of the different axial discretization layers is not provided. </p>
<p>The pressure loss coefficient in the deflection has to be given explicitly, it is not calculated from the given geometry. </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Source:</p>
<ul>
<li>Model developed as part of DA025 &QUOT;Modellierung und Simulation eines LowEx-Geb&auml;udes in der objektorientierten Programmiersprache Modelica&QUOT; by Tim Comanns</li>
</ul>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"HVAC.Examples.GeothermalField.Verification.RectangularGround_2Pipes\">HVAC.Examples.GeothermalField.Verification.RectangularGround_2Pipes</a></p>
<p><a href=\"HVAC.Examples.GeothermalField.Verification.RadialGround_1Pipe\">HVAC.Examples.GeothermalField.Verification.RadialGround_1Pipe</a></p>
</html>",
      revisions="<html>
<p><ul>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL</li>
<li><i>January 29, 2014&nbsp;</i> by Ana Constantin:<br/>Added to HVAC, formated and upgraded to current version of Dymola/Modelica</li>
<li><i>March 13, 2012&nbsp;</i> by Tim Comanns (supervisor: Ana Constantin):<br/>Implemented.</li>
</ul></p>
</html>"));
end UPipe;
