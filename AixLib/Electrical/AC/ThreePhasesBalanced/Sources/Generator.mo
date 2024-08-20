within AixLib.Electrical.AC.ThreePhasesBalanced.Sources;
model Generator "Model of a generator"
  extends AixLib.Electrical.AC.OnePhase.Sources.Generator(
    redeclare Interfaces.Terminal_p terminal,
    f(start=60));
  annotation (
    defaultComponentName="gen",
    Documentation(info="<html>
<p>
Model of an inductive generator.
</p>
<p>
See <a href=\"modelica://AixLib.Electrical.AC.OnePhase.Sources.Generator\">
AixLib.Electrical.AC.OnePhase.Sources.Generator</a> for
more information.
</p>
</html>", revisions="<html>
<ul>
<li>
August 24, 2014, by Marco Bonvini:<br/>
Revised documentation.
</li>
<li>
January 4, 2012, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),  
   __Dymola_LockedEditing="Model from IBPSA");
end Generator;
