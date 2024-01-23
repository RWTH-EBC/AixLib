within AixLib.Obsolete.YearIndependent.FastHVAC.Components.HeatExchangers;
model MultiRadiator "Simple multi radiator model"
extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

  /* *******************************************************************
      Multi Radiator Parameters
     ******************************************************************* */
parameter Integer n(min=2) = 3 "Number of radiators";

parameter Boolean selectable=false "Radiator record" annotation(Dialog(group="Radiator Data"));
  parameter AixLib.DataBase.Radiators.RadiatorBaseDataDefinition radiatorType
    "Choose a radiator" annotation (Dialog(group="Radiator Data", enable=
          selectable), choicesAllMatching=true);
parameter FastHVAC.Media.BaseClasses.MediumSimple medium=
      FastHVAC.Media.WaterSimple()
    "Standard charastics for water (heat capacity, density, thermal conductivity)"
    annotation (choicesAllMatching);

protected
  parameter Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure
    capacityWater=medium.c "Heat capacity of medium";
  parameter Modelica.Units.SI.Density densityWater=medium.rho
    "density of medium";
  /* *******************************************************************
      Components
      ******************************************************************* */

public
  RadiatorMultiLayer radiator(selectable=true, radiatorType=radiatorType)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Interfaces.EnthalpyPort_a enthalpyPort_a "Port for input heat medium flow"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  Interfaces.EnthalpyPort_b enthalpyPort_b "Port for output heat medium flow"
    annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
                           ConvectiveHeat
    "Port for convective heat into the environment"
    annotation (Placement(transformation(extent={{-50,70},{-30,90}}),
        iconTransformation(extent={{-50,70},{-30,90}})));
  AixLib.Utilities.Interfaces.RadPort RadiativeHeat "Port for radiative heat into the environment" annotation (Placement(transformation(extent={{30,70},{50,90}})));
  Valves.Splitter splitter(n=n)
    annotation (Placement(transformation(extent={{-66,-10},{-46,10}})));
  Valves.Manifold manifold(n=n)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  BaseClasses.PseudoRadiator pseudoRadiator(n=n - 1)
    annotation (Placement(transformation(extent={{-10,28},{12,48}})));

equation
     pseudoRadiator.dotQ_conv = -(n-1)*radiator.ConvectiveHeat.Q_flow;
     pseudoRadiator.dotQ_rad = -(n-1)*radiator.RadiativeHeat.Q_flow;

  for k in 1:(n-1) loop

     pseudoRadiator.enthalpyPort_b[k].T = radiator.enthalpyPort_b1.T;
     pseudoRadiator.enthalpyPort_b[k].c = radiator.enthalpyPort_b1.c;
     pseudoRadiator.enthalpyPort_b[k].h = radiator.enthalpyPort_b1.h;
     pseudoRadiator.enthalpyPort_b[k].m_flow = radiator.enthalpyPort_b1.m_flow;
     connect(splitter.enthalpyPort_b[k+1],pseudoRadiator.enthalpyPort_a[k]);
     connect(pseudoRadiator.enthalpyPort_b[k],manifold.enthalpyPort_a[k+1]);
  end for;

  connect(radiator.ConvectiveHeat, ConvectiveHeat) annotation (Line(
      points={{-5.4,5.8},{-5.4,15.5},{-40,15.5},{-40,80}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(radiator.RadiativeHeat, RadiativeHeat) annotation (Line(
      points={{5.6,6},{5.6,16.5},{40,16.5},{40,80}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(pseudoRadiator.therm, ConvectiveHeat) annotation (Line(
      points={{-2.3,47},{-2.3,55.5},{-40,55.5},{-40,80}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pseudoRadiator.star, RadiativeHeat) annotation (Line(
      points={{4.3,47},{4.3,55.5},{40,55.5},{40,80}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(splitter.enthalpyPort_a, enthalpyPort_a) annotation (Line(
      points={{-66,0},{-100,0}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(manifold.enthalpyPort_b, enthalpyPort_b) annotation (Line(
      points={{60,0},{100,0}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(splitter.enthalpyPort_b[1], radiator.enthalpyPort_a1) annotation (
      Line(
      points={{-46,-0.666667},{-8,-0.666667},{-8,-0.2}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(radiator.enthalpyPort_b1, manifold.enthalpyPort_a[1]) annotation (
      Line(
      points={{8,-0.2},{8,-0.666667},{40,-0.666667}},
      color={176,0,0},
      smooth=Smooth.None));
  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<ul>
  <li>This model emulates the behavour of n identical radiators.
  </li>
</ul>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Instead of connecting n radiator models in parallel , the
  MultiRadiator model consists of one single radiator model and a
  pseudoradiator model.
</p>
<p>
  The radiator model receives the n-th part of the total flow of heat
  medium, which interacts with its environment via the therm
  (ConvectiveHeat) and star (RadiativeHeat) connectors and flows out of
  the radiator at a different temperature and specific enthalpy.
</p>
<p>
  The pseudoradiator emulates the behaivour of the reamaining
  (identical) n-1 radiators. It receives the remaining flow of heat
  medium, injects (or absorbs) (n-1)-times the heat flow of the
  radiator into the environment and injects back heat medium back into
  to the circuit with the same temperature and specific enthalpy than
  at the output of the actual radiator model.
</p>
<p>
  This method reduces the number of state variables and therefore the
  simulation time.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  <a href=
  \"AixLib.FastHVAC.Examples.HeatExchangers.MultiRadiator.ValidationMultiRadiator\">
  ValidationMultiRadiator</a>
</p>
</html>",
revisions="<html><ul>
  <li>
    <i>April 13, 2017&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>February 22, 2014&#160;</i> by Nicolás Chang:<br/>
    Implemented.
  </li>
</ul>
</html>"),
Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),            graphics),
                                defaultComponentName="multiRadiator",
                                Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-66,58},{-58,-72}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-46,58},{-38,-72}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-26,58},{-18,-72}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-6,58},{2,-72}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{14,58},{22,-72}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{34,58},{42,-72}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{54,58},{62,-72}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-72,-58},{64,-68}},
          lineColor={95,95,95},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-70,52},{66,42}},
          lineColor={95,95,95},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-62,16},{54,-28}},
          lineColor={0,0,0},
          textString="multi n=%n",
          textStyle={TextStyle.Bold,TextStyle.Italic}),
          Text(
          extent={{-158,-100},{142,-140}},
          textString="%name",
          lineColor={0,0,255}),
        Polygon(
          points={{20,-74},{60,-89},{20,-104},{20,-74}},
          lineColor={176,0,0},
          smooth=Smooth.None,
          fillColor={176,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,-79},{50,-89},{20,-99},{20,-79}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal),
        Line(
          points={{55,-89},{-60,-89}},
          color={176,0,0},
          smooth=Smooth.None)}));
end MultiRadiator;
