within AixLib.FastHVAC.Components.Pipes;
model DynamicPipeAggregated "DynamicPipe with heat loss to ambient"

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
    parameter Boolean withInsulation = true
    "Option to add insulation of the pipe";
    parameter AixLib.DataBase.Pipes.InsulationBaseDataDefinition
                                                   parameterIso=
                 AixLib.DataBase.Pipes.Insulation.Iso100pc() "Type of Insulation"
                   annotation (choicesAllMatching=true, Dialog( enable = withInsulation));
    parameter Boolean withConvection = false
    "= true to internally simulate heat loss to ambient by convection ";

        parameter Boolean withRadiation=false
    "= true to internally simulate heat loss to ambient by radiation (only works with convection = true)" annotation (Dialog( enable = withConvection));

final parameter          Boolean withRadiationParam=if not withConvection then false else withRadiation
    "= true to internally simulate heat loss to ambient by radiation (only works with convection = true)" annotation (Dialog( enable = false));
 parameter   Modelica.SIunits.CoefficientOfHeatTransfer                                      alphaOutside=8
    "Heat transfer coefficient to ambient"                      annotation (Dialog( enable = withConvection));
 parameter Modelica.SIunits.Emissivity eps = 0.8 "Emissivity"
 annotation (Dialog( enable = withRadiation));
         parameter Boolean calculateAlpha = true "Use calculated value for inside heat coefficient";
    parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaInsideFix = 30 "Fix value for heat transfer coeffiecient inside pipe" annotation(Dialog(enable = not calculateAlpha));
    final parameter Modelica.SIunits.Area AOutside = if not withInsulation then Modelica.Constants.pi*outerDiameter*length else Modelica.Constants.pi*(outerDiameter*parameterIso.factor*2 + outerDiameter)*length;

  /* *******************************************************************
      Components
     ******************************************************************* */

  Utilities.HeatTransfer.CylindricHeatTransfer pipeWall[nNodes](
    rho=fill(d, nNodes),
    c=fill(c, nNodes),
    d_out=fill(outerDiameter, nNodes),
    d_in=fill(innerDiameter, nNodes),
    length=fill(length/nNodes, nNodes),
    lambda=fill(lambda, nNodes),
    T0=fill(T_0, nNodes))
            annotation (Placement(transformation(extent={{-10,-36},{10,-16}})));

  Utilities.HeatTransfer.CylindricHeatTransfer insulation[nNodes](
    rho=fill(parameterIso.d, nNodes),
    c=fill(parameterIso.c, nNodes),
    d_out=fill(outerDiameter*parameterIso.factor*2 + outerDiameter, nNodes),
    d_in=fill(outerDiameter, nNodes),
    length=fill(length/nNodes, nNodes),
    lambda=fill(parameterIso.lambda, nNodes),
    T0=fill(T_0, nNodes)) if
               withInsulation
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_outside
        annotation (Placement(transformation(extent={{46,82},{66,102}}),
        iconTransformation(extent={{46,82},{66,102}})));

  FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a1 annotation (Placement(
        transformation(extent={{-108,-10},{-88,10}}), iconTransformation(extent=
           {{-108,-10},{-88,10}})));
  FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b1 annotation (Placement(
        transformation(extent={{88,-10},{108,10}}), iconTransformation(extent={{
            88,-10},{108,10}})));

  AixLib.Utilities.Interfaces.Star star if withRadiationParam
    annotation (Placement(transformation(extent={{-70,86},{-50,106}}),
        iconTransformation(extent={{-70,86},{-50,106}})));
  AixLib.Utilities.HeatTransfer.HeatConv heatConv[nNodes](alpha=fill(
        alphaOutside, nNodes), A=AOutside/nNodes) if
                                  withConvection "Convection from pipe wall"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={58,28})));
  AixLib.Utilities.HeatTransfer.HeatToStar twoStar_RadEx[nNodes](   eps=fill(
        eps, nNodes), A=AOutside/nNodes) if
                                  withRadiationParam annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-58,30})));
  FastHVAC.Components.Pipes.BaseClasses.PipeBase pipeBase(
    medium=medium,
    parameterPipe=parameterPipe,
    T_0=T_0,
    nNodes=nNodes,
    length=length,
    alphaInsideFix=alphaInsideFix,
    calculateAlpha=calculateAlpha)
    annotation (Placement(transformation(extent={{-20,-78},{20,-38}})));
protected
  Modelica.Fluid.Interfaces.HeatPorts_a heatPorts[nNodes]
    annotation (Placement(transformation(extent={{36,44},{76,52}}),
        iconTransformation(extent={{-46,20},{40,38}})));
public
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(m=nNodes)
                annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={56,70})));
protected
  Modelica.Fluid.Interfaces.HeatPorts_a heatPorts1
                                                 [nNodes] if withRadiationParam
    annotation (Placement(transformation(extent={{-76,44},{-36,52}}),
        iconTransformation(extent={{-46,20},{40,38}})));
public
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector_Star(m=nNodes) if
    withRadiationParam                                                        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,68})));
equation

          //nothing
         if (not withRadiationParam and not withInsulation and not withConvection) then
           connect(pipeWall.port_b,heatPorts);

         end if;
          //only radiation (doesn't work)
          if (withRadiationParam and not withInsulation and not withConvection) then
            connect(pipeWall.port_b, twoStar_RadEx.Therm);
            connect(pipeWall.port_b,heatPorts);

          end if;
          // only insulation
         if (withInsulation and not withRadiationParam and not withConvection) then
           connect(pipeWall.port_b,insulation.port_a);
           connect(insulation.port_b,heatPorts);

         end if;
         // only convection
         if (withConvection and not withRadiationParam and not withInsulation) then
           connect(pipeWall.port_b,heatConv.port_b);
           connect(heatConv.port_a, heatPorts);

         end if;
         //convection and radiation
         if (withConvection and withRadiationParam and not withInsulation) then
             connect(pipeWall.port_b,heatConv.port_b);
             connect(heatConv.port_a, heatPorts);
             connect(pipeWall.port_b, twoStar_RadEx.Therm);

         end if;
         //convection and insulation
         if (withConvection and withInsulation and not withRadiationParam) then
             connect(pipeWall.port_b,insulation.port_a);
             connect(insulation.port_b,  heatConv.port_b);
             connect(heatConv.port_a, heatPorts);

         end if;
         // radiation and insulation (doesn't work)
          if (withRadiationParam and withInsulation and not withConvection) then
              connect(pipeWall.port_b,insulation.port_a);
              connect(insulation.port_b, twoStar_RadEx.Therm);
              connect(insulation.port_b,heatPorts);

          end if;
         //radiation, insulation and convection
         if (withRadiationParam and withInsulation and withConvection) then
             connect(pipeWall.port_b,insulation.port_a);
             connect(insulation.port_b,  heatConv.port_b);
             connect(heatConv.port_a, heatPorts);
             connect(insulation.port_b, twoStar_RadEx.Therm);

         end if;

  connect(pipeBase.enthalpyPort_b1, enthalpyPort_b1) annotation (Line(
      points={{19.6,-58},{58,-58},{58,0},{98,0}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(pipeBase.enthalpyPort_a1, enthalpyPort_a1) annotation (Line(
      points={{-19.6,-58},{-58,-58},{-58,0},{-98,0}},
      color={176,0,0},
      smooth=Smooth.None));

  connect(twoStar_RadEx.Star, heatPorts1) annotation (Line(points={{-58,39.1},{-58,
          44},{-58,48},{-56,48}}, color={95,95,95}));
  connect(heatPorts1, thermalCollector_Star.port_a)
    annotation (Line(points={{-56,48},{-60,48},{-60,58}}, color={127,0,0}));
  connect(thermalCollector_Star.port_b, star)
    annotation (Line(points={{-60,78},{-60,96}}, color={191,0,0}));
  connect(heatPorts, thermalCollector.port_a)
    annotation (Line(points={{56,48},{56,60}}, color={127,0,0}));
  connect(thermalCollector.port_b, heatPort_outside)
    annotation (Line(points={{56,80},{56,92}}, color={191,0,0}));
  connect(pipeBase.heatPorts, pipeWall.port_a) annotation (Line(points={{-0.2,-48.2},
          {-0.2,-37.1},{0,-37.1},{0,-26}}, color={127,0,0}));
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
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  This model is based on <a href=
  \"FastHVAC.Components.Pipes.DynamicPipe\">DynamicPipe</a>. The
  difference is that the aggregated pipe has pipe wall and insulation
  wall which allows discretisation of pipe wall and pipe insulation.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Differently from <a href=
  \"FastHVAC.Components.Pipes.DynamicPipe\">DynamicPipe</a> for each
  discretisation of the pipe, there is a connector to the corresponding
  element of the discretized pipe wall. Each element of the discretised
  pipe wall is connected to a corresponding element of the discretized
  insulation wall. The heat-ports and stars of all nodes are then
  collected to form two single ports, which can be connected to an
  ambient temperature.
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
</html>"),
    experiment(
      StopTime=14000,
      Interval=30,
      Algorithm="Lsodar"),
    experimentSetupOutput);
end DynamicPipeAggregated;
