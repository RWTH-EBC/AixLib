within AixLib.Electrical.PVSystem.BaseClasses;
model CellTemperatureSimple
  "Model for determining the cell temperature of a PV module mounted on an open rack, under open circuit conditions, without wind dependency."

 extends AixLib.Electrical.PVSystem.BaseClasses.PartialCellTemperature;

equation

 T_c = if radTil >= 0.01 then
 (T_a)+(T_NOCT-293.15)*radTil/radNOCT
 else
 (T_a);

 annotation (
  Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Model for determining the cell temperature of a PV module mounted on an open rack, under open circuit conditions, without wind dependency.</p>
<p><br/>
<h4><span style=\"color: #008000\">References</span></h4>
<p><q>Thermal modelling to analyze the effect of cell temperature on PV
modules energy efficiency</q> by Romary, Florian et al.</p>
</ul>
</html>
"));
end CellTemperatureSimple;
