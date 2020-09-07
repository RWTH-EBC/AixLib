within AixLib.Media;
package AirIncompressible
  "Package with incopressible moist air model for air duct simulations"
  extends Modelica.Media.Interfaces.PartialCondensingGases(
     mediumName="Air",
     final substanceNames={"water", "air"},
     final reducedX=true,
     final singleState = false,
     reference_X={0.01,0.99},
     final fluidConstants = {Modelica.Media.IdealGases.Common.FluidData.H2O,
                             Modelica.Media.IdealGases.Common.FluidData.N2},
     reference_T=273.15,
     reference_p=101325,
     AbsolutePressure(start=p_default),
     Temperature(start=T_default));
  extends Modelica.Icons.Package;

  constant Integer Water=1
    "Index of water (in substanceNames, massFractions X, etc.)";
  constant Integer Air=2
    "Index of air (in substanceNames, massFractions X, etc.)";

  constant AbsolutePressure pStp = reference_p
    "Pressure for which fluid density is defined";
  constant Density dStp = 1.2 "Fluid density at pressure pStp";

  // Redeclare ThermodynamicState to avoid the warning
  // "Base class ThermodynamicState is replaceable"
  // during model check
  redeclare record extends ThermodynamicState
    "ThermodynamicState record for moist air"
  end ThermodynamicState;
  // There must not be any stateSelect=StateSelect.prefer for
  // the pressure.
  // Otherwise, translateModel("Buildings.Fluid.FMI.ExportContainers.Examples.FMUs.ResistanceVolume")
  // will fail as Dymola does an index reduction and outputs
  //   Differentiated the equation
  //   vol.dynBal.medium.p+res.dp-inlet.p = 0.0;
  //   giving
  //   der(vol.dynBal.medium.p)+der(res.dp) = der(inlet.p);
  //
  //   The model requires derivatives of some inputs as listed below:
  //   1 inlet.m_flow
  //   1 inlet.p
  // Therefore, the statement
  //   p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default)
  // has been removed.
  redeclare replaceable model extends BaseProperties(
    Xi(each stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
    T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
    final standardOrderComponents=true) "Base properties"

  protected
    constant Modelica.SIunits.MolarMass[2] MMX = {steam.MM,dryair.MM}
      "Molar masses of components";

    MassFraction X_steam "Mass fraction of steam water";
    MassFraction X_air "Mass fraction of air";
    Modelica.SIunits.TemperatureDifference dT(start=T_default-reference_T)
      "Temperature difference used to compute enthalpy";
  equation
    assert(T >= 200.0, "
In "   + getInstanceName() + ": Temperature T exceeded its minimum allowed value of -73.15 degC (200 Kelvin)
as required from medium model \"" + mediumName + "\".");
    assert(T <= 423.15, "
In "   + getInstanceName() + ": Temperature T exceeded its maximum allowed value of 150 degC (423.15 Kelvin)
as required from medium model \"" + mediumName + "\".");

    MM = 1/(Xi[Water]/MMX[Water]+(1.0-Xi[Water])/MMX[Air]);

    X_steam  = Xi[Water]; // There is no liquid in this medium model
    X_air    = 1-Xi[Water];

    dT = T - reference_T;
    h = dT*dryair.cp * X_air +
       (dT * steam.cp + h_fg) * X_steam;
    R = dryair.R*X_air + steam.R*X_steam;

    // Equation for ideal gas, from h=u+p*v and R*T=p*v, from which follows that  u = h-R*T.
    // u = h-R*T;
    // However, in this medium, the gas law is d/dStp=p/pStp, from which follows using h=u+pv that
    // u= h-p*v = h-p/d = h-pStp/dStp
    u = h-pStp/dStp;

    // In this medium model, the density depends only
    // on temperature, but not on pressure.
    //  d = p/(R*T);
    d/dStp = p/pStp;

    state.p = p;
    state.T = T;
    state.X = X;
  end BaseProperties;

redeclare function density "Gas density"
  extends Modelica.Icons.Function;
  input ThermodynamicState state;
  output Density d "Density";
algorithm
  d :=dStp;
  annotation(smoothOrder=5,
  Inline=true,
  Documentation(info="<html>Density is computed from pressure, temperature and composition in the
thermodynamic state record applying the ideal gas law.
</html>"));
end density;

redeclare function extends dynamicViscosity
    "Return the dynamic viscosity of dry air"
algorithm
  eta := 4.89493640395e-08 * state.T + 3.88335940547e-06;
  annotation (
  smoothOrder=99,
  Inline=true,
Documentation(info="<html><p>
  This function returns the dynamic viscosity.
</p>
<h4>
  Implementation
</h4>
<p>
  The function is based on the 5th order polynomial of <a href=
  \"modelica://Modelica.Media.Air.MoistAir.dynamicViscosity\">Modelica.Media.Air.MoistAir.dynamicViscosity</a>.
  However, for the typical range of temperatures encountered in
  building applications, a linear function sufficies. This
  implementation is therefore the above 5th order polynomial,
  linearized around <i>20</i>°C. The relative error of this
  linearization is <i>0.4</i>% at <i>-20</i>°C, and less then
  <i>0.2</i>% between <i>-5</i>°C and <i>+50</i>°C.
</p>
</html>",
revisions="<html><ul>
  <li>December 19, 2013, by Michael Wetter:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end dynamicViscosity;

redeclare function enthalpyOfCondensingGas
    "Enthalpy of steam per unit mass of steam"
  extends Modelica.Icons.Function;

  input Temperature T "temperature";
  output SpecificEnthalpy h "steam enthalpy";
algorithm
  h := (T-reference_T) * steam.cp + h_fg;
  annotation(smoothOrder=5,
  Inline=true,
  derivative=der_enthalpyOfCondensingGas);
end enthalpyOfCondensingGas;

redeclare replaceable function extends enthalpyOfGas
    "Enthalpy of gas mixture per unit mass of gas mixture"
algorithm
  h := enthalpyOfCondensingGas(T)*X[Water]
       + enthalpyOfDryAir(T)*(1.0-X[Water]);
annotation (
  Inline=true);
end enthalpyOfGas;

redeclare replaceable function extends enthalpyOfLiquid
    "Enthalpy of liquid (per unit mass of liquid) which is linear in the temperature"
algorithm
  h := (T - reference_T)*cpWatLiq;
  annotation (
    smoothOrder=5,
    Inline=true,
    derivative=der_enthalpyOfLiquid);
end enthalpyOfLiquid;

redeclare function enthalpyOfNonCondensingGas
    "Enthalpy of non-condensing gas per unit mass of steam"
  extends Modelica.Icons.Function;

  input Temperature T "temperature";
  output SpecificEnthalpy h "enthalpy";
algorithm
  h := enthalpyOfDryAir(T);
  annotation (
  smoothOrder=5,
  Inline=true,
  derivative=der_enthalpyOfNonCondensingGas);
end enthalpyOfNonCondensingGas;

redeclare function extends enthalpyOfVaporization
    "Enthalpy of vaporization of water"
algorithm
  r0 := h_fg;
  annotation (
    Inline=true);
end enthalpyOfVaporization;

redeclare function extends gasConstant
    "Return ideal gas constant as a function from thermodynamic state, only valid for phi<1"

algorithm
    R := dryair.R*(1 - state.X[Water]) + steam.R*state.X[Water];
  annotation (
    smoothOrder=2,
    Inline=true,
    Documentation(info="<html>The ideal gas constant for moist air is computed from <a href=
\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\">thermodynamic
state</a> assuming that all water is in the gas phase.
</html>"));
end gasConstant;

redeclare function extends pressure
    "Returns pressure of ideal gas as a function of the thermodynamic state record"

algorithm
  p := state.p;
  annotation (
  smoothOrder=2,
  Inline=true,
  Documentation(info="<html>Pressure is returned from the thermodynamic state record input as a
simple assignment.
</html>"));
end pressure;

redeclare function extends isobaricExpansionCoefficient
    "Isobaric expansion coefficient beta"
algorithm
  beta := 0;
  annotation (
    smoothOrder=5,
    Inline=true,
Documentation(info="<html><p>
  This function returns the isobaric expansion coefficient at constant
  pressure, which is zero for this medium. The isobaric expansion
  coefficient at constant pressure is
</p>
<p style=\"text-align:center;font-style:italic;\">
  β<sub>p</sub> = - 1 ⁄ v &#160; (∂ v ⁄ ∂ T)<sub>p</sub> = 0,
</p>
<p>
  where <i>v</i> is the specific volume, <i>T</i> is the temperature
  and <i>p</i> is the pressure.
</p>
</html>",
revisions="<html><ul>
  <li>December 18, 2013, by Michael Wetter:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end isobaricExpansionCoefficient;

redeclare function extends isothermalCompressibility
    "Isothermal compressibility factor"
algorithm
  kappa := -1/state.p;
  annotation (
    smoothOrder=5,
    Inline=true,
    Documentation(info="<html><p>
  This function returns the isothermal compressibility coefficient. The
  isothermal compressibility is
</p>
<p style=\"text-align:center;font-style:italic;\">
  κ<sub>T</sub> = -1 ⁄ v &#160; (∂ v ⁄ ∂ p)<sub>T</sub> = -1 ⁄ p,
</p>
<p>
  where <i>v</i> is the specific volume, <i>T</i> is the temperature
  and <i>p</i> is the pressure.
</p>
</html>",
revisions="<html><ul>
  <li>December 18, 2013, by Michael Wetter:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end isothermalCompressibility;

redeclare function extends saturationPressure
    "Saturation curve valid for 223.16 <= T <= 373.16 (and slightly outside with less accuracy)"

algorithm
  psat := AixLib.Utilities.Psychrometrics.Functions.saturationPressure(Tsat);
  annotation (
  smoothOrder=5,
  Inline=true);
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
             Modelica.Math.log(max(Y[i], Modelica.Constants.eps)*state.p/reference_p) for i in 1:2);
  annotation (
  Inline=true,
    Documentation(info="<html><p>
  This function computes the specific entropy.
</p>
<p>
  The specific entropy of the mixture is obtained from
</p>
<p style=\"text-align:center;font-style:italic;\">
  s = s<sub>s</sub> + s<sub>m</sub>,
</p>
<p>
  where <i>s<sub>s</sub></i> is the entropy change due to the state
  change (relative to the reference temperature) and
  <i>s<sub>m</sub></i> is the entropy change due to mixing of the dry
  air and water vapor.
</p>
<p>
  The entropy change due to change in state is obtained from
</p>
<p style=\"text-align:center;font-style:italic;\">
  s<sub>s</sub> = c<sub>v</sub> ln(T/T<sub>0</sub>) + R
  ln(v/v<sub>0</sub>)<br/>
  = c<sub>v</sub> ln(T/T<sub>0</sub>) + R ln(ρ<sub>0</sub>/ρ)
</p>
<p>
  If we assume <i>ρ = p<sub>0</sub>/(R T)</i>, and because
  <i>c<sub>p</sub> = c<sub>v</sub> + R</i>, we can write
</p>
<p style=\"text-align:center;font-style:italic;\">
  s<sub>s</sub> = c<sub>v</sub> ln(T/T<sub>0</sub>) + R
  ln(T/T<sub>0</sub>)<br/>
  =c<sub>p</sub> ln(T/T<sub>0</sub>).
</p>
<p>
  Next, the entropy of mixing is obtained from a reversible isothermal
  expansion process. Hence,
</p>
<p style=\"text-align:center;font-style:italic;\">
  s<sub>m</sub> = -R ∑<sub>i</sub>( X<sub>i</sub> ⁄ M<sub>i</sub>
  ln(Y<sub>i</sub> p/p<sub>0</sub>)),
</p>
<p>
  where <i>R</i> is the gas constant, <i>X</i> is the mass fraction,
  <i>M</i> is the molar mass, and <i>Y</i> is the mole fraction.
</p>
<p>
  To obtain the state for a given pressure, entropy and mass fraction,
  use <a href=
  \"modelica://AixLib.Media.Air.setState_psX\">AixLib.Media.Air.setState_psX</a>.
</p>
<h4>
  Limitations
</h4>
<p>
  This function is only valid for a relative humidity below 100%.
</p>
<ul>
  <li>November 27, 2013, by Michael Wetter:<br/>
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
  Inline=true,
Documentation(info="<html><p>
  This function returns the partial derivative of density with respect
  to pressure at constant temperature.
</p>
</html>",
revisions="<html><ul>
  <li>December 18, 2013, by Michael Wetter:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end density_derp_T;

redeclare function extends density_derT_p
    "Return the partial derivative of density with respect to temperature at constant pressure"
algorithm
  ddTp := 0;

  annotation (
  smoothOrder=99,
  Inline=true,
  Documentation(info=
"<html><p>
  This function computes the derivative of density with respect to
  temperature at constant pressure.
</p>/html /html
</html>",
revisions="<html><ul>
  <li>December 18, 2013, by Michael Wetter:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end density_derT_p;

redeclare function extends density_derX
    "Return the partial derivative of density with respect to mass fractions at constant pressure and temperature"
algorithm
  dddX := fill(0, nX);
annotation (
  smoothOrder=99,
  Inline=true,
  Documentation(info="<html><p>
  This function returns the partial derivative of density with respect
  to mass fraction. This value is zero because in this medium, density
  is proportional to pressure, but independent of the species
  concentration.
</p>
</html>",
revisions="<html><ul>
  <li>December 18, 2013, by Michael Wetter:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end density_derX;

redeclare replaceable function extends specificHeatCapacityCp
    "Specific heat capacity of gas mixture at constant pressure"
algorithm
  cp := dryair.cp*(1-state.X[Water]) +steam.cp*state.X[Water];
    annotation (
  smoothOrder=99,
  Inline=true,
  derivative=der_specificHeatCapacityCp);
end specificHeatCapacityCp;

redeclare replaceable function extends specificHeatCapacityCv
    "Specific heat capacity of gas mixture at constant volume"
algorithm
  cv:= dryair.cv*(1-state.X[Water]) +steam.cv*state.X[Water];
  annotation (
    smoothOrder=99,
    Inline=true,
    derivative=der_specificHeatCapacityCv);
end specificHeatCapacityCv;

redeclare function setState_dTX
    "Return thermodynamic state as function of density d, temperature T and composition X"
  extends Modelica.Icons.Function;
  input Density d "Density";
  input Temperature T "Temperature";
  input MassFraction X[:]=reference_X "Mass fractions";
  output ThermodynamicState state "Thermodynamic state";

algorithm
    // Note that d/dStp = p/pStp, hence p = d*pStp/dStp
    state := if size(X, 1) == nX then
               ThermodynamicState(p=d*pStp/dStp, T=T, X=X)
             else
               ThermodynamicState(p=d*pStp/dStp,
                                  T=T,
                                  X=cat(1, X, {1 - sum(X)}));
    annotation (
    smoothOrder=2,
    Inline=true,
    Documentation(info="<html><p>
  The <a href=
  \"modelica://Modelica.Media.Interfaces.PartialMixtureMedium.ThermodynamicState\">
  thermodynamic state record</a> is computed from density
  <code>d</code>, temperature <code>T</code> and composition
  <code>X</code>.
</p>
</html>"));
end setState_dTX;

redeclare function extends setState_phX
    "Return thermodynamic state as function of pressure p, specific enthalpy h and composition X"
algorithm
  state := if size(X, 1) == nX then
    ThermodynamicState(p=p, T=temperature_phX(p, h, X), X=X)
 else
    ThermodynamicState(p=p, T=temperature_phX(p, h, X), X=cat(1, X, {1 - sum(X)}));
  annotation (
  smoothOrder=2,
  Inline=true,
  Documentation(info="<html>The <a href=
\"modelica://Modelica.Media.Interfaces.PartialMixtureMedium.ThermodynamicState\">
thermodynamic state record</a> is computed from pressure p, specific
enthalpy h and composition X.
</html>"));
end setState_phX;

redeclare function extends setState_pTX
    "Return thermodynamic state as function of p, T and composition X or Xi"
algorithm
    state := if size(X, 1) == nX then
                ThermodynamicState(p=p, T=T, X=X)
             else
                ThermodynamicState(p=p, T=T, X=cat(1, X, {1 - sum(X)}));
    annotation (
  smoothOrder=2,
  Inline=true,
  Documentation(info="<html>The <a href=
\"modelica://Modelica.Media.Interfaces.PartialMixtureMedium.ThermodynamicState\">
thermodynamic state record</a> is computed from pressure p, temperature
T and composition X.
</html>"));
end setState_pTX;

redeclare function extends setState_psX
    "Return the thermodynamic state as function of p, s and composition X or Xi"
  protected
    Modelica.SIunits.MassFraction[2] X_int "Mass fraction";
    Modelica.SIunits.MoleFraction[2] Y "Molar fraction";
    Modelica.SIunits.Temperature T "Temperature";
algorithm
    if size(X, 1) == nX then
      X_int:=X;
    else
      X_int :=cat(
        1,
        X,
        {1 - sum(X)});
    end if;
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
Inline=true,
Documentation(info="<html><p>
  This function returns the thermodynamic state based on pressure,
  specific entropy and mass fraction.
</p>
<p>
  The state is computed by symbolically solving <a href=
  \"modelica://AixLib.Media.Air.specificEntropy\">AixLib.Media.Air.specificEntropy</a>
  for temperature.
</p>
<ul>
  <li>November 27, 2013, by Michael Wetter:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end setState_psX;

redeclare replaceable function extends specificEnthalpy
    "Compute specific enthalpy from pressure, temperature and mass fraction"
algorithm
  h := (state.T - reference_T)*dryair.cp * (1 - state.X[Water]) +
       ((state.T-reference_T) * steam.cp + h_fg) * state.X[Water];
  annotation (
   smoothOrder=5,
   Inline=true);
end specificEnthalpy;

redeclare replaceable function specificEnthalpy_pTX "Specific enthalpy"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.Pressure p "Pressure";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.MassFraction X[:] "Mass fractions of moist air";
  output Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy at p, T, X";

algorithm
  h := specificEnthalpy(setState_pTX(p, T, X));
  annotation(smoothOrder=5,
             Inline=true,
             inverse(T=temperature_phX(p, h, X)),
             Documentation(info="<html>Specific enthalpy as a function of temperature and species
concentration. The pressure is input for compatibility with the medium
models, but the specific enthalpy is independent of the pressure.
</html>",
revisions="<html><ul>
  <li>April 30, 2015, by Filip Jorissen and Michael Wetter:<br/>
    Added <code>Inline=true</code> for <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/227\">issue 227</a>.
  </li>
</ul>
</html>"));
end specificEnthalpy_pTX;

redeclare replaceable function extends specificGibbsEnergy
    "Specific Gibbs energy"
algorithm
  g := specificEnthalpy(state) - state.T*specificEntropy(state);
  annotation (
    Inline=true);
end specificGibbsEnergy;

redeclare replaceable function extends specificHelmholtzEnergy
    "Specific Helmholtz energy"
algorithm
  f := specificEnthalpy(state) - gasConstant(state)*state.T - state.T*specificEntropy(state);
  annotation (
    Inline=true);
end specificHelmholtzEnergy;

redeclare function extends isentropicEnthalpy "Return the isentropic enthalpy"
algorithm
  h_is := specificEnthalpy(setState_psX(
            p=p_downstream,
            s=specificEntropy(refState),
            X=refState.X));
annotation (
  Inline=true,
  Documentation(info="<html><p>
  This function computes the specific enthalpy for an isentropic state
  change from the temperature that corresponds to the state
  <code>refState</code> to <code>reference_T</code>.
</p>
</html>",
revisions="<html><ul>
  <li>December 18, 2013, by Michael Wetter:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end isentropicEnthalpy;

redeclare function extends specificInternalEnergy "Specific internal energy"
  extends Modelica.Icons.Function;
algorithm
  u := specificEnthalpy(state) - pStp/dStp;
  annotation (
    Inline=true);
end specificInternalEnergy;

redeclare function extends temperature
    "Return temperature of ideal gas as a function of the thermodynamic state record"
algorithm
  T := state.T;
  annotation (
  smoothOrder=2,
  Inline=true,
  Documentation(info="<html>Temperature is returned from the thermodynamic state record input as a
simple assignment.
</html>"));
end temperature;

redeclare function extends molarMass "Return the molar mass"
algorithm
    MM := 1/(state.X[Water]/MMX[Water]+(1.0-state.X[Water])/MMX[Air]);
    annotation (
Inline=true,
smoothOrder=99,
Documentation(info="<html><p>
  This function returns the molar mass.
</p>
</html>",
revisions="<html><ul>
  <li>December 18, 2013, by Michael Wetter:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end molarMass;

redeclare replaceable function temperature_phX
    "Compute temperature from specific enthalpy and mass fraction"
    extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "specific enthalpy";
  input MassFraction[:] X "mass fractions of composition";
  output Temperature T "temperature";
algorithm
  T := reference_T + (h - h_fg * X[Water])
       /((1 - X[Water])*dryair.cp + X[Water] * steam.cp);
  annotation(smoothOrder=5,
             Inline=true,
             inverse(h=specificEnthalpy_pTX(p, T, X)),
             Documentation(info="<html>Temperature as a function of specific enthalpy and species
concentration. The pressure is input for compatibility with the medium
models, but the temperature is independent of the pressure.
</html>",
revisions="<html><ul>
  <li>April 30, 2015, by Filip Jorissen and Michael Wetter:<br/>
    Added <code>Inline=true</code> for <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/227\">issue 227</a>.
  </li>
</ul>
</html>"));
end temperature_phX;

redeclare function extends thermalConductivity
    "Thermal conductivity of dry air as a polynomial in the temperature"
algorithm
  lambda := Modelica.Media.Incompressible.TableBased.Polynomials_Temp.evaluate(
      {(-4.8737307422969E-008), 7.67803133753502E-005, 0.0241814385504202},
   Modelica.SIunits.Conversions.to_degC(state.T));
annotation(LateInline=true);
end thermalConductivity;
//////////////////////////////////////////////////////////////////////
// Protected classes.
// These classes are only of use within this medium model.
// Models generally have no need to access them.
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
      Documentation(info="<html><p>
  This data record contains the coefficients for perfect gases.
</p>
<ul>
  <li>September 12, 2014, by Michael Wetter:<br/>
    Corrected the wrong location of the <code>preferredView</code> and
    the <code>revisions</code> annotation.
  </li>
  <li>November 21, 2013, by Michael Wetter:<br/>
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
    "Temperature derivative of enthalpy of liquid per unit mass of liquid"
  extends Modelica.Icons.Function;
  input Temperature T "Temperature";
  input Real der_T "Temperature derivative";
  output Real der_h "Derivative of liquid enthalpy";
algorithm
  der_h := cpWatLiq*der_T;
  annotation (
    Inline=true);
end der_enthalpyOfLiquid;

function der_enthalpyOfCondensingGas
    "Derivative of enthalpy of steam per unit mass of steam"
  extends Modelica.Icons.Function;
  input Temperature T "Temperature";
  input Real der_T "Temperature derivative";
  output Real der_h "Derivative of steam enthalpy";
algorithm
  der_h := steam.cp*der_T;
  annotation (
    Inline=true);
end der_enthalpyOfCondensingGas;

replaceable function enthalpyOfDryAir
    "Enthalpy of dry air per unit mass of dry air"
  extends Modelica.Icons.Function;

  input Temperature T "Temperature";
  output SpecificEnthalpy h "Dry air enthalpy";
algorithm
  h := (T - reference_T)*dryair.cp;
  annotation (
    smoothOrder=5,
    Inline=true,
    derivative=der_enthalpyOfDryAir);
end enthalpyOfDryAir;

replaceable function der_enthalpyOfDryAir
    "Derivative of enthalpy of dry air per unit mass of dry air"
  extends Modelica.Icons.Function;
  input Temperature T "Temperature";
  input Real der_T "Temperature derivative";
  output Real der_h "Derivative of dry air enthalpy";
algorithm
  der_h := dryair.cp*der_T;
  annotation (
    Inline=true);
end der_enthalpyOfDryAir;

replaceable function der_enthalpyOfNonCondensingGas
    "Derivative of enthalpy of non-condensing gas per unit mass of steam"
  extends Modelica.Icons.Function;
  input Temperature T "Temperature";
  input Real der_T "Temperature derivative";
  output Real der_h "Derivative of steam enthalpy";
algorithm
  der_h := der_enthalpyOfDryAir(T, der_T);
  annotation (
    Inline=true);
end der_enthalpyOfNonCondensingGas;

replaceable function der_specificHeatCapacityCp
    "Derivative of specific heat capacity of gas mixture at constant pressure"
  extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state";
    input ThermodynamicState der_state "Derivative of thermodynamic state";
    output Real der_cp(unit="J/(kg.K.s)")
      "Derivative of specific heat capacity";
algorithm
  der_cp := (steam.cp-dryair.cp)*der_state.X[Water];
  annotation (
    Inline=true);
end der_specificHeatCapacityCp;

replaceable function der_specificHeatCapacityCv
    "Derivative of specific heat capacity of gas mixture at constant volume"
  extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state";
    input ThermodynamicState der_state "Derivative of thermodynamic state";
    output Real der_cv(unit="J/(kg.K.s)")
      "Derivative of specific heat capacity";
algorithm
  der_cv := (steam.cv-dryair.cv)*der_state.X[Water];
  annotation (
    Inline=true);
end der_specificHeatCapacityCv;
  annotation(preferredView="info", Documentation(info="<html><p>
  This medium package models moist air using a gas law in which
  pressure and temperature are independent, which often leads to
  significantly faster and more robust computations. Additionally, the
  density is constant to improve the simulation stability and speed.
</p>
<p>
  This medium uses the gas law
</p>
<p style=\"text-align:center;\">
  <i>ρ = ρ<sub>stp</sub>,</i>
</p>
<p>
  where <i>p<sub>std</sub></i> is a constant reference density.
</p>
<p>
  <br/>
  The medium model can be used for air duct simulations, where the
  pressures and temperatures are close to the reference values.
</p>
<p>
  <br/>
  Note that models in this package implement the equation for the
  internal energy as
</p>
<p style=\"text-align:center;\">
  <i>u = h - p<sub>stp</sub> ⁄ ρ<sub>stp</sub>,</i>
</p>
<p>
  where <i>u</i> is the internal energy per unit mass, <i>h</i> is the
  enthalpy per unit mass, <i>p<sub>stp</sub></i> is the static pressure
  and <i>ρ<sub>stp</sub></i> is the mass density at standard pressure
  and temperature. The reason for this implementation is that in
  general,
</p>
<p style=\"text-align:center;\">
  <i>h = u + p v,</i>
</p>
<p>
  from which follows that
</p>
<p style=\"text-align:center;\">
  <i>u = h - p v = h - p ⁄ ρ = h - p<sub>stp</sub> ⁄
  ρ<sub>std</sub>,</i>
</p>
<p>
  because <i>p ⁄ ρ = p<sub>stp</sub> ⁄ ρ<sub>stp</sub></i> in this
  medium model.
</p>
<p>
  The enthalpy is computed using the convention that <i>h=0</i> if
  <i>T=0</i> °C and no water vapor is present.
</p>
<ul>
  <li>January 09, 2020 by Alexander Kümpel:<br/>
    Copy from <a href=\"modelica://AixLib/Media/Air.mo\">Air</a> and
    density set constant
  </li>
</ul>
</html>"),
    Icon(graphics={
        Ellipse(
          extent={{-78,78},{-34,34}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-18,86},{26,42}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{48,58},{92,14}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-22,32},{22,-12}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{36,-32},{80,-76}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-36,-30},{8,-74}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-90,-6},{-46,-50}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120})}));
end AirIncompressible;
