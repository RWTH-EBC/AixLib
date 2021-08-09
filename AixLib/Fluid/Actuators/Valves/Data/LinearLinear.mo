within AixLib.Fluid.Actuators.Valves.Data;
record LinearLinear = GenericThreeWay(a_ab = Linear(), b_ab=Linear())
  "Linear-linear valve characteristic for three way valve"
  annotation (
defaultComponentName="datValLin",
defaultComponentPrefixes="parameter",
Documentation(info="<html>
<p>
Linear valve opening characteristics with
a normalized leakage flow rate of <i>0.0001</i>.
</p>
<p>
<b>Note</b>: This record is only for demonstration,
as the implementation in
<a href=\"modelica://AixLib.Fluid.Actuators.Valves.TwoWayLinear\">
AixLib.Fluid.Actuators.Valves.TwoWayLinear</a>
is more efficient.
</p>
</html>", revisions="<html>
<ul>
<li>
June 09, 2020, by Alexander Kümpel:<br/>
First implementation.
</li>
</ul>
</html>"));
