within AixLib.Fluid.Movers.Compressors.Validation.StaticHeatPumpBoundaries.StaticBoundaries;
model IsentropicEfficiency
  extends Utilities.IsentropicEfficiency.PartialIsentropicEfficiency;

equation
  etaIse = -3.565 + 0.2464*rotSpe + 1.227*piPre - 0.007986*rotSpe^2+
  0.03947*rotSpe*piPre-0.9075*piPre^2+0.0001086*rotSpe^3-
   0.0006588*rotSpe^2*piPre +0.0001482*rotSpe*piPre^2 +
    0.1721*piPre^3-5.291e-07*rotSpe^4+3.353e-06*rotSpe^3*piPre+
    1.037e-05*rotSpe^2*piPre^2 - 0.0001854*rotSpe*piPre^3-0.01102*piPre^4;

end IsentropicEfficiency;
