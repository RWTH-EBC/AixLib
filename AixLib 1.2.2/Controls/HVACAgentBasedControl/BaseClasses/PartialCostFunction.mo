within AixLib.Controls.HVACAgentBasedControl.BaseClasses;
partial model PartialCostFunction

  Modelica.Blocks.Interfaces.RealInput capacity
    "Input to connect with ProducerAgent"                                             annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,-100}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-80})));
  Modelica.Blocks.Interfaces.RealOutput cost
    "Output to connect with ProducerAgent"                                          annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,-100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,-90})));
equation

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={129,162,193},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-50,48},{46,-78}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="$")}),                Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Documentation(revisions="<html><ul>
  <li>November 2016: Developed and implemented by Felix Bünning
  </li>
</ul>
</html>",
    info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<ul>
  <li>This model implements a partial cost function.
  </li>
</ul>
<p>
  <b><span style=
  \"font-family: MS Shell Dlg 2; color: #008000;\">Concept</span></b>
</p>
<p>
  An input and output for capacity and cost respectively is
  implemented. Also the basic icon is implemented.
</p>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<ul>
  <li>Roozbeh Sangi, Felix Bünning, Johannes Fütterer, Dirk Müller. A
  Platform for the Agent-based Control of HVAC Systems. Modelica
  Conference, 2017, Prague, Czech Republic.
  </li>
  <li>Felix Bünning, Roozbeh Sangi, Dirk Müller. A Modelica library for
  agent-based control of building HVAC systems. Applied Energy,
  193:52-59, 2017.
  </li>
</ul>
</html>"));
end PartialCostFunction;
