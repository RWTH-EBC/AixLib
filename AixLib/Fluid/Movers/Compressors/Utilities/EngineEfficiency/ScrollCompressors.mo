within AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency;
package ScrollCompressors
  "Package that contains efficiency models for scroll compressors"
  extends Modelica.Icons.VariantsPackage;

  package SimilitudeTheory
    "Package that contains engine efficiency models based on similitude theory"
    extends Modelica.Icons.VariantsPackage;

    model Buck_R134aR450aR1234yfR1234zee_Scroll
      "Power - Similutude for R134a, R450a, R1234yf, R1234ze(e) - Scroll"
      extends PowerEngineEfficiency(
        final useIseWor=true,
        final MRef = 0.102032,
        final rotSpeRef = 9.334,
        final powMod=Choices.EnginePowerModels.MendozaMirandaEtAl2016,
        final a=1,
        final b={-0.1642,0.2050,0.0659,07669});

    end Buck_R134aR450aR1234yfR1234zee_Scroll;
  end SimilitudeTheory;
end ScrollCompressors;
