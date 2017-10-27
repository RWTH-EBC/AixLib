within AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency.RotaryCompressors.SimilitudeTheory;
model Buck_R134aR450aR1234yfR1234zee_Rotary
  "Rotary Compressor - R134a, R450a, R1234yf, R1234ze(e) - Similitude - Power"
  extends PowerEngineEfficiency(
    final useIseWor=true,
    final MRef=0.102032,
    final rotSpeRef=9.334,
    final powMod=Types.EnginePowerModels.MendozaMirandaEtAl2016,
    final a=1,
    final b={-0.1642,0.2050,0.0659,07669});

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
