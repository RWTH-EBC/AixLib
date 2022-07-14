within AixLib.Controls.HVACAgentBasedControl.Agents;
model ConsumerAgent
  extends BaseClasses.PartialAgent(
    name=10001,
    uDPSend_adapted(userBufferSize=100000, autoBufferSize=true),
    uDPReceive_adapted(userBufferSize=100000, autoBufferSize=true));

  parameter Integer broker = 10003 "Name of the corresponding broker-agent";
  parameter Real sampleStartTime = 0 "Time when the agent makes first request";
  parameter Real sampleTriggerTime = 60
    "Time difference between two calls for adjustment [s]";

  Modelica.Blocks.Sources.SampleTrigger sampleTrigger(           startTime=
        sampleStartTime, period=sampleTriggerTime)
    annotation (Placement(transformation(extent={{-160,100},{-140,120}})));

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
  Modelica.StateGraph.Transition requestNoted(enableTimer=true, waitTime=
        0.1)
    annotation (Placement(transformation(extent={{-34,32},{-14,52}})));
  Modelica.StateGraph.StepWithSignal sendRequest(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{2,32},{22,52}})));
  Modelica.StateGraph.TransitionWithSignal newMessage1 "confirmation"
    annotation (Placement(transformation(extent={{38,52},{58,32}})));
  Modelica.StateGraph.Transition repeat(enableTimer=true, waitTime=10)
    annotation (Placement(transformation(extent={{-8,-6},{-28,14}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=noEvent(
        getperformative.y[1] == 5))
    annotation (Placement(transformation(extent={{66,62},{92,80}})));
  Modelica.StateGraph.Step state(nIn=1, nOut=2)
    annotation (Placement(transformation(extent={{66,32},{86,52}})));
  Modelica.StateGraph.TransitionWithSignal rightMessage "confirmation"
    annotation (Placement(transformation(extent={{106,52},{126,32}})));
  Modelica.StateGraph.Transition repeat1(enableTimer=true, waitTime=10)
    annotation (Placement(transformation(extent={{-8,-38},{-28,-18}})));
  Modelica.StateGraph.Step composeNotUnderstood(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-56,-240},{-36,-220}})));
  Modelica.StateGraph.Transition transition2(enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{-20,-240},{0,-220}})));
  Modelica.StateGraph.StepWithSignal sendNotUnderstood(nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{16,-240},{36,-220}})));
  Modelica.StateGraph.Transition transition4(enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{54,-240},{74,-220}})));
  Modelica.Blocks.Logical.Or or2
    annotation (Placement(transformation(extent={{148,-220},{168,-200}})));

  Modelica.StateGraph.Step composeConfirm(nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{-74,-118},{-54,-98}})));
  Modelica.StateGraph.StepWithSignal sendConfirm(nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{14,-118},{34,-98}})));
  Modelica.StateGraph.Transition confirmNoted(enableTimer=true, waitTime=
        0.1)
    annotation (Placement(transformation(extent={{-32,-118},{-12,-98}})));
  Modelica.StateGraph.Transition transition1(enableTimer=true, waitTime=0.1)
    annotation (Placement(transformation(extent={{74,-118},{94,-98}})));
  Modelica.Blocks.Logical.Or or3
    annotation (Placement(transformation(extent={{166,-182},{186,-162}})));
  Modelica.StateGraph.Step waitForInform(        nIn=1, nOut=2)
    annotation (Placement(transformation(extent={{4,-82},{-16,-62}})));
  Modelica.StateGraph.TransitionWithSignal rightMessage1 "confirmation"
    annotation (Placement(transformation(extent={{-54,-62},{-74,-82}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=
        getperformative.y[1] == 8)
    annotation (Placement(transformation(extent={{-116,-70},{-90,-52}})));
  Modelica.Blocks.Interfaces.RealInput demand
    "Input for the demand estimation of the consumer (e.g. output of a PID element)"                    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-90,200}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-46,80})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-94,116},{-74,136}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=(abs(demand)
         >= 20))
    annotation (Placement(transformation(extent={{-160,128},{-140,148}})));
  Modelica.StateGraph.Transition reset(enableTimer=true, waitTime=180)
    annotation (Placement(transformation(extent={{-62,-166},{-82,-146}})));
algorithm
  when noEvent(waiting.active) then
      content.u[1] := 0;
      content.u[2] := 0;
  end when;

  when noEvent(composeRequest.active) then
      content.u[1] := demand; //temporary function
      content.u[2] := 0;
      performative.u[1]:= 19;
      sender.u[1]:=name;
      receiver.u[1]:= broker;
      reply_to.u[1] := name;
      ontology.u[1] := 1;
      uDPSend_adapted.receiver := broker;
      messageID.u[1] := name*name + integer(time);
      Modelica.Utilities.Streams.print("ConsumerAgent "+ String(name)+ " requests " + String(content.u[1]) + " W of heat from Broker "+ String(broker)+".");
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
    Modelica.Utilities.Streams.print("ConsumerAgent "+ String(name)+ " confirms the request of " + String(content.u[2]) + " W of heat " + "for a price of "+String(content.u[1])+".");
  end when;

equation

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
      points={{36.5,-230},{60,-230}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition4.outPort, waiting.inPort[2]) annotation (Line(
      points={{65.5,-230},{130,-230},{130,-266},{-178,-266},{-178,-244},{
          -173,-244}},
      color={0,0,0},
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
      points={{-26,-108},{-36,-108},{-36,-108},{-38,-108},{-38,-108},{-53.5,
          -108}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(confirmNoted.outPort, sendConfirm.inPort[1]) annotation (Line(
      points={{-20.5,-108},{-10,-108},{-10,-108},{2,-108},{2,-108},{13,-108}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sendConfirm.outPort[1], transition1.inPort) annotation (Line(
      points={{34.5,-108},{48,-108},{48,-108},{56,-108},{56,-108},{80,-108}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition1.outPort, waiting.inPort[1]) annotation (Line(
      points={{85.5,-108},{130,-108},{130,-266},{-178,-266},{-178,-244},{-174,
          -244},{-174,-243.333},{-173,-243.333}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(or3.u1, sendConfirm.active) annotation (Line(
      points={{164,-172},{150,-172},{150,-130},{150,-130},{150,-126},{24,
          -126},{24,-119}},
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
      points={{-16.5,-71.75},{-38,-71.75},{-38,-72},{-60,-72}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(booleanExpression2.y, rightMessage1.condition) annotation (Line(
      points={{-88.7,-61},{-64,-61},{-64,-60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(rightMessage.outPort, waitForInform.inPort[1]) annotation (Line(
      points={{117.5,42},{128,42},{128,-72},{5,-72}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(rightMessage1.outPort, composeConfirm.inPort[1]) annotation (Line(
      points={{-65.5,-72},{-114,-72},{-114,-108},{-75,-108}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(and1.u2, sampleTrigger.y) annotation (Line(
      points={{-96,118},{-108,118},{-108,110},{-139,110}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression.y, and1.u1) annotation (Line(
      points={{-139,138},{-108,138},{-108,126},{-96,126}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(and1.y, transitionWithSignal.condition) annotation (Line(
      points={{-73,126},{-66,126},{-66,90},{-106,90},{-106,54}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(waitForInform.outPort[2],reset. inPort) annotation (Line(
      points={{-16.5,-72.25},{-40,-72.25},{-40,-156},{-68,-156}},
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
  <li>This model is a consumer agent which controls a heat/cold
  consuming entity.
  </li>
  <li>It is equivalent to the room agent apart from the inut data.
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
  The consumer agent receives a requested capacity as an input. When a
  pre-defined sample-time has elapsed, a cooling or heating request is
  calculated and send to a broker agent. The broker-agent ensures that
  the requested heat is produced. The logic is implemented with the
  help of the StateGraph library. Communication is realized with the
  help of the DeviceDriver library and follows the language standards
  for multi-agent-systems set by the FIPA to the highest possible
  extend for Modelica models. The following figure shows the behaviour
  of the consumer agent. For further information please refer to the
  first reference.
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
  <li>November 2016, by Felix Bünning: Updated symbol
  </li>
  <li>October 2015, by Felix Bünning: Developed and implemented
  </li>
</ul>
</html>"),Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -300},{200,200}}), graphics={
        Rectangle(
          extent={{-140,-78},{18,-214}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={206,101,103},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-54,-148},{22,-162}},
          lineColor={0,0,0},
          fillColor={255,170,213},
          fillPattern=FillPattern.Solid,
          fontSize=12,
          textString="Reset"),
        Rectangle(
          extent={{-140,-48},{136,-128}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-140,86},{138,-48}},
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
          extent={{10,-52},{130,-66}},
          lineColor={0,0,0},
          fillColor={255,170,213},
          fillPattern=FillPattern.Solid,
          fontSize=12,
          textString="Wait for price information")}),
                                          Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-62,-96},{-62,-96}},
          pattern=LinePattern.None,
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-76,52},{76,24}},
          pattern=LinePattern.None,
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="%name%",
          lineColor={0,0,0}),
        Rectangle(
          extent={{-42,14},{-30,-80}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,20},{-30,8}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,-74},{-30,-86}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,14},{-8,-80}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,20},{-8,8}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,-74},{-8,-86}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{2,14},{14,-80}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{2,20},{14,8}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{2,-74},{14,-86}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{24,14},{36,-80}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{24,20},{36,8}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{24,-74},{36,-86}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{38,14},{38,-4},{52,2},{52,8},{38,14}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-62,-86},{-54,-86},{-54,-74},{-50,-70},{-46,-70},{-46,-62},{
              -54,-62},{-58,-66},{-62,-72},{-62,-86},{-62,-86}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}));
end ConsumerAgent;
