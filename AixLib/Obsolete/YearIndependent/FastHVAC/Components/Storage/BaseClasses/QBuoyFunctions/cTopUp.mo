within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions;
function cTopUp

  input Modelica.Units.SI.TemperatureDifference dTover;
  input Modelica.Units.SI.TemperatureDifference dTborder;
  input Integer dn_gap;

  output Real c_top_up;

protected
  parameter Real a=11.9;
  parameter Real b(unit="1/K")= 0.08698;
  parameter Real c(unit="1/K")=0.1239;
  parameter Real d=2.145;
  parameter Real e=0.0621;

algorithm
  c_top_up:=a*exp(-b*dTover)*(1 - exp(-c*dTborder))*(d - e*dn_gap);

end cTopUp;
