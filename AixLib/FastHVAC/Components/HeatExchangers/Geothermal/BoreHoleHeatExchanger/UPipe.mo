within AixLib.FastHVAC.Components.HeatExchangers.Geothermal.BoreHoleHeatExchanger;
model UPipe "Discretized UPipe consisting of n UPipeElements"
  import SI = Modelica.SIunits;

  /// Model parameters ///
    // General
    parameter SI.Temperature T_start[n] "Initial Temperature of UPipe-System"          annotation(Dialog(group="General"));
    parameter Integer n = 5 "Number of discretizations in axial direction" annotation(Dialog(group="General"));
    parameter FastHVAC.Media.BaseClasses.MediumSimple medium=
      FastHVAC.Media.WaterSimple()
      "Standard  charastics for water (heat capacity, density, thermal conductivity)"
    annotation (choicesAllMatching);

    // Borehole
    parameter SI.Length boreholeDepth "Total depth of the borehole" annotation(Dialog(group="Borehole"));
    parameter SI.Diameter boreholeDiameter "Total diameter of the borehole" annotation(Dialog(group="Borehole"));
    parameter AixLib.DataBase.Materials.FillingMaterials.FillingMaterialBaseRecord boreholeFilling
    "Filling of the borehole"
    annotation (Dialog(group="Borehole"), choicesAllMatching=true);

    // Pipes
    parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition pipeType "Type of pipe" annotation (Dialog(group="Pipes"), choicesAllMatching=true);
    parameter Integer nParallel(min=1, max=2)=2 "1: U-Pipe, 2: Double-U-Pipe" annotation (Dialog(group="Pipes"));
    parameter SI.Diameter pipeCentreReferenceCircle = boreholeDiameter/2
    "Diameter of the reference circle on which the centres of all the pipes are arranged"               annotation(Dialog(group="Pipes"));

public
    BaseClasses.UPipeElement                                 uPipeElement[n](
    n=n,
    each medium=medium,
    T_start=T_start,
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

    // connecting the last elements to each other
  connect(uPipeElement[n].portDownOut,uPipeElement[n].portUpIn);

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
        Text(
          extent={{12,36},{-12,68}},
          fillColor={184,0,0},
          fillPattern=FillPattern.Solid,
          textString="n",
          lineColor={0,0,0})}),
    Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview </span></h4>
<p>The model enables the creation of a borehole heat exchanger that is axially discretized. </p>
<p>It&apos;s a FastHVAC porting of the existing <b>UPipe </b>from the Fluid Library.</p>
<p>For detailed information please see the original model <a href=\"AixLib.Fluid.HeatExchangers.Geothermal.BoreHoleHeatExchanger.UPipe\">AixLib.Fluid.HeatExchangers.Geothermal.BoreHoleHeatExchanger.UPipe</a>.</p>
<h4><span style=\"color: #008000\">References</span></h4>
<h4><span style=\"color: #008000\">Example Results</span></h4>
<p><a href=\"AixLib.FastHVAC.Examples.HeatExchangers.RectangularGround_2Pipes\">AixLib.FastHVAC.Examples.HeatExchangers.RectangularGround_2Pipes</a></p>
<p><a href=\"AixLib.FastHVAC.Examples.HeatExchangers.RadialGround1Pipe\">AixLib.FastHVAC.Examples.HeatExchangers.RadialGround1Pipe</a> </p>
</html>",
      revisions="<html>
<p><ul>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL</li>
<li><i>January 29, 2014&nbsp;</i> by Ana Constantin:<br/>Added to HVAC, formated and upgraded to current version of Dymola/Modelica</li>
<li><i>March 13, 2012&nbsp;</i> by Tim Comanns (supervisor: Ana Constantin):<br/>Implemented.</li>
</ul></p>
</html>"));
end UPipe;
