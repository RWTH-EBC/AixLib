within AixLib.Fluid.HeatExchangers.HeatPump.DefrostCorrection;
partial function baseFct
  "Base class for correction model, icing and defrosting of evaporator"
  extends Modelica.Icons.Function;
  input Real T_eva;
  output Real f_CoPicing;
  annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Base funtion used in HeatPump model. Input is the evaporator inlet temperature, output is a CoP-correction factor f_cop_icing.
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
</html>",
  revisions="<html>
<p><ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul></p>
</html>"));
end baseFct;
