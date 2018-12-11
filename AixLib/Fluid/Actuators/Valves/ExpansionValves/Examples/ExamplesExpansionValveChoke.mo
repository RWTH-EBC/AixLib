within AixLib.Fluid.Actuators.Valves.ExpansionValves.Examples;
package ExamplesExpansionValveChoke
  "Examples for the model ExpansionValveChoke"
  model ExpansionValveChokePressureDifference
    SimpleExpansionValves.ExpansionValveChoke expansionValveChoke(redeclare
        package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_473_Formula)
      annotation (Placement(transformation(extent={{-6,-14},{14,6}})));
    Modelica.Fluid.Sources.Boundary_ph boundary(
      p=1200000,
      h=180000,
      nPorts=1,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_473_Formula)
      annotation (Placement(transformation(extent={{-96,-10},{-76,10}})));
    Modelica.Fluid.Sources.Boundary_ph boundary1(
      p=250000,
      h=180000,
      nPorts=1,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_473_Formula)
      annotation (Placement(transformation(extent={{94,-8},{74,12}})));
    Modelica.Blocks.Sources.Ramp ramp(duration=1)
      annotation (Placement(transformation(extent={{-98,64},{-78,84}})));
  equation
    connect(ramp.y, expansionValveChoke.manVarVal) annotation (Line(points={{
            -77,74},{-40.5,74},{-40.5,6.6},{-1,6.6}}, color={0,0,127}));
    connect(boundary.ports[1], expansionValveChoke.port_a) annotation (Line(
          points={{-76,0},{-44,0},{-44,-4},{-6,-4}}, color={0,127,255}));
    connect(expansionValveChoke.port_b, boundary1.ports[1]) annotation (Line(
          points={{14,-4},{56,-4},{56,2},{74,2}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent = {{-100,-100},{100,100}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points = {{-36,60},{64,0},{-36,-60},{-36,60}})}), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end ExpansionValveChokePressureDifference;

  model ExpansionValveChokeMassFlowRate "Example with Mass flow rate"
    Sources.MassFlowSource_T              source(
      nPorts=1,
      m_flow=1,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Record)
      "Source of constant mass flow and temperature"
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    FixedResistances.PressureDrop              simplePipe(
      dp_nominal=7.5e5,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Record,
      m_flow_nominal=0.1)
      " Simple pipe to provide pressure loss"
      annotation (Placement(transformation(extent={{10,-10},{30,10}})));
    Sources.FixedBoundary              sink(nPorts=1, redeclare package Medium
        = Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Record)
      "Sink of constant pressure and temperature"
      annotation (Placement(transformation(extent={{80,-10},{60,10}})));
    Modelica.Blocks.Sources.Sine valOpe(
      freqHz=1,
      amplitude=0.3,
      offset=0.7)
      "Input signal to prediscribe expansion valve's opening"
      annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
    SimpleExpansionValves.ExpansionValveChoke expansionValveChoke(redeclare
        package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Record)
      annotation (Placement(transformation(extent={{-40,-12},{-20,8}})));
  equation
    connect(source.ports[1], expansionValveChoke.port_a) annotation (Line(
          points={{-60,0},{-50,0},{-50,-2},{-40,-2}}, color={0,127,255}));
    connect(valOpe.y, expansionValveChoke.manVarVal) annotation (Line(points={{
            -59,50},{-48,50},{-48,8.6},{-35,8.6}}, color={0,0,127}));
    connect(expansionValveChoke.port_b, simplePipe.port_a) annotation (Line(
          points={{-20,-2},{-6,-2},{-6,0},{10,0}}, color={0,127,255}));
    connect(simplePipe.port_b, sink.ports[1])
      annotation (Line(points={{30,0},{60,0}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent = {{-100,-100},{100,100}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points = {{-36,60},{64,0},{-36,-60},{-36,60}})}), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end ExpansionValveChokeMassFlowRate;
  annotation (Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Polygon(
          origin={8.0,14.0},
          lineColor={78,138,73},
          fillColor={78,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}));
end ExamplesExpansionValveChoke;
