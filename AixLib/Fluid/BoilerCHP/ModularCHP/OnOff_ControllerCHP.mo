within AixLib.Fluid.BoilerCHP.ModularCHP;
model OnOff_ControllerCHP


  parameter
    AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
    CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
    "CHP engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

  Modelica.Blocks.Sources.BooleanPulse cHPOnOffSwitch(
    startTime(displayUnit="h") = 0,
    period(displayUnit="h") = 86400,
    width=50) annotation (Placement(transformation(extent={{-68,-8},{-52,8}})));
  Modelica.Blocks.Logical.Timer timerIsOff
    annotation (Placement(transformation(extent={{-6,0},{8,14}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-32,0},{-18,14}})));
  Modelica.Blocks.Logical.LessThreshold declarationTime(threshold=2400)
    annotation (Placement(transformation(extent={{20,0},{34,14}})));
  Modelica.Blocks.Logical.Or pumpControl
    annotation (Placement(transformation(extent={{48,-8},{64,8}})));
  Controls.Interfaces.CHPControlBus modularCHPControlBus
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,0})));
  Modelica.Blocks.Sources.Ramp rampModFac1stStep(
    height=0.25,
    duration=1,
    startTime=1800,
    offset=0.5)
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Blocks.Logical.Switch switchModulationFactor
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  Modelica.Blocks.Logical.LessEqual greater
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Utilities.Time.ModelTime modTim
    annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  Modelica.Blocks.Sources.Ramp rampModFac2ndStep(
    height=0.25,
    duration=1,
    offset=0.75,
    startTime=3600)
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  Modelica.Blocks.Sources.RealExpression timeTo2ndStepModFac(y=3600)
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Sources.Ramp rampVol1stStep(
    height=0.25,
    duration=1,
    startTime=1800,
    offset=0.5)
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  Modelica.Blocks.Logical.Switch switchVolumeFlowCoolant
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Modelica.Blocks.Logical.LessEqual greater1
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Utilities.Time.ModelTime modTim1
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
  Modelica.Blocks.Sources.Ramp rampVol2ndStep(
    height=0.25,
    duration=1,
    offset=0.75,
    startTime=3600)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Sources.RealExpression timeTo2ndStepVol(y=3600)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
equation
  connect(timerIsOff.u,not1. y)
    annotation (Line(points={{-7.4,7},{-17.3,7}},    color={255,0,255}));
  connect(timerIsOff.y,declarationTime. u)
    annotation (Line(points={{8.7,7},{18.6,7}},   color={0,0,127}));
  connect(declarationTime.y,pumpControl. u1) annotation (Line(points={{34.7,7},
          {38,7},{38,0},{46.4,0}},  color={255,0,255}));
  connect(cHPOnOffSwitch.y, not1.u) annotation (Line(points={{-51.2,0},{-42,0},{
          -42,7},{-33.4,7}}, color={255,0,255}));
  connect(cHPOnOffSwitch.y, pumpControl.u2) annotation (Line(points={{-51.2,0},{
          -42,0},{-42,-6.4},{46.4,-6.4}}, color={255,0,255}));
  connect(cHPOnOffSwitch.y, modularCHPControlBus.isOn) annotation (Line(points={
          {-51.2,0},{-42,0},{-42,-18},{80,-18},{80,-0.1},{100.1,-0.1}}, color={255,
          0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(switchModulationFactor.y, modularCHPControlBus.modFac) annotation (
      Line(points={{41,-70},{100.1,-70},{100.1,-0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(rampModFac1stStep.y, switchModulationFactor.u1) annotation (Line(
        points={{1,-50},{10,-50},{10,-62},{18,-62}}, color={0,0,127}));
  connect(greater.y, switchModulationFactor.u2)
    annotation (Line(points={{-39,-70},{18,-70}}, color={255,0,255}));
  connect(greater.u1, modTim.y) annotation (Line(points={{-62,-70},{-70,-70},{
          -70,-60},{-79,-60}}, color={0,0,127}));
  connect(rampModFac2ndStep.y, switchModulationFactor.u3) annotation (Line(
        points={{1,-90},{10,-90},{10,-78},{18,-78}}, color={0,0,127}));
  connect(greater.u2, timeTo2ndStepModFac.y) annotation (Line(points={{-62,-78},
          {-70,-78},{-70,-90},{-79,-90}}, color={0,0,127}));
  connect(rampVol1stStep.y, switchVolumeFlowCoolant.u1)
    annotation (Line(points={{1,90},{6,90},{6,78},{18,78}}, color={0,0,127}));
  connect(greater1.y, switchVolumeFlowCoolant.u2) annotation (Line(points={{-39,
          70},{-22,70},{-22,70},{-4,70},{-4,70},{18,70}}, color={255,0,255}));
  connect(greater1.u1, modTim1.y) annotation (Line(points={{-62,70},{-68,70},{-68,
          80},{-72,80},{-72,80},{-79,80}}, color={0,0,127}));
  connect(rampVol2ndStep.y, switchVolumeFlowCoolant.u3)
    annotation (Line(points={{1,50},{6,50},{6,62},{18,62}}, color={0,0,127}));
  connect(greater1.u2, timeTo2ndStepVol.y) annotation (Line(points={{-62,62},{-68,
          62},{-68,50},{-79,50}}, color={0,0,127}));
  connect(pumpControl.y, modularCHPControlBus.isOnPump) annotation (Line(points=
         {{64.8,0},{82,0},{82,-0.1},{100.1,-0.1}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
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
