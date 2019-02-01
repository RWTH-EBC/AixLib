within PhysicalCompressors.ReciprocatingCompressor;
model test_closedVolume_v6
  extends PhysicalCompressors.ReciprocatingCompressor.Geometry.Geometry_Roskoch;
  //Volumina
  Modelica.SIunits.Volume V_gas(min=0.001);
  Modelica.SIunits.Volume V_0(start = 0);
  //State variables
  Modelica.SIunits.Density d_gas(start=5);
  Modelica.SIunits.Temperature T_gas;
  Modelica.SIunits.Pressure p_gas(start=3e5) "Pressure inside the chamber";
  Modelica.SIunits.SpecificInternalEnergy u_gas(start = 550e3);
  Modelica.SIunits.SpecificEnthalpy h_gas(start = 600e3);
  Medium.ThermodynamicState state_dh;
  Medium.ThermodynamicState state_in;
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
  Modelica.SIunits.EnergyFlowRate U_flow_in(start=0);
  Modelica.SIunits.EnergyFlowRate U_flow_out(start=0);
  Modelica.SIunits.SpecificEnthalpy h_in;
  //Iteration variables
  Modelica.SIunits.SpecificEnthalpy h_delta;
  Integer n;
  //Heat Transfer Coefficients
  Modelica.SIunits.CoefficientOfHeatTransfer alpha(start = 0.0001);
  Real c1;
  Modelica.SIunits.Velocity v_pis_avg "average velocity of piston";
  constant Real small =  0;//Modelica.Constants.small;
  //Isentropic efficiency
  Modelica.SIunits.SpecificEntropy s_out_is "specific isentropic entropy for outgoing fluid";
  Modelica.SIunits.SpecificEnthalpy h_out_is "specific insentropic enthaly for outgoing fluid";
  Modelica.SIunits.Energy U_in;
  Modelica.SIunits.Energy U_out;
  Real eta_is "isentropic efficiency";
  //Power
  Modelica.SIunits.Power P "Power";
  Integer modi;
  Integer i "Counter";
  //volumetric efficiency
  Real lambda "volumetric efficiency";

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
// initial equation
//    m_gas = d_gas * V_gas;
algorithm

  when modi == 1 then
    i:=i + 1;
  end when;

equation
  //Connect ports
  //Fluid ports
  Fluid_in.m_flow = der(m_in);
  Fluid_out.m_flow = der(m_out);
  Fluid_in.h_outflow = h_gas;
  Fluid_out.h_outflow = h_gas;
  h_in = inStream(Fluid_in.h_outflow);
  state_in = Medium.setState_ph(p=Fluid_in.p, h=h_in);
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
    U_flow_in = der(m_gas) * h_in;
    U_flow_out = 0;
    der(m_in) = der(m_gas);
    der(m_out) = small;
    c1 = 6.18;
    modi = 1;
  elseif p_gas > Fluid_out.p then //Discharge
    der(m_gas) = -Aeff_out*sqrt(2*d_gas*abs((Fluid_out.p - p_gas)));
    U_flow_out = der(m_gas) * h_gas;
    U_flow_in = 0;
    der(m_in) = small;
    der(m_out) = der(m_gas);
    c1 = 2.28;
    modi = 3;
  else //Compression or expansion
    der(m_gas) = small;
    U_flow_in = 0;
    U_flow_out = 0;
    der(m_in) = small;
    der(m_out) = small;
    c1 = 6.18;
    modi = 2;
  end if;
  //Energy balance
  der(m_gas)*u_gas + m_gas*der(u_gas) - der(W_rev) - der(W_irr) - Heat_port.Q_flow - U_flow_in - U_flow_out = 0;
   //m_gas * der(u_gas) - der(W_rev) - der(W_irr) - port_a.Q_flow - u_dot = 0;

  //Average
  if time > 0 then
  m_in_avg = m_in / time;
  m_out_avg = m_out / time;
  P = (W_irr+W_rev) / time;
  else
    m_in_avg = 0;
    m_out_avg = 0;
    P=0;
  end if;

  //Heat transfer Coefficient (Gas to cylinder)
  alpha = 127.93*D_pis^(-0.2)*(p_gas/1e6)^(0.8)*T_gas^(-0.53)*(c1*
    v_pis_avg)^(0.8);
  alpha_gas_cyl = alpha;

  //Isentropic efficiency
  der(U_in) = U_flow_in;
  der(U_out) = U_flow_out;
  s_out_is = Medium.specificEntropy(state_in);
  h_out_is = Medium.specificEnthalpy_ps(p=Fluid_out.p, s=s_out_is);
  if time > 0.1 then
    eta_is = (-m_out * (h_out_is - h_in))  / ( -U_out - U_in);
  else
    eta_is = 0;
  end if;

  //Volumetric efficiency
  V_0 =  Modelica.Constants.pi * H * ( 1 + c_dead) * (0.5 * D_pis)^2;
  if i > 0 then
    lambda = m_in / ( state_in.d * V_0 * i);
  else
    lambda = 0;
  end if;


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
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=0.2,
      Interval=3e-05,
      Tolerance=0.001,
      __Dymola_Algorithm="Dassl"));
end test_closedVolume_v6;
