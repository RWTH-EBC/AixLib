within AixLib.DataBase.CHP;
package ModularCHPEngineMedia
partial package CHPCombustionMixtureGasNasa
    "Medium model of a mixture of ideal gases based on NASA source"

  import Modelica.Math;
  import Modelica.Media.Interfaces.Choices.ReferenceEnthalpy;

  extends Modelica.Media.Interfaces.PartialMixtureMedium(
     ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX,
     substanceNames=data[:].name,
     reducedX = false,
     singleState=false,
     reference_X=fill(1/nX,nX),
     SpecificEnthalpy(start=if referenceChoice==ReferenceEnthalpy.ZeroAt0K then 3e5 else
        if referenceChoice==ReferenceEnthalpy.UserDefined then h_offset else 0, nominal=1.0e5),
     Density(start=10, nominal=10),
     AbsolutePressure(start=10e5, nominal=10e5),
     Temperature(min=200, max=6000, start=500, nominal=500));

    redeclare record extends ThermodynamicState "Thermodynamic state variables"
    end ThermodynamicState;

//   redeclare record extends FluidConstants "Fluid constants"
//   end FluidConstants;

  constant Modelica.Media.IdealGases.Common.DataRecord[:] data
    "Data records of ideal gas substances";
    // ={Common.SingleGasesData.N2,Common.SingleGasesData.O2}

  constant Boolean excludeEnthalpyOfFormation=true
    "If true, enthalpy of formation Hf is not included in specific enthalpy h";
  constant ReferenceEnthalpy referenceChoice=ReferenceEnthalpy.ZeroAt0K
    "Choice of reference enthalpy";
  constant SpecificEnthalpy h_offset=0.0
    "User defined offset for reference enthalpy, if referenceChoice = UserDefined";

//   constant FluidConstants[nX] fluidConstants
//     "Additional data needed for transport properties";
  constant MolarMass[nX] MMX=data[:].MM "Molar masses of components";
  constant Integer methodForThermalConductivity(min=1,max=2)=1;
  redeclare replaceable model extends BaseProperties(
    T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
    p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
    Xi(each stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
    final standardOrderComponents=true)
    "Base properties (p, d, T, h, u, R, MM, X, and Xi of NASA mixture gas"
  equation
    assert(T >= 200 and T <= 6000, "
Temperature T (=" + String(T) + " K = 200 K) is not in the allowed range
200 K <= T <= 6000 K
required from medium model \"" + mediumName + "\".");

    MM = molarMass(state);
    h = h_TX(T, X);
    R = data.R*X;
    u = h - R*T;
    d = p/(R*T);
    // connect state with BaseProperties
    state.T = T;
    state.p = p;
    state.X = if fixedX then reference_X else X;
  end BaseProperties;

    redeclare function setState_pTX
    "Return thermodynamic state as function of p, T and composition X"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := if size(X,1) == 0 then ThermodynamicState(p=p,T=T,X=reference_X) else if size(X,1) == nX then ThermodynamicState(p=p,T=T, X=X) else
             ThermodynamicState(p=p,T=T, X=cat(1,X,{1-sum(X)}));
    annotation(Inline=true,smoothOrder=2);
    end setState_pTX;

    redeclare function setState_phX
    "Return thermodynamic state as function of p, h and composition X"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := if size(X,1) == 0 then ThermodynamicState(p=p,T=T_hX(h,reference_X),X=reference_X) else if size(X,1) == nX then ThermodynamicState(p=p,T=T_hX(h,X),X=X) else
             ThermodynamicState(p=p,T=T_hX(h,X), X=cat(1,X,{1-sum(X)}));
      annotation(Inline=true,smoothOrder=2);
    end setState_phX;

    redeclare function setState_psX
    "Return thermodynamic state as function of p, s and composition X"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := if size(X,1) == 0 then ThermodynamicState(p=p,T=T_psX(p,s,reference_X),X=reference_X) else if size(X,1) == nX then ThermodynamicState(p=p,T=T_psX(p,s,X),X=X) else
             ThermodynamicState(p=p,T=T_psX(p,s,X), X=cat(1,X,{1-sum(X)}));
      annotation(Inline=true,smoothOrder=2);
    end setState_psX;

    redeclare function setState_dTX
    "Return thermodynamic state as function of d, T and composition X"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := if size(X,1) == 0 then ThermodynamicState(p=d*(data.R*reference_X)*T,T=T,X=reference_X) else if size(X,1) == nX then ThermodynamicState(p=d*(data.R*X)*T,T=T,X=X) else
             ThermodynamicState(p=d*(data.R*cat(1,X,{1-sum(X)}))*T,T=T, X=cat(1,X,{1-sum(X)}));
      annotation(Inline=true,smoothOrder=2);
    end setState_dTX;

      redeclare function extends setSmoothState
      "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
      algorithm
      state := ThermodynamicState(
              p=Modelica.Media.Common.smoothStep(
                x,
                state_a.p,
                state_b.p,
                x_small),
              T=Modelica.Media.Common.smoothStep(
                x,
                state_a.T,
                state_b.T,
                x_small),
              X=Modelica.Media.Common.smoothStep(
                x,
                state_a.X,
                state_b.X,
                x_small));
        annotation(Inline=true,smoothOrder=2);
      end setSmoothState;

    redeclare function extends pressure "Return pressure of ideal gas"
    algorithm
      p := state.p;
      annotation(Inline=true,smoothOrder=2);
    end pressure;

    redeclare function extends temperature "Return temperature of ideal gas"
    algorithm
      T := state.T;
      annotation(Inline=true,smoothOrder=2);
    end temperature;

    redeclare function extends density "Return density of ideal gas"
    algorithm
      d := state.p/((state.X*data.R)*state.T);
      annotation(Inline = true, smoothOrder = 3);
    end density;

  redeclare function extends specificEnthalpy "Return specific enthalpy"
    extends Modelica.Icons.Function;
  algorithm
    h := h_TX(state.T,state.X);
    annotation(Inline=true,smoothOrder=2);
  end specificEnthalpy;

  redeclare function extends specificInternalEnergy
    "Return specific internal energy"
    extends Modelica.Icons.Function;
  algorithm
    u := h_TX(state.T,state.X) - gasConstant(state)*state.T;
    annotation(Inline=true,smoothOrder=2);
  end specificInternalEnergy;

  redeclare function extends specificEntropy "Return specific entropy"
    protected
    Real[nX] Y(unit="mol/mol")=massToMoleFractions(state.X, data.MM)
      "Molar fractions";
  algorithm
  s :=  s_TX(state.T, state.X) - sum(state.X[i]*Modelica.Constants.R/MMX[i]*
      (if state.X[i]<Modelica.Constants.eps then Y[i] else
      Modelica.Math.log(Y[i]*state.p/reference_p)) for i in 1:nX);
    annotation(Inline=true,smoothOrder=2);
  end specificEntropy;

  redeclare function extends specificGibbsEnergy "Return specific Gibbs energy"
    extends Modelica.Icons.Function;
  algorithm
    g := h_TX(state.T,state.X) - state.T*specificEntropy(state);
    annotation(Inline=true,smoothOrder=2);
  end specificGibbsEnergy;

  redeclare function extends specificHelmholtzEnergy
    "Return specific Helmholtz energy"
    extends Modelica.Icons.Function;
  algorithm
    f := h_TX(state.T,state.X) - gasConstant(state)*state.T - state.T*specificEntropy(state);
    annotation(Inline=true,smoothOrder=2);
  end specificHelmholtzEnergy;

  function h_TX "Return specific enthalpy"
    import Modelica.Media.Interfaces.Choices;
     extends Modelica.Icons.Function;
     input Modelica.SIunits.Temperature T "Temperature";
     input MassFraction X[nX]=reference_X
      "Independent Mass fractions of gas mixture";
     input Boolean exclEnthForm=excludeEnthalpyOfFormation
      "If true, enthalpy of formation Hf is not included in specific enthalpy h";
     input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy
                                     refChoice=referenceChoice
      "Choice of reference enthalpy";
     input Modelica.SIunits.SpecificEnthalpy h_off=h_offset
        "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
     output Modelica.SIunits.SpecificEnthalpy h
        "Specific enthalpy at temperature T";
  algorithm
    h :=(if fixedX then reference_X else X)*
         {Modelica.Media.IdealGases.Common.Functions.h_T(
                            data[i], T, exclEnthForm, refChoice, h_off) for i in 1:nX};
    annotation(Inline=false,smoothOrder=2);
  end h_TX;

  function h_TX_der "Return specific enthalpy derivative"
    import Modelica.Media.Interfaces.Choices;
     extends Modelica.Icons.Function;
     input Modelica.SIunits.Temperature T "Temperature";
     input MassFraction X[nX] "Independent Mass fractions of gas mixture";
     input Boolean exclEnthForm=excludeEnthalpyOfFormation
      "If true, enthalpy of formation Hf is not included in specific enthalpy h";
     input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy
                                     refChoice=referenceChoice
      "Choice of reference enthalpy";
     input Modelica.SIunits.SpecificEnthalpy h_off=h_offset
        "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
    input Real dT "Temperature derivative";
    input Real dX[nX] "Independent mass fraction derivative";
    output Real h_der "Specific enthalpy at temperature T";
  algorithm
    h_der := if fixedX then
      dT*sum((Modelica.Media.IdealGases.Common.Functions.cp_T(
                                 data[i], T)*reference_X[i]) for i in 1:nX) else
      dT*sum((Modelica.Media.IdealGases.Common.Functions.cp_T(
                                 data[i], T)*X[i]) for i in 1:nX)+
      sum((Modelica.Media.IdealGases.Common.Functions.h_T(
                             data[i], T)*dX[i]) for i in 1:nX);
    annotation (Inline = false, smoothOrder=1);
  end h_TX_der;

  redeclare function extends gasConstant "Return gasConstant"
  algorithm
    R := data.R*state.X;
    annotation(Inline = true, smoothOrder = 3);
  end gasConstant;

  redeclare function extends specificHeatCapacityCp
    "Return specific heat capacity at constant pressure"
  algorithm
    cp := {Modelica.Media.IdealGases.Common.Functions.cp_T(
                              data[i], state.T) for i in 1:nX}*state.X;
    annotation(Inline=true,smoothOrder=1);
  end specificHeatCapacityCp;

  redeclare function extends specificHeatCapacityCv
    "Return specific heat capacity at constant volume from temperature and gas data"
  algorithm
    cv := {Modelica.Media.IdealGases.Common.Functions.cp_T(
                              data[i], state.T) for i in 1:nX}*state.X -data.R*state.X;
    annotation(Inline=true, smoothOrder = 1);
  end specificHeatCapacityCv;

  function MixEntropy "Return mixing entropy of ideal gases / R"
    extends Modelica.Icons.Function;
    input Modelica.SIunits.MoleFraction x[:] "Mole fraction of mixture";
    output Real smix "Mixing entropy contribution, divided by gas constant";
  algorithm
    smix := sum(if x[i] > Modelica.Constants.eps then -x[i]*Modelica.Math.log(x[i]) else
                     x[i] for i in 1:size(x,1));
    annotation(Inline=true,smoothOrder=2);
  end MixEntropy;

  function s_TX
    "Return temperature dependent part of the entropy, expects full entropy vector"
    extends Modelica.Icons.Function;
    input Temperature T "Temperature";
    input MassFraction[nX] X "Mass fraction";
    output SpecificEntropy s "Specific entropy";
  algorithm
    s := sum(Modelica.Media.IdealGases.Common.Functions.s0_T(
                                data[i], T)*X[i] for i in 1:size(X,1));
    annotation(Inline=true,smoothOrder=2);
  end s_TX;

  redeclare function extends isentropicExponent "Return isentropic exponent"
  algorithm
    gamma := specificHeatCapacityCp(state)/specificHeatCapacityCv(state);
    annotation(Inline=true,smoothOrder=2);
  end isentropicExponent;

  redeclare function extends velocityOfSound "Return velocity of sound"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Properties at upstream location";
  algorithm
    a := sqrt(max(0,gasConstant(state)*state.T*specificHeatCapacityCp(state)/specificHeatCapacityCv(state)));
    annotation(Inline=true,smoothOrder=2);
  end velocityOfSound;

  function isentropicEnthalpyApproximation
    "Approximate method of calculating h_is from upstream properties and downstream pressure"
    extends Modelica.Icons.Function;
    input AbsolutePressure p2 "Downstream pressure";
    input ThermodynamicState state "Thermodynamic state at upstream location";
    output SpecificEnthalpy h_is "Isentropic enthalpy";
    protected
    SpecificEnthalpy h "Specific enthalpy at upstream location";
    SpecificEnthalpy h_component[nX] "Specific enthalpy at upstream location";
    IsentropicExponent gamma =  isentropicExponent(state) "Isentropic exponent";
    protected
    MassFraction[nX] X "Complete X-vector";
  algorithm
    X := if reducedX then cat(1,state.X,{1-sum(state.X)}) else state.X;
    h_component :={Modelica.Media.IdealGases.Common.Functions.h_T(
                                     data[i], state.T, excludeEnthalpyOfFormation,
      referenceChoice, h_offset) for i in 1:nX};
    h :=h_component*X;
    h_is := h + gamma/(gamma - 1.0)*(state.T*gasConstant(state))*
      ((p2/state.p)^((gamma - 1)/gamma) - 1.0);
    annotation(smoothOrder=2);
  end isentropicEnthalpyApproximation;

  redeclare function extends isentropicEnthalpy "Return isentropic enthalpy"
    input Boolean exact = false
      "Flag whether exact or approximate version should be used";
  algorithm
    h_is := if exact then specificEnthalpy_psX(p_downstream,specificEntropy(refState),refState.X) else
           isentropicEnthalpyApproximation(p_downstream,refState);
    annotation(Inline=true,smoothOrder=2);
  end isentropicEnthalpy;

function gasMixtureViscosity
    "Return viscosities of gas mixtures at low pressures (Wilke method)"
  extends Modelica.Icons.Function;
  input MoleFraction[:] yi "Mole fractions";
  input MolarMass[size(yi,1)] M "Mole masses";
  input DynamicViscosity[size(yi,1)] eta "Pure component viscosities";
  output DynamicViscosity etam "Viscosity of the mixture";
    protected
  Real fi[size(yi,1),size(yi,1)];
algorithm
  for i in 1:size(eta,1) loop
    assert(fluidConstants[i].hasDipoleMoment,"Dipole moment for " + fluidConstants[i].chemicalFormula +
       " not known. Can not compute viscosity.");
    assert(fluidConstants[i].hasCriticalData, "Critical data for "+ fluidConstants[i].chemicalFormula +
       " not known. Can not compute viscosity.");
    for j in 1:size(eta,1) loop
      if i==1 then
        fi[i,j] := (1 + (eta[i]/eta[j])^(1/2)*(M[j]/M[i])^(1/4))^2/(8*(1 + M[i]/M[j]))^(1/2);
      elseif j<i then
          fi[i,j] := eta[i]/eta[j]*M[j]/M[i]*fi[j,i];
        else
          fi[i,j] := (1 + (eta[i]/eta[j])^(1/2)*(M[j]/M[i])^(1/4))^2/(8*(1 + M[i]/M[j]))^(1/2);
      end if;
    end for;
  end for;
  etam := sum(yi[i]*eta[i]/sum(yi[j]*fi[i,j] for j in 1:size(eta,1)) for i in 1:size(eta,1));

  annotation (smoothOrder=2,
             Documentation(info="<html>

<p>
Simplification of the kinetic theory (Chapman and Enskog theory)
approach neglecting the second-order effects.<br>
<br>
This equation has been extensively tested (Amdur and Mason, 1958;
Bromley and Wilke, 1951; Cheung, 1958; Dahler, 1959; Gandhi and Saxena,
1964; Ranz and Brodowsky, 1962; Saxena and Gambhir, 1963a; Strunk, et
al., 1964; Vanderslice, et al. 1962; Wright and Gray, 1962). In most
cases, only nonpolar mixtures were compared, and very good results
obtained. For some systems containing hydrogen as one component, less
satisfactory agreement was noted. Wilke's method predicted mixture
viscosities that were larger than experimental for the H2-N2 system,
but for H2-NH3, it underestimated the viscosities. <br>
Gururaja, et al. (1967) found that this method also overpredicted in
the H2-O2 case but was quite accurate for the H2-CO2 system. <br>
Wilke's approximation has proved reliable even for polar-polar gas
mixtures of aliphatic alcohols (Reid and Belenyessy, 1960). The
principal reservation appears to lie in those cases where Mi&gt;&gt;Mj
and etai&gt;&gt;etaj.<br>
</p>

</html>"));
end gasMixtureViscosity;

    redeclare replaceable function extends dynamicViscosity
    "Return mixture dynamic viscosity"
    protected
      DynamicViscosity[nX] etaX "Component dynamic viscosities";
    algorithm
      for i in 1:nX loop
    etaX[i] := Modelica.Media.IdealGases.Common.Functions.dynamicViscosityLowPressure(
                                                         state.T,
                       fluidConstants[i].criticalTemperature,
                       fluidConstants[i].molarMass,
                       fluidConstants[i].criticalMolarVolume,
                       fluidConstants[i].acentricFactor,
                       fluidConstants[i].dipoleMoment);
      end for;
      eta := gasMixtureViscosity(massToMoleFractions(state.X,
                             fluidConstants[:].molarMass),
                 fluidConstants[:].molarMass,
                 etaX);
      annotation (smoothOrder=2);
    end dynamicViscosity;

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

function lowPressureThermalConductivity
    "Return thermal conductivities of low-pressure gas mixtures (Mason and Saxena Modification)"
  extends Modelica.Icons.Function;
  input MoleFraction[:] y "Mole fraction of the components in the gas mixture";
  input Temperature T "Temperature";
  input Temperature[size(y,1)] Tc "Critical temperatures";
  input AbsolutePressure[size(y,1)] Pc "Critical pressures";
  input MolarMass[size(y,1)] M "Molecular weights";
  input ThermalConductivity[size(y,1)] lambda
      "Thermal conductivities of the pure gases";
  output ThermalConductivity lambdam "Thermal conductivity of the gas mixture";
    protected
  MolarMass[size(y,1)] gamma;
  Real[size(y,1)] Tr "Reduced temperature";
  Real[size(y,1),size(y,1)] A "Mason and Saxena Modification";
  constant Real epsilon =  1.0 "Numerical constant near unity";
algorithm
  for i in 1:size(y,1) loop
    gamma[i] := 210*(Tc[i]*M[i]^3/Pc[i]^4)^(1/6);
    Tr[i] := T/Tc[i];
  end for;
  for i in 1:size(y,1) loop
    for j in 1:size(y,1) loop
      A[i,j] := epsilon*(1 + (gamma[j]*(Math.exp(0.0464*Tr[i]) - Math.exp(-0.2412*Tr[i]))/
      (gamma[i]*(Math.exp(0.0464*Tr[j]) - Math.exp(-0.2412*Tr[j]))))^(1/2)*(M[i]/M[j])^(1/4))^2/
      (8*(1 + M[i]/M[j]))^(1/2);
    end for;
  end for;
  lambdam := sum(y[i]*lambda[i]/(sum(y[j]*A[i,j] for j in 1:size(y,1))) for i in 1:size(y,1));

  annotation (smoothOrder=2,
              Documentation(info="<html>

<p>
This function applies the Masson and Saxena modification of the
Wassiljewa Equation for the thermal conductivity for gas mixtures of
n elements at low pressure.
</p>

<p>
For nonpolar gas mixtures errors will generally be less than 3 to 4%.
For mixtures of nonpolar-polar and polar-polar gases, errors greater
than 5 to 8% may be expected. For mixtures in which the sizes and
polarities of the constituent molecules are not greatly different, the
thermal conductivity can be estimated satisfactorily by a mole fraction
average of the pure component conductivities.
</p>

</html>"));
end lowPressureThermalConductivity;

    redeclare replaceable function extends thermalConductivity
    "Return thermal conductivity for low pressure gas mixtures"
      input Integer method=methodForThermalConductivity
      "Method to compute single component thermal conductivity";
    protected
      ThermalConductivity[nX] lambdaX "Component thermal conductivities";
      DynamicViscosity[nX] eta "Component thermal dynamic viscosities";
      SpecificHeatCapacity[nX] cp "Component heat capacity";
    algorithm
      for i in 1:nX loop
    assert(fluidConstants[i].hasCriticalData, "Critical data for "+ fluidConstants[i].chemicalFormula +
       " not known. Can not compute thermal conductivity.");
    eta[i] := Modelica.Media.IdealGases.Common.Functions.dynamicViscosityLowPressure(
                                                        state.T,
                       fluidConstants[i].criticalTemperature,
                       fluidConstants[i].molarMass,
                       fluidConstants[i].criticalMolarVolume,
                       fluidConstants[i].acentricFactor,
                       fluidConstants[i].dipoleMoment);
    cp[i] := Modelica.Media.IdealGases.Common.Functions.cp_T(
                                data[i],state.T);
    lambdaX[i] :=Modelica.Media.IdealGases.Common.Functions.thermalConductivityEstimate(
                                                           Cp=cp[i], eta=
          eta[i], method=method,data=data[i]);
      end for;
      lambda := lowPressureThermalConductivity(massToMoleFractions(state.X,
                                   fluidConstants[:].molarMass),
                           state.T,
                           fluidConstants[:].criticalTemperature,
                           fluidConstants[:].criticalPressure,
                           fluidConstants[:].molarMass,
                           lambdaX);
      annotation (smoothOrder=2);
    end thermalConductivity;

  redeclare function extends isobaricExpansionCoefficient
    "Return isobaric expansion coefficient beta"
  algorithm
    beta := 1/state.T;
    annotation(Inline=true,smoothOrder=2);
  end isobaricExpansionCoefficient;

  redeclare function extends isothermalCompressibility
    "Return isothermal compressibility factor"
  algorithm
    kappa := 1.0/state.p;
    annotation(Inline=true,smoothOrder=2);
  end isothermalCompressibility;

  redeclare function extends density_derp_T
    "Return density derivative by pressure at constant temperature"
  algorithm
    ddpT := 1/(state.T*gasConstant(state));
    annotation(Inline=true,smoothOrder=2);
  end density_derp_T;

  redeclare function extends density_derT_p
    "Return density derivative by temperature at constant pressure"
  algorithm
    ddTp := -state.p/(state.T*state.T*gasConstant(state));
    annotation(Inline=true,smoothOrder=2);
  end density_derT_p;

  redeclare function density_derX "Return density derivative by mass fraction"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    output Density[nX] dddX "Derivative of density w.r.t. mass fraction";
  algorithm
    dddX := {-state.p/(state.T*gasConstant(state))*molarMass(state)/data[
      i].MM for i in 1:nX};
    annotation(Inline=true,smoothOrder=2);
  end density_derX;

  redeclare function extends molarMass "Return molar mass of mixture"
  algorithm
    MM := 1/sum(state.X[j]/data[j].MM for j in 1:size(state.X, 1));
    annotation(Inline=true,smoothOrder=2);
  end molarMass;

  function T_hX "Return temperature from specific enthalpy and mass fraction"
    extends Modelica.Icons.Function;
    input SpecificEnthalpy h "Specific enthalpy";
    input MassFraction[nX] X "Mass fractions of composition";
     input Boolean exclEnthForm=excludeEnthalpyOfFormation
      "If true, enthalpy of formation Hf is not included in specific enthalpy h";
     input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy
                                     refChoice=referenceChoice
      "Choice of reference enthalpy";
     input Modelica.SIunits.SpecificEnthalpy h_off=h_offset
        "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
    output Temperature T "Temperature";
    protected
    MassFraction[nX] Xfull = if size(X,1) == nX then X else cat(1,X,{1-sum(X)});
  package Internal
      "Solve h(data,T) for T with given h (use only indirectly via temperature_phX)"
    extends Modelica.Media.Common.OneNonLinearEquation;
    redeclare record extends f_nonlinear_Data
        "Data to be passed to non-linear function"
      extends Modelica.Media.IdealGases.Common.DataRecord;
    end f_nonlinear_Data;

    redeclare function extends f_nonlinear
    algorithm
        y := h_TX(x,X);
    end f_nonlinear;

    // Dummy definition has to be added for current Dymola
    redeclare function extends solve
    end solve;
  end Internal;

  algorithm
    T := Internal.solve(h, 200, 6000, 1.0e5, Xfull, data[1]);
    annotation(inverse(h = h_TX(T,X,exclEnthForm,refChoice,h_off)));
  end T_hX;

  function T_psX
    "Return temperature from pressure, specific entropy and mass fraction"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input MassFraction[nX] X "Mass fractions of composition";
    output Temperature T "Temperature";
    protected
    MassFraction[nX] Xfull = if size(X,1) == nX then X else cat(1,X,{1-sum(X)});
  package Internal
      "Solve h(data,T) for T with given h (use only indirectly via temperature_phX)"
    extends Modelica.Media.Common.OneNonLinearEquation;
    redeclare record extends f_nonlinear_Data
        "Data to be passed to non-linear function"
      extends Modelica.Media.IdealGases.Common.DataRecord;
    end f_nonlinear_Data;

    redeclare function extends f_nonlinear
        "Note that this function always sees the complete mass fraction vector"
        protected
    MassFraction[nX] Xfull = if size(X,1) == nX then X else cat(1,X,{1-sum(X)});
    Real[nX] Y(unit="mol/mol")=massToMoleFractions(if size(X,1) == nX then X else cat(1,X,{1-sum(X)}), data.MM)
          "Molar fractions";
    algorithm
      y := s_TX(x,Xfull) - sum(Xfull[i]*Modelica.Constants.R/MMX[i]*
      (if Xfull[i]<Modelica.Constants.eps then Y[i] else
      Modelica.Math.log(Y[i]*p/reference_p)) for i in 1:nX);
        // s_TX(x,X)- data[:].R*X*(Modelica.Math.log(p/reference_p)
        //       + MixEntropy(massToMoleFractions(X,data[:].MM)));
    end f_nonlinear;

    // Dummy definition has to be added for current Dymola
    redeclare function extends solve
    end solve;
  end Internal;

  algorithm
    T := Internal.solve(s, 200, 6000, p, Xfull, data[1]);
  end T_psX;

//   redeclare function extends specificEnthalpy_psX
//   protected
//     Temperature T "Temperature";
//   algorithm
//     T := temperature_psX(p,s,X);
//     h := specificEnthalpy_pTX(p,T,X);
//   end extends;

//   redeclare function extends density_phX
//     "Compute density from pressure, specific enthalpy and mass fraction"
//     protected
//     Temperature T "Temperature";
//     SpecificHeatCapacity R "Gas constant";
//   algorithm
//     T := temperature_phX(p,h,X);
//     R := if (not reducedX) then
//       sum(data[i].R*X[i] for i in 1:size(substanceNames, 1)) else
//       sum(data[i].R*X[i] for i in 1:size(substanceNames, 1)-1) + data[end].R*(1-sum(X[i]));
//     d := p/(R*T);
//   end density_phX;

  annotation (Documentation(info="<html>
<p>
This model calculates the medium properties for single component ideal gases.
</p>
<p>
<b>Sources for model and literature:</b><br>
Original Data: Computer program for calculation of complex chemical
equilibrium compositions and applications. Part 1: Analysis
Document ID: 19950013764 N (95N20180) File Series: NASA Technical Reports
Report Number: NASA-RP-1311  E-8017  NAS 1.61:1311
Authors: Gordon, Sanford (NASA Lewis Research Center)
 Mcbride, Bonnie J. (NASA Lewis Research Center)
Published: Oct 01, 1994.
</p>
<p><b>Known limits of validity:</b></br>
The data is valid for
temperatures between 200 K and 6000 K.  A few of the data sets for
monatomic gases have a discontinuous 1st derivative at 1000 K, but
this never caused problems so far.
</p>
<p>
This model has been copied from the ThermoFluid library.
It has been developed by Hubertus Tummescheit.
</p>
</html>"));
end CHPCombustionMixtureGasNasa;

  package NaturalGasMixture_GeneralType
    "Simple natural gas mixture for CHP-engine combustion"
    import AixLib;

    extends
      AixLib.DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa(
      mediumName="NaturalGasMixture_SelectableVolumetricProportions",
      data={Modelica.Media.IdealGases.Common.SingleGasesData.N2,Modelica.Media.IdealGases.Common.SingleGasesData.CH4,
          Modelica.Media.IdealGases.Common.SingleGasesData.C2H4,Modelica.Media.IdealGases.Common.SingleGasesData.C2H6,
          Modelica.Media.IdealGases.Common.SingleGasesData.C3H8,Modelica.Media.IdealGases.Common.SingleGasesData.C4H10_n_butane,
          Modelica.Media.IdealGases.Common.SingleGasesData.C5H12_n_pentane,
          Modelica.Media.IdealGases.Common.SingleGasesData.C6H14_n_hexane,
          Modelica.Media.IdealGases.Common.SingleGasesData.CO2},
      fluidConstants={Modelica.Media.IdealGases.Common.FluidData.N2,Modelica.Media.IdealGases.Common.FluidData.CH4,
          Modelica.Media.IdealGases.Common.FluidData.C2H4,Modelica.Media.IdealGases.Common.FluidData.C2H6,
          Modelica.Media.IdealGases.Common.FluidData.C3H8,Modelica.Media.IdealGases.Common.FluidData.C4H10_n_butane,
          Modelica.Media.IdealGases.Common.FluidData.C5H12_n_pentane,Modelica.Media.IdealGases.Common.FluidData.C6H14_n_hexane,
          Modelica.Media.IdealGases.Common.FluidData.CO2},
      substanceNames={"Nitrogen","Methane","Ethene","Ethane","Propane",
          "n-Butane","n-Pentane","n-Hexane","Carbondioxide"});

    constant
      AixLib.DataBase.CHP.ModularCHPEngineMedia.CombustionEngineFuelDataBaseRecord
      NatGasTyp=NaturalGas_GeneralDefinition()
      "Needed natural gas data for calculations, manual redefinition of volumetric proportions of the gas components (Xi_mole) required (default:{1/9,1/9,...})!"
      annotation (choicesAllMatching=true, Dialog(group="Natural gas type"));

     import Modelica.SIunits.*;

    constant MoleFraction moleFractions_Gas[:] = NatGasTyp.Xi_mole;
    constant MolarMass MM = sum(NatGasTyp.Xi_mole[i]*NatGasTyp.MMi[i] for i in 1:size(NatGasTyp.MMi, 1)) "Molar mass of natural gas type from its composition";
    constant MassFraction massFractions_Gas[:] = Modelica.Media.Interfaces.PartialMixtureMedium.moleToMassFractions(NatGasTyp.Xi_mole, NatGasTyp.MMi);
    constant SpecificEnergy H_U = sum(massFractions_Gas[i]*NatGasTyp.H_Ui[i] for i in 1:size(NatGasTyp.MMi, 1)) "Calorific Value of the fuel gas";
    constant Real l_min = sum(NatGasTyp.Xi_mole[i]*NatGasTyp.nue_min[i] for i in 1:size(NatGasTyp.MMi, 1))/0.21;
    constant Real L_st = l_min*0.02885/MM "Stoichiometric air consumption";

    record NaturalGas_GeneralDefinition
      extends
        AixLib.DataBase.CHP.ModularCHPEngineMedia.CombustionEngineFuelDataBaseRecord(
          naturalGasType="GeneralTypeForRedefinition", Xi_mole={1/9,1/9,1/9,1/9,
            1/9,1/9,1/9,1/9,1/9});
    end NaturalGas_GeneralDefinition;

    annotation (Documentation(info="<html>
<p>Gasoline model for natural gas type H.</p>
</html>"));
  end NaturalGasMixture_GeneralType;

  package NaturalGasMixture_TypeAachen
    "Simple natural gas mixture (type Aachen) for CHP-engine combustion"

    extends
      AixLib.DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa(
      mediumName="NaturalGasMixtureForAachen",
      data={Modelica.Media.IdealGases.Common.SingleGasesData.N2,Modelica.Media.IdealGases.Common.SingleGasesData.CH4,
          Modelica.Media.IdealGases.Common.SingleGasesData.C2H4,Modelica.Media.IdealGases.Common.SingleGasesData.C2H6,
          Modelica.Media.IdealGases.Common.SingleGasesData.C3H8,Modelica.Media.IdealGases.Common.SingleGasesData.C4H10_n_butane,
          Modelica.Media.IdealGases.Common.SingleGasesData.C5H12_n_pentane,
          Modelica.Media.IdealGases.Common.SingleGasesData.C6H14_n_hexane,
          Modelica.Media.IdealGases.Common.SingleGasesData.CO2},
      fluidConstants={Modelica.Media.IdealGases.Common.FluidData.N2,Modelica.Media.IdealGases.Common.FluidData.CH4,
          Modelica.Media.IdealGases.Common.FluidData.C2H4,Modelica.Media.IdealGases.Common.FluidData.C2H6,
          Modelica.Media.IdealGases.Common.FluidData.C3H8,Modelica.Media.IdealGases.Common.FluidData.C4H10_n_butane,
          Modelica.Media.IdealGases.Common.FluidData.C5H12_n_pentane,Modelica.Media.IdealGases.Common.FluidData.C6H14_n_hexane,
          Modelica.Media.IdealGases.Common.FluidData.CO2},
      substanceNames={"Nitrogen","Methane","Ethene","Ethane","Propane",
          "n-Butane","n-Pentane","n-Hexane","Carbondioxide"});

    constant
      AixLib.DataBase.CHP.ModularCHPEngineMedia.CombustionEngineFuelDataBaseRecord
      NatGasTyp=NaturalGasTypeAachen()
      "Needed natural gas data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Natural gas type"));

     import Modelica.SIunits.*;

    constant MoleFraction moleFractions_Gas[:] = NatGasTyp.Xi_mole;
    constant MolarMass MM = sum(NatGasTyp.Xi_mole[i]*NatGasTyp.MMi[i] for i in 1:size(NatGasTyp.MMi, 1)) "Molar mass of natural gas type from its composition";
    constant MassFraction massFractions_Gas[:] = Modelica.Media.Interfaces.PartialMixtureMedium.moleToMassFractions(NatGasTyp.Xi_mole, NatGasTyp.MMi);
    constant SpecificEnergy H_U = sum(massFractions_Gas[i]*NatGasTyp.H_Ui[i] for i in 1:size(NatGasTyp.MMi, 1)) "Calorific Value of the fuel gas";
    constant Real l_min = sum(NatGasTyp.Xi_mole[i]*NatGasTyp.nue_min[i] for i in 1:size(NatGasTyp.MMi, 1))/0.21;
    constant Real L_st = l_min*0.02885/MM "Stoichiometric air consumption";

    record NaturalGasTypeAachen
      extends
        AixLib.DataBase.CHP.ModularCHPEngineMedia.CombustionEngineFuelDataBaseRecord(
          naturalGasType="TypeAachen", Xi_mole={0.0089,0.9255,0,0.045,0.0063,
            0.0019,0.0004,0.0001,0.0119});
    end NaturalGasTypeAachen;
    annotation (Documentation(info="<html>
<p>Gasoline model for natural gas type H.</p>
</html>"));
  end NaturalGasMixture_TypeAachen;

  package NaturalGasMixture_TypeH
    "Simple natural gas mixture (type H) for CHP-engine combustion"

    extends
      AixLib.DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa(
      mediumName="NaturalGasMixtureTypeH",
      data={Modelica.Media.IdealGases.Common.SingleGasesData.N2,Modelica.Media.IdealGases.Common.SingleGasesData.CH4,
          Modelica.Media.IdealGases.Common.SingleGasesData.C2H4,Modelica.Media.IdealGases.Common.SingleGasesData.C2H6,
          Modelica.Media.IdealGases.Common.SingleGasesData.C3H8,Modelica.Media.IdealGases.Common.SingleGasesData.C4H10_n_butane,
          Modelica.Media.IdealGases.Common.SingleGasesData.C5H12_n_pentane,
          Modelica.Media.IdealGases.Common.SingleGasesData.C6H14_n_hexane,
          Modelica.Media.IdealGases.Common.SingleGasesData.CO2},
      fluidConstants={Modelica.Media.IdealGases.Common.FluidData.N2,Modelica.Media.IdealGases.Common.FluidData.CH4,
          Modelica.Media.IdealGases.Common.FluidData.C2H4,Modelica.Media.IdealGases.Common.FluidData.C2H6,
          Modelica.Media.IdealGases.Common.FluidData.C3H8,Modelica.Media.IdealGases.Common.FluidData.C4H10_n_butane,
          Modelica.Media.IdealGases.Common.FluidData.C5H12_n_pentane,Modelica.Media.IdealGases.Common.FluidData.C6H14_n_hexane,
          Modelica.Media.IdealGases.Common.FluidData.CO2},
      substanceNames={"Nitrogen","Methane","Ethene","Ethane","Propane",
          "n-Butane","n-Pentane","n-Hexane","Carbondioxide"});

    constant
      AixLib.DataBase.CHP.ModularCHPEngineMedia.CombustionEngineFuelDataBaseRecord
      NatGasTyp=NaturalGasTypeH() "Needed natural gas data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Natural gas type"));

     import Modelica.SIunits.*;

    constant MoleFraction moleFractions_Gas[:] = NatGasTyp.Xi_mole;
    constant MolarMass MM = sum(NatGasTyp.Xi_mole[i]*NatGasTyp.MMi[i] for i in 1:size(NatGasTyp.MMi, 1)) "Molar mass of natural gas type from its composition";
    constant MassFraction massFractions_Gas[:] = Modelica.Media.Interfaces.PartialMixtureMedium.moleToMassFractions(NatGasTyp.Xi_mole, NatGasTyp.MMi);
    constant SpecificEnergy H_U = sum(massFractions_Gas[i]*NatGasTyp.H_Ui[i] for i in 1:size(NatGasTyp.MMi, 1)) "Calorific Value of the fuel gas";
    constant Real l_min = sum(NatGasTyp.Xi_mole[i]*NatGasTyp.nue_min[i] for i in 1:size(NatGasTyp.MMi, 1))/0.21;
    constant Real L_st = l_min*0.02885/MM "Stoichiometric air consumption";

    record NaturalGasTypeH
      extends
        AixLib.DataBase.CHP.ModularCHPEngineMedia.CombustionEngineFuelDataBaseRecord(
          naturalGasType="TypeH", Xi_mole={0.007,0.854,0,0.08,0.029,0.01,0,0,
            0.02});
    end NaturalGasTypeH;
    annotation (Documentation(info="<html>
<p>Gasoline model for natural gas type H.</p>
</html>"));
  end NaturalGasMixture_TypeH;

  package NaturalGasMixture_TypeL
    "Simple natural gas mixture (type L) for CHP-engine combustion"

    extends
      AixLib.DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa(
      mediumName="NaturalGasMixtureTypeL",
      data={Modelica.Media.IdealGases.Common.SingleGasesData.N2,Modelica.Media.IdealGases.Common.SingleGasesData.CH4,
          Modelica.Media.IdealGases.Common.SingleGasesData.C2H4,Modelica.Media.IdealGases.Common.SingleGasesData.C2H6,
          Modelica.Media.IdealGases.Common.SingleGasesData.C3H8,Modelica.Media.IdealGases.Common.SingleGasesData.C4H10_n_butane,
          Modelica.Media.IdealGases.Common.SingleGasesData.C5H12_n_pentane,
          Modelica.Media.IdealGases.Common.SingleGasesData.C6H14_n_hexane,
          Modelica.Media.IdealGases.Common.SingleGasesData.CO2},
      fluidConstants={Modelica.Media.IdealGases.Common.FluidData.N2,Modelica.Media.IdealGases.Common.FluidData.CH4,
          Modelica.Media.IdealGases.Common.FluidData.C2H4,Modelica.Media.IdealGases.Common.FluidData.C2H6,
          Modelica.Media.IdealGases.Common.FluidData.C3H8,Modelica.Media.IdealGases.Common.FluidData.C4H10_n_butane,
          Modelica.Media.IdealGases.Common.FluidData.C5H12_n_pentane,Modelica.Media.IdealGases.Common.FluidData.C6H14_n_hexane,
          Modelica.Media.IdealGases.Common.FluidData.CO2},
      substanceNames={"Nitrogen","Methane","Ethene","Ethane","Propane",
          "n-Butane","n-Pentane","n-Hexane","Carbondioxide"});

    constant
      AixLib.DataBase.CHP.ModularCHPEngineMedia.CombustionEngineFuelDataBaseRecord
      NatGasTyp=NaturalGasTypeL() "Needed natural gas data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Natural gas type"));

     import Modelica.SIunits.*;

    constant MoleFraction moleFractions_Gas[:] = NatGasTyp.Xi_mole;
    constant MolarMass MM = sum(NatGasTyp.Xi_mole[i]*NatGasTyp.MMi[i] for i in 1:size(NatGasTyp.MMi, 1)) "Molar mass of natural gas type from its composition";
    constant MassFraction massFractions_Gas[:] = Modelica.Media.Interfaces.PartialMixtureMedium.moleToMassFractions(NatGasTyp.Xi_mole, NatGasTyp.MMi);
    constant SpecificEnergy H_U = sum(massFractions_Gas[i]*NatGasTyp.H_Ui[i] for i in 1:size(NatGasTyp.MMi, 1)) "Calorific Value of the fuel gas";
    constant Real l_min = sum(NatGasTyp.Xi_mole[i]*NatGasTyp.nue_min[i] for i in 1:size(NatGasTyp.MMi, 1))/0.21;
    constant Real L_st = l_min*0.02885/MM "Stoichiometric air consumption";

    record NaturalGasTypeL
      extends
        AixLib.DataBase.CHP.ModularCHPEngineMedia.CombustionEngineFuelDataBaseRecord(
          naturalGasType="TypeL", Xi_mole={0.126,0.82,0,0.033,0.006,0.003,0,0,
            0.012});
    end NaturalGasTypeL;
    annotation (Documentation(info="<html>
<p>Gasoline model for natural gas type H.</p>
</html>"));
  end NaturalGasMixture_TypeL;

  package CHPFlueGasLambdaOnePlus
    "Simple flue gas for overstoichiometric O2-fuel ratios"
    extends
      AixLib.DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa(
      mediumName="FlueGasLambdaPlus",
      data={Modelica.Media.IdealGases.Common.SingleGasesData.N2,Modelica.Media.IdealGases.Common.SingleGasesData.O2,
          Modelica.Media.IdealGases.Common.SingleGasesData.H2O,Modelica.Media.IdealGases.Common.SingleGasesData.CO2},
      fluidConstants={Modelica.Media.IdealGases.Common.FluidData.N2,Modelica.Media.IdealGases.Common.FluidData.O2,
          Modelica.Media.IdealGases.Common.FluidData.H2O,Modelica.Media.IdealGases.Common.FluidData.CO2},
      substanceNames={"Nitrogen","Oxygen","Water","Carbondioxide"},
      reference_X={0.768,0.232,0.0,0.0});

    annotation (Documentation(info="<html>

</html>"));
  end CHPFlueGasLambdaOnePlus;

  package EngineCombustionAir "Air as mixture of N2 and O2"
    extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
      mediumName="CombustionAirN2O2",
      data={Modelica.Media.IdealGases.Common.SingleGasesData.N2,Modelica.Media.IdealGases.Common.SingleGasesData.O2},
      fluidConstants={Modelica.Media.IdealGases.Common.FluidData.N2,Modelica.Media.IdealGases.Common.FluidData.O2},
      substanceNames={"Nitrogen","Oxygen"}, reference_X = {0.768, 0.232});

    //!!For the script calculating the combustion: Nitrogen has to be at first place for the composition of the fuel!!"
      constant ThermodynamicState stateAir = setState_pTX(reference_p, reference_T, reference_X);
      constant MolarMass MM = 1/sum(stateAir.X[j]/data[j].MM for j in 1:size(stateAir.X, 1));
      constant MolarMass MMX[:] = data[:].MM;
      constant Real X[:] = stateAir.X;
      constant MoleFraction moleFractions_Air[:] = massToMoleFractions(X, MMX);
    annotation (Documentation(info="<html>

</html>"));
  end EngineCombustionAir;

  package CHPCoolantPropyleneGlycolWater
    "Package with model for propylene glycol - water with constant properties"
    extends Modelica.Media.Interfaces.PartialSimpleMedium(
      mediumName="PropyleneGlycolWater(X_a = "
        + String(X_a) + ", property_T = "
        + String(property_T) + ")",
      final cp_const=specificHeatCapacityCp_TX_a(T = property_T, X_a = X_a),
      final cv_const=cp_const,
      final d_const=density_TX_a(T = property_T, X_a = X_a),
      final eta_const=dynamicViscosity_TX_a(T = property_T, X_a = X_a),
      final lambda_const=thermalConductivity_TX_a(T = property_T, X_a = X_a),
      a_const=1484,
      final T_min=fusionTemperature_TX_a(T = property_T, X_a = X_a),
      T_max=Modelica.SIunits.Conversions.from_degC(100),
      T0=273.15,
      MM_const=(X_a/simplePropyleneGlycolWaterConstants[1].molarMass + (1
           - X_a)/0.018015268)^(-1),
      fluidConstants=simplePropyleneGlycolWaterConstants,
      p_default=300000,
      reference_p=300000,
      reference_T=273.15,
      reference_X={1},
      AbsolutePressure(start=p_default),
      Temperature(start=T_default),
      Density(start=d_const));

    constant Modelica.SIunits.Temperature property_T
      "Temperature for evaluation of constant fluid properties";
    constant Modelica.SIunits.MassFraction X_a
      "Mass fraction of propylene glycol in water";

    redeclare model BaseProperties "Base properties"
      Temperature T(stateSelect=
        if preferredMediumStates then StateSelect.prefer else StateSelect.default)
        "Temperature of medium";

      InputAbsolutePressure p "Absolute pressure of medium";
      InputMassFraction[nXi] Xi=fill(0, 0)
        "Structurally independent mass fractions";
      InputSpecificEnthalpy h "Specific enthalpy of medium";
      Modelica.SIunits.SpecificInternalEnergy u
        "Specific internal energy of medium";
      Modelica.SIunits.Density d=d_const "Density of medium";
      Modelica.SIunits.MassFraction[nX] X={1}
        "Mass fractions (= (component mass)/total mass  m_i/m)";
      final Modelica.SIunits.SpecificHeatCapacity R=0
        "Gas constant (of mixture if applicable)";
      final Modelica.SIunits.MolarMass MM=MM_const
        "Molar mass (of mixture or single fluid)";
      ThermodynamicState state
        "Thermodynamic state record for optional functions";
      parameter Boolean preferredMediumStates=false
        "= true if StateSelect.prefer shall be used for the independent property variables of the medium"
        annotation(Evaluate=true, Dialog(tab="Advanced"));
      final parameter Boolean standardOrderComponents=true
        "If true, and reducedX = true, the last element of X will be computed from the other ones";
      Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T_degC=
          Modelica.SIunits.Conversions.to_degC(T)
        "Temperature of medium in [degC]";
      Modelica.SIunits.Conversions.NonSIunits.Pressure_bar p_bar=
          Modelica.SIunits.Conversions.to_bar(p)
        "Absolute pressure of medium in [bar]";

      // Local connector definition, used for equation balancing check
      connector InputAbsolutePressure = input Modelica.SIunits.AbsolutePressure
        "Pressure as input signal connector";
      connector InputSpecificEnthalpy = input Modelica.SIunits.SpecificEnthalpy
        "Specific enthalpy as input signal connector";
      connector InputMassFraction = input Modelica.SIunits.MassFraction
        "Mass fraction as input signal connector";

    equation
      assert(T >= T_min and T <= T_max, "
Temperature T (= "   + String(T) + " K) is not
in the allowed range ("   + String(T_min) + " K <= T <= " + String(T_max) + " K)
required from medium model \""   + mediumName + "\".
");   assert(X_a >= X_a_min and X_a <= X_a_max, "
    Mass fraction X_a (= "   + String(X_a) + " ) is not
in the allowed range ("   + String(X_a_min) + " <= X_a <= " + String(X_a_max) + " )
required from medium model \""   + mediumName + "\".
");

      h = cp_const*(T-reference_T);
      u = h;
      state.T = T;
      state.p = p;

      annotation(Documentation(info="<html>
    <p>
    This base properties model is identical to
    <a href=\"modelica://Modelica.Media.Water.ConstantPropertyLiquidWater\">
    Modelica.Media.Water.ConstantPropertyLiquidWater</a>,
    except that the equation
    <code>u = cv_const*(T - reference_T)</code>
    has been replaced by <code>u=h</code> because
    <code>cp_const=cv_const</code>.
    Also, the model checks if the mass fraction of the mixture is within the
    allowed limits.
    </p>
</html>"));
    end BaseProperties;
  protected
    constant Modelica.SIunits.MassFraction X_a_min=0.
      "Minimum allowed mass fraction of propylene glycol in water";
    constant Modelica.SIunits.MassFraction X_a_max=0.6
      "Maximum allowed mass fraction of propylene glycol in water";

    // Fluid constants based on pure Propylene Glycol
    constant Modelica.Media.Interfaces.Types.Basic.FluidConstants[1]
      simplePropyleneGlycolWaterConstants(
      each chemicalFormula="C3H8O2",
      each structureFormula="CH3CH(OH)CH2OH",
      each casRegistryNumber="57-55-6",
      each iupacName="1,2-Propylene glycol",
      each molarMass=0.07609);

    // Coefficients for evaluation of physical properties
    constant AixLib.Media.Antifreeze.BaseClasses.PropertyCoefficients
      proCoe(
      X_a_ref=0.307031,
      T_ref=Modelica.SIunits.Conversions.from_degC(32.7083),
      nX_a=6,
      nT={4,4,4,3,2,1},
      nTot=18,
      a_d={1.018e3,-5.406e-1,-2.666e-3,1.347e-5,7.604e-1,-9.450e-3,5.541e-5,-1.343e-7,
          -2.498e-3,2.700e-5,-4.018e-7,3.376e-9,-1.550e-4,2.829e-6,-7.175e-9,-1.131e-6,
          -2.221e-8,2.342e-8},
      a_eta={6.837e-1,-3.045e-2,2.525e-4,-1.399e-6,3.328e-2,-3.984e-4,4.332e-6,-1.860e-8,
          5.453e-5,-8.600e-8,-1.593e-8,-4.465e-11,-3.900e-6,1.054e-7,-1.589e-9,-1.587e-8,
          4.475e-10,3.564e-9},
      a_Tf={-1.325e1,-3.820e-5,7.865e-7,-1.733e-9,-6.631e-1,6.774e-6,-6.242e-8,-7.819e-10,
          -1.094e-2,5.332e-8,-4.169e-9,3.288e-11,-2.283e-4,-1.131e-8,1.918e-10,-3.409e-6,
          8.035e-11,1.465e-8},
      a_cp={3.882e3,2.699e0,-1.659e-3,-1.032e-5,-1.304e1,5.070e-2,-4.752e-5,
          1.522e-6,-1.598e-1,9.534e-5,1.167e-5,-4.870e-8,3.539e-4,3.102e-5,-2.950e-7,
          5.000e-5,-7.135e-7,-4.959e-7},
      a_lambda={4.513e-1,7.955e-4,3.482e-8,-5.966e-9,-4.795e-3,-1.678e-5,8.941e-8,
          1.493e-10,2.076e-5,1.563e-7,-4.615e-9,9.897e-12,-9.083e-8,-2.518e-9,
          6.543e-11,-5.952e-10,-3.605e-11,2.104e-11})
      "Coefficients for evaluation of thermo-physical properties";

    replaceable function density_TX_a
      "Evaluate density of antifreeze-water mixture"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Temperature T "Temperature of antifreeze-water mixture";
      input Modelica.SIunits.MassFraction X_a "Mass fraction of antifreeze";
      output Modelica.SIunits.Density d "Density of antifreeze-water mixture";
    algorithm
      d :=polynomialProperty(
          X_a,
          T,
          proCoe.a_d)
      annotation (
      Documentation(info="<html>
  <p>
  Density of propylene antifreeze-water mixture at specified mass fraction
  and temperature, based on Melinder (2010).
  </p>
  <h4>References</h4>
  <p>
  Melinder, &#197;ke. 2010. Properties of Secondary Working Fluids (Secondary
  Refrigerants or Coolants, Heat Transfer Fluids) for Indirect Systems. Paris:
  IIR/IIF.
  </p>
  </html>",
    revisions="<html>
  <ul>
  <li>
  May 2, 2018 by Massimo Cimmino:<br/>
  First implementation.
  This function is used by
  <a href=\"modelica://AixLib.Media.Antifreeze.PropyleneGlycolWater\">
  AixLib.Media.Antifreeze.PropyleneGlycolWater</a>.
  </li>
  </ul>
  </html>"));

    end density_TX_a;

    replaceable function dynamicViscosity_TX_a
      "Evaluate dynamic viscosity of antifreeze-water mixture"
        extends Modelica.Icons.Function;
      input Modelica.SIunits.Temperature T "Temperature of antifreeze-water mixture";
      input Modelica.SIunits.MassFraction X_a "Mass fraction of antifreeze";
      output Modelica.SIunits.DynamicViscosity eta "Dynamic Viscosity of antifreeze-water mixture";
    algorithm
      eta :=1e-3*exp(polynomialProperty(
          X_a,
          T,
          proCoe.a_eta));

    annotation (
    Documentation(info="<html>
<p>
Dynamic viscosity of antifreeze-water mixture at specified mass fraction and
temperature, based on Melinder (2010).
</p>
<h4>References</h4>
<p>
Melinder, &#197;ke. 2010. Properties of Secondary Working Fluids (Secondary
Refrigerants or Coolants, Heat Transfer Fluids) for Indirect Systems. Paris:
IIR/IIF.
</p>
</html>",     revisions="<html>
<ul>
<li>
May 2, 2018 by Massimo Cimmino:<br/>
First implementation.
This function is used by
<a href=\"modelica://AixLib.Media.Antifreeze.PropyleneGlycolWater\">
AixLib.Media.Antifreeze.PropyleneGlycolWater</a>.
</li>
</ul>
</html>"));
    end dynamicViscosity_TX_a;

    replaceable function fusionTemperature_TX_a
      "Evaluate temperature of fusion of antifreeze-water mixture"
        extends Modelica.Icons.Function;
      input Modelica.SIunits.Temperature T "Temperature of antifreeze-water mixture";
      input Modelica.SIunits.MassFraction X_a "Mass fraction of antifreeze";
      output Modelica.SIunits.Temperature Tf "Temperature of fusion of antifreeze-water mixture";
    algorithm
      Tf :=Modelica.SIunits.Conversions.from_degC(polynomialProperty(
          X_a,
          T,
          proCoe.a_Tf));

    annotation (
    Documentation(info="<html>
<p>
Fusion temperature of antifreeze-water mixture at specified mass fraction and
temperature, based on Melinder (2010).
</p>
<h4>References</h4>
<p>
Melinder, &#197;ke. 2010. Properties of Secondary Working Fluids (Secondary
Refrigerants or Coolants, Heat Transfer Fluids) for Indirect Systems. Paris:
IIR/IIF.
</p>
</html>",     revisions="<html>
<ul>
<li>
May 2, 2018 by Massimo Cimmino:<br/>
First implementation.
This function is used by
<a href=\"modelica://AixLib.Media.Antifreeze.PropyleneGlycolWater\">
AixLib.Media.Antifreeze.PropyleneGlycolWater</a>.
</li>
</ul>
</html>"));
    end fusionTemperature_TX_a;

    replaceable function polynomialProperty
      "Evaluates thermophysical property from 2-variable polynomial"
      extends Modelica.Icons.Function;

      input Real x "First independent variable";
      input Real y "Second independent variable";
      input Real a[sum(proCoe.nT)] "Polynomial coefficients";

      output Real f "Value of thermophysical property";

    protected
      Real dx;
      Real dy;
      Integer n;
    algorithm
      dx := 100*(x - proCoe.X_a_ref);
      dy := y - proCoe.T_ref;

      f := 0;
      n := 0;
      for i in 0:proCoe.nX_a - 1 loop
        for j in 0:proCoe.nT[i+1] - 1 loop
          n := n + 1;
          f := f + a[n]*dx^i*dy^j;
        end for;
      end for;
    annotation (
    Documentation(info="<html>
<p>
Evaluates a thermophysical property of a mixture, based on correlations proposed
by Melinder (2010).
</p>
<p>
The polynomial has the form
</p>
<p align=\"center\" style=\"font-style:italic;\">
f = a<sub>1</sub> (x-xm)<sup>0</sup>(y-ym)<sup>0</sup>
+ a<sub>2</sub> (x-xm)<sup>0</sup>(y-ym)<sup>1</sup>
+ ... +
a<sub>ny[1]</sub> (x-xm)<sup>0</sup>(y-ym)<sup>ny[1]-1</sup>
+ ... +
a<sub>ny[1])+1</sub> (x-xm)<sup>1</sup>(y-ym)<sup>0</sup>
+ ... +
a<sub>ny[1]+ny[2]</sub> (x-xm)<sup>1</sup>(y-ym)<sup>ny[2]-1</sup>
+ ...
</p>
<h4>References</h4>
<p>
Melinder, &#197;ke. 2010. Properties of Secondary Working Fluids (Secondary
Refrigerants or Coolants, Heat Transfer Fluids) for Indirect Systems. Paris:
IIR/IIF.
</p>
</html>",     revisions="<html>
<ul>
<li>
March 16, 2018 by Massimo Cimmino:<br/>
First implementation.
This function is used models in
<a href=\"modelica://AixLib.Media.Antifreeze\">
AixLib.Media.Antifreeze</a>.
</li>
</ul>
</html>"));
    end polynomialProperty;

    replaceable function specificHeatCapacityCp_TX_a
      "Evaluate specific heat capacity of antifreeze-water mixture"
        extends Modelica.Icons.Function;
      input Modelica.SIunits.Temperature T "Temperature of antifreeze-water mixture";
      input Modelica.SIunits.MassFraction X_a "Mass fraction of antifreeze";
      output Modelica.SIunits.SpecificHeatCapacity cp "Specific heat capacity of antifreeze-water mixture";
    algorithm
      cp :=polynomialProperty(
          X_a,
          T,
          proCoe.a_cp);

    annotation (
    Documentation(info="<html>
<p>
Specific heat capacity of antifreeze-water mixture at specified mass fraction
and temperature, based on Melinder (2010).
</p>
<h4>References</h4>
<p>
Melinder, &#197;ke. 2010. Properties of Secondary Working Fluids (Secondary
Refrigerants or Coolants, Heat Transfer Fluids) for Indirect Systems. Paris:
IIR/IIF.
</p>
</html>",     revisions="<html>
<ul>
<li>
March 16, 2018 by Massimo Cimmino:<br/>
First implementation.
This function is used by
<a href=\"modelica://AixLib.Media.Antifreeze.PropyleneGlycolWater\">
AixLib.Media.Antifreeze.PropyleneGlycolWater</a>.
</li>
</ul>
</html>"));
    end specificHeatCapacityCp_TX_a;

    replaceable function thermalConductivity_TX_a
      "Evaluate thermal conductivity of antifreeze-water mixture"
        extends Modelica.Icons.Function;
      input Modelica.SIunits.Temperature T "Temperature of antifreeze-water mixture";
      input Modelica.SIunits.MassFraction X_a "Mass fraction of antifreeze";
      output Modelica.SIunits.ThermalConductivity lambda "Thermal conductivity of antifreeze-water mixture";
    algorithm
      lambda :=polynomialProperty(
          X_a,
          T,
          proCoe.a_lambda);

    annotation (
    Documentation(info="<html>
<p>
Thermal conductivity of antifreeze-water mixture at specified mass fraction and
temperature, based on Melinder (2010).
</p>
<h4>References</h4>
<p>
Melinder, &#197;ke. 2010. Properties of Secondary Working Fluids (Secondary
Refrigerants or Coolants, Heat Transfer Fluids) for Indirect Systems. Paris:
IIR/IIF.
</p>
</html>",     revisions="<html>
<ul>
<li>
March 16, 2018 by Massimo Cimmino:<br/>
First implementation.
This function is used by
<a href=\"modelica://AixLib.Media.Antifreeze.PropyleneGlycolWater\">
AixLib.Media.Antifreeze.PropyleneGlycolWater</a>.
</li>
</ul>
</html>"));
    end thermalConductivity_TX_a;
  annotation(preferredView="info", Documentation(info="<html>
<p>
This medium package models propylene glycol - water mixtures.
</p>
<p>
The mass density, specific heat capacity, thermal conductivity and viscosity
are assumed constant and evaluated at a set temperature and mass fraction of
propylene glycol within the mixture. The dependence of the four properties
are shown on the figure below.
</p>
<p align=\"center\">
<img src=\"modelica://AixLib/Resources/Images/Media/Antifreeze/PropyleneGlycolWaterProperties.png\" border=\"1\"
alt=\"Relative variation of specific heat capacity with temperature\"/>
</p>
<p>
The accuracy of the thermophysical properties is dependent on the temperature
variations encountered during simulations.
The figure below shows the relative error of the the four properties over a
<i>10</i> &deg;C range around the temperature used to evaluate the constant
properties. The maximum errors are <i>0.8</i> % for mass density, <i>1.5</i> %
for specific heat capacity, <i>3.2</i> % for thermal conductivity and <i>250</i>
% for dynamic viscosity.
</p>
<p align=\"center\">
<img src=\"modelica://AixLib/Resources/Images/Media/Antifreeze/PropyleneGlycolWaterError10degC.png\" border=\"1\"
alt=\"Relative variation of specific heat capacity with temperature\"/>
</p>
<p>
The figure below shows the relative error of the the four properties over a
<i>20</i> &deg;C range around the temperature used to evaluate the constant
proepties. The maximum errors are <i>1.6</i> % for mass density, <i>3.0</i> %
for specific heat capacity, <i>6.2</i> % for thermal conductivity and <i>950</i>
% for dynamic viscosity.
</p>
<p align=\"center\">
<img src=\"modelica://AixLib/Resources/Images/Media/Antifreeze/PropyleneGlycolWaterError20degC.png\" border=\"1\"
alt=\"Relative variation of specific heat capacity with temperature\"/>
</p>
<p>
The enthalpy is computed using the convention that <i>h=0</i>
if <i>T=0</i> &deg;C.
</p>
<h4>Limitations</h4>
<p>
Density, specific heat capacity, thermal conductivity and viscosity are constant.
The propylene glycol/water mixture is modeled as an incompressible liquid.
There are no phase changes. The medium is limited to temperatures below
<i>100</i> &deg;C and mass fractions below <i>0.60</i>.
As is the case for AixLib.Media.Water, this medium package should not be used if
the simulation relies on the dynamic viscosity.
</p>
<h4>Typical use and important parameters</h4>
<p>
The temperature and mass fraction must be specified for the evaluation of the
constant thermophysical properties. A typical use of the package is (e.g. for
a temperature of <i>20</i> &deg;C and a mass fraction of <i>0.40</i>):
</p>
<p>
<code>Medium = AixLib.Media.Antifreeze.PropyleneGlycolWater(property_T=293.15, X_a=0.40)</code>
</p>
</html>",   revisions="<html>
<ul>
<li>
March 16, 2018, by Massimo Cimmino:<br/>
First implementation.
</li>
</ul>
</html>"));
  end CHPCoolantPropyleneGlycolWater;

  record CombustionEngineFuelDataBaseRecord

      extends Modelica.Icons.Record;

      //Base-Record for physical combustion calculations of natural gas out of (Nitrogen,Methane,Ethene,Ethane,Propane,n-Butane,n-Pentane,n-Hexane,Carbondioxide)
      parameter String naturalGasType "Name of the natural gas composition";
      parameter String substanceNames[:] = {"Nitrogen","Methane","Ethene","Ethane","Propane","n-Butane","n-Pentane","n-Hexane","Carbondioxide"};
      parameter Modelica.SIunits.MoleFraction Xi_mole[:] "Volumetric proportion of each fuel component";
      parameter Modelica.SIunits.MolarMass MMi[:] = {0.02802,0.01604,0.02805,0.03007,0.0441,0.05815,0.07215,0.08618,0.04401} "Molar mass of natural gas components";
      parameter Modelica.SIunits.SpecificEnergy H_Ui[:] = {0,50000000,50900000,47160000,46440000,45720000,45000000,44640000,0};
      //constant Modelica.SIunits.MolarMass MM = sum(Xi_mole[i]/MMi[i] for i in 1:size(MMi, 1));
      parameter Real nue_C[size(MMi, 1)] = {0, 1, 2, 2, 3, 4, 5, 6, 1} "Number of carbon atoms for each gas component (for composition calculation)";
      parameter Real nue_H[size(MMi, 1)] = {0, 4, 4, 6, 8, 10, 12, 14, 0} "Number of hydrogen atoms for each gas component (for composition calculation)";
      parameter Real nue_O[size(MMi, 1)] = {0, 0, 0, 0, 0, 0, 0, 0, 2} "Number of oxygen atoms for each gas component (for composition calculation)";
      parameter Real nue_N[size(MMi, 1)] = {2, 0, 0, 0, 0, 0, 0, 0, 0} "Number of nitrogen atoms for each gas component (for composition calculation)";
      parameter Real nue_min[:] = {0, 2, 3, 3.5, 5, 6.5, 8, 9.5, 0} "Number of O2 molecules needed for combustion";

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end CombustionEngineFuelDataBaseRecord;
end ModularCHPEngineMedia;
