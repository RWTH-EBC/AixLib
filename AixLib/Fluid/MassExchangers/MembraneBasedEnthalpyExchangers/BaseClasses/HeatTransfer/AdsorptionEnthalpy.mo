within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.HeatTransfer;
model AdsorptionEnthalpy
  "model that calculates the adsorption enthalpy based on the Dubinin-Astakhov equation"

  //============ parameters ====================

  //calculation of water uptake in adsorbent
  parameter Real F
    "material specific asdoprtion characteristic constant";
  parameter Real n
    "material specific asdoprtion characteristic constant";
  parameter Modelica.Units.SI.SpecificVolume v_0(min=0)
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
  Modelica.Units.SI.MassFraction w(min=0)
    "actual water uptake of adsorbent in kg/kg";
  Modelica.Units.SI.MassFraction w_0(min=0)
    "maximum water uptake of adsorbent in kg/kg (material specific)";
  Modelica.Units.SI.Density rho "density of water vapour";
  Real dw0_dT(unit="1/K")
    "derivative of maximum water uptake by temperature";
  Modelica.Units.SI.SpecificEnthalpy dh_v "vaporization enthalpy of water";
  Modelica.Units.SI.SpecificEnthalpy q_st "adsorption enthalpy of water";


  input Modelica.Units.SI.Temperature T "Temperature in K";
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
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This model calculates the adsorption enthalpy of water vapour for an
  microporous absorbent. It is based on the Dubinin-Astakhov equation
  for sorption. All equations are taken from [1].
</p>
<p>
  The actual water uptake <i>w</i> of the absorbent is calculated as
  follows.
</p>
<p style=\"text-align:center;\">
  <i>w = w<sub>0</sub> exp[-F(-T ln(φ))<sup>n</sup>]</i>
</p>
<p>
  Here <i>F</i> and <i>n</i> are material specific adsorption
  characteristic constants. The temperature <i>T</i> and the relative
  humidty <i>φ</i> are inputs of the model. The maximum water uptake
  <i>w<sub>0</sub></i> is calculated as following:
</p>
<p style=\"text-align:center;\">
  <i>w<sub>0</sub> = ρ(T) v<sub>0</sub></i>
</p>
<p>
  The specific micropore volume of the adsobent <i>v<sub>0</sub></i>
  has to be set as an parameter. The density of water is calculated by
  the following term.
</p>
<p style=\"text-align:center;\">
  <i>ρ(T) = 1 ⁄ (A T + B⁄T)</i>
</p>
<p>
  <i>A</i> and <i>B</i> are constants with <i>A =
  1.8105⋅10<sup>-6</sup> m<sup>3</sup> kg<sup>-1</sup>
  K<sup>-1</sup></i> and <i>B = 138.08⋅10<sup>-3</sup> m<sup>3</sup>
  kg<sup>-1</sup> K</i> .
</p>
<p>
  With the specific vaporization enthalpy of water
  <i>Δh<sub>v</sub></i> and the gas constant of water vapour
  <i>R<sub>g</sub></i> the specific adsorption enthalpy can be
  calculated by the following equation.
</p>
<p style=\"text-align:center;\">
  <i>Δh<sub>ads</sub> = Δh<sub>v</sub> + R<sub>g</sub> T[-1 ⁄F ln(w
  ⁄w<sub>0</sub>)]<sup>1 ⁄n</sup> [1 ⁄T + 1 ⁄(n w0 ln(w ⁄w<sub>0</sub>)
  (∂w<sub>0</sub> ⁄∂T)]</i>
</p>
<h4>
  Known Limitations
</h4>
<ul>
  <li>Calculated adsorption enthalpy for high relative humidities is
  not reliable (increases up to very high values, as the ln-function
  aproximates zero).
  </li>
  <li>Not solvable for complete dry air as the ln(0) is not defined
  </li>
</ul>
<h4>
  References
</h4>
<p>
  [1]: Min,J.; Wang,L.: <i>Coupled heat and mass transfer during
  moisture exchange across a mebrane.</i> Journal of Membrane Science.
  430 (2013). pp.150-157
</p>
</html>", revisions="<html>
<ul>
  <li>November 23, 2018, by Martin Kremer:<br/>
    Changed RealInputs to inputs to use the model inside other models
  </li>
  <li>November 22, 2018, by Martin Kremer:<br/>
    First Implementation
  </li>
</ul>
</html>"));
end AdsorptionEnthalpy;
