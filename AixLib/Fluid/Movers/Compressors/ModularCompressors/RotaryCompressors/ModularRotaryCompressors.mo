within AixLib.Fluid.Movers.Compressors.ModularCompressors.RotaryCompressors;
model ModularRotaryCompressors
  "Model of simple rotary compressors in parallel"
  extends BaseClasses.PartialModularCompressors(
    redeclare
    Controls.HeatPump.ModularHeatPumps.ModularCompressorController modCon,
    redeclare
    SimpleCompressors.RotaryCompressors.RotaryCompressor modCom);


equation
  // Connect port_a with inlet ports of expansion valves and connect heat ports
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
end ModularRotaryCompressors;
