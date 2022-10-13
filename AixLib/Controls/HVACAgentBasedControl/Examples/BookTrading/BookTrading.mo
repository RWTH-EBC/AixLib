within AixLib.Controls.HVACAgentBasedControl.Examples.BookTrading;
model BookTrading
    extends Modelica.Icons.Example;

  BookBuyerAgent bookBuyerAgent(name=10001, ISBN=0618640150,
    sampleRate=1)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  BookSellerAgent bookSellerAgent(name=30001, bookList(start=[3551555559.0,30;
          3551555577.0,20; 3551555588.0,20]),
    sampleRate=1)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  BookSellerAgent bookSellerAgent1(name=30002, bookList(start=[3551555589.0,
          30; 3551555559.0,40; 3551555556.0,20]),
    sampleRate=1)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  BookSellerAgent bookSellerAgent2(name=30003, bookList(start=[3551555555.0,
          30; 3551555554.0,20; 3551555553.0,20; 3551555580.0,15]),
    sampleRate=1)
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  BookBuyerAgent bookBuyerAgent1(
    name=10002,
    ISBN=3551555559.0,
    sampleRate=1,
    sampleTime=40)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  BookBuyerAgent bookBuyerAgent2(
    ISBN=3551555559.0,
    name=10003,
    sampleRate=1,
    sampleTime=55)
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  inner Agents.MessageNotification messageNotification
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<ul>
  <li>This model is a an example to show the function of the
  BookBuyerAgent and BookSellerAgent in accordance to the BookTrading
  example provided in Caire, 2009, JADE PROGRAMMING FOR BEGINNERS.
  </li>
  <li>It acts as a prove that implementing functioning multi-agent
  systems on the basis of the Modelica language environment is
  possible.
  </li>
</ul>
<h4>
  <span style=\"color: #008000\">Concept</span>
</h4>
<p>
  The model consists of three BookBuyerAgents and three BookSeller
  agents. Two of the agents try to buy the book Harry Potter 1
  (ISBN=3551555559) and one tries to buy Lord of the Rings
  (ISBN=0618640150). Two of the seller agents have Harry Potter in
  Stock, none has Lord of the Rings in stock. The log (which can be
  found in the simulation tab of the Dymola message window), shows how
  the different requests are served (see Example Results). For further
  details, please refer to the first reference.
</p>
<p>
  The logic is implemented with the help of the StateGraph library.
  Communication is realized with the help of the DeviceDriver library
  and follows the language standards for multi-agent-systems set by the
  FIPA to the highest possible extend for Modelica models.
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
<ul>
  <li>BookBuyerAgent 10001 calls for proposals for book 6.1864e+008
  from BookSellerAgent 30001.
  </li>
  <li>BookSellerAgent 30001 has not found the book 6.1864e+008 and
  refuses the proposal.
  </li>
  <li>BookBuyerAgent 10001 calls for proposals for book 6.1864e+008
  from BookSellerAgent 30002.
  </li>
  <li>BookSellerAgent 30002 has not found the book 6.1864e+008 and
  refuses the proposal.
  </li>
  <li>BookBuyerAgent 10001 calls for proposals for book 6.1864e+008
  from BookSellerAgent 30003.
  </li>
  <li>BookSellerAgent 30003 has not found the book 6.1864e+008 and
  refuses the proposal.
  </li>
  <li>BookBuyerAgent 10001 was not offered the book 6.1864e+008. It
  goes back to idle.
  </li>
  <li>BookBuyerAgent 10001 calls for proposals for book 6.1864e+008
  from BookSellerAgent 30001.
  </li>
  <li>BookBuyerAgent 10002 calls for proposals for book 3.55156e+009
  from BookSellerAgent 30001.
  </li>
  <li>BookSellerAgent 30001 has found the book 3.55156e+009 and offers
  it for 30 €.
  </li>
  <li>BookBuyerAgent 10002 collects proposal for book 3.55156e+009.
  </li>
  <li>BookBuyerAgent 10002 calls for proposals for book 3.55156e+009
  from BookSellerAgent 30002.
  </li>
  <li>BookSellerAgent 30002 has found the book 3.55156e+009 and offers
  it for 40 €.
  </li>
  <li>BookBuyerAgent 10002 collects proposal for book 3.55156e+009.
  </li>
  <li>BookBuyerAgent 10002 calls for proposals for book 3.55156e+009
  from BookSellerAgent 30003.
  </li>
  <li>BookSellerAgent 30003 has not found the book 3.55156e+009 and
  refuses the proposal.
  </li>
  <li>BookBuyerAgent 10002 buys book 3.55156e+009 from BookSellerAgent
  30001.
  </li>
  <li>BookSellerAgent 30001 has found the book 3.55156e+009 and and
  sells it for 30 € to 10002.
  </li>
  <li>BookBuyerAgent 10002 has succesfully bought the book 3.55156e+009
  for 30 €.
  </li>
  <li>BookBuyerAgent 10003 calls for proposals for book 3.55156e+009
  from BookSellerAgent 30001.
  </li>
  <li>BookBuyerAgent 10001 was not served and goes back to idle.
  </li>
  <li>BookSellerAgent 30001 has not found the book 3.55156e+009 and
  refuses the proposal.
  </li>
  <li>BookBuyerAgent 10003 calls for proposals for book 3.55156e+009
  from BookSellerAgent 30002.
  </li>
  <li>BookSellerAgent 30002 has found the book 3.55156e+009 and offers
  it for 40 €.
  </li>
  <li>BookBuyerAgent 10003 collects proposal for book 3.55156e+009.
  </li>
  <li>BookBuyerAgent 10003 calls for proposals for book 3.55156e+009
  from BookSellerAgent 30003.
  </li>
  <li>BookSellerAgent 30003 has not found the book 3.55156e+009 and
  refuses the proposal.
  </li>
  <li>BookBuyerAgent 10003 buys book 3.55156e+009 from BookSellerAgent
  30002.
  </li>
  <li>BookSellerAgent 30002 has found the book 3.55156e+009 and and
  sells it for 40 € to 10003.
  </li>
  <li>BookBuyerAgent 10003 has succesfully bought the book 3.55156e+009
  for 40 €.
  </li>
</ul>
</html>",
      revisions="<html><ul>
  <li>October 2015, by Felix Bünning: Developed and implemented
  </li>
</ul>
</html>"),experiment(StopTime=400, Tolerance=1e-012),
      __Dymola_experimentSetupOutput);
end BookTrading;
