within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.buoyancyDitribution;
partial function buoyancyDist
                              //Distribution of massflow over the layers i set by a predefined profile (linear,square, cubic, inv ...)
  input Integer i
                 "position of the layer emitting buoyant mass flow";
  input Integer j
                 "position of the highest layer receiving buoyant mass flow";
  input Integer n
                 "total number of layers";
  input Modelica.Units.SI.Temperature T[n] "Temperature of layers";
  output Real[n] y           "mass fraction of buoyant current received (-1 for emitting layer)";

end buoyancyDist;
