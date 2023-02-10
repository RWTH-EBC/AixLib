within AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer;
model ConsumerDistributorModule
  extends
    AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.BaseClasses.ModularConsumer_base(
                    simpleConsumer(each allowFlowReversal=allowFlowReversal,
                                   final T_start=T_start));
    extends AixLib.Fluid.Interfaces.PartialTwoPort(redeclare package Medium =
        MediumWater);

  Fluid.HeatExchangers.ActiveWalls.Distributor
    distributor(
    redeclare package Medium = Medium,
    final m_flow_nominal = sum(simpleConsumer.m_flow_nominal),
    allowFlowReversal=allowFlowReversal,
    n=n_consumers) annotation (
      Placement(transformation(
        extent={{-24,-24},{24,24}},
        rotation=90,
        origin={6,0})));

  parameter Modelica.Media.Interfaces.Types.Temperature T_start[n_consumers]=fill(Medium.T_default, n_consumers)
    "Start value of temperature";
  Interfaces.ConsumerControlBus consumerControlBus(nConsumers=n_consumers)
                                                   annotation (Placement(
        transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={{
            -10,90},{10,110}})));
  Fluid.Sensors.TemperatureTwoPort senTFlow(
    allowFlowReversal=allowFlowReversal,
    redeclare package Medium = Medium,
    m_flow_nominal=sum(simpleConsumer.m_flow_nominal))
                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-64,-40})));
  Fluid.Sensors.TemperatureTwoPort senTReturn(
    allowFlowReversal=allowFlowReversal,
    redeclare package Medium = Medium,
    m_flow_nominal=sum(simpleConsumer.m_flow_nominal))
                     annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={62,-40})));
equation



  connect(distributor.flowPorts, simpleConsumer.port_a) annotation (Line(points={{-18,
          1.33227e-15},{-30,1.33227e-15},{-30,-69},{-20,-69}},
                                                color={0,127,255}));
  connect(distributor.returnPorts, simpleConsumer.port_b) annotation (Line(points={{30.8,
          -1.33227e-15},{42,-1.33227e-15},{42,-69},{18,-69}},
                                                color={0,127,255}));

  connect(consumerControlBus.TOutSet, simpleConsumer.TOutSet) annotation (Line(
      points={{0.05,100.05},{0,100.05},{0,38},{-58,38},{-58,-80.78},{-21.14,-80.78}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(consumerControlBus.TInSet, simpleConsumer.TInSet) annotation (Line(
      points={{0.05,100.05},{0,100.05},{0,38},{-58,38},{-58,-77.36},{-21.14,-77.36}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(consumerControlBus.TPrescribedSet, simpleConsumer.TPrescribedSet)
    annotation (Line(
      points={{0.05,100.05},{0,100.05},{0,38},{-58,38},{-58,-52.85},{-21.9,-52.85}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(consumerControlBus.Q_flowSet, simpleConsumer.Q_flowSet) annotation (
      Line(
      points={{0.05,100.05},{0.05,38},{-58,38},{-58,-59.12},{-21.52,-59.12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(consumerControlBus.TOutMea, simpleConsumer.TOutMea) annotation (Line(
      points={{0.05,100.05},{0.05,38},{32,38},{32,-76.22},{20.28,-76.22}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(consumerControlBus.Q_flowMea, simpleConsumer.Q_flowMea) annotation (
      Line(
      points={{0.05,100.05},{0.05,38},{32,38},{32,-79.64},{19.9,-79.64}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(consumerControlBus.TInMea, simpleConsumer.TInMea) annotation (Line(
      points={{0.05,100.05},{0.05,38},{32,38},{32,-73.18},{20.28,-73.18}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(port_a, senTFlow.port_a) annotation (Line(points={{-100,0},{-80,0},{-80,
          -40},{-74,-40}}, color={0,127,255}));
  connect(senTFlow.port_b, distributor.mainFlow) annotation (Line(points={{-54,-40},
          {-6.8,-40},{-6.8,-24}}, color={0,127,255}));
  connect(distributor.mainReturn, senTReturn.port_a)
    annotation (Line(points={{18,-24},{18,-40},{52,-40}}, color={0,127,255}));
  connect(senTReturn.port_b, port_b) annotation (Line(points={{72,-40},{80,-40},
          {80,0},{100,0}}, color={0,127,255}));
  connect(consumerControlBus.TOutDisMea, senTReturn.T) annotation (Line(
      points={{0.05,100.05},{0.05,38},{62,38},{62,-29}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(consumerControlBus.TInDisMea, senTFlow.T) annotation (Line(
      points={{0.05,100.05},{0.05,38},{-64,38},{-64,-29}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash),
        Polygon(
          points={{80,-240},{120,-255},{80,-270},{80,-240}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=not allowFlowReversal),
        Line(
          points={{115,-255},{0,-255}},
          color={0,128,255},
          visible=not allowFlowReversal),
        Polygon(
          points={{80,-294},{120,-309},{80,-324},{80,-294}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=not allowFlowReversal),
        Line(
          points={{115,-309},{0,-309}},
          color={0,128,255},
          visible=not allowFlowReversal),
        Rectangle(
          extent={{-70,70},{70,50}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-52,64},{-44,56}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-64,64},{-56,56}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-40,-40}},
          color={28,108,200},
          thickness=0.5),                Text(
          extent={{-62,-18},{58,-58}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="More than 3 consumers \n Total number of consumers: %n_consumers",
          visible=n_consumers > 3),
        Line(
          points={{-60,56},{-60,20},{-74,20},{-74,0},{-68,0},{-30,0},{-30,20},{-48,
              20},{-48,56}},
          color={28,108,200},
          thickness=0.5),
                   Ellipse(
          extent={{-68,16},{-38,-14}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{-64,12},{-42,-10}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360),                 Text(
          extent={{-80,-6},{-26,-34}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          fontSize=6,
          textString="CONS. 1"),
        Line(
          points={{-90,0},{-80,0},{-80,60},{-70,60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{90,0},{80,0},{80,60},{70,60}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-12,64},{-4,56}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          visible=n_consumers>=2),
        Ellipse(
          extent={{0,64},{8,56}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=n_consumers>=2),
        Ellipse(
          extent={{42,64},{50,56}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          visible=n_consumers>=3),
        Ellipse(
          extent={{54,64},{62,56}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=n_consumers>=3),
        Polygon(
          points={{3.45944,-4.54058},{-3.45944,-4.54058},{0,1.62164},{3.45944,-4.54058}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-60,42},
          rotation=180,
                      visible=hasFeedback[1]),
        Polygon(
          points={{3.37834,-3.64874},{3.37834,3.64874},{-3.37834,0},{3.37834,-3.64874}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid, visible=hasFeedback[1],
          origin={-60,36},
          rotation=270),
        Ellipse(
          extent={{-4,4},{4,-4}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid, visible=hasPump[1],
          origin={-74,10},
          rotation=270),
        Line(
          points={{3.83476e-17,1},{4,-3},{1.72997e-15,-7}},
          color={135,135,135},
          thickness=0.5, visible=hasPump[1],
          origin={-71,10},
          rotation=270),
        Line(
          points={{-48,40},{-54,40}},
          color={28,108,200},
          thickness=0.5,visible=hasFeedback[1]),
        Polygon(
          points={{3.45944,-4.54058},{-3.45944,-4.54058},{0,1.62164},{3.45944,-4.54058}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-58,40},
          rotation=90,visible=hasFeedback[1]),
        Line(
          points={{-8,56},{-8,20},{-22,20},{-22,0},{-16,0},{22,0},{22,20},{4,20},
              {4,56}},
          color={28,108,200},
          thickness=0.5,
          visible=n_consumers >= 2),
        Ellipse(
          extent={{-16,16},{14,-14}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          visible=n_consumers >= 2),
        Ellipse(
          extent={{-12,12},{10,-10}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360,
          visible=n_consumers >= 2),
        Polygon(
          points={{3.45944,-4.54058},{-3.45944,-4.54058},{0,1.62164},{3.45944,-4.54058}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-8,42},
          rotation=180,
          visible=n_consumers>=2 and (if size(hasFeedback,1)>= 2 then hasFeedback[2] else true)),
        Polygon(
          points={{3.37834,-3.64874},{3.37834,3.64874},{-3.37834,0},{3.37834,-3.64874}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={-8,36},
          rotation=270,
          visible=n_consumers>=2 and (if size(hasFeedback,1)>= 2 then hasFeedback[2] else true)),
        Ellipse(
          extent={{-4,4},{4,-4}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-22,10},
          rotation=270,
          visible=n_consumers >= 2 and (if size(hasPump, 1) >= 2 then hasPump[2]
               else true)),
        Line(
          points={{3.83476e-17,1},{4,-3},{1.72997e-15,-7}},
          color={135,135,135},
          thickness=0.5,
          origin={-19,10},
          rotation=270,
          visible=n_consumers>=2 and (if size(hasPump,1)>= 2 then hasPump[2] else true)),
        Line(
          points={{4,40},{-2,40}},
          color={28,108,200},
          thickness=0.5,
          visible=n_consumers>=2 and (if size(hasFeedback,1)>= 2 then hasFeedback[2] else true)),
        Polygon(
          points={{3.45944,-4.54058},{-3.45944,-4.54058},{0,1.62164},{3.45944,-4.54058}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-6,40},
          rotation=90,
          visible=n_consumers>=2 and (if size(hasFeedback,1)>= 2 then hasFeedback[2] else true)),
        Line(
          points={{46,56},{46,20},{32,20},{32,0},{38,0},{76,0},{76,20},{58,20},{
              58,56}},
          color={28,108,200},
          thickness=0.5,
          visible=n_consumers>=3),
        Ellipse(
          extent={{38,16},{68,-14}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          visible=n_consumers>=3),
        Ellipse(
          extent={{42,12},{64,-10}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360,
          visible=n_consumers>=3),
        Polygon(
          points={{3.45944,-4.54058},{-3.45944,-4.54058},{0,1.62164},{3.45944,-4.54058}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={46,42},
          rotation=180,
          visible=n_consumers>=3 and (if size(hasFeedback,1)>= 3 then hasFeedback[3] else true)),
        Polygon(
          points={{3.37834,-3.64874},{3.37834,3.64874},{-3.37834,0},{3.37834,-3.64874}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={46,36},
          rotation=270,
          visible=n_consumers>=3 and (if size(hasFeedback,1)>= 3 then hasFeedback[3] else true)),
        Ellipse(
          extent={{-4,4},{4,-4}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          visible=n_consumers>=3 and (if size(hasPump,1)>= 3 then hasPump[3] else true),
          origin={32,10},
          rotation=270),
        Line(
          points={{3.83476e-17,1},{4,-3},{1.72997e-15,-7}},
          color={135,135,135},
          thickness=0.5,
          visible=n_consumers>=3 and (if size(hasPump,1)>= 3 then hasPump[3] else true),
          origin={35,10},
          rotation=270),
        Line(
          points={{58,40},{52,40}},
          color={28,108,200},
          thickness=0.5,
          visible=n_consumers >= 3 and (if size(hasFeedback, 1) >= 3 then
              hasFeedback[3] else true)),
        Polygon(
          points={{3.45944,-4.54058},{-3.45944,-4.54058},{0,1.62164},{3.45944,-4.54058}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={48,40},
          rotation=90,
          visible=n_consumers>=3 and (if size(hasFeedback,1)>= 3 then hasFeedback[3] else true)),
        Text(
          extent={{-26,-6},{28,-34}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          fontSize=6,
          textString="CONS. 2",
          visible=n_consumers>=2),
        Text(
          extent={{26,-6},{80,-34}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          fontSize=6,
          textString="CONS. 3",
          visible=n_consumers>=3)}),
        Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ConsumerDistributorModule;
