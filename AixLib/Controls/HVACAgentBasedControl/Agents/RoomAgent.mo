within AixLib.Controls.HVACAgentBasedControl.Agents;
model RoomAgent
  extends BaseClasses.PartialAgent(
    name=10001,
    uDPSend_adapted(userBufferSize=100000, autoBufferSize=true),
    uDPReceive_adapted(userBufferSize=100000, autoBufferSize=true));
  parameter Real T_set = 273.15+20 "Set temperature by the user";
  parameter Integer broker = 10003 "Name of the corresponding broker-agent";
  parameter Real startTime = 0 "Time when the agent makes first request";
  parameter Real threshold = 2
    "Temperature threshold difference when agent gets active";
  parameter Real sampleTriggerTime = 60
    "Time difference between two calls for adjustment [s]";
  parameter Real P=50 "Proportional factor for load estimation";
  parameter Real Kd = 30000 "Derivative factor for load estimation";
  parameter Real G=1 "Gain for the load estimation";

  Modelica.Blocks.Interfaces.RealInput T "Room temperature" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-110,200}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-20,80})));

  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-100,140},{-80,160}})));
  Modelica.Blocks.Logical.GreaterThreshold T_too_high(threshold=threshold)
    annotation (Placement(transformation(extent={{-60,140},{-40,160}})));
  Modelica.Blocks.Math.Add add1(k2=-1)
    annotation (Placement(transformation(extent={{-100,110},{-80,130}})));
  Modelica.Blocks.Logical.GreaterThreshold T_too_low(threshold=threshold)
    annotation (Placement(transformation(extent={{-60,110},{-40,130}})));
  Modelica.Blocks.Sources.SampleTrigger sampleTrigger(           startTime=
        startTime, period=sampleTriggerTime)
    annotation (Placement(transformation(extent={{-20,172},{0,192}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{-20,140},{0,160}})));

  Modelica.Blocks.Logical.And actionTrigger
    annotation (Placement(transformation(extent={{48,140},{68,160}})));
  Modelica.StateGraph.InitialStep waiting(       nOut=2, nIn=3)
    annotation (Placement(transformation(extent={{-172,-254},{-152,-234}})));
  Modelica.StateGraph.TransitionWithSignal newMessage annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-98,-228})));
  Modelica.Blocks.Math.IntegerChange integerChange
    annotation (Placement(transformation(extent={{-172,-78},{-152,-58}})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal
    annotation (Placement(transformation(extent={{-116,52},{-96,32}})));
  Modelica.StateGraph.Step composeRequest(nOut=1, nIn=3)
    annotation (Placement(transformation(extent={{-72,32},{-52,52}})));
  Modelica.StateGraph.Transition requestNoted(enableTimer=true, waitTime=1)
    annotation (Placement(transformation(extent={{-34,32},{-14,52}})));
  Modelica.StateGraph.StepWithSignal sendRequest(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{2,32},{22,52}})));
  Modelica.StateGraph.TransitionWithSignal newMessage1 "confirmation"
    annotation (Placement(transformation(extent={{38,52},{58,32}})));
  Modelica.StateGraph.Transition repeat(enableTimer=true, waitTime=
        100000000)
    annotation (Placement(transformation(extent={{-8,-6},{-28,14}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=noEvent(
        getperformative.y[1] == 5))
    annotation (Placement(transformation(extent={{66,62},{92,80}})));
  Modelica.StateGraph.Step state(nIn=1, nOut=2)
    annotation (Placement(transformation(extent={{66,32},{86,52}})));
  Modelica.StateGraph.TransitionWithSignal rightMessage "confirmation"
    annotation (Placement(transformation(extent={{106,52},{126,32}})));
  Modelica.StateGraph.Transition repeat1(enableTimer=true, waitTime=
        100000000000.0)
    annotation (Placement(transformation(extent={{-8,-38},{-28,-18}})));
  Modelica.StateGraph.Step composeNotUnderstood(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-56,-240},{-36,-220}})));
  Modelica.StateGraph.Transition transition2(enableTimer=true, waitTime=1)
    annotation (Placement(transformation(extent={{-20,-240},{0,-220}})));
  Modelica.StateGraph.StepWithSignal sendNotUnderstood(nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{16,-240},{36,-220}})));
  Modelica.StateGraph.Transition transition4(enableTimer=true, waitTime=1)
    annotation (Placement(transformation(extent={{54,-240},{74,-220}})));
  Modelica.Blocks.Logical.Or or2
    annotation (Placement(transformation(extent={{148,-220},{168,-200}})));

protected
  Modelica.Blocks.Interfaces.RealOutput T_ref
    annotation (Placement(transformation(extent={{-156,154},{-136,174}})));

public
  Modelica.StateGraph.Step composeConfirm(nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{-74,-122},{-54,-102}})));
  Modelica.StateGraph.StepWithSignal sendConfirm(nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{16,-122},{36,-102}})));
  Modelica.StateGraph.Transition confirmNoted(enableTimer=true, waitTime=1)
    annotation (Placement(transformation(extent={{-30,-122},{-10,-102}})));
  Modelica.StateGraph.Transition transition1(enableTimer=true, waitTime=1)
    annotation (Placement(transformation(extent={{76,-122},{96,-102}})));
  Modelica.Blocks.Logical.Or or3
    annotation (Placement(transformation(extent={{166,-182},{186,-162}})));
  Modelica.StateGraph.Step waitForInform(        nIn=1, nOut=2)
    annotation (Placement(transformation(extent={{-8,-86},{-28,-66}})));
  Modelica.StateGraph.TransitionWithSignal rightMessage1 "confirmation"
    annotation (Placement(transformation(extent={{-54,-66},{-74,-86}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=noEvent(
        getperformative.y[1] == 8))
    annotation (Placement(transformation(extent={{-114,-70},{-88,-52}})));
  Modelica.Blocks.Continuous.Derivative derivative
    annotation (Placement(transformation(extent={{100,140},{120,160}})));
  Modelica.StateGraph.Transition reset(enableTimer=true, waitTime=180)
    annotation (Placement(transformation(extent={{-62,-166},{-82,-146}})));
algorithm
  when noEvent(waiting.active) then
      content.u[1] := 0;
      content.u[2] := 0;
  end when;

  when noEvent(composeRequest.active) then
      content.u[1] := G*(P*add1.y+Kd*derivative.y); //temporary function
      content.u[2] := 0;
      performative.u[1]:= 19;
      sender.u[1]:=name;
      receiver.u[1]:= broker;
      reply_to.u[1] := name;
      ontology.u[1] := 1;
      uDPSend_adapted.receiver := broker;
      messageID.u[1] := name*name + integer(time);
      Modelica.Utilities.Streams.print("RoomAgent "+ String(name)+ " requests " + String(content.u[1]) + " W of heat from Broker "+ String(broker)+".");
  end when;

  // Send out "not understood" message, if message has unknown performative
  when noEvent(composeNotUnderstood.active) then
    content.u[1] := 0;
    content.u[2] := 0;
    performative.u[1] := 11; //"not understood"
    sender.u[1] := name;
    receiver.u[1] := getsender.y[1];
    uDPSend_adapted.receiver :=  getsender.y[1];
    ontology.u[1] := getontology.y[1];
    messageID.u[1] := name*name + integer(time);
  end when;

  // Confirm the information by broker
  when noEvent(composeConfirm.active) then
    content.u[1] := get_content.y[1];
    content.u[2] := get_content.y[2];
    performative.u[1] := 5; //"confirm"
    receiver.u[1] := broker;
    reply_to.u[1] := name;
    ontology.u[1] := 1;
    uDPSend_adapted.receiver := broker;
    messageID.u[1] := name*name + integer(time);
    Modelica.Utilities.Streams.print("RoomAgent "+ String(name)+ " confirms the request of " + String(content.u[2]) + " W of heat " + "for a price of "+String(content.u[1])+".");
  end when;

equation
  T_ref = T_set;

  connect(T, add.u1) annotation (Line(
      points={{-110,200},{-110,156},{-102,156}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.u2, T_ref) annotation (Line(
      points={{-102,144},{-126,144},{-126,164},{-146,164}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y, T_too_high.u) annotation (Line(
      points={{-79,150},{-62,150}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add1.u2, add.u1) annotation (Line(
      points={{-102,114},{-110,114},{-110,156},{-102,156}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add1.u1, T_ref) annotation (Line(
      points={{-102,126},{-126,126},{-126,164},{-146,164}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_too_low.u, add1.y) annotation (Line(
      points={{-62,120},{-79,120}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_too_low.y, or1.u2) annotation (Line(
      points={{-39,120},{-32,120},{-32,142},{-22,142}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(T_too_high.y, or1.u1) annotation (Line(
      points={{-39,150},{-22,150}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(T_ref, T_ref) annotation (Line(
      points={{-146,164},{-146,164}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(actionTrigger.u2, sampleTrigger.y) annotation (Line(
      points={{46,142},{38,142},{38,182},{1,182}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(integerChange.u, getMessageID.y[1]) annotation (Line(
      points={{-174,-68},{-176,-68},{-176,-40},{-179,-40}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(transitionWithSignal.inPort, waiting.outPort[1]) annotation (Line(
      points={{-110,42},{-130,42},{-130,-243.75},{-151.5,-243.75}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(composeRequest.inPort[1], transitionWithSignal.outPort) annotation (
      Line(
      points={{-73,42.6667},{-80.5,42.6667},{-80.5,42},{-104.5,42}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(requestNoted.inPort, composeRequest.outPort[1]) annotation (Line(
      points={{-28,42},{-51.5,42}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(requestNoted.outPort, sendRequest.inPort[1]) annotation (Line(
      points={{-22.5,42},{1,42}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(newMessage1.inPort, sendRequest.outPort[1]) annotation (Line(
      points={{44,42},{30,42},{30,42.25},{22.5,42.25}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(repeat.outPort, composeRequest.inPort[2]) annotation (Line(
      points={{-19.5,4},{-86,4},{-86,42},{-73,42}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(repeat.inPort, sendRequest.outPort[2]) annotation (Line(
      points={{-14,4},{28,4},{28,41.75},{22.5,41.75}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(integerChange.y, newMessage1.condition) annotation (Line(
      points={{-151,-68},{-136,-68},{-136,66},{48,66},{48,54}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(state.inPort[1], newMessage1.outPort) annotation (Line(
      points={{65,42},{49.5,42}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(repeat1.outPort, composeRequest.inPort[3]) annotation (Line(
      points={{-19.5,-28},{-86,-28},{-86,42},{-74,42},{-74,41.3333},{-73,
          41.3333}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(repeat1.inPort, state.outPort[2]) annotation (Line(
      points={{-14,-28},{94,-28},{94,41.75},{86.5,41.75}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(rightMessage.inPort, state.outPort[1]) annotation (Line(
      points={{112,42},{110,42},{110,42.25},{86.5,42.25}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(booleanExpression1.y, rightMessage.condition) annotation (Line(
      points={{93.3,71},{116,71},{116,54}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(newMessage.inPort, waiting.outPort[2]) annotation (Line(
      points={{-102,-228},{-116,-228},{-116,-244.25},{-151.5,-244.25}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(newMessage.condition, newMessage1.condition) annotation (Line(
      points={{-98,-240},{-98,-244},{-100,-244},{-100,-248},{-136,-248},{
          -136,66},{48,66},{48,54}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(composeNotUnderstood.inPort[1], newMessage.outPort) annotation (Line(
      points={{-57,-230},{-76,-230},{-76,-228},{-96.5,-228}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(composeNotUnderstood.outPort[1], transition2.inPort) annotation (Line(
      points={{-35.5,-230},{-14,-230}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition2.outPort, sendNotUnderstood.inPort[1]) annotation (Line(
      points={{-8.5,-230},{15,-230}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sendNotUnderstood.outPort[1], transition4.inPort) annotation (Line(
      points={{36.5,-230},{42,-230},{42,-230},{54,-230},{54,-230},{60,-230}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition4.outPort, waiting.inPort[2]) annotation (Line(
      points={{65.5,-230},{130,-230},{130,-266},{-178,-266},{-178,-244},{
          -173,-244}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(actionTrigger.y, transitionWithSignal.condition) annotation (Line(
      points={{69,150},{68,150},{68,90},{68,90},{68,90},{-106,90},{-106,54}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sendRequest.active, or2.u1) annotation (Line(
      points={{12,31},{12,12},{140,12},{140,-210},{146,-210}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sendNotUnderstood.active, or2.u2) annotation (Line(
      points={{26,-241},{26,-250},{146,-250},{146,-218}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(confirmNoted.inPort, composeConfirm.outPort[1]) annotation (Line(
      points={{-24,-112},{-53.5,-112}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(confirmNoted.outPort, sendConfirm.inPort[1]) annotation (Line(
      points={{-18.5,-112},{15,-112}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sendConfirm.outPort[1], transition1.inPort) annotation (Line(
      points={{36.5,-112},{82,-112}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition1.outPort, waiting.inPort[1]) annotation (Line(
      points={{87.5,-112},{130,-112},{130,-266},{-178,-266},{-178,-244},{-173,
          -244},{-173,-243.333}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(or3.u1, sendConfirm.active) annotation (Line(
      points={{164,-172},{160,-172},{160,-170},{154,-170},{154,-128},{26,
          -128},{26,-123}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(or2.y, or3.u2) annotation (Line(
      points={{169,-210},{178,-210},{178,-190},{152,-190},{152,-180},{164,
          -180}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(or3.y, uDPSend_adapted.trigger) annotation (Line(
      points={{187,-172},{192,-172},{192,-88},{150,-88},{150,-70},{176,-70}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(waitForInform.outPort[1], rightMessage1.inPort) annotation (Line(
      points={{-28.5,-75.75},{-38,-75.75},{-38,-76},{-60,-76}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(booleanExpression2.y, rightMessage1.condition) annotation (Line(
      points={{-86.7,-61},{-64,-61},{-64,-64}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(rightMessage.outPort, waitForInform.inPort[1]) annotation (Line(
      points={{117.5,42},{128,42},{128,-76},{-7,-76}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(rightMessage1.outPort, composeConfirm.inPort[1]) annotation (Line(
      points={{-65.5,-76},{-114,-76},{-114,-112},{-75,-112}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(derivative.u, add1.y) annotation (Line(
      points={{98,150},{96,150},{96,102},{-72,102},{-72,120},{-79,120}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(or1.y, actionTrigger.u1)
    annotation (Line(points={{1,150},{23.5,150},{46,150}}, color={255,0,255}));
  connect(waitForInform.outPort[2], reset.inPort) annotation (Line(
      points={{-28.5,-76.25},{-40,-76.25},{-40,-156},{-68,-156}},
      color={255,0,0},
      pattern=LinePattern.Dot));
  connect(reset.outPort, waiting.inPort[3]) annotation (Line(
      points={{-73.5,-156},{-73.5,-156},{-178,-156},{-178,-244.667},{-173,
          -244.667}},
      color={255,0,0},
      pattern=LinePattern.Dot));
  annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<ul>
  <li>This model is a room-agent which controls the temperature inside
  the room.
  </li>
  <li>It is based on communication via UDP and logic implemented with
  the help of the StateGraph Modelica library.
  </li>
  <li>It is used together with a broker-agent and at least one
  producer-agent.
  </li>
</ul>
<p>
  <b><span style=
  \"font-family: MS Shell Dlg 2; color: #008000;\">Concept</span></b>
</p>
<p>
  The room agent observes the temperature inside a room. If the
  temperature crosses a certain treshhold and a pre-defined sample-time
  has elapsed, a cooling or heating request is calculated and send to a
  broker agent. The broker-agent ensures that the requested heat is
  produced. The logic is implemented with the help of the StateGraph
  library. Communication is realized with the help of the DeviceDriver
  library and follows the language standards for multi-agent-systems
  set by the FIPA to the highest possible extend for Modelica models.
  The following figure shows the behaviour of the roomagent. For
  further information please refer to the first reference.
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Controls/HVACAgentBasedControl/RoomAgent.png\"
  alt=\"Room agent\">
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
  <li>November 2016, by Felix Bünning: Made coefficients for load
  estimation accessible for the user
  </li>
  <li>October 2015, by Felix Bünning: Developed and implemented
  </li>
</ul>
</html>"),Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -300},{200,200}}), graphics={
        Rectangle(
          extent={{-140,-84},{18,-220}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={206,101,103},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-58,-140},{18,-154}},
          lineColor={0,0,0},
          fillColor={255,170,213},
          fillPattern=FillPattern.Solid,
          fontSize=12,
          textString="Reset"),
        Rectangle(
          extent={{-140,-50},{136,-134}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-140,84},{136,-50}},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-140,-192},{140,-260}},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Text(
          extent={{-6,-196},{132,-210}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          fontSize=12,
          textString="Message not understood"),
        Text(
          extent={{-96,78},{26,66}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          fontSize=12,
          textString="Send request"),
        Text(
          extent={{8,-56},{128,-70}},
          lineColor={0,0,0},
          fillColor={255,170,213},
          fillPattern=FillPattern.Solid,
          fontSize=13,
          textString="Wait for price information")}),
                                          Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-22,12},{22,-32}},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{0,-100},{0,-40},{-10,-40},{-24,-46},{-34,-58},{-38,-72},
              {-40,-84},{-40,-100},{0,-100}},
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{0,-100},{0,-40},{10,-40},{24,-46},{34,-58},{38,-72},{40,
              -84},{40,-100},{0,-100}},
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-66,0},{-30,-36}},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{34,0},{70,-36}},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-62,-96},{-62,-58},{-62,-44},{-76,-50},{-86,-62},{-90,
              -72},{-90,-84},{-88,-96},{-62,-96}},
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-62,-96},{-62,-96}},
          pattern=LinePattern.None,
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-62,-44},{-52,-44},{-38,-44},{-44,-54},{-50,-70},{-52,
              -84},{-52,-96},{-62,-96},{-62,-44}},
          pattern=LinePattern.None,
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{62,-44},{52,-44},{38,-44},{44,-54},{50,-70},{52,-84},{52,
              -96},{62,-96},{62,-44}},
          pattern=LinePattern.None,
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{62,-96},{62,-58},{62,-44},{76,-50},{86,-62},{90,-72},{90,
              -84},{88,-96},{62,-96}},
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-76,52},{76,24}},
          pattern=LinePattern.None,
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="%name%",
          lineColor={0,0,0})}));
end RoomAgent;
