within AixLib.Fluid.Movers.Compressors.Utilities;
package Types
  "Types, constants to define menu choices"
  extends Modelica.Icons.TypesPackage;

  type EnginePolynomialModels = enumeration(
      JahningEtAl2000
      "JahningEtAl2000 - Function of inlet pressure",
      KinarbEtAl2010
      "KinarbEtAl2010 - Function of pressure ratio",
      DurprezEtAl2007
      "DurprezEtAl2007 - Function of pressure ratio",
      Engelpracht2017
      "Engelpracht2017 - Function of pressure ratio and rotational speed")
    "Enumeration to define polynomial models for calculating engine efficiency"
    annotation (Evaluate=true);
  type EnginePowerModels = enumeration(
      MendozaMirandaEtAl2016
      "MendozaMirandaEtAl2016 - Function of various properties")
    "Enumeration to define polynomial models for calculating engine efficiency"
    annotation (Evaluate=true);
  type IsentropicPolynomialModels = enumeration(
      DarrAndCrawford1992
      "DarrAndCrawford1992 - Function of rotational speed and densities",
      Karlsson2007
      "Karlsson2007 - Function of pressure ratio and rotational speed",
      Engelpracht2017
      "Engelpracht2017 - Function of pressure ratio and rotational speed")
    "Enumeration to define polynomial models for calculating isentropic efficiency"
    annotation (Evaluate=true);
  type IsentropicPowerModels = enumeration(
      MendozaMirandaEtAl2016
      "MendozaMirandaEtAl2016 - Function of various properties")
    "Enumeration to define polynomial models for calculating isentropic efficiency"
    annotation (Evaluate=true);
  type VolumetricPolynomialModels = enumeration(
      DarrAndCrawford1992
      "DarrAndCrawford1992 - Function of rotational speed and densities",
      Karlsson2007
      "Karlsson2007 - Function of pressure ratio and rotational speed",
      KinarbEtAl2010
      "KinarbEtAl2010 - Function of pressure ratio",
      ZhouEtAl2010
      "ZhouEtAl2010 - Function of pressure ratio and isentropic exponent",
      Li2013
      "Li2013 - Function of rotational speed and reference rotational speed",
      HongtaoLaughmannEtAl2017
      "HongtaoLaughmannEtAl2017 - Function of pressures and rotational speed",
      Koerner2017
      "Koerner2017 - Function of pressure ratio",
      Engelpracht2017
      "Engelpracht2017 - Function of pressure ratio and rotational speed")
    "Enumeration to define polynomial models for calculating volumetric efficiency"
    annotation (Evaluate=true);
  type VolumetricPowerModels = enumeration(
      MendozaMirandaEtAl2016
      "MendozaMirandaEtAl2016 - Function of various properties")
    "Enumeration to define polynomial models for calculating volumetric efficiency"
    annotation (Evaluate=true);
  type HeatTransferModels = enumeration(
      Simplified
      "Calculation of heat transfer using simplified temperature difference")
    "Enumeration to define heat transfer models for calculations of heat losses"
    annotation (Evaluate=true);
  type SimpleCompressor = enumeration(
      Default
      "Default value used for partial compressor",
      RotaryCompressor
      "Simple rotary compressor",
      RotaryCompressorPressureLosses
      "Simple rotary compressor with pressure losses",
      RotaryCompressorPressureHeatLosses
      "Simple rotary compressor with pressure and heat losses")
    "Enumeration to define simple compressor model"
    annotation (Evaluate=true);
  annotation (Documentation(revisions="<html><ul>
  <li>October 20, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>",   info="<html>
<p>
  This package contains types and constants to define menue choices.
</p>
</html>"));
end Types;
