within AixLib.Electrical.PVSystem.BaseClasses;
model CellTemperatureMountingContactToGround
  "Empirical model for determining the cell temperature of a PV module mounted with the 
  module backsite in contact with the ground"

extends AixLib.Electrical.PVSystem.BaseClasses.PartialCellTemperature;

equation

 T_c = if noEvent(radTil >= Modelica.Constants.eps) then
     radTil*(exp(-2.81-0.0455*winVel))+(T_a)
 else
 (T_a);

  annotation (Documentation(info="<html><h4>
  Overview
</h4>
<p>
  Model for determining the cell temperature of a PV module mounted
  with the module backside in contact with the ground, under operating
  conditions and under consideration of the wind velocity. E.g. roof
  integrated PV modules.
</p>
<p>
  <br/>
  <b>References</b>
</p>
<p>
  SANDIA REPORT SAND 2004-3535 Unlimited Release Printed December 2004
  Photovoltaic Array Performance Model. (2005). by King, D. L. et al.
</p>
</html>"));
end CellTemperatureMountingContactToGround;
