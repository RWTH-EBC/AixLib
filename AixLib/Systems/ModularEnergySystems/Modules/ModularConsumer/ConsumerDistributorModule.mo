within AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer;
model ConsumerDistributorModule
    extends
    AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.BaseClasses.ModularConsumer_base(
    T_Flow(unit="K"),
    T_Return(unit="K"),
    simpleConsumer(final T_start=T_start));
    extends AixLib.Fluid.Interfaces.PartialTwoPort(redeclare package Medium =
        MediumWater);

  Fluid.HeatExchangers.ActiveWalls.Distributor
    distributor(
    redeclare package Medium = Medium,
    final m_flow_nominal = sum(simpleConsumer.m_flow_nominal),
    n=n_consumers) annotation (
      Placement(transformation(
        extent={{-24,-24},{24,24}},
        rotation=90,
        origin={0,-50})));

  parameter Modelica.Media.Interfaces.Types.Temperature T_start[n_consumers]=fill(Medium.T_default, n_consumers)
    "Start value of temperature";
equation

  connect(port_a, distributor.mainFlow) annotation (Line(points={{-100,0},{-60,0},
          {-60,-80},{-12.8,-80},{-12.8,-74}}, color={0,127,255}));
  connect(distributor.mainReturn, port_b) annotation (Line(points={{12,-74},{12,
          -80},{60,-80},{60,0},{100,0}}, color={0,127,255}));
  connect(distributor.flowPorts, simpleConsumer.port_a) annotation (Line(points=
         {{-24,-50},{-40,-50},{-40,0},{-10,0}}, color={0,127,255}));
  connect(distributor.returnPorts, simpleConsumer.port_b) annotation (Line(points={{24.8,
          -50},{40,-50},{40,0},{10,0}},         color={0,127,255}));

   annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
                   Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Text(
          extent={{-56,18},{56,-18}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="CONSUMER [%n]")}),                         Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ConsumerDistributorModule;
