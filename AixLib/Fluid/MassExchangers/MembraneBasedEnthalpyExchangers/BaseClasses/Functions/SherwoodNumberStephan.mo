within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.Functions;
function SherwoodNumberStephan
  "calculates sherwood number out of reynolds and schmidt number according to Stephan, K."

  // Inputs
  input Modelica.Units.SI.Length dimension "characteristic dimension";
  input Modelica.Units.SI.Length length "length of flat gap";
  input Real Sc "Schmidt number";
  input Real Re "Reynolds number";

  // Outputs
  output Real Sh "Sherwood number";

algorithm

  Sh := 7.55+(0.024*(Sc*Re*dimension/length)^(1.14))/(1+0.0358*Sc^(0.81)*
        (Re*dimension/length)^(0.64));

  annotation (Documentation(info="<html><p>
  This function calculates the Sherwood number for a flat gap according
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
</html>", revisions="<html>
<ul>
  <li>November 15, 2019, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end SherwoodNumberStephan;
