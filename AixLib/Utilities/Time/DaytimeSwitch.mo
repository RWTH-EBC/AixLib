within AixLib.Utilities.Time;
model DaytimeSwitch
  "Set the output to true if the given daytime stamp is equal to current daytime"
  parameter Boolean weekly=true
    "Switch between a daily or weekly trigger approach" annotation(Dialog(
        enable=not daily,descriptionLabel=true), choices(choice=true "Weekly",
      choice=false "Daily",
      radioButtons=true));

  parameter Integer weekDay = 1 "Day of the week" annotation (Dialog(enable=weekly));
  parameter Integer hourDay = 12
                                "Hour of the day";
  parameter AixLib.Utilities.Time.Types.ZeroTime zerTim
    "Enumeration for choosing how reference time (time = 0) should be defined";
  parameter Integer yearRef=2016 "Year when time = 0, used if zerTim=Custom";
  AixLib.Utilities.Time.CalendarTime calTim(zerTim=zerTim, yearRef=yearRef) "Used to get the unix time stamp and calendar time from the simulation time";

  Modelica.Blocks.Interfaces.BooleanOutput isDaytime "Output boolean if current time stamp matches the set parameters"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

equation
  if weekly then
    isDaytime =(calTim.weekDay == weekDay and calTim.hour == hourDay); //Trigger every week
  else
    isDaytime =(calTim.hour == hourDay); //Trigger every day
  end if;

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
          color={238,46,47})}), Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  Using <a href=
  \"modelica://AixLib.Utilities.Time.CalendarTime\">AixLib.Utilities.Time.CalendarTime</a>,
  this model triggers a control if the current time is equal to a
  certain hour of the day and or day of the week.
</p>
</html>"));
end DaytimeSwitch;
