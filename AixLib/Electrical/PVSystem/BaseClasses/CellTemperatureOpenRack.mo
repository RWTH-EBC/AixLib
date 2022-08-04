within AixLib.Electrical.PVSystem.BaseClasses;
model CellTemperatureOpenRack
   "Empirical model for determining the cell temperature of a PV module mounted on an 
   open rack"

 extends AixLib.Electrical.PVSystem.BaseClasses.PartialCellTemperature;

  final parameter Modelica.Units.SI.Temperature T_a_0=293.15
    "Reference ambient temperature";
 final parameter Real coeff_trans_abs = 0.9
 "Module specific coefficient as a product of transmission and absorption.
 It is usually unknown and set to 0.9 in literature";

equation

 T_c = if noEvent(radTil >= Modelica.Constants.eps) then
 (T_a)+(T_NOCT-T_a_0)*radTil/radNOCT*9.5/(5.7+3.8*winVel)*(1-eta/coeff_trans_abs)
 else
 (T_a);

 annotation (
  Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Model for determining the cell temperature of a PV module mounted on
  an open rack under operating conditions and under consideration of
  the wind velocity.
</p>
<p>
  <br/>
</p>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<p>
  <q>Solar engineering of thermal processes.</q> by Duffie, John A. ;
  Beckman, W. A.
</p>
</html>
"));
end CellTemperatureOpenRack;
