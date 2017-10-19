within AixLib.Fluid.Actuators.ExpansionValves.Utilities.FlowCoefficient.R22;
model R22_EEV_16
  "Polynomial - R22 - EEV - 1.6 mm"
  extends PolynomialFlowCoefficient(
    final polyMod=Choices.PolynomialModels.Li2013,
    final a={-0.03469,1.64866,-0.84227,1.19513,0,0},
    final b={1,1,1,1,1,1},
    final pDifRat=0.84);

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>"));
end R22_EEV_16;
