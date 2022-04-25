within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions;
function qbuoySingle
  input Integer n;
  input Integer nbuoy;
  input Integer nstop;
  input Modelica.SIunits.TemperatureDifference dTover;
  input Modelica.SIunits.TemperatureDifference dT13;
  input Modelica.SIunits.TemperatureDifference dTborder;

  output Modelica.SIunits.SpecificEnergy q_buoy_single[n];

algorithm
  q_buoy_single:=qFreebuoy(
      n,
      nbuoy,
      nstop,
      dTover) + qTopmix(
      n,
      nbuoy,
      nstop,
      dTover,
      dTborder) + qBotmix(
      n,
      nbuoy,
      dTover,
      dT13);

end qbuoySingle;
