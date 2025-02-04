within AixLib.Electrical.AC.ThreePhasesBalanced.Sources;
model Grid "Electrical grid"
  extends AixLib.Electrical.AC.OnePhase.Sources.Grid(
    redeclare Interfaces.Terminal_p terminal,
    f(start=60),
    V(start=480),
    redeclare AixLib.Electrical.AC.ThreePhasesBalanced.Sources.FixedVoltage sou);

  annotation (
  defaultComponentName="gri",
    Documentation(info="<html>
<p>
Model that can be used to represent the electrical grid supply.
See <a href=\"modelica://AixLib.Electrical.AC.OnePhase.Sources.Grid\">
AixLib.Electrical.AC.OnePhase.Sources.Grid</a> for
more information.
</p>
</html>",
 revisions="<html>
<ul>
<li>
August 24, 2014, by Marco Bonvini:<br/>
Revised documentation.
</li>
<li>
January 2, 2012, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
   __Dymola_LockedEditing="Model from IBPSA");
end Grid;
