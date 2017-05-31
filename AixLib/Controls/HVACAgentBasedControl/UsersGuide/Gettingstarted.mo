within AixLib.Controls.HVACAgentBasedControl.UsersGuide;
class Gettingstarted "Getting started"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">What you can do with this library</span></h4>
<p>The Modelica HVACAgentBasedControl presents a set of agents which can control building energy systems and systems of similar characteristics (e.g. district heating networks or electrical smart-grids). It depcits a plug&AMP;play solution to control systems with multiple energy suppliers. With the help of a market-based communication mechanism and cost functions for each energy supplier, the most cost effective supplier in the system is always chosen. With the help of individual cost functions the &QUOT;costs&QUOT; that should be minimized can be defined individually by the developer (e.g. money, primary energy, exergy destruction). </p>
<h4><span style=\"color: #008000\">How you set up your system with agent-based control</span></h4>
<p>If you want to control a building energy system with multiple heat/cold suppliers and multiple heat/cold consumers here is how you set up the system:</p>
<ul>
<li>Equip each thermal zone with a RoomAgent just by placing an agent close to the zone in your model. The input of the room agent needs to be connected to a temperature sensor of the thermal zone</li>
<li>Equip each heat/cold supplier with a Heat/ColdProducerAgent and a corresponding CostFunction. Make sure that the heat supplier is able to use the demanded capacity from the &QUOT;setCapacity&QUOT; output of the agent.</li>
<li>Place a MessageNotification and a Broker anywhere in the model.</li>
<li>Give each agent an individual five-digit number in the parameters under &QUOT;name&QUOT;(e.g. 1000X for the consumers, 20001 for the broker, 3000X for the producers)</li>
<li>Write down all names of the ProducerAgents in the &QUOT;startTable&QUOT; of the broker. Delete or add more lines if necessary.</li>
</ul>
<p>The system is now ready to go. </p>
<p><b>If you used older versions of this library, please add a MessageNotification agent to your agent-based systems in order to make them work. For more information please refer to <a href=\"HVACAgentBasedControl.Agents.MessageNotification\">MessageNotification model</a>. </b></p>
<h4><span style=\"color: #008000\">What can a building energy system with agent-based control look like?</span></h4>
<p>Below you see an example building energy system which can be found <a href=\"HVACAgentBasedControl.Examples.BuildingHeatingSystems.BuildingHeating\">here</a>. The system consists of two thermal zones (or rooms) and two heat producers e.g. a heat pump and a boiler. The system is set up as described in the section above. For a more detailed description please refer to the <a href=\"HVACAgentBasedControl.Examples.BuildingHeatingSystems.BuildingHeating\">model itself</a>. There are more examples available in the Example package if you need further input. </p>
<p><img src=\"modelica://AixLib/Resources/Images/Controls/HVACAgentBasedControl/ExampleSystem.PNG\"/> </p>
</html>", revisions="<html>
<ul>
<li>November 2016, by Felix B&uuml;nning: Original implementation</li>
<li><i><span style=\"font-family: Arial,sans-serif;\">December 2016&nbsp;</i></span><span style=\"font-family: MS Shell Dlg 2;\"> by Roozbeh Sangi:<br>revised</span></li>
</ul>
</html>"));
end Gettingstarted;
