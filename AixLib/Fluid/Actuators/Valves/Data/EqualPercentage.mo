within AixLib.Fluid.Actuators.Valves.Data;
record EqualPercentage =
                Generic (
    y =  {0,0.01,0.1,0.3,0.5,0.7,0.9,1},
    phi = {0.0001,0.018,0.03,0.065,0.141,0.31,0.68,1}) "Equal percentage opening curve"
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
