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

  annotation (Documentation(revisions="<html><ul>
  <li>October 20, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a model of modular compressors that are used, for example, in
  close-loop systems like heat pumps or chillers.<br/>
  It consists of <code>nCom</code> compressors in parallel and also
  <code>nCom</code> PID conrollers if no external controller is used.
</p>
<h4>
  Modeling approaches
</h4>
<p>
  This base model mainly consists of two sub-models. Therefore, please
  checkout these sub-models for further information of underlying
  modeling approaches and parameterisation:
</p>
<ul>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompressor\">
    AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompressor</a>.
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Controls.HeatPump.ModularHeatPumps.ModularCompressorController\">
    AixLib.Controls.HeatPump.ModularHeatPumps.ModularCompressorController</a>.
  </li>
</ul>
<p>
  The first sub-model describes a simple compressor that is defined in
  <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.SimpleCompressors\">AixLib.Fluid.Movers.Compressors.SimpleCompressors</a>;
  the second sub-model describes the internal controller model.
</p>
</html>"),  Diagram(graphics={Line(points={{-100,0},{-10,0}},
                    color={0,127,255}),
                              Line(points={{10,0},{100,0}},
                    color={0,127,255}),
                              Line(points={{0,10},{0,100}},
                    color={191,0,0})}));
end ModularCompressors;
