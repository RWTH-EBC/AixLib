within AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.RotaryCompressors.SimilitudeTheory;
model Buck_R134aR450aR1234yfR1234zee_Rotary
  "Rotary Compressor - R134a, R450a, R1234yf, R1234ze(e) - Similitude - Power"
  extends PowerIsentropicEfficiency(
    final MRef=0.102032,
    final rotSpeRef=9.334,
    final powMod=Types.IsentropicPowerModels.MendozaMirandaEtAl2016,
    final a=0.85,
    final b={0.0753,0.2183,0.0015,0.0972});

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 23, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end Buck_R134aR450aR1234yfR1234zee_Rotary;
