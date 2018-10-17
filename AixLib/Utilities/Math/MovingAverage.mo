within AixLib.Utilities.Math;
model MovingAverage
  parameter Real T=24*3600 "Time span for average";
  Modelica.Blocks.Interfaces.RealInput u "Continuous input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y "Continuous output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

initial equation
y = u;

equation

  der(y)*T = u - delay(u,T);
  annotation ( Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={135,135,135},
          fillColor={222,222,148},
          fillPattern=FillPattern.Solid), Text(
          extent={{-100,-100},{102,-140}},
          lineColor={135,135,135},
          fillColor={222,222,148},
          fillPattern=FillPattern.Solid,
          textString="%name")}),
    Documentation(revisions="<html>
<ul>
<li><i>02.06.2014 </i>, by Kristian Huchtemann:<br/>
  implemented</li>
</ul>
</html>",
      info="<html>
<h4>Moving Average</h4>
<h4><span style=\"color:#008000\">Overview</span></h4>
<ul>
<li>Calculates a moving average between a past time instant and the actual simulation time.</li>
<li>Used to implement automatic user control decisions. E.g. a sun blind is closed when moving average of ambient temperature is above a certain level.</li>
</ul>

</html>"));
end MovingAverage;
