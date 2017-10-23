within AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency;
package ScrollCompressors
  "Package that contains efficiency models for scroll compressors"
  extends Modelica.Icons.VariantsPackage;
  package SimilitudeTheory
    "Package that contains isentropic efficiency models based on similitude theory"
    extends Modelica.Icons.VariantsPackage;

    model Buck_R134aR450aR1234yfR1234zee_Scroll
      "Power - Similutude for R134a, R450a, R1234yf, R1234ze(e) - Scroll"
      extends PowerIsentropicEfficiency(
        final MRef=0.102032,
        final rotSpeRef=9.334,
        final powMod=Choices.IsentropicPowerModels.MendozaMirandaEtAl2016,
        final a=1,
        final b={0.0753,0.2183,0.0015,0.0972});

    end Buck_R134aR450aR1234yfR1234zee_Scroll;
  end SimilitudeTheory;

  package R407C
    "Package that contains isentropic efficiency models for R407C"
    extends Modelica.Icons.VariantsPackage;
    model R407C_Scroll_XXXX
      "Polynomial - R407C - Scroll Compressor - Unknown displacement volume"
      extends PolynomialEngineEfficiency(
        final polyMod=Choices.IsentropicPolynomialModels.Karlsson2007,
        final a={0.926,-0.0823,0.00352,0.00924,-0.000022},
        final b={1,1,1,1,1});

    end R407C_Scroll_XXXX;
  end R407C;
end ScrollCompressors;
