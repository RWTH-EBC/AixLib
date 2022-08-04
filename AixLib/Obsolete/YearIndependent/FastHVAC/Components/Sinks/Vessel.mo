within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Sinks;
model Vessel "Vessel model"
extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

  /* *******************************************************************
      Components
      ******************************************************************* */

  FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a annotation (Placement(
        transformation(extent={{-88,-18},{-52,18}}), iconTransformation(
          extent={{-88,-18},{-52,18}})));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Icon(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{100,100}}), graphics={Rectangle(
          extent={{-70,68},{94,-60}},
          lineColor={127,0,0},
          lineThickness=1),
          Text(
          extent={{-40,66},{84,-52}},
          textString="%name",
          lineColor={0,0,255})}),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Sink model vessel.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Sink model for in stream variables mass flow and specific enthalpy
  flow.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  Examples can be found in <a href=
  \"modelica:/AixLib.FastHVAC.Examples.Sinks.SinkSourceVesselTest\">SinkSourceVesselTest</a>
</p>
</html>",
  revisions="<html><ul>
  <li>
    <i>November 28, 2016&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>December 16, 2014&#160;</i> Konstantin Finkbeiner:<br/>
    Implemented
  </li>
</ul>
</html>"));
end Vessel;
