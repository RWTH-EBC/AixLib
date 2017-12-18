within AixLib.Fluid.Movers.Compressors.Validation.StaticHeatPumpBoundaries.StaticBoundaries;
model EngineEfficiency
  extends Utilities.EngineEfficiency.PartialEngineEfficiency(
    useIseWor = false);

equation
  // etaEng = 0.3314+0.01414*rotSpe+0.2645*piPre-0.000101*rotSpe^2-
  //   0.003797*rotSpe*piPre -0.04506*piPre^2+2.334e-05*rotSpe^2*piPre +
  //   0.0001859*rotSpe*piPre^2+0.003053*piPre^3;

  etaEng = 0.8704+0.001295*rotSpe+0.05194*piPre-8.006e-06*rotSpe^2-0.0001272*rotSpe*piPre-0.01146*piPre^2+1.059e-06*rotSpe^2*piPre-2.265e-06*rotSpe*piPre^2+0.0008853*piPre^3;

end EngineEfficiency;
