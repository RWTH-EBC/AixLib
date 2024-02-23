within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions;
function qbuoySingle
  input Integer n;
  input Integer nbuoy;
  input Integer nstop;
  input Modelica.Units.SI.TemperatureDifference dTover;
  input Modelica.Units.SI.TemperatureDifference dT13;
  input Modelica.Units.SI.TemperatureDifference dTborder;

  output Modelica.Units.SI.SpecificEnergy q_buoy_single[n];

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
