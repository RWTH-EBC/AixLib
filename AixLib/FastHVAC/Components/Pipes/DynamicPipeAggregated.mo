within AixLib.FastHVAC.Components.Pipes;
model DynamicPipeAggregated


  parameter Integer nNodes(min=3)=3 "Number of discrete flow volumes";

  /* *******************************************************************
      Medium
     ******************************************************************* */

    parameter Modelica.SIunits.Temperature T_0=Modelica.SIunits.Conversions.from_degC(20)
    "Initial temperature of fluid";
    parameter Boolean selectable=true "Pipe record";
    parameter FastHVAC.Media.BaseClass.MediumSimple medium=
      FastHVAC.Media.WaterSimple()
    "Mediums charastics  (heat capacity, density, thermal conductivity)"
    annotation(choicesAllMatching);
protected
    parameter Modelica.SIunits.Volume  V_fluid= Modelica.Constants.pi*length*innerDiameter*innerDiameter/4;

    /* *******************************************************************
      Pipe Parameters
     ******************************************************************* */

    parameter Modelica.SIunits.Diameter innerDiameter=(if selectable then parameterPipe.d_i else diameter)
    "Inner diameter of  pipe";
    parameter Modelica.SIunits.Diameter outerDiameter=(if selectable then parameterPipe.d_o else innerDiameter+2*s_pipeWall)
    "Outer diameter of  pipe";
    parameter Modelica.SIunits.Density d=(if selectable then parameterPipe.d else rho_pipeWall)
    "Density of pipe material";
    parameter Modelica.SIunits.SpecificHeatCapacity c=(if selectable then parameterPipe.c else c_pipeWall)
    "Heat capacity of pipe material";
    parameter Modelica.SIunits.ThermalConductivity lambda= (if selectable then parameterPipe.lambda else lambda_pipeWall)
    "Thermal Conductivity of pipe material";

public
    parameter Modelica.SIunits.Length length=1 "Length of pipe"
       annotation(Dialog(group = "Geometry"));
    parameter Modelica.SIunits.Diameter diameter= 0.01
    "Inner diameter of  pipe (if selectable=false)"
    annotation (Dialog(group = "Geometry",enable=not selectable));
    parameter Modelica.SIunits.Density rho_pipeWall= 8900
    "Density of pipe material (if selectable=false)"
    annotation (Dialog(group = "Pipe material",enable=not selectable));
    parameter Modelica.SIunits.Thickness s_pipeWall = 0.001
    "Thickness of pipe wall (if selectable=false)"
    annotation (Dialog(group = "Geometry", enable=not selectable));
    parameter Modelica.SIunits.SpecificHeatCapacity c_pipeWall= 390
    "Heat capacity of pipe material (if selectable=false)"
    annotation (Dialog(group = "Pipe material",enable=not selectable));
    parameter Modelica.SIunits.ThermalConductivity lambda_pipeWall= 393
    "Thermal Conductivity of pipe material (if selectable=false)"
    annotation (Dialog(group = "Pipe material",enable=not selectable));
    parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition parameterPipe=
      AixLib.DataBase.Pipes.Copper.Copper_6x1() "Type of pipe"
    annotation (Dialog(enable=selectable), choicesAllMatching=true);

    parameter AixLib.DataBase.Pipes.IsolationBaseDataDefinition
                                                   parameterIso=
                 AixLib.DataBase.Pipes.Isolation.Iso100pc() "Type of Insulation"
                   annotation (choicesAllMatching=true);

  /* *******************************************************************
      Components
     ******************************************************************* */

  Utilities.HeatTransfer.CylindricHeatTransfer
    pipeWall[ nNodes](
    rho=fill(d, nNodes),
    c=fill(c, nNodes),
    d_out=fill(outerDiameter, nNodes),
    d_in=fill(innerDiameter, nNodes),
    length=fill(length/nNodes, nNodes),
    lambda=fill(lambda, nNodes),
    T0=fill(T_0, nNodes)) annotation (Placement(transformation(extent={{-10,22},
            {10,42}})));

  Utilities.HeatTransfer.CylindricHeatTransfer
    insulation[ nNodes](
    d_out=fill(outerDiameter*parameterIso.factor*2 + outerDiameter, nNodes),
    d_in=fill(outerDiameter, nNodes),
    length=fill(length/nNodes, nNodes),
    lambda=fill(parameterIso.lambda, nNodes),
    rho=fill(parameterIso.d, nNodes),
    c=fill(parameterIso.c, nNodes),
    T0=fill(T_0, nNodes))
    annotation (Placement(transformation(extent={{-10,48},{10,68}})));

  FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a1 annotation (Placement(
        transformation(extent={{-106,-10},{-86,10}}), iconTransformation(extent=
           {{-106,-10},{-86,10}})));
  FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b1 annotation (Placement(
        transformation(extent={{86,-10},{106,10}}), iconTransformation(extent={{
            86,-10},{106,10}})));

  Modelica.Fluid.Interfaces.HeatPorts_a heatPorts[nNodes]
    annotation (Placement(transformation(extent={{-22,80},{18,88}}),
        iconTransformation(extent={{-42,40},{44,58}})));
  FastHVAC.Components.Pipes.BaseClasses.PipeBase pipeBase(
    medium=medium,
    parameterPipe=parameterPipe,
    T_0=T_0,
    nNodes=nNodes,
    length=length)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
equation

  connect(pipeBase.enthalpyPort_a1, enthalpyPort_a1) annotation (Line(
      points={{-19.6,0},{-96,0}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(pipeBase.enthalpyPort_b1, enthalpyPort_b1) annotation (Line(
      points={{19.6,0},{96,0}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(pipeWall.port_b,insulation.port_a)  annotation (Line(
      points={{0,40.8},{0,58}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(insulation.port_b, heatPorts) annotation (Line(
      points={{0,66.8},{0,84},{-2,84}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pipeWall.port_a, pipeBase.heatPorts) annotation (Line(
      points={{0,32},{0,9.8},{-0.2,9.8}},
      color={191,0,0},
      smooth=Smooth.None));
    annotation (choicesAllMatching,
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}),
                                      graphics={
        Rectangle(
          extent={{-100,40},{100,-40}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-106,12},{-86,-12}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,0}),
        Ellipse(
          extent={{86,12},{106,-12}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,0}),
        Line(
          points={{-86,-60},{86,-60},{56,-50},{86,-60},{56,-70}},
          color={176,0,0},
          smooth=Smooth.None,
          thickness=0.5),
        Text(
          extent={{-40,14},{40,-12}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,0},
          textString="%nNodes"),
        Text(
          extent={{-68,-70},{76,-90}},
          lineColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Dynamic Pipe with pipe wall and insulation wall which allows discretisation of pipe wall and pipe insulation.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/> </p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>For each discretisation of the pipe, there is a connector to the corresponding element of the discretized pipe wall. Each element of the discretised pipe wall is connected to a corresponding element of the discretized insulation wall. </p>
<p>The outside heat port is a multiple heat port.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"FastHVAC.Examples.Pipes.DynamicPipeAggregated\">DynamicPipeAggregated</a></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>February 10, 2015</i> by Konstantin Finkbeiner:<br/>Addapted to FastHVAC</li>
<li><i>June 21, 2014&nbsp;</i> by Ana Constantin:<br/>Removed nParallel parameter.</li>
<li><i>November 13, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>August 3, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>"));
end DynamicPipeAggregated;
