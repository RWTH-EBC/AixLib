within AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency.RollingPistonTypeRotaryCompressor;
model GeneralNVarPIVar
  "General refrigerant and displacement volume | Variable pressure ratio and rotational speed"
  extends PartialEngineEfficiency;

equation
  // Calculate engine efficiency
  //
  eta_mech_el = 0.0957214408265998 + n_compressor*(n_compressor*(n_compressor*
    (n_compressor*(3.13293379590205e-11*n_compressor - 1.86028373775212e-08 -
    9.91053456387955e-11*ratio_pressure)  + 4.49402507385231e-06 +
    ratio_pressure*(1.05181138122206e-09*ratio_pressure + 2.97156718978992e-08))
    - 0.000551123582212516 + ratio_pressure*(ratio_pressure*(
    -3.71221991776753e-09*ratio_pressure - 3.08242161042959e-07) -
    2.83805388964573e-06)) + 0.0336042594518318 + ratio_pressure*
    (ratio_pressure*(1.04245115131576e-06*ratio_pressure + 2.73040051562071e-05)
    + 0.000124051213495265)) + ratio_pressure*(ratio_pressure*
    (-8.25590145280732e-05*ratio_pressure - 0.000612850128091508) - 0.0237502431235701);

end GeneralNVarPIVar;
