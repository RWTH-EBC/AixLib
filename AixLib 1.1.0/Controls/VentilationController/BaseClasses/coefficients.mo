within AixLib.Controls.VentilationController.BaseClasses;
function coefficients
  "coeffictients a and b = f(phi) for function Top=a*T_amb + b"
  input Real phi(min=0, max=1) "relative humidity of air";

  output Real c[2] "function offset, proportional factor";
algorithm
  c := {(21.0 - 22.1)/(0.7 - 0.3)*phi + (21.525 + 0.0275*50),
        (0.116 - 0.112)/(0.7 - 0.3)*phi + (0.112 - 1e-4*30)};
  annotation (Documentation(revisions="<html><ul>
  <li>
    <i>October, 2015&#160;</i> by Moritz Lauster:<br/>
    Adapted and moved to AixLib
  </li>
</ul>
</html>"));
end coefficients;
