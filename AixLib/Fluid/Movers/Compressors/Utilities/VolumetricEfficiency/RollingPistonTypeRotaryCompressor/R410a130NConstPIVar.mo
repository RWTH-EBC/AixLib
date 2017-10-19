within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.RollingPistonTypeRotaryCompressor;
model R410a130NConstPIVar
  "R410a - 130 cm³ - Variable pressure ration and constant rotational speed"
  extends PartialVolumetricEfficiency;

equation
  // Calculate volumetric efficiency
  //
  lambdah_h =  1.108*ratio_pressure^(-0.165)
    "Fit for volumetric efficiency by Körner(2017)";

end R410a130NConstPIVar;
