within AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency;
model ConstantEfficiency
  "General model that describes a constant overall isentropic efficiency"
  extends PartialIsentropicEfficiency;

  // Definition of parameters
  //
  parameter Modelica.SIunits.Efficiency etaIseCon = 0.9
    "Constant overall isentropic efficiency";

equation
  // Calculate overall isentropic efficiency
  //
  etaIse = etaIseCon "Allocation of constant overall isentropic efficiency";

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
