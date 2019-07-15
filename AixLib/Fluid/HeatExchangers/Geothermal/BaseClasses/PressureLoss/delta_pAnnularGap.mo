within AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.PressureLoss;
function delta_pAnnularGap
  extends
    AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.PressureLoss.delta_p_partial;

algorithm
 // Berechnung nach Gnielinski2007, glattes Rohr
 w := m_dot/d/((d_o^2 - d_i^2)*Modelica.Constants.pi/4);
 Re := abs(w)*d_h/ny;

 if Re <= 2300 then
  if Re <=0 then
   xi:=0;
  else
   xi := 64/phi/Re;
  end if;
 else
   xi := (1.8*Modelica.Math.log10(phi*Re) - 1.5)^(-2);
 end if;
 dpFG := xi*d*w^2/2*L/d_h + height*(gravity)*d;
  annotation (Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>Pressure loss in annular gap.</p>
</html>",
    revisions="<html>
<p><ul>
<li><i>January 10, 2014&nbsp;</i> by Kristian Huchtemann:<br/>Implemented.</li>
</ul></p>
</html>"));
end delta_pAnnularGap;
