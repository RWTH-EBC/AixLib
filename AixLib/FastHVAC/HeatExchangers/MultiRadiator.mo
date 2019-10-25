within AixLib.FastHVAC.HeatExchangers;
model MultiRadiator "Simple multi radiator model"
  parameter Integer n(min=2) = 2 "Number of radiators";
  parameter Integer N=16 "Number of discretisation layers for single radiator";
  parameter Boolean selectable=true "Radiator record" annotation(Dialog(group="Radiator Data"));
  parameter AixLib.DataBase.Radiators.RadiatorBaseDataDefinition radiatorType
    "Choose a radiator" annotation (Dialog(group="Radiator Data", enable=
          selectable), choicesAllMatching=true);
  parameter Media.FastHvac.BaseClasses.MediumSimple medium=
      Media.FastHvac.WaterSimple()
    "Standard charastics for water (heat capacity, density, thermal conductivity)"
    annotation (choicesAllMatching);

  RadiatorMultiLayer radiator(medium=medium, selectable=selectable,
   radiatorType=radiatorType,
    T0=T0,                    N=N)
    annotation (Placement(transformation(extent={{-36,-12},{-12,12}})));
  Interfaces.EnthalpyPort_a enthalpyPort_a "Port for input heat medium flow"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  Interfaces.EnthalpyPort_b enthalpyPort_b "Port for output heat medium flow"
    annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ConvectiveHeat
    "Port for convective heat into the environment"
    annotation (Placement(transformation(extent={{-50,70},{-30,90}}),
        iconTransformation(extent={{-50,70},{-30,90}})));
  AixLib.Utilities.Interfaces.RadPort RadiativeHeat
    "Port for radiative heat into the environment"
    annotation (Placement(transformation(extent={{30,70},{50,90}})));
  Valves.Splitter splitter(nOut=n, nIn=1)
    "Splits up n-1/n part of massflow for real radiator "
                                          annotation (Placement(transformation(extent={{-72,-10},
            {-52,10}})));

  parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
    "Initial temperature, in degrees Celsius";
  Pumps.FluidSource fluidSource( medium=medium) "Fluidsource to create enthalpy flow behind n radiators"
    annotation (Placement(transformation(extent={{62,-12},{82,8}})));
  Sensors.MassFlowSensor massFlowRate
    "Massflow sensor to get massflow through real radiator" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-2,-14})));
  Sensors.TemperatureSensor temperature(medium=medium)
    "Temperature sensor to get temperature through after radiator" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-2,-44})));
  Sinks.Vessel vessel annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-2,-70})));
  Modelica.Blocks.Math.Product product
    "Product of single mass flow and count of radiators"
    annotation (Placement(transformation(extent={{30,-16},{50,4}})));
  Modelica.Blocks.Sources.Constant ConstN(k=n)
    "Constant value of radiator count"
    annotation (Placement(transformation(extent={{10,-6},{22,6}})));
  BaseClasses.PseudoRadiator pseudoRadiator(n=n - 1)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
equation
  for k in 2:n loop
    connect(splitter.enthalpyPort_b[k], vessel.enthalpyPort_a)
     annotation (Line(points={{-52,0},{-52,-63},{-2,-63}},   color={176,0,0}));
  end for;
  connect(enthalpyPort_a, splitter.enthalpyPort_a[1])
    annotation (Line(points={{-100,0},{-72,0}}, color={176,0,0}));
  connect(fluidSource.enthalpyPort_b, enthalpyPort_b)
    annotation (Line(points={{81,0},{100,0}}, color={176,0,0}));
  connect(massFlowRate.enthalpyPort_b, temperature.enthalpyPort_a)
    annotation (Line(points={{-2.1,-23},{-2.1,-35.2}}, color={176,0,0}));
  connect(temperature.enthalpyPort_b, vessel.enthalpyPort_a) annotation (Line(points={{-2.1,
          -53},{-2.1,-58.5},{-2,-58.5},{-2,-63}}, color={176,0,0}));
  connect(radiator.enthalpyPort_b1, massFlowRate.enthalpyPort_a) annotation (Line(points={
          {-14.4,-0.24},{-2.1,-0.24},{-2.1,-5.2}}, color={176,0,0}));
  connect(temperature.T, fluidSource.T_fluid)
    annotation (Line(points={{9,-45},{54,-45},{54,2.2},{64,2.2}}, color={0,0,127}));
  connect(splitter.enthalpyPort_b[1], radiator.enthalpyPort_a1) annotation (Line(points={{
          -52,0},{-42,0},{-42,-0.24},{-33.6,-0.24}}, color={176,0,0}));
  connect(product.y, fluidSource.m_flow)
    annotation (Line(points={{51,-6},{58,-6},{58,-4.6},{64,-4.6}}, color={0,0,127}));
  connect(massFlowRate.m_flow, product.u2)
    annotation (Line(points={{7,-14},{18,-14},{18,-12},{28,-12}}, color={0,0,127}));
  connect(ConstN.y, product.u1)
    annotation (Line(points={{22.6,0},{28,0}}, color={0,0,127}));

  connect(radiator.ConvectiveHeat, pseudoRadiator.ConvectiveHeatIn) annotation
    (Line(points={{-30.48,6.96},{-30.48,18},{-3.8,18},{-3.8,31}}, color={191,0,
          0}));
  connect(pseudoRadiator.ConvectiveHeat, ConvectiveHeat)
    annotation (Line(points={{-3.8,49},{-40,49},{-40,80}}, color={191,0,0}));
  connect(pseudoRadiator.RadiativeHeat, RadiativeHeat)
    annotation (Line(points={{4,49.6},{40,49.6},{40,80}}, color={95,95,95}));
  connect(pseudoRadiator.RadiativeHeatIn, radiator.RadiativeHeat) annotation (
      Line(points={{4.2,30.8},{4.2,12},{-17.28,12},{-17.28,7.2}}, color={95,95,
          95}));
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
    <i>October 25, 2019;</i> David Jansen:<br/>
    Reworked model to make it more comprehensible and to work with massflow as flow variable
  </li>
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
            100}})),            defaultComponentName="multiRadiator",
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
