within AixLib.Fluid.Movers.Compressors.Utilities;
package Types "Types, constants to define menu choices"
  extends Modelica.Icons.Package;

  type EnginePolynomialModels = enumeration(
      JahningEtAl2000
      "JahningEtAl2000 - Function of inlet pressure",
      KinarbEtAl2010
      "KinarbEtAl2010 - Function of pressure ratio",
      DurprezEtAl2007
      "DurprezEtAl2007 - Function of pressure ratio",
      Engelpracht2017
      "Engelpracht2017 - Function of pressure ratio and rotational speed")
    "Enumeration to define polynomial models for calculating flow coefficient"
    annotation (Evaluate=true);
  type EnginePowerModels = enumeration(
      MendozaMirandaEtAl2016
      "MendozaMirandaEtAl2016 - Function of various properties")
    "Enumeration to define polynomial models for calculating flow coefficient"
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
      "Koerner2017 - Function of pressure ratio")
    "Enumeration to define polynomial models for calculating flow coefficient"
    annotation (Evaluate=true);
  type VolumetricPowerModels = enumeration(
      MendozaMirandaEtAl2016
      "MendozaMirandaEtAl2016 - Function of various properties")
    "Enumeration to define polynomial models for calculating flow coefficient"
    annotation (Evaluate=true);
  type IsentropicPolynomialModels = enumeration(
      DarrAndCrawford1992
      "DarrAndCrawford1992 - Function of rotational speed and densities",
      Karlsson2007
      "Karlsson2007 - Function of pressure ratio and rotational speed")
    "Enumeration to define polynomial models for calculating flow coefficient"
    annotation (Evaluate=true);
  type IsentropicPowerModels = enumeration(
      MendozaMirandaEtAl2016
      "MendozaMirandaEtAl2016 - Function of various properties")
    "Enumeration to define polynomial models for calculating flow coefficient"
    annotation (Evaluate=true);
  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 20, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>",   info="<html>
<p>This package contains types and constants to define menue choices.</p>
</html>"));
end Types;
