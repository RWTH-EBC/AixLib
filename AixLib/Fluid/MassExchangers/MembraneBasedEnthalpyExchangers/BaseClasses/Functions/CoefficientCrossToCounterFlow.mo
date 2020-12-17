within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.Functions;
function CoefficientCrossToCounterFlow
  "Calculates coefficient of efficiency of cross flow exchanger to counter flow exchanger based on NTU-method"
  input Real NTU "number of transfer units";
  output Real coeCroCou "coefficient for reduced efficiency in quasi-counter flow";
algorithm
  coeCroCou :=-9E-5*NTU^3 + 0.0023*NTU^2 - 0.0207*NTU + 0.956;
  // polynom calculated by curve fit for min(m_flow * cp)/max(m_flow * cp) = 1 with accuracy of 0,2 percent standard deviation
  annotation (Documentation(revisions="<html>
<ul>
<li>August 21, 2018, by Martin Kremer:<br>First implementation. </li>
</ul>
</html>", info="<html>
<p>This function calculates an coefficient to derive the heat/mass transfer of a cross-flow enthalpy exchanger out of the heat/mass transfer of a counter-flow enthalpy exchanger.</p>
<p>The coefficient calculation is based on the effectiveness correlations for the NTU-Method[1]. </p>
<p>The effectiveness of a counter-flow heat exchanger can be expressed as:</p>
<p align=\"center\"><i>&epsilon; = (1 - exp[- NTU (1 - C<sub>r</sub> )]) &frasl; (1 - C<sub>r</sub> exp[- NTU (1 - C<sub>r</sub> )]) </i></p>
<p align=\"center\">for (C<sub>r</sub> &lt; 1) </p>
<p align=\"center\"><i>&epsilon; = NTU &frasl; (1 + NTU) </i></p>
<p align=\"center\">for (C<sub>r</sub> = 1) </p>
<p>With</p>
<p align=\"center\"><i>C<sub>r</sub> = (ṁ c<sub>p</sub> )<sub>min</sub> &frasl; (ṁ c<sub>p</sub> )<sub>max</sub> </i></p>
<p>The effectiveness of a cross-flow heat exchanger can be expressed as:</p>
<p align=\"center\"><i>&epsilon; = 1 - exp[(exp(- NTU<sup> 0.78</sup> C<sub>r</sub> ) - 1 ) &frasl; (NTU<sup> -0.22</sup> C<sub>r</sub> )] </i></p>
<p>By dividing the correlation for the cross-flow heat exchanger through the correlation for the counter-flow heat exchanger it is possible to derive the efficiency of a cross-flow heat exhcanger from the efficiency of a counter-flow heat exchanger.</p>
<p align=\"center\"><i>C = &epsilon;<sub>cross</sub> &frasl; &epsilon;<sub>counter</sub> = f(NTU,C<sub>r</sub>) </i></p>
<p>The coefficient <i>C</i> was evaluated for different <i>NTU</i> and <i>C<sub>r</i></sub> . It has shown, that for <i>C<sub>r  </i></sub> near to 1 the coefficient can be approximated through a polynom of third degree:</p>
<p align=\"center\"><i>C = -9 &middot; 10<sup> -5</sup> NTU<sup> 3</sup> + 0.0023 NTU<sup> 2</sup> - 0.0207 NTU + 0.956 </i></p>
<p> </p>
<p><br><br><br>[1]: Incropera, F.P.; De Witt, D.P.; Bergman, T. L.; Lavine, A. S. :<i> Fundamentals of Heat and Mass Transfer </i>; 6th Edition; 2007; John Wiley &amp; Sons, Inc.<i> </i></p>
</html>"));
end CoefficientCrossToCounterFlow;
