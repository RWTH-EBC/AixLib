within AixLib.Electrical.PVSystem.BaseClasses;
model IVCharacteristics5pNumerical "Numerical 5-p model for determining the I-V characteristics of a PV array after (DeSoto et al.,2006)"

extends PartialIVCharacteristics;
// Main parameters under standard conditions

Modelica.SIunits.ElectricCurrent I_ph0 "Photo current under standard conditions";

Modelica.SIunits.ElectricCurrent I_s0 "Saturation current under standard conditions";

Modelica.SIunits.Resistance R_s0 "Series resistance under standard conditions";

Modelica.SIunits.Resistance R_sh0 "Shunt resistance under standard conditions";

Real a_0(unit = "V") "Modified diode ideality factor under standard conditions";

// Other parameters and constants

constant Real e=Modelica.Math.exp(1.0) "Euler's constant";

constant Real pi=Modelica.Constants.pi "Pi";

constant Real k(final unit="J/K") = 1.3806503e-23 "Boltzmann's constant";

constant Real q( unit = "A.s")= 1.602176620924561e-19 "Electron charge";

parameter Modelica.SIunits.Energy E_g0=1.79604e-19 "Band gap energy under standard conditions for Si";

parameter Real C=0.0002677 "band gap temperature coefficient for Si";

Modelica.SIunits.ElectricCurrent I_mp(start=I_mp0*0.5) "MPP current";

Modelica.SIunits.Voltage V_mp(start=V_mp0*0.95) "MPP voltage";

Modelica.SIunits.Energy E_g "Band gap energy";

Modelica.SIunits.ElectricCurrent I_s "Saturation current";

Modelica.SIunits.ElectricCurrent I_ph "Photo current";

Modelica.SIunits.Resistance R_s "Series resistance";

Modelica.SIunits.Resistance R_sh "Shunt resistance";

Real a(final unit = "V") "Modified diode ideality factor";

Modelica.SIunits.Power P_mod "Output power of one PV module";

AixLib.Electrical.PVSystem.BaseClasses.PVModule5pNumericalPreCalc pVModule5pNumericalPreCalc(data = data) "Module that determines the main parameters under standard conditions";

equation

  // Numerical parameter extraction under standard conditions

  I_ph0=pVModule5pNumericalPreCalc.I_ph0;

  I_s0=pVModule5pNumericalPreCalc.I_s0;

  R_s0=pVModule5pNumericalPreCalc.R_s0;

  R_sh0=pVModule5pNumericalPreCalc.R_sh0;

  a_0=pVModule5pNumericalPreCalc.a_0;

  // Parameter extrapolation equations to operating conditions

   a/a_0 = T_c/T_c0;

   I_s/I_s0 = (T_c/T_c0)^3*exp(1/k*(E_g0/T_c0-E_g/T_c));

   E_g/E_g0 = 1-C*(T_c-T_c0);

   R_s = R_s0;

   I_ph = if absRadRat > 0 then absRadRat*(I_ph0+TCoeff_Isc*(T_c-T_c0))
   else
    0;

   R_sh/R_sh0 = if absRadRat > 0.001 then 1/absRadRat
   else
    0;

   //Numerical Power correlations at MPP

   I_mp = if absRadRat <= 0.02 then 0
   else
   I_ph-I_s*(exp((V_mp+I_mp*R_s)/a)-1)-(V_mp+I_mp*R_s)/R_sh;

   V_mp = if absRadRat <= 0.02 then 0
   else
   I_mp/((I_s/a*exp((V_mp+I_mp*R_s)/a)+1/R_sh)/(1+R_s/R_sh+I_s*R_s/a*exp((V_mp+I_mp*R_s)/a)));

   // Efficiency and Performance

   eta= if radTil <= 0.01 then 0
   else
   P_mod/(radTil*A_pan);

   P_mod = V_mp*I_mp;

   DCOutputPower=P_mod*n_mod;


  annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p><br><span style=\"font-family: Courier New;\">Numerical 5-p model for determining the I-V characteristics of a PV array (DeSoto et al.,2006).</span></p>
<p><span style=\"font-family: Courier New;\">The final output of this model is the DC performance of the PV array.</span></p>
<p><span style=\"font-family: Courier New;\">Validated with experimental data from NIST (Boyd, 2017).</span></p>
<p><span style=\"font-family: Courier New;\">Approx. 0.3 percent more accurate than the analytical 5-p model, but exhibits initialization and convergence difficulties due to the iterative equations. Approx. 6 percent more accurate than the simple approach using the performance factor.</span></p>
<p><span style=\"font-family: Courier New;\">Module calibration is based on manufactory data.</span></p>
<p><br><h4><span style=\"color: #008000\">References</span></h4></p>
<p><span style=\"font-family: Courier New;\">Sources of literature:</span></p>
<p><span style=\"font-family: Courier New;\">Improvement and validation of a model for photovoltaic array performance. by De Soto, W. ; Klein, S. A. ; Beckman, W. A.</span></p>
<p><span style=\"font-family: Courier New;\">Performance Data from the NIST Photovoltaic Arrays and Weather Station.by Boyd, M.</span></p>
</html>"));
end IVCharacteristics5pNumerical;
