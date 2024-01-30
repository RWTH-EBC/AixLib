within AixLib.Controls.HVACAgentBasedControl.Examples.BookTrading;
model BookBuyerAgent
  extends BaseClasses.PartialAgent;
  parameter Real[:,1] knownSellers = [30001; 30002; 30003]
    "List of known BookSellerAgents (their adresses)";
  Real[3,2] proposals(start=[9999,9999;9999,9999;9999,9999]);
  parameter Real ISBN = 3551551677.0
    "ISBN number of the book that the agent tries to buy";
  Integer counter( start=1);
  Integer counterProposals( start=1);
  Boolean requestsDone(start=false);
  Real lowestPrice(start=9999999);
  Boolean bookOffered(start=false);
  parameter Integer  sampleTime = 20
    "Period of time between two tries of the agent to buy the book";

  Modelica.StateGraph.InitialStep waiting(nIn=4, nOut=1)
    annotation (Placement(transformation(extent={{-166,-138},{-146,-118}})));
  Modelica.StateGraph.Step composeRequest(nIn=3, nOut=1)
    annotation (Placement(transformation(extent={{-84,116},{-64,136}})));
  Modelica.StateGraph.Step collectProposal(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{10,50},{30,70}})));
  Modelica.StateGraph.Step composeBuy(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-12,-66},{8,-46}})));
  Modelica.Blocks.Math.IntegerChange integerChange annotation (Placement(
        transformation(extent={{-158,72},{-138,92}})));
  Modelica.Blocks.Sources.SampleTrigger sampleTrigger(period=sampleTime,
      startTime=sampleTime)
    annotation (Placement(transformation(extent={{-194,-100},{-174,-80}})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal
    annotation (Placement(transformation(extent={{-144,-18},{-124,2}})));
  Modelica.StateGraph.Transition transition(enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{-44,116},{-24,136}})));
  Modelica.StateGraph.Step check(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.StateGraph.TransitionWithSignal newMessage
    annotation (Placement(transformation(extent={{90,116},{110,136}})));
  Modelica.StateGraph.TransitionWithSignal offer(enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{-36,50},{-16,70}})));
  Modelica.StateGraph.TransitionWithSignal refuse(enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{-36,8},{-16,28}})));
  Modelica.StateGraph.TransitionWithSignal done(enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{58,50},{78,70}})));
  Modelica.StateGraph.TransitionWithSignal notDone(enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{58,6},{78,26}})));
  Modelica.StateGraph.StepWithSignal sendRequest(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{-2,116},{18,136}})));
  Modelica.StateGraph.StepWithSignal sendBuy(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{54,-66},{74,-46}})));
  Modelica.StateGraph.Step check1(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{-72,-140},{-52,-120}})));
  Modelica.StateGraph.TransitionWithSignal confirmation(enableTimer=true,
      waitTime=0.1)
    annotation (Placement(transformation(extent={{0,-140},{20,-120}})));
  Modelica.StateGraph.Step setDone(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{40,-140},{60,-120}})));
  Modelica.StateGraph.Transition transition1(enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{22,-66},{42,-46}})));
  Modelica.StateGraph.Transition transition3(enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{90,-140},{110,-120}})));
  Modelica.Blocks.Interfaces.BooleanOutput bookBought
    "Indicator that turns true if a book was succesfully bought"                                                   annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,198}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,90})));
  Modelica.StateGraph.TransitionWithSignal newMessage1
    annotation (Placement(transformation(extent={{90,-80},{110,-60}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{150,-90},{170,-70}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=(
        getperformative.y[1] == 13) or (requestsDone))
    annotation (Placement(transformation(extent={{-80,26},{-54,44}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=
        getperformative.y[1] == 17)
    annotation (Placement(transformation(extent={{-80,-10},{-54,8}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=requestsDone)
    annotation (Placement(transformation(extent={{10,24},{36,42}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y=not (
        requestsDone))
    annotation (Placement(transformation(extent={{10,-10},{36,8}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression4(y=
        getperformative.y[1] == 5)
    annotation (Placement(transformation(extent={{-32,-162},{-6,-144}})));
  Modelica.StateGraph.Transition abort(enableTimer=true, waitTime=30)
    annotation (Placement(transformation(extent={{-34,-186},{-14,-166}})));

  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
    annotation (Placement(transformation(extent={{-140,180},{-120,200}})));
  Modelica.StateGraph.Step stateOfOffers(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{-68,-66},{-48,-46}})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal1
    annotation (Placement(transformation(extent={{-40,-46},{-20,-66}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression5(y=bookOffered)
    annotation (Placement(transformation(extent={{-80,-40},{-54,-22}})));
  Modelica.StateGraph.Transition noOffers(enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{-150,-172},{-170,-152}})));
  Modelica.StateGraph.Transition abortAction(
                                            enableTimer=true, waitTime=15)
    annotation (Placement(transformation(extent={{90,154},{110,174}})));
  Modelica.StateGraph.Transition abortAction1(
                                            enableTimer=true, waitTime=15)
    annotation (Placement(transformation(extent={{90,-48},{110,-28}})));
  Modelica.StateGraph.Step notServed(nIn=2, nOut=1)
                                            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={182,-158})));
  Modelica.StateGraph.Transition transition2(                  waitTime=0.1,
      enableTimer=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={182,-184})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-150,-74},{-138,-62}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression6(y=not (
        bookBought))
    annotation (Placement(transformation(extent={{-194,-76},{-174,-56}})));

algorithm
    when waiting.active then
      counter :=1;
      counterProposals :=1;
      lowestPrice := 9999999;
      bookOffered :=false;
    end when;

    when composeRequest.active then
      content.u[1] := ISBN; //temporary function
      content.u[2] := 0;
      performative.u[1]:= 4;
      sender.u[1]:=name;
      reply_to.u[1] := name;
      ontology.u[1] := 1;
      uDPSend_adapted.receiver := knownSellers[counter,1];
      receiver.u[1]:= integer(knownSellers[counter,1]);
      messageID.u[1] := name*name + integer(time);
      Modelica.Utilities.Streams.print("BookBuyerAgent "+ String(name)+ " calls for proposals for book " + String(ISBN) + " from BookSellerAgent "+ String(knownSellers[counter,1])+".");
    end when;

    when sendRequest.active then
      counter := counter +1;
      if counter > size(knownSellers,1) then
        requestsDone := true;
      end if;
    end when;

    when collectProposal.active then
      if Modelica.Math.isEqual(getperformative.y[1],13) then
        bookOffered :=true;
        Modelica.Utilities.Streams.print("BookBuyerAgent "+ String(name)+ " collects proposal for book " + String(ISBN)+".");
      end if;

      proposals[counterProposals,1] := get_content.y[1];
      proposals[counterProposals,2] := getsender.y[1];
      counterProposals := counterProposals +1;

    end when;

    when composeBuy.active then
     counter := 1;
     lowestPrice := min(proposals[:,1]);
     // loop to find the cheapest producer
     for counter in 1:size(proposals,1) loop
       if Modelica.Math.isEqual(proposals[counter,1],lowestPrice) then
         break;
       end if;
     end for;

     //send out accept proposal to the cheapest producer
     performative.u[1]:=19;
     sender.u[1]:=name;
     receiver.u[1]:= integer(proposals[counter,2]);
     reply_to.u[1] := name;
     content.u[1] := ISBN;
     ontology.u[1] := 1;
     uDPSend_adapted.receiver := proposals[counter,2];
     messageID.u[1] := name*name + integer(time);
     Modelica.Utilities.Streams.print("BookBuyerAgent "+ String(name)+ " buys book " + String(ISBN) + " from BookSellerAgent "+ String(proposals[counter,2])+".");

    end when;

    when setDone.active then
      bookBought := true;
      Modelica.Utilities.Streams.print("BookBuyerAgent "+ String(name)+ " has succesfully bought the book " + String(ISBN) + " for "+ String(proposals[counter,1])+" €.");
    end when;

    when stateOfOffers.active then
      if not
            (bookOffered) then
        Modelica.Utilities.Streams.print("BookBuyerAgent "+ String(name)+ " was not offered the book " + String(ISBN) + ". It goes back to idle.");
      end if;
    end when;

    when notServed.active then
       Modelica.Utilities.Streams.print("BookBuyerAgent "+ String(name)+ " was not served and goes back to idle.");
    end when;

equation
  connect(waiting.outPort[1], transitionWithSignal.inPort) annotation (Line(
      points={{-145.5,-128},{-140,-128},{-140,-8},{-138,-8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transitionWithSignal.outPort, composeRequest.inPort[1]) annotation (
      Line(
      points={{-132.5,-8},{-104,-8},{-104,126.667},{-85,126.667}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition.inPort, composeRequest.outPort[1]) annotation (Line(
      points={{-38,126},{-63.5,126}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(newMessage.outPort, check.inPort[1]) annotation (Line(
      points={{101.5,126},{126,126},{126,94},{-92,94},{-92,60},{-81,60}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(check.outPort[1], offer.inPort) annotation (Line(
      points={{-59.5,60.25},{-60,60.25},{-60,60},{-30,60}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(offer.outPort, collectProposal.inPort[1]) annotation (Line(
      points={{-24.5,60},{-16,60},{-16,60},{-8,60},{-8,60},{9,60}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(refuse.inPort, check.outPort[2]) annotation (Line(
      points={{-30,18},{-44,18},{-44,59.75},{-59.5,59.75}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(refuse.outPort, composeRequest.inPort[2]) annotation (Line(
      points={{-24.5,18},{-10,18},{-10,-8},{-104,-8},{-104,126},{-85,126}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(collectProposal.outPort[1], notDone.inPort) annotation (Line(
      points={{30.5,60.25},{40,60.25},{40,60},{48,60},{48,16},{64,16}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(done.inPort, collectProposal.outPort[2]) annotation (Line(
      points={{64,60},{80,60},{80,59.75},{30.5,59.75}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(notDone.outPort, composeRequest.inPort[3]) annotation (Line(
      points={{69.5,16},{120,16},{120,-8},{-104,-8},{-104,125.333},{-85,125.333}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(sendRequest.outPort[1], newMessage.inPort) annotation (Line(
      points={{18.5,126.25},{78,126.25},{78,126},{96,126}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sendRequest.inPort[1], transition.outPort) annotation (Line(
      points={{-3,126},{-32.5,126}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(composeBuy.outPort[1], transition1.inPort) annotation (Line(
      points={{8.5,-56},{14,-56},{14,-56},{16,-56},{16,-56},{28,-56}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition1.outPort, sendBuy.inPort[1]) annotation (Line(
      points={{33.5,-56},{38,-56},{38,-56},{42,-56},{42,-56},{53,-56}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(confirmation.inPort, check1.outPort[1]) annotation (Line(
      points={{6,-130},{-48,-130},{-48,-129.75},{-51.5,-129.75}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(setDone.inPort[1], confirmation.outPort) annotation (Line(
      points={{39,-130},{11.5,-130}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition3.inPort, setDone.outPort[1]) annotation (Line(
      points={{96,-130},{62,-130},{62,-129.75},{60.5,-129.75}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition3.outPort, waiting.inPort[1]) annotation (Line(
      points={{101.5,-130},{134,-130},{134,-192},{-180,-192},{-180,-127.25},{-167,
          -127.25}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(newMessage1.inPort, sendBuy.outPort[1]) annotation (Line(
      points={{96,-70},{86,-70},{86,-55.75},{74.5,-55.75}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(newMessage1.outPort, check1.inPort[1]) annotation (Line(
      points={{101.5,-70},{126,-70},{126,-100},{-92,-100},{-92,-130},{-73,-130}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(or1.y, uDPSend_adapted.trigger) annotation (Line(
      points={{171,-80},{172,-80},{172,-70},{176,-70}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(or1.u1, sendRequest.active) annotation (Line(
      points={{148,-80},{154,-80},{154,84},{8,84},{8,115}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(or1.u2, sendBuy.active) annotation (Line(
      points={{148,-88},{64,-88},{64,-67}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression.y, offer.condition) annotation (Line(
      points={{-52.7,35},{-26,35},{-26,48}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression1.y, refuse.condition) annotation (Line(
      points={{-52.7,-1},{-26,-1},{-26,6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression2.y, done.condition) annotation (Line(
      points={{37.3,33},{68,33},{68,48}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression3.y, notDone.condition) annotation (Line(
      points={{37.3,-1},{68,-1},{68,4}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(integerChange.y, newMessage.condition) annotation (Line(
      points={{-137,82},{-116,82},{-116,104},{100,104},{100,114}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(newMessage1.condition, newMessage.condition) annotation (Line(
      points={{100,-82},{100,-82},{-116,-82},{-116,104},{100,104},{100,114}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(abort.inPort, check1.outPort[2]) annotation (Line(
      points={{-28,-176},{-42,-176},{-42,-130.25},{-51.5,-130.25}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(abort.outPort, waiting.inPort[2]) annotation (Line(
      points={{-22.5,-176},{40,-176},{40,-192},{-180,-192},{-180,-127.75},{-167,
          -127.75}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(booleanExpression4.y, confirmation.condition) annotation (Line(
      points={{-4.7,-153},{10,-153},{10,-142}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(transitionWithSignal1.outPort, composeBuy.inPort[1]) annotation (Line(
      points={{-28.5,-56},{-13,-56}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transitionWithSignal1.inPort, stateOfOffers.outPort[1]) annotation (
      Line(
      points={{-34,-56},{-40,-56},{-40,-55.75},{-47.5,-55.75}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(stateOfOffers.inPort[1], done.outPort) annotation (Line(
      points={{-69,-56},{-92,-56},{-92,-16},{128,-16},{128,60},{69.5,60}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transitionWithSignal1.condition, booleanExpression5.y) annotation (
      Line(
      points={{-30,-44},{-30,-31},{-52.7,-31}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(noOffers.inPort, stateOfOffers.outPort[2]) annotation (Line(
      points={{-156,-162},{-124,-162},{-124,-86},{-42,-86},{-42,-56.25},{-47.5,-56.25}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(noOffers.outPort, waiting.inPort[3]) annotation (Line(
      points={{-161.5,-162},{-180,-162},{-180,-128.25},{-167,-128.25}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(abortAction.inPort, sendRequest.outPort[2]) annotation (Line(
      points={{96,164},{74,164},{74,125.75},{18.5,125.75}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(abortAction1.inPort, sendBuy.outPort[2]) annotation (Line(
      points={{96,-38},{82,-38},{82,-56.25},{74.5,-56.25}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(abortAction.outPort, notServed.inPort[1]) annotation (Line(
      points={{101.5,164},{156,164},{156,-134},{182.5,-134},{182.5,-147}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(abortAction1.outPort, notServed.inPort[2]) annotation (Line(
      points={{101.5,-38},{144,-38},{144,-140},{156,-140},{156,-140},{181.5,-140},
          {181.5,-147}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(notServed.outPort[1], transition2.inPort) annotation (Line(
      points={{182,-168.5},{182,-180}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition2.outPort, waiting.inPort[4]) annotation (Line(
      points={{182,-185.5},{182,-192},{-180,-192},{-180,-128.75},{-167,-128.75}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(and1.y, transitionWithSignal.condition) annotation (Line(
      points={{-137.4,-68},{-126,-68},{-126,-30},{-134,-30},{-134,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sampleTrigger.y, and1.u2) annotation (Line(
      points={{-173,-90},{-158,-90},{-158,-72.8},{-151.2,-72.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression6.y, and1.u1) annotation (Line(
      points={{-173,-66},{-151.2,-66},{-151.2,-68}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(getMessageID.y[1], integerChange.u) annotation (Line(points={{-179,-40},
          {-168,-40},{-168,82},{-160,82}}, color={0,0,127}));
  annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<ul>
  <li>This model is a an agent that tries to buy a pre-set book from
  one or more BookSellerAgents.
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
  The BookBuyerAgent calls for proposals from all known
  BookSellerAgents to buy a book, which is set before simulation. The
  agent then compares all offers from the seller agent and choses the
  book with the lowest price. Afterwards the book is bought from the
  seller agent. The logic is implemented with the help of the
  StateGraph library. Communication is realized with the help of the
  DeviceDriver library and follows the language standards for
  multi-agent-systems set by the FIPA to the highest possible extend
  for Modelica models. The presented agent has the purpose of
  demonstrating the possibility of agent implementation in Modelica by
  implementing the behaviour of the BookBuyer agent presented in Caire,
  2009, JADE PROGRAMMING FOR BEGINNERS.
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
    \"HVACAgentLibraryRealValues.BookTradingExample.ExampleNetworkCommunication2\">
    ExampleNetworkCommunication2</a>
  </li>
</ul>
</html>",
      revisions="<html><ul>
  <li>October 2015, by Felix Bünning: Developed and implemented
  </li>
</ul>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},
            {200,200}}),       graphics={
        Rectangle(
          extent={{-120,-96},{160,-174}},
          fillColor={206,255,229},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-120,-16},{160,-96}},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-120,78},{160,-16}},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-120,180},{160,78}},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-108,174},{-34,158}},
          lineColor={0,0,0},
          fillColor={206,255,229},
          fillPattern=FillPattern.Solid,
          textString="Call for proposals",
          fontSize=14),
        Text(
          extent={{80,76},{154,60}},
          lineColor={0,0,0},
          fillColor={206,255,229},
          fillPattern=FillPattern.Solid,
          fontSize=14,
          textString="Collect proposals"),
        Text(
          extent={{-24,-24},{50,-40}},
          lineColor={0,0,0},
          fillColor={206,255,229},
          fillPattern=FillPattern.Solid,
          fontSize=14,
          textString="Buy book
"),     Text(
          extent={{50,-160},{124,-176}},
          lineColor={0,0,0},
          fillColor={206,255,229},
          fillPattern=FillPattern.Solid,
          fontSize=14,
          textString="Wait for confirmation
")}),                                     Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-66,40},{-66,-74}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-66,40},{-50,40},{-20,34},{0,24}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{66,40},{50,40},{20,34},{0,24}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{-66,-74},{-50,-74},{-20,-80},{0,-90}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{66,-74},{50,-74},{20,-80},{0,-90}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{66,40},{66,-74}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,24},{0,-90}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-10,-90},{10,-90}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{72,-78},{46,-78},{30,-82},{10,-90}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{-72,-78},{-46,-78},{-30,-82},{-10,-90}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{-72,32},{-72,-78}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{72,32},{72,-78}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-72,32},{-66,32}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{72,32},{66,32}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-58,-60},{-42,-60},{-22,-64},{-8,-70}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{-58,-42},{-42,-42},{-22,-46},{-8,-52}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{-58,-10},{-42,-10},{-22,-14},{-8,-20}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{-58,2},{-42,2},{-22,-2},{-8,-8}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{-58,14},{-42,14},{-22,10},{-8,4}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{60,16},{44,16},{24,12},{10,6}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{60,4},{44,4},{24,0},{10,-6}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Text(
          extent={{-80,82},{82,42}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="%name%")}));
end BookBuyerAgent;
