within AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency.SimilitudeTheory;
model Poly_GeneralLiterature
  "Generic overall engine efficiency based on literature review for various compressors"
  extends PolynomialEngineEfficiency(
    final useIseWor=false,
    final polyMod=Types.EnginePolynomialModels.Engelpracht2017,
    final a={0.0957214408265998,-0.0237502431235701,-0.000612850128091508,-8.25590145280732e-05,
        0.0336042594518318,-0.000551123582212516,4.49402507385231e-06,-1.86028373775212e-08,
        3.13293379590205e-11,0.000124051213495265,2.73040051562071e-05,
        1.04245115131576e-06,-2.83805388964573e-06,-3.08242161042959e-07,-3.71221991776753e-09,
        2.97156718978992e-08,1.05181138122206e-09,-9.91053456387955e-11},
    final b={1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1});

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
