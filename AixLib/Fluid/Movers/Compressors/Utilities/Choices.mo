within AixLib.Fluid.Movers.Compressors.Utilities;
package Choices "Types, constants to define menu choices"
  extends Modelica.Icons.Package;

  type EnginePolynomialModels = enumeration(
      t
      "t")
    "Enumeration to define polynomial models for calculating flow coefficient"
    annotation (Evaluate=true);
  type EnginePowerModels = enumeration(
      MendozaMirandaEtAl2016
      "MendozaMirandaEtAl2016 - Function of various properties")
    "Enumeration to define polynomial models for calculating flow coefficient"
    annotation (Evaluate=true);
  type VolumetricPolynomialModels = enumeration(
      Karlsson2007
      "Karlsson2007 - Function of pressure ratio and rotational speed")
    "Enumeration to define polynomial models for calculating flow coefficient"
    annotation (Evaluate=true);
  type VolumetricPowerModels = enumeration(
      MendozaMirandaEtAl2016
      "MendozaMirandaEtAl2016 - Function of various properties")
    "Enumeration to define polynomial models for calculating flow coefficient"
    annotation (Evaluate=true);
  type IsentropicPolynomialModels = enumeration(
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
end Choices;
