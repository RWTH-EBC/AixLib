within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Pipes;
model DynamicPipe "DynamicPipe with heat loss to ambient"
  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

  /* *******************************************************************
      Medium
     ******************************************************************* */
    parameter Boolean selectable=true "Pipe record";
    parameter FastHVAC.Media.BaseClasses.MediumSimple medium=
      FastHVAC.Media.WaterSimple()
    "Mediums charastics  (heat capacity, density, thermal conductivity)"
    annotation (choicesAllMatching);

protected
  parameter Modelica.Units.SI.Volume V_fluid=Modelica.Constants.pi*length*
      nParallel*innerDiameter*innerDiameter/4;
  parameter Modelica.Units.SI.Diameter innerDiameter=(if selectable then
      parameterPipe.d_i else diameter) "Inner diameter of  pipe";
  parameter Modelica.Units.SI.Diameter outerDiameter=(if selectable then
      parameterPipe.d_o else innerDiameter + 2*s_pipeWall)
    "Outer diameter of  pipe";
  parameter Modelica.Units.SI.Density d=(if selectable then parameterPipe.d
       else rho_pipeWall) "Density of pipe material";
  parameter Modelica.Units.SI.SpecificHeatCapacity c=(if selectable then
      parameterPipe.c else c_pipeWall) "Heat capacity of pipe material";
  parameter Modelica.Units.SI.ThermalConductivity lambda=(if selectable then
      parameterPipe.lambda else lambda_pipeWall)
    "Thermal Conductivity of pipe material";

public
  parameter Modelica.Units.SI.Temperature T_0=
      Modelica.Units.Conversions.from_degC(20) "Initial temperature of fluid";

  /* *******************************************************************
      Pipe Parameters
     ******************************************************************* */

    parameter Integer nNodes(min=3)=3 "Number of discrete flow volumes";

    parameter Integer nParallel(min=1)=1 "Number of identical parallel pipes"
    annotation(Dialog(group = "Geometry"));
  parameter Modelica.Units.SI.Length length=1 "Length of pipe"
    annotation (Dialog(group="Geometry"));
  parameter Modelica.Units.SI.Diameter diameter=0.01
    "Inner diameter of  pipe (if selectable=false)"
    annotation (Dialog(group="Geometry", enable=not selectable));
  parameter Modelica.Units.SI.Density rho_pipeWall=8900
    "Density of pipe material (if selectable=false)"
    annotation (Dialog(group="Pipe material", enable=not selectable));
  parameter Modelica.Units.SI.Thickness s_pipeWall=0.001
    "Thickness of pipe wall (if selectable=false)"
    annotation (Dialog(group="Geometry", enable=not selectable));
  parameter Modelica.Units.SI.SpecificHeatCapacity c_pipeWall=390
    "Heat capacity of pipe material (if selectable=false)"
    annotation (Dialog(group="Pipe material", enable=not selectable));
  parameter Modelica.Units.SI.ThermalConductivity lambda_pipeWall=393
    "Thermal Conductivity of pipe material (if selectable=false)"
    annotation (Dialog(group="Pipe material", enable=not selectable));
    parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition parameterPipe=
      AixLib.DataBase.Pipes.Copper.Copper_6x1() "Type of pipe"
    annotation (Dialog(enable=selectable), choicesAllMatching=true);
    parameter Boolean withInsulation = true
    "Option to add insulation of the pipe";
    parameter AixLib.DataBase.Pipes.InsulationBaseDataDefinition parameterIso=
      AixLib.DataBase.Pipes.Insulation.Iso100pc() "Type of Insulation"
    annotation (choicesAllMatching=true, Dialog( enable = withInsulation));
    parameter Boolean withConvection = false
    "= true to internally simulate heat loss to ambient by convection ";
    parameter Boolean withRadiation=false
    "= true to internally simulate heat loss to ambient by radiation (only works with convection = true)"
    annotation (Dialog( enable = withConvection));

    final parameter Boolean withRadiationParam=if not withConvection then false else withRadiation
    "= true to internally simulate heat loss to ambient by radiation (only works with convection = true)"
    annotation (Dialog( enable = false));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConOut=8
    "Heat transfer coefficient to ambient"
    annotation (Dialog(enable=withConvection));
  parameter Modelica.Units.SI.Emissivity eps=0.8 "Emissivity"
    annotation (Dialog(enable=withRadiation));
    parameter Boolean calcHCon=true "Use calculated value for inside heat transfer coefficient";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConIn_const=30
    "Fix value for heat transfer coeffiecient inside pipe"
    annotation (Dialog(enable=not calcHCon));

  /* *******************************************************************
      Components
     ******************************************************************* */
     AixLib.Utilities.HeatTransfer.CylindricHeatTransfer pipeWall(
    rho=d,
    c=c,
    d_out=outerDiameter,
    d_in=innerDiameter,
    length=length,
    lambda=lambda,
    T0=T_0)
    annotation (Placement(transformation(extent={{-10,14},{10,34}})));

  AixLib.Utilities.HeatTransfer.CylindricHeatTransfer
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
    annotation (Placement(transformation(extent={{-98,42},{-78,62}}),
        iconTransformation(extent={{-98,42},{-78,62}})));

  FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a1 annotation (
      Placement(transformation(extent={{-108,-10},{-88,10}}),
        iconTransformation(extent={{-108,-10},{-88,10}})));
  FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b1 annotation (
      Placement(transformation(extent={{88,-10},{108,10}}),
        iconTransformation(extent={{88,-10},{108,10}})));

  AixLib.Utilities.Interfaces.RadPort star if withRadiationParam
    annotation (Placement(transformation(extent={{78,42},{98,62}}), iconTransformation(extent={{78,42},{98,62}})));
  AixLib.Utilities.HeatTransfer.HeatConv heatConv(hCon=hConOut, A=Modelica.Constants.pi*outerDiameter*length) if withConvection
    "Convection from pipe wall"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-38,52})));
  AixLib.Utilities.HeatTransfer.HeatToRad twoStar_RadEx(eps=eps, A=Modelica.Constants.pi*outerDiameter*length) if withRadiationParam annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={46,52})));

  FastHVAC.Components.Pipes.BaseClasses.PipeBase pipeBase(
    medium=medium,
    nParallel=nParallel,
    parameterPipe=parameterPipe,
    T_0=T_0,
    nNodes=nNodes,
    length=length,
    hConIn_const=hConIn_const,
    calcHCon=calcHCon)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
equation
   //Connect the heat ports from the pipe to the pipe wall
      for i in 1:nNodes loop
        connect(pipeBase.heatPorts[i],pipeWall.port_a);
      end for;

          //nothing
         if (not withRadiationParam and not withInsulation and not withConvection) then
           connect(pipeWall.port_b,heatPort_outside);

         end if;
          //only radiation (doesn't work)
          if (withRadiationParam and not withInsulation and not withConvection) then
    connect(pipeWall.port_b, twoStar_RadEx.conv);
            connect(pipeWall.port_b,heatPort_outside);

          end if;
          // only insulation
         if (withInsulation and not withRadiationParam and not withConvection) then
           connect(pipeWall.port_b,insulation.port_a);
           connect(insulation.port_b,heatPort_outside);

         end if;
         // only convection
         if (withConvection and not withRadiationParam and not withInsulation) then
           connect(pipeWall.port_b,heatConv.port_b);
           connect(heatConv.port_a, heatPort_outside);

         end if;
         //convection and radiation
         if (withConvection and withRadiationParam and not withInsulation) then
             connect(pipeWall.port_b,heatConv.port_b);
             connect(heatConv.port_a, heatPort_outside);
    connect(pipeWall.port_b, twoStar_RadEx.conv);

         end if;
         //convection and insulation
         if (withConvection and withInsulation and not withRadiationParam) then
             connect(pipeWall.port_b,insulation.port_a);
             connect(insulation.port_b,  heatConv.port_b);
             connect(heatConv.port_a, heatPort_outside);

         end if;
         // radiation and insulation (doesn't work)
          if (withRadiationParam and withInsulation and not withConvection) then
              connect(pipeWall.port_b,insulation.port_a);
    connect(insulation.port_b, twoStar_RadEx.conv);
              connect(insulation.port_b,heatPort_outside);

          end if;
         //radiation, insulation and convection
         if (withRadiationParam and withInsulation and withConvection) then
             connect(pipeWall.port_b,insulation.port_a);
             connect(insulation.port_b,  heatConv.port_b);
             connect(heatConv.port_a, heatPort_outside);
    connect(insulation.port_b, twoStar_RadEx.conv);

         end if;

  connect(pipeBase.enthalpyPort_b1, enthalpyPort_b1) annotation (Line(
      points={{19.6,0},{98,0}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(pipeBase.enthalpyPort_a1, enthalpyPort_a1) annotation (Line(
      points={{-19.6,0},{-98,0}},
      color={176,0,0},
      smooth=Smooth.None));

  connect(twoStar_RadEx.rad, star) annotation (Line(points={{55.1,52},{88,52}}, color={95,95,95}));
     annotation (choicesAllMatching,
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Icon(coordinateSystem(preserveAspectRatio=false,
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
    Documentation(info="
    
    
<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  This model is based on <a href=
  \"FastHVAC.Components.Pipes.BaseClasses.PipeBase\">pipeBase</a>. The
  pipes parameter can be chosen from <a href=\"DataBase\">DataBase</a> or
  entered manually . This model takes into account the heat loss due to
  convection and / or radiation and insulation can also be chosen.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The fluid inside the pipe is represented by the model <a href=
  \"modelica:/Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">HeatCapacitor</a>.
  Two cilindrical layers with <a href=
  \"HVAC.Components.Pipes.BaseClasses.Insulation.CylindricHeatConduction\">
  heat conduction</a> and <a href=
  \"HVAC.Components.Pipes.BaseClasses.Insulation.CylindricLoad\">heat
  storage</a> where added for the pipe wall and pipe insulation each.
</p>
<p>
  The model directly calculates radiation and convection instead of
  modeling these phenomena outside the pipe, an ambient temperature can
  be prescribed at the heat-port and the star of the pipe and the loss
  to ambient will be calculated within the pipe model. The purpose is
  to clean up bigger models and to simplify modeling systems with pipes
  outside building-walls.
</p>
<p>
  Please note that it's not possible to consider radiation without
  considering convection.
</p>
<p>
  Also, be careful when using neither isolation nor convection, as this
  will result in ideal heat transfer to the outside of the pipe and so
  to a significant heat loss. Might be useful if used for example for
  CCA (concrete core activation).
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  <a href=\"FastHVAC.Examples.Pipes\">Pipes</a>
</p>
</html>",
revisions="<html><ul>
  <li>
    <i>November 17, 2017&#160;</i> David Jansen:<br/>
    Reduced pipe models to two versions and moved to development
  </li>
  <li>
    <i>December 20, 2016&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>January 27, 2015</i> by Konstantin Finkbeiner:<br/>
    Addapted to FastHVAC
  </li>
  <li>
    <i>November 26, 2014&#160;</i> by Roozbeh Sangi:<br/>
    Updated connectors to EBC Library 2.2, Updated documentation, Added
    example
  </li>
  <li>
    <i>May 19, 2014&#160;</i> by Roozbeh Sangi:<br/>
    Added to the HVAC library
  </li>
  <li>
    <i>November 13, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>August 9, 2011</i> by Ana Constantin:<br/>
    Introduced the possibility of neglecting the insulation wall
  </li>
  <li>
    <i>April 11, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>


"), experiment(
      StopTime=14000,
      Interval=30,
      Algorithm="Lsodar"),
    experimentSetupOutput);
end DynamicPipe;
