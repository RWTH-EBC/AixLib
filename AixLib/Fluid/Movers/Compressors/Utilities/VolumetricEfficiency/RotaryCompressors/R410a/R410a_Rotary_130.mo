within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.RotaryCompressors.R410a;
model R410a_Rotary_130
  "Rotary Compressor - R410a - 130 cm³ - Polynomial"
  extends PolynomialVolumetricEfficiency(
    final polyMod=Types.VolumetricPolynomialModels.Koerner2017,
    final a={1.108},
    final b={-0.165});

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 23, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end R410a_Rotary_130;
