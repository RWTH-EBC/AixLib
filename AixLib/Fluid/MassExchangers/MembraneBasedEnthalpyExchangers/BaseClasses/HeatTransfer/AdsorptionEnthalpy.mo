within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.HeatTransfer;
model AdsorptionEnthalpy
  "model that calculates the adsorption enthalpy based on the Dubinin-Astakhov equation"

  //============ parameters ====================

  //calculation of water uptake in adsorbent
  parameter Real F
    "material specific asdoprtion characteristic constant";
  parameter Real n
    "material specific asdoprtion characteristic constant";
  parameter Modelica.SIunits.SpecificVolume v_0(min=0)
    "micropore volume per unit mass of absorbent";

  //calculation of adsorption heat
protected
  constant Real R_g(unit="J/(kg.K)") = 461.4 "specific gas constant of water vapour";
  constant Real A(unit="m.m.m/(kg.K)") = 1.8105E-6
    "constant for density calculation of water vapour";
    //Min et al: Coupled heat and mass transfer during moisture exchange across a membrane
  constant Real B(unit="m.m.m.K/kg") = 138.08E-3
    "constant for density calculation of water vapour";
    //Min et al: Coupled heat and mass transfer during moisture exchange across a membrane


  //============ variables =====================
public
  Modelica.SIunits.MassFraction w(min=0,max=w_0)
    "actual water uptake of adsorbent in kg/kg";
  Modelica.SIunits.MassFraction w_0(min=0)
    "maximum water uptake of adsorbent in kg/kg (material specific)";
  Modelica.SIunits.Density rho
    "density of water vapour";
  Real dw0_dT(unit="1/K")
    "derivative of maximum water uptake by temperature";
  Modelica.SIunits.SpecificEnthalpy dh_v
    "vaporization enthalpy of water";
  Modelica.SIunits.SpecificEnthalpy q_st
    "adsorption enthalpy of water";


  input Modelica.SIunits.Temperature T
    "Temperature in K";
  input Real phi(min=0.01,max=0.99)
    "relative Humidity, range:0.01...0.99";
  Modelica.Blocks.Interfaces.RealOutput dhAds
    "adsorption enthalpy in J/kgK"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation

  rho = 1/(A*T+B/T);
  //Min et al: Coupled heat and mass transfer during moisture exchange across a membrane

  w_0 = rho * v_0;
  //Min et al: Coupled heat and mass transfer during moisture exchange across a membrane

  w = w_0 * exp(-F*(-T*log(phi))^n);
  //Min et al: Coupled heat and mass transfer during moisture exchange across a membrane

  dw0_dT = (B/T^2-A)*v_0/(A*T+B/T)^2;
  //Min et al: Coupled heat and mass transfer during moisture exchange across a membrane

  q_st = dh_v + R_g * T * (-1/F * log(w/w_0))^(1/n) * (1/T + 1/(n*w_0*log(w/w_0)) * dw0_dT);
  //Min et al: Coupled heat and mass transfer during moisture exchange across a membrane

  dh_v = 2500E3; //for first test, needs to be changed depending on temperature

  dhAds = max(min(q_st,4E6),dh_v);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-60,60},{60,-60}}, color={0,0,0}),
        Line(points={{-60,-60},{60,60}}, color={0,0,0}),
        Line(points={{0,60},{0,-60}}, color={0,0,0}),
        Line(points={{-60,0},{60,0}}, color={0,0,0}),
        Text(
          extent={{-40,-70},{32,-92}},
          lineColor={28,108,200},
          fillColor={0,127,0},
          fillPattern=FillPattern.None,
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end AdsorptionEnthalpy;
