within AixLib.Fluid.Actuators.Valves.ExpansionValves.ModularExpansionValves;
model ModularExpansionValves
  "Model of modular expansion valves, i.g. each valves is in front 
  of an evaporator"
  extends BaseClasses.PartialModularExpansionVavles;

equation
  // Connect ports_b with outlet ports of expansion valves
  //
  for i in 1:nVal loop
    connect(expansionValves[i].port_b,ports_b[i]);
  end for;

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 17, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>"));
end ModularExpansionValves;
