within PhysicalCompressors.ReciprocatingCompressor;
model test_closedVolume
  extends PhysicalCompressors.ReciprocatingCompressor.Geometry.Geometry_Roskoch;
  package Medium =AixLib.Media.Refrigerants.R32.R32_IIR_P1_70_T233_373_Horner
    "Internal medium model";
  //parameter Modelica.SIunits.Mass m = 0.009;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha = 10;
  parameter Modelica.SIunits.Area A = 0.1;
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
  parameter Modelica.SIunits.Mass m_gas=0.009;


  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,100})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

equation

  port_a.T = state_dh.T;
  V_gas = u;
  h_gas = u_gas - p_gas / d_gas;
  der(W_rev) = -p_gas*der(V_gas);
  der(W_irr) = abs(-p_rub*der(V_gas));
  d_gas = m_gas/V_gas;
  p_gas = state_dh.p;
  (state_dh, h_delta, n) = setState_dh(d=d_gas,h=h_gas);
  //Energy balance
  m_gas * der(u_gas) - der(W_rev) - der(W_irr) -port_a.Q_flow = 0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end test_closedVolume;
