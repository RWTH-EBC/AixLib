within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.RollingPistonTypeRotaryCompressor;
model R410a130NVarPIVar
  "R410a - 130 cm³ - Variable pressure ration and variable rotational speed"
  extends PartialVolumetricEfficiency;

equation
  // Calculate volumetric efficiency
  //
  lambdah_h = (3.216164809959999e-04.*((T_inlet-263.864279610770)/
    8.43796869242862) - 0.0521044823322188) .* ((ratio_pressure-4.54069854496490)
    /1.63495326341915) + (0.801790164842882 - 0.00493895583430215.*((T_inlet-
    263.864279610770)/8.43796869242862)) + 0.049805496348618.*((n_compressor-
    64.4107142857143)/20.8137823859887) - 0.021900176265525.*
    ((n_compressor-64.4107142857143)/20.8137823859887).^2
    "Fit vor volumetric efficiency";

end R410a130NVarPIVar;
