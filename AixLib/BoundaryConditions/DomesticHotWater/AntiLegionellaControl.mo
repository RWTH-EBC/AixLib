within AixLib.BoundaryConditions.DomesticHotWater;
model AntiLegionellaControl "Control to avoid Legionella in the DHW"
  parameter Modelica.Media.Interfaces.Types.Temperature T_DHW
    "Constant TSet DHW output value";

  parameter Modelica.Units.SI.ThermodynamicTemperature TLegMin=333.15
    "Temperature at which the legionella in DWH dies";
  parameter Real percentageDeath=0.999 "Specify the percentage of legionella you want to kill. 100 Percent would be impossible, as the model is based on exponential growth/death";
  parameter Modelica.Units.SI.Time triggerEvery
    "Time passed before next disinfection. Each day would be 86400 s"
    annotation (Dialog(enable=weekly));
  parameter Boolean aux_for_desinfection = true "Use aux heater for desinfection";
  Modelica.Units.SI.Time minTimeAntLeg(displayUnit="min")=
    get_minTimeAntLeg_for_TLegMin(fitMinLegTime.y[1], percentageDeath)
    "Minimal duration of antilegionella control to ensure correct disinfection";
  function get_minTimeAntLeg_for_TLegMin
    input Modelica.Units.SI.Temperature timeAtNinetyPercent;
    input Real percentageDeath;
    output Modelica.Units.SI.Time minTimeAntLeg;
  algorithm
    minTimeAntLeg := log(1-percentageDeath) / log(1-0.9) * timeAtNinetyPercent * 3600;
  end get_minTimeAntLeg_for_TLegMin;
  Modelica.Blocks.Interfaces.RealOutput TSet_DHW
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput
                                  y "Set auxilliar heater to true"
    annotation (Placement(transformation(extent={{100,-68},{120,-48}})));
  AixLib.Utilities.Logical.SmoothSwitch switchTLeg
    "Switch to Legionalla control if needed"
    annotation (Placement(transformation(extent={{64,-6},{78,8}})));

  Modelica.Blocks.Sources.Constant constTLegMin(final k=TLegMin)
    "Temperature at which the legionella in DWH dies"
    annotation (Placement(transformation(extent={{-88,-84},{-70,-66}})));
  Modelica.Blocks.Logical.GreaterEqual
                               TConLessTLegMin
    "Compare if current TCon is smaller than the minimal TLeg"
    annotation (Placement(transformation(extent={{-80,-32},{-60,-12}})));
  Modelica.Blocks.Logical.Timer timeAntiLeg "Time in which legionella will die"
    annotation (Placement(transformation(extent={{-30,-32},{-10,-12}})));
  Modelica.Blocks.Logical.Greater
                               greaterThreshold
    annotation (Placement(transformation(extent={{4,-30},{18,-14}})));
  Modelica.Blocks.Logical.Pre pre1
    annotation (Placement(transformation(extent={{-54,-28},{-42,-16}})));
  Modelica.Blocks.MathInteger.TriggeredAdd triggeredAdd(
    use_reset=true,
    use_set=false,
    y_start=0)
              "See info of model for description"
    annotation (Placement(transformation(extent={{-20,22},{-8,34}})));
  Modelica.Blocks.Sources.IntegerConstant intConPluOne(final k=1)
    "Value for counting"
    annotation (Placement(transformation(extent={{-44,22},{-32,34}})));
  Modelica.Blocks.Math.IntegerToReal intToReal "Converts Integer to Real"
    annotation (Placement(transformation(extent={{2,22},{14,34}})));
  Modelica.Blocks.Logical.LessThreshold    lessThreshold(final threshold=1)
    "Checks if value is less than one"
    annotation (Placement(transformation(extent={{26,18},{46,38}})));

  Modelica.Blocks.Sources.BooleanExpression triggerControl(y=((time - t1) >
        triggerEvery))
    annotation (Placement(transformation(extent={{-48,-6},{-28,14}})));

  Modelica.Blocks.Logical.Not not2
    annotation (Placement(transformation(extent={{60,-56},{72,-44}})));

  Modelica.Blocks.Sources.RealExpression realExpression(y=minTimeAntLeg)
    annotation (Placement(transformation(extent={{-30,-58},{-10,-38}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{78,-64},{90,-52}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(final k=
        aux_for_desinfection)
    "Temperature at which the legionella in DWH dies"
    annotation (Placement(transformation(extent={{54,-92},{72,-74}})));
  Modelica.Blocks.Interfaces.RealInput TSetDHW
    "Connector of first Real input signal"
    annotation (Placement(transformation(extent={{-142,50},{-102,90}})));
  Modelica.Blocks.Interfaces.RealInput TLowest
    "Connector of first Real input signal"
    annotation (Placement(transformation(extent={{-138,-90},{-98,-50}})));
protected
  Modelica.Units.SI.Time t1 "Helper variable for control";
  Modelica.Units.NonSI.Temperature_degC TLegMinDegC=TLegMin - 273.15;
  Modelica.Blocks.Tables.CombiTable1Dv fitMinLegTime(table=[45.5505451608561,
        62.916073325099134; 48.78942881500426,7.736506444512433;
        51.23771705478529,1.7687971042538275; 53.542872526585,
        0.47986000155581393; 55.85049580472921,0.16470935490617822;
        58.450217615650374,0.07001663558934895; 62.20891102436398,
        0.028517297027731203; 65.03006236819671,0.017814514615367875;
        68.72055458338941,0.010893105323934898; 73.06411809575089,
        0.007255730019232521; 75.88841028402207,0.006114735966220416;
        78.13366536545968,0.005494625286920662], u={TLegMinDegC});

algorithm
  when greaterThreshold.y then
    t1 := time;
  end when;
equation
  connect(switchTLeg.u3, constTLegMin.y) annotation (Line(points={{62.6,-4.6},{52,
          -4.6},{52,-75},{-69.1,-75}},color={0,0,127}));
  connect(switchTLeg.y, TSet_DHW) annotation (Line(points={{78.7,1},{92,1},{92,0},
          {110,0}},            color={0,0,127}));
  connect(timeAntiLeg.u,pre1. y)
    annotation (Line(points={{-32,-22},{-41.4,-22}},
                                                 color={255,0,255}));
  connect(TConLessTLegMin.y,pre1. u)
    annotation (Line(points={{-59,-22},{-55.2,-22}},
                                                 color={255,0,255}));
  connect(greaterThreshold.y,triggeredAdd. reset) annotation (Line(points={{18.7,
          -22},{22,-22},{22,12},{-10.4,12},{-10.4,20.8}},color={255,0,255}));
  connect(intToReal.u,triggeredAdd. y)
    annotation (Line(points={{0.8,28},{-6.8,28}}, color={255,127,0}));
  connect(intConPluOne.y,triggeredAdd. u)
    annotation (Line(points={{-31.4,28},{-22.4,28}}, color={255,127,0}));
  connect(intToReal.y,lessThreshold. u) annotation (Line(points={{14.6,28},{24,28}},
                                color={0,0,127}));
  connect(constTLegMin.y, TConLessTLegMin.u2) annotation (Line(points={{-69.1,-75},
          {-50,-75},{-50,-50},{-100,-50},{-100,-30},{-82,-30}}, color={0,0,127}));
  connect(lessThreshold.y, switchTLeg.u2) annotation (Line(points={{47,28},{52,28},
          {52,1},{62.6,1}}, color={255,0,255}));
  connect(triggerControl.y, triggeredAdd.trigger) annotation (Line(points={{-27,
          4},{-17.6,4},{-17.6,20.8}}, color={255,0,255}));
  connect(lessThreshold.y, not2.u) annotation (Line(points={{47,28},{48,28},{48,
          -50},{58.8,-50}}, color={255,0,255}));
  connect(timeAntiLeg.y, greaterThreshold.u1)
    annotation (Line(points={{-9,-22},{2.6,-22}}, color={0,0,127}));
  connect(realExpression.y, greaterThreshold.u2) annotation (Line(points={{-9,-48},
          {-9,-38},{2.6,-38},{2.6,-28.4}}, color={0,0,127}));
  connect(not2.y, and1.u1) annotation (Line(points={{72.6,-50},{74,-50},{74,-58},
          {76.8,-58}}, color={255,0,255}));
  connect(y, and1.y)
    annotation (Line(points={{110,-58},{90.6,-58}}, color={255,0,255}));
  connect(booleanConstant.y, and1.u2) annotation (Line(points={{72.9,-83},{80,
          -83},{80,-62.8},{76.8,-62.8}}, color={255,0,255}));
  connect(switchTLeg.u1, TSetDHW) annotation (Line(points={{62.6,6.6},{62.6,70},
          {-122,70}}, color={0,0,127}));
  connect(TLowest, TConLessTLegMin.u1) annotation (Line(points={{-118,-70},{-90,
          -70},{-90,-22},{-82,-22}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                            Rectangle(
          extent={{-100,99.5},{100,-100}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillPattern=FillPattern.Solid,
          fillColor={255,255,170}),
        Ellipse(extent={{-80,98},{80,-62}}, lineColor={160,160,164},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(points={{0,98},{0,78}}, color={160,160,164}),
        Line(points={{80,18},{60,18}},
                                     color={160,160,164}),
        Line(points={{0,-62},{0,-42}}, color={160,160,164}),
        Line(points={{-80,18},{-60,18}},
                                       color={160,160,164}),
        Line(points={{37,88},{26,68}}, color={160,160,164}),
        Line(points={{70,56},{49,44}}, color={160,160,164}),
        Line(points={{71,-19},{52,-9}},  color={160,160,164}),
        Line(points={{39,-52},{29,-33}}, color={160,160,164}),
        Line(points={{-39,-52},{-29,-34}}, color={160,160,164}),
        Line(points={{-71,-19},{-50,-8}},  color={160,160,164}),
        Line(points={{-71,55},{-54,46}}, color={160,160,164}),
        Line(points={{-38,88},{-28,69}}, color={160,160,164}),
        Line(
          points={{0,18},{-50,68}},
          thickness=0.5),
        Line(
          points={{0,18},{40,18}},
          thickness=0.5),
        Line(
          points={{0,18},{0,86}},
          thickness=0.5,
          color={238,46,47}),
        Line(
          points={{0,18},{-18,-14}},
          thickness=0.5,
          color={238,46,47}),
        Text(
          extent={{-14,0},{72,-36}},
          lineColor={238,46,47},
          lineThickness=0.5,
          textString=DynamicSelect("%TLegMin K", String(TLegMin-273.15)+ "°C")),
        Text(
          extent={{-94,0},{56,-154}},
          lineColor={28,108,200},
          textString="Day of week: %trigWeekDay
Hour of Day: %trigHour",
          horizontalAlignment=TextAlignment.Left),
        Text(
          extent={{-104,146},{100,92}},
          lineColor={28,108,200},
          textString="%name")}),                                                           Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model represents the anti legionella control of a real heat pump. Based on a daily or weekly approach, the given supply temperature is raised above the minimal temperature required for the thermal desinfection (at least 60 &deg;C) for a given duration minTimeAntLeg.</p>
</html>", revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/IBPSA/issues/577\">#577</a>)
</li>
</ul>
</html>"));
end AntiLegionellaControl;
