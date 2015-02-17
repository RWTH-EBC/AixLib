within AixLib.Media;
package Air
  "Incompressible moist air model with constant specific heat capacities and Charle's law for density versus temperature"
  extends Modelica.Media.Interfaces.PartialCondensingGases(
     mediumName="Moist air unsaturated gas",
     final substanceNames={"water", "air"},
     final reducedX=true,
     final singleState=true,
     reference_X={0.01,0.99},
     final fluidConstants = {Modelica.Media.IdealGases.Common.FluidData.H2O,
                             Modelica.Media.IdealGases.Common.FluidData.N2},
     final reference_T=273.15,
     reference_p=101325);
  extends Modelica.Icons.Package;

  final constant Integer Water=1
    "Index of water (in substanceNames, massFractions X, etc.)";
  final constant Integer Air=2
    "Index of air (in substanceNames, massFractions X, etc.)";

  // Redeclare ThermodynamicState to avoid the warning
  // "Base class ThermodynamicState is replaceable"
  // during model check, and to set the start values.
  redeclare record extends ThermodynamicState(
    p(start=p_default),
    T(start=T_default),
    X(start=X_default))
  end ThermodynamicState;

  redeclare replaceable model extends BaseProperties(
    p(stateSelect=StateSelect.never),
    Xi(each stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
    final standardOrderComponents=true) "Base properties"

  protected
    constant Modelica.SIunits.MolarMass[2] MMX = {steam.MM,dryair.MM}
      "Molar masses of components";

    MassFraction X_steam "Mass fraction of steam water";
    MassFraction X_air "Mass fraction of air";

  equation
    MM = 1/(Xi[Water]/MMX[Water]+(1.0-Xi[Water])/MMX[Air]);

    assert(T >= 200.0 and T <= 423.15, "
Temperature T is not in the allowed range
200.0 K <= (T =" + String(T) + " K) <= 423.15 K
required from medium model \""     + mediumName + "\".");

    X_steam  = Xi[Water]; // There is no liquid in this medium model
    X_air    = 1-Xi[Water];

    h = T_degC*dryair.cp * X_air +
       (T_degC * steam.cp + h_fg) * X_steam;
    R = dryair.R*X_air + steam.R*X_steam;

    u = h-R*T;
    d = reference_p/(R*T);

    state.p = p;
    state.T = T;
    state.X = X;

    annotation (Documentation(info="<html>
    <p>
    Base properties of the medium.
    </p>
</html>"));
  end BaseProperties;

redeclare function extends density "Return the gas density"

algorithm
  d := reference_p/(gasConstant(state)*state.T);
  annotation (smoothOrder=2,
Documentation(info="<html>
<p>
This function computes density as a function of temperature and humidity content.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end density;

redeclare function extends dynamicViscosity
    "Return the dynamic viscosity of dry air"
algorithm
  eta := 4.89493640395e-08 * state.T + 3.88335940547e-06;
  annotation (
  smoothOrder=99,
Documentation(info="<html>
<p>
This function returns the dynamic viscosity.
</p>
<h4>Implementation</h4>
<p>
The function is based on the 5th order polynomial
of
<a href=\"modelica://Modelica.Media.Air.MoistAir.dynamicViscosity\">
Modelica.Media.Air.MoistAir.dynamicViscosity</a>.
However, for the typical range of temperatures encountered
in building applications, a linear function sufficies.
This implementation is therefore the above 5th order polynomial,
linearized around <i>20</i>&deg;C.
The relative error of this linearization is
<i>0.4</i>% at <i>-20</i>&deg;C,
and less then
<i>0.2</i>% between  <i>-5</i>&deg;C and  <i>+50</i>&deg;C.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 19, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end dynamicViscosity;

redeclare function enthalpyOfCondensingGas
    "Returns the enthalpy of steam per unit mass of steam"
  extends Modelica.Icons.Function;

  input Temperature T "temperature";
  output SpecificEnthalpy h "steam enthalpy";
algorithm
  h := (T - reference_T) * steam.cp + enthalpyOfVaporization(T);
  annotation(smoothOrder=5, derivative=der_enthalpyOfCondensingGas,
Documentation(info="<html>
<p>
This function computes the specific enthalpy of water vapor.
This function does not take into account the ratio of water vapor per unit mass,
rather, the specific enthalpy is for water vapor only.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end enthalpyOfCondensingGas;

redeclare replaceable function extends enthalpyOfGas
    "Return the enthalpy of the gas mixture per unit mass of the gas mixture"
algorithm
  h := enthalpyOfCondensingGas(T)*X[Water]
       + enthalpyOfDryAir(T)*(1.0-X[Water]);
  annotation(smoothOrder=5,
Documentation(info="<html>
<p>
This function computes the specific enthalpy of the air and water vapor mixture.
The specific enthalpy is per unit mass of the total mixture.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end enthalpyOfGas;

redeclare replaceable function extends enthalpyOfLiquid
    "Return the enthalpy of liquid per unit mass of liquid"
algorithm
  h := (T - reference_T)*cpWatLiq;
  annotation(smoothOrder=5, derivative=der_enthalpyOfLiquid,
Documentation(info="<html>
<p>
This function computes the specific enthalpy of liquid water.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end enthalpyOfLiquid;

redeclare function enthalpyOfNonCondensingGas
    "Return the enthalpy of the non-condensing gas per unit mass of steam"
  extends Modelica.Icons.Function;

  input Temperature T "Temperature";
  output SpecificEnthalpy h "Specific enthalpy";
algorithm
  h := enthalpyOfDryAir(T);
  annotation(smoothOrder=5, derivative=der_enthalpyOfNonCondensingGas,
Documentation(info="<html>
<p>
This function computes the specific enthalpy of dry air.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end enthalpyOfNonCondensingGas;

redeclare function extends enthalpyOfVaporization
    "Return the enthalpy of vaporization of water"
algorithm
  r0 := h_fg;
  annotation(smoothOrder=99,
Documentation(info="<html>
<p>
This function returns a constant enthalpy of vaporization.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end enthalpyOfVaporization;

redeclare function extends gasConstant
    "Return the ideal gas constant as a function of the thermodynamic state, only valid for phi<1"

algorithm
    R := dryair.R*(1 - state.X[Water]) + steam.R*state.X[Water];
  annotation (smoothOrder=2,
Documentation(info="<html>
<p>
This function computes the gas constant for the air and water vapor mixture.
</p>
<h4>Assumptions</h4>
<p>
This function is only valid for a relative humidity below 100%.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end gasConstant;

redeclare function extends isobaricExpansionCoefficient
    "Return the isobaric expansion coefficient"
algorithm
  beta := 1/state.T;
annotation (
Documentation(info="<html>
<p>
This function returns the isobaric expansion coefficient,
</p>
<p align=\"center\" style=\"font-style:italic;\">
&beta;<sub>p</sub> = - 1 &frasl; v &nbsp; (&part; v &frasl; &part; T)<sub>p</sub>
= 1&frasl;T,
</p>
<p>
where
<i>v</i> is the specific volume,
<i>T</i> is the temperature and
<i>p</i> is the pressure.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end isobaricExpansionCoefficient;

redeclare function extends isothermalCompressibility
    "Return the isothermal compressibility factor"
algorithm
  kappa := 0;
annotation (
Documentation(info="<html>
<p>
This function returns the isothermal compressibility coefficient,
which is zero as this medium is incompressible.
The isothermal compressibility is defined as
</p>
<p align=\"center\" style=\"font-style:italic;\">
&kappa;<sub>T</sub> = -1 &frasl; v &nbsp; (&part; v &frasl; &part; p)<sub>T</sub>,
</p>
<p>
where
<i>v</i> is the specific volume,
<i>T</i> is the temperature and
<i>p</i> is the pressure.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end isothermalCompressibility;

redeclare function extends pressure "Return the pressure"
algorithm
  p := state.p;
  annotation (
smoothOrder=99,
Documentation(info="<html>
<p>
This function returns the pressure.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end pressure;

redeclare function extends saturationPressure "Return the saturation pressure"

algorithm
  // Calling saturationPressure as below causes the commands
  // simulate(AixLib.Utilities.Psychrometrics.Functions.Examples.X_pSatpphi);
  // in OpenModelica to never return. 2014-10-04
  //psat := AixLib.Utilities.Psychrometrics.Functions.saturationPressure(Tsat=Tsat);
  psat := AixLib.Utilities.Math.Functions.spliceFunction(
             AixLib.Utilities.Psychrometrics.Functions.saturationPressureLiquid(Tsat),
             AixLib.Utilities.Psychrometrics.Functions.sublimationPressureIce(Tsat),
             Tsat-273.16,
             1.0);
  annotation(Inline=true,smoothOrder=5,
Documentation(info="<html>
<p>
This function computes the saturation pressure of the water vapor for a given temperature,
using the function
<a href=\"modelica://AixLib.Utilities.Psychrometrics.Functions.saturationPressure\">
AixLib.Utilities.Psychrometrics.Functions.saturationPressure</a>.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end saturationPressure;

redeclare function extends specificEntropy
    "Return the specific entropy, only valid for phi<1"

  protected
    Modelica.SIunits.MoleFraction[2] Y "Molar fraction";
algorithm
    Y := massToMoleFractions(
         state.X, {steam.MM,dryair.MM});
    s := specificHeatCapacityCp(state) * Modelica.Math.log(state.T/reference_T)
         - Modelica.Constants.R *
         sum(state.X[i]/MMX[i]*
             Modelica.Math.log(max(Y[i], Modelica.Constants.eps)) for i in 1:2);
  annotation (
    Inline=false,
    Documentation(info="<html>
<p>
This function computes the specific entropy.
</p>
<p>
The specific entropy of the mixture is obtained from
<p align=\"center\" style=\"font-style:italic;\">
s = s<sub>s</sub> + s<sub>m</sub>,
</p>
<p>
where
<i>s<sub>s</sub></i> is the entropy change due to the state change
(relative to the reference temperature) and
<i>s<sub>m</sub></i> is the entropy change due to mixing
of the dry air and water vapor.
</p>
<p>
The entropy change due to change in state is obtained from
<p align=\"center\" style=\"font-style:italic;\">
s<sub>s</sub> = c<sub>v</sub> ln(T/T<sub>0</sub>) + R ln(v/v<sub>0</sub>) <br/>
= c<sub>v</sub> ln(T/T<sub>0</sub>) + R ln(&rho;<sub>0</sub>/&rho;)
</p>
<p>Because <i>&rho; = p<sub>0</sub>/(R T)</i> for this medium model,
and because <i>c<sub>p</sub> = c<sub>v</sub> + R</i>,
we can write
</p>
<p align=\"center\" style=\"font-style:italic;\">
s<sub>s</sub> = c<sub>v</sub> ln(T/T<sub>0</sub>) + R ln(T/T<sub>0</sub>) <br/>
=c<sub>p</sub> ln(T/T<sub>0</sub>).
</p>
<p>
Next, the entropy of mixing is obtained from a reversible isothermal
expansion process. Hence,
</p>
<p align=\"center\" style=\"font-style:italic;\">
  s<sub>m</sub> = -R &sum;<sub>i</sub>( X<sub>i</sub> &frasl; M<sub>i</sub>
  ln(Y<sub>i</sub>)),
</p>
<p>
where <i>R</i> is the gas constant,
<i>X</i> is the mass fraction,
<i>M</i> is the molar mass, and
<i>Y</i> is the mole fraction.
</p>
<p>
To obtain the state for a given pressure, entropy and mass fraction, use
<a href=\"modelica://AixLib.Media.Air.setState_psX\">
AixLib.Media.Air.setState_psX</a>.
</p>
<h4>Limitations</h4>
<p>
This function is only valid for a relative humidity below 100%.
</p>
</html>", revisions="<html>
<ul>
<li>
November 27, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end specificEntropy;

redeclare function extends density_derp_T
    "Return the partial derivative of density with respect to pressure at constant temperature"
algorithm
  ddpT := 0;
annotation (
Documentation(info="<html>
<p>
This function returns the partial derivative of density
with respect to pressure at constant temperature,
which is zero as the medium is incompressible.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end density_derp_T;

redeclare function extends density_derT_p
    "Return the partial derivative of density with respect to temperature at constant pressure"
algorithm
  ddTp := -reference_p / gasConstant(state) / (state.T)^2;

  annotation (smoothOrder=1, Documentation(info=
                   "<html>
<p>
This function computes the derivative of density with respect to temperature
at constant pressure.
</p>
</html>", revisions=
"<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation, based on the IDA implementation in <code>therpro.nmf</code>,
but converted from Celsius to Kelvin.
</li>
</ul>
</html>"));
end density_derT_p;

redeclare function extends density_derX
    "Return the partial derivative of density with respect to mass fractions at constant pressure and temperature"
algorithm
  dddX[Water] := reference_p*(steam.R - dryair.R)/((steam.R - dryair.R)
      *state.X[Water]*temperature(state) + dryair.R*temperature(state))^2;
  dddX[Air] := reference_p*(dryair.R - steam.R)/((dryair.R - steam.R)*
      state.X[Air]*temperature(state) + steam.R*temperature(state))^2;

annotation (
Documentation(info="<html>
<p>
This function returns the partial derivative of density
with respect to mass fraction.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end density_derX;

redeclare replaceable function extends specificHeatCapacityCp
    "Return the specific heat capacity at constant pressure"
algorithm
  cp := dryair.cp*(1-state.X[Water]) +steam.cp*state.X[Water];
    annotation(derivative=der_specificHeatCapacityCp,
Documentation(info="<html>
<p>
This function computes the specific heat capacity at constant pressure
for the air and water vapor mixture.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end specificHeatCapacityCp;

redeclare replaceable function extends specificHeatCapacityCv
    "Return the specific heat capacity at constant volume"
algorithm
  cv:= dryair.cv*(1-state.X[Water]) +steam.cv*state.X[Water];
    annotation(derivative=der_specificHeatCapacityCv,
Documentation(info="<html>
<p>
This function computes the specific heat capacity at constant volume
for the air and water vapor mixture.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end specificHeatCapacityCv;

redeclare function setState_dTX
    "Return the thermodynamic state as function of density d, temperature T and composition X or Xi"
  extends Modelica.Icons.Function;
  input Density d "Density";
  input Temperature T "Temperature";
  input MassFraction X[:]=reference_X "Mass fractions";
  output ThermodynamicState state "Thermodynamic state";

algorithm
    state := if size(X, 1) == nX then
               ThermodynamicState(p=reference_p, T=T, X=X)
             else
               ThermodynamicState(p=reference_p,
                                  T=T,
                                  X=cat(1, X, {1 - sum(X)}));
    annotation (smoothOrder=99,
Documentation(info="<html>
<p>
This function returns the thermodynamic state for a given density, temperature and composition.
Because this medium assumes density to be a function of temperature and composition only,
this function ignores the argument <code>d</code>.
The pressure that is used to set the state is equal to the constant
<code>reference_p</code>.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end setState_dTX;

redeclare function extends setState_phX
    "Return the thermodynamic state as function of pressure p, specific enthalpy h and composition X or Xi"
algorithm
  state := if size(X, 1) == nX then
    ThermodynamicState(p=p, T=temperature_phX(p, h, X), X=X)
 else
    ThermodynamicState(p=p, T=temperature_phX(p, h, X), X=cat(1, X, {1 - sum(X)}));
  annotation (smoothOrder=99,
Documentation(info="<html>
<p>
This function returns the thermodynamic state for a given pressure, specific enthalpy and composition.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end setState_phX;

redeclare function extends setState_pTX
    "Return the thermodynamic state as function of p, T and composition X or Xi"
algorithm
    state := if size(X, 1) == nX then
                ThermodynamicState(p=p, T=T, X=X)
             else
                ThermodynamicState(p=p, T=T, X=cat(1, X, {1 - sum(X)}));
annotation (smoothOrder=99,
Documentation(info="<html>
<p>
This function returns the thermodynamic state for a given pressure, temperature and composition.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end setState_pTX;

redeclare function extends setState_psX
    "Return the thermodynamic state as function of p, s and composition X or Xi"
  protected
    Modelica.SIunits.MassFraction[2] X_int=
      if size(X, 1) == nX then X else cat(1, X, {1 - sum(X)}) "Mass fraction";
    Modelica.SIunits.MoleFraction[2] Y "Molar fraction";
    Modelica.SIunits.Temperature T "Temperature";
algorithm
   Y := massToMoleFractions(
         X_int, {steam.MM,dryair.MM});
    // The next line is obtained from symbolic solving the
    // specificEntropy function for T.
    // In this formulation, we can set T to any value when calling
    // specificHeatCapacityCp as cp does not depend on T.
    T := 273.15 * Modelica.Math.exp((s + Modelica.Constants.R *
           sum(X_int[i]/MMX[i]*
             Modelica.Math.log(max(Y[i], Modelica.Constants.eps)) for i in 1:2))
             / specificHeatCapacityCp(setState_pTX(p=p,
                                                   T=273.15,
                                                   X=X_int)));

    state := ThermodynamicState(p=p,
                                T=T,
                                X=X_int);

annotation (
Inline=false,
Documentation(info="<html>
<p>
This function returns the thermodynamic state based on pressure,
specific entropy and mass fraction.
</p>
<p>
The state is computed by symbolically solving
<a href=\"modelica://AixLib.Media.Air.specificEntropy\">
AixLib.Media.Air.specificEntropy</a>
for temperature.
</p>
</html>", revisions="<html>
<ul>
<li>
November 27, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end setState_psX;

redeclare replaceable function extends specificEnthalpy
    "Return the specific enthalpy from pressure, temperature and mass fraction"
  protected
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T_degC
      "Celsius temperature";
algorithm
  T_degC :=state.T + Modelica.Constants.T_zero;
  h := T_degC*dryair.cp * (1 - state.X[Water]) +
       (T_degC * steam.cp + h_fg) * state.X[Water];
  annotation(Inline=false, smoothOrder=99,
Documentation(info="<html>
<p>
This function computes the specific enthalpy of the air and water vapor mixture.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end specificEnthalpy;

redeclare replaceable function specificEnthalpy_pTX
    "Return the specific enthalpy"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.Pressure p "Pressure";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[:] "Mass fractions of moist air";
  output Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy at p, T, X";

algorithm
  h := specificEnthalpy(setState_pTX(p, T, X));
  annotation(smoothOrder=99,
             inverse(T=temperature_phX(p, h, X)),
Documentation(info="<html>
<p>
This function computes the specific enthalpy of the air and water vapor mixture.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end specificEnthalpy_pTX;

redeclare replaceable function extends specificGibbsEnergy
    "Return the specific Gibbs energy"
algorithm
  g := specificEnthalpy(state) - state.T*specificEntropy(state);
annotation (
Documentation(info="<html>
<p>
This function computes the specific Gibbs energy for the air and water vapor mixture.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end specificGibbsEnergy;

redeclare replaceable function extends specificHelmholtzEnergy
    "Return the specific Helmholtz energy"
algorithm
  f := specificEnthalpy(state) - gasConstant(state)*state.T - state.T*specificEntropy(state);
annotation (
Documentation(info="<html>
<p>
This function computes the specific Helmholtz energy for the air and water vapor mixture.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end specificHelmholtzEnergy;

redeclare function extends isentropicEnthalpy "Return the isentropic enthalpy"
algorithm
  h_is := specificEnthalpy(setState_psX(
            p=p_downstream,
            s=specificEntropy(refState),
            X=refState.X));
annotation (
Documentation(info="<html>
<p>
This function computes the specific enthalpy for
an isentropic state change from the temperature
that corresponds to the state <code>refState</code>
to <code>reference_T</code>.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end isentropicEnthalpy;

redeclare replaceable function extends specificInternalEnergy
    "Return the specific internal energy"
algorithm
  u := specificEnthalpy(state) - gasConstant(state)*state.T;
annotation (
Documentation(info="<html>
<p>
This function computes the specific internal energy for the air and water vapor mixture.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end specificInternalEnergy;

redeclare function extends temperature "Return the temperature from the state"
algorithm
  T := state.T;
  annotation (
smoothOrder=99,
Documentation(info="<html>
<p>
This function returns the temperature of the thermodynamic state.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end temperature;

redeclare function extends molarMass "Return the molar mass"
algorithm
    MM := 1/(state.X[Water]/MMX[Water]+(1.0-state.X[Water])/MMX[Air]);
    annotation (
smoothOrder=99,
Documentation(info="<html>
<p>
This function returns the molar mass.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end molarMass;

redeclare replaceable function temperature_phX
    "Return the temperature from pressure, the specific enthalpy and mass fraction"
    extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input MassFraction[:] X "Mass fractions of composition";
  output Temperature T "Temperature";
algorithm
  T := reference_T + (h - h_fg * X[Water])
       /((1 - X[Water])*dryair.cp + X[Water] * steam.cp);
  annotation(smoothOrder=99,
             inverse(h=specificEnthalpy_pTX(p, T, X)),
Documentation(info="<html>
<p>
This function computes temperature as a function of pressure, specific enthalpy and mass fraction.
</p>
<h4>Implementation</h4>
<p>
Because this medium model assumes all water to be in vapor form, this function does
not require an iterative solution.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end temperature_phX;

redeclare function extends thermalConductivity
    "Return the thermal conductivity"
algorithm
  lambda := Modelica.Media.Incompressible.TableBased.Polynomials_Temp.evaluate(
      {(-4.8737307422969E-008), 7.67803133753502E-005, 0.0241814385504202},
   Modelica.SIunits.Conversions.to_degC(state.T));
annotation (
Documentation(info="<html>
<p>
This function computes the thermal conductivity of dry air.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end thermalConductivity;

//////////////////////////////////////////////////////////////////////
// Protected classes.
// These classes are only of use within this medium model.
// Equipment models generally have no need to access them.
// Therefore, they are made protected. This also allows to redeclare the
// medium model with another medium model that does not provide an
// implementation of these classes.
protected
  record GasProperties
    "Coefficient data record for properties of perfect gases"
    extends Modelica.Icons.Record;

    Modelica.SIunits.MolarMass MM "Molar mass";
    Modelica.SIunits.SpecificHeatCapacity R "Gas constant";
    Modelica.SIunits.SpecificHeatCapacity cp
      "Specific heat capacity at constant pressure";
    Modelica.SIunits.SpecificHeatCapacity cv = cp-R
      "Specific heat capacity at constant volume";
    annotation (
      preferredView="info",
      defaultComponentName="gas",
      Documentation(info="<html>
<p>
This data record contains the coefficients for perfect gases.
</p>
</html>", revisions=
          "<html>
<ul>
<li>
September 12, 2014, by Michael Wetter:<br/>
Corrected the wrong location of the <code>preferredView</code>
and the <code>revisions</code> annotation.
</li>
<li>
November 21, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
  end GasProperties;

  // In the assignments below, we compute cv as OpenModelica
  // cannot evaluate cv=cp-R as defined in GasProperties.
  constant GasProperties dryair(
    R =    Modelica.Media.IdealGases.Common.SingleGasesData.Air.R,
    MM =   Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM,
    cp =   AixLib.Utilities.Psychrometrics.Constants.cpAir,
    cv =   AixLib.Utilities.Psychrometrics.Constants.cpAir
             -Modelica.Media.IdealGases.Common.SingleGasesData.Air.R)
    "Dry air properties";
  constant GasProperties steam(
    R =    Modelica.Media.IdealGases.Common.SingleGasesData.H2O.R,
    MM =   Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM,
    cp =   AixLib.Utilities.Psychrometrics.Constants.cpSte,
    cv =   AixLib.Utilities.Psychrometrics.Constants.cpSte
            -Modelica.Media.IdealGases.Common.SingleGasesData.H2O.R)
    "Steam properties";

  constant Real k_mair =  steam.MM/dryair.MM "Ratio of molar weights";

  constant Modelica.SIunits.MolarMass[2] MMX={steam.MM,dryair.MM}
    "Molar masses of components";

  constant Modelica.SIunits.SpecificEnergy h_fg=
    AixLib.Utilities.Psychrometrics.Constants.h_fg
    "Latent heat of evaporation of water";
  constant Modelica.SIunits.SpecificHeatCapacity cpWatLiq=
    AixLib.Utilities.Psychrometrics.Constants.cpWatLiq
    "Specific heat capacity of liquid water";

replaceable function der_enthalpyOfLiquid
    "Return the temperature derivative of enthalpy of liquid per unit mass of liquid"
  extends Modelica.Icons.Function;
  input Temperature T "Temperature";
  input Real der_T "Temperature derivative";
  output Real der_h "Derivative of liquid enthalpy";

algorithm
    der_h := cpWatLiq*der_T;
    annotation (Documentation(info=
                   "<html>
<p>
This function computes the temperature derivative of the enthalpy of liquid water
per unit mass of liquid.
</p>
</html>", revisions=
"<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end der_enthalpyOfLiquid;

function der_enthalpyOfCondensingGas
    "Return the derivative of enthalpy of steam per unit mass of steam"
  extends Modelica.Icons.Function;
  input Temperature T "Temperature";
  input Real der_T "Temperature derivative";
  output Real der_h "Derivative of steam enthalpy";
algorithm
  der_h := steam.cp*der_T;
annotation (
Documentation(info="<html>
<p>
This function computes the temperature derivative of the enthalpy of steam
per unit mass of steam.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end der_enthalpyOfCondensingGas;

replaceable function enthalpyOfDryAir
    "Return the enthalpy of dry air per unit mass of dry air"
  extends Modelica.Icons.Function;

  input Temperature T "Temperature";
  output SpecificEnthalpy h "Dry air enthalpy";
algorithm
  h := (T - reference_T)*dryair.cp;
  annotation(smoothOrder=5, derivative=der_enthalpyOfDryAir,
Documentation(info="<html>
<p>
This function computes the specific enthalpy of dry air.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end enthalpyOfDryAir;

replaceable function der_enthalpyOfDryAir
    "Return the derivative of enthalpy of dry air per unit mass of dry air"
  extends Modelica.Icons.Function;
  input Temperature T "Temperature";
  input Real der_T "Temperature derivative";
  output Real der_h "Derivative of dry air enthalpy";
algorithm
  der_h := dryair.cp*der_T;
annotation (
Documentation(info="<html>
<p>
This function computes the temperature derivative of the enthalpy of dry air
per unit mass of dry air.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end der_enthalpyOfDryAir;

replaceable function der_enthalpyOfNonCondensingGas
    "Return the derivative of enthalpy of dry air per unit mass of dry air"
  extends Modelica.Icons.Function;
  input Temperature T "Temperature";
  input Real der_T "Temperature derivative";
  output Real der_h "Derivative of steam enthalpy";
algorithm
  der_h := der_enthalpyOfDryAir(T, der_T);
annotation (
Documentation(info="<html>
<p>
This function computes the temperature derivative of the enthalpy of dry air
per unit mass of dry air.
</p>
</html>",
revisions="<html>
<ul>
<li>
February 3, 2015, by Michael Wetter:<br/>
Removed <code>stateSelect.prefer</code> for temperature.
This is for
<a href=\"https://github.com/iea-annex60/modelica-annex60/issues/160\">#160</a>.
</li>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end der_enthalpyOfNonCondensingGas;

replaceable function der_specificHeatCapacityCp
    "Return the derivative of the specific heat capacity at constant pressure"
  extends Modelica.Icons.Function;
  input ThermodynamicState state "Thermodynamic state";
  input ThermodynamicState der_state "Derivative of thermodynamic state";
  output Real der_cp(unit="J/(kg.K.s)") "Derivative of specific heat capacity";
algorithm
  der_cp := (steam.cp-dryair.cp)*der_state.X[Water];
annotation (
Documentation(info="<html>
<p>
This function computes the derivative of the specific heat capacity at constant pressure
with respect to the state.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end der_specificHeatCapacityCp;

replaceable function der_specificHeatCapacityCv
    "Return the derivative of the specific heat capacity at constant volume"
  extends Modelica.Icons.Function;
  input ThermodynamicState state "Thermodynamic state";
  input ThermodynamicState der_state "Derivative of thermodynamic state";
  output Real der_cv(unit="J/(kg.K.s)") "Derivative of specific heat capacity";
algorithm
  der_cv := (steam.cv-dryair.cv)*der_state.X[Water];
annotation (
Documentation(info="<html>
<p>
This function computes the derivative of the specific heat capacity at constant volume
with respect to the state.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end der_specificHeatCapacityCv;

annotation (preferredView="info", Documentation(info="<html>
<p>
This medium package models moist air.
The specific heat capacities at constant pressure and at constant volume are
constant for the individual species dry air, water vapor and liquid water.
The gas law is
</p>
<p align=\"center\" style=\"font-style:italic;\">
d = p<sub>0</sub>/(R T)
</p>
<p>
where
<i>&rho;</i> is the mass density,
<i>p<sub>0</sub></i> is the atmospheric pressure, which is equal to the constant
<code>reference_p</code>, with a default value of
<i>101325</i> Pascals,
<i>R</i> is the gas constant of the mixture
and
<i>T</i> is the absolute temperature.
</p>
<p>
The enthalpy is computed using the convention that <i>h=0</i>
if <i>T=0</i> &deg;C and the water vapor content is zero.
</p>
<h4>Limitations</h4>
<p>
This medium is modeled as incompressible. The pressure that is used
to compute the physical properties is constant, and equal to
<code>reference_p</code>.
</p>
<p>
This model assumes that water is only present in the form of vapor.
If the medium is oversaturated, all properties are computes as if all
water were present in the form of vapor.
</p>
</html>", revisions="<html>
<ul>
<li>
October 4, 2014, by Michael Wetter:<br/>
Reformulated <code>saturationPressure</code> as the previous implementation
caused OpenModelica to never return when executing
<code>AixLib.Utilities.Psychrometrics.Functions.Examples.X_pSatpphi</code>.
</li>
<li>
September 12, 2014, by Michael Wetter:<br/>
Set <code>T(start=T_default)</code> and <code>p(start=p_default)</code> in the
<code>ThermodynamicState</code> record. Setting the start value for
<code>T</code> is required to avoid an error due to conflicting start values
when checking <a href=\"modelica://Buildings.Examples.VAVReheat.ClosedLoop\">
Buildings.Examples.VAVReheat.ClosedLoop</a> in pedantic mode.
</li>
<li>
July 24, 2014, by Michael Wetter:<br/>
Changed implementation to use
<a href=\"modelica://AixLib.Utilities.Psychrometrics.Constants\">
AixLib.Utilities.Psychrometrics.Constants</a>.
This was done to use consistent values throughout the library.
</li>
<li>
December 10, 2013, by Michael Wetter:<br/>
Replaced <code>reference_p</code> by <code>p</code> in the <code>setState_pXX</code> functions.
This is required for
<a href=\"modelica://AixLib.Fluid.MixingVolumes.Examples.MixingVolumeInitialization\">
AixLib.Fluid.MixingVolumes.Examples.MixingVolumeInitialization</a>
to translate.
</li>
<li>
November 27, 2013, by Michael Wetter:<br/>
Changed the gas law.
</li>
<li>
November 15, 2013, by Michael Wetter:<br/>
Revised and simplified the implementation.
</li>
<li>
November 14, 2013, by Michael Wetter:<br/>
Removed function
<code>HeatCapacityOfWater</code>
which is neither needed nor implemented in the
Modelica Standard Library.
</li>
<li>
November 13, 2013, by Michael Wetter:<br/>
Removed un-used computations in <code>specificEnthalpy_pTX</code> and
in <code>temperature_phX</code>.
</li>
<li>
March 29, 2013, by Michael Wetter:<br/>
Added <code>final standardOrderComponents=true</code> in the
<code>BaseProperties</code> declaration. This avoids an error
when models are checked in Dymola 2014 in the pedenatic mode.
</li>
<li>
April 12, 2012, by Michael Wetter:<br/>
Added keyword <code>each</code> to <code>Xi(stateSelect=...</code>.
</li>
<li>
April 4, 2012, by Michael Wetter:<br/>
Added redeclaration of <code>ThermodynamicState</code> to avoid a warning
during model check and translation.
</li>
<li>
January 27, 2010, by Michael Wetter:<br/>
Added function <code>enthalpyOfNonCondensingGas</code> and its derivative.
</li>
<li>
January 27, 2010, by Michael Wetter:<br/>
Fixed bug with temperature offset in <code>temperature_phX</code>.
</li>
<li>
August 18, 2008, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Ellipse(
          extent={{-72,74},{-28,30}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-30,-34},{14,-78}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-12,82},{32,38}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-84,-10},{-40,-54}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-16,28},{28,-16}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{42,-36},{86,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{54,54},{98,10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120})}));
end Air;
