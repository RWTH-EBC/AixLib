within AixLib.Fluid.Movers.Compressors.ModularCompressors;
model ModularCompressors
  "Model of simple modular compressors"
  extends BaseClasses.PartialModularCompressors;

equation
  // Connect port_b with compressors' port_b
  //
  for i in 1:nCom loop
    connect(modCom[i].port_b,port_b);
  end for;

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 20, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end ModularCompressors;
