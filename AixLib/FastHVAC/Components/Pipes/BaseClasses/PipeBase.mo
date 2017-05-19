within AixLib.FastHVAC.Components.Pipes.BaseClasses;
model PipeBase
  import AixLib;

  /* *******************************************************************
      Medium
     ******************************************************************* */
    parameter Integer nNodes( min=3)=3 "Number of discrete flow volumes";
    parameter FastHVAC.Media.BaseClasses.MediumSimple medium=
      FastHVAC.Media.WaterSimple()
    "Mediums charastics  (heat capacity, density, thermal conductivity)"
    annotation(choicesAllMatching);

    parameter Modelica.SIunits.Volume  V_fluid=Modelica.Constants.pi* length*parameterPipe.d_i*parameterPipe.d_i/4;

    parameter Modelica.SIunits.Temperature T_0=Modelica.SIunits.Conversions.from_degC(20)
    "Initial temperature of fluid";

  /* *******************************************************************
      Pipe Parameters
     ******************************************************************* */

    parameter Modelica.SIunits.Length length "Length of pipe"
       annotation(Dialog(group = "Geometry"));

    parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition parameterPipe=
      AixLib.DataBase.Pipes.Copper.Copper_6x1() "Type of pipe"
    annotation (choicesAllMatching=true);

  /* *******************************************************************
      Components
     ******************************************************************* */

  FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a1 annotation (Placement(
        transformation(extent={{-108,-10},{-88,10}}), iconTransformation(extent=
           {{-108,-10},{-88,10}})));
  FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b1 annotation (Placement(
        transformation(extent={{88,-10},{108,10}}), iconTransformation(extent={{
            88,-10},{108,10}})));

  AixLib.FastHVAC.BaseClasses.WorkingFluid
                                  pipeFluid[nNodes](
    medium=fill(medium,nNodes),
    T0=fill(T_0,nNodes),
    m_fluid=fill(V_fluid/nNodes*medium.rho, nNodes))
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Modelica.Fluid.Interfaces.HeatPorts_a heatPorts[nNodes]
    annotation (Placement(transformation(extent={{-20,32},{20,40}}),
        iconTransformation(extent={{-44,40},{42,58}})));
equation

  for i in 2:nNodes loop
      connect(pipeFluid[i-1].enthalpyPort_b, pipeFluid[i].enthalpyPort_a);
  end for;

  connect(pipeFluid[nNodes].enthalpyPort_b, enthalpyPort_b1) annotation (Line(
      points={{18,0},{98,0}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(pipeFluid[1].enthalpyPort_a, enthalpyPort_a1) annotation (Line(
      points={{-18,0},{-98,0}},
      color={176,0,0},
      smooth=Smooth.None));

  connect(pipeFluid.heatPort, heatPorts) annotation (Line(
      points={{0,18.8},{0,36}},
      color={191,0,0},
      smooth=Smooth.None));
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
    Documentation(info="<html>
   
<h4><span style=\"color:#008000\">Overview</span></h4>
<p> Base model for a pipe.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>This model for a discrete pipe fluid represents just the fluid without a pipe wall. The outside heat port is a multiple heat port, this allows the heat transfer connection of each discrete fluid element with the environment. </p>

</html>",
        revisions="<html>
<p><ul>
<li><i>December 20, 2016&nbsp; </i> Tobias Blacha:<br/>Moved into AixLib</li>
<li><i>January 27, 2015 </i> by Konstantin Finkbeiner:<br/>Implemented</li>
</ul></p>
</html>"),
    experiment(
      StopTime=14000,
      Interval=30,
      Algorithm="Lsodar"),
    experimentSetupOutput);
end PipeBase;
