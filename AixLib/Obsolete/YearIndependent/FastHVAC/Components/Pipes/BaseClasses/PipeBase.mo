within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Pipes.BaseClasses;
model PipeBase
  /* *******************************************************************
      Medium
     ******************************************************************* */
    parameter Integer nNodes(min=1)=1 "Number of discrete flow volumes";
    parameter FastHVAC.Media.BaseClasses.MediumSimple medium=
      FastHVAC.Media.WaterSimple()
    "Mediums charastics  (heat capacity, density, thermal conductivity)"
    annotation (choicesAllMatching);
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConIn_const=30
    "Fix value for heat transfer coeffiecient inside pipe"
    annotation (Dialog(enable=not calcHCon));
    parameter Boolean calcHCon=true "Use calculated value for inside heat coefficient";
  final parameter Modelica.Units.SI.Volume V_fluid=nParallel*Modelica.Constants.pi
      *length*parameterPipe.d_i*parameterPipe.d_i/4;

  parameter Modelica.Units.SI.Temperature T_0=
      Modelica.Units.Conversions.from_degC(20) "Initial temperature of fluid";

  /* *******************************************************************
      Pipe Parameters
     ******************************************************************* */

    parameter Integer nParallel(min=1)=1 "Number of identical parallel pipes"
    annotation(Dialog(group="Geometry"));
  parameter Modelica.Units.SI.Length length "Length of pipe"
    annotation (Dialog(group="Geometry"));

    parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition parameterPipe=
      AixLib.DataBase.Pipes.Copper.Copper_6x1() "Type of pipe"
    annotation (choicesAllMatching=true);

  /* *******************************************************************
      Components
     ******************************************************************* */

  FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a1 annotation (
      Placement(transformation(extent={{-108,-10},{-88,10}}),
        iconTransformation(extent={{-108,-10},{-88,10}})));
  FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b1 annotation (
      Placement(transformation(extent={{88,-10},{108,10}}),
        iconTransformation(extent={{88,-10},{108,10}})));

  FastHVAC.BaseClasses.WorkingFluid pipeFluid[nNodes](
    medium=fill(medium, nNodes),
    T0=fill(T_0, nNodes),
    m_fluid=fill(V_fluid/nNodes*medium.rho, nNodes))
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Modelica.Fluid.Interfaces.HeatPorts_a heatPorts[nNodes]
    annotation (Placement(transformation(extent={{-18,58},{22,66}}),
        iconTransformation(extent={{-44,40},{42,58}})));
  AixLib.Obsolete.YearIndependent.Utilities.HeatTransfer.HeatConvPipeInside heatConvPipeInside[nNodes](
  each hConIn_const=hConIn_const,
    d_i=fill(parameterPipe.d_i, nNodes),
    length=fill(length, nNodes),
    d_a=fill(parameterPipe.d_o, nNodes),
    A_sur=fill(nParallel*parameterPipe.d_o*Modelica.Constants.pi*length/nNodes, nNodes),
    medium=fill(medium, nNodes),
    each calcHCon=calcHCon)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,38})));
  Sensors.MassFlowSensor massFlowRate
    annotation (Placement(transformation(extent={{44,-10},{64,10}})));
  Modelica.Blocks.Math.Division divideMassFlow
    "division block to take multiple parallel pipes into account" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={32,38})));
  Modelica.Blocks.Sources.Constant nParallelConst(k=nParallel)
    "Constant for amount of parallel pipes" annotation (Placement(
        transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={68,32})));

equation

  for i in 2:nNodes loop
      connect(pipeFluid[i-1].enthalpyPort_b, pipeFluid[i].enthalpyPort_a);
  end for;

  connect(pipeFluid[nNodes].enthalpyPort_b, massFlowRate.enthalpyPort_a) annotation (Line(
      points={{18,0},{32,0},{32,-0.1},{45.2,-0.1}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(pipeFluid[1].enthalpyPort_a, enthalpyPort_a1) annotation (Line(
      points={{-18,0},{-98,0}},
      color={176,0,0},
      smooth=Smooth.None));
  for i in 1:nNodes loop
      connect(divideMassFlow.y,heatConvPipeInside[i].m_flow);
      end for;

  connect(pipeFluid.heatPort, heatConvPipeInside.port_b)
    annotation (Line(points={{0,18.8},{0,28}}, color={191,0,0}));
  connect(heatConvPipeInside.port_a, heatPorts)
    annotation (Line(points={{0,48},{0,56},{0,62},{2,62}}, color={191,0,0}));
  connect(massFlowRate.enthalpyPort_b, enthalpyPort_b1) annotation (Line(points=
         {{63,-0.1},{78.5,-0.1},{78.5,0},{98,0}}, color={176,0,0}));
  connect(massFlowRate.dotm, divideMassFlow.u1) annotation (Line(points={{55,9},
          {55,20},{82,20},{82,44},{44,44}}, color={0,0,127}));
  connect(nParallelConst.y, divideMassFlow.u2)
    annotation (Line(points={{61.4,32},{44,32}}, color={0,0,127}));
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
          extent={{-40,14},{40,-12}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,0},
          textString="%nNodes"),
        Text(
          extent={{-68,-70},{76,-90}},
          lineColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Base model for a pipe.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  This model for a discrete pipe fluid represents just the fluid
  without a pipe wall. The outside heat port is a multiple heat port,
  this allows the heat transfer connection of each discrete fluid
  element with the environment.
</p>
<ul>
  <li>
    <i>November 17, 2017&#160;</i> David Jansen:<br/>
    Added heat convection inside pipe, moved into development
  </li>
  <li>
    <i>December 20, 2016&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>January 27, 2015</i> by Konstantin Finkbeiner:<br/>
    Implemented
  </li>
</ul>
</html>"),
    experiment(
      StopTime=14000,
      Interval=30,
      Algorithm="Lsodar"),
    experimentSetupOutput);
end PipeBase;
