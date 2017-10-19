within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.R134a;
model R134a_EEV_15
  "Polynomial - R134a - EEV - 1.5 mm"
  extends PowerFlowCoefficient(
    final powMod=Choices.PowerModels.ZhifangAndOu2008,
    final a=1.1868e-13,
    final b={-1.4347,3.6426});

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>"));
end R134a_EEV_15;
