within AixLib.Controls.HVACAgentBasedControl.Examples.BuildingHeatingSystems;
model BuildingHeating_usePoke
  extends BuildingHeating(
    roomAgent(usePoke=true),
    roomAgent1(usePoke=true),
    broker(usePoke=true),
    messageNotification(usePoke=true, n=5),
    heatProducerAgent(usePoke=true),
    heatProducerAgent1(usePoke=true));
equation
  connect(roomAgent.sendOut, messageNotification.receive[1]) annotation (Line(
        points={{-41,127},{10,127},{10,150},{102,150},{102,128.4},{122,128.4}},
        color={255,0,255}));
  connect(roomAgent1.sendOut, messageNotification.receive[2]) annotation (Line(
        points={{39,127},{100,127},{100,129.2},{122,129.2}},
                                                         color={255,0,255}));
  connect(heatProducerAgent1.sendOut, messageNotification.receive[3])
    annotation (Line(points={{-1,-131},{114,-131},{114,130},{122,130}},
        color={255,0,255}));
  connect(heatProducerAgent.sendOut, messageNotification.receive[4])
    annotation (Line(points={{-81,-131},{-30,-131},{-30,-142},{116,-142},{116,
          130.8},{122,130.8}},
                        color={255,0,255}));
  connect(broker.sendOut, messageNotification.receive[5]) annotation (Line(
        points={{137,67},{144,67},{144,56},{110,56},{110,131.6},{122,131.6}},
        color={255,0,255}));
  annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<ul>
  <li>This model extends the BuildingHeating model
  </li>
  <li>It uses a different form of agent communication but the exact
  same physical model
  </li>
  <li>The alternative agent communication saves significant simulation
  time in systems where the agents are not active all the time
  </li>
</ul>
<h4>
  <span style=\"color: #008000\">Concept</span>
</h4>
<p>
  The parameter \"usePoke\" is set to true in all agents of the system.
  The parameter \"n\" in messageNotification is set to the number of
  other agents in the system (here 5). The \"senOut\" boolean outputs are
  then connected to the \"u\" input of the messageNotification agent. The
  system is set up.
</p>
<p>
  The conventional communication method uses a constant refresh-rate in
  the UDP inboxes of all agents, leading to excessive event generation,
  even when the agents are not active. This again leads to long
  simulation times. By using \"usePoke\", the UDP inboxes of the agents
  are only refreshed when another agent send out a message. The other
  agents are \"poked\" by the boolean signal and update their inboxes. In
  systems where the agents are idle in long periods of time, the
  \"usePoke\" technique can save substantial simulation time.
</p>
<p>
  For more information you can also refer to <a href=
  \"HVACAgentBasedControl.Agents.MessageNotification\">MessageNotification
  model</a>
</p>
<ul>
  <li>July 2017, by Roozbeh Sangi: Documentation modified
  </li>
  <li>November 2016, by Felix Bünning: Developed and implemented
  </li>
</ul>
</html>"),
    experiment(StartTime=2.6784e+006, StopTime=3.2832e+006),
    __Dymola_experimentSetupOutput);
end BuildingHeating_usePoke;
