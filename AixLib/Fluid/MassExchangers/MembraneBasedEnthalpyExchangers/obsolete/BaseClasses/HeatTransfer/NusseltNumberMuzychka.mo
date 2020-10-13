within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.obsolete.BaseClasses.HeatTransfer;
function NusseltNumberMuzychka
  "claculates nusselt number out of reynolds and prandtl number according to Muzychka et. al"
  input Real Re "Reynolds number";
  input Real Pr "Prandtl number";
  input Real aspectRatio "aspect ratio between duct height and width";
  input Real zStern "dimensionless length";
  input Boolean UWT "true if UWT boundary conditions";
  input Real C1 "constant C1";
  input Real C2 "constant C2";
  input Real C3 "constant C3";
  input Real C4 "constant C4";
  input Real gamma "shape parameter (rectangular duct: 0.1)";

  output Real Nu "Nusselt number";

protected
  Real m "exponent";
  Real fPr "function for boundary conditions";
  Real fRe "product of Reynolds and friction factor";
  constant Real pi = Modelica.Constants.pi;
algorithm
  // Definition for exponent
  m :=2.27 + 1.65*Pr^(1/3);

  // Defintion for boundary function
  if UWT == true then
    fPr := 0.564/(1+(1.644*Pr^(1/6))^(9/2))^(2/9);
  else
    fPr := 0.886/(1+(1.909*Pr^(1/6))^(9/2))^(2/9);
  end if;

  // Definition of product of reynolds and friciton factor
  fRe := 12/(sqrt(aspectRatio) * (1+aspectRatio) * (1 - (192*aspectRatio)/(pi^5) * tanh(pi/(2*aspectRatio))));

  //Calculation of Nusselt number
  Nu := (((C4 * fPr)/sqrt(zStern))^m + ((C2 * C3 * (fRe/zStern)^(1/3))^5 + (C1 * (fRe/(8 * sqrt(pi)*aspectRatio^gamma)))^5)^(m/5))^(1/m);

  annotation (Documentation(revisions="<html><ul>
  <li>August 21, 2018, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  This function calculates the Nusselt number for a rectangular duct
  according to Muzychka and Yovanovich [1].
</p>
<p>
  <br/>
  The dimensionless length zStern as input has to be calculated as
  follows.
</p>
<p style=\"text-align:center;\">
  <i>zStern = (s<sub>duct</sub> ⁄ √A<sub>cross-section</sub> ) ⁄ (Re Pr
  )</i>
</p>
<p>
  <br/>
  <br/>
  <br/>
  [1]: Muzychka, Y. S.; Yovanovich, M. M. : Laminar Forced Convection
  Heat Transfer in the Combined Entry Region of Non-Circular Ducts ;
  Transactions of the ASME; Vol. 126; February 2004
</p>
</html>"));
end NusseltNumberMuzychka;
