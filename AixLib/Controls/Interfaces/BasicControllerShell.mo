within AixLib.Controls.Interfaces;
model BasicControllerShell
  "Base model for controller with bus connectors"

  BasicPriorityControllerBus
                           ExternalBus "Bus to higher level"
    annotation (Placement(transformation(extent={{-20,78},{20,118}})));
  BasicPriorityControllerBus
                           InternalBus "Bus to physical level"
    annotation (Placement(transformation(extent={{-20,-122},{20,-82}})));
  TestSwitchVectorBus testSwitchVectorBus(n=3)
    annotation (Placement(transformation(extent={{-10,-78},{10,-58}})));
  TestSwitchVectorBusOpposite testSwitchVectorBusOpposite(n=3)
    annotation (Placement(transformation(extent={{-10,48},{10,68}})));
  SimpleBasicPriorityController simpleBasicPriorityController(priogain=1)
    annotation (Placement(transformation(extent={{-58,2},{-38,22}})));
  SimpleBasicPriorityController simpleBasicPriorityController1(priogain=10)
    annotation (Placement(transformation(extent={{-4,0},{16,20}})));
  SimpleBasicPriorityController simpleBasicPriorityController2(priogain=7)
    annotation (Placement(transformation(extent={{56,0},{76,20}})));
  Modelica.Blocks.Interfaces.IntegerInput u1
    annotation (Placement(transformation(extent={{-94,82},{-54,122}})));
equation
  connect(testSwitchVectorBus.signalBus, InternalBus) annotation (Line(
      points={{0,-78},{0,-102}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(testSwitchVectorBusOpposite.signalBus, ExternalBus) annotation (Line(
      points={{0,67.8},{0,98}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(simpleBasicPriorityController.basicPriorityControllerBus2,
    testSwitchVectorBus.signalBusVector[1]) annotation (Line(
      points={{-48,2.1},{-24,2.1},{-24,-59.7333},{0,-59.7333}},
      color={255,204,51},
      thickness=0.5));
  connect(simpleBasicPriorityController.basicPriorityControllerBus,
    testSwitchVectorBusOpposite.signalBusVector[1]) annotation (Line(
      points={{-48,21.7},{-24,21.7},{-24,46.6667},{0.2,46.6667}},
      color={255,204,51},
      thickness=0.5));
  connect(testSwitchVectorBusOpposite.u, u1) annotation (Line(points={{-7.6,68},
          {-7.6,90},{-74,90},{-74,102}}, color={255,127,0}));
  connect(testSwitchVectorBusOpposite.signalBusVector[2],
    simpleBasicPriorityController1.basicPriorityControllerBus) annotation (Line(
      points={{0.2,48},{4,48},{4,19.7},{6,19.7}},
      color={255,204,51},
      thickness=0.5));
  connect(simpleBasicPriorityController1.basicPriorityControllerBus2,
    testSwitchVectorBus.signalBusVector[2]) annotation (Line(
      points={{6,0.1},{4,0.1},{4,-58.4},{0,-58.4}},
      color={255,204,51},
      thickness=0.5));
  connect(testSwitchVectorBusOpposite.signalBusVector[3],
    simpleBasicPriorityController2.basicPriorityControllerBus) annotation (Line(
      points={{0.2,49.3333},{34,49.3333},{34,19.7},{66,19.7}},
      color={255,204,51},
      thickness=0.5));
  connect(simpleBasicPriorityController2.basicPriorityControllerBus2,
    testSwitchVectorBus.signalBusVector[3]) annotation (Line(
      points={{66,0.1},{34,0.1},{34,-57.0667},{0,-57.0667}},
      color={255,204,51},
      thickness=0.5));
  connect(u1, testSwitchVectorBus.u) annotation (Line(points={{-74,102},{-70,
          102},{-70,-76},{-7.6,-76},{-7.6,-58}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,50},{76,-8}},
          lineColor={0,0,0},
          fillColor={134,176,68},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Text(
          extent={{-72,38},{62,8}},
          lineColor={54,86,37},
          fillColor={0,216,108},
          fillPattern=FillPattern.Solid,
          textString="Controller"),
        Rectangle(
          extent={{-10,11},{10,-11}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          origin={1,-64},
          rotation=270),
        Polygon(
          points={{1,8},{-7,-6},{9,-6},{1,8}},
          lineColor={0,0,0},
          fillColor={79,79,79},
          fillPattern=FillPattern.Solid,
          origin={2,-63},
          rotation=180),
        Rectangle(
          extent={{22,-38},{42,-58}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{1,8},{-7,-6},{9,-6},{1,8}},
          lineColor={0,0,0},
          fillColor={79,79,79},
          fillPattern=FillPattern.Solid,
          origin={32,-47},
          rotation=270),
        Rectangle(
          extent={{-10,10},{10,-10}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          origin={-30,-48},
          rotation=180),
        Polygon(
          points={{1,8},{-7,-6},{9,-6},{1,8}},
          lineColor={0,0,0},
          fillColor={79,79,79},
          fillPattern=FillPattern.Solid,
          origin={-30,-49},
          rotation=90),
        Rectangle(
          extent={{-10,11},{10,-11}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          origin={1,-32},
          rotation=90),
        Polygon(
          points={{1,8},{-7,-6},{9,-6},{1,8}},
          lineColor={0,0,0},
          fillColor={79,79,79},
          fillPattern=FillPattern.Solid,
          origin={0,-33},
          rotation=360)}),                                       Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BasicControllerShell;
