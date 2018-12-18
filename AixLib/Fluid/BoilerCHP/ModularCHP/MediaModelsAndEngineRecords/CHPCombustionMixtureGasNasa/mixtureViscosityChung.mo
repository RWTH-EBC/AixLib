within AixLib.Fluid.BoilerCHP.ModularCHP.MediaModelsAndEngineRecords.CHPCombustionMixtureGasNasa;
function mixtureViscosityChung
  "Return the viscosity of gas mixtures without access to component viscosities (Chung, et. al. rules)"
extends Modelica.Icons.Function;

  input Temperature T "Temperature";
  input Temperature[nX] Tc "Critical temperatures";
  input MolarVolume[nX] Vcrit "Critical volumes (m3/mol)";
  input Real[nX] w "Acentric factors";
  input Real[nX] mu "Dipole moments (debyes)";
  input MolarMass[nX] MolecularWeights "Molecular weights (kg/mol)";
  input MoleFraction[nX] y "Molar Fractions";
  input Real[nX] kappa =  zeros(nX) "Association Factors";
  output DynamicViscosity etaMixture "Mixture viscosity (Pa.s)";
protected
constant Real[size(y,1)] Vc =  Vcrit*1000000 "Critical volumes (cm3/mol)";
constant Real[size(y,1)] M =  MolecularWeights*1000
    "Molecular weights (g/mol)";
Integer n = size(y,1) "Number of mixed elements";
Real sigmam3 "Mixture sigma3 in Angstrom";
Real sigma[size(y,1),size(y,1)];
Real edivkm;
Real edivk[size(y,1),size(y,1)];
Real Mm;
Real Mij[size(y,1),size(y,1)];
Real wm "Accentric factor";
Real wij[size(y,1),size(y,1)];
Real kappam
    "Correlation for highly polar substances such as alcohols and acids";
Real kappaij[size(y,1),size(y,1)];
Real mum;
Real Vcm;
Real Tcm;
Real murm "Dimensionless dipole moment of the mixture";
Real Fcm "Factor to correct for shape and polarity";
Real omegav;
Real Tmstar;
Real etam "Mixture viscosity in microP";
algorithm
//combining rules
for i in 1:n loop
  for j in 1:n loop
    Mij[i,j] := 2*M[i]*M[j]/(M[i]+M[j]);
    if i==j then
      sigma[i,j] := 0.809*Vc[i]^(1/3);
      edivk[i,j] := Tc[i]/1.2593;
      wij[i,j] := w[i];
      kappaij[i,j] := kappa[i];
    else
      sigma[i,j] := (0.809*Vc[i]^(1/3)*0.809*Vc[j]^(1/3))^(1/2);
      edivk[i,j] := (Tc[i]/1.2593*Tc[j]/1.2593)^(1/2);
      wij[i,j] := (w[i] + w[j])/2;
      kappaij[i,j] := (kappa[i]*kappa[j])^(1/2);
    end if;
  end for;
end for;
//mixing rules
sigmam3 := (sum(sum(y[i]*y[j]*sigma[i,j]^3 for j in 1:n) for i in 1:n));
//(epsilon/k)m
edivkm := (sum(sum(y[i]*y[j]*edivk[i,j]*sigma[i,j]^3 for j in 1:n) for i in 1:n))/sigmam3;
Mm := ((sum(sum(y[i]*y[j]*edivk[i,j]*sigma[i,j]^2*Mij[i,j]^(1/2) for j in 1:n) for i in 1:n))/(edivkm*sigmam3^(2/3)))^2;
wm := (sum(sum(y[i]*y[j]*wij[i,j]*sigma[i,j]^3 for j in 1:n) for i in 1:n))/sigmam3;
mum := (sigmam3*(sum(sum(y[i]*y[j]*mu[i]^2*mu[j]^2/sigma[i,j]^3 for j in 1:n) for i in 1:n)))^(1/4);
Vcm := sigmam3/(0.809)^3;
Tcm := 1.2593*edivkm;
murm := 131.3*mum/(Vcm*Tcm)^(1/2);
kappam := (sigmam3*(sum(sum(y[i]*y[j]*kappaij[i,j] for j in 1:n) for i in 1:n)));
Fcm := 1 - 0.275*wm + 0.059035*murm^4 + kappam;
Tmstar := T/edivkm;
omegav := 1.16145*(Tmstar)^(-0.14874) + 0.52487*Math.exp(-0.77320*Tmstar) + 2.16178*Math.exp(-2.43787*Tmstar);
etam := 26.69*Fcm*(Mm*T)^(1/2)/(sigmam3^(2/3)*omegav);
etaMixture := etam*1e7;

  annotation (smoothOrder=2,
            Documentation(info="<html>

<p>
Equation to estimate the viscosity of gas mixtures at low pressures.<br>
It is a simplification of an extension of the rigorous kinetic theory
of Chapman and Enskog to determine the viscosity of multicomponent
mixtures, at low pressures and with a factor to correct for molecule
shape and polarity.
</p>

<p>
The input argument Kappa is a special correction for highly polar substances such as
alcohols and acids.<br>
Values of kappa for a few such materials:
</p>

<table style=\"text-align: left; width: 302px; height: 200px;\" border=\"1\"
cellspacing=\"0\" cellpadding=\"2\">
<tbody>
<tr>
<td style=\"vertical-align: top;\">Compound <br>
</td>
<td style=\"vertical-align: top; text-align: center;\">Kappa<br>
</td>
<td style=\"vertical-align: top;\">Compound<br>
</td>
<td style=\"vertical-align: top;\">Kappa<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">Methanol<br>
</td>
<td style=\"vertical-align: top;\">0.215<br>
</td>
<td style=\"vertical-align: top;\">n-Pentanol<br>
</td>
<td style=\"vertical-align: top;\">0.122<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">Ethanol<br>
</td>
<td style=\"vertical-align: top;\">0.175<br>
</td>
<td style=\"vertical-align: top;\">n-Hexanol<br>
</td>
<td style=\"vertical-align: top;\">0.114<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">n-Propanol<br>
</td>
<td style=\"vertical-align: top;\">0.143<br>
</td>
<td style=\"vertical-align: top;\">n-Heptanol<br>
</td>
<td style=\"vertical-align: top;\">0.109<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">i-Propanol<br>
</td>
<td style=\"vertical-align: top;\">0.143<br>
</td>
<td style=\"vertical-align: top;\">Acetic Acid<br>
</td>
<td style=\"vertical-align: top;\">0.0916<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">n-Butanol<br>
</td>
<td style=\"vertical-align: top;\">0.132<br>
</td>
<td style=\"vertical-align: top;\">Water<br>
</td>
<td style=\"vertical-align: top;\">0.076<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">i-Butanol<br>
</td>
<td style=\"vertical-align: top;\">0.132</td>
<td style=\"vertical-align: top;\"><br>
</td>
<td style=\"vertical-align: top;\"><br>
</td>
</tr>
</tbody>
</table>
<p>
Chung, et al. (1984) suggest that for other alcohols not shown in the
table:<br>
&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; kappa = 0.0682 + 4.704*[(number of -OH
groups)]/[molecular weight]<br>
<br>
<span style=\"font-weight: normal;\">S.I. units relation for the
debyes:&nbsp;</span><br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; 1 debye = 3.162e-25 (J.m^3)^(1/2)<br>
</p>
<h4>References</h4>
<p>
[1] THE PROPERTIES OF GASES AND LIQUIDS, Fifth Edition,<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; Bruce E. Poling, John M.
Prausnitz, John P. O'Connell.<br>
[2] Chung, T.-H., M. Ajlan, L. L. Lee, and K. E. Starling: Ind. Eng.
Chem. Res., 27: 671 (1988).<br>
[3] Chung, T.-H., L. L. Lee, and K. E. Starling; Ing. Eng. Chem.
Fundam., 23: 3 ()1984).<br>
</p>
</html>"));
end mixtureViscosityChung;
