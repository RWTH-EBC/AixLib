within AixLib.Fluid.Actuators.ExpansionValves.Utilities.FlowCoefficient.R410a;
model R410a_EEV_18
  "Polynomial - R410a - EEV - 1.8 mm"
  extends PolynomialFlowCoefficient(
    final polyMod=Choices.PolynomialModels.Li2013,
    final a={-0.07374,1.5461,-0.73679,1.09651,0,0},
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
end R410a_EEV_18;
