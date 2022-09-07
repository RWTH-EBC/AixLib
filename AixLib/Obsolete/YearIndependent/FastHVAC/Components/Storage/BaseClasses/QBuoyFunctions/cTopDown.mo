within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions;
function cTopDown

  input Modelica.Units.SI.TemperatureDifference dTover;
  input Modelica.Units.SI.TemperatureDifference dTborder;
  input Integer dn_gap;

  output Real c_top_down;

protected
  parameter Real a=1.445;
  parameter Real b(unit="1/K")= 0.03445;
  parameter Real c(unit="1/K")=0.1455;
  parameter Real d=0.8435;
  parameter Real e=0.02059;

algorithm
  c_top_down:=a*exp(-b*dTover)*(1 - exp(-c*dTborder))*(d + e*dn_gap);

end cTopDown;
