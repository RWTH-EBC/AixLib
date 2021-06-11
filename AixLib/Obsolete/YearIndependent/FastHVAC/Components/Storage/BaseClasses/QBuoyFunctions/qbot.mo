within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions;
function qbot
  input Modelica.SIunits.TemperatureDifference dTover;
  input Modelica.SIunits.TemperatureDifference dT13;

  output Modelica.SIunits.SpecificEnergy qbot;

protected
  parameter Real a=594.1;
algorithm
  qbot:=a*sqrt(dTover)*dT13;

end qbot;
