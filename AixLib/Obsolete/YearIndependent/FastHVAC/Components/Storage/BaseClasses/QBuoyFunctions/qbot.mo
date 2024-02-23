within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions;
function qbot
  input Modelica.Units.SI.TemperatureDifference dTover;
  input Modelica.Units.SI.TemperatureDifference dT13;

  output Modelica.Units.SI.SpecificEnergy qbot;

protected
  parameter Real a=594.1;
algorithm
  qbot:=a*sqrt(dTover)*dT13;

end qbot;
