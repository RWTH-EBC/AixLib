within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.Generic;
model Poly_GeneralLiterature
  "Generic overall volumetric efficiency based on literature review for various compressors"
  extends PolynomialVolumetricEfficiency(
    final polyMod=Types.VolumetricPolynomialModels.Engelpracht2017,
    final a={0.801790164842882, -0.0521044823322188, 3.216164809959999e-04,
             -0.00493895583430215, 0.049805496348618, -0.021900176265525},
    final b={1,1,1,1,1,1},
    final c={4.54069854496490, 1.63495326341915, 263.864279610770,
             8.43796869242862, 64.4107142857143, 20.8137823859887});

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
