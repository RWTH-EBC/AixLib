within AixLib.Fluid.HeatPumps.BaseClasses;
model EvaporatorCondenserWithCapacity
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(final m_flow_nominal=mFlow_nominal);

  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);
  parameter Boolean is_con "Type of heat exchanger" annotation (Dialog( descriptionLabel = true),choices(choice=true "Condenser",
      choice=false "Evaporator",
      radioButtons=true));
  parameter Modelica.SIunits.PressureDifference dp_nominal
    "Pressure drop at nominal mass flow rate"
    annotation (Dialog(group="Flow resistance"));
  parameter Real deltaM=0.3
    "Fraction of nominal mass flow rate where transition to turbulent occurs"
    annotation (Dialog(group="Flow resistance"));

  parameter Modelica.SIunits.Volume V "Volume of heat exchanger";
  parameter Modelica.SIunits.Time tau=1
    "Time constant at nominal flow rate (use tau=0 for steady-state sensor, but see user guide for potential problems)"
    annotation (Dialog(group="Temperature sensors"));
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (InitialState and InitialOutput are identical)"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.SIunits.Temperature T_start=Medium.T_default
    "Initial or guess value of output (= state)" annotation (Dialog(tab="Initialization"));
  parameter Boolean transferHeat=true
    "If true, temperature T converges towards TAmb when no flow"
    annotation (Dialog(group="Temperature sensors"),choices(checkBox=true));
  parameter Modelica.SIunits.Temperature TAmb_nominal=273.15
    "Fixed ambient temperature for heat transfer"
    annotation (Dialog(group="Temperature sensors",enable=transferHeat));
  parameter Modelica.SIunits.Time tauHeaTra=1200 "Time constant for heat transfer, default 20 minutes"
    annotation (Dialog(group="Temperature sensors",enable=transferHeat));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_start=Medium.p_default
    "Start value of pressure"
    annotation (Dialog(tab="Initialization"));
  parameter Boolean use_cap=true "False if capacity and heat losses are neglected"
    annotation (Dialog(group="Heat losses"),choices(checkBox=true));
  parameter Modelica.SIunits.HeatCapacity C "Capacity of heat exchanger"
    annotation (Dialog(group="Heat losses", enable=use_cap));
  parameter Modelica.SIunits.ThermalConductance kAOut_nominal
    "Nominal value for thermal conductance to the ambient" annotation (Dialog(group="Heat losses", enable=
          use_cap));
  parameter Modelica.SIunits.ThermalConductance kAIns_nominal
    "Nominal value for thermal conductance on the inside of the heat exchanger"
    annotation (Dialog(group="Heat losses", enable=use_cap));
  parameter Real htcExpIns=0.88 "Exponent heat transfer coefficient for internal convection"
    annotation (Dialog(group="Heat losses", enable=use_cap));

  parameter Modelica.Fluid.Types.Dynamics massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of mass balance: dynamic (3 initialization options) or steady state"
    annotation (Dialog(tab="Dynamics", group="Equation"));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Dialog(tab="Dynamics", group="Equation"));

  parameter Real mSenFac=mSenFac
                           "Factor for scaling the sensible thermal mass of the volume"
    annotation (Dialog(tab="Dynamics"));
  parameter Modelica.SIunits.MassFlowRate mFlow_nominal=1;
  parameter Boolean from_dp=false
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Dialog(tab="Advanced", group="Flow resistance"));
  parameter Boolean homotopyInitialization=false "= true, use homotopy method"
    annotation (Dialog(tab="Advanced", group="Flow resistance"));
  parameter Boolean linearized=false
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation (Dialog(tab="Advanced", group="Flow resistance"));
  parameter Modelica.Media.Interfaces.Types.MassFraction X_start[Medium.nX]=
      Medium.X_default "Start value of mass fractions m_i/m"
    annotation (Dialog(tab="Initialization"));
 AixLib.Fluid.MixingVolumes.MixingVolume vol(
    nPorts=2,
    final use_C_flow=false,
    final m_flow_nominal=m_flow_nominal,
    final p_start=p_start,
    final T_start=T_start,
    final m_flow_small=1E-4*abs(m_flow_nominal),
    final V=V,
    redeclare final package Medium = Medium,
    final C_start=fill(0, Medium.nC),
    final C_nominal=fill(1E-2, Medium.nC),
    final mSenFac=mSenFac,
    final allowFlowReversal=true,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics,
    final X_start=X_start)                   "Volume of heat exchanger"
    annotation (Placement(transformation(extent={{-12,0},{8,-20}})));
  AixLib.Fluid.Sensors.MassFlowRate mFlow_a(redeclare final package Medium = Medium, final
      allowFlowReversal=allowFlowReversal) "Mass flow rate at inlet"
    annotation (Placement(transformation(extent={{-80,10},{-60,-10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senT_b(
    final allowFlowReversal=allowFlowReversal,
    final m_flow_small=1E-4*m_flow_nominal,
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final tau=tau,
    final initType=initType,
    final T_start=T_start,
    final TAmb(displayUnit="K") = TAmb_nominal,
    final tauHeaTra=tauHeaTra,
    final transferHeat=transferHeat) "Temperature at outlet"
    annotation (Placement(transformation(extent={{22,10},{42,-10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senT_a(
    final initType=initType,
    final tauHeaTra=tauHeaTra,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=m_flow_nominal,
    final m_flow_small=1E-4*m_flow_nominal,
    final T_start=T_start,
    final TAmb=TAmb_nominal,
    redeclare final package Medium = Medium,
    final tau=tau,
    final transferHeat=transferHeat) "Temperature at inlet"
    annotation (Placement(transformation(extent={{-50,10},{-30,-10}})));
  AixLib.Fluid.FixedResistances.PressureDrop preDro(
    final allowFlowReversal=allowFlowReversal,
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final show_T=show_T,
    final deltaM=deltaM,
    final dp_nominal=dp_nominal,
    final from_dp=from_dp,
    final homotopyInitialization=homotopyInitialization,
    final linearized=linearized)
                         "Pressure drop"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Thermal.HeatTransfer.Components.Convection conIns if use_cap
    "Convection between fluid and solid" annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={-12,28})));
  Modelica.Thermal.HeatTransfer.Components.Convection conOut if use_cap
    "Convection and conduction between solid and ambient air" annotation (
      Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=270,
        origin={-12,78})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCap(
    final C=C,
    final T(start=T_start),
    final der_T(start=0)) if use_cap
    "Heat Capacity"
    annotation (Placement(transformation(extent={{-12,-12},{12,12}},
        rotation=270,
        origin={12,52})));
  Modelica.Blocks.Sources.RealExpression heatLossIns(final y=kAIns_nominal*htcExpIns) if
                                               use_cap
    "Nominal heat loss coefficient to the inside" annotation (Placement(
        transformation(
        extent={{-15,-10},{15,10}},
        rotation=0,
        origin={-61,28})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_out if use_cap
    "Temperature and heat flow to the ambient"
    annotation (Placement(transformation(extent={{-5,105},{5,95}}),
        iconTransformation(extent={{-5,105},{5,95}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_ref
    "Temperature and heat flow from the refrigerant"
    annotation (Placement(transformation(extent={{-5,-95},{5,-105}}),
        iconTransformation(extent={{-5,-95},{5,-105}})));
  Modelica.Blocks.Sources.RealExpression heatLossOut(final y=kAOut_nominal) if use_cap
    "Nominal heat loss coefficient to the inside" annotation (Placement(
        transformation(
        extent={{-11,-10},{11,10}},
        rotation=0,
        origin={-51,78})));


  Modelica.Blocks.Interfaces.RealOutput m_flow_out "Output value for mass flow rate"
    annotation (Placement(transformation(extent={{-100,-50},{-120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_out "Output value flow temperature"
    annotation (Placement(transformation(extent={{-100,-70},{-120,-50}})));
  Modelica.Blocks.Interfaces.RealOutput T_ret_out "Output value return temperature"
    annotation (Placement(transformation(extent={{-100,-90},{-120,-70}})));
equation
  connect(mFlow_a.port_b, senT_a.port_a)
    annotation (Line(points={{-60,0},{-50,0}}, color={0,127,255}));
  connect(senT_a.port_b, vol.ports[1])
    annotation (Line(points={{-30,0},{-4,0}}, color={0,127,255}));
  connect(vol.heatPort, conIns.solid)
    annotation (Line(points={{-12,-10},{-12,20}}, color={191,0,0},
      pattern=LinePattern.Dash));
  connect(conIns.fluid, heatCap.port)
    annotation (Line(points={{-12,36},{-12,52},{1.77636e-15,52}},
                                                          color={191,0,0},
      pattern=LinePattern.Dash));
  connect(heatCap.port, conOut.solid)
    annotation (Line(points={{1.77636e-15,52},{-12,52},{-12,70}},
                                                          color={191,0,0},
      pattern=LinePattern.Dash));
  connect(conIns.Gc, heatLossIns.y)
    annotation (Line(points={{-20,28},{-44.5,28}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(port_ref, vol.heatPort)
    annotation (Line(points={{0,-100},{0,-56},{-12,-56},{-12,-10}},
                                                    color={191,0,0}));
  connect(conOut.fluid, port_out)
    annotation (Line(points={{-12,86},{-12,100},{0,100}},
                                                  color={191,0,0},
      pattern=LinePattern.Dash));
  connect(conOut.Gc, heatLossOut.y)
    annotation (Line(points={{-20,78},{-38.9,78}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(mFlow_a.m_flow, m_flow_out)
    annotation (Line(points={{-70,-11},{-70,-40},{-110,-40}}, color={0,0,127}));
  connect(senT_a.T, T_flow_out) annotation (Line(points={{-40,-11},{-40,-60},{-110,-60}}, color={0,0,127}));
  connect(senT_b.T, T_ret_out) annotation (Line(points={{32,-11},{32,-80},{-110,
          -80}},                                                                       color={0,0,127}));
  connect(mFlow_a.port_a, port_a) annotation (Line(points={{-80,0},{-100,0}}, color={0,127,255}));
  connect(vol.ports[2], senT_b.port_a)
    annotation (Line(points={{0,0},{22,0}}, color={0,127,255}));
  connect(preDro.port_a, senT_b.port_b)
    annotation (Line(points={{60,0},{42,0}}, color={0,127,255}));
  connect(port_b, preDro.port_b)
    annotation (Line(points={{100,0},{80,0}}, color={0,127,255}));
  annotation (Icon(graphics={ Ellipse(
          extent={{-46,44},{48,-44}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={170,213,255}),
        Rectangle(
          extent={{-18,100},{18,-100}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          origin={0,68},
          rotation=90,
          visible=use_cap),
        Text(
          extent={{-36,52},{36,82}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          fillColor={255,215,136},
          fillPattern=FillPattern.Solid,
          textString="C",
          visible=use_cap),
        Text(
          extent={{-38,-16},{34,14}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          fillColor={255,215,136},
          fillPattern=FillPattern.Solid,
          textString="V"),
        Rectangle(
          extent={{-4,-42},{4,-50}},
          pattern=LinePattern.None,
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-107,5},{-44,-4}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          visible=is_con),
        Rectangle(
          extent={{44,-4},{100,5}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          visible=is_con),
        Line(
          points={{0,-96},{0,-50},{0,-46}},
          color={0,0,0},
          pattern=LinePattern.None),
        Line(
          points={{0,-50},{0,-96},{62,-54},{94,-38},{16,-74}},
          color={0,0,0},
          pattern=LinePattern.None),
        Line(
          points={{-18,-70},{42,-44}},
          color={0,0,0},
          pattern=LinePattern.None),
        Rectangle(
          extent={{0,-98},{0,-48}},
          lineColor={238,46,47},
          pattern=LinePattern.None,
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-102,34},{-96,56},{-140,52},{-100,88},{-84,84},{-106,36}},
          color={238,46,47},
          pattern=LinePattern.None),
        Line(
          points={{-80,88},{-80,110},{-76,104},{-80,110},{-84,104}},
          color={28,108,200},
          visible=use_cap),
        Line(
          points={{-80,34},{-80,56},{-76,50},{-80,56},{-84,50}},
          color={238,46,47},
          visible=use_cap),
        Line(
          points={{-50,34},{-50,56},{-46,50},{-50,56},{-54,50}},
          color={238,46,47},
          visible=use_cap),
        Line(
          points={{-50,88},{-50,110},{-46,104},{-50,110},{-54,104}},
          color={28,108,200},
          visible=use_cap),
        Line(
          points={{80,34},{80,56},{84,50},{80,56},{76,50}},
          color={238,46,47},
          visible=use_cap),
        Line(
          points={{80,88},{80,110},{84,104},{80,110},{76,104}},
          color={28,108,200},
          visible=use_cap),
        Line(
          points={{50,88},{50,110},{54,104},{50,110},{46,104}},
          color={28,108,200},
          visible=use_cap),
        Line(
          points={{50,34},{50,56},{54,50},{50,56},{46,50}},
          color={238,46,47},
          visible=use_cap),
        Line(
          points={{20,34},{20,56},{24,50},{20,56},{16,50}},
          color={238,46,47},
          visible=use_cap),
        Line(
          points={{20,88},{20,110},{24,104},{20,110},{16,104}},
          color={28,108,200},
          visible=use_cap),
        Line(
          points={{-20,88},{-20,110},{-16,104},{-20,110},{-24,104}},
          color={28,108,200},
          visible=use_cap),
        Line(
          points={{-20,34},{-20,56},{-16,50},{-20,56},{-24,50}},
          color={238,46,47},
          visible=use_cap),
        Rectangle(
          extent={{-100,-4},{-44,5}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          visible=not is_con),
        Rectangle(
          extent={{43,5},{106,-4}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          visible=not is_con)}));
end EvaporatorCondenserWithCapacity;
