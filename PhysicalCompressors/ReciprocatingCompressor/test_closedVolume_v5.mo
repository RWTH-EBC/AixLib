within PhysicalCompressors.ReciprocatingCompressor;
model test_closedVolume_v5
  extends PhysicalCompressors.ReciprocatingCompressor.Geometry.Geometry_Roskoch;
  //State variables
  Modelica.SIunits.Volume V_gas(min=small);
  Modelica.SIunits.Density d_gas(start=5);
  Modelica.SIunits.Temperature T_gas;
  Medium.ThermodynamicState state_dh;
  Modelica.SIunits.Pressure p_gas(start=3e5) "Pressure inside the chamber";
  Modelica.SIunits.SpecificInternalEnergy u_gas(start = 550e3);
  Modelica.SIunits.SpecificEnthalpy h_gas(start = 600e3);
  //Mass
  Modelica.SIunits.Mass m_gas(start=0.0001);
  Modelica.SIunits.Mass m_in(start=small);
  Modelica.SIunits.Mass m_out;
  Modelica.SIunits.MassFlowRate m_in_avg;
  Modelica.SIunits.MassFlowRate m_out_avg;
  //Work
  Modelica.SIunits.Work W_rev(start=0) "reversible work";
  Modelica.SIunits.Work W_irr(start=0) "irreversible work";
  //Streams
  Modelica.SIunits.EnergyFlowRate U_flow;
  Modelica.SIunits.SpecificEnthalpy h_in;

  //Debugging variables
  Modelica.SIunits.SpecificEnthalpy h_delta;
  Integer n;
  //Heat Transfer Coefficients
  Modelica.SIunits.CoefficientOfHeatTransfer alpha(start = 0.0001);
  Real c1;
  Modelica.SIunits.Velocity v_pis_avg "average velocity of piston";
  constant Real small =  Modelica.Constants.small;

  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={20,100})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Heat_port
    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));

  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput v_pis annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-20,100})));
  Modelica.Blocks.Interfaces.RealOutput alpha_gas_cyl
    "Heat tranfer cooefficient between gas and cylinder" annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=-90,
        origin={22,-102})));
initial equation
   m_gas = d_gas * V_gas;

equation
  //Connect ports
  //Fluid ports
  Fluid_in.m_flow = der(m_in);
  Fluid_out.m_flow = der(m_out);
  Fluid_in.h_outflow = h_gas;
  Fluid_out.h_outflow = h_gas;
  h_in = inStream(Fluid_in.h_outflow);
  //Heat port
  Heat_port.T = T_gas;
  //Real inputs
  V_gas = u;
  v_pis_avg = v_pis;

  //Work, reversible and irreversible
  der(W_rev) = -p_gas*der(V_gas);
  der(W_irr) = abs(-p_rub*der(V_gas));
  d_gas = m_gas/V_gas;

  //State in piston
  (state_dh, h_delta, n) = setState_dh(d=d_gas,h=h_gas);
  h_gas = u_gas - p_gas / d_gas;
  p_gas = state_dh.p;
  T_gas = state_dh.T;
  //Mass balance
  if Fluid_in.p > p_gas then //Suction
    der(m_gas) = Aeff_in*sqrt(2*d_gas*abs((Fluid_in.p - p_gas)));
    U_flow = der(m_gas) * h_in;
    der(m_in) = der(m_gas);
    der(m_out) = small;
    c1 = 6.18;
  elseif p_gas > Fluid_out.p then //Discharge
    der(m_gas) = -Aeff_out*sqrt(2*d_gas*abs((Fluid_out.p - p_gas)));
    U_flow = der(m_gas) * h_gas;
    der(m_in) = small;
    der(m_out) = der(m_gas);
    c1 = 2.28;
  else //Compression or expansion
    der(m_gas) = small;
    U_flow = 0;
    der(m_in) = small;
    der(m_out) = small;
    c1 = 2.28;
  end if;
  //Energy balance
  der(m_gas)*u_gas + m_gas*der(u_gas) - der(W_rev) - der(W_irr) - Heat_port.Q_flow - U_flow = 0;
   //m_gas * der(u_gas) - der(W_rev) - der(W_irr) - port_a.Q_flow - u_dot = 0;

  //Average mass flow
  if time > 0 then
  m_in_avg = m_in / time;
  m_out_avg = m_out / time;
  else
    m_in_avg = 0;
    m_out_avg = 0;
  end if;

  //Heat transfer Coefficient (Gas to cylinder)
  alpha = 127.93*D_pis^(-0.2)*(p_gas/1e6)^(0.8)*T_gas^(-0.53)*(c1*
    v_pis_avg)^(0.8);
  alpha_gas_cyl = alpha;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-50,36},{50,-90}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          lineThickness=1,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-52,62},{-48,62},{-48,-30},{-52,-30},{-52,62}},
          lineColor={95,95,95},
          fillColor={135,135,135},
          fillPattern=FillPattern.Backward),
        Polygon(
          points={{48,60},{52,60},{52,-34},{48,-34},{48,60}},
          lineColor={95,95,95},
          fillColor={135,135,135},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-48,40},{48,30}},
          lineColor={95,95,95},
          fillColor={135,135,135},
          fillPattern=FillPattern.Forward),
        Rectangle(
          extent={{-6,92},{6,40}},
          lineColor={95,95,95},
          fillColor={135,135,135},
          fillPattern=FillPattern.Forward),
        Polygon(
          points={{-48,-90},{48,-90},{48,70},{52,70},{52,-94},{-52,-94},{-52,
              70},{-48,70},{-48,-90}},
          lineColor={95,95,95},
          fillColor={135,135,135},
          fillPattern=FillPattern.Backward)}),                   Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end test_closedVolume_v5;
