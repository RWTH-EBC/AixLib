within AixLib.Utilities.Time;
model DaytimeSwitch
  "If given daytime stamp is equal to current daytime output is true"
  AixLib.Utilities.Time.CalendarTime calTim(zerTim=zerTim, yearRef=yearRef);
  parameter Integer weekDay "Day of the week";
  parameter Integer hourDay "Hour of the day";
  parameter AixLib.Utilities.Time.Types.ZeroTime zerTim
    "Enumeration for choosing how reference time (time = 0) should be defined";
  parameter Integer yearRef=2016 "Year when time = 0, used if zerTim=Custom";
  Modelica.Blocks.Interfaces.BooleanOutput isDaytime
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  isDaytime =(calTim.weekDay == weekDay and calTim.hour == hourDay);
  annotation (Icon(graphics={   Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid), Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        lineColor={0,0,255}),
        Ellipse(extent={{-80,80},{80,-80}}, lineColor={160,160,164},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(points={{0,80},{0,60}}, color={160,160,164}),
        Line(points={{80,0},{60,0}}, color={160,160,164}),
        Line(points={{0,-80},{0,-60}}, color={160,160,164}),
        Line(points={{-80,0},{-60,0}}, color={160,160,164}),
        Line(points={{37,70},{26,50}}, color={160,160,164}),
        Line(points={{70,38},{49,26}}, color={160,160,164}),
        Line(points={{71,-37},{52,-27}}, color={160,160,164}),
        Line(points={{39,-70},{29,-51}}, color={160,160,164}),
        Line(points={{-39,-70},{-29,-52}}, color={160,160,164}),
        Line(points={{-71,-37},{-50,-26}}, color={160,160,164}),
        Line(points={{-71,37},{-54,28}}, color={160,160,164}),
        Line(points={{-38,70},{-28,51}}, color={160,160,164}),
        Line(
          points={{0,0},{-50,50}},
          thickness=0.5),
        Line(
          points={{0,0},{40,0}},
          thickness=0.5),
        Line(points={{-38,42}}, color={28,108,200}),
        Line(
          points={{0,0},{0,68}},
          thickness=0.5,
          color={238,46,47}),
        Line(
          points={{0,0},{-18,-32}},
          thickness=0.5,
          color={238,46,47})}));
end DaytimeSwitch;
