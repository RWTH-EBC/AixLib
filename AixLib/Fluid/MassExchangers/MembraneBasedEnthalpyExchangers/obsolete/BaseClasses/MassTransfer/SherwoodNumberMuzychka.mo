within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.obsolete.BaseClasses.MassTransfer;
function SherwoodNumberMuzychka
  "calculates sherwood number out of reynolds and schmidtl number according to Muzychka et. al"
  input Real Re "Reynolds number";
  input Real Sc "Schmidt number";
  input Real aspectRatio "aspect ratio between duct height and width";
  input Real zStern "dimensionless length";
  input Boolean UWT "true if UWT (uniform wall temperature) boundary conditions";
  input Real C1 "constant C1: 3.24 for UWT(uniform wall temperature), 3.86 for UWF(uniform wall flux)";
  input Real C2 "constant C2: 1 for local Nusselt number, 1.5 for average Nusselt number";
  input Real C3 "constant C3: 0.409 for UWT, 0.501 for UWF";
  input Real C4 "constant C4: 1 for local Nusselt number, 2 for average Nusselt number";
  input Real gamma "shape parameter (rectangular duct: 0.1)";

  output Real Sh( unit="1") "Sherwood number";

protected
  Real m "exponent";
  Real fSc "function for boundary conditions";
  Real fRe "product of Reynolds and friction factor";
  constant Real pi = Modelica.Constants.pi;
algorithm
  // Definition for exponent
  m :=2.27 + 1.65*Sc^(1/3);

  // Defintion for boundary function
  if UWT == true then
    fSc := 0.564/(1+(1.644*Sc^(1/6))^(9/2))^(2/9);
  else
    fSc := 0.886/(1+(1.909*Sc^(1/6))^(9/2))^(2/9);
  end if;

  // Definition of product of reynolds and friciton factor
  fRe := 12/(sqrt(aspectRatio) * (1+aspectRatio) * (1 - (192*aspectRatio)/(pi^5) * tanh(pi/(2*aspectRatio))));

  //Calculation of Sherwood number
  Sh := (((C4 * fSc)/sqrt(zStern))^m + ((C2 * C3 * (fRe/zStern)^(1/3))^5 + (C1 * (fRe/(8 * sqrt(pi)*aspectRatio^gamma)))^5)^(m/5))^(1/m);

  annotation (Documentation(revisions="<html><ul>
  <li>August 21, 2018, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  This function calculates the Sherwood number for a rectangular duct
  in analogy to the Nusselt number according to Muzychka and Yovanovich
  [1].
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
end SherwoodNumberMuzychka;
