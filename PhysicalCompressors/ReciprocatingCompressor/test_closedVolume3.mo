within PhysicalCompressors.ReciprocatingCompressor;
model test_closedVolume3
  extends PhysicalCompressors.ReciprocatingCompressor.Geometry.Geometry_Roskoch;
  //extends PhysicalCompressors.ReciprocatingCompressor.Medium;
  //parameter Modelica.SIunits.Mass m = 0.009;
  //parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha = 10;
  //parameter Modelica.SIunits.Area A = 0.1;
  parameter Modelica.SIunits.Pressure p_in = 3e5;
  parameter Modelica.SIunits.Temperature T_in = 273.15;
  parameter Modelica.SIunits.Pressure p_out = 20e5;
  //parameter Modelica.SIunits.Temperature T_out = 350;
  Medium.ThermodynamicState state_in;
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
  Modelica.SIunits.Mass m_gas(start=0.009);
  Modelica.SIunits.EnergyFlowRate u_dot;
  Modelica.SIunits.Mass m_in;
  Modelica.SIunits.Mass m_out;
  Modelica.SIunits.MassFlowRate m_in_avg;
  Modelica.SIunits.MassFlowRate m_out_avg;

  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,100})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

equation
  state_in = Medium.setState_pT(p=p_in,T=T_in);
  port_a.T = state_dh.T;
  V_gas = u;
  h_gas = u_gas - p_gas / d_gas;
  //Work, reversible and irreversible
  der(W_rev) = -p_gas*der(V_gas);
  der(W_irr) = abs(-p_rub*der(V_gas));
  d_gas = m_gas/V_gas;
  p_gas = state_dh.p;
  (state_dh, h_delta, n) = setState_dh(d=d_gas,h=h_gas);
  //Mass balance
  if p_in > p_gas then //Suction
    der(m_gas) = Aeff_in*sqrt(2*d_gas*abs((p_in - p_gas)));
    u_dot = der(m_gas) * state_in.h;
    der(m_in) = der(m_gas);
    der(m_out) = 0;
  elseif p_gas > p_out then //Discharge
    der(m_gas) = -Aeff_out*sqrt(2*d_gas*abs((p_out - p_gas)));
    u_dot = der(m_gas) * h_gas;
    der(m_in) = 0;
    der(m_out) = der(m_gas);
  else
    der(m_gas) = 0;
    u_dot = 0;
    der(m_in) = 0;
    der(m_out) = 0;
  end if;
  //Energy balance
  //der(m_gas)*u_gas + m_gas * der(u_gas) - der(W_rev) - der(W_irr) - port_a.Q_flow = 0;
   der(m_gas)*u_gas + m_gas * der(u_gas) - der(W_rev) - der(W_irr) - port_a.Q_flow - u_dot = 0;
   //m_gas * der(u_gas) - der(W_rev) - der(W_irr) - port_a.Q_flow - u_dot = 0;
  if time > 0 then
  m_in_avg = m_in / time;
  m_out_avg = m_out / time;
  else
    m_in_avg = 0;
    m_out_avg = 0;
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
        coordinateSystem(preserveAspectRatio=false)));
end test_closedVolume3;
