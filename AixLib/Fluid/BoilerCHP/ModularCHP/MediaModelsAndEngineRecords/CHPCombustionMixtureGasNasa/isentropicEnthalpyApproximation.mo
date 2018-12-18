within AixLib.Fluid.BoilerCHP.ModularCHP.MediaModelsAndEngineRecords.CHPCombustionMixtureGasNasa;
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
