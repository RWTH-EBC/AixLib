within AixLib.Electrical.Interfaces;
model PartialTwoPort "Model of a generic two port component with phase systems"

  replaceable package PhaseSystem_p =
      AixLib.Electrical.PhaseSystems.PartialPhaseSystem constrainedby
    AixLib.Electrical.PhaseSystems.PartialPhaseSystem
    "Phase system of terminal p"
    annotation (choicesAllMatching=true);

  replaceable package PhaseSystem_n =
      AixLib.Electrical.PhaseSystems.PartialPhaseSystem constrainedby
    AixLib.Electrical.PhaseSystems.PartialPhaseSystem
    "Phase system of terminal n"
    annotation (choicesAllMatching=true);

  extends AixLib.Electrical.Interfaces.PartialBaseTwoPort(
    redeclare replaceable AixLib.Electrical.Interfaces.Terminal terminal_n
      constrainedby AixLib.Electrical.Interfaces.Terminal(
        redeclare replaceable package PhaseSystem = PhaseSystem_n),
    redeclare replaceable AixLib.Electrical.Interfaces.Terminal terminal_p
      constrainedby AixLib.Electrical.Interfaces.Terminal(
        redeclare replaceable package PhaseSystem=PhaseSystem_p));

  annotation (Documentation(revisions="<html>
<ul>
<li>
May 15, 2014, by Marco Bonvini:<br/>
Created documentation.
</li>
<li>
October 31, 2013, by Marco Bonvini:<br/>
Model included into the AixLib library.
</li>
</ul>
</html>", info="<html>
<p>
This is a model of a component with two electric terminals.
It represents a common interface that is extended by other models.
</p>
</html>"),  
   __Dymola_LockedEditing="Model from IBPSA");
end PartialTwoPort;
