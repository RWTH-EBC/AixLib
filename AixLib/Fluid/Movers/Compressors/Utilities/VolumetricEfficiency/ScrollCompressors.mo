within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency;
package ScrollCompressors
  "Package that contains efficiency models for scroll compressors"
  extends Modelica.Icons.VariantsPackage;
  package SimilitudeTheory
    "Package that contains volumetric efficiency models based on similitude theory"
    extends Modelica.Icons.VariantsPackage;

    model Buck_R134aR450aR1234yfR1234zee_Reciporating
      "Power - Similutude for R134a, R450a, R1234yf, R1234ze(e) - Reciporating"
      extends PowerVolumetricEfficiency(
        final MRef=0.102032,
        final rotSpeRef=9.334,
        final powMod=Choices.VolumetricPowerModels.MendozaMirandaEtAl2016,
        final a=1.35,
        final b={-0.2678,-0.0106,0.7195});

    end Buck_R134aR450aR1234yfR1234zee_Reciporating;
  end SimilitudeTheory;

  package R407C "Package that contains volumetric efficiency models for R407C"
    extends Modelica.Icons.VariantsPackage;
    model R407C_Scroll_XXXX
      "Polynomial - R407C - Scroll Compressor - Unknown displacement volume"
      extends PolynomialEngineEfficiency(
        final polyMod=Choices.VolumetricPolynomialModels.Karlsson2007,
        final a = {0.0012, -0.088, 1.1262, -0.0045, 0.0039, -0.000025},
        final b = {1,1,1,1,1,1});

    end R407C_Scroll_XXXX;
  end R407C;
end ScrollCompressors;
