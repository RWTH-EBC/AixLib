within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions;
function dToverEff

  input Modelica.Units.SI.TemperatureDifference dTover;
  input Real h_rel;
  output Modelica.Units.SI.TemperatureDifference dTover_eff;

protected
  parameter Real a=0.5023;
  parameter Real b=0.259;

algorithm
  dTover_eff:=a*dTover*exp(-b*h_rel);

end dToverEff;
