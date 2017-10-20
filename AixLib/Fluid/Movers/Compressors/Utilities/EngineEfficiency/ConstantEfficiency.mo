within AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency;
model ConstantEfficiency
  "General model that describes a constant overall engine efficiency"
  extends PartialEngineEfficiency;

  // Definition of parameters
  //
  parameter Modelica.SIunits.Efficiency etaEngCon = 0.9
    "Constant overall engine efficiency";

equation
  // Calculate overall engine efficiency
  //
  etaEng = etaEngCon "Allocation of constant overall engine efficiency";

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 20, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end ConstantEfficiency;
