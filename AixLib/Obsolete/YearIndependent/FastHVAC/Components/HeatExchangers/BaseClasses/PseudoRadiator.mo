within AixLib.Obsolete.YearIndependent.FastHVAC.Components.HeatExchangers.BaseClasses;
model PseudoRadiator
  /* *******************************************************************
      Parameters
     ******************************************************************* */

  parameter Integer n(min=1);

  /* *******************************************************************
      Components
     ******************************************************************* */

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
                             therm
    "Port connecting the source of convective heat and the environment"
      annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  AixLib.Utilities.Interfaces.RadPort star "Port connecting the source of radiative heat and the environment" annotation (Placement(transformation(extent={{20,80},{40,100}})));
  Interfaces.EnthalpyPort_a enthalpyPort_a[n]
    "Input port of the pseudo-radiator. Acts as a sink of heat medium"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Interfaces.EnthalpyPort_b enthalpyPort_b[n]
    "Output port of the pseudo-radiator. Acts as a source of heat medium"
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
      prescribedConvHeatFlow
    "Source for the convective heat produced by the pseudo-radiator"                          annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-30,52})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
      prescribedRadHeatFlow
    "Source for the radiative heat produced by the pseudo-radiator"                          annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={30,52})));
    Modelica.Blocks.Interfaces.RealInput dotQ_conv( unit="W")
    "Prescribed convective heat into the environment" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-30,-100})));
    Modelica.Blocks.Interfaces.RealInput dotQ_rad( unit="W")
    "Prescribed radiative heat into the environment" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={30,-100})));
equation
  connect(prescribedConvHeatFlow.Q_flow, dotQ_conv) annotation (Line(
      points={{-30,42},{-30,-100}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedRadHeatFlow.Q_flow, dotQ_rad) annotation (Line(
      points={{30,42},{30,-100}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(prescribedConvHeatFlow.port, therm) annotation (Line(
        points={{-30,62},{-30,90}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(prescribedRadHeatFlow.port, star) annotation (Line(
        points={{30,62},{30,90}},
        color={191,0,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),   graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Polygon(
            points={{18,-58},{58,-73},{18,-88},{18,-58}},
            lineColor={0,128,255},
            smooth=Smooth.None,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid,
            visible=showDesignFlowDirection),
          Polygon(
            points={{18,-63},{48,-73},{18,-83},{18,-63}},
            lineColor={255,255,255},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            visible=allowFlowReversal),
          Line(
            points={{53,-73},{-62,-73}},
            color={0,128,255},
            smooth=Smooth.None,
            visible=showDesignFlowDirection),
          Rectangle(
            extent={{-60,74},{-52,-56}},
            lineColor={95,95,95},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-40,74},{-32,-56}},
            lineColor={95,95,95},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-20,74},{-12,-56}},
            lineColor={95,95,95},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{0,74},{8,-56}},
            lineColor={95,95,95},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{20,74},{28,-56}},
            lineColor={95,95,95},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{40,74},{48,-56}},
            lineColor={95,95,95},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{60,74},{68,-56}},
            lineColor={95,95,95},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-66,-42},{70,-52}},
            lineColor={95,95,95},
            fillColor={230,230,230},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-64,68},{72,58}},
            lineColor={95,95,95},
            fillColor={230,230,230},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-50,44},{62,6}},
            lineColor={0,0,0},
            textString="pseudo",
            textStyle={TextStyle.Bold,TextStyle.Italic}),
          Text(
            extent={{-20,-6},{30,-26}},
            lineColor={0,0,0},
            textString="n=%n",
            textStyle={TextStyle.Bold,TextStyle.Italic})}),
             Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  This model emulates the behaviour of n identical radiators.
</p>
<h4>
  <span style=\"color:#008000\">Level of Development</span>
</h4>
<p>
  <img src=\"modelica://HVAC/Images/stars2.png\" alt=\"\">
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The PseudoRadiator is a component of the MultiRadiator
</p>
<p>
  The PseudoRadiator has three functions:
</p>
<ul>
  <li>It acts as a vessel for a part of the heat medium flow entering
  the MultiRadiator model;
  </li>
  <li>It prescribes a convective and radiative heat into the
  environment of the MultiRadiator;
  </li>
  <li>It acts as a source of heat medium leaving the MultiRadiator.
  </li>
</ul>
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
</html>"));
end PseudoRadiator;
