within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions;
function cQup

  input Real dh_gap;
  output Real c_qup;

  parameter Real p1=0.02973;
  parameter Real p2=1.329;

algorithm
  c_qup:=p1*dh_gap + p2;

end cQup;
