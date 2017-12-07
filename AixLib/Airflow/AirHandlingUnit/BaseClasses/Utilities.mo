within AixLib.Airflow.AirHandlingUnit.BaseClasses;
package Utilities "Utilities and functions for the AHU"
  extends Modelica.Icons.UtilitiesPackage;
  function relativePartialPressureLiCl
    "gives the relative partial vapor pressure of water in LiCl at a given temperature and concentration in relation to air"
    extends Modelica.Icons.Function;

    input Real Theta "reduced temperature value of desiccant solution, T/Tc_H2O";
    input Real x( min = 0.25, max = 0.5)  "mass fraction of solute";

    output Real pi "Function value, relative water vapour pressure, pw_s / pw_a";

  protected
    parameter Real pi_0 =   0.28;
    parameter Real pi_1 =   4.3;
    parameter Real pi_2 =   0.6;
    parameter Real pi_3 =   0.21;
    parameter Real pi_4 =   5.1;
    parameter Real pi_5 =   0.49;
    parameter Real pi_6 =   0.362;
    parameter Real pi_7 =   -4.75;
    parameter Real pi_8 =   -0.4;
    parameter Real pi_9 =   0.03;

    Real A =   2-(1+(x/pi_0)^pi_1)^pi_2;
    Real B =   (1+(x/pi_3)^pi_4)^pi_5 - 1;

    Real f = A + B * Theta;

    Real pi_25 = 1-(1+(x/pi_6)^pi_7)^pi_8 - pi_9 * Modelica.Math.exp(-((x-0.1)^2/0.005));

  algorithm

      pi := pi_25 * f;

  end relativePartialPressureLiCl;

  function partialPressureWater
    "gives the partial vapour pressure of water at given temperature"

    input Real T "in K, Temperature of water/ desiccant solution";

    output Real pw_l;

  protected
    Real T_c = 647.096 "temperature at critical point of water in K"; //374 °C
    Real p_c = 22060000 "pressure at critical point of water in Pa";  // 22.06 MPa

    Real A0 =   -7.858230;
    Real A1 =   1.839910;
    Real A2 =   -11.781100;
    Real A3 =   22.670500;
    Real A4 =   -15.939300;
    Real A5 =   1.775160;

    Real tau = 1-(T/T_c);

    Real B = (A0*tau+A1*tau^1.5+A2*tau^3+A3*tau^3.5+A4*tau^4+A5*tau^7.5)/(1 - tau);

    //Antoine

    //Real A = 8.07131;
    //Real B = 1730.63;
    //Real C = 233.426;

    //Real D = A - B/(C+T-273.15);

  algorithm

    pw_l := Modelica.Math.exp(B)  *  p_c;
    //pw_l := 10^(D) * 133.3224;

  end partialPressureWater;

  function partialPressureAir "partial vapor pressure of humid air"

    input Modelica.SIunits.Temperature T "temperature of air in K";
    input Real rh "relative humidity of air between 0 and 1";

    output Modelica.SIunits.PartialPressure pw_a "in Pa, partial vapor pressure in air";

    //Factors for T in °C and p in Pa
  protected
    Real A = 611;
    Real B = 7.5;
    Real C = 35.85;

    Real Z = B*(T-273.15)/(T-C);

    //saturation vapor pressure in air
    Real pws_a = A * 10^Z;

  algorithm

    pw_a := rh * pws_a;

  end partialPressureAir;

  function densityLiCl
    "returns the density of a LiCl desiccant solution"

    input Modelica.SIunits.Temperature T "Temperature of solution";
    input Real x( min=0, max=1) "concentration of LiCl desiccant solution";
    //input Real theta (min=0, max=1) "reduced temperature";

    output Modelica.SIunits.Density rho "density of LiCl solution";

  protected
    Modelica.SIunits.Density rho_cw =   322
      "density of water at critical point in kg/m^3";
    Modelica.SIunits.Density rho_w =   rho_cw * (1 + B0*tau^(1/3) + B1*tau^(2/3)
      + B2*tau^(5/3) + B3*tau^(16/3) + B4*tau^(43/3) + B5*tau^(110/3))
      "density of water in kg/m^3";
    Modelica.SIunits.Temperature Tc_H2O =   647.096
      "density of water at critical point in kg/m^3";
    Real theta =   T/Tc_H2O "reduced Temperature";
    Real tau =   1 - theta;

    Real x1 =   x/(1-x);

    Real rho0 = 1;
    Real rho1 = 0.540966;
    Real rho2 = -0.303792;
    Real rho3 = 0.100791;

    Real B0 = 1.9937718430;
    Real B1 = 1.0985211604;
    Real B2 = -0.5094492996;
    Real B3 = -1.7619124270;
    Real B4 = -45.9005480267;
    Real B5 = -723692.2618632;

  algorithm

    rho := rho_w * (rho0*x1^0 + rho1*x1^1 + rho2*x1^2 + rho3*x1^3);

  end densityLiCl;

  function specificHeatCapacityCpLiCl
    "returns the specific heat capacity Cp for a LiCl desiccant solution"

    input Modelica.SIunits.Temperature T "in K, temperature of brine";
    input Real x "concentration of solution";

    output Modelica.SIunits.SpecificHeatCapacity cp
      "in J/kgK, specific heat capacity of LiCl solution";

  protected
    Real a = 88.7891;
    Real b = -120.1958;
    Real c = -16.9264;
    Real d = 52.4654;
    Real e = 0.10826;
    Real f = 0.46988;

    Real A = 1.43980;
    Real B = -1.24317;
    Real C = -0.12070;
    Real D = 0.12825;
    Real E = 0.62934;
    Real F = 58.5225;
    Real G = -105.6343;
    Real H = 47.7948;

    Real theta = T/228 - 1;
    Modelica.SIunits.SpecificHeatCapacity cp_w =   (a + b*theta^0.02
        + c*theta^0.04 + d*theta^0.06 + e*theta^1.8 + f*theta^8)*1000;

    //Real f1  =  A*x + B*x^2 + C*x^3 "für x <= 0.31";
    Real f1 =   D + E*x "für x>0.31";
    Real f2 =   F*theta^0.02 + G*theta^0.04 + H*theta^0.06;
  algorithm

    cp := cp_w *(1-f1*f2);

  end specificHeatCapacityCpLiCl;
end Utilities;
