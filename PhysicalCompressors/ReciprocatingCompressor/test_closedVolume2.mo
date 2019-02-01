within PhysicalCompressors.ReciprocatingCompressor;
model test_closedVolume2
  extends PhysicalCompressors.ReciprocatingCompressor.Geometry.Geometry_Roskoch;

  parameter Modelica.SIunits.Mass m = 0.009;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha = 10;
  parameter Modelica.SIunits.Temperature T_ref = 298;
  parameter Modelica.SIunits.Area A = 0.1;
  //parameter Modelica.SIunits.SpecificEnthalpy h = 520e3;
  Modelica.SIunits.Volume V_gas;
  Modelica.SIunits.Density d_gas;
  Medium.ThermodynamicState state_dh;
  Modelica.SIunits.SpecificEnthalpy h_delta;
  Integer n;
  Modelica.SIunits.Work W_rev(start=0) "reversible work";
  Modelica.SIunits.Work W_irr(start=0) "irreversible work";
  Modelica.SIunits.Pressure p_gas(start=3e5) "Pressure inside the chamber";
  Modelica.SIunits.SpecificInternalEnergy u_gas(start = 550e3);
  Modelica.SIunits.SpecificEnthalpy h_gas(start = 500e3);
  Modelica.SIunits.HeatFlowRate Q_out;

  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
equation
  Q_out = A*alpha*(T_ref-state_dh.T);
  //port_a.T = state_dh.T;
  V_gas = u;
  h_gas = u_gas - p_gas / d_gas;
  der(W_rev) = -p_gas*der(V_gas);
  der(W_irr) = -p_rub*der(V_gas);
  d_gas = m/V_gas;
  p_gas = state_dh.p;
  (state_dh, h_delta, n) = setState_dh(d=d_gas,h=h_gas);
  //Energy balance
  m * der(u_gas) - der(W_rev) - abs(der(W_irr)) - Q_out  = 0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end test_closedVolume2;
