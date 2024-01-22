within AixLib.Controls.HVACAgentBasedControl.Examples.BookTrading;
model NetworkCommunication1
    extends Modelica.Icons.Example;

  BookSellerAgent bookSellerAgent1(            bookList(start=[3551555589.0,
          30; 3551555559.0,40; 3551555556.0,20]),
    uDPSend_adapted(IPAddress="134.130.49.128"),
    name=10003,
    sampleRate=1)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica_DeviceDrivers.Blocks.OperatingSystem.SynchronizeRealtime
    synchronizeRealtime(priority="Below normal")
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  inner Agents.MessageNotification messageNotification
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<ul>
  <li>This model is part of a system to demonstrate agent communication
  over a network connection.
  </li>
  <li>It uses a simple example case in which a single book is bought by
  a BookSellerAgent from a BookBuyerAgent.
  </li>
  <li>It is used together with the model NetWorkCommunication2.
  </li>
</ul>
<h4>
  <span style=\"color: #008000\">Concept</span>
</h4>
<p>
  The model NetworkCommunication1 harbors the BookSellerAgent. The
  model NetworkCommunication2 harbors the BookBuyerAgent. In order to
  run the system, the model NetworkCommunication1 needs to be opened on
  one machine and the model NetworkCommunicatio2 needs to be opened on
  another machine on the same local network. In the parameters of the
  featured BookBuyerAgent and BookSellerAgent the network IP adress of
  the other machine needs to be specified under
  \"uDPSend_adapted(IPAddress=\"134.130.49.128\")\". (For example, if
  NetworkCommunication1 runs on a machine with local IP address
  192.168.2.1 and NetworkCommunication2 runs on a machine with local IP
  address 192.168.2.2, change the parameter of the BookSellerAgent in
  NetworkCommunication1 to \"uDPSend_adapted(IPAddress=\"192.168.2.2\")\".)
</p>
<p>
  Start the simulation of both models at roughly the same time and a
  book will be traded over the local network, as can be seen in the
  example results.
</p>
<h4>
  <span style=\"color: #008000;\">References</span>
</h4>
<ul>
  <li>Felix Bünning. Development of a Modelica-library for agent-based
  control of HVAC systems. Bachelor thesis, 2016, RWTH Aachen
  University, Aachen, Germany.
  </li>
  <li>FIPA ACL Message Structure Specification
  </li>
  <li>FIPA Communicative Act Library Specification
  </li>
  <li>Caire, 2009, JADE PROGRAMMING FOR BEGINNERS
  </li>
</ul>
<h4>
  <span style=\"color: #008000\">Example Results</span>
</h4>
<p>
  Results on the machine running NetworkCommunication1
  (BookSellerAgent):
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Controls/HVACAgentBasedControl/ScreenshotSellerAgent_marked.png\"
  alt=\"Seller agent\">
</p>
<p>
  Results on the machine running NetworkCommunication2
  (BookBuyerAgent):
</p>
<p>
  <img src=
  \"modelica:/AixLib/Resources/Images/Controls/HVACAgentBasedControl/ScreenshotBuyerAgent_marked.png\"
  alt=\"Buyer agent\">
</p>
<ul>
  <li>November 2016, by Felix Bünning: Info-window updated
  </li>
  <li>October 2015, by Felix Bünning: Developed and implemented
  </li>
</ul>
</html>"),experiment(StopTime=1000, Tolerance=1e-012),
      __Dymola_experimentSetupOutput);
end NetworkCommunication1;
