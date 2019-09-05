within AixLib.Electrical.PVSystem.BaseClasses;
model CellTemperatureOpenRack
   "Model for determining the cell temperature of a PV module mounted on an open rack"

 extends AixLib.Electrical.PVSystem.BaseClasses.PartialCellTemperature;

equation

 T_c = if radTil >= 0.01 then
 (T_a+273.15)+(T_NOCT-293.15)*radTil/radNOCT*9.5/(5.7+3.8*winVel)*(1-eta/0.9)
 else
 (T_a+273.15);


 annotation (
  Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Model for determining the cell temperature of a PV module mounted on an open rack under operating conditions and under consideration of the wind velocity.</p>
<p><br/>
<h4><span style=\"color: #008000\">References</span></h4>
<p><q>Solar engineering of thermal processes.</q> by Duffie, John A. ; Beckman, W. A.</p>
</ul>
</html>
"));
end CellTemperatureOpenRack;
