within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model MoistSplitter "A simple model which weights a given set of mass fraction inputs
  to calculate an average mass fraction"

  parameter Integer nOut "Number of splitter outputs";
  parameter Integer nIn "Number of splitter inputs";
  parameter Real splitFactor[nIn, nOut]= fill(1/nOut, nOut, nIn)
    "Matrix of split factor for outputs (between 0 and 1 for each row)";
  Modelica.Blocks.Interfaces.RealInput portIn[nIn]
    "Single thermal input"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput portOut[nOut]
    "Set of thermal outputs" annotation (Placement(transformation(extent={{80,-20},
            {120,20}}), iconTransformation(extent={{80,-20},{120,20}})));

equation

  portOut = portIn * splitFactor
    "Equivalent building temperature rerouted to SignalInput";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{80,0},{-60,80}}, color={0,0,127}),
        Line(points={{80,0},{-60,40}}, color={0,0,127}),
        Line(points={{80,0},{-60,0}}, color={0,0,127}),
        Line(points={{80,0},{-60,-40}}, color={0,0,127}),
        Line(points={{80,0},{-60,-80}}, color={0,0,127})}),      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MoistSplitter;
