within AixLib.Fluid.HeatExchangers.HeatPump.Characteristics;
partial function baseFct "Base class for Cycle Characteristic"
  extends Modelica.Icons.Function;
  input Real N;
  input Real T_con;
  input Real T_eva;
  input Real mFlow_eva;
  input Real mFlow_con;
  output Real Char[2];

  annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Base funtion used in HeatPump model. It defines the inputs speed N (1/min), condenser outlet temperature T_co (K) and evaporator inlet temperature T_ev (K). The output is the vector Char: first value is compressor power, second value is the condenser heat flow rate.
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
</html>",
    revisions="<html>
<p><ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul></p>
</html>
"));
end baseFct;
