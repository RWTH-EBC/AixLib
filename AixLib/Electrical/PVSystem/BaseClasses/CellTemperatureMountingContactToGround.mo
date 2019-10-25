within AixLib.Electrical.PVSystem.BaseClasses;
model CellTemperatureMountingContactToGround
   "Model for determining the cell temperature of a PV module mounted with the module backsite in contact with the ground"

 extends AixLib.Electrical.PVSystem.BaseClasses.PartialCellTemperature;

equation

 T_c = if radTil >= 0.01 then
 radTil*(exp(-2.81-0.0455*winVel))+(T_a)
 else
 (T_a);


 annotation (
  Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Model for determining the cell temperature of a PV module mounted with the module backsite in contact with the ground,
under operating conditions and under consideration of the wind velocity. E.g. roof integrated PV modules.</p>
<p><br/>
<h4><span style=\"color: #008000\">References</span></h4>
<p><q>SANDIA REPORT SAND 2004-3535 Unlimited Release Printed December 2004 Photovoltaic
Array Performance Model. (2005).</q> by King, D. L. et al.</p>
</ul>
</html>
"));
end CellTemperatureMountingContactToGround;
