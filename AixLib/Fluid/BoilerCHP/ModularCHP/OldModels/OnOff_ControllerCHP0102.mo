within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
model OnOff_ControllerCHP0102
  import AixLib;

  parameter
    AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
    CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
    "CHP engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

  parameter Modelica.SIunits.Time startTimeChp=0
    "Start time for discontinous simulation tests to heat the Chp unit up to the prescribed return temperature";
  Modelica.Blocks.Sources.BooleanPulse cHPOnOffSwitch(
    period(displayUnit="h") = 86400,
    width=50,
    startTime(displayUnit="h") = startTimeChp)
              annotation (Placement(transformation(extent={{-68,-8},{-52,8}})));
  Modelica.Blocks.Logical.Timer timerIsOff
    annotation (Placement(transformation(extent={{-6,0},{8,14}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-32,0},{-18,14}})));
  Modelica.Blocks.Logical.LessThreshold declarationTime(threshold=2400)
    annotation (Placement(transformation(extent={{20,0},{34,14}})));
  Modelica.Blocks.Logical.Or pumpControl
    annotation (Placement(transformation(extent={{48,-8},{64,8}})));
  AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHPControlBus2702
    modularCHPControlBus annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,0})));
  Modelica.Blocks.Sources.Ramp rampModFac1stStep(
    height=0.25,
    duration=1,
    startTime=1800,
    offset=0.5)
    annotation (Placement(transformation(extent={{-20,70},{0,90}})));
  Modelica.Blocks.Logical.Switch switchModulationFactor
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Modelica.Blocks.Logical.LessEqual greater
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Utilities.Time.ModelTime modTim
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Sources.Ramp rampModFac2ndStep(
    height=0.25,
    duration=1,
    offset=0.75,
    startTime=3600)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Modelica.Blocks.Sources.RealExpression timeTo2ndStepModFac(y=3600)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  Modelica.Blocks.Sources.TimeTable modulationFactorControl(table=[0.0,0.75;
        7200,0.75; 7200,1; 10800,1; 10800,0.5; 14400,0.5; 14400,0.75; 18000,
        0.75; 18000,0.0], startTime=startTimeChp)
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
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
  connect(rampModFac1stStep.y, switchModulationFactor.u1) annotation (Line(
        points={{1,80},{10,80},{10,68},{18,68}},     color={0,0,127}));
  connect(greater.y, switchModulationFactor.u2)
    annotation (Line(points={{-39,60},{18,60}},   color={255,0,255}));
  connect(greater.u1, modTim.y) annotation (Line(points={{-62,60},{-70,60},{-70,
          70},{-79,70}},       color={0,0,127}));
  connect(rampModFac2ndStep.y, switchModulationFactor.u3) annotation (Line(
        points={{1,40},{10,40},{10,52},{18,52}},     color={0,0,127}));
  connect(greater.u2, timeTo2ndStepModFac.y) annotation (Line(points={{-62,52},{
          -70,52},{-70,40},{-79,40}},     color={0,0,127}));
  connect(pumpControl.y, modularCHPControlBus.isOnPump) annotation (Line(points=
         {{64.8,0},{82,0},{82,-0.1},{100.1,-0.1}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(switchModulationFactor.y, modularCHPControlBus.modFac) annotation (
      Line(points={{41,60},{100.1,60},{100.1,-0.1}}, color={0,0,127}), Text(
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
end OnOff_ControllerCHP0102;
