within AixLib.FastHVAC.HeatExchangers.BaseClasses;
model PseudoRadiator
 parameter Integer n(min=1) = 1 "Number of radiators to emulate";


  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensorConvective
    "Measures convective heatflow" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-70})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensorRadiative
    "Measures radiative heatflow" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={42,-70})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowConvective
    "Creates the convective heatflow of n-1 radiators" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-28,58})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowRadiative
    "Creates the radiative heatflow of n-1 radiators" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={26,60})));
  Modelica.Blocks.Math.Product productConvective
    "Product for convective heatflow of the emulated radiators" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,10})));
  Modelica.Blocks.Sources.Constant ConstRest(k=n) "Number of emulated radiators"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-2,-38})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ConvectiveHeat
    "Port for convective heat into the environment"
    annotation (Placement(transformation(extent={{-50,86},{-30,106}}),
        iconTransformation(extent={{-48,80},{-28,100}})));
  Utilities.Interfaces.RadPort        RadiativeHeat
    "Port for radiative heat into the environment"
    annotation (Placement(transformation(extent={{30,82},{50,102}}), iconTransformation(
          extent={{30,86},{50,106}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ConvectiveHeatIn
    "Port for convective heat into the pseude radiator" annotation (Placement(
        transformation(extent={{-50,-106},{-30,-86}}), iconTransformation(extent={{-48,-100},
            {-28,-80}})));
  Utilities.Interfaces.RadPort RadiativeHeatIn
    "Port for radiative heat into the pseude radiator" annotation (Placement(
        transformation(extent={{30,-102},{50,-82}}), iconTransformation(extent={{32,-102},
            {52,-82}})));
  Modelica.Blocks.Math.Product productRadiative
    "Product for radiative heatflow of the emulated radiators" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={26,10})));
equation
  connect(ConvectiveHeat, prescribedHeatFlowConvective.port)
    annotation (Line(points={{-40,96},{-40,68},{-28,68}},         color={191,0,0}));
  connect(RadiativeHeat, prescribedHeatFlowRadiative.port)
    annotation (Line(points={{40,92},{40,70},{26,70}}, color={95,95,95}));
  connect(heatFlowSensorConvective.port_b, ConvectiveHeat)
    annotation (Line(points={{-40,-60},{-40,96}}, color={191,0,0}));
  connect(RadiativeHeat, heatFlowSensorRadiative.port_b)
    annotation (Line(points={{40,92},{42,92},{42,-60}}, color={95,95,95}));
  connect(heatFlowSensorConvective.port_a, ConvectiveHeatIn)
    annotation (Line(points={{-40,-80},{-40,-96}}, color={191,0,0}));
  connect(RadiativeHeatIn, heatFlowSensorRadiative.port_a)
    annotation (Line(points={{40,-92},{42,-92},{42,-80}}, color={95,95,95}));
  connect(ConstRest.y, productConvective.u2) annotation (Line(points={{-2,-31.4},{-2,-20},
          {-14,-20},{-14,-2}}, color={0,0,127}));
  connect(prescribedHeatFlowConvective.Q_flow, productConvective.y)
    annotation (Line(points={{-28,48},{-28,30},{-20,30},{-20,21}}, color={0,0,127}));
  connect(heatFlowSensorConvective.Q_flow, productConvective.u1)
    annotation (Line(points={{-30,-70},{-26,-70},{-26,-2}}, color={0,0,127}));
  connect(heatFlowSensorRadiative.Q_flow, productRadiative.u2)
    annotation (Line(points={{32,-70},{32,-2}}, color={0,0,127}));
  connect(ConstRest.y, productRadiative.u1)
    annotation (Line(points={{-2,-31.4},{-2,-20},{20,-20},{20,-2}}, color={0,0,127}));
  connect(productRadiative.y, prescribedHeatFlowRadiative.Q_flow)
    annotation (Line(points={{26,21},{26,50}}, color={0,0,127}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),             Icon(coordinateSystem(
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
  <img src=\"modelica://HVAC/Images/stars2.png\" alt=\"\" />
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
