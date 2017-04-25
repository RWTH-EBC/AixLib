within AixLib.FastHVAC.Interfaces;
connector EnthalpyPort_b "Outlet connector non-Fluid"
  extends EnthalpyPort;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={176,0,0}, thickness={0.5},
          fillColor={176,0,0},
          fillPattern=FillPattern.Solid), Ellipse(
          extent={{-54,50},{52,-52}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>This model defines a inlet enthalpy port for fast non fluid HVAC models</p>
<h4>Implementation</h4>
</html>"));
end EnthalpyPort_b;
