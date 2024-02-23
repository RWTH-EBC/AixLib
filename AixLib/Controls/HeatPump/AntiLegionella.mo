within AixLib.Controls.HeatPump;
model AntiLegionella "Control to avoid Legionella in the DHW"

  parameter Modelica.Units.SI.ThermodynamicTemperature TLegMin=333.15
    "Temperature at which the legionella in DWH dies";

  parameter Modelica.Units.SI.Time minTimeAntLeg
    "Minimal duration of antilegionella control";
  parameter Boolean weekly=true
    "Switch between a daily or weekly trigger approach" annotation(Dialog(descriptionLabel=true), choices(choice=true "Weekly",
      choice=false "Daily",
      radioButtons=true));
  parameter Integer trigWeekDay "Day of the week at which control is triggered"
    annotation (Dialog(enable=weekly));
  parameter Integer trigHour "Hour of the day at which control is triggered";
  parameter AixLib.Utilities.Time.Types.ZeroTime zerTim
    "Enumeration for choosing how reference time (time = 0) should be defined";
  parameter Integer yearRef=2016 "Year when time = 0, used if zerTim=Custom";
  Modelica.Blocks.Logical.GreaterEqual
                               TConLessTLegMin
    "Compare if current TCon is smaller than the minimal TLeg"
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  AixLib.Utilities.Logical.SmoothSwitch switchTLeg
    "Switch to Legionalla control if needed"
    annotation (Placement(transformation(extent={{70,72},{84,86}})));
  Modelica.Blocks.Interfaces.RealOutput TSet_out
    "Set value for the condenser outlet temperature"
    annotation (Placement(transformation(extent={{100,66},{128,94}})));

  Modelica.Blocks.Sources.Constant constTLegMin(final k=TLegMin)
    "Temperature at which the legionella in DWH dies"
    annotation (Placement(transformation(extent={{-96,-12},{-88,-4}})));
  Modelica.Blocks.Logical.Timer timeAntiLeg "Time in which legionella will die"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Logical.GreaterThreshold
                               greaterThreshold(final threshold=minTimeAntLeg)
    annotation (Placement(transformation(extent={{14,-8},{28,8}})));
  Modelica.Blocks.Interfaces.RealInput TSet_in "Input of TSet"
    annotation (Placement(transformation(extent={{-140,64},{-100,104}})));
  Modelica.Blocks.Logical.Pre pre1
    annotation (Placement(transformation(extent={{-44,-6},{-32,6}})));
  AixLib.Utilities.Time.DaytimeSwitch daytimeSwitch(
    final hourDay=trigHour,
    final zerTim=zerTim,
    final yearRef=yearRef,
    final weekDay=trigWeekDay)
    "If given day and hour match the current daytime, output will be true"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-46,34})));
  Modelica.Blocks.MathInteger.TriggeredAdd triggeredAdd(use_reset=true, use_set=
       false,
    y_start=0)
              "See info of model for description"
    annotation (Placement(transformation(extent={{-10,52},{2,64}})));
  Modelica.Blocks.Sources.IntegerConstant intConPluOne(final k=1)
    "Value for counting"
    annotation (Placement(transformation(extent={{-34,52},{-22,64}})));
  Modelica.Blocks.Logical.LessThreshold    lessThreshold(final threshold=1)
    "Checks if value is less than one"
    annotation (Placement(transformation(extent={{36,48},{56,68}})));
  Modelica.Blocks.Math.IntegerToReal intToReal "Converts Integer to Real"
    annotation (Placement(transformation(extent={{12,52},{24,64}})));
  Modelica.Blocks.Interfaces.RealInput TSupAct
    "Input of actual supply temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
equation
  connect(constTLegMin.y, TConLessTLegMin.u2) annotation (Line(points={{-87.6,
          -8},{-72,-8}},                    color={0,0,127}));
  connect(switchTLeg.y, TSet_out)
    annotation (Line(points={{84.7,79},{84.7,80},{114,80}}, color={0,0,127}));
  connect(TSet_in, switchTLeg.u1) annotation (Line(points={{-120,84},{-28,84},{-28,
          84.6},{68.6,84.6}}, color={0,0,127}));
  connect(switchTLeg.u3, constTLegMin.y) annotation (Line(points={{68.6,73.4},{-78,
          73.4},{-78,-8},{-87.6,-8}}, color={0,0,127}));
  connect(timeAntiLeg.u, pre1.y)
    annotation (Line(points={{-22,0},{-31.4,0}}, color={255,0,255}));
  connect(TConLessTLegMin.y, pre1.u)
    annotation (Line(points={{-49,0},{-45.2,0}}, color={255,0,255}));
  connect(lessThreshold.y, switchTLeg.u2) annotation (Line(points={{57,58},{60,
          58},{60,79},{68.6,79}}, color={255,0,255}));
  connect(intToReal.y, lessThreshold.u) annotation (Line(points={{24.6,58},{30,
          58},{30,58},{34,58}}, color={0,0,127}));
  connect(intConPluOne.y, triggeredAdd.u)
    annotation (Line(points={{-21.4,58},{-12.4,58}}, color={255,127,0}));
  connect(intToReal.u, triggeredAdd.y)
    annotation (Line(points={{10.8,58},{3.2,58}}, color={255,127,0}));
  connect(greaterThreshold.y, triggeredAdd.reset) annotation (Line(points={{
          28.7,0},{32,0},{32,34},{-0.4,34},{-0.4,50.8}}, color={255,0,255}));
  connect(TSupAct, TConLessTLegMin.u1)
    annotation (Line(points={{-120,0},{-72,0}}, color={0,0,127}));
  connect(daytimeSwitch.isDaytime, triggeredAdd.trigger) annotation (Line(
        points={{-39.4,34},{-8,34},{-8,50.8},{-7.6,50.8}}, color={255,0,255}));
  connect(timeAntiLeg.y, greaterThreshold.u)
    annotation (Line(points={{1,0},{12.6,0}}, color={0,0,127}));
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
          pattern=LinePattern.Dash,
          lineThickness=0.5,
          textString=DynamicSelect("%TLegMin K", String(TLegMin-273.15)+ "°C")),
        Text(
          extent={{-94,0},{56,-154}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Day of week: %trigWeekDay
Hour of Day: %trigHour",
          horizontalAlignment=TextAlignment.Left),
        Text(
          extent={{-104,146},{100,92}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="%name")}),                                                           Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This model represents the anti legionella control of a real heat
  pump. Based on a daily or weekly approach, the given supply
  temperature is raised above the minimal temperature required for the
  thermal desinfection (at least 60 °C) for a given duration
  minTimeAntLeg.
</p>
<ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>"));
end AntiLegionella;
