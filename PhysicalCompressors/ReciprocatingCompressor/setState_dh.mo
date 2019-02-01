within PhysicalCompressors.ReciprocatingCompressor;
function setState_dh
  "Return thermodynamic state of refrigerant as function of p and h"
extends Modelica.Icons.Function;
  input Modelica.SIunits.Density d;
  input Modelica.SIunits.SpecificEnthalpy h;
  output Medium.ThermodynamicState state;
  output Modelica.SIunits.SpecificEnthalpy h_del;
  output Integer i;

protected
  Modelica.SIunits.Temperature T_start = 473;
  Modelica.SIunits.Temperature T_int;
  Medium.SpecificHeatCapacity cp;
  Modelica.SIunits.SpecificEnthalpy h_delta = 1000e3;
  Medium.ThermodynamicState state_dT;
  //Integer i = 1;
algorithm
  T_int :=T_start;
  while abs(h_delta) > 1e3 and i<10 loop
    state_dT := Medium.setState_dT(d=d, T=T_int, phase=0);
    h_delta := h - Medium.specificEnthalpy_dT(d=d, T=T_int);
    cp := Medium.specificHeatCapacityCp(state_dT);
    T_int := T_int + h_delta/cp;
    i:=i + 1;
  end while;
  h_del :=h_delta;
  state := Medium.ThermodynamicState(
    d=d,
    p=state_dT.p,
    T=T_int,
    h=h, phase = 0);
end setState_dh;
