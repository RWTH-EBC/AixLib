within PhysicalCompressors.ReciprocatingCompressor;
model Compression
  "Model that describes the thermodynamic compression"
  extends ReciprocatingCompressor.Geometry.Geometry_Roskoch;
  package Medium =
      AixLib.Media.Refrigerants.R32.R32_IIR_P1_70_T233_373_Horner
      "Internal medium model";
  Modelica.SIunits.Volume V_gas = V1;
  Modelica.SIunits.Pressure p_gas(start=5e5) "Pressure inside the chamber";
  //constant Modelica.SIunits.Mass m = 0.001;
  Modelica.SIunits.Density d_gas(start = 15);
  Medium.ThermodynamicState state_dh;
  Integer modi(start=1);
  Modelica.SIunits.Mass m_gas(start = 0.001) "mass inside the chamber";
  Modelica.SIunits.SpecificInternalEnergy u_gas;
  Modelica.SIunits.Work W_rev "reversible work";
  Modelica.SIunits.Work W_irr "irreversible work";
  Modelica.SIunits.SpecificEnthalpy  h_gas(start=400) "specific enthalpy of gas";
  //parameter Modelica.SIunits.Density d_gas = 15;

  Modelica.Blocks.Interfaces.RealInput V1
    annotation (Placement(transformation(extent={{-15,-15},{15,15}},
        rotation=270,
        origin={1,99})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-116,-18},{-82,16}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{84,-18},{116,14}})));

equation

  d_gas = m_gas / V_gas;
  state_dh = setState_dh(d=d_gas, h=h_gas);
  h_gas = state_dh.h;
  p_gas = state_dh.p;
  der(W_rev) = -p_gas*der(V_gas);
  der(W_irr) = -p_rub*der(V_gas);
  h_gas = u_gas - p_gas / d_gas;


if Fluid_in.p > p_gas then //suction
  modi = 1;
  //Konti
  der(m_gas) = Fluid_in.m_flow;
  Fluid_out.m_flow = 0;
  //Mass balance
  der(m_gas) = Aeff_in*sqrt(2*d_gas*(Fluid_in.p - p_gas));
  //Energy balance
  der(m_gas) * u_gas + der(u_gas)*m_gas - Fluid_in.m_flow * inStream(Fluid_in.h_outflow) - der(W_rev) - der(W_irr) = 0;

elseif p_gas > Fluid_in.p and p_gas < Fluid_out.p then //compression
  modi = 2;
  //Mass balance
  Fluid_in.m_flow = 0;
  Fluid_out.m_flow = 0;
  der(m_gas) = 0;
  //Energy balance
  m_gas * der(u_gas) - der(W_rev) - der(W_irr) = 0;

elseif p_gas > Fluid_out.p then //discharge
  modi = 3;
  //Konti
  der(m_gas) = -Fluid_out.m_flow;
  Fluid_in.m_flow = 0;
  //Mass balance
  der(m_gas) = Aeff_out*sqrt(2*d_gas*(p_gas - Fluid_out.p));
  //Energy balance
  der(m_gas)*u_gas + der(u_gas)*m_gas + Fluid_out.m_flow * actualStream(Fluid_out.h_outflow) - der(W_rev) - der(W_irr) = 0;

elseif  p_gas > Fluid_in.p and p_gas < Fluid_out.p then //expansion
  modi = 4;
  //Mass balance
  Fluid_in.m_flow = 0;
  Fluid_out.m_flow = 0;
  der(m_gas) = 0;
  //Energy balance
  m_gas * der(u_gas) - der(W_rev) + der(W_irr) = 0;
else
  modi=0;
  //Mass balance
  der(m_gas) = 0;
  Fluid_in.m_flow = 0;
  Fluid_out.m_flow = 0;
  //Energy balance
  m_gas * der(u_gas) - der(W_rev) + der(W_irr) = 0;

end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Compression;
