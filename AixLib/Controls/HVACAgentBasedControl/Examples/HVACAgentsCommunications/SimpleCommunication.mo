within AixLib.Controls.HVACAgentBasedControl.Examples.HVACAgentsCommunications;
model SimpleCommunication
  extends Modelica.Icons.Example;

  Agents.ConsumerAgent roomAgent_C(broker=20001, sampleTrigger(period=100))
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  Modelica.Blocks.Sources.TimeTable timeTable(table=[0.0,5000; 20,5000; 30,
        5000; 50,5000; 70,5000; 90,5000])
    annotation (Placement(transformation(extent={{-82,-82},{-62,-62}})));
  Agents.Broker broker_LTC(name=20001, startTable=[30001,0,0,0,0,0,0; 30002,0,
        0,0,0,0,0])
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Agents.IntermediateAgent   intermediateAgent_C(name=30001, broker=40001,
    setCapacity(start=3000))
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  Agents.Broker broker_HTC(name=40001, startTable=[40002,0,0,0,0,0,0; 40003,0,
        0,0,0,0,0])
    annotation (Placement(transformation(extent={{-20,22},{0,42}})));
  Agents.HeatProducerAgent heatProducerAgent(setCapacity(start=3000), name=40002)
    annotation (Placement(transformation(extent={{-20,58},{0,78}})));
  Agents.HeatProducerAgent heatProducerAgent1(
    name=30002,
    setCapacity(start=1000),
    maxCapacity=2000)
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));
  Agents.HeatProducerAgent heatProducerAgent2(name=40003, setCapacity(start=4000))
    annotation (Placement(transformation(extent={{60,58},{80,78}})));
  Modelica.Blocks.Sources.BooleanExpression onOff(y=true)
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  Modelica.Blocks.Sources.RealExpression cost(y=100)
    annotation (Placement(transformation(extent={{-90,2},{-70,22}})));
  Modelica.Blocks.Sources.RealExpression capacity(y=1)
    annotation (Placement(transformation(extent={{-92,-42},{-72,-22}})));
  inner Agents.MessageNotification messageNotification
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  AixLib.Controls.HVACAgentBasedControl.CostFunctions.Economic.Constant_Economic_Cost constantFactor(p=1, eta=1)
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  AixLib.Controls.HVACAgentBasedControl.CostFunctions.Economic.Constant_Economic_Cost constantFactor1(eta=1, p=2)
    annotation (Placement(transformation(extent={{60,80},{80,100}})));
  AixLib.Controls.HVACAgentBasedControl.CostFunctions.Economic.Constant_Economic_Cost constantFactor2(eta=1, p=0.5)
    annotation (Placement(transformation(extent={{60,2},{80,22}})));
equation
  connect(onOff.y, heatProducerAgent.OnOff_external) annotation (Line(points={{-69,30},
          {-34,30},{-34,64.6},{-18,64.6}},          color={255,0,255}));
  connect(onOff.y, intermediateAgent_C.OnOff_external) annotation (Line(
        points={{-69,30},{-34,30},{-34,28},{-34,-13.4},{-18,-13.4}}, color={255,
          0,255}));
  connect(onOff.y, heatProducerAgent1.OnOff_external) annotation (Line(points=
         {{-69,30},{-34,30},{-34,26},{-34,-26},{50,-26},{50,-13.4},{62,-13.4}},
        color={255,0,255}));
  connect(cost.y, intermediateAgent_C.calcCost)
    annotation (Line(points={{-69,12},{-4,12},{-4,-2}}, color={0,0,127}));
  connect(capacity.y, intermediateAgent_C.currentCapacity) annotation (Line(
        points={{-71,-32},{-18,-32},{-18,-18}}, color={0,0,127}));
  connect(capacity.y, heatProducerAgent1.currentCapacity) annotation (Line(
        points={{-71,-32},{-71,-32},{62,-32},{62,-18}}, color={0,0,127}));
  connect(capacity.y, heatProducerAgent2.currentCapacity) annotation (Line(
        points={{-71,-32},{18,-32},{18,56},{62,56},{62,60}}, color={0,0,127}));
  connect(heatProducerAgent.currentCapacity, heatProducerAgent2.currentCapacity)
    annotation (Line(points={{-18,60},{-18,56},{62,56},{62,60}}, color={0,0,
          127}));
  connect(timeTable.y, roomAgent_C.demand) annotation (Line(points={{-61,-72},
          {-36,-72},{-14.6,-72},{-14.6,-82}},                color={0,0,127}));
  connect(onOff.y, heatProducerAgent2.OnOff_external) annotation (Line(points={{-69,30},
          {-24,30},{-24,50},{16,50},{16,64.6},{62,64.6}},          color={255,
          0,255}));
  connect(heatProducerAgent.calcCapacity, constantFactor.capacity)
    annotation (Line(points={{-16,77},{-16,79.5},{-16,82}}, color={0,0,127}));
  connect(heatProducerAgent.calcCost, constantFactor.cost)
    annotation (Line(points={{-4,76},{-4,81}}, color={0,0,127}));
  connect(heatProducerAgent2.calcCapacity, constantFactor1.capacity)
    annotation (Line(points={{64,77},{64,82}}, color={0,0,127}));
  connect(constantFactor1.cost, heatProducerAgent2.calcCost)
    annotation (Line(points={{76,81},{76,76}}, color={0,0,127}));
  connect(heatProducerAgent1.calcCapacity, constantFactor2.capacity)
    annotation (Line(points={{64,-1},{64,1.5},{64,4}}, color={0,0,127}));
  connect(heatProducerAgent1.calcCost, constantFactor2.cost)
    annotation (Line(points={{76,-2},{76,3}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics={
        Line(
          points={{-22,-88},{-48,-88},{-48,-14},{-22,-14}},
          color={0,0,255},
          smooth=Smooth.None,
          thickness=1),
        Line(
          points={{2,-14},{58,-14}},
          color={255,0,0},
          thickness=1,
          smooth=Smooth.None),
        Line(
          points={{82,-14},{92,-14},{92,-88},{2,-88}},
          color={255,0,0},
          thickness=1,
          smooth=Smooth.None),
        Line(
          points={{2,-2},{14,-2},{14,26},{92,26},{92,66},{82,66}},
          color={255,0,0},
          thickness=1,
          smooth=Smooth.None),
        Line(
          points={{58,66},{2,66}},
          color={255,0,0},
          thickness=1,
          smooth=Smooth.None),
        Line(
          points={{-22,-2},{-48,-2},{-48,66},{-22,66}},
          color={0,0,255},
          thickness=1,
          smooth=Smooth.None),
        Polygon(
          points={{-50,40},{-48,46},{-46,40},{-50,40}},
          lineColor={0,0,255},
          lineThickness=1,
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-50,-40},{-48,-34},{-46,-40},{-50,-40}},
          lineColor={0,0,255},
          lineThickness=1,
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{22,58},{86,20}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="High Temperature Circuit
"),     Text(
          extent={{-136,36},{-62,-52}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Heat exchanger acts as a
consumer in the High Temp Circuit
and as a producer in the
Low Temp Circuit"),
        Line(
          points={{-60,-10},{-26,-8}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{22,-36},{86,-74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Low Temperature Circuit
"),     Line(
          points={{-58,-8},{-60,-10},{-58,-12}},
          color={0,0,0},
          thickness=0.5)}),
    experiment(StopTime=500, Interval=100),
    __Dymola_experimentSetupOutput,
    Documentation(revisions="<html><ul>
  <li>October 2015, by Felix Bünning: Developed and implemented
  </li>
  <li>December 2016, by Roozbeh Sangi:<br/>
    revised
  </li>
</ul>
</html>",
      info="<html><p>
  <b><span style=
  \"font-family: MS Shell Dlg 2; color: #008000;\">Overview</span></b>
</p>
<ul>
  <li>
    <span style=\"font-family: MS Shell Dlg 2;\">This model is a an
    example to show the function of the HVAC Agents presented in this
    library</span>
  </li>
  <li>
    <span style=\"font-family: MS Shell Dlg 2;\">It acts as a prove that
    implementing functioning multi-agent systems on the basis of the
    Modelica language environment is possible.</span>
  </li>
</ul>
<p>
  <b><span style=
  \"font-family: MS Shell Dlg 2; color: #008000;\">Concept</span></b>
</p>
<p>
  <span style=\"font-family: MS Shell Dlg 2;\">The model consists of a
  consumer agent, two brokers, one intermediate agent and three
  producer agents. The model represents a heating system in which two
  circuits are interconnected via an heat exchanger. There is no real
  physical system implemented. The model, however, shows the
  communication of the agents with each other (see the log below). For
  further details, please refer to the reference.</span>
</p>
<p>
  <span style=\"font-family: MS Shell Dlg 2;\">The logic is implemented
  with the help of the StateGraph library. Communication is realized
  with the help of the DeviceDriver library and follows the language
  standards for multi-agent-systems set by the FIPA to the highest
  possible extend for Modelica models.</span>
</p>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<ul>
  <li>Felix Bünning. Development of a Modelica-library for agent-based
  control of HVAC systems. Bachelor thesis, 2016, RWTH Aachen
  University, Aachen, Germany.
  </li>
  <li>Roozbeh Sangi, Felix Bünning, Johannes Fütterer, Dirk Müller. A
  Platform for the Agent-based Control of HVAC Systems. Modelica
  Conference, 2017, Prague, Czech Republic.
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
  <li>ConsumerAgent 10001 requests 5000 W of heat from Broker 20001.
  </li>
  <li>Broker 20001 collected the request of 5000 W of heat from
  Consumer 10001.
  </li>
  <li>Broker 20001 calls for proposal of 5000 W of heat from Producer
  30001.
  </li>
  <li>IntermediateAgent 30001 got a call from bottom broker 20001 and
  passes it on to top broker 40001.
  </li>
  <li>Broker 40001 collected the request of 5000 W of heat from
  Consumer 30001.
  </li>
  <li>Broker 40001 calls for proposal of 5000 W of heat from Producer
  40002.
  </li>
  <li>HeatProducerAgent 40002 proposes adjustment of 5000 W for a price
  of 7960.
  </li>
  <li>Broker 40001 collects proposal of 5000 W of heat for the price of
  7960 from Producer 40002.
  </li>
  <li>Broker 40001 calls for proposal of 5000 W of heat from Producer
  40003.
  </li>
  <li>HeatProducerAgent 40003 proposes adjustment of 5000 W for a price
  of 17960.
  </li>
  <li>Broker 40001 collects proposal of 5000 W of heat for the price of
  17960 from Producer 40003.
  </li>
  <li>Broker 40001 calculates an average price of 1.592 per W of heat.
  </li>
  <li>Broker 40001 asks for a confirmation of 5000 W of heat for the
  total price of 7960 from Consumer 30001.
  </li>
  <li>IntermediateAgent 30001 got an information from top broker 40001
  and passes it on as a proposal to bottom broker 20001 after adding
  own costs of 100.
  </li>
  <li>Broker 20001 collects proposal of 5000 W of heat for the price of
  8060 from Producer 30001.
  </li>
  <li>Broker 20001 calls for proposal of 5000 W of heat from Producer
  30002.
  </li>
  <li>HeatProducerAgent 30002 proposes adjustment of 1000 W for a price
  of 960.
  </li>
  <li>Broker 20001 collects proposal of 1000 W of heat for the price of
  960 from Producer 30002.
  </li>
  <li>Broker 20001 calculates an average price of 1.4816 per W of heat.
  </li>
  <li>Broker 20001 asks for a confirmation of 5000 W of heat for the
  total price of 7408 from Consumer 10001.
  </li>
  <li>ConsumerAgent 10001 confirms the request of 5000 W of heat for a
  price of 7408.
  </li>
  <li>5000 W of heat were confirmed by consumers at broker 20001. Go on
  to final requests to producers.
  </li>
  <li>Broker 20001 accepts the proposal of 30001 and orders 4000 W of
  heat.
  </li>
  <li>IntermediateAgent 30001 got an accept proposal from 20001 and
  passes it on as a confirmation to top broker 40001.
  </li>
  <li>IntermediateAgent 30001 confirms the adjustment of 4000 W of
  heat.
  </li>
  <li>Broker 20001 accepts the proposal of 30002 and orders 1000 W of
  heat.
  </li>
  <li>4000 W of heat were confirmed by consumers at broker 40001. Go on
  to final requests to producers.
  </li>
  <li>Broker 40001 accepts the proposal of 40002 and orders 4000 W of
  heat.
  </li>
  <li>HeatProducerAgent 40002 confirms the adjustment of 4000 W of
  heat. The setpoint is now 7000W.
  </li>
  <li>HeatProducerAgent 30002 confirms the adjustment of 1000 W of
  heat. The setpoint is now 2000W.
  </li>
  <li>Broker 40001 rejects the proposal of 40003.
  </li>
</ul>
</html>"));
end SimpleCommunication;
