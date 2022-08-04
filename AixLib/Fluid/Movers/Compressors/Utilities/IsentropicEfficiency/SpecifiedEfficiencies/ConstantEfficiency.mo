within AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies;
model ConstantEfficiency
  "General model that describes a constant overall isentropic efficiency"
  extends PartialIsentropicEfficiency;

  // Definition of parameters
  //
  parameter Modelica.Units.SI.Efficiency etaIseCon=0.9
    "Constant overall isentropic efficiency";

equation
  // Calculate overall isentropic efficiency
  //
  etaIse = etaIseCon "Allocation of constant overall isentropic efficiency";

  annotation (Documentation(revisions="<html><ul>
  <li>October 20, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model contains a simple calculation procedure for isentropic
  efficiency models (for more information, please check out <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompression\">
  AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompression</a>).
  The model provides a constant overall isentropic efficiency and is
  the most basic engine efficiency model.
</p>
</html>"));
end ConstantEfficiency;
