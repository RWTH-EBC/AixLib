within AixLib.Building.LowOrder.BaseClasses;
model SplitterRealPercent
  "A simple model which splits a given real input into different outputs weighted by given factors"
parameter Integer dimension "Dimension of the splitter";
parameter Real splitFactor[dimension]= fill(1/dimension, dimension)
    "weight factor for zones (between 0 and 1)";
  Modelica.Blocks.Interfaces.RealInput signalInput
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput signalOutput[dimension]
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
        iconTransformation(extent={{80,-20},{120,20}})));
equation
  for i in 1:dimension loop
    signalOutput[i] = splitFactor[i] * signalInput;
  end for;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-2,4},{26,-30}},
          lineColor={255,0,0},
          textString="%",
          textStyle={TextStyle.Bold}),
        Line(
          points={{-80,0},{14,80},{14,80}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-80,0},{18,48},{18,48}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-80,0},{16,18},{16,18}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-80,0},{12,-78},{12,-78}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-80,0},{12,-46},{12,-46}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-80,0},{12,-18},{12,-18}},
          color={0,0,255},
          smooth=Smooth.None),
        Text(
          extent={{-48,-82},{52,-100}},
          lineColor={0,0,255},
          textString="Percent")}),
    Documentation(revisions="<html>
<p><ul>
<li><i>October 30, 2015&nbsp;</i> by Moritz Lauster:<br/>Moved and adapted to AixLib</li>
</ul></p>
</html>"));
end SplitterRealPercent;
