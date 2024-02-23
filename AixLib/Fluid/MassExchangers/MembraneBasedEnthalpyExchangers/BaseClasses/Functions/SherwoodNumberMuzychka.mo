within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.Functions;
function SherwoodNumberMuzychka
  "calculates sherwood number out of reynolds and prandtl number according to Muzychka et. al"
  input Real Re "Reynolds number";
  input Real Sc "Schmidt number";
  input Real aspRat "aspect ratio between duct height and width";
  input Real zStern "dimensionless length";
  input Boolean uniWalTem "true if uniform wall temperature boundary conditions";
  input Boolean local "true if local nusslet number or false if average shall be calculated";
  input Real gamma "shape parameter (rectangular duct: 0.1)";

  output Real Sh "Sherwood number";

protected
  Real m "exponent";
  Real C1 "constant C1: 3.24 for UWT(uniform wall temperature), 3.86 for UWF(uniform wall flux)";
  Real C2 "constant C2: 1 for local Nusselt number, 1.5 for average Nusselt number";
  Real C3 "constant C3: 0.409 for UWT, 0.501 for UWF";
  Real C4 "constant C4: 1 for local Nusselt number, 2 for average Nusselt number";
  Real fSc "function for boundary conditions";
  Real fRe "product of Reynolds and friction factor";
  constant Real pi = Modelica.Constants.pi;
algorithm
  // Definition for exponent
  m :=2.27 + 1.65*Sc^(1/3);

  // Defintion for boundary function
  if uniWalTem == true then
    fSc := 0.564/(1+(1.644*Sc^(1/6))^(9/2))^(2/9);
    C1 := 3.24;
    C3 := 0.409;
  else
    fSc := 0.886/(1+(1.909*Sc^(1/6))^(9/2))^(2/9);
    C1 := 3.86;
    C3 := 0.501;
  end if;

  if local == true then
    C2 := 1;
    C4 := 1;
  else
    C2 := 1.5;
    C4 := 2;
  end if;

  // Definition of product of reynolds and friciton factor
  fRe := 12/(sqrt(aspRat) * (1+aspRat) * (1 - (192*aspRat)/(pi^5) * tanh(pi/(2*aspRat))));

  //Calculation of Nusselt number
  Sh := (((C4 * fSc)/sqrt(zStern))^m + ((C2 * C3 * (fRe/zStern)^(1/3))^5 + (C1 * (fRe/(8 * sqrt(pi)*aspRat^gamma)))^5)^(m/5))^(1/m);

  annotation (Documentation(revisions="<html><ul>
  <li>August 21, 2018, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  This function calculates the Sherwood number for a rectangular duct
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
<h4>
  References
</h4>
<p>
  [1]: Muzychka, Y. S.; Yovanovich, M. M. : Laminar Forced Convection
  Heat Transfer in the Combined Entry Region of Non-Circular Ducts ;
  Transactions of the ASME; Vol. 126; February 2004
</p>
</html>"));
end SherwoodNumberMuzychka;
