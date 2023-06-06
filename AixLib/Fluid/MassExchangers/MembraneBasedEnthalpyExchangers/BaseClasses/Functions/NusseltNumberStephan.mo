within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.Functions;
function NusseltNumberStephan
  "calculates nusselt number out of reynolds and prandtl number according to Stephan, K."

  // Inputs
  input Modelica.Units.SI.Length dimension "characteristic dimension";
  input Modelica.Units.SI.Length length "length of flat gap";
  input Real Pr "Prandtl number";
  input Real Re "Reynolds number";

  // Outputs
  output Real Nu "Nusselt number";

algorithm

  Nu := 7.55+(0.024*(Pr*Re*dimension/length)^(1.14))/(1+0.0358*Pr^(0.81)*
        (Pr*dimension/length)^(0.64));

  annotation (Documentation(revisions="<html><ul>
  <li>November 14, 2019, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  This function calculates the Nusselt number for a flat gap according
  to Stephan [1].
</p>
<h4>
  References
</h4>
<p>
  [1]: Stephan, K.: Waermeuebergang und Druckabfall bei nicht
  ausgebildeter Laminarstroemung in Rohren und ebenen Spalten.
  Chemie-Ing.-Techn. Vol. 31, no. 12, 1959 pp. 773-778
</p>
</html>"));
end NusseltNumberStephan;
