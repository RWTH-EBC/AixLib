within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.RotaryCompressors.R22;
model R22_Rotary_20
  "Rotary Compressor - R22 - 20.7 cm³ - Polynomial"
  extends PolynomialVolumetricEfficiency(
    final polyMod=Types.VolumetricPolynomialModels.Li2013,
    final rotSpeRef=60,
    final a={0.709,0.416,-0.125},
    final b={1,1,1},
    final c={1.083,-0.077,0});

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 23, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end R22_Rotary_20;
