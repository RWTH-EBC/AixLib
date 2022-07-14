within AixLib.Controls.HVACAgentBasedControl.Agents;
model IntermediateAgent
  extends BaseClasses.PartialAgent;
  parameter Integer broker = 10003 "Name of the corresponding broker-agent";
  parameter Real maxCapacity = 10000 "maximum capacity";
  Integer currentClient(start=0) "Integer variable to define currentClient";
  Real currentCost( start= 0) "Real variable to define currentCost";
  Real setCapacity(start=0) "Real variable to define setCapacity";
  Real newCost(start=0) "Real variable to define newCost";
  Real ownCost(start=0) "Real variable to define ownCost";

// CostFunction related components

// This section contains the blocks for the state-machine logic of the agent
  Modelica.StateGraph.InitialStep waiting(nOut=2, nIn=5)
                                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-178,-244})));
  Modelica.StateGraph.TransitionWithSignal newMessage annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={-160,-136})));
  Modelica.StateGraph.Step message(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{-178,-98},{-158,-78}})));

  Modelica.StateGraph.Step passOnCall(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-36,86},{-16,106}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=noEvent(
        getperformative.y[1] == 4))
    annotation (Placement(transformation(extent={{-108,74},{-82,92}})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal(
             waitTime=0.5, enableTimer=false)
    annotation (Placement(transformation(extent={{-88,86},{-68,106}})));
  Modelica.StateGraph.Transition transition1(                  waitTime=0.1,
      enableTimer=true)
    annotation (Placement(transformation(extent={{14,86},{34,106}})));

  Modelica.StateGraph.StepWithSignal sendCall(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{74,86},{94,106}})));
  Modelica.Blocks.Math.IntegerChange integerChange annotation (Placement(
        transformation(extent={{-176,-34},{-156,-14}})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal3(
                                                                enableTimer=
       true, waitTime=0.5)
    annotation (Placement(transformation(extent={{-84,-238},{-64,-218}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y=noEvent(
        getperformative.y[1] == 4))
    annotation (Placement(transformation(extent={{-120,-250},{-94,-232}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-88,-244},{-82,-238}})));
  Modelica.StateGraph.Step composeNotUnderstood(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-34,-238},{-14,-218}})));
  Modelica.StateGraph.Transition transition3(enableTimer=true, waitTime=1)
    annotation (Placement(transformation(extent={{4,-238},{24,-218}})));

  Modelica.StateGraph.StepWithSignal sendNotUnderstood(nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{44,-238},{64,-218}})));
  Modelica.StateGraph.Transition transition4(enableTimer=true, waitTime=1)
    annotation (Placement(transformation(extent={{84,-238},{104,-218}})));

  Modelica.StateGraph.TransitionWithSignal fromTopBroker(waitTime=0.5,
      enableTimer=false)
    annotation (Placement(transformation(extent={{-44,30},{-24,50}})));
  Modelica.StateGraph.TransitionWithSignal newMessage1
                                                      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-108,40})));
  Modelica.StateGraph.Step check(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-82,30},{-62,50}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression4(y=noEvent((
        getperformative.y[1] == 8) and (getsender.y[1] == broker)))
    annotation (Placement(transformation(extent={{-70,6},{-44,24}})));
  Modelica.StateGraph.Step passOnInformation(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{2,30},{22,50}})));
  Modelica.StateGraph.Transition transition7(                  waitTime=0.1,
      enableTimer=true)
    annotation (Placement(transformation(extent={{44,30},{64,50}})));
  Modelica.StateGraph.StepWithSignal sendInformation(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{84,30},{104,50}})));
  Modelica.StateGraph.TransitionWithSignal newMessage2
                                                      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-40})));
  Modelica.StateGraph.Step check1(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-86,-50},{-66,-30}})));
  Modelica.StateGraph.TransitionWithSignal fromBottomBroker(waitTime=0.5,
      enableTimer=false)
    annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
  Modelica.StateGraph.Step passOnConfirmation(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-2,-50},{18,-30}})));
  Modelica.StateGraph.Transition transition8(                  waitTime=0.1,
      enableTimer=true)
    annotation (Placement(transformation(extent={{38,-50},{58,-30}})));
  Modelica.StateGraph.StepWithSignal sendConfirmation(
                                                     nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{82,-50},{102,-30}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=noEvent((
        getsender.y[1] == currentClient)))
    annotation (Placement(transformation(extent={{-86,-70},{-60,-52}})));
  Modelica.StateGraph.Transition transition2(                  waitTime=0.1,
      enableTimer=true)
    annotation (Placement(transformation(extent={{-112,-118},{-92,-98}})));
  Modelica.StateGraph.Step confirmToBottom(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-70,-118},{-50,-98}})));
  Modelica.StateGraph.Transition transition5(                  waitTime=0.1,
      enableTimer=true)
    annotation (Placement(transformation(extent={{-22,-118},{-2,-98}})));
  Modelica.StateGraph.StepWithSignal sendConfirmation1(
                                                     nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{34,-118},{54,-98}})));
  Modelica.StateGraph.Transition transition6(                  waitTime=0.1,
      enableTimer=true)
    annotation (Placement(transformation(extent={{82,-118},{102,-98}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{132,62},{144,74}})));
  Modelica.Blocks.Logical.Or or2
    annotation (Placement(transformation(extent={{134,-102},{146,-90}})));
  Modelica.Blocks.Logical.Or or3
    annotation (Placement(transformation(extent={{130,-78},{142,-66}})));
  Modelica.Blocks.Logical.Or or4
    annotation (Placement(transformation(extent={{154,-78},{166,-66}})));
  Modelica.Blocks.Interfaces.RealOutput calcCapacity
    "Output to connect with cost function"                                                  annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,198}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,90})));
  Modelica.Blocks.Interfaces.RealInput calcCost
    "Input to connect with cost function"                                             annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={90,200}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={60,80})));
  Modelica.Blocks.Interfaces.RealInput currentCapacity
    "Input for current capacity of device"                                                    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-90,-300}),iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={-80,-80})));
  Modelica.Blocks.Interfaces.RealOutput setCapacityOut(start=0.001)
    "Output for set capacity of device"                                                                 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={74,-300}),iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,-90})));
  Modelica.StateGraph.Transition reset(enableTimer=true, waitTime=60)
    annotation (Placement(transformation(extent={{-26,-170},{-46,-150}})));
  Modelica.StateGraph.Transition reset1(
                                       enableTimer=true, waitTime=60)
    annotation (Placement(transformation(extent={{14,-190},{-6,-170}})));
  Modelica.Blocks.Interfaces.BooleanInput OnOff_external
    "External on/off switch"
    annotation (Placement(transformation(extent={{-152,-164},{-112,-124}}),
        iconTransformation(extent={{-100,-54},{-60,-14}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=noEvent(abs(
        setCapacity) > 30))
    annotation (Placement(transformation(extent={{-200,-306},{-180,-286}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-150,-300},{-130,-280}})));
  Modelica.StateGraph.Step shutDown(
                                   nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{-80,-274},{-60,-254}})));
  Modelica.StateGraph.Transition transition9(                  waitTime=0.1,
      enableTimer=true)
    annotation (Placement(transformation(extent={{-52,-274},{-32,-254}})));
  Modelica.StateGraph.TransitionWithSignal Off annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-116,-264})));
  Modelica.Blocks.Logical.Not not2
    annotation (Placement(transformation(extent={{-172,-292},{-162,-282}})));
equation

  connect(newMessage.inPort, waiting.outPort[1]) annotation (Line(
      points={{-156,-136},{-140,-136},{-140,-243.75},{-167.5,-243.75}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(newMessage.outPort, message.inPort[1]) annotation (Line(
      points={{-161.5,-136},{-190,-136},{-190,-88},{-179,-88}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(booleanExpression.y, transitionWithSignal.condition) annotation (Line(
      points={{-80.7,83},{-78,83},{-78,84}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(passOnCall.inPort[1], transitionWithSignal.outPort) annotation (Line(
      points={{-37,96},{-76.5,96}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition1.inPort, passOnCall.outPort[1]) annotation (Line(
      points={{20,96},{-15.5,96}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sendCall.inPort[1], transition1.outPort) annotation (Line(
      points={{73,96},{25.5,96}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(getMessageID.y[1], integerChange.u) annotation (Line(
      points={{-179,-40},{-180,-40},{-180,-30},{-182,-30},{-182,-24},{-178,-24}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(integerChange.y, newMessage.condition) annotation (Line(
      points={{-155,-24},{-152,-24},{-152,-118},{-160,-118},{-160,-124}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(message.outPort[1], transitionWithSignal.inPort) annotation (Line(
      points={{-157.5,-87.75},{-152,-87.75},{-152,-86},{-144,-86},{-144,-86},
          {-132,-86},{-132,96},{-82,96}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(booleanExpression3.y, not1.u) annotation (Line(
      points={{-92.7,-241},{-92.7,-242},{-92,-242},{-92,-241},{-88.6,-241}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(transitionWithSignal3.condition, not1.y) annotation (Line(
      points={{-74,-240},{-80,-240},{-80,-241},{-81.7,-241}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(transitionWithSignal3.inPort, message.outPort[2]) annotation (Line(
      points={{-78,-228},{-132,-228},{-132,-86},{-152,-86},{-152,-88.25},{-157.5,
          -88.25}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(composeNotUnderstood.inPort[1], transitionWithSignal3.outPort)
    annotation (Line(
      points={{-35,-228},{-42,-228},{-42,-228},{-54,-228},{-54,-228},{-72.5,-228}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(composeNotUnderstood.outPort[1], transition3.inPort) annotation (Line(
      points={{-13.5,-228},{-8,-228},{-8,-228},{-2,-228},{-2,-228},{10,-228}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition3.outPort, sendNotUnderstood.inPort[1]) annotation (Line(
      points={{15.5,-228},{22,-228},{22,-228},{32,-228},{32,-228},{43,-228}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition4.inPort, sendNotUnderstood.outPort[1]) annotation (Line(
      points={{90,-228},{84,-228},{84,-228},{76,-228},{76,-228},{64.5,-228}},
      color={0,0,0},
      smooth=Smooth.None));

// The algorithm section contains the logic of the broker, describing the
// actions taken during each active state of the agent
algorithm

  when waiting.active then
    currentClient := 0;
    calcCapacity := setCapacity;
    currentCost := calcCost;

  end when;

  // ExternalshutDown
  when noEvent(shutDown.active) then
    setCapacity :=0;
    setCapacityOut := setCapacity;
  end when;

  // Compute costs for the requested amount of heat
  when passOnCall.active then
    currentClient := getsender.y[1];
    performative.u[1] := 19;
    sender.u[1] := name;
    receiver.u[1] := broker;
    reply_to.u[1] := name;
    content.u[1] := get_content.y[1];
    content.u[2] := get_content.y[2];
    ontology.u[1] := getontology.y[1];
    uDPSend_adapted.receiver := broker;
    messageID.u[1] := name*name + integer(time);
    Modelica.Utilities.Streams.print("IntermediateAgent "+ String(name)+ " got a call from bottom broker " + String(currentClient) + " and passes it on to top broker " + String(broker) +".");
  end when;

  when passOnInformation.active then
    performative.u[1] := 13;
    sender.u[1] := name;
    reply_to.u[1] := name;
    receiver.u[1] := currentClient;
    uDPSend_adapted.receiver := currentClient;
    calcCapacity := get_content.y[2];
    newCost :=calcCost;
    ownCost := newCost -currentCost;
    content.u[1] := get_content.y[1]+ownCost;
    content.u[2] := get_content.y[2];
    ontology.u[1] := getontology.y[1];
    messageID.u[1] := name*name + integer(time);
    Modelica.Utilities.Streams.print("IntermediateAgent "+ String(name)+ " got an information from top broker " + String(broker) + " and passes it on as a proposal to bottom broker " + String(currentClient) +" after adding own costs of " + String(ownCost) +".");
  end when;

  when passOnConfirmation.active then
    if getperformative.y[1] == 1 then
      performative.u[1] := 5;
      Modelica.Utilities.Streams.print("IntermediateAgent "+ String(name)+ " got an accept proposal from " + String(currentClient) + " and passes it on as a confirmation to top broker " + String(broker) +".");
    else
      performative.u[1] := 3;
      Modelica.Utilities.Streams.print("IntermediateAgent "+ String(name)+ " got an reject proposal from " + String(currentClient) + " and passes it on as a cancel to top broker " + String(broker) +".");
    end if;

      sender.u[1] := name;
      receiver.u[1] := broker;
      reply_to.u[1] := name;
      uDPSend_adapted.receiver := broker;
      content.u[1] := get_content.y[2];
      content.u[2] := get_content.y[1];
      ontology.u[1] := getontology.y[1];
      messageID.u[1] := name*name + integer(time);

  end when;

  when confirmToBottom.active then
    performative.u[1] := 5;
    sender.u[1] := name;
    reply_to.u[1] := name;
    receiver.u[1] := currentClient;
    uDPSend_adapted.receiver := currentClient;
    content.u[1] := get_content.y[2];
    content.u[2] := get_content.y[1];
    ontology.u[1] := getontology.y[1];
    messageID.u[1] := name*name + integer(time);
    if getperformative.y[1] == 1 then
      Modelica.Utilities.Streams.print("IntermediateAgent "+ String(name)+ " confirms the adjustment of " + String(get_content.y[1]) + " W of heat.");
      setCapacity := max(min(setCapacity+get_content.y[1],maxCapacity),0);
      setCapacityOut := setCapacity;
    end if;
  end when;

// Send out "not understood" message, if message has unknown performative
  when composeNotUnderstood.active then
    performative.u[1] := 11; //"not understood"
    content.u[1] := 0;
    content.u[2] := 0;
    messageID.u[1] := name*name + integer(time);
  end when;

equation

  connect(transition4.outPort, waiting.inPort[1]) annotation (Line(
      points={{95.5,-228},{130,-228},{130,-280},{-192,-280},{-192,-243.2},{
          -189,-243.2}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(sendCall.outPort[1], newMessage1.inPort) annotation (Line(
      points={{94.5,96.25},{110,96.25},{110,60},{-122,60},{-122,40},{-112,
          40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(newMessage1.outPort, check.inPort[1]) annotation (Line(
      points={{-106.5,40},{-83,40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(check.outPort[1], fromTopBroker.inPort) annotation (Line(
      points={{-61.5,40},{-38,40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(fromTopBroker.outPort, passOnInformation.inPort[1]) annotation (Line(
      points={{-32.5,40},{1,40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(passOnInformation.outPort[1], transition7.inPort) annotation (Line(
      points={{22.5,40},{50,40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition7.outPort, sendInformation.inPort[1]) annotation (Line(
      points={{55.5,40},{83,40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sendInformation.outPort[1], newMessage2.inPort) annotation (Line(
      points={{104.5,40.25},{110,40.25},{110,-16},{-124,-16},{-124,-40},{
          -114,-40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(newMessage2.outPort, check1.inPort[1]) annotation (Line(
      points={{-108.5,-40},{-87,-40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(check1.outPort[1], fromBottomBroker.inPort) annotation (Line(
      points={{-65.5,-40},{-44,-40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(fromBottomBroker.outPort, passOnConfirmation.inPort[1]) annotation (
      Line(
      points={{-38.5,-40},{-3,-40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(passOnConfirmation.outPort[1], transition8.inPort) annotation (Line(
      points={{18.5,-40},{44,-40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition8.outPort, sendConfirmation.inPort[1]) annotation (Line(
      points={{49.5,-40},{81,-40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(booleanExpression4.y, fromTopBroker.condition) annotation (Line(
      points={{-42.7,15},{-34,15},{-34,28}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression1.y, fromBottomBroker.condition) annotation (Line(
      points={{-58.7,-61},{-40,-61},{-40,-52}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sendConfirmation.outPort[1], transition2.inPort) annotation (Line(
      points={{102.5,-40},{110,-40},{110,-86},{-124,-86},{-124,-108},{-106,
          -108}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(transition2.outPort, confirmToBottom.inPort[1]) annotation (Line(
      points={{-100.5,-108},{-71,-108}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(confirmToBottom.outPort[1], transition5.inPort) annotation (Line(
      points={{-49.5,-108},{-16,-108}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition5.outPort, sendConfirmation1.inPort[1]) annotation (Line(
      points={{-10.5,-108},{33,-108}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition6.inPort, sendConfirmation1.outPort[1]) annotation (Line(
      points={{88,-108},{54.5,-108}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition6.outPort, waiting.inPort[2]) annotation (Line(
      points={{93.5,-108},{130,-108},{130,-280},{-192,-280},{-192,-243.6},{
          -189,-243.6}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(newMessage1.condition, integerChange.y) annotation (Line(
      points={{-108,28},{-108,8},{-150,8},{-150,-22},{-152,-22},{-152,-24},
          {-155,-24}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(newMessage2.condition, newMessage.condition) annotation (Line(
      points={{-110,-52},{-152,-52},{-152,-118},{-160,-118},{-160,-124}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sendCall.active, or1.u1) annotation (Line(
      points={{84,85},{84,68},{130.8,68}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sendInformation.active, or1.u2) annotation (Line(
      points={{94,29},{94,10},{126,10},{126,63.2},{130.8,63.2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sendNotUnderstood.active, or2.u2) annotation (Line(
      points={{54,-239},{54,-260},{126,-260},{126,-100.8},{132.8,-100.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sendConfirmation1.active, or2.u1) annotation (Line(
      points={{44,-119},{44,-146},{134,-146},{134,-96},{132.8,-96}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(or3.u1, sendConfirmation.active) annotation (Line(
      points={{128.8,-72},{92,-72},{92,-51}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(or2.y, or3.u2) annotation (Line(
      points={{146.6,-96},{150,-96},{150,-88},{122,-88},{122,-76.8},{128.8,
          -76.8}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(or4.u2, or3.y) annotation (Line(
      points={{152.8,-76.8},{146.4,-76.8},{146.4,-72},{142.6,-72}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(or4.y, uDPSend_adapted.trigger) annotation (Line(
      points={{166.6,-72},{172,-72},{172,-70},{176,-70}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(or4.u1, or1.y) annotation (Line(
      points={{152.8,-72},{152.8,-66},{152,-66},{152,-58},{146,-58},{146,68},{144.6,
          68}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(reset.inPort, sendCall.outPort[2]) annotation (Line(
      points={{-32,-160},{36,-160},{124,-160},{124,94},{124,95.75},{94.5,
          95.75}},
      color={255,0,0},
      pattern=LinePattern.Dot));
  connect(sendInformation.outPort[2], reset1.inPort) annotation (Line(
      points={{104.5,39.75},{124,39.75},{124,-180},{8,-180}},
      color={255,0,0},
      pattern=LinePattern.Dot));
  connect(reset.outPort, waiting.inPort[3]) annotation (Line(
      points={{-37.5,-160},{-106,-160},{-192,-160},{-192,-244},{-189,-244}},
      color={255,0,0},
      pattern=LinePattern.Dot));
  connect(reset1.outPort, waiting.inPort[4]) annotation (Line(
      points={{2.5,-180},{-80,-180},{-192,-180},{-192,-244.4},{-189,-244.4}},
      color={255,0,0},
      pattern=LinePattern.Dot));
  connect(and1.u2, booleanExpression2.y) annotation (Line(points={{-152,
          -298},{-158,-298},{-158,-296},{-179,-296}},
                                          color={255,0,255}));
  connect(Off.inPort, waiting.outPort[2]) annotation (Line(points={{-120,
          -264},{-164,-264},{-164,-244.25},{-167.5,-244.25}},
                                                       color={0,0,0}));
  connect(Off.outPort, shutDown.inPort[1]) annotation (Line(points={{-114.5,
          -264},{-128,-264},{-81,-264}},        color={0,0,0}));
  connect(shutDown.outPort[1], transition9.inPort) annotation (Line(points={{-59.5,
          -263.75},{-52,-263.75},{-52,-264},{-46,-264}}, color={0,0,0}));
  connect(and1.y, Off.condition) annotation (Line(points={{-129,-290},{-118,
          -290},{-118,-276},{-116,-276}},
                                    color={255,0,255}));
  connect(transition9.outPort, waiting.inPort[5]) annotation (Line(points={{-40.5,
          -264},{-26,-264},{-26,-280},{-192,-280},{-192,-244},{-190,-244},{
          -190,-244.8},{-189,-244.8}},
                                  color={0,0,0}));
  connect(OnOff_external, not2.u) annotation (Line(points={{-132,-144},{
          -132,-190},{-196,-190},{-196,-287},{-173,-287}}, color={255,0,255}));
  connect(not2.y, and1.u1) annotation (Line(points={{-161.5,-287},{-160,
          -287},{-160,-290},{-160,-290},{-160,-288},{-160,-290},{-152,-290}},
                                                                  color={
          255,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -300},{200,200}}), graphics={
        Rectangle(
          extent={{-80,-136},{56,-196}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={206,101,103},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-24,-138},{52,-152}},
          lineColor={0,0,0},
          fillColor={255,170,213},
          fillPattern=FillPattern.Solid,
          fontSize=13,
          textString="Reset"),
        Rectangle(
          extent={{-130,-196},{126,-248}},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-130,140},{126,64}},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Text(
          extent={{-62,124},{42,110}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          fontSize=12,
          textString="Pass on call for proposal
"),     Text(
          extent={{-124,-198},{12,-212}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          fontSize=12,
          textString="Message not understood"),
        Rectangle(
          extent={{-130,64},{126,-8}},
          fillColor={170,255,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Text(
          extent={{-56,4},{48,-10}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          fontSize=12,
          textString="Pass on information to bottom broker
"),     Rectangle(
          extent={{-130,-8},{126,-80}},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Text(
          extent={{-42,-68},{62,-82}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          fontSize=12,
          textString="Pass on confirmation to top broker
"),     Rectangle(
          extent={{-130,-78},{126,-138}},
          fillColor={170,255,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Text(
          extent={{-64,-128},{40,-142}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          fontSize=12,
          textString="Confirm pass-on to bottom broker
")}),                                     Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                  Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-54,56},{66,-50}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="A"),
        Rectangle(
          extent={{100,100},{-100,-100}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,6},{22,6},{22,42},{40,42},{0,80},{0,6}},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{0,6},{-22,6},{-22,42},{-40,42},{0,80},{0,6}},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{0,-10},{22,-10},{22,-46},{40,-46},{0,-84},{0,-10}},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{0,-10},{-22,-10},{-22,-46},{-40,-46},{0,-84},{0,-10}},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}),
    Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<ul>
  <li>This model is an intermediate agent which represents devices to
  connect thermal circuits (heat exchanger, mixing valve).
  </li>
  <li>It is based on communication via UDP and logic implemented with
  the help of the StateGraph Modelica library.
  </li>
  <li>It is used together with a broker-agent and at least one
  producer-agent.
  </li>
</ul>
<h4>
  <span style=\"color: #008000\">Concept</span>
</h4>
<p>
  The intermediate agent acts as a producer in front of one broker
  (bottom) and consumer in front of another broker (top). When it gets
  a call for proposal from the bottom broker, it passes it on to the
  top broker as an request. This broker handels the request and
  responds with a price information. The intermediate agent adds its
  own costs and passes it on as a proposal to the bottom broker. The
  proposal gets either rejected or accepted. This is passed on a
  confirm/reject to the top broker. The intermediate agent also adjusts
  it capacity according to the requested adjustment. The logic is
  implemented with the help of the StateGraph library. Communication is
  realized with the help of the DeviceDriver library and follows the
  language standards for multi-agent-systems set by the FIPA to the
  highest possible extend for Modelica models. The following figure
  shows the behaviour of the roomagent. For further information please
  refer to the first reference.
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Controls/HVACAgentBasedControl/IntermediateAgent.png\"
  alt=\"Intermediate agent\">
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
  <li>Felix Bünning, Roozbeh Sangi, Dirk Müller. A Modelica library for
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
    \"HVACAgentBasedControl.Examples.HVACAgentsCommunications.SimpleCommunication\">
    ExampleAgentSystem</a>
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
  <li>October 2015, by Felix Bünning: Developed and implemented
  </li>
</ul>
</html>"));
end IntermediateAgent;
