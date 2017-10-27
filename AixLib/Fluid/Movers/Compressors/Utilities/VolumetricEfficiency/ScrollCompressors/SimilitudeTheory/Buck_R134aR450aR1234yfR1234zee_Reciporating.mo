within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.ScrollCompressors.SimilitudeTheory;
model Buck_R134aR450aR1234yfR1234zee_Reciporating
  "Scroll Compressor - R134a, R450a, R1234yf, R1234ze(e) - Similitude - Power"
  extends PowerVolumetricEfficiency(
    final MRef=0.102032,
    final rotSpeRef=9.334,
    final powMod=Types.VolumetricPowerModels.MendozaMirandaEtAl2016,
    final a=1.35,
    final b={-0.2678,-0.0106,0.7195});

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 23, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end Buck_R134aR450aR1234yfR1234zee_Reciporating;
