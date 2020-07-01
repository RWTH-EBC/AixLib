within AixLib.FastHVAC.Interfaces;
connector EnthalpyPort_b "Outlet enthalpy connector non-Fluid models"
  extends AixLib.FastHVAC.Interfaces.EnthalpyPort;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={176,0,0}, thickness={0.5},
          fillColor={176,0,0},
          fillPattern=FillPattern.Solid), Ellipse(
          extent={{-54,50},{52,-52}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html><p>
  This model defines a inlet enthalpy port used within the FastHVAC
  package
</p>
</html>", revisions="<html>
<ul>
  <li>
    <i>April 25, 2017</i>, by Michael Mans:<br/>
    Moved to AixLib
  </li>
</ul>
</html>"));
end EnthalpyPort_b;
