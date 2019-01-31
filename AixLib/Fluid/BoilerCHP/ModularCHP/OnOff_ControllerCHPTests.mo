within AixLib.Fluid.BoilerCHP.ModularCHP;
model OnOff_ControllerCHPTests

  parameter
    AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
    CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
    "CHP engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

  parameter Modelica.SIunits.Time startTimeChp=0
    "Start time for discontinous simulation tests to heat the Chp unit up to the prescribed return temperature";
  Modelica.Blocks.Logical.Timer timerIsOff
    annotation (Placement(transformation(extent={{-6,0},{8,14}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-32,0},{-18,14}})));
  Modelica.Blocks.Logical.LessThreshold declarationTime(threshold=7200)
    annotation (Placement(transformation(extent={{20,0},{34,14}})));
  Modelica.Blocks.Logical.Or pumpControl
    annotation (Placement(transformation(extent={{48,-8},{64,8}})));
  Controls.Interfaces.CHPControlBus modularCHPControlBus
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,0})));
  Modelica.Blocks.Sources.TimeTable modulationFactorControl(table=[0.0,0.75;
        7200,0.75; 7200,1; 10800,1; 10800,0.5; 14400,0.5; 14400,0.75; 18000,
        0.75; 18000,0.0], startTime=startTimeChp)
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
    annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
equation
  connect(timerIsOff.u,not1. y)
    annotation (Line(points={{-7.4,7},{-17.3,7}},    color={255,0,255}));
  connect(timerIsOff.y,declarationTime. u)
    annotation (Line(points={{8.7,7},{18.6,7}},   color={0,0,127}));
  connect(declarationTime.y,pumpControl. u1) annotation (Line(points={{34.7,7},
          {38,7},{38,0},{46.4,0}},  color={255,0,255}));
  connect(pumpControl.y, modularCHPControlBus.isOnPump) annotation (Line(points=
         {{64.8,0},{82,0},{82,-0.1},{100.1,-0.1}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(modulationFactorControl.y, modularCHPControlBus.modFac) annotation (
      Line(points={{11,-50},{100.1,-50},{100.1,-0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(greaterThreshold.y, not1.u) annotation (Line(points={{-47,0},{-40,0},
          {-40,7},{-33.4,7}}, color={255,0,255}));
  connect(pumpControl.u2, not1.u) annotation (Line(points={{46.4,-6.4},{-40,
          -6.4},{-40,7},{-33.4,7}}, color={255,0,255}));
  connect(greaterThreshold.y, modularCHPControlBus.isOn) annotation (Line(
        points={{-47,0},{-40,0},{-40,-16},{92,-16},{92,-0.1},{100.1,-0.1}},
        color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(greaterThreshold.u, modulationFactorControl.y) annotation (Line(
        points={{-70,0},{-82,0},{-82,-32},{38,-32},{38,-50},{11,-50}}, color={0,
          0,127}));
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
end OnOff_ControllerCHPTests;
