within AixLib.Electrical.PVSystem.BaseClasses;
model CellTemperatureMountingCloseToGround
  "Empirical model for determining the cell temperature of a PV module mounted with the 
  module backsite close to the ground"

 extends AixLib.Electrical.PVSystem.BaseClasses.PartialCellTemperature;

equation

 T_c = if noEvent(radTil >= Modelica.Constants.eps) then
 radTil*(exp(-2.98-0.0471*winVel))+(T_a)+radTil/1000*1
 else
 (T_a);

 annotation (
  Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Model for determining the cell temperature of a PV module mounted
  with the module backsite close to the ground, under operating
  conditions and under consideration of the wind velocity.
</p>
<p>
  <br/>
</p>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<p>
  <q>SANDIA REPORT SAND 2004-3535 Unlimited Release Printed December
  2004 Photovoltaic Array Performance Model. (2005).</q> by King, D. L.
  et al.
</p>
</html>
"));
end CellTemperatureMountingCloseToGround;
