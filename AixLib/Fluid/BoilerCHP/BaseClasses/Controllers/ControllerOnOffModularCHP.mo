within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model ControllerOnOffModularCHP

  parameter
    AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
    CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
    "CHP engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
  parameter Modelica.Units.SI.Time startTimeChp=0
    "Start time for discontinous simulation tests to heat the Chp unit up to the prescribed return temperature";
  parameter Real modTab[:,2]=[0.0,0.8; 7200,0.8; 7200,0.93; 10800,0.93; 10800,
      0.62; 14400,0.62; 14400,0.8; 18000,0.8; 18000,0.0]
    "Table for unit modulation (time = first column; modulation factors = second column)";

  Modelica.Blocks.Logical.Timer timerIsOff
    annotation (Placement(transformation(extent={{-6,16},{8,30}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-32,16},{-18,30}})));
  Modelica.Blocks.Logical.LessThreshold declarationTime(threshold=7200)
    annotation (Placement(transformation(extent={{20,16},{34,30}})));
  Modelica.Blocks.Logical.Or pumpControl
    annotation (Placement(transformation(extent={{48,8},{64,24}})));
  AixLib.Controls.Interfaces.CHPControlBus modCHPConBus annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,0})));
  Modelica.Blocks.Sources.TimeTable modulationFactorControl(
                          startTime=startTimeChp, table=modTab)
    annotation (Placement(transformation(extent={{-10,-54},{10,-34}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
    annotation (Placement(transformation(extent={{-68,6},{-48,26}})));

equation
  connect(timerIsOff.u,not1. y)
    annotation (Line(points={{-7.4,23},{-17.3,23}},  color={255,0,255}));
  connect(timerIsOff.y,declarationTime. u)
    annotation (Line(points={{8.7,23},{18.6,23}}, color={0,0,127}));
  connect(declarationTime.y,pumpControl. u1) annotation (Line(points={{34.7,23},
          {38,23},{38,16},{46.4,16}},
                                    color={255,0,255}));
  connect(pumpControl.y, modCHPConBus.isOnPump) annotation (Line(points={{
          64.8,16},{82,16},{82,-0.1},{100.1,-0.1}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(modulationFactorControl.y, modCHPConBus.modFac) annotation (Line(
        points={{11,-44},{100.1,-44},{100.1,-0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(greaterThreshold.y, not1.u) annotation (Line(points={{-47,16},{-40,
          16},{-40,23},{-33.4,23}},
                              color={255,0,255}));
  connect(pumpControl.u2, not1.u) annotation (Line(points={{46.4,9.6},{-40,
          9.6},{-40,23},{-33.4,23}},color={255,0,255}));
  connect(greaterThreshold.y, modCHPConBus.isOn) annotation (Line(points={{
          -47,16},{-40,16},{-40,0},{92,0},{92,-0.1},{100.1,-0.1}}, color={255,
          0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(greaterThreshold.u, modulationFactorControl.y) annotation (Line(
        points={{-70,16},{-82,16},{-82,-16},{38,-16},{38,-44},{11,-44}},
                                                                       color={0,
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
CHP")}),
       Documentation(info="<html><p>
  Model of an easy on-off-controller for the modular CHP model.
</p>
<p>
  It allows to manually modulate the load of the power unit. A
  modulation factor (modFac) of 0 indicates that the machine is not in
  operation.
</p>
<ul>
  <li>
    <i>April, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/667\">#667</a>)
  </li>
</ul>
</html>"));
end ControllerOnOffModularCHP;
