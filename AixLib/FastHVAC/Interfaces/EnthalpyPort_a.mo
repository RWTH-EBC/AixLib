within AixLib.FastHVAC.Interfaces;
connector EnthalpyPort_a "Inlet enthalpy connector non-Fluid models"
  extends EnthalpyPort;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={176,0,0}, thickness={0.5},
          fillPattern=FillPattern.Solid,
          fillColor={176,0,0})}), Documentation(info="<html>
<p>This model defines a inlet enthalpy port for fast non fluid HVAC models</p>
<p><br><b>Implementation</b></p>
</html>", revisions="<html>
<ul>
<li>
April 25, 2017, by Michael Mans:<br/>
Moved to AixLib
</li>
</ul>
</html>"));
end EnthalpyPort_a;
