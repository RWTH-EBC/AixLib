within AixLib.Building.LowOrder.BaseClasses;
model SolarRadWeightedSum
  "weights vec input and sums it up to one scalar output"
  parameter Integer n = 1 "number of inputs and weightfactors";
  parameter Real weightfactors[n] = {1}
    "weightfactors with which the inputs are to be weighted";
  Modelica.Blocks.Interfaces.RealInput
                                   solarRad_in[n] annotation(Placement(transformation(extent = {{-100, 0}, {-80, 20}}), iconTransformation(extent = {{-100, -10}, {-80, 10}})));
  Modelica.Blocks.Interfaces.RealOutput
                                    solarRad_out annotation(Placement(transformation(extent = {{80, 0}, {100, 20}}), iconTransformation(extent = {{80, -10}, {100, 10}})));
protected
  parameter Real sumWeightfactors = if sum(weightfactors) <0.0001 then 0.0001 else sum(weightfactors);
initial equation
  assert(noEvent(n == size(weightfactors, 1)), "weightfactors (likely Aw) has to have n elements");
  assert(noEvent(sum(weightfactors)>0.0001),"The sum of the weightfactors (likely the window areas) in SolarRadWeightedSum is 0. In case of no radiation (e.g. no windows) this might be correct.",level=AssertionLevel.warning);
equation
  solarRad_out = solarRad_in * weightfactors / sumWeightfactors;

//   //Nothing happens to other components
//   solarRad_out.I_dir = sum(solarRad_in.I_dir);
//   solarRad_out.I_diff = sum(solarRad_in.I_diff);
//   solarRad_out.I_gr = sum(solarRad_in.I_gr);
//   solarRad_out.AOI = sum(solarRad_in.AOI);
  annotation (Icon(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),                                                                                                    graphics={                                                                                                    Line(points={{
              -74,-20},{60,-20}},                                                                                                    color={255,
              128,0}),                                                                                                    Line(points={{
              -74,20},{60,20}},                                                                                                    color={255,
              128,0}),                                                                                                    Line(points={{
              60,20},{80,0}},                                                                                                    color={255,
              128,0}),                                                                                                    Line(points={{
              60,-20},{80,0}},                                                                                                    color={255,
              128,0}),
        Rectangle(
          extent={{-80,24},{-74,-24}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,30},{0,10},{20,20},{0,30}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-74,66},{72,30}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={236,99,92},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Polygon(
          points={{0,-10},{0,-30},{20,-20},{0,-10}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid)}),                                                                                                    Documentation(info="<html>
<p>This component weights the n-vectorial radiant input with n weightfactors and has a scalar output.</p>
<p><br/>The partial class contains following components:</p>
<ul>
<li>2 solar radiation ports</li>
</ul>
<h4>Main equations</h4>
<p> input(n)*weightfactors(n)/sum(weightfactors). </p>
<h4>Assumption and limitations</h4>
<p>If the weightfactors are all zero, Dymola tries to divide through zero. You will get a warning and the output is set to zero. </p>
<h4>Typical use and important parameters</h4>
<p>You can use this component to weight a radiant input and sum it up to one scalar output, e.g. weight the radiance of the sun of n directions with the areas of windows in n directions and sum it up to one scalar radiance on a non-directional window </p>
</html>",  revisions = "<html>
 <ul>
 <li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
 </ul>
 </html>"));
end SolarRadWeightedSum;
