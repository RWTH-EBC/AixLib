within AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies;
model ConstantEfficiency
  "General model that describes a constant overall engine efficiency"
  extends PartialEngineEfficiency(
    final useIseWor=false);

  // Definition of parameters
  //
  parameter Modelica.Units.SI.Efficiency etaEngCon=0.9
    "Constant overall engine efficiency";

equation
  // Calculate overall engine efficiency
  //
  etaEng = etaEngCon "Allocation of constant overall engine efficiency";

  annotation (Documentation(revisions="<html><ul>
  <li>October 20, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model contains a simple calculation procedure for engine
  efficiency models (for more information, please check out <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompression\">
  AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompression</a>).
  The model provides a constant overall engine efficiency and is the
  most basic engine efficiency model.
</p>
</html>"));
end ConstantEfficiency;
