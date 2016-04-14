within AixLib.Building.LowOrder.BaseClasses;
model Split "Splits a scalar input into an output vector"
  extends Modelica.Blocks.Interfaces.SIMO;
parameter Real coefficients[nout]= fill(1/nout, nout) "Split coefficients";
equation
 u * coefficients = y;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-2,4},{26,-30}},
          lineColor={255,0,0},
          textString="%",
          textStyle={TextStyle.Bold}),
        Line(
          points={{-80,0},{100,100},{100,100}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-80,0},{100,68},{100,68}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-80,0},{16,18},{100,36}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-80,0},{100,-100},{100,-100}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-80,0},{100,-66},{100,-66}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-80,0},{12,-18},{100,-34}},
          color={0,0,255},
          smooth=Smooth.None)}),
    Documentation(revisions="<html>
<ul>
<li><i>October 30, 2015&nbsp;</i> by Moritz Lauster:<br/>Moved and adapted to AixLib</li>
</ul>
</html>",
        info="<html>
<p>Works similar to <a href=\"Modelica.Blocks.Math.Sum\">Sum</a>, but extends SIMO, so splits one signal into nout-signals.</p>
</html>"));
end Split;
