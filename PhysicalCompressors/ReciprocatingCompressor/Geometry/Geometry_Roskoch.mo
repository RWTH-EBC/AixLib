within PhysicalCompressors.ReciprocatingCompressor.Geometry;
record Geometry_Roskoch
  "\"Geometrical quantities taken form Roskoch\""
  extends DataBaseDefinition(
  name = "Geometry taken from Roskoch",
  D_pis = 34e-3,
  H = 34e-3,
  A_env = 0.04,
  alpha_env = 6,
  pistonRod_ratio = 3.5,
  Aeff_in = 1.27e-5,
  Aeff_out = 1.61e-5,
  c_dead = 0.0607,
  p_rub = 48.92e3);

end Geometry_Roskoch;
