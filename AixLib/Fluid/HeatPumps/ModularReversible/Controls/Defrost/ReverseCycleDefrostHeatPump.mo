within AixLib.Fluid.HeatPumps.ModularReversible.Controls.Defrost;
model ReverseCycleDefrostHeatPump
  "Heat pump in reverse cycle operation during defrost"
  extends
    AixLib.Fluid.Chillers.ModularReversible.RefrigerantCycle.BaseClasses.PartialChillerCycle(
    QCoo_flow_nominal=-PEle_nominal*COP_constant*y_constant,
    PEle_nominal=2000,
    redeclare final
      AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.NoFrosting
      iceFacCal,
    devIde="DefrostEfficiency");
  parameter Real COP_constant = 6.25 "COP during defrost (useful side is the evaporator)";
  parameter Real y_constant = 0.275 "Constant defrost compressor speed";
  Modelica.Blocks.Sources.Constant conPEle(k=PEle_nominal*y_constant) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,30})));
  Modelica.Blocks.Sources.Constant conQEva_flow(k=-PEle_nominal*COP_constant*
        y_constant)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,30})));

equation
  connect(conPEle.y, PEle) annotation (Line(points={{30,19},{30,-54},{0,-54},{0,
          -130}}, color={0,0,127}));
  connect(conQEva_flow.y, proRedQEva.u2) annotation (Line(points={{70,19},{70,-14},
          {-24,-14},{-24,-78}}, color={0,0,127}));
  connect(conPEle.y, redQCon.u2) annotation (Line(points={{30,19},{30,-54},{64,-54},
          {64,-78}}, color={0,0,127}));
  annotation (               Documentation(revisions="<html>
<ul>
  <li>
    <i>December 22, 2025</i> by Fabian Roemer:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1520\">AixLib #1623</a>)
  </li>
</ul>
</html>", info="<html>
This model can be used to estimate the heat pumps behavior during defrost. 
It assumes a constant COP and a constant compressor speed (usually low to have efficient defrost).
The default values were calibrated for the custom build heat pump at the Institute EBC.
Still, note that the model heavily simplifies the real dynamics during defrost.
The model was used for studies in the PhD of Fabian Römer, e.g. the publication Römer et al.
<h4>References</h4>
<p>
Römer, Fabian and Fuchs, Nico and Fuchs, Nico and Müller, Dirk, Practical, Near-Optimal Design Rule Extraction for Heat Pumps in Single-Family Buildings (September 03, 2025). Available at SSRN: 
<a href=\"https://ssrn.com/abstract=5633891\">https://ssrn.com/abstract=5633891</a>
</p>
</html>"));
end ReverseCycleDefrostHeatPump;
