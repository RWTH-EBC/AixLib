within AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.Generic;
model Poly_GeneralLiterature
  "Generic overall isentropic efficiency based on literature review for various compressors"
  extends PolynomialIsentropicEfficiency(
    final polyMod=Types.IsentropicPolynomialModels.Engelpracht2017,
    final a={0.624648650065473, 1.942405219838358e-04,
             -3.318894570488234e-08, -0.002032592168203},
    final b={1,1,1,1});

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 23, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end Poly_GeneralLiterature;
