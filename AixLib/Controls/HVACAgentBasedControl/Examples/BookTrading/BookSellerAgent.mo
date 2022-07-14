within AixLib.Controls.HVACAgentBasedControl.Examples.BookTrading;
model BookSellerAgent
  extends BaseClasses.PartialAgent;
  Real[:,2] bookList( start= [3551551677.0,30; 3551551679.0,20; 3551551616.0, 20]);
  Real searchedBook(start=0);
  Integer counter(start=1);
  Boolean bookInStock(start=false);
  Boolean bookToSell(start=false);
  Real index(start=1);

  //current message
  Integer sender_current(start=0);
  Integer performative_current(start=0);
  Real content_1_current(start=0);
  Real content_2_current(start=0);

  Modelica.Blocks.Math.IntegerChange integerChange annotation (Placement(
        transformation(extent={{-174,-50},{-154,-30}})));
  Modelica.StateGraph.InitialStep waiting(nIn=2, nOut=1)
    annotation (Placement(transformation(extent={{-180,-120},{-160,-100}})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
    annotation (Placement(transformation(extent={{-120,160},{-100,180}})));
  Modelica.StateGraph.TransitionWithSignal newMessage
    annotation (Placement(transformation(extent={{-144,-120},{-124,-100}})));
  Modelica.StateGraph.Step checkPurpose(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{-108,-120},{-88,-100}})));
  Modelica.StateGraph.TransitionWithSignal OfferRequestsServer(enableTimer=true,
      waitTime=0.1)
    annotation (Placement(transformation(extent={{-118,100},{-98,120}})));
  Modelica.StateGraph.TransitionWithSignal PurchaseOrdersServer(enableTimer=true,
      waitTime=0.1)
    annotation (Placement(transformation(extent={{-120,0},{-100,20}})));
  Modelica.StateGraph.Step checkLibrary(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-60,100},{-40,120}})));
  Modelica.StateGraph.Step composeResponse(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{20,100},{40,120}})));
  Modelica.StateGraph.StepWithSignal sendResponse(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{100,100},{120,120}})));
  Modelica.StateGraph.Step checkLibrary1(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Modelica.StateGraph.Step composeResponse1(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Modelica.StateGraph.StepWithSignal sendResponse1(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{100,0},{120,20}})));
  Modelica.StateGraph.Transition transition(enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{-24,100},{-4,120}})));
  Modelica.StateGraph.Transition transition1(enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{60,100},{80,120}})));
  Modelica.StateGraph.Transition transition2(enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{-24,0},{-4,20}})));
  Modelica.StateGraph.Transition transition3(enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{60,0},{80,20}})));
  Modelica.StateGraph.Transition transition4(enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{10,-138},{-10,-118}})));
  Modelica.StateGraph.Transition transition5(enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{10,-178},{-10,-158}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{150,-80},{170,-60}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=
        performative_current == 4)
    annotation (Placement(transformation(extent={{-74,74},{-100,92}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=
        performative_current == 19)
    annotation (Placement(transformation(extent={{-74,-16},{-100,2}})));

algorithm
  when waiting.active then
    searchedBook := 0;
    counter := 1;
    bookInStock :=false;
    bookToSell :=false;
    index :=1;
  end when;

  when checkPurpose.active then
    sender_current := getsender.y[1];
    performative_current := getperformative.y[1];
    content_1_current := get_content.y[1];
    content_2_current := get_content.y[2];

  end when;

  when checkLibrary.active then

    searchedBook := content_1_current;
    for index in 1:size(bookList,1) loop
      if Modelica.Math.isEqual(bookList[index,1],searchedBook) then
         bookInStock := true;
         counter  := index;
         break;
      end if;
    end for;
  end when;

 when composeResponse.active then

      sender.u[1]:=name;
      reply_to.u[1] := name;
      ontology.u[1] := 1;
      uDPSend_adapted.receiver := sender_current;
      receiver.u[1]:= sender_current;
      messageID.u[1] := name*name + integer(time);

      if bookInStock then
        content.u[1] := bookList[counter,2];
        content.u[2] := bookList[counter,1];
        performative.u[1]:= 13;
        Modelica.Utilities.Streams.print("BookSellerAgent "+ String(name)+ " has found the book " + String(get_content.y[1]) + " and offers it for "+ String(bookList[counter,2])+" €.");
      else
        content.u[1] := 0;
        content.u[2] := 0;
        performative.u[1]:= 17;
        Modelica.Utilities.Streams.print("BookSellerAgent "+ String(name)+ " has not found the book " + String(get_content.y[1]) + " and refuses the proposal.");
      end if;

  end when;

  when checkLibrary1.active then
    searchedBook := content_1_current;
    for index in 1:size(bookList,1) loop
      if Modelica.Math.isEqual(bookList[index,1],searchedBook) then
         bookToSell := true;
         counter := index;
         break;
      end if;
    end for;

  end when;

  when composeResponse1.active then

      sender.u[1]:=name;
      reply_to.u[1] := name;
      ontology.u[1] := 1;
      uDPSend_adapted.receiver := sender_current;
      receiver.u[1]:= sender_current;
      messageID.u[1] := name*name + integer(time);

     if bookToSell then
       Modelica.Utilities.Streams.print("BookSellerAgent "+ String(name)+ " has found the book " + String(get_content.y[1]) + " and and sells it for "+ String(bookList[counter,2])+" € to " + String(getsender.y[1])+".");
       content.u[1] := bookList[counter,2];
       content.u[2] := bookList[counter,1];
       performative.u[1]:= 5;
       bookList[counter,2] := 0;
       bookList[counter,1] := 0;

     else
       content.u[1] := 0;
       content.u[2] := 0;
       performative.u[1]:= 17;
       Modelica.Utilities.Streams.print("BookSellerAgent "+ String(name)+ " has not found the book " + String(get_content.y[1]) + " and and can therefore not sell it.");
     end if;

  end when;

equation
  connect(getMessageID.y[1], integerChange.u) annotation (Line(
      points={{-179,-40},{-176,-40}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(waiting.outPort[1], newMessage.inPort) annotation (Line(
      points={{-159.5,-110},{-138,-110}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(newMessage.outPort,checkPurpose. inPort[1]) annotation (Line(
      points={{-132.5,-110},{-109,-110}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(checkPurpose.outPort[1], OfferRequestsServer.inPort) annotation (Line(
      points={{-87.5,-109.75},{-72,-109.75},{-72,-30},{-134,-30},{-134,110},{-112,
          110}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(checkPurpose.outPort[2], PurchaseOrdersServer.inPort) annotation (
      Line(
      points={{-87.5,-110.25},{-72,-110.25},{-72,-30},{-134,-30},{-134,10},{-114,
          10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(OfferRequestsServer.outPort, checkLibrary.inPort[1]) annotation (Line(
      points={{-106.5,110},{-61,110}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition.inPort, checkLibrary.outPort[1]) annotation (Line(
      points={{-18,110},{-39.5,110}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition.outPort, composeResponse.inPort[1]) annotation (Line(
      points={{-12.5,110},{19,110}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(composeResponse.outPort[1], transition1.inPort) annotation (Line(
      points={{40.5,110},{66,110}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition1.outPort, sendResponse.inPort[1]) annotation (Line(
      points={{71.5,110},{99,110}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition4.outPort, waiting.inPort[1]) annotation (Line(
      points={{-1.5,-128},{-190,-128},{-190,-109.5},{-181,-109.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition5.outPort, waiting.inPort[2]) annotation (Line(
      points={{-1.5,-168},{-190,-168},{-190,-110.5},{-181,-110.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sendResponse.outPort[1], transition4.inPort) annotation (Line(
      points={{120.5,110},{130,110},{130,-128},{4,-128}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sendResponse1.outPort[1], transition5.inPort) annotation (Line(
      points={{120.5,10},{130,10},{130,-168},{4,-168}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(PurchaseOrdersServer.outPort, checkLibrary1.inPort[1]) annotation (
      Line(
      points={{-108.5,10},{-61,10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(checkLibrary1.outPort[1], transition2.inPort) annotation (Line(
      points={{-39.5,10},{-18,10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition2.outPort, composeResponse1.inPort[1]) annotation (Line(
      points={{-12.5,10},{19,10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(composeResponse1.outPort[1], transition3.inPort) annotation (Line(
      points={{40.5,10},{66,10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition3.outPort, sendResponse1.inPort[1]) annotation (Line(
      points={{71.5,10},{99,10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(uDPSend_adapted.trigger, or1.y) annotation (Line(
      points={{176,-70},{171,-70}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(or1.u1, sendResponse.active) annotation (Line(
      points={{148,-70},{140,-70},{140,94},{110,94},{110,99}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sendResponse1.active, or1.u2) annotation (Line(
      points={{110,-1},{110,-6},{136,-6},{136,-78},{148,-78}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression1.y, OfferRequestsServer.condition) annotation (Line(
      points={{-101.3,83},{-108,83},{-108,98}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression2.y, PurchaseOrdersServer.condition) annotation (
      Line(
      points={{-101.3,-7},{-110,-7},{-110,-2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(integerChange.y, newMessage.condition) annotation (Line(
      points={{-153,-40},{-146,-40},{-146,-124},{-134,-124},{-134,-122},{-134,-122}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<ul>
  <li>This model is a an agent that offers and sells books to calling
  BookBuyerAgents.
  </li>
  <li>It is based on communication via UDP and logic implemented with
  the help of the StateGraph Modelica library.
  </li>
  <li>It is used together with at least one BookSellerAgent.
  </li>
</ul>
<h4>
  <span style=\"color: #008000\">Concept</span>
</h4>
<p>
  The BookSellerAgent responds to calls from a BookBuyerAgent. This can
  be a call for proposals or a request to buy a book. When a call for
  proposals comes in, the BookSellerAgent checks whether the required
  book is in stock or not. If yes, it reponds with the corresponding
  price, if no, it refuses the call. When a request to buy a book comes
  in, the agent looks for the book in stock, sells it and afterwards
  removes it from the stock list. The logic is implemented with the
  help of the StateGraph library. Communication is realized with the
  help of the DeviceDriver library and follows the language standards
  for multi-agent-systems set by the FIPA to the highest possible
  extend for Modelica models. The presented agent has the purpose of
  demonstrating the possibility of agent implementation in Modelica by
  implementing the behaviour of the BookSeller agent presented in
  Caire, 2009, JADE PROGRAMMING FOR BEGINNERS.
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
  <li>
    <a href=
    \"HVACAgentLibraryRealValues.BookTradingExample.ExampleBookTrading\">ExampleBookTrading</a>
  </li>
  <li>
    <a href=
    \"HVACAgentLibraryRealValues.BookTradingExample.ExampleNetworkCommunication1\">
    ExampleNetworkCommunication1</a>
  </li>
</ul>
</html>",
      revisions="<html><ul>
  <li>October 2015, by Felix Bünning: Developed and implemented
  </li>
</ul>
</html>"),Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-82,38},{-62,38},{-42,-44},{46,-44},{62,22},{-58,22}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-46,-22},{50,-22}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-52,0},{56,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-22,22},{-10,-44}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{26,22},{14,-44}},
          color={0,0,0},
          smooth=Smooth.None),
        Ellipse(extent={{-48,-46},{-18,-76}}, lineColor={0,0,0}),
        Ellipse(extent={{22,-46},{52,-76}}, lineColor={0,0,0}),
        Text(
          extent={{-78,88},{84,48}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="%name%")}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-200},{200,200}}), graphics={
        Rectangle(
          extent={{-138,36},{142,-68}},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-138,138},{142,36}},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-76,78},{74,60}},
          lineColor={0,0,0},
          fillColor={206,255,229},
          fillPattern=FillPattern.Solid,
          fontSize=14,
          textString="OfferRequestsServer"),
        Text(
          extent={{-78,-30},{72,-48}},
          lineColor={0,0,0},
          fillColor={206,255,229},
          fillPattern=FillPattern.Solid,
          fontSize=14,
          textString="PurchaseOrderServer")}));
end BookSellerAgent;
