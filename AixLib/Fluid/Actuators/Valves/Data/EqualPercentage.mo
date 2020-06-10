within AixLib.Fluid.Actuators.Valves.Data;
record EqualPercentage =
                Generic (
    y =  {0,0.01,0.1,0.4,0.8,1},
    phi = {0.0001,0.015,0.03,0.1,0.45,1}) "Equal percentage opening curve"
  annotation (
defaultComponentName="datValLin",
defaultComponentPrefixes="parameter",
Documentation(info="<html>
<p>
Equal percentage valve opening characteristics with
a normalized leakage flow rate of <i>0.0001</i>.
</p>
</html>", revisions="<html>
<ul>
<li>
June 09, 2020, by Alexander Kümpel:<br/>
First implementation.
</li>
</ul>
</html>"));
