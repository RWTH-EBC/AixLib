within AixLib.FastHVAC.Components.Pipes;
model DynamicPipeAmbientLoss

  /* *******************************************************************
      Medium
     ******************************************************************* */
parameter Boolean selectable=true "Pipe record";
    parameter FastHVAC.Media.BaseClasses.MediumSimple medium=
      FastHVAC.Media.WaterSimple()
    "Mediums charastics  (heat capacity, density, thermal conductivity)"
    annotation(choicesAllMatching);

protected
    parameter Modelica.SIunits.Volume  V_fluid= Modelica.Constants.pi*length*innerDiameter*innerDiameter/4;
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
    parameter Modelica.SIunits.Temperature T_0=Modelica.SIunits.Conversions.from_degC(20)
    "Initial temperature of fluid";

  /* *******************************************************************
      Pipe Parameters
     ******************************************************************* */

    parameter Integer nNodes(min=3)=3 "Number of discrete flow volumes";

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
    parameter Boolean withInsulation = false
    "Option to add insulation of the pipe";
    parameter AixLib.DataBase.Pipes.IsolationBaseDataDefinition
                                                   parameterIso=
                 AixLib.DataBase.Pipes.Isolation.Iso100pc() "Type of Insulation"
                   annotation (choicesAllMatching=true, Dialog( enable = withInsulation));
parameter Boolean heatLossToAmbient = false
    "= true to internally simulate heat loss to ambient by convection and radiation";
                               parameter
    Modelica.SIunits.CoefficientOfHeatTransfer                                      alpha=8
    "Heat transfer coefficient to ambient"                      annotation (Dialog( enable = heatLossToAmbient));
 parameter Modelica.SIunits.Emissivity eps = 0.8 "Emissivity"
                                      annotation (Dialog( enable = heatLossToAmbient));
  /* *******************************************************************
      Components
     ******************************************************************* */

  Utilities.HeatTransfer.CylindricHeatTransfer
    pipeWall(
    rho=d,
    c=c,
    d_out=outerDiameter,
    d_in=innerDiameter,
    length=length,
    lambda=lambda,
    T0=T_0) annotation (Placement(transformation(extent={{-10,14},{10,34}})));

  Utilities.HeatTransfer.CylindricHeatTransfer
    insulation(
    d_out=outerDiameter*parameterIso.factor*2 + outerDiameter,
    d_in=outerDiameter,
    length=length,
    lambda=parameterIso.lambda,
    rho=parameterIso.d,
    c=parameterIso.c,
    T0=T_0) if withInsulation
    annotation (Placement(transformation(extent={{-10,34},{10,54}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_outside
        annotation (Placement(transformation(extent={{-80,40},{-60,60}}),
        iconTransformation(extent={{-80,40},{-60,60}})));

  FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a1 annotation (Placement(
        transformation(extent={{-108,-10},{-88,10}}), iconTransformation(extent=
           {{-108,-10},{-88,10}})));
  FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b1 annotation (Placement(
        transformation(extent={{88,-10},{108,10}}), iconTransformation(extent={{
            88,-10},{108,10}})));

  AixLib.Utilities.Interfaces.Star star if
                                        heatLossToAmbient and not withInsulation
    annotation (Placement(transformation(extent={{60,40},{80,60}}),
        iconTransformation(extent={{60,40},{80,60}})));
  AixLib.Utilities.HeatTransfer.HeatConv heatConv(alpha=alpha, A=Modelica.Constants.pi
        *outerDiameter*length) if   heatLossToAmbient and not withInsulation
    "Convection from pipe wall" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,68})));
  AixLib.Utilities.HeatTransfer.HeatConv heatConv_withInsulation(alpha=alpha,
      A=Modelica.Constants.pi*insulation.d_out*length) if
                                     (heatLossToAmbient and withInsulation)
    "Convection from insulation" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={26,68})));
  AixLib.Utilities.HeatTransfer.HeatToStar twoStar_RadEx(eps=eps, A=Modelica.Constants.pi
        *outerDiameter*length) if   heatLossToAmbient and not withInsulation
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={2,68})));
  FastHVAC.Components.Pipes.BaseClasses.PipeBase pipeBase(
    medium=medium,
    parameterPipe=parameterPipe,
    T_0=T_0,
    nNodes=nNodes,
    length=length)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
equation

   //Connect the heat ports from the pipe to the pipe wall
      for i in 1:nNodes loop
        connect(pipeBase.heatPorts[i],pipeWall.port_a);
      end for;

        //Connect pipe wall to the outside
      if (withInsulation and heatLossToAmbient) then
        connect(pipeWall.port_b,insulation.port_a);
        connect(insulation.port_b, heatConv_withInsulation.port_b);
        connect( heatConv_withInsulation.port_a, heatPort_outside);
      elseif withInsulation then
        connect(pipeWall.port_b,insulation.port_a);
        connect(insulation.port_b,  heatPort_outside);
      elseif heatLossToAmbient then
        connect(pipeWall.port_b,  heatConv.port_b);
        connect( heatConv.port_b, twoStar_RadEx.Therm);
        connect( twoStar_RadEx.Star, star);
        connect( heatConv.port_a, heatPort_outside);
      else
        connect(pipeWall.port_b,  heatPort_outside);
      end if;

  connect(pipeBase.enthalpyPort_b1, enthalpyPort_b1) annotation (Line(
      points={{19.6,0},{98,0}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(pipeBase.enthalpyPort_a1, enthalpyPort_a1) annotation (Line(
      points={{-19.6,0},{-98,0}},
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
          extent={{-68,-70},{76,-90}},
          lineColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html>
<h4>DynamicPipe with heat loss to ambient</h4>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This model is based on  <a href=\"FastHVAC.Components.Pipes.BaseClasses.PipeBase\">pipeBase</a>. This model considers heat loss through radiation and convection. This model is suitable when a pipe is not embedded into a wall.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The model already includes heat-transfer by convection and by radiation. Instead of modeling these phenomena outside the pipe, an ambient temperature can be prescribed at the heat-port and the star of the pipe and the loss to ambient will be calculated within the pipe model. The purpose is to clean up bigger models and to simplify modeling systems with pipes outside building-walls. </p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"FastHVAC.Examples.Pipes.DynamicPipe_ambientLoss\">DynamicPipe_ambientLoss</a></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>December 20, 2016&nbsp; </i> Tobias Blacha:<br/>Moved into AixLib</li>
<li><i>January 27, 2015 </i> by Konstantin Finkbeiner:<br/>Addapted to FastHVAC</li>
<li><i>November 26, 2014&nbsp;</i> by Roozbeh Sangi:<br>Updated connectors to EBC Library 2.2, Updated documentation, Added example</li>
<li><i>May 19, 2014&nbsp;</i> by Roozbeh Sangi:<br>Added to the HVAC library</li>
<li><i>November 13, 2013&nbsp;</i> by Ole Odendahl:<br>Formatted documentation appropriately</li>
<li><i>August 9, 2011</i> by Ana Constantin:<br>Introduced the possibility of neglecting the insulation wall</li>
<li><i>April 11, 2011</i> by Ana Constantin:<br>Implemented</li>
</ul></p>
</html>"),
    experiment(
      StopTime=14000,
      Interval=30,
      Algorithm="Lsodar"),
    experimentSetupOutput);
end DynamicPipeAmbientLoss;
