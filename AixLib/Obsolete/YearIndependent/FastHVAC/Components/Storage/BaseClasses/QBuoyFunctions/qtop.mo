within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions;
function qtop

  input Modelica.Units.SI.TemperatureDifference dTover;
  input Modelica.Units.SI.TemperatureDifference dTborder;
  input Integer dn_gap;

  output Modelica.Units.SI.SpecificEnergy qtop;

protected
  parameter Real a(unit="J/(kg.K)")=3896;
  parameter Real b(unit="1/K")=0.0354;
  parameter Real c=524.7;
  parameter Real d=0.5153;

algorithm
  qtop:=a*(1 - exp(-b*dTover))*dTborder*(1 - exp(-c*exp(-d*dn_gap)));

end qtop;
