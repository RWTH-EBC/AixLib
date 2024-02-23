within AixLib.Controls.HVACAgentBasedControl.Agents;
model MessageNotification

  parameter Integer n=1
    "Number of Boolean inputs (number of other agents in the system)";
  parameter Boolean usePoke=false
    "Mode for different type of communication (standard is false)";

  Modelica.Blocks.MathBoolean.Or receiverCollector(nu=n) if usePoke
    annotation (Placement(transformation(extent={{-60,-6},{-48,6}})));
  Modelica.Blocks.Interfaces.BooleanInput  receive[n] if usePoke
    "Input to connect with other agents"
    annotation (Placement(transformation(extent={{-100,-20},{-60,20}}), iconTransformation(extent={{-100,
            -20},{-60,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    "Notification for other agents (not connected to anything)"
    annotation (Placement(transformation(extent={{80,-10},{100,10}}), iconTransformation(extent={{80,-10},
            {100,10}})));
equation
  connect(receive,receiverCollector. u) annotation (Line(points={{-80,0},{-80,0},{-60,0}},
                  color={255,0,255}));

  if usePoke then
    connect(receiverCollector.y, y)
    annotation (Line(points={{-47.1,0},{90,0},{90,0}},   color={255,0,255}));
  else
    y = false;
  end if;
  annotation (defaultComponentPrefixes="inner", Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-58,34},{50,-38}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Line(
          points={{-58,34},{-4,-6}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{50,34},{-4,-6}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-58,-38},{-14,2}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{50,-38},{6,2}},
          color={0,0,0},
          thickness=0.5)}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>November 2016, by Felix Bünning: Developed and implemented
  </li>
</ul>
</html>", info="<html>
<h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<ul>
  <li>This model is necessary to enable the agents to communicate with
  each other
  </li>
  <li>It needs to be placed in every system that uses agent-based
  control, similar to the \"System\" model in the Modelica.Fluid package
  </li>
  <li>It supports two different types of agent communication
  </li>
  <li>
    <h4>
      If you used an earlier version of this library and have problems
      running your agent system, add this component and the system
      should run again
    </h4>
  </li>
</ul>
<h4>
  <span style=
  \"font-family: MS Shell Dlg 2; color: #008000;\">Concept</span>
</h4>
<p>
  Every agent system needs a MessageNotification model in order to
  function, similar to the \"System\" model of the Modelica.Fluid
  library. The MessageNotification is responsible for ensuring that the
  agents receive their messages and update their inbox.
</p>
<p>
  There are two different possibilities to notify the agents when they
  receive a message. The standard one corresponds to earlier versions
  of the library and is set by setting usePoke=false in the
  MessageNotification models and all other agents in the system. When
  this setting is made, the UDP inbox of all agents gets updated every
  n seconds (n set by user). This is straight forward but also leads to
  time event generation (weak simulation performance). If usePoke is
  set to true, the Boolean sendOut connectors of every agent in the
  system needs to be connected to the Boolean receive[n] input of the
  MessageNotification model. With this method, the agents only update
  their inbox in case one agent has sent out a message. This reduces
  event generation during idle times of the agents and thus may
  increase simulation perfomance in systems with long idle times of the
  agents. Example images for both methods are provided below. For
  further information you can also refer to the example results.
</p>
<p>
  System with usePoke=false
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Controls/HVACAgentBasedControl/ExampleSystemMarked.png\"
  alt=\"Example system\">
</p>
<p>
  System with usePoke=true
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Controls/HVACAgentBasedControl/ExampleSystemMarkedPoke.PNG\"
  alt=\"Example system poke\">
</p>
<h4>
  <span style=\"color: #008000\">Example Results</span>
</h4>
<ul>
  <li>
    <a href=
    \"HVACAgentBasedControl.Examples.BuildingHeatingSystems.BuildingHeating\">
    System with usePoke=false</a>
  </li>
  <li>
    <a href=
    \"HVACAgentBasedControl.Examples.BuildingHeatingSystems.BuildingHeating_usePoke\">
    System with usePoke=true</a>
  </li>
</ul>
</html>"));
end MessageNotification;
