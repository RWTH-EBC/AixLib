within AixLib.Controls.HVACAgentBasedControl.Agents;
model Broker
  extends BaseClasses.PartialAgent;

  Boolean proposalsComplete(start=false)
    "Boolean variable to describe whether all proposals have been collected";
  Boolean requestComplete(start= false)
    "Boolean variable to describe whether all requests are served by the current constellation";
  Boolean rejectsComplete( start=false);
  Real[:,7] heatSupplierTable(start=startTable);
  parameter Real[:,7] startTable = [30001,0,0,0,0,0,0; 30002,0,0,0,0,0,0]
    "Initialization table for the negotiation process. Fill first column with ProducerAgents";
  Integer proposalCounter(start=1) "Integer variable to describe proposalCounter";
  Integer counterReject(start=1) "Integer variable to describe counterReject";
  Real lowestPrice(start=0) "Real variable to define lowestPrice";
  Integer counter(start=1) "Integer variable to describe counter";
  Boolean requestsExceedSupply(start=false) "Boolean variable to describe whteher requests exceed supply";

  // Tables and variables note the requests by the consumers
  Real requestTable[10,1](start=[0;0;0;0;0;0;0;0;0;0]) "Real variable to define requestTable";
  Real requestAddresses[10,1](start=[0;0;0;0;0;0;0;0;0;0]) "Real variable to define requestAddresses";
  Real heatingRequestSum(start=0) "Real variable to define the sum of heating requests";
  Integer requestCounter(start=1) "Real variable to define requestCounter";

  // Variables for average price (for storage)
  Real totalPrice "Real variable to define totalPrice";
  Real totalHeat "Real variable to define totalHeat";
  Real averagePrice "Real variable to define averagePrice";

  // Variables for finding the lowest price combination
  Real heatingCalculationSum(start=0) "Real variable to define the sum of heatingCalculation";
  Integer cheapest(start=1) "Integer variable to define the cheapest offer";
  Real heatingPriceSum "Real variable to define the sum of heatingPrice";
  Real totalaveragePrice "Real variable to define totalaveragePrice";
  Real restHeat "Real variable to define restHeat";
  Boolean calculationDone( start=false) "Boolean variable to annonce calculationDone";

  // Variable for composing information
  Integer informationCounter(start=1) "Integer variable to define informationCounter";
  Boolean informationDone(start=false) "Boolean variable to announce informationDone";

  // Variables for requests from producers
  Boolean finalRequestDone(start=false) "Boolean variable to announce finalRequestDone";

// This section contains the blocks for the state-machine logic of the agent

public
  Modelica.StateGraph.InitialStep waiting(nIn=7, nOut=1)
                                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-156,-444})));
  Modelica.StateGraph.TransitionWithSignal newMessage annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-122,-444})));
  Modelica.StateGraph.Step message(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{-108,-454},{-88,-434}})));
  Modelica.Blocks.Math.IntegerChange integerChange
    annotation (Placement(transformation(extent={{-184,-496},{-164,-476}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=noEvent(
        getperformative.y[1] == 19))
    annotation (Placement(transformation(extent={{-156,100},{-130,118}})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal
    annotation (Placement(transformation(extent={{-132,148},{-112,168}})));
  Modelica.StateGraph.Step requests(nIn=2, nOut=1)
    annotation (Placement(transformation(extent={{-40,148},{-20,168}})));
  Modelica.StateGraph.Transition waitforRequests(enableTimer=true, waitTime=10)
    annotation (Placement(transformation(extent={{102,148},{122,168}})));
  Modelica.StateGraph.TransitionWithSignal newRequests
    annotation (Placement(transformation(extent={{32,108},{12,128}})));
  Modelica.StateGraph.Step callForProposal(nIn=2, nOut=1)
    annotation (Placement(transformation(extent={{-142,38},{-122,58}})));
  Modelica.StateGraph.TransitionWithSignal newProposal(waitTime=0.1,
      enableTimer=false)
    annotation (Placement(transformation(extent={{-50,38},{-30,58}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=noEvent((
        getperformative.y[1] == 13) or (getperformative.y[1] == 17)))
    annotation (Placement(transformation(extent={{-32,4},{-6,22}})));
  Modelica.StateGraph.Step collectProposal(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{54,38},{74,58}})));
  Modelica.StateGraph.TransitionWithSignal allProposalsCollected(enableTimer=true, waitTime=
       0.1)
    annotation (Placement(transformation(extent={{68,6},{48,26}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=noEvent(
        proposalsComplete))
    annotation (Placement(transformation(extent={{108,-8},{82,10}})));
  Modelica.StateGraph.Step sendOutRequest(nOut=1, nIn=3)
    annotation (Placement(transformation(extent={{-126,-210},{-106,-190}})));

  Modelica.StateGraph.TransitionWithSignal notFinished(enableTimer=true, waitTime=
       0.1)
    annotation (Placement(transformation(extent={{126,38},{146,58}})));
  Modelica.Blocks.Logical.Not not2
    annotation (Placement(transformation(extent={{122,-10},{130,-2}})));
  Modelica.StateGraph.StepWithSignal sendCall(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{-78,38},{-58,58}})));
  Modelica.StateGraph.Transition transition(enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{-110,38},{-90,58}})));
  Modelica.StateGraph.StepWithSignal sendRequest(       nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{-22,-210},{-2,-190}})));
  Modelica.StateGraph.Transition transition1(enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{-86,-210},{-66,-190}})));
  Modelica.StateGraph.Step check(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{-22,38},{-2,58}})));
  Modelica.StateGraph.TransitionWithSignal correctPerformative(waitTime=0.5,
      enableTimer=false)
    annotation (Placement(transformation(extent={{10,38},{30,58}})));
  Modelica.StateGraph.Step check1(
                                 nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{-26,108},{-46,128}})));
  Modelica.StateGraph.TransitionWithSignal correctPerformative1(
                                                               waitTime=0.5,
      enableTimer=false)
    annotation (Placement(transformation(extent={{-68,108},{-88,128}})));
  Modelica.StateGraph.Transition requestNoted(enableTimer=true, waitTime=1)
    annotation (Placement(transformation(extent={{-2,148},{18,168}})));
  Modelica.StateGraph.StepWithSignal sendConfirmation(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{40,148},{60,168}})));

  Modelica.StateGraph.TransitionWithSignal actionConfirmed(waitTime=0.5,
      enableTimer=false)
    annotation (Placement(transformation(extent={{42,-210},{62,-190}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression5(y=noEvent((
        getperformative.y[1] == 5) and (getsender.y[1] == receiver.u[1])))
    annotation (Placement(transformation(extent={{20,-230},{46,-212}})));

  Modelica.StateGraph.TransitionWithSignal transitionWithSignal3(
                                                                enableTimer=
       true, waitTime=0.5)
    annotation (Placement(transformation(extent={{-56,-428},{-36,-408}})));
  Modelica.StateGraph.Step composeNotUnderstood(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-14,-428},{6,-408}})));
  Modelica.StateGraph.Transition transition2(enableTimer=true, waitTime=1)
    annotation (Placement(transformation(extent={{20,-428},{40,-408}})));
  Modelica.StateGraph.StepWithSignal sendNotUnderstood(nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{56,-428},{76,-408}})));
  Modelica.StateGraph.Transition transition4(enableTimer=true, waitTime=1)
    annotation (Placement(transformation(extent={{88,-428},{108,-408}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression6(y=not (
        getperformative.y[1] == 19))
    annotation (Placement(transformation(extent={{-4,-452},{-30,-434}})));

// The algorithm section contains the logic of the broker, describing the
// actions taken during each active state of the agent

  Modelica.StateGraph.Step composeInformation(nOut=1, nIn=2)
    annotation (Placement(transformation(extent={{-34,-64},{-14,-44}})));
  Modelica.StateGraph.TransitionWithSignal newConfirm(waitTime=0.1, enableTimer=
       false)
    annotation (Placement(transformation(extent={{-136,-134},{-116,-114}})));
  Modelica.StateGraph.Step check2(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{-104,-134},{-84,-114}})));
  Modelica.StateGraph.TransitionWithSignal correctPerformative2(
                                                               waitTime=0.5,
      enableTimer=false)
    annotation (Placement(transformation(extent={{-70,-134},{-50,-114}})));
  Modelica.StateGraph.Step collectConfirm(nOut=3, nIn=1)
    annotation (Placement(transformation(extent={{-32,-134},{-12,-114}})));
  Modelica.StateGraph.Step computePrice(nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{-134,-64},{-114,-44}})));
  Modelica.StateGraph.TransitionWithSignal
                                 transition5(
                                            enableTimer=true, waitTime=0.5)
    annotation (Placement(transformation(extent={{-88,-64},{-68,-44}})));
  Modelica.StateGraph.Transition transition6(
                                            enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{24,-64},{44,-44}})));
  Modelica.StateGraph.StepWithSignal sendInformation(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{74,-44},{94,-64}})));
  Modelica.StateGraph.TransitionWithSignal confirmComplete(waitTime=0.5,
      enableTimer=false)
    annotation (Placement(transformation(extent={{10,-134},{30,-114}})));
  Modelica.StateGraph.Step computeFinalConstellation(nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{52,-134},{72,-114}})));
  Modelica.StateGraph.Transition transition7(
                                            enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{96,-134},{116,-114}})));
  Modelica.StateGraph.Step checkRequestComplete(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{84,-210},{104,-190}})));
  Modelica.StateGraph.TransitionWithSignal requestsComplete(waitTime=0.5,
      enableTimer=false)
    annotation (Placement(transformation(extent={{124,-210},{144,-190}})));
  Modelica.StateGraph.TransitionWithSignal requestsNotComplete(waitTime=0.5,
      enableTimer=false)
    annotation (Placement(transformation(extent={{112,-248},{92,-228}})));
  Modelica.StateGraph.TransitionWithSignal confirmNotComplete(waitTime=0.5,
      enableTimer=false)
    annotation (Placement(transformation(extent={{10,-104},{-10,-84}})));
  Modelica.Blocks.Logical.Or or1 annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={154,0})));
  Modelica.Blocks.Logical.Or or2 annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={180,-206})));
  Modelica.Blocks.Logical.Or or3 annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={116,-30})));
  Modelica.Blocks.Logical.Or or4 annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={154,-30})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y=noEvent((
        getperformative.y[1] == 5 or getperformative.y[1] == 3) and (
        getsender.y[1] == receiver.u[1])))
    annotation (Placement(transformation(extent={{-100,-154},{-74,-136}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression4(y=noEvent(
        informationDone and (abs(heatingRequestSum) >= 1)))
    annotation (Placement(transformation(extent={{-14,-152},{12,-134}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression7(y=noEvent(not (
        informationDone)))
    annotation (Placement(transformation(extent={{-46,-112},{-20,-94}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression8(y=noEvent(
        finalRequestDone))
    annotation (Placement(transformation(extent={{54,-284},{80,-266}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression9(y=noEvent(not (
        finalRequestDone)))
    annotation (Placement(transformation(extent={{54,-264},{80,-246}})));
  Modelica.StateGraph.Transition           abort(enableTimer=true, waitTime=10)
    annotation (Placement(transformation(extent={{48,-102},{68,-82}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression11(y=noEvent(
        calculationDone))
    annotation (Placement(transformation(extent={{-122,-106},{-96,-88}})));
  Modelica.StateGraph.Step prepareTableforRejections(nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{118,-108},{138,-88}})));
  Modelica.StateGraph.Transition transition3(
                                            enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{164,-160},{144,-140}})));
  Modelica.StateGraph.Transition reset(enableTimer=true, waitTime=60)
    annotation (Placement(transformation(extent={{-10,-294},{-30,-274}})));
  Modelica.StateGraph.Transition reset1(enableTimer=true, waitTime=60)
    annotation (Placement(transformation(extent={{-10,-328},{-30,-308}})));
  Modelica.StateGraph.Transition reset2(enableTimer=true, waitTime=60)
    annotation (Placement(transformation(extent={{-10,-362},{-30,-342}})));
  Modelica.StateGraph.Transition reset3(enableTimer=true, waitTime=60)
    annotation (Placement(transformation(extent={{-10,-392},{-30,-372}})));
  Modelica.StateGraph.Step checkAvailability(nIn=1, nOut=2)
    annotation (Placement(transformation(extent={{24,-24},{4,-4}})));
  Modelica.StateGraph.TransitionWithSignal enoughSupply(enableTimer=true, waitTime=
       0.1)
    annotation (Placement(transformation(extent={{-120,-4},{-140,-24}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression10(y=noEvent(not (
        requestsExceedSupply)))
    annotation (Placement(transformation(extent={{-80,-16},{-106,2}})));
  Modelica.StateGraph.Step limitedSupplyAbort(
                                             nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{62,-338},{42,-318}})));
  Modelica.StateGraph.TransitionWithSignal enoughSupply1(enableTimer=true,
      waitTime=1)
    annotation (Placement(transformation(extent={{92,-318},{72,-338}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression12(y=noEvent(
        requestsExceedSupply))
    annotation (Placement(transformation(extent={{116,-322},{90,-304}})));
  Modelica.StateGraph.Transition reset4(enableTimer=true, waitTime=1)
    annotation (Placement(transformation(extent={{-54,-346},{-74,-326}})));
algorithm
  when noEvent(waiting.active) then
    counter :=1;
    counterReject := 1;
    lowestPrice :=0;
    heatSupplierTable := startTable;
    proposalCounter := 1;

    finalRequestDone :=false;
    informationCounter :=1;
    informationDone :=false;
    heatingCalculationSum :=0;
    cheapest :=1;
    heatingPriceSum :=0;
    totalaveragePrice :=0;
    restHeat := 0;
    requestTable :=[0;0;0;0;0;0;0;0;0;0];
    requestAddresses := [0;0;0;0;0;0;0;0;0;0];
    heatingRequestSum := 0;
    requestCounter :=1;

    proposalsComplete := false;
    requestComplete := false;
    heatingRequestSum :=0;
    rejectsComplete := false;
    content.u[1] := 0;
    content.u[2] := 0;

    calculationDone := false;
    requestsExceedSupply := false;
  end when;

// Collecting requests to bundle goals
  when noEvent(requests.active) then

    // Collect the requests
    heatingRequestSum := heatingRequestSum + get_content.y[1];
    requestTable[requestCounter,1] := get_content.y[1];
    requestAddresses[requestCounter,1] := getsender.y[1];

    // Create the confirmation for the consumer agent
    performative.u[1] := 5; //"confirm"
    ontology.u[1] :=1;
    sender.u[1] := name;
    receiver.u[1] := getsender.y[1];
    reply_to.u[1] := name;
    content.u[1] := get_content.y[1];
    uDPSend_adapted.receiver := getsender.y[1];
    messageID.u[1] := name*name + integer(time);

    Modelica.Utilities.Streams.print("Broker "+ String(name)+ " collected the request of " + String(requestTable[requestCounter,1]) + " W of heat from Consumer " + String(requestAddresses[requestCounter,1])+".");

    requestCounter := requestCounter +1;
  end when;

// Broker calls all heatSuppliers in the list for a proposal for the requested heat
  when noEvent(callForProposal.active) then
      performative.u[1]:= 4;
      sender.u[1]:=name;
      receiver.u[1]:= integer(heatSupplierTable[proposalCounter,1]);
      reply_to.u[1] := name;
      content.u[1] := heatingRequestSum;
      ontology.u[1] := 1;
      uDPSend_adapted.receiver := heatSupplierTable[proposalCounter,1];
      messageID.u[1] := name*name + integer(time);
      Modelica.Utilities.Streams.print("Broker "+ String(name)+ " calls for proposal of " + String(heatingRequestSum) + " W of heat from Producer " + String(receiver.u[1])+".");
  end when;

// Receiving the proposals and add the information that proposal was received
// price for the proposal and maximum capacity
   when noEvent(collectProposal.active) then

     if noEvent(getperformative.y[1] == 13) then
      heatSupplierTable[proposalCounter,3] := get_content.y[1];
      heatSupplierTable[proposalCounter,4] := get_content.y[2];
      heatSupplierTable[proposalCounter,5] := if heatingRequestSum >=0 then (get_content.y[1]/max(0.0001,get_content.y[2])) else -(get_content.y[1]/min(0.0001,get_content.y[2]));
      heatSupplierTable[proposalCounter,7] := heatSupplierTable[proposalCounter,5];
      /*if getsender.y[1] == 30001 then
        heatSupplierTable[proposalCounter,3] := averagePrice;
        heatSupplierTable[proposalCounter,7] := averagePrice;
        end if;*/
      Modelica.Utilities.Streams.print("Broker "+ String(name)+ " collects proposal of " + String(get_content.y[2]) + " W of heat for the price of " + String(heatSupplierTable[proposalCounter,3]) + " from Producer " + String(receiver.u[1])+".");
   else
      heatSupplierTable[proposalCounter,3] := 999999999;
      heatSupplierTable[proposalCounter,4] := 0.0001;
      heatSupplierTable[proposalCounter,5] := 999999999;
      heatSupplierTable[proposalCounter,7] := 999999999;
      heatSupplierTable[proposalCounter,2] := 3;
      Modelica.Utilities.Streams.print("Broker "+ String(name)+ " collects refusal from from Producer " + String(receiver.u[1])+".");
   end if;

    if noEvent(proposalCounter== size(heatSupplierTable,1)) then
      proposalsComplete := true; //if all proposals are there go to next block
    end if;
    proposalCounter := proposalCounter +1;
  end when;

// Check whether the possible supply exceeds the demand
  when  noEvent(checkAvailability.active) then
    if abs(sum(heatSupplierTable[:,4])) < (abs(heatingRequestSum)-1) then
      Modelica.Utilities.Streams.print("Broker received less proposals than necessary to fulfill demand. Ordering all available capacity.");
      heatingRequestSum := sum(heatSupplierTable[:,4]);
    end if;
    if abs(sum(heatSupplierTable[:,4])) < 10 then
      requestsExceedSupply := true;
    end if;

  end when;

  // Abort procedure if demand exceeds supply
  when noEvent(limitedSupplyAbort.active) then
    Modelica.Utilities.Streams.print("Broker received no proposal. Abort process.");
  end when;

   // Block to compute the price
   when noEvent(computePrice.active) then
     restHeat := heatingRequestSum;

       while (abs(heatingCalculationSum)<abs(heatingRequestSum)) loop
       lowestPrice := min(heatSupplierTable[:,7]);
       for i in 1:size(heatSupplierTable,1) loop
         if noEvent(Modelica.Math.isEqual(heatSupplierTable[i,7],lowestPrice)) then
           cheapest := i;
           break;
         end if;
       end for;

       heatSupplierTable[cheapest,6] := if (heatingRequestSum > 0) then min(restHeat,heatSupplierTable[cheapest,4]) else max(restHeat,heatSupplierTable[cheapest,4]);
       heatSupplierTable[cheapest,2] := 1;
       heatingCalculationSum := heatingCalculationSum + heatSupplierTable[cheapest,6];
       heatingPriceSum := heatingPriceSum + heatSupplierTable[cheapest,6]*heatSupplierTable[cheapest,5];
       heatSupplierTable[cheapest,7] := 9999999999.0;
       restHeat := heatingRequestSum - heatingCalculationSum;

     end while;

     totalaveragePrice := heatingPriceSum/heatingCalculationSum;
     Modelica.Utilities.Streams.print("Broker "+ String(name)+ " calculates an average price of " + String(totalaveragePrice) + " per W of heat.");
     heatingRequestSum :=0;
     heatingCalculationSum := 0;
     calculationDone := true;
   end when;

   // Composeinformation for consumer agents in order to get a confirmation afterwards
   when noEvent(composeInformation.active) then
     performative.u[1]:=8;
     sender.u[1]:=name;
     receiver.u[1]:= integer(requestAddresses[informationCounter,1]);
     reply_to.u[1] := name;
     content.u[1] := totalaveragePrice*requestTable[informationCounter,1];
     content.u[2] := requestTable[informationCounter,1];
     ontology.u[1] := 1;
     uDPSend_adapted.receiver := requestAddresses[informationCounter,1];
     messageID.u[1] := name*name + integer(time);
     Modelica.Utilities.Streams.print("Broker "+ String(name)+ " asks for a confirmation of " + String(content.u[2]) + " W of heat for the total price of " + String(content.u[1]) + " from Consumer " + String(receiver.u[1])+".");
   end when;

   // Collect confirms of the consumers and catch the final amount of heat requested
   when noEvent(collectConfirm.active) then
     if noEvent(getperformative.y[1] == 5) then
       heatingRequestSum := heatingRequestSum + get_content.y[2];
     end if;

     informationCounter := informationCounter +1;
     if noEvent(requestAddresses[informationCounter,1]<1) then
       informationDone := true;
       if (abs(heatingRequestSum) >= 1) then
       Modelica.Utilities.Streams.print(String(heatingRequestSum)+ " W of heat were confirmed by consumers at broker " + String(name) +". Go on to final requests to producers.");
       else
       Modelica.Utilities.Streams.print("There was no request confirmed by consumers at broker " + String(name) +". It sends rejections to the producers.");
       end if;

     end if;

   end when;

   when noEvent(prepareTableforRejections.active) then
     for i in 1:size(heatSupplierTable,1) loop
       heatSupplierTable[i,3] := 0;
       heatSupplierTable[i,2] := 0;
     end for;
   end when;

   when noEvent(computeFinalConstellation.active) then
      if abs(sum(heatSupplierTable[:,4])) < (abs(heatingRequestSum)-1) then
        Modelica.Utilities.Streams.print("Broker received less proposals than necessary to fulfill demand. Ordering all available capacity.");
        heatingRequestSum := sum(heatSupplierTable[:,4]);
      end if;

     restHeat := heatingRequestSum;

     // Writing the right price back from column 5 to column 7 and resetting the requested capacity
     for i in 1:size(heatSupplierTable,1) loop
       heatSupplierTable[i,7] := heatSupplierTable[i,5];
       heatSupplierTable[i,6] := 0;
     end for;

     // As long as the total request is not served, the next cheapest supplier is looked for
     while (abs(heatingCalculationSum)<abs(heatingRequestSum)) loop
       lowestPrice := min(heatSupplierTable[:,7]);
       // Looking for the index of the cheapest supplier
       for i in 1:size(heatSupplierTable,1) loop
         if noEvent(Modelica.Math.isEqual(heatSupplierTable[i,7],lowestPrice)) then
           cheapest := i;
           break;
         end if;
       end for;

       heatSupplierTable[cheapest,6] := if (heatingRequestSum > 0) then min(restHeat,heatSupplierTable[cheapest,4]) else max(restHeat,heatSupplierTable[cheapest,4]); //setting the requested capacity (minimum of the maximum device capacity and the rest of heat that needs to be supplied)
       heatSupplierTable[cheapest,2] := 1; //setting approve for supplier
       heatingCalculationSum := heatingCalculationSum + heatSupplierTable[cheapest,6]; //saving the amount of heat that is approved already
       heatingPriceSum := heatingPriceSum + heatSupplierTable[cheapest,6]*heatSupplierTable[cheapest,5]; //saving the the total price of the heat so far
       heatSupplierTable[cheapest,7] := 9999999999.0; //setting the price high, so the next cheapest producer can be found in the next loop
       restHeat := heatingRequestSum - heatingCalculationSum; //calculating the amount of heat that still needs to be approved in the next loop

     end while;

     // Update the average energy price
     totalPrice := totalPrice + heatingPriceSum;
     totalHeat := totalHeat + heatingRequestSum;
     averagePrice := totalPrice/totalHeat;
     counter:=1; //reset counter for next block
   end when;

// Block to send out accept proposal to all providing producers
   when noEvent(sendOutRequest.active) then

     sender.u[1]:=name;
     receiver.u[1]:= integer(heatSupplierTable[counter,1]);
     reply_to.u[1] := name;
     content.u[1] := heatSupplierTable[counter,6];
     ontology.u[1] := 1;
     uDPSend_adapted.receiver := heatSupplierTable[counter,1];
     messageID.u[1] := name*name + integer(time);

     if noEvent(heatSupplierTable[counter,2] > 0 and heatSupplierTable[counter,2] <3) then
       performative.u[1]:=1;//accept proposal
       Modelica.Utilities.Streams.print("Broker "+ String(name)+ " accepts the proposal of " + String(receiver.u[1]) + " and orders " + String(content.u[1]) + " W of heat.");
     else
       if noEvent(heatSupplierTable[counter,2] <3) then
       performative.u[1]:=18;//reject proposal
       Modelica.Utilities.Streams.print("Broker "+ String(name)+ " rejects the proposal of " + String(receiver.u[1])+ ".");
       else
       performative.u[1]:=18;
       Modelica.Utilities.Streams.print("Broker "+ String(name)+ " accepts refusal of " + String(receiver.u[1])+ ".");
       end if;
     end if;

     counter := counter+1;

     if noEvent(counter > size(heatSupplierTable,1)) then
       finalRequestDone := true;
     end if;

   end when;

// Send out "not understood" message, if message has unknown performative
  when noEvent(composeNotUnderstood.active) then
    performative.u[1] := 11; //"not understood"
    content.u[1] := 0;
    content.u[2] := 0;
    sender.u[1] := name;
    receiver.u[1] := getsender.y[1];
    uDPSend_adapted.receiver :=  getsender.y[1];
    ontology.u[1] := getontology.y[1];
    messageID.u[1] := name*name + integer(time);
  end when;


equation
  connect(newMessage.inPort,waiting. outPort[1]) annotation (Line(
      points={{-126,-444},{-145.5,-444}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(newMessage.outPort,message. inPort[1]) annotation (Line(
      points={{-120.5,-444},{-109,-444}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(integerChange.y, newMessage.condition) annotation (Line(
      points={{-163,-486},{-122,-486},{-122,-456}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(integerChange.u, getMessageID.y[1]) annotation (Line(
      points={{-186,-486},{-192,-486},{-192,-58},{-176,-58},{-176,-40},{-179,-40}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(booleanExpression.y, transitionWithSignal.condition) annotation (Line(
      points={{-128.7,109},{-122,109},{-122,146}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(transitionWithSignal.outPort,requests. inPort[1]) annotation (Line(
      points={{-120.5,158},{-52,158},{-52,158.5},{-41,158.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(callForProposal.inPort[1], waitforRequests.outPort) annotation (Line(
      points={{-143,48.5},{-152,48.5},{-152,70},{158,70},{158,158},{113.5,158}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(notFinished.inPort, collectProposal.outPort[1]) annotation (Line(
      points={{132,48},{110,48},{110,48.25},{74.5,48.25}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(not2.y, notFinished.condition) annotation (Line(
      points={{130.4,-6},{136,-6},{136,36}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(message.outPort[1], transitionWithSignal.inPort) annotation (Line(
      points={{-87.5,-443.75},{-80,-443.75},{-80,-422},{-168,-422},{-168,158},{-126,
          158}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(notFinished.outPort, callForProposal.inPort[2]) annotation (Line(
      points={{137.5,48},{158,48},{158,66},{-152,66},{-152,47.5},{-143,47.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(allProposalsCollected.inPort, collectProposal.outPort[2]) annotation (
     Line(
      points={{62,16},{120,16},{120,48},{108,48},{108,47.75},{74.5,47.75}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(transition.inPort, callForProposal.outPort[1]) annotation (Line(
      points={{-104,48},{-121.5,48}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition.outPort, sendCall.inPort[1]) annotation (Line(
      points={{-98.5,48},{-79,48}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sendCall.outPort[1], newProposal.inPort) annotation (Line(
      points={{-57.5,48.25},{-50,48.25},{-50,48},{-44,48}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sendOutRequest.outPort[1], transition1.inPort) annotation (Line(
      points={{-105.5,-200},{-80,-200}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(check.inPort[1], newProposal.outPort) annotation (Line(
      points={{-23,48},{-38.5,48}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(booleanExpression1.y, correctPerformative.condition) annotation (Line(
      points={{-4.7,13},{20,13},{20,36}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(correctPerformative.outPort, collectProposal.inPort[1]) annotation (
      Line(
      points={{21.5,48},{53,48}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(correctPerformative.inPort, check.outPort[1]) annotation (Line(
      points={{16,48},{8,48},{8,48.25},{-1.5,48.25}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(newRequests.condition, newMessage.condition) annotation (Line(
      points={{22,106},{22,100},{-164,100},{-164,-418},{-76,-418},{-76,-458},
          {-122,-458},{-122,-456}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(correctPerformative1.outPort, requests.inPort[2]) annotation (
      Line(
      points={{-79.5,118},{-108,118},{-108,157.5},{-41,157.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(check1.outPort[1], correctPerformative1.inPort) annotation (Line(
      points={{-46.5,118},{-54,118},{-54,118},{-62,118},{-62,118},{-74,118}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(check1.inPort[1], newRequests.outPort) annotation (Line(
      points={{-25,118},{-16,118},{-16,118},{-4,118},{-4,118},{20.5,118}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(correctPerformative1.condition, transitionWithSignal.condition)
    annotation (Line(
      points={{-78,106},{-122,106},{-122,146}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(requests.outPort[1], requestNoted.inPort) annotation (Line(
      points={{-19.5,158},{4,158}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sendConfirmation.inPort[1], requestNoted.outPort) annotation (Line(
      points={{39,158},{9.5,158}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sendConfirmation.outPort[1], waitforRequests.inPort) annotation (Line(
      points={{60.5,158.25},{80,158.25},{80,158},{108,158}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(newRequests.inPort, sendConfirmation.outPort[2]) annotation (Line(
      points={{26,118},{82,118},{82,157.75},{60.5,157.75}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(newProposal.condition, newMessage.condition) annotation (Line(
      points={{-40,36},{-40,22},{-160,22},{-160,-414},{-74,-414},{-74,-462},{-122,
          -462},{-122,-456}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression2.y, not2.u) annotation (Line(
      points={{80.7,1},{68,1},{68,-6},{121.2,-6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression2.y, allProposalsCollected.condition)
    annotation (Line(
      points={{80.7,1},{58,1},{58,4}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(actionConfirmed.inPort, sendRequest.outPort[1]) annotation (Line(
      points={{48,-200},{26,-200},{26,-199.75},{-1.5,-199.75}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(booleanExpression5.y, actionConfirmed.condition) annotation (Line(
      points={{47.3,-221},{52,-221},{52,-212}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(transition1.outPort, sendRequest.inPort[1]) annotation (Line(
      points={{-74.5,-200},{-23,-200}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(booleanExpression6.y, transitionWithSignal3.condition) annotation (
      Line(
      points={{-31.3,-443},{-46,-443},{-46,-430}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(transitionWithSignal3.inPort, message.outPort[2]) annotation (Line(
      points={{-50,-418},{-62,-418},{-62,-444.25},{-87.5,-444.25}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transitionWithSignal3.outPort, composeNotUnderstood.inPort[1])
    annotation (Line(
      points={{-44.5,-418},{-15,-418}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(composeNotUnderstood.outPort[1], transition2.inPort) annotation (Line(
      points={{6.5,-418},{26,-418}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition2.outPort, sendNotUnderstood.inPort[1]) annotation (Line(
      points={{31.5,-418},{55,-418}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sendNotUnderstood.outPort[1], transition4.inPort) annotation (Line(
      points={{76.5,-418},{94,-418}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition4.outPort, waiting.inPort[2]) annotation (Line(
      points={{99.5,-418},{136,-418},{136,-464},{-182,-464},{-182,-443.429},{
          -167,-443.429}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(computePrice.outPort[1], transition5.inPort) annotation (Line(
      points={{-113.5,-54},{-106,-54},{-106,-54},{-98,-54},{-98,-54},{-82,
          -54}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition5.outPort, composeInformation.inPort[1]) annotation (Line(
      points={{-76.5,-54},{-58,-54},{-58,-53.5},{-35,-53.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(composeInformation.outPort[1], transition6.inPort) annotation (Line(
      points={{-13.5,-54},{30,-54}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition6.outPort, sendInformation.inPort[1]) annotation (Line(
      points={{35.5,-54},{44,-54},{44,-54},{54,-54},{54,-54},{73,-54}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sendInformation.outPort[1], newConfirm.inPort) annotation (Line(
      points={{94.5,-54},{132,-54},{132,-72},{-146,-72},{-146,-124},{-130,
          -124}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(newConfirm.outPort, check2.inPort[1]) annotation (Line(
      points={{-124.5,-124},{-105,-124}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(check2.outPort[1], correctPerformative2.inPort) annotation (Line(
      points={{-83.5,-123.75},{-74,-123.75},{-74,-124},{-64,-124}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(correctPerformative2.outPort, collectConfirm.inPort[1]) annotation (
      Line(
      points={{-58.5,-124},{-33,-124}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(collectConfirm.outPort[1], confirmComplete.inPort) annotation (Line(
      points={{-11.5,-123.667},{4,-123.667},{4,-124},{16,-124}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(confirmComplete.outPort, computeFinalConstellation.inPort[1])
    annotation (Line(
      points={{21.5,-124},{51,-124}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(computeFinalConstellation.outPort[1], transition7.inPort) annotation (
     Line(
      points={{72.5,-124},{102,-124}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition7.outPort, sendOutRequest.inPort[1]) annotation (Line(
      points={{107.5,-124},{138,-124},{138,-150},{-146,-150},{-146,-199.333},{
          -127,-199.333}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(actionConfirmed.outPort, checkRequestComplete.inPort[1]) annotation (
      Line(
      points={{53.5,-200},{83,-200}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(checkRequestComplete.outPort[1], requestsComplete.inPort) annotation (
     Line(
      points={{104.5,-199.75},{118,-199.75},{118,-200},{130,-200}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(requestsNotComplete.outPort, sendOutRequest.inPort[2]) annotation (
      Line(
      points={{100.5,-238},{-146,-238},{-146,-200},{-127,-200}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(requestsNotComplete.inPort, checkRequestComplete.outPort[2])
    annotation (Line(
      points={{106,-238},{112,-238},{112,-238},{120,-238},{120,-200.25},{104.5,-200.25}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(confirmNotComplete.inPort, collectConfirm.outPort[2]) annotation (
      Line(
      points={{4,-94},{6,-94},{6,-124},{-11.5,-124}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(confirmNotComplete.outPort, composeInformation.inPort[2]) annotation (
     Line(
      points={{-1.5,-94},{-54,-94},{-54,-54.5},{-35,-54.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(requestsComplete.outPort, waiting.inPort[1]) annotation (Line(
      points={{135.5,-200},{150,-200},{150,-464},{-182,-464},{-182,-443.143},{
          -167,-443.143}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(or1.u2, sendCall.active) annotation (Line(
      points={{149.2,7.2},{149.2,18},{150,18},{150,28},{-68,28},{-68,37}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sendConfirmation.active, or1.u1) annotation (Line(
      points={{50,147},{52,147},{52,132},{154,132},{154,7.2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sendNotUnderstood.active, or2.u1) annotation (Line(
      points={{66,-429},{68,-429},{68,-440},{180,-440},{180,-213.2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sendRequest.active, or2.u2) annotation (Line(
      points={{-12,-211},{-14,-211},{-14,-230},{184.8,-230},{184.8,-213.2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sendInformation.active, or3.u2) annotation (Line(
      points={{84,-43},{84,-34.8},{108.8,-34.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(or1.y, or3.u1) annotation (Line(
      points={{154,-6.6},{154,-18},{104,-18},{104,-30},{108.8,-30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(or4.u1, or3.y) annotation (Line(
      points={{146.8,-30},{122.6,-30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(or4.y, uDPSend_adapted.trigger) annotation (Line(
      points={{160.6,-30},{166,-30},{166,-70},{176,-70}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(or2.y, or4.u2) annotation (Line(
      points={{180,-199.4},{180,-84},{150,-84},{150,-34.8},{146.8,-34.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(newConfirm.condition, newMessage.condition) annotation (Line(
      points={{-126,-136},{-160,-136},{-160,-414},{-74,-414},{-74,-462},{-122,-462},
          {-122,-456}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression3.y, correctPerformative2.condition) annotation (
      Line(
      points={{-72.7,-145},{-60,-145},{-60,-136}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression4.y, confirmComplete.condition) annotation (Line(
      points={{13.3,-143},{20,-143},{20,-136}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression7.y, confirmNotComplete.condition) annotation (Line(
      points={{-18.7,-103},{-6,-103},{-6,-106},{0,-106}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression8.y, requestsComplete.condition) annotation (Line(
      points={{81.3,-275},{134,-275},{134,-212}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression9.y, requestsNotComplete.condition) annotation (Line(
      points={{81.3,-255},{102,-255},{102,-250}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(abort.inPort, collectConfirm.outPort[3]) annotation (Line(
      points={{54,-92},{8,-92},{8,-124.333},{-11.5,-124.333}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(booleanExpression11.y, transition5.condition) annotation (Line(
      points={{-94.7,-97},{-78,-97},{-78,-66}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(prepareTableforRejections.inPort[1], abort.outPort) annotation (Line(
      points={{117,-98},{74,-98},{74,-92},{59.5,-92}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(prepareTableforRejections.outPort[1], transition3.inPort) annotation (
     Line(
      points={{138.5,-98},{166,-98},{166,-150},{158,-150}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition3.outPort, sendOutRequest.inPort[3]) annotation (Line(
      points={{152.5,-150},{-146,-150},{-146,-200.667},{-127,-200.667}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(reset.outPort, waiting.inPort[3]) annotation (Line(
      points={{-21.5,-284},{-182,-284},{-182,-443.714},{-167,-443.714}},
      color={255,0,0},
      pattern=LinePattern.Dot));
  connect(reset.inPort, sendRequest.outPort[2]) annotation (Line(
      points={{-16,-284},{12,-284},{12,-200.25},{-1.5,-200.25}},
      color={255,0,0},
      pattern=LinePattern.Dot));
  connect(reset1.inPort, check2.outPort[2]) annotation (Line(
      points={{-16,-318},{12,-318},{12,-178},{-72,-178},{-72,-124.25},{
          -83.5,-124.25}},
      color={255,0,0},
      pattern=LinePattern.Dot));
  connect(sendCall.outPort[2], reset2.inPort) annotation (Line(
      points={{-57.5,47.75},{-58,47.75},{-58,48},{-46,48},{-46,2},{-154,2},
          {-154,-178},{12,-178},{12,-352},{-16,-352}},
      color={255,0,0},
      pattern=LinePattern.Dot));
  connect(check.outPort[2], reset3.inPort) annotation (Line(
      points={{-1.5,47.75},{4,47.75},{4,46},{12,46},{12,2},{-154,2},{-154,
          -178},{12,-178},{12,-382},{8,-382},{-16,-382}},
      color={255,0,0},
      pattern=LinePattern.Dot));
  connect(reset1.outPort, waiting.inPort[4]) annotation (Line(
      points={{-21.5,-318},{-100,-318},{-182,-318},{-182,-444},{-167,-444}},
      color={255,0,0},
      pattern=LinePattern.Dot));
  connect(reset2.outPort, waiting.inPort[5]) annotation (Line(
      points={{-21.5,-352},{-98,-352},{-182,-352},{-182,-444.286},{-167,
          -444.286}},
      color={255,0,0},
      pattern=LinePattern.Dot));
  connect(reset3.outPort, waiting.inPort[6]) annotation (Line(
      points={{-21.5,-382},{-76,-382},{-182,-382},{-182,-442},{-182,-444.571},{
          -167,-444.571}},
      color={255,0,0},
      pattern=LinePattern.Dot));
  connect(checkAvailability.inPort[1], allProposalsCollected.outPort)
    annotation (Line(points={{25,-14},{38,-14},{38,16},{56.5,16}}, color={0,0,0}));
  connect(enoughSupply.inPort, checkAvailability.outPort[1]) annotation (Line(
        points={{-126,-14},{3.5,-14},{3.5,-13.75}}, color={0,0,0}));
  connect(enoughSupply.outPort, computePrice.inPort[1]) annotation (Line(points=
         {{-131.5,-14},{-140,-14},{-148,-14},{-148,-54},{-135,-54}}, color={0,0,
          0}));
  connect(enoughSupply.condition, booleanExpression10.y) annotation (Line(
        points={{-130,-2},{-112,-2},{-112,-7},{-107.3,-7}}, color={255,0,255}));
  connect(enoughSupply1.outPort, limitedSupplyAbort.inPort[1]) annotation (Line(
        points={{80.5,-328},{80.5,-328},{63,-328}}, color={0,0,0}));
  connect(enoughSupply1.condition, booleanExpression12.y) annotation (Line(
        points={{82,-316},{84,-316},{84,-314},{86,-314},{86,-313},{88.7,-313}},
        color={255,0,255}));
  connect(checkAvailability.outPort[2], enoughSupply1.inPort) annotation (Line(
      points={{3.5,-14.25},{-22,-14.25},{-22,2},{-154,2},{-154,-178},{12,-178},{
          12,-300},{126,-300},{126,-328},{86,-328}},
      color={255,0,0},
      pattern=LinePattern.Dot));
  connect(reset4.inPort, limitedSupplyAbort.outPort[1]) annotation (Line(points=
         {{-60,-336},{-18,-336},{26,-336},{26,-328},{41.5,-328}}, color={0,0,0}));
  connect(reset4.outPort, waiting.inPort[7]) annotation (Line(
      points={{-65.5,-336},{-182,-336},{-182,-446},{-182,-444.857},{-167,
          -444.857}},
      color={255,0,0},
      pattern=LinePattern.Dot));

  annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<ul>
  <li>This model is a broker agent which collects requests from
  room-agent and buys heat for the lowest price from producer agents.
  </li>
  <li>It is based on communication via UDP and logic implemented with
  the help of the StateGraph Modelica library.
  </li>
  <li>It is used together with at least one room or consumer agent and
  at least one producer agent.
  </li>
</ul>
<h4>
  <span style=\"color: #008000\">Concept</span>
</h4>
<p>
  The broker agent gets cooling- or heating requests from one or more
  room-agents and collects them to one big request. The broker then
  calls for proposals from all producer agents and afterwards collects
  the proposals. The best-suited price and capcity is chosen and
  confirmed to the related producer agent. The other agents are
  rejected. The logic is implemented with the help of the StateGraph
  library. Communication is realized with the help of the DeviceDriver
  library and follows the language standards for multi-agent-systems
  set by the FIPA to the highest possible extend for Modelica models.
  The following figure shows the behaviour of the broker agent. For
  further information please refer to the first reference.
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Controls/HVACAgentBasedControl/Broker.png\"
  alt=\"Broker\">
</p>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<ul>
  <li>Roozbeh Sangi, Felix Bünning, Johannes Fütterer, Dirk Müller. A
  Platform for the Agent-based Control of HVAC Systems. Modelica
  Conference, 2017, Prague, Czech Republic.
  </li>
  <li>FIPA ACL Message Structure Specification
  </li>
  <li>FIPA Communicative Act Library Specification
  </li>
  <li>Felix Bünning, Roozbeh Sangi, Dirk Müller<span style=
  \"font-family: TimesNewRoman,serif;\">. A</span> Modelica library for
  agent-based control of building HVAC systems. Applied Energy,
  193:52-59, 2017.
  </li>
</ul>
<h4>
  <span style=\"color: #008000\">Example Results</span>
</h4>
<ul>
  <li>
    <a href=
    \"HVACAgentBasedControl.Examples.BuildingHeatingSystems.BuildingHeating\">
    Simple Heating System</a>
  </li>
</ul>
</html>",
      revisions="<html><ul>
  <li>December 2016, by Roozbeh Sangi:<br/>
    revised
  </li>
  <li>December 2016, by Felix Bünning: Changed some variables to
  Integer type in order to avoid warnings caused by using the \"==\"
  operator
  </li>
  <li>November 2016, by Felix Bünning: Added handling of proposals in
  case demand exceeds supply
  </li>
  <li>October 2015, by Felix Bünning: Developed and implemented
  </li>
</ul>
</html>"),Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -500},{200,200}}), graphics={
        Rectangle(
          extent={{-128,-258},{132,-394}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={206,101,103},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,-288},{-44,-302}},
          lineColor={0,0,0},
          fillColor={255,170,213},
          fillPattern=FillPattern.Solid,
          fontSize=12,
          textString="Reset"),
        Rectangle(
          extent={{-172,-8},{168,-146}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-68,-396},{132,-462}},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-172,-146},{168,-258}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-172,94},{170,-12}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-172,200},{170,94}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-12,200},{146,178}},
          lineColor={0,0,0},
          fillColor={255,170,213},
          fillPattern=FillPattern.Solid,
          fontSize=12,
          textString="Collect Requests"),
        Text(
          extent={{-28,86},{74,66}},
          lineColor={0,0,0},
          fillColor={255,170,213},
          fillPattern=FillPattern.Solid,
          fontSize=12,
          textString="Call and collect Proposals
"),     Text(
          extent={{-86,-154},{148,-174}},
          lineColor={0,0,0},
          fillColor={255,170,213},
          fillPattern=FillPattern.Solid,
          fontSize=12,
          textString="Send Request and Rejections"),
        Text(
          extent={{-44,-444},{142,-460}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          fontSize=14,
          textString="Message not understood"),
        Text(
          extent={{-146,-18},{18,-34}},
          lineColor={0,0,0},
          fillColor={255,170,213},
          fillPattern=FillPattern.Solid,
          fontSize=13,
          textString="Inform Consumers")}),    Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-76,66},{-74,-80}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-1,73},{1,-73}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-3,-79},
          rotation=90),
        Line(
          points={{-74,-54},{-52,-18},{-38,-40},{-20,-2},{-2,-70},{20,36},{38,-18},
              {60,4},{68,-10}},
          color={255,0,0},
          smooth=Smooth.None,
          thickness=0.5),
        Text(
          extent={{-78,82},{84,42}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="%name%")}));
end Broker;
