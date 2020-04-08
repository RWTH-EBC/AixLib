within AixLib.DataBase.ThermalMachines.HeatPump.Functions.DefrostCorrection;
partial function PartialBaseFct
  "Base class for correction model, icing and defrosting of evaporator"
  extends Modelica.Icons.Function;
  input Real T_eva;
  output Real f_CoPicing;
  annotation (Documentation(info="<html>
<p>Base funtion used in HeatPump model. Input is the evaporator inlet temperature, output is a CoP-correction factor f_cop_icing. </p>
</html>",
  revisions="<html>
<ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul>
</html>"));
end PartialBaseFct;