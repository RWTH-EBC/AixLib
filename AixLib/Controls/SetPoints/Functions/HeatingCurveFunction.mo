within AixLib.Controls.SetPoints.Functions;
function HeatingCurveFunction "Linear function with a set temperature of 55degC at -20 degC outdoor air temperature"
  extends PartialBaseFct;
protected
  parameter Real TOffNig = 20;
algorithm
  if isDay then
    TSet := 55 + ((TRoom-55)/(TRoom+20))*(T_oda+20);
  else
    TSet := 55 + ((TRoom-55)/(TRoom+20))*(T_oda+20)-TOffNig;
  end if;
end HeatingCurveFunction;
