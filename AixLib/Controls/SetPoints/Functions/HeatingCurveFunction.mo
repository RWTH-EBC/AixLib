within AixLib.Controls.SetPoints.Functions;
function HeatingCurveFunction "Linear function with a set temperature of 55degC at -20 degC outdoor air temperature"
  extends PartialBaseFct;
protected
  parameter Real TOffNig = 10 "Delta K for night mode of heating system";
algorithm
  if isDay then
    TSet := (55) + ((TRoom-(273.15+55))/(TRoom+(273.15+20)))*(T_oda+20);
  else
    TSet := (55) + ((TRoom-(273.15+55))/(TRoom+(273.15+20)))*(T_oda+20)-TOffNig;
  end if;
  annotation (Documentation(revisions="<html>
 <li><i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)</li>
</html>"));
end HeatingCurveFunction;
