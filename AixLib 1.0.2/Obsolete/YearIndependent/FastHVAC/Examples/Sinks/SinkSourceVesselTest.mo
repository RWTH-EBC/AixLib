within AixLib.Obsolete.YearIndependent.FastHVAC.Examples.Sinks;
model SinkSourceVesselTest
  extends Modelica.Icons.Example;

  Components.Sinks.Sink sink
    annotation (Placement(transformation(extent={{-28,0},{-8,20}})));
  Components.Sinks.Vessel vessel
    annotation (Placement(transformation(extent={{80,-18},{100,2}})));
  Components.Pumps.FluidSource fluidSource
    annotation (Placement(transformation(extent={{-68,-16},{-48,4}})));
  Components.Sinks.Sink source(isSource=true)
    annotation (Placement(transformation(extent={{32,-70},{52,-50}})));
  Modelica.Blocks.Sources.Constant dotm(k=0.05)
    annotation (Placement(transformation(extent={{-96,-26},{-82,-12}})));
  Modelica.Blocks.Sources.Constant T_source(k=333.15)
    annotation (Placement(transformation(extent={{-96,2},{-82,16}})));
  Modelica.Blocks.Sources.Constant source_heatFlow(k=1000)
    annotation (Placement(transformation(extent={{26,-40},{40,-26}})));
  Modelica.Blocks.Sources.Constant sink_heatFlow(k=1000)
    annotation (Placement(transformation(extent={{-34,34},{-20,48}})));
  Components.Sensors.TemperatureSensor T_afterSink annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={12,-2})));
  Components.Sensors.TemperatureSensor T_afterSource annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={78,-36})));
equation
  connect(fluidSource.enthalpyPort_b, sink.enthalpyPort_a1) annotation (Line(
      points={{-48,-5},{-36,-5},{-36,10},{-27,10}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(sink_heatFlow.y, sink.Load) annotation (Line(
      points={{-19.3,41},{-18.1,41},{-18.1,18.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(source_heatFlow.y, source.Load) annotation (Line(
      points={{40.7,-33},{41.9,-33},{41.9,-51.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_source.y, fluidSource.T_fluid) annotation (Line(
      points={{-81.3,9},{-66,9},{-66,-1.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dotm.y, fluidSource.dotm) annotation (Line(
      points={{-81.3,-19},{-66,-19},{-66,-8.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sink.enthalpyPort_b1, T_afterSink.enthalpyPort_a) annotation (Line(
      points={{-9,10},{11.9,10},{11.9,6.8}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(T_afterSink.enthalpyPort_b, source.enthalpyPort_a1) annotation (
      Line(
      points={{11.9,-11},{11.9,-60},{33,-60}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(source.enthalpyPort_b1, T_afterSource.enthalpyPort_a) annotation (
      Line(
      points={{51,-60},{78.1,-60},{78.1,-44.8}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(T_afterSource.enthalpyPort_b, vessel.enthalpyPort_a) annotation (
      Line(
      points={{78.1,-27},{78.1,-8},{83,-8}},
      color={176,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics={
        Rectangle(
          extent={{100,60},{62,-80}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{60,60},{-38,-14}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,60},{-100,-80}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{96,100},{-100,70}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-46,92},{38,70}},
          lineColor={0,0,0},
          fontSize=14,
          textString="Test sink model
(incl. fluid source model)
"),     Rectangle(
          extent={{60,-16},{-38,-80}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{68,58},{100,46}},
          lineColor={0,0,0},
          fontSize=14,
          horizontalAlignment=TextAlignment.Left,
          textString="Vessel model. "),
        Text(
          extent={{-88,68},{-47,35}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          fontSize=14,
          horizontalAlignment=TextAlignment.Left,
          textString="Fluid source model. 
"),     Text(
          extent={{30,52},{86,46}},
          lineColor={0,0,0},
          fontSize=14,
          horizontalAlignment=TextAlignment.Left,
          textString="Sink 
with constant 
heat flow value."),
        Text(
          extent={{-36,-22},{20,-28}},
          lineColor={0,0,0},
          fontSize=14,
          horizontalAlignment=TextAlignment.Left,
          textString="Source 
with constant
heat flow value.")}));
end SinkSourceVesselTest;
