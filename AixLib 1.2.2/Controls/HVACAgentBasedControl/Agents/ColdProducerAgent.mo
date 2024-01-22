within AixLib.Controls.HVACAgentBasedControl.Agents;
model ColdProducerAgent
  extends BaseClasses.PartialAgent;
  parameter Real maxCapacity = 0
    "Maximum capacity for heat/cold generation (heat positive, cold negative)";
  parameter Real minCapacity = -10000
    "Minimum capacity for heat/cold generation (heat positive, cold negative)";
  Real minCapacityInternal "Real variable to define minCapacityInternal";
  Real costCurrent(start=40) "Real variable to define costCurrent";
  Real costNew(start=0) "Real variable to define costNew";
  Real setCapacity(start=2000) "Real variable to define setCapacity";
  Real costDifference(start=0) "Real variable to define costDifference";
  Real totalRequest(start=0) "Real variable to define totalRequest";
  Real currentCapacityDiscrete(start=2000) "Real variable to define currentCapacityDiscrete";
  parameter Boolean maxCapacityExternal=false
    "Use external input for minimal capacity";

// CostFunction related components

// This section contains the blocks for the state-machine logic of the agent
  Modelica.StateGraph.InitialStep waiting(       nOut=2, nIn=4)
                                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-130,-108})));
  Modelica.StateGraph.TransitionWithSignal newMessage annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-92,-108})));
  Modelica.StateGraph.Step message(nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{-72,-118},{-52,-98}})));
  Modelica.StateGraph.Step adjustHeat(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-36,20},{-16,40}})));
  Modelica.StateGraph.Transition transition2(
      enableTimer=true, waitTime=2)
    annotation (Placement(transformation(extent={{-8,20},{12,40}})));

  Modelica.StateGraph.Step computeProposal(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-26,86},{-6,106}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=noEvent(
        getperformative.y[1] == 4))
    annotation (Placement(transformation(extent={{-124,72},{-98,90}})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal(
             waitTime=0.5, enableTimer=false)
    annotation (Placement(transformation(extent={{-100,86},{-80,106}})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal1(
                        waitTime=0.5, enableTimer=false)
    annotation (Placement(transformation(extent={{-86,20},{-66,40}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=noEvent(
        getperformative.y[1] == 1))
    annotation (Placement(transformation(extent={{-108,8},{-82,26}})));
  Modelica.StateGraph.Transition transition1(                  waitTime=0.1,
      enableTimer=true)
    annotation (Placement(transformation(extent={{44,86},{64,106}})));

  Modelica.StateGraph.StepWithSignal sendProposal(nOut=3, nIn=1)
    annotation (Placement(transformation(extent={{76,86},{96,106}})));
  Modelica.Blocks.Math.IntegerChange integerChange annotation (Placement(
        transformation(extent={{-170,-50},{-150,-30}})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal2(
                        waitTime=0.5, enableTimer=false)
    annotation (Placement(transformation(extent={{-86,-18},{-66,2}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=noEvent(
        getperformative.y[1] == 18))
    annotation (Placement(transformation(extent={{-108,-36},{-82,-18}})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal3(
                                                                enableTimer=
       true, waitTime=0.5)
    annotation (Placement(transformation(extent={{-86,-56},{-66,-36}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y=noEvent(
        getperformative.y[1] == 4))
    annotation (Placement(transformation(extent={{-124,-68},{-98,-50}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-90,-62},{-84,-56}})));
  Modelica.StateGraph.Step composeNotUnderstood(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-36,-56},{-16,-36}})));
  Modelica.StateGraph.Transition transition3(enableTimer=true, waitTime=1)
    annotation (Placement(transformation(extent={{2,-56},{22,-36}})));

  Modelica.StateGraph.StepWithSignal sendNotUnderstood(nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{42,-56},{62,-36}})));
  Modelica.StateGraph.Transition transition4(enableTimer=true, waitTime=1)
    annotation (Placement(transformation(extent={{82,-56},{102,-36}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{104,-194},{124,-174}})));
  Modelica.Blocks.Interfaces.RealInput currentCapacity
    "Input for current capacity of device"                                                    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-70,-200}),iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={-80,-80})));
  Modelica.Blocks.Interfaces.RealOutput setCapacityOut
    "Output for set capacity of device"                                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,-200}),iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,-90})));

  Modelica.StateGraph.StepWithSignal sendConfirmation(nOut=1, nIn=2)
    annotation (Placement(transformation(extent={{26,20},{46,40}})));
  Modelica.StateGraph.Transition transition5(                  waitTime=0.1,
      enableTimer=true)
    annotation (Placement(transformation(extent={{72,20},{92,40}})));
  Modelica.Blocks.Logical.Or or2
    annotation (Placement(transformation(extent={{134,-194},{154,-174}})));

protected
  Modelica.Blocks.Interfaces.BooleanInput send
    annotation (Placement(transformation(extent={{140,-204},{180,-164}})));

public
  Modelica.StateGraph.Step confirm(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-38,-26},{-18,-6}})));
  Modelica.StateGraph.Transition transition6(
      enableTimer=true, waitTime=2)
    annotation (Placement(transformation(extent={{-8,-26},{12,-6}})));
  Modelica.Blocks.Interfaces.RealOutput calcCapacity
    "Output to connect with cost function"                                                  annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,198}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,90})));
  Modelica.Blocks.Interfaces.RealInput calcCost
    "Input to connect with cost function"                                             annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={70,200}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={60,80})));
  Modelica.StateGraph.TransitionWithSignal Off(enableTimer=true, waitTime=0)
                                               annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-82,-154})));
  Modelica.StateGraph.Step shutDown(
                                   nOut=2, nIn=1)
    annotation (Placement(transformation(extent={{-56,-164},{-36,-144}})));
  Modelica.StateGraph.Transition transition7(                  waitTime=0.1,
      enableTimer=true)
    annotation (Placement(transformation(extent={{-26,-164},{-6,-144}})));
  Modelica.Blocks.Logical.Not not2
    annotation (Placement(transformation(extent={{-184,-194},{-174,-184}})));
  Modelica.Blocks.Interfaces.BooleanInput OnOff_external
    "External on/off switch"
    annotation (Placement(transformation(extent={{-220,-130},{-180,-90}}),
        iconTransformation(extent={{-100,-62},{-60,-22}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression4(y=noEvent(abs(
        setCapacity) > 30))
    annotation (Placement(transformation(extent={{-150,-206},{-130,-186}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-114,-198},{-94,-178}})));
  Modelica.StateGraph.Transition reset(enableTimer=true, waitTime=60)
    annotation (Placement(transformation(extent={{20,-116},{0,-96}})));
protected
  Modelica.Blocks.Interfaces.BooleanOutput calc_active
    "Indicator that cost calculation in cost function is active"                                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,198}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,90})));
public
  Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold(samplePeriod=3600)
    annotation (Placement(transformation(extent={{-174,-86},{-154,-66}})));
  Modelica.Blocks.Interfaces.RealInput minCapacityInput if maxCapacityExternal
    "Input for external minimum capacity"                                                                            annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-200,-76}),  iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-80,38})));
equation

  if maxCapacityExternal then
    //connect(maxCapacity,maxCapacityInternal);
    minCapacityInternal = zeroOrderHold.y;
  else
   minCapacityInternal = minCapacity;
  end if;

  connect(newMessage.inPort, waiting.outPort[1]) annotation (Line(
      points={{-96,-108},{-108,-108},{-108,-107.75},{-119.5,-107.75}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(newMessage.outPort, message.inPort[1]) annotation (Line(
      points={{-90.5,-108},{-73,-108}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(adjustHeat.outPort[1], transition2.inPort) annotation (Line(
      points={{-15.5,30},{-2,30}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(send, uDPSend_adapted.trigger) annotation (Line(
      points={{160,-184},{168,-184},{168,-70},{176,-70}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanExpression.y, transitionWithSignal.condition) annotation (Line(
      points={{-96.7,81},{-90,81},{-90,84}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(computeProposal.inPort[1], transitionWithSignal.outPort) annotation (
      Line(
      points={{-27,96},{-88.5,96}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(booleanExpression1.y, transitionWithSignal1.condition) annotation (
      Line(
      points={{-80.7,17},{-80.7,16},{-76,16},{-76,18}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(adjustHeat.inPort[1], transitionWithSignal1.outPort) annotation (Line(
      points={{-37,30},{-74.5,30}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition1.inPort, computeProposal.outPort[1]) annotation (Line(
      points={{50,96},{-5.5,96}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sendProposal.inPort[1], transition1.outPort) annotation (Line(
      points={{75,96},{55.5,96}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(getMessageID.y[1], integerChange.u) annotation (Line(
      points={{-179,-40},{-172,-40}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(integerChange.y, newMessage.condition) annotation (Line(
      points={{-149,-40},{-136,-40},{-136,-76},{-120,-76},{-120,-76},{-92,
          -76},{-92,-96}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sendProposal.outPort[1], transitionWithSignal1.inPort) annotation (
      Line(
      points={{96.5,96.3333},{104,96.3333},{104,68},{-114,68},{-114,30},{-80,30}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transitionWithSignal2.condition, booleanExpression2.y) annotation (
      Line(
      points={{-76,-20},{-76,-27},{-80.7,-27}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(transitionWithSignal2.inPort, sendProposal.outPort[2]) annotation (
      Line(
      points={{-80,-8},{-114,-8},{-114,68},{104,68},{104,96},{96.5,96}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(message.outPort[1], transitionWithSignal.inPort) annotation (Line(
      points={{-51.5,-107.75},{-48,-107.75},{-48,-86},{-132,-86},{-132,96},{-94,
          96}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(booleanExpression3.y, not1.u) annotation (Line(
      points={{-96.7,-59},{-90.6,-59}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(transitionWithSignal3.condition, not1.y) annotation (Line(
      points={{-76,-58},{-80,-58},{-80,-59},{-83.7,-59}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(transitionWithSignal3.inPort, message.outPort[2]) annotation (Line(
      points={{-80,-46},{-132,-46},{-132,-86},{-48,-86},{-48,-108.25},{-51.5,-108.25}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(composeNotUnderstood.inPort[1], transitionWithSignal3.outPort)
    annotation (Line(
      points={{-37,-46},{-74.5,-46}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(composeNotUnderstood.outPort[1], transition3.inPort) annotation (Line(
      points={{-15.5,-46},{8,-46}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition3.outPort, sendNotUnderstood.inPort[1]) annotation (Line(
      points={{13.5,-46},{41,-46}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition4.inPort, sendNotUnderstood.outPort[1]) annotation (Line(
      points={{88,-46},{62.5,-46}},
      color={0,0,0},
      smooth=Smooth.None));

// The algorithm section contains the logic of the broker, describing the
// actions taken during each active state of the agent
algorithm

  when noEvent(waiting.active) then
    currentCapacityDiscrete := currentCapacity;
    calcCapacity := setCapacity;
    costCurrent := calcCost;

  end when;

  // ExternalshutDown
  when noEvent(shutDown.active) then
    setCapacity :=0;
    setCapacityOut := setCapacity;
  end when;

  // Compute costs for the requested amount of heat
  when noEvent(computeProposal.active) then

    if get_content.y[1] >0 then

      if noEvent(((setCapacity+get_content.y[1]) >= maxCapacity)) then

        if noEvent(setCapacity > (maxCapacity-1)) then
          content.u[1] := 0;
          content.u[2] := 0;
          performative.u[1] := 17;
          Modelica.Utilities.Streams.print("ColdProducerAgent "+ String(name)+ " refuses proposal due to maximum capacity.");
        else
          totalRequest := maxCapacity;
          calcCapacity := totalRequest;
          calc_active := true;
          costNew := calcCost;
          content.u[2] := maxCapacity - setCapacity;
          performative.u[1] := 13; //propose
          costDifference := costNew - costCurrent;
          content.u[1] :=  costDifference;
          Modelica.Utilities.Streams.print("ColdProducerAgent "+ String(name)+ " proposes adjustment of " + String(content.u[2]) + " W " + "for a price of "+String(content.u[1])+".");
        end if;

      else
        totalRequest := setCapacity+get_content.y[1];
        calcCapacity := totalRequest;
        calc_active := true;
        costNew := calcCost;
        content.u[2] := get_content.y[1];
        performative.u[1] := 13; //propose
        costDifference := costNew - costCurrent;
        content.u[1] :=  costDifference;
        Modelica.Utilities.Streams.print("ColdProducerAgent "+ String(name)+ " proposes adjustment of " + String(content.u[2]) + " W " + "for a price of "+String(content.u[1])+".");

      end if;

    else

      if noEvent(((setCapacity+get_content.y[1]) <= minCapacityInternal)) then
        if noEvent(setCapacity < minCapacityInternal+10) then
          totalRequest := 0;
          calcCapacity := 0;
          calc_active := true;
          costNew := calcCost;
          content.u[2] := 0;
          performative.u[1] := 17; //refuse
          content.u[1] := 0;
          Modelica.Utilities.Streams.print("ColdProducerAgent "+ String(name)+ " refuses proposal due to minimum capacity.");
        else

          totalRequest := 0;
          calcCapacity := totalRequest;
          calc_active := true;
          costNew := calcCost;
          content.u[2] := minCapacityInternal - setCapacity;
          performative.u[1] := 13; //propose
          costDifference := costNew - costCurrent;
          content.u[1] :=  costDifference;
          Modelica.Utilities.Streams.print("ColdProducerAgent "+ String(name)+ " proposes adjustment of " + String(content.u[2]) + " W " + "for a price of "+String(content.u[1])+".");
        end if;

      else
        totalRequest := setCapacity+get_content.y[1];
        calcCapacity := totalRequest;
        calc_active := true;
        costNew := calcCost;
        content.u[2] := get_content.y[1];
        performative.u[1] := 13; //propose
        costDifference := costNew - costCurrent;
        content.u[1] :=  costDifference;
        Modelica.Utilities.Streams.print("ColdProducerAgent "+ String(name)+ " proposes adjustment of " + String(content.u[2]) + " W " + "for a price of "+String(content.u[1])+".");
      end if;

    end if;

    uDPSend_adapted.receiver := getsender.y[1];
    receiver.u[1] := getsender.y[1];
    ontology.u[1] := 1;
    reply_to.u[1] := name;
    sender.u[1] :=name;
    messageID.u[1] := name*name + integer(time);

    calc_active := false;

  end when;

// Adjust heat according to the confirmation by the broker, send confirmation
  when noEvent(adjustHeat.active) then

    setCapacity := setCapacity + get_content.y[1];
    setCapacityOut :=setCapacity;
    content.u[1] := 0;
    content.u[2] := 0;
    performative.u[1] := 5; //"confirm"

    uDPSend_adapted.receiver := getsender.y[1];
    receiver.u[1] := getsender.y[1];
    ontology.u[1] := 1;
    reply_to.u[1] := name;
    sender.u[1] :=name;
    messageID.u[1] := name*name + integer(time);
    Modelica.Utilities.Streams.print("ColdProducerAgent "+ String(name)+ " confirms the adjustment of " + String(get_content.y[1]) + " W of heat. The setpoint is now " + String(setCapacity) +"W.");

  end when;

// Confirm the receiving of the reject
  when noEvent(confirm.active) then
    uDPSend_adapted.receiver := getsender.y[1];
    receiver.u[1] := getsender.y[1];
    performative.u[1] := 5;
    sender.u[1] :=name;
    content.u[1] := 0;
    content.u[2] := 0;

  end when;

// Send out "not understood" message, if message has unknown performative
  when noEvent(composeNotUnderstood.active) then
    performative.u[1] := 11; //"not understood"
    content.u[1] := 0;
    content.u[2] := 0;
    messageID.u[1] := name*name + integer(time);
  end when;



equation
  connect(transition2.outPort, sendConfirmation.inPort[1]) annotation (Line(
      points={{3.5,30},{14,30},{14,30.5},{25,30.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sendConfirmation.outPort[1], transition5.inPort) annotation (Line(
      points={{46.5,30},{78,30}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition5.outPort, waiting.inPort[2]) annotation (Line(
      points={{83.5,30},{104,30},{104,-172},{-148,-172},{-148,-107.75},{
          -141,-107.75}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(send, or2.y) annotation (Line(
      points={{160,-184},{155,-184}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(or2.u2, or1.y) annotation (Line(
      points={{132,-192},{125,-192},{125,-184}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sendNotUnderstood.active, or2.u1) annotation (Line(
      points={{52,-57},{52,-58},{128,-58},{128,-184},{132,-184}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sendConfirmation.active, or1.u1) annotation (Line(
      points={{36,19},{36,12},{130,12},{130,-128},{96,-128},{96,-184},{102,-184}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(sendProposal.active, or1.u2) annotation (Line(
      points={{86,85},{86,74},{132,74},{132,-130},{94,-130},{94,-192},{102,-192}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(confirm.inPort[1], transitionWithSignal2.outPort) annotation (Line(
      points={{-39,-16},{-66,-16},{-66,-8},{-74.5,-8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition6.inPort, confirm.outPort[1]) annotation (Line(
      points={{-2,-16},{-17.5,-16}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition6.outPort, sendConfirmation.inPort[2]) annotation (Line(
      points={{3.5,-16},{18,-16},{18,29.5},{25,29.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition4.outPort, waiting.inPort[1]) annotation (Line(
      points={{93.5,-46},{104,-46},{104,-172},{-148,-172},{-148,-107.25},{
          -141,-107.25}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(calcCapacity, calcCapacity) annotation (Line(
      points={{-90,198},{-90,198},{-90,198}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(not2.u, OnOff_external) annotation (Line(points={{-185,-189},{
          -188,-189},{-188,-190},{-192,-190},{-192,-110},{-200,-110}},
                                    color={255,0,255}));
  connect(Off.inPort, waiting.outPort[2]) annotation (Line(points={{-86,
          -154},{-112,-154},{-112,-154},{-112,-108.25},{-119.5,-108.25}},
                                                              color={0,0,0}));
  connect(Off.outPort, shutDown.inPort[1]) annotation (Line(points={{-80.5,-154},
          {-57,-154}},            color={0,0,0}));
  connect(shutDown.outPort[1], transition7.inPort) annotation (Line(points={{-35.5,
          -153.75},{-28.75,-153.75},{-28.75,-154},{-20,-154}}, color={0,0,0}));
  connect(transition7.outPort, waiting.inPort[3]) annotation (Line(points={{-14.5,
          -154},{18,-154},{18,-172},{-148,-172},{-148,-108.25},{-141,
          -108.25}},
        color={0,0,0}));
  connect(not2.y, and1.u1) annotation (Line(points={{-173.5,-189},{-124,
          -189},{-124,-186},{-120,-186},{-120,-188},{-116,-188}},
                              color={255,0,255}));
  connect(and1.y, Off.condition) annotation (Line(points={{-93,-188},{-82,
          -188},{-82,-166}},
                       color={255,0,255}));
  connect(booleanExpression4.y, and1.u2) annotation (Line(points={{-129,
          -196},{-124,-196},{-116,-196}},
                              color={255,0,255}));
  connect(reset.inPort, sendProposal.outPort[3]) annotation (Line(
      points={{14,-106},{120,-106},{120,95.6667},{96.5,95.6667}},
      color={255,0,0},
      pattern=LinePattern.Dot));
  connect(reset.outPort, waiting.inPort[4]) annotation (Line(
      points={{8.5,-106},{-14,-106},{-14,-126},{-142,-126},{-142,-114},{
          -142,-108.75},{-141,-108.75}},
      color={255,0,0},
      pattern=LinePattern.Dot));
  connect(minCapacityInput, zeroOrderHold.u)
    annotation (Line(points={{-200,-76},{-176,-76}}, color={0,0,127}));

  if  maxCapacityExternal then
    connect(minCapacityInput, zeroOrderHold.u) annotation (Line(points={{-200,
            -76},{-194,-76},{-194,-76},{-176,-76}},
                                                color={0,0,127}));
  else
    zeroOrderHold.u = 0;
  end if;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -200},{200,200}}), graphics={
        Rectangle(
          extent={{-26,-82},{114,-130}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={206,101,103},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{20,-92},{96,-106}},
          lineColor={0,0,0},
          fillColor={255,170,213},
          fillPattern=FillPattern.Solid,
          fontSize=13,
          textString="Reset"),
        Rectangle(
          extent={{-142,-30},{114,-82}},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-142,10},{114,-30}},
          fillColor={255,170,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-142,64},{114,10}},
          fillColor={170,255,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-142,140},{114,64}},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Text(
          extent={{-58,134},{46,120}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          fontSize=12,
          textString="Compute Proposal"),
        Text(
          extent={{-58,62},{46,48}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          fontSize=12,
          textString="Proposal Accepted"),
        Text(
          extent={{-58,10},{46,-4}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          fontSize=12,
          textString="Proposal Rejected"),
        Text(
          extent={{-56,-64},{48,-78}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          fontSize=12,
          textString="Message not understood")}),
                                          Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-98,64},{100,62}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid,
          textString="%name%"),
        Rectangle(
          extent={{-64,18},{68,-70}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,14},{64,-66}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-38,64},{-38,24}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,20},{0,-20}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={-38,44},
          rotation=90),
        Line(
          points={{-14,14},{14,-14}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={-38,44},
          rotation=90),
        Line(
          points={{14,14},{-14,-14}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={-38,44},
          rotation=90),
        Line(
          points={{32,42},{32,2}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,20},{0,-20}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={32,22},
          rotation=90),
        Line(
          points={{-14,14},{14,-14}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={32,22},
          rotation=90),
        Line(
          points={{14,14},{-14,-14}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={32,22},
          rotation=90),
        Line(
          points={{-16,6},{-16,-34}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,20},{0,-20}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={-16,-14},
          rotation=90),
        Line(
          points={{-14,14},{14,-14}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={-16,-14},
          rotation=90),
        Line(
          points={{14,14},{-14,-14}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={-16,-14},
          rotation=90)}),
    Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<ul>
  <li>This model is a producer agent which controls a cold producing
  device.
  </li>
  <li>It is based on communication via UDP and logic implemented with
  the help of the StateGraph Modelica library.
  </li>
  <li>It is used together with a broker-agent and at least one
  producer-agent.
  </li>
  <li>It requires a CostFunction component to compute a proposal.
  </li>
</ul>
<h4>
  <span style=\"color: #008000\">Concept</span>
</h4>
<p>
  The cold producer agent recives a call for proposal from the broker
  with a requested capacity adjustment. It makes a proposal with the
  help of a Cost function for the adjustment and sends it back to the
  broker. If the proposal is accepted, the agent confirms the
  adjustment and adjusts the capacity of the controlled device
  accordingly. The logic is implemented with the help of the StateGraph
  library. Communication is realized with the help of the DeviceDriver
  library and follows the language standards for multi-agent-systems
  set by the FIPA to the highest possible extend for Modelica models.
  The following figure shows the behaviour of the consumer agent. For
  further information please refer to the first reference.
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Controls/HVACAgentBasedControl/ProducerAgent.png\"
  alt=\"Producer agent\">
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
<p>
  <b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">Example
  Results</span></b>
</p>
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
  <li>November 2016, by Felix Bünning: Implemented variable minimum
  load
  </li>
  <li>October 2015, by Felix Bünning: Developed and implemented
  </li>
</ul>
</html>"));
end ColdProducerAgent;
