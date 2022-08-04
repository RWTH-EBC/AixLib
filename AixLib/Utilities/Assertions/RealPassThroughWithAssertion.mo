within AixLib.Utilities.Assertions;
model RealPassThroughWithAssertion
  "Asserts Real input value while passing it through to Real output"

  extends Modelica.Blocks.Routing.RealPassThrough;

  parameter Real minBound "Minimal value for the assertion boundary";
  parameter Real maxBound "Maximal value for the assertion boundary";
  parameter Modelica.Units.SI.Time startTime=-Modelica.Constants.inf
    "Time after which assert statement is applied";
  parameter AssertionLevel assertLevel=AssertionLevel.error "Level of assertion (built-in enumerator)";

initial equation
  assert(maxBound >= minBound, "Assertion block: Limits must be consistent. However, uMax (=" + String(maxBound) +
                     ") < uMin (=" + String(minBound) + ")");

equation
  if time > startTime then
    assert(u>=minBound and u<=maxBound,
      "In component " + getInstanceName() + " the variable value is not between bounds (min: " + String(minBound) + ", max: " + String(maxBound) + ")",
        assertLevel);
  end if;

  annotation (defaultComponentName="assertComp",
    Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Rectangle(
          extent={{-100,54},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,-100},{100,-54}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Forward),
        Text(
          extent={{-100,54},{100,30}},
          lineColor={0,0,127},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,255,255},
          textString="max = %maxBound"),
        Text(
          extent={{-100,-30},{100,-54}},
          lineColor={0,0,127},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,255,255},
          textString="min = %minBound")}),             Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>March 26, 2020 by Philipp Mehrfeld:<br/>
    First implementation. See <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/884\">#884</a>.
  </li>
</ul>
</html>", info="<html>
<p>
  Asserts Real input value while passing it through to Real output.
</p>
<p>
  Level of assertion message can be selected. Error will directly abort
  the simulation.
</p>
<p>
  As during a period after initialization one might not want to assert
  the Real value, the parameter startTime can be set.<br/>
  Use <span style=\"font-family: Courier New;\">startTime =
  Modelica.Constants.inf</span> to totally avoid assertion
  (functionality then is the same as in <span style=
  \"font-family: Courier New;\">Modelica.Blocks.Routing.RealPassThrough</span>).
</p>
</html>"));
end RealPassThroughWithAssertion;
