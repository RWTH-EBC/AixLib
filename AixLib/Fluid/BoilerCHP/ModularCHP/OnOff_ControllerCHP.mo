within AixLib.Fluid.BoilerCHP.ModularCHP;
model OnOff_ControllerCHP
  Modelica.Blocks.Sources.BooleanPulse cHPIsOnOff(
    startTime(displayUnit="h") = 0,
    period(displayUnit="h") = 86400,
    width=50) annotation (Placement(transformation(extent={{-62,-8},{-46,8}})));
  Modelica.Blocks.Logical.Timer timerIsOff
    annotation (Placement(transformation(extent={{-6,0},{8,14}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-32,0},{-18,14}})));
  Modelica.Blocks.Logical.LessThreshold declarationTime(threshold=2400)
    annotation (Placement(transformation(extent={{20,0},{34,14}})));
  Modelica.Blocks.Logical.Or pumpControl
    annotation (Placement(transformation(extent={{48,-8},{64,8}})));
  Controls.Interfaces.CHPControlBus modularCHPControlBus annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,0})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=0.25,
    duration=1,
    startTime=1800,
    offset=0.5)
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  Modelica.Blocks.Logical.LessEqual greater
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Utilities.Time.ModelTime modTim
    annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=0.25,
    duration=1,
    offset=0.75,
    startTime=3600)
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=3600)
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
equation
  connect(timerIsOff.u,not1. y)
    annotation (Line(points={{-7.4,7},{-17.3,7}},    color={255,0,255}));
  connect(timerIsOff.y,declarationTime. u)
    annotation (Line(points={{8.7,7},{18.6,7}},   color={0,0,127}));
  connect(declarationTime.y,pumpControl. u1) annotation (Line(points={{34.7,7},
          {38,7},{38,0},{46.4,0}},  color={255,0,255}));
  connect(cHPIsOnOff.y, not1.u) annotation (Line(points={{-45.2,0},{-42,0},{-42,
          7},{-33.4,7}}, color={255,0,255}));
  connect(cHPIsOnOff.y, pumpControl.u2) annotation (Line(points={{-45.2,0},{-42,
          0},{-42,-6.4},{46.4,-6.4}}, color={255,0,255}));
  connect(cHPIsOnOff.y, modularCHPControlBus.isOn) annotation (Line(points={{
          -45.2,0},{-42,0},{-42,-18},{80,-18},{80,-0.1},{100.1,-0.1}}, color={
          255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(switch1.y, modularCHPControlBus.modFac) annotation (Line(points={{41,
          -70},{100.1,-70},{100.1,-0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(ramp.y, switch1.u1) annotation (Line(points={{1,-50},{10,-50},{10,-62},
          {18,-62}}, color={0,0,127}));
  connect(greater.y, switch1.u2)
    annotation (Line(points={{-39,-70},{18,-70}}, color={255,0,255}));
  connect(greater.u1, modTim.y) annotation (Line(points={{-62,-70},{-70,-70},{
          -70,-60},{-79,-60}}, color={0,0,127}));
  connect(ramp1.y, switch1.u3) annotation (Line(points={{1,-90},{10,-90},{10,
          -78},{18,-78}}, color={0,0,127}));
  connect(greater.u2, realExpression.y) annotation (Line(points={{-62,-78},{-70,
          -78},{-70,-90},{-79,-90}}, color={0,0,127}));
  annotation (Icon(graphics={
      Rectangle(
        extent={{-100,100},{100,-100}},
        lineColor={95,95,95},
        lineThickness=0.5,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid), Text(
          extent={{-86,18},{82,-8}},
          lineColor={28,108,200},
          textString="onOff
Controller
CHP")}));
end OnOff_ControllerCHP;
