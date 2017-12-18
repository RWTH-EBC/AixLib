within AixLib.Fluid.Movers.Compressors.Validation.StaticHeatPumpBoundaries.StaticBoundaries;
model VolumetricEfficiency
  extends Utilities.VolumetricEfficiency.PartialVolumetricEfficiency;

equation
  lamH = 0.5828+0.0303*rotSpe-0.1727*piPre-0.000588*rotSpe^2+
    0.003072*rotSpe*piPre+0.01238*piPre^2+3.434e-06*rotSpe^3-
    1.496e-05*rotSpe^2*piPre -0.0001785*rotSpe*piPre^2;

end VolumetricEfficiency;
