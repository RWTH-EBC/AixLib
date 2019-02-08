within PhysicalCompressors.ReciprocatingCompressor;
package Utilities
  record DataBaseDefinition
    "Base data definition for geometrical quantities of reciprocating compressor"

    constant String name
    "Short description of the record";
    constant Modelica.SIunits.Diameter D_pis
    "Diameter of piston";
    constant Modelica.SIunits.Length H "Hub";
    constant Modelica.SIunits.Area A_env "Area of piston to enviroment";
    constant Real alpha_env "Heat flow coefficient, pistion-->ambient [W/m2K]";
    constant Real pistonRod_ratio "Ratio of rod and crankshaft";
    constant Modelica.SIunits.Area Aeff_in "Effective area valve in";
    constant Modelica.SIunits.Area Aeff_out "Effective area valve out";
    constant Real c_dead "Relative dead Volume of the piston";
    constant Modelica.SIunits.Pressure p_rub "Rubbing pressure";
    constant Modelica.SIunits.ThermalConductance G_wall_env "Thermal conductance between wall and ambient";

     annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end DataBaseDefinition;

  record Geometry_Roskoch
    "\"Geometrical quantities taken form Roskoch\""
    extends
      PhysicalCompressors.ReciprocatingCompressor.Utilities.DataBaseDefinition(
    name = "Geometry taken from Roskoch",
    D_pis = 34e-3,
    H = 34e-3,
    A_env = 0.04,
    alpha_env = 6,
    pistonRod_ratio = 3.5,
    Aeff_in = 1.27e-5,
    Aeff_out = 1.61e-5,
    c_dead = 0.0607,
    p_rub = 48.92e3,
    G_wall_env = A_env * 6);

  end Geometry_Roskoch;

  package Geometry

    model Volumes "Model that calculates the piston hub volume"
      extends
        PhysicalCompressors.ReciprocatingCompressor.Utilities.Geometry_Roskoch;
      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Real small = Modelica.Constants.small;
      Modelica.SIunits.Volume V_gas;
      Modelica.SIunits.Volume V_hub = Modelica.Constants.pi*(0.5*D_pis)^2*H;
      Modelica.SIunits.Volume V_dead = c_dead*V_hub;
      Real pi = Modelica.Constants.pi;
      Modelica.Blocks.Interfaces.RealOutput V1
        annotation (Placement(transformation(extent={{100,30},{120,50}})));

      Modelica.SIunits.Length x;
      Modelica.SIunits.Length x_int(start=0.001);
      Modelica.SIunits.Angle phi;
      Modelica.SIunits.Area A "Heat transfer area of gas to cylinder";

      Modelica.Blocks.Interfaces.RealOutput v_x_avg "average velocity of piston"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      Modelica.Blocks.Interfaces.RealOutput A_gas_cyl
        annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
    equation
      phi = flange_a.phi +  0.5*Modelica.Constants.pi;
      //Volume inside compressor
      flange_a.tau = 0;
      x = -0.5*H*(1 - cos(phi) + pistonRod_ratio*(1 - sqrt(1 - (1/pistonRod_ratio * sin(phi))^2))) + (1 + c_dead)*H;
      V_gas = pi*(0.5*D_pis)^2*x;
      //V_gas = Modelica.Constants.pi*D_pis*x;
      V1 = V_gas;
      A = pi*D_pis*x + 2*pi*(0.5*D_pis)^2;
      A_gas_cyl = A;

      //Average velocity of piston
      der(x_int) = abs(der(x));
      if time > 0 then
        v_x_avg = x_int / time;
      else
        v_x_avg = 0;
      end if;

       annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Ellipse(
              extent={{-52,52},{58,-54}},
              lineColor={0,0,0},
              fillColor={230,230,230},
              fillPattern=FillPattern.Solid)}),                       Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Volumes;

    model test_Volumes
      Volumes volumes
        annotation (Placement(transformation(extent={{-40,36},{-20,56}})));
      Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=20)
        annotation (Placement(transformation(extent={{-82,38},{-62,58}})));
    equation
      connect(constantSpeed.flange, volumes.flange_a) annotation (Line(points={{-62,
              48},{-50,48},{-50,46},{-40,46}}, color={0,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end test_Volumes;
  end Geometry;

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

  model closedVolume1 "model using constants for fluid dependent values"
    extends
      PhysicalCompressors.ReciprocatingCompressor.Utilities.Geometry_Roskoch;
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
    (state_dh, h_delta, n) =Utilities.setState_dh(d=d_gas, h=h_gas);
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
      //c1 = 6.18;
      modi = 1;
    elseif p_gas > Fluid_out.p then //Discharge
      der(m_gas) = -Aeff_out*sqrt(2*d_gas*abs((Fluid_out.p - p_gas)));
      U_flow_out = der(m_gas) * h_gas;
      U_flow_in = 0;
      der(m_in) = small;
      der(m_out) = der(m_gas);
      //c1 = 2.28;
      modi = 3;
    else //Compression or expansion
      der(m_gas) = small;
      U_flow_in = 0;
      U_flow_out = 0;
      der(m_in) = small;
      der(m_out) = small;
      //c1 = 6.18;
      modi = 2;
    end if;

    c1 = smooth(2, if der(V_gas) > 0 then 6.18 else 2.28);

  //    if der(V_gas) smooth(1,c1=6.18)
  //      c1 = 6.18;
  //    else
  //      c1 = 2.28;
  //    end if;
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
    alpha = 127.93*D_pis^(-0.2)*(p_gas/1e6)^(0.8)*T_gas^(-0.53)*(c1*v_pis_avg)^(0.8);
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
  end closedVolume1;

  model closedVolume2
    "model using correlation for fluid dependent values"
    extends
      PhysicalCompressors.ReciprocatingCompressor.Utilities.Geometry_Roskoch;
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
    constant Real small =  Modelica.Constants.small;
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
    Modelica.SIunits.Area Aeff_in_cor "Effective Area of inlet valve calculated by correlation";
    Modelica.SIunits.Area Aeff_out_cor(max = 5e-5) "Effective Area of outlet valve calculated by correlation";
    Real G_dot_out(min=small) "Mass flow density at valve outlet";

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

    //Effective area of valves
    //G_dot_out = -der(m_out) / Aeff_out;
    Aeff_in_cor = 2.0415e-3 * (Modelica.Constants.R / Medium.refrigerantConstants.molarMass)^(-0.9826);
    Aeff_out_cor = 5.1109e-4 * G_dot_out^(-0.4860);
    G_dot_out = smooth(2, if der(m_out) < 0 then  -der(m_out) / Aeff_out  else   -m_out_avg / Aeff_out);
    //State in piston
    (state_dh, h_delta, n) =Utilities.setState_dh(d=d_gas, h=h_gas);
    h_gas = u_gas - p_gas / d_gas;
    p_gas = state_dh.p;
    T_gas = state_dh.T;
    //Mass balance
    if Fluid_in.p > p_gas then //Suction
      der(m_gas) = Aeff_in_cor*sqrt(2*d_gas*abs((Fluid_in.p - p_gas)));
      U_flow_in = der(m_gas) * h_in;
      U_flow_out = 0;
      der(m_in) = der(m_gas);
      der(m_out) = 0;
      //c1 = 6.18;
      modi = 1;
    elseif p_gas > Fluid_out.p then //Discharge
      der(m_gas) = -Aeff_out_cor*sqrt(2*d_gas*abs((Fluid_out.p - p_gas)));
      U_flow_out = der(m_gas) * h_gas;
      U_flow_in = 0;
      der(m_in) = 0;
      der(m_out) = der(m_gas);
      //c1 = 2.28;
      modi = 3;
    else //Compression or expansion
      der(m_gas) = 0;
      U_flow_in = 0;
      U_flow_out = 0;
      der(m_in) = 0;
      der(m_out) = 0;
      //c1 = 6.18;
      modi = 2;
    end if;

    c1 = smooth(2, if der(V_gas) > 0 then 6.18 else 2.28);

    //Energy balance
    der(m_gas)*u_gas + m_gas*der(u_gas) - der(W_rev) - der(W_irr) - Heat_port.Q_flow - U_flow_in - U_flow_out = 0;
     //m_gas * der(u_gas) - der(W_rev) - der(W_irr) - port_a.Q_flow - u_dot = 0;

    //Average
    if time > 0.01 then
    m_in_avg = m_in / time;
    m_out_avg = m_out / time;
    P = (W_irr+W_rev) / time;
    else
      m_in_avg = 0.01;
      m_out_avg = -0.01;
      P=0;
    end if;

    //Heat transfer Coefficient (Gas to cylinder)
    alpha = 127.93*D_pis^(-0.2)*(p_gas/1e6)^(0.8)*T_gas^(-0.53)*(c1*v_pis_avg)^(0.8);
    alpha_gas_cyl = alpha;

    //Isentropic efficiency
    der(U_in) = U_flow_in;
    der(U_out) = U_flow_out;
    s_out_is = Medium.specificEntropy(state_in);
    h_out_is = Medium.specificEnthalpy_ps(p=Fluid_out.p, s=s_out_is);
  //   if time > 0.1 then
  //     eta_is = (-m_out * (h_out_is - h_in))  / ( -U_out - U_in);
  //   else
  //     eta_is = 0;
  //   end if;
  when modi == 1 then
    eta_is = (-m_out * (h_out_is - h_in))  / ( -U_out - U_in);
    lambda = m_in / ( state_in.d * V_0 * i);
  end when;

    //Volumetric efficiency
    V_0 =  Modelica.Constants.pi * H * ( 1 + c_dead) * (0.5 * D_pis)^2;


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
  end closedVolume2;

  model ThermalConductor_Gas_Cylinder
    "Lumped thermal element transporting heat without storing it"
    extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
    Modelica.SIunits.ThermalConductance G(start = 0.0001) "Thermal conductance of material";

    Modelica.Blocks.Interfaces.RealInput A_cg annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={40,100})));
    Modelica.Blocks.Interfaces.RealInput alpha annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={-40,100})));
  equation
    G = alpha*A_cg;
    Q_flow = G*dT;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
          Rectangle(
            extent={{-90,70},{90,-70}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={192,192,192},
            fillPattern=FillPattern.Backward),
          Line(
            points={{-90,70},{-90,-70}},
            thickness=0.5),
          Line(
            points={{90,70},{90,-70}},
            thickness=0.5),
          Text(
            extent={{-150,115},{150,75}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{-150,-75},{150,-105}},
            lineColor={0,0,0},
            textString="G=%G")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Line(
            points={{-80,0},{80,0}},
            color={255,0,0},
            thickness=0.5,
            arrow={Arrow.None,Arrow.Filled}),
          Text(
            extent={{-100,-20},{100,-40}},
            lineColor={255,0,0},
            textString="Q_flow"),
          Text(
            extent={{-100,40},{100,20}},
            lineColor={0,0,0},
            textString="dT = port_a.T - port_b.T")}),
      Documentation(info="<html>
<p>
This is a model for transport of heat without storing it; see also:
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalResistor\">ThermalResistor</a>.
It may be used for complicated geometries where
the thermal conductance G (= inverse of thermal resistance)
is determined by measurements and is assumed to be constant
over the range of operations. If the component consists mainly of
one type of material and a regular geometry, it may be calculated,
e.g., with one of the following equations:
</p>
<ul>
<li><p>
    Conductance for a <b>box</b> geometry under the assumption
    that heat flows along the box length:</p>
    <pre>
    G = k*A/L
    k: Thermal conductivity (material constant)
    A: Area of box
    L: Length of box
    </pre>
    </li>
<li><p>
    Conductance for a <b>cylindrical</b> geometry under the assumption
    that heat flows from the inside to the outside radius
    of the cylinder:</p>
    <pre>
    G = 2*pi*k*L/log(r_out/r_in)
    pi   : Modelica.Constants.pi
    k    : Thermal conductivity (material constant)
    L    : Length of cylinder
    log  : Modelica.Math.log;
    r_out: Outer radius of cylinder
    r_in : Inner radius of cylinder
    </pre>
    </li>
</ul>
<pre>
    Typical values for k at 20 degC in W/(m.K):
      aluminium   220
      concrete      1
      copper      384
      iron         74
      silver      407
      steel        45 .. 15 (V2A)
      wood         0.1 ... 0.2
</pre>
</html>"));
  end ThermalConductor_Gas_Cylinder;
end Utilities;
