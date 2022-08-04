within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions;
function qbuoy0

  input Modelica.Units.SI.TemperatureDifference dTover;
  input Real dh_gap;
  output Modelica.Units.SI.SpecificEnergy qbuoy0;

protected
  parameter Real a(unit="J/(kg.K)")=3844;
  parameter Real b=1.233;

algorithm
  qbuoy0:=a*dTover*(1-exp(-b*dh_gap));

end qbuoy0;
