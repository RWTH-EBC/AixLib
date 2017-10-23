within AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency;
package ReciporatingCompressors
  "Package that contains efficiency models for reciporating compressors"
  extends Modelica.Icons.VariantsPackage;
  package SimilitudeTheory
    "Package that contains volumetric efficiency models based on similitude theory"
    extends Modelica.Icons.VariantsPackage;

    model Buck_R134aR450aR1234yfR1234zee_Reciporating
      "Power - Similutude for R134a, R450a, R1234yf, R1234ze(e) - Reciporating"
      extends PowerIsentropicEfficiency(
        final MRef=0.102032,
        final rotSpeRef=9.334,
        final powMod=Choices.IsentropicPowerModels.MendozaMirandaEtAl2016,
        final a=1,
        final b={0.0753,0.2183,0.0015,0.0972});

    end Buck_R134aR450aR1234yfR1234zee_Reciporating;
  end SimilitudeTheory;
end ReciporatingCompressors;
