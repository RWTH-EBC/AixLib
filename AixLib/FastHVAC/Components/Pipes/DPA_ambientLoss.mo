within AixLib.FastHVAC.Components.Pipes;
model DPA_ambientLoss "Discretized DynamicPipe with heat loss to ambient"


  parameter Integer nNodes(min=1)=3 "Number of discrete flow volumes";

  /* *******************************************************************
      Medium
     ******************************************************************* */

    parameter Modelica.SIunits.Temperature T_0=Modelica.SIunits.Conversions.from_degC(20)
    "Initial temperature of fluid";
    parameter Boolean selectable=true "Pipe record";
    parameter FastHVAC.Media.BaseClass.MediumSimple medium=
      FastHVAC.Media.WaterSimple()
    "Mediums charastics  (heat capacity, density, thermal conductivity)";

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
    parameter Boolean withInsulation =  true
    "Option to add insulation of the pipe";
    parameter AixLib.DataBase.Pipes.IsolationBaseDataDefinition
                                                   parameterIso=
                 AixLib.DataBase.Pipes.Isolation.Iso100pc() "Type of Insulation"
                   annotation (choicesAllMatching=true, Dialog( enable = withInsulation));
    parameter Boolean heatLossToAmbient = true
    "= true to internally simulate heat loss to ambient by convection and radiation";

    parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha=8
    "Heat transfer coefficient to ambient"                      annotation (Dialog( enable = heatLossToAmbient));

    parameter Modelica.SIunits.Emissivity eps = 0.8 "Emissivity"
                                      annotation (Dialog( enable = heatLossToAmbient));

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
    T0=fill(T_0, nNodes)) annotation (Placement(transformation(extent={{-10,-42},
            {10,-22}})));

  Utilities.HeatTransfer.CylindricHeatTransfer
    insulation[ nNodes](
    d_out=fill(outerDiameter*parameterIso.factor*2 + outerDiameter, nNodes),
    d_in=fill(outerDiameter, nNodes),
    length=fill(length/nNodes, nNodes),
    lambda=fill(parameterIso.lambda, nNodes),
    rho=fill(parameterIso.d, nNodes),
    c=fill(parameterIso.c, nNodes),
    T0=fill(T_0, nNodes)) if withInsulation
    annotation (Placement(transformation(extent={{-10,-16},{10,4}})));

  FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a1 annotation (Placement(
        transformation(extent={{-108,-10},{-88,10}}), iconTransformation(extent=
           {{-108,-10},{-88,10}})));
  FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b1 annotation (Placement(
        transformation(extent={{88,-10},{108,10}}), iconTransformation(extent={{
            88,-10},{108,10}})));

  AixLib.Utilities.HeatTransfer.HeatToStar twoStar_RadEx[nNodes](eps=fill(eps,
        nNodes), A=Modelica.Constants.pi*outerDiameter*length/nNodes) if
                                     heatLossToAmbient and not withInsulation
    "Radiation" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-58,34})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector_Star(m=nNodes) if
                                     heatLossToAmbient and not withInsulation annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,64})));
  AixLib.Utilities.Interfaces.Star star if    heatLossToAmbient and not withInsulation
    annotation (Placement(transformation(extent={{-70,80},{-50,100}}),
        iconTransformation(extent={{60,40},{80,60}})));
protected
  Modelica.Fluid.Interfaces.HeatPorts_a heatPorts_Star[nNodes] if heatLossToAmbient and not withInsulation
    annotation (Placement(transformation(extent={{-78,44},{-38,52}}),
        iconTransformation(extent={{-46,20},{40,38}})));
public
  AixLib.Utilities.HeatTransfer.HeatConv heatConv[nNodes](alpha=fill(alpha,
        nNodes), A=Modelica.Constants.pi*outerDiameter*length/nNodes) if
                                     heatLossToAmbient and not withInsulation
    "Convection from pipe wall" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={46,34})));
  AixLib.Utilities.HeatTransfer.HeatConv heatConv_withInsulation[nNodes](
      alpha=fill(alpha, nNodes), A=Modelica.Constants.pi*insulation.d_out*
        length/nNodes) if            (heatLossToAmbient and withInsulation)
    "Convection from insulation" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={72,34})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(m=nNodes)
                annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={58,66})));
protected
  Modelica.Fluid.Interfaces.HeatPorts_a heatPorts[nNodes]
    annotation (Placement(transformation(extent={{40,46},{80,54}}),
        iconTransformation(extent={{-46,20},{40,38}})));
public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_outside annotation (Placement(transformation(extent={{48,80},
            {68,100}}),
        iconTransformation(extent={{-80,40},{-60,60}})));
  FastHVAC.Components.Pipes.BaseClasses.PipeBase pipeBase(
    medium=medium,
    parameterPipe=parameterPipe,
    T_0=T_0,
    nNodes=nNodes,
    length=length)
    annotation (Placement(transformation(extent={{-20,-86},{20,-46}})));
equation

   //Connect the heat ports from the pipe to the pipe wall

      if (withInsulation and heatLossToAmbient) then
        connect(pipeWall.port_b,insulation.port_a);
        connect(insulation.port_b,  heatConv_withInsulation.port_b);
        connect( heatConv_withInsulation.port_a, heatPorts);
      elseif withInsulation then
        connect(pipeWall.port_b,insulation.port_a);
        connect(insulation.port_b,  heatPorts);
        elseif heatLossToAmbient then
        connect(pipeWall.port_b,  heatConv.port_b);
        connect( heatConv.port_a, heatPorts);
        connect( heatConv.port_b, twoStar_RadEx.Therm);
        connect( twoStar_RadEx.Star, heatPorts_Star);
        connect( heatPorts_Star, thermalCollector_Star.port_a);
        connect( thermalCollector_Star.port_b, star);

      else
         connect(pipeWall.port_b,  heatPorts);
      end if;

    connect(pipeBase.heatPorts,pipeWall.port_a);
    connect(heatPorts, thermalCollector.port_a);
    connect(heatPort_outside, thermalCollector.port_b);

  connect(pipeBase.enthalpyPort_b1, enthalpyPort_b1) annotation (Line(
      points={{19.6,-66},{58,-66},{58,0},{98,0}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(pipeBase.enthalpyPort_a1, enthalpyPort_a1) annotation (Line(
      points={{-19.6,-66},{-58,-66},{-58,0},{-98,0}},
      color={176,0,0},
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
          extent={{-108,12},{-88,-12}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,0}),
        Ellipse(
          extent={{88,12},{108,-12}},
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
<p>Dynamic Pipe with pipe wall and insulation wall which allows discretisation of pipe wall and pipe insulation.This model considers heat loss through radiation and convection. It is useful when pipe is not embedded in wall.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/> </p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p> The model already includes heat-transfer by convection and by radiation. Instead of modeling these phenomena outside the pipe, an ambient temperature can be prescribed at the heat-port and the star of the pipe, so the loss to ambient will be calculated within the pipe model. The purpose is to clean up bigger models and to simplify modeling systems with pipes outside building-walls. </p>
<p>Differently from <a href=\"FastHVAC.Components.Pipes.DynamicPipe_ambientLoss\">DynamicPipe_ambientLoss</a> for each discretisation of the pipe, there is a connector to the corresponding element of the discretized pipe wall. Each element of the discretised pipe wall is connected to a corresponding element of the discretized insulation wall. The heat-ports and stars of all nodes are then collected to form two single ports, which can be connected to an ambient temperature. </p>
<p>It is possible to choose no insulation, if used for example for CCA ( concrete core activation). </p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"FastHVAC.Examples.Pipes.DPA_ambientLoss\">DPA_ambientLoss</a></p>
</html>",
        revisions="<html>
<ul>
<li><i>December 20, 2016&nbsp; </i> Tobias Blacha:<br/>Moved into AixLib</li>
<li><i>January 27, 2015 </i> by Konstantin Finkbeiner:<br/>Addapted to FastHVAC</li>
<li><i>November 26, 2014&nbsp;</i> by Roozbeh Sangi:<br>Updated connectors to EBC Library 2.2, Updated documentation, Added example</li>
<li><i>May 19, 2014&nbsp;</i> by Roozbeh Sangi:<br>Added to the HVAC library</li>
<li><i>November 13, 2013&nbsp;</i> by Ole Odendahl:<br>Formatted documentation appropriately</li>
<li><i>August 3, 2011</i> by Ana Constantin:<br>Implemented</li>
</ul>
</html>"));
end DPA_ambientLoss;
