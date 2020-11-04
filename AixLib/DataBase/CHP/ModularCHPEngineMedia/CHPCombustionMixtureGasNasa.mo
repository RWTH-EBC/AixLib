within AixLib.DataBase.CHP.ModularCHPEngineMedia;
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
             Documentation(info="<html><p>
  Simplification of the kinetic theory (Chapman and Enskog theory)
  approach neglecting the second-order effects.<br/>
  <br/>
  This equation has been extensively tested (Amdur and Mason, 1958;
  Bromley and Wilke, 1951; Cheung, 1958; Dahler, 1959; Gandhi and
  Saxena, 1964; Ranz and Brodowsky, 1962; Saxena and Gambhir, 1963a;
  Strunk, et al., 1964; Vanderslice, et al. 1962; Wright and Gray,
  1962). In most cases, only nonpolar mixtures were compared, and very
  good results obtained. For some systems containing hydrogen as one
  component, less satisfactory agreement was noted. Wilke's method
  predicted mixture viscosities that were larger than experimental for
  the H2-N2 system, but for H2-NH3, it underestimated the
  viscosities.<br/>
  Gururaja, et al. (1967) found that this method also overpredicted in
  the H2-O2 case but was quite accurate for the H2-CO2 system.<br/>
  Wilke's approximation has proved reliable even for polar-polar gas
  mixtures of aliphatic alcohols (Reid and Belenyessy, 1960). The
  principal reservation appears to lie in those cases where
  Mi&gt;&gt;Mj and etai&gt;&gt;etaj.<br/>
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
              Documentation(info="<html><p>
  This function applies the Masson and Saxena modification of the
  Wassiljewa Equation for the thermal conductivity for gas mixtures of
  n elements at low pressure.
</p>
<p>
  For nonpolar gas mixtures errors will generally be less than 3 to 4%.
  For mixtures of nonpolar-polar and polar-polar gases, errors greater
  than 5 to 8% may be expected. For mixtures in which the sizes and
  polarities of the constituent molecules are not greatly different,
  the thermal conductivity can be estimated satisfactorily by a mole
  fraction average of the pure component conductivities.
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

  annotation (Documentation(info="<html><p>
  This model calculates the medium properties for single component
  ideal gases.
</p>
<p>
  <b>Sources for model and literature:</b><br/>
  Original Data: Computer program for calculation of complex chemical
  equilibrium compositions and applications. Part 1: Analysis Document
  ID: 19950013764 N (95N20180) File Series: NASA Technical Reports
  Report Number: NASA-RP-1311 E-8017 NAS 1.61:1311 Authors: Gordon,
  Sanford (NASA Lewis Research Center) Mcbride, Bonnie J. (NASA Lewis
  Research Center) Published: Oct 01, 1994.
</p>
<p>
  <b>Known limits of validity:</b><br/>
  The data is valid for temperatures between 200 K and 6000 K. A few of
  the data sets for monatomic gases have a discontinuous 1st derivative
  at 1000 K, but this never caused problems so far.
</p>
<p>
  This model has been copied from the ThermoFluid library. It has been
  developed by Hubertus Tummescheit.
</p>
</html>"));
end CHPCombustionMixtureGasNasa;
