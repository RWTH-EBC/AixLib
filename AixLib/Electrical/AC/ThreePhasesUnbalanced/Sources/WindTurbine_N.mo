within AixLib.Electrical.AC.ThreePhasesUnbalanced.Sources;
model WindTurbine_N "Simple wind turbine source with neutral cable"
  extends BaseClasses.UnbalancedWindTurbine_N(
  redeclare AixLib.Electrical.AC.OnePhase.Sources.WindTurbine wt_phase1,
  redeclare AixLib.Electrical.AC.OnePhase.Sources.WindTurbine wt_phase2,
  redeclare AixLib.Electrical.AC.OnePhase.Sources.WindTurbine wt_phase3);
  annotation (
  defaultComponentName="winTur",
 Documentation(revisions="<html>
<ul>
<li>
August 27, 2014, by Marco Bonvini:<br/>
Revised documentation.
</li>
</ul>
</html>", info="<html>
<p>
Simple wind turbine model for three-phase unbalanced systems
with neutral cable connection.
</p>
<p>
For more information, see
<a href=\"modelica://AixLib.Electrical.AC.OnePhase.Sources.WindTurbine\">
AixLib.Electrical.AC.OnePhase.Sources.WindTurbine</a>.
</p>
</html>"),  
   __Dymola_LockedEditing="Model from IBPSA");
end WindTurbine_N;
