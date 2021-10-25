within AixLib.Fluid.Interfaces;
model PassThroughMedium "To make medium connectors conditional"
  extends AixLib.Fluid.Interfaces.PartialTwoPort;
equation
  connect(port_a, port_b)
    annotation (Line(points={{-100,0},{100,0}}, color={0,127,255}));
  annotation (Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,127,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Line(
          points={{-94,0},{92,0}},
          color={0,127,255},
          thickness=0.5)}), Documentation(info="<html><p>
  Model to make models extending the TwoPort-Model optional.
</p>
<p>
  Idea is based on the model <a href=
  \"Modelica.Blocks.Routing.RealPassThrough\">RealPassThrough</a> of the
  standard library.
</p>
<ul>
  <li>January 06, 2020, by Fabian Wuellhorst:<br/>
    Change extend to TwoPort instead of TwoPortInterface (see issue
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/833\">833</a>).
  </li>
  <li>August 08, 2018, by Fabian Wuellhorst, Philipp Mehrfeld:<br/>
    First implementation
  </li>
</ul>
</html>"));
end PassThroughMedium;
