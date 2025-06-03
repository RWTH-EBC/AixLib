within AixLib.Controls.OBC.CDL.Reals.Sources.Validation;
model TimeTableNegativeStartTime
  "Validation model for TimeTable block with negative start time"
  AixLib.Controls.OBC.CDL.Reals.Sources.TimeTable timTabLin(
    smoothness=AixLib.Controls.OBC.CDL.Types.Smoothness.LinearSegments,
    table=[
      0,0;
      6*3600,1;
      18*3600,0.5;
      24*3600,0])
    "Time table with smoothness method of linear segments"
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  AixLib.Controls.OBC.CDL.Reals.Sources.TimeTable timTabLinHol(
    smoothness=AixLib.Controls.OBC.CDL.Types.Smoothness.LinearSegments,
    extrapolation=AixLib.Controls.OBC.CDL.Types.Extrapolation.HoldLastPoint,
    table=[
      0,0;
      6*3600,1;
      18*3600,0.5;
      24*3600,0])
    "Time table with smoothness method of linear segments, hold first and last value"
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  AixLib.Controls.OBC.CDL.Reals.Sources.TimeTable timTabLinDer(
    smoothness=AixLib.Controls.OBC.CDL.Types.Smoothness.LinearSegments,
    extrapolation=AixLib.Controls.OBC.CDL.Types.Extrapolation.LastTwoPoints,
    table=[
      0,0;
      6*3600,1;
      18*3600,0.5;
      24*3600,0])
    "Time table with smoothness method of linear segments, extrapolate with der"
    annotation (Placement(transformation(extent={{50,10},{70,30}})));
  AixLib.Controls.OBC.CDL.Reals.Sources.TimeTable timTabCon(
    smoothness=AixLib.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    table=[
      0,0;
      6*3600,1;
      18*3600,0.5;
      24*3600,0])
    "Time table with smoothness method of constant segments"
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  AixLib.Controls.OBC.CDL.Reals.Sources.TimeTable timTabLinCon(
    smoothness=AixLib.Controls.OBC.CDL.Types.Smoothness.LinearSegments,
    table=[
      0,0;
      6*3600,0;
      6*3600,1;
      18*3600,0.5;
      24*3600,0])
    "Time table with smoothness method of linear segments"
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  annotation (
    experiment(
      Tolerance=1e-6,
      StartTime=-129600.0,
      StopTime=172800),
    __Dymola_Commands(
      file="modelica://AixLib/Resources/Scripts/Dymola/Controls/OBC/CDL/Reals/Sources/Validation/TimeTableNegativeStartTime.mos" "Simulate and plot"),
    Documentation(
      info="<html>
<p>
This model validates the block
<a href=\"modelica://AixLib.Controls.OBC.CDL.Reals.Sources.TimeTable\">
AixLib.Controls.OBC.CDL.Reals.Sources.TimeTable</a>.
The model is identical to
<a href=\"modelica://AixLib.Controls.OBC.CDL.Reals.Sources.Validation.TimeTable\">
AixLib.Controls.OBC.CDL.Reals.Sources.Validation.TimeTable</a>
except that the start time is negative, and not a multiple of a full day.
</html>",
      revisions="<html>
<ul>
<li>
March 13, 2020, by Michael Wetter:<br/>
First implementation in CDL.
</li>
</ul>
</html>"),
    Icon(
      graphics={
        Ellipse(
          lineColor={75,138,73},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100,-100},{100,100}}),
        Polygon(
          lineColor={0,0,255},
          fillColor={75,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-36,60},{64,0},{-36,-60},{-36,60}})}), 
   __Dymola_LockedEditing="Model from IBPSA");
end TimeTableNegativeStartTime;
