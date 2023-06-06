within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions;
function dhDown
  input Modelica.Units.SI.TemperatureDifference dTover;
  input Real dh_gap;
  output Real dhdown;

  parameter Real a=1.989;
  parameter Real b=5.03;
  parameter Real c(unit="1/K")=0.087;
  parameter Real d=0.1257;

algorithm

  dhdown:=a + b*(1 - exp(-c*dTover))*(1 - exp(-d*dh_gap));

end dhDown;
