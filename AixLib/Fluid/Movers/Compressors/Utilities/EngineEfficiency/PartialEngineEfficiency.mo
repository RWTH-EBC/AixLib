within AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency;
partial model PartialEngineEfficiency
  "Based model used by all models describing engine efficiencies"
  extends BaseClasses.PartialEfficiency;

  // Definition of outputs
  //
  output Modelica.SIunits.Efficiency etaEng(min=0, max=1, nominal= 0.9)
    "Overall engine efficiency";

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 20, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end PartialEngineEfficiency;
