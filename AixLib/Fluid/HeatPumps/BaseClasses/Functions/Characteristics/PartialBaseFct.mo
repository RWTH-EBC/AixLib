within AixLib.Fluid.HeatPumps.BaseClasses.Functions.Characteristics;
partial function PartialBaseFct "Base class for Cycle Characteristic"
  extends Modelica.Icons.Function;
  input Real N;
  input Real T_con;
  input Real T_eva;
  input Real mFlow_eva;
  input Real mFlow_con;
  output Real Char[2];

  annotation (Documentation(info="<html>
<p>Base funtion used in HeatPump model. It defines the inputs speed N (1/min), condenser outlet temperature T_co (K) and evaporator inlet temperature T_ev (K). The output is the vector Char: first value is compressor power, second value is the condenser heat flow rate. </p>
</html>",
    revisions="<html>
<ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul>
</html>
"));
end PartialBaseFct;
