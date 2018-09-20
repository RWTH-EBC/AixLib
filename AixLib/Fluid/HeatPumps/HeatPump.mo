within AixLib.Fluid.HeatPumps;
model HeatPump "Base model of realistic heat pump"
  extends AixLib.Fluid.Interfaces.PartialFourPortInterface(
    redeclare final package Medium1 = Medium_con,
    redeclare final package Medium2 = Medium_eva,
    final m1_flow_nominal=mFlow_conNominal,
    final m2_flow_nominal=mFlow_evaNominal,
    final allowFlowReversal1=allowFlowReversalCon,
    final allowFlowReversal2=allowFlowReversalEva,
    final m1_flow_small=1E-4*abs(mFlow_conNominal),
    final m2_flow_small=1E-4*abs(mFlow_evaNominal),
    final show_T=show_TPort);

//General
  replaceable package Medium_con = Modelica.Media.Air.MoistAir constrainedby
    Modelica.Media.Interfaces.PartialMedium                                "Medium at sink side"
    annotation (Dialog(tab = "Condenser"),choicesAllMatching=true);
  replaceable package Medium_eva = Modelica.Media.Air.MoistAir constrainedby
    Modelica.Media.Interfaces.PartialMedium                                "Medium at source side"
    annotation (Dialog(tab = "Evaporator"),choicesAllMatching=true);
  parameter Boolean use_revHP=true "True if the HP is reversible" annotation(choices(choice=true "reversible HP",
      choice=false "only heating",
      radioButtons=true), Dialog(descriptionLabel=true));
  replaceable model PerDataHea =
      AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.BaseClasses.PartialPerformanceData
  "Performance data of HP in heating mode"
    annotation (choicesAllMatching=true);
  replaceable model PerDataChi =
      AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.BaseClasses.PartialPerformanceData
  "Performance data of HP in chilling mode"
    annotation (Dialog(enable=use_revHP),choicesAllMatching=true);

  parameter Real scalingFactor=1 "Scaling-factor of HP";
  parameter Boolean use_refIne=true
    "Consider the inertia of the refrigerant cycle"                           annotation(choices(checkBox=true), Dialog(
        group="Refrigerant inertia"));

  constant Modelica.SIunits.Frequency refIneFre_constant
    "Cut off frequency for inertia of refrigerant cycle"
    annotation (Dialog(enable=use_refIne, group="Refrigerant inertia"));
  parameter Integer nthOrder=3 "Order of refrigerant cycle interia" annotation (Dialog(enable=
          use_refIne, group="Refrigerant inertia"));

//Condenser
  parameter Modelica.SIunits.MassFlowRate mFlow_conNominal
    "Nominal mass flow rate"
    annotation (               Dialog(group="Parameters", tab="Condenser"),
      Evaluate=false);
  parameter Modelica.SIunits.Volume VCon "Volume in condenser"
    annotation (Evaluate=false,Dialog(group="Parameters", tab="Condenser"));
  parameter Modelica.SIunits.PressureDifference dpCon_nominal
    "Pressure drop at nominal mass flow rate"
    annotation (Evaluate=false,Dialog(group="Flow resistance", tab="Condenser"));
  parameter Real deltaM_con=0.1
    "Fraction of nominal mass flow rate where transition to turbulent occurs"
    annotation (Dialog(tab="Condenser", group="Flow resistance"));
  parameter Boolean use_ConCap=true
    "If heat losses at capacitor side are considered or not"
    annotation (Dialog(group="Heat Losses", tab="Condenser"),
                                          choices(checkBox=true));
  parameter Modelica.SIunits.HeatCapacity CCon
    "Heat capacity of Condenser (= cp*m)" annotation (Evaluate=false,Dialog(group="Heat Losses",
        tab="Condenser",
      enable=use_ConCap));
  parameter Modelica.SIunits.ThermalConductance GCon
    "Constant thermal conductance of condenser material"
    annotation (Evaluate=false,Dialog(group="Heat Losses", tab="Condenser",
      enable=use_ConCap));
//Evaporator
  parameter Modelica.SIunits.MassFlowRate mFlow_evaNominal
    "Nominal mass flow rate" annotation (Evaluate=false,Dialog(group="Parameters", tab="Evaporator"));

  parameter Modelica.SIunits.Volume VEva "Volume in evaporator"
    annotation (Evaluate=false,Dialog(group="Parameters", tab="Evaporator"));
  parameter Modelica.SIunits.PressureDifference dpEva_nominal
    "Pressure drop at nominal mass flow rate"
    annotation (Evaluate=false,Dialog(group="Flow resistance", tab="Evaporator"));
  parameter Real deltaM_eva=0.1
    "Fraction of nominal mass flow rate where transition to turbulent occurs"
    annotation (Dialog(tab="Evaporator", group="Flow resistance"));
  parameter Boolean use_EvaCap=true
    "If heat losses at capacitor side are considered or not"
    annotation (Dialog(group="Heat Losses", tab="Evaporator"),
                                          choices(checkBox=true));
  parameter Modelica.SIunits.HeatCapacity CEva
    "Heat capacity of Evaporator (= cp*m)"
    annotation (Evaluate=false,Dialog(group="Heat Losses", tab="Evaporator",
      enable=use_EvaCap));
  parameter Modelica.SIunits.ThermalConductance GEva
    "Constant thermal conductance of Evaporator material"
    annotation (Evaluate=false,Dialog(group="Heat Losses", tab="Evaporator",
      enable=use_EvaCap));

//Assumptions
  parameter Boolean allowFlowReversalEva=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Dialog(group="Evaporator", tab="Assumptions"));
  parameter Boolean allowFlowReversalCon=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Evaluate=false,Dialog(group="Condenser", tab="Assumptions"));

  parameter Modelica.SIunits.Time tauSenT=1
    "Time constant at nominal flow rate (use tau=0 for steady-state sensor, but see user guide for potential problems)"
    annotation (Dialog(tab="Assumptions", group="Temperature sensors"));

  parameter Boolean transferHeat=true
    "If true, temperature T converges towards TAmb when no flow"
    annotation (Dialog(tab="Assumptions", group="Temperature sensors"),choices(checkBox=true));
  parameter Modelica.SIunits.Time tauHeaTra=1200
    "Time constant for heat transfer in temperature sensors, default 20 minutes"
    annotation (Evaluate=false,Dialog(tab="Assumptions", group="Temperature sensors"));
  parameter Modelica.SIunits.Temperature TAmbCon_nominal=291.15
    "Fixed ambient temperature for heat transfer of sensors at the condenser side" annotation (               Dialog(tab=
          "Assumptions",                                                                                               group=
          "Condenser"));

  parameter Modelica.SIunits.Temperature TAmbEva_nominal=273.15
    "Fixed ambient temperature for heat transfer of sensors at the evaporator side"
    annotation (               Dialog(tab="Assumptions",group="Evaporator"));

//Initialization
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (InitialState and InitialOutput are identical)"
    annotation (Dialog(tab="Initialization", group="Parameters"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure pCon_start=
      Medium_con.p_default "Start value of pressure"
    annotation (Evaluate=false,Dialog(tab="Initialization", group="Condenser"));
  parameter Modelica.Media.Interfaces.Types.Temperature TCon_start=Medium_con.T_default
    "Start value of temperature"
    annotation (Evaluate=false,Dialog(tab="Initialization", group="Condenser"));
  parameter Modelica.Media.Interfaces.Types.MassFraction XCon_start[Medium_con.nX]=
     Medium_con.X_default "Start value of mass fractions m_i/m"
    annotation (Evaluate=false,Dialog(tab="Initialization", group="Condenser"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure pEva_start=
      Medium_eva.p_default "Start value of pressure"
    annotation (Evaluate=false,Dialog(tab="Initialization", group="Evaporator"));
  parameter Modelica.Media.Interfaces.Types.Temperature TEva_start=Medium_eva.T_default
    "Start value of temperature"
    annotation (Evaluate=false,Dialog(tab="Initialization", group="Evaporator"));
  parameter Modelica.Media.Interfaces.Types.MassFraction XEva_start[Medium_eva.nX]=
     Medium_eva.X_default "Start value of mass fractions m_i/m"
    annotation (Evaluate=false,Dialog(tab="Initialization", group="Evaporator"));
  parameter Real x_start[nthOrder]=zeros(nthOrder)
    "Initial or guess values of states"
    annotation (Dialog(tab="Initialization", group="Refrigerant inertia", enable=use_refIne));
  parameter Real yRefIne_start=0 "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Initialization", group="Refrigerant inertia",enable=initType ==
          Init.InitialOutput and use_refIne));
//Dynamics
  parameter Modelica.Fluid.Types.Dynamics massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of mass balance: dynamic (3 initialization options) or steady state"
    annotation (Dialog(tab="Dynamics", group="Equation"));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Dialog(tab="Dynamics", group="Equation"));
  parameter Real mSenFacCon=1
    "Factor for scaling the sensible thermal mass of the volume in the condenser"
    annotation (Dialog(tab="Dynamics",group="Condenser"));
  parameter Real mSenFacEva=1
    "Factor for scaling the sensible thermal mass of the volume in the evaporator"
    annotation (Dialog(tab="Dynamics", group="Evaporator"));
//Advanced
  parameter Boolean show_TPort=false
    "= true, if actual temperature at port is computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));
  parameter Boolean from_dp=false
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Dialog(tab="Advanced", group="Flow resistance"));
  parameter Boolean homotopyInitialization=false "= true, use homotopy method"
    annotation (Dialog(tab="Advanced", group="Flow resistance"));
  parameter Boolean linearized=false
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation (Dialog(tab="Advanced", group="Flow resistance"));
  AixLib.Fluid.HeatPumps.BaseClasses.EvaporatorCondenserWithCapacity con(
    redeclare final package Medium = Medium_con,
    final allowFlowReversal=allowFlowReversalCon,
    final mFlow_nominal=mFlow_conNominal,
    final m_flow_small=1E-4*abs(mFlow_conNominal),
    final show_T=show_TPort,
    final deltaM=deltaM_con,
    final dp_nominal=dpCon_nominal,
    final tau=tauSenT,
    final initType=initType,
    final T_start=TCon_start,
    final TAmb_nominal=TAmbCon_nominal,
    final tauHeaTra=tauHeaTra,
    final p_start=pCon_start,
    final kAOut_nominal=GCon,
    final kAIns_nominal=3.66,
    final htcExpIns=0.88,
    final use_cap=use_ConCap,
    final X_start=XCon_start,
    final from_dp=from_dp,
    final homotopyInitialization=homotopyInitialization,
    final linearized=linearized,
    final massDynamics=massDynamics,
    final energyDynamics=energyDynamics,
    final mSenFac=mSenFacCon,
    final transferHeat=transferHeat,
    final is_con=true,
    final V=VCon*scalingFactor,
    final C=CCon*scalingFactor) "Heat exchanger model for the condenser"
    annotation (Placement(transformation(extent={{-16,72},{16,104}})));
  AixLib.Fluid.HeatPumps.BaseClasses.EvaporatorCondenserWithCapacity eva(
    redeclare final package Medium = Medium_eva,
    final mFlow_nominal=mFlow_evaNominal,
    final deltaM=deltaM_eva,
    final dp_nominal=dpEva_nominal,
    final TAmb_nominal=TAmbEva_nominal,
    final tauHeaTra=tauHeaTra,
    final use_cap=use_EvaCap,
    final kAOut_nominal=GEva,
    final kAIns_nominal=3.66,
    final htcExpIns=0.88,
    final allowFlowReversal=allowFlowReversalEva,
    final m_flow_small=1E-4*abs(mFlow_evaNominal),
    final show_T=show_TPort,
    final tau=tauSenT,
    final initType=initType,
    final T_start=TEva_start,
    final p_start=pEva_start,
    final X_start=XEva_start,
    final from_dp=from_dp,
    final homotopyInitialization=homotopyInitialization,
    final linearized=linearized,
    final massDynamics=massDynamics,
    final energyDynamics=energyDynamics,
    final transferHeat=transferHeat,
    final mSenFac=mSenFacEva,
    final is_con=false,
    final V=VEva*scalingFactor,
    final C=CEva*scalingFactor) "Heat exchanger model for the evaporator"
    annotation (Placement(transformation(extent={{16,-70},{-16,-102}})));
  Modelica.Blocks.Continuous.CriticalDamping heatFlowIneEva(
    final initType=initType,
    final normalized=true,
    final n=nthOrder,
    final f=refIneFre_constant,
    final x_start=x_start,
    final y_start=yRefIne_start) if
                                   use_refIne
    "This n-th order block represents the inertia of the refrigerant cycle and delays the heat flow"
    annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={30,-30})));
  Modelica.Blocks.Routing.RealPassThrough realPassThroughnSetCon if
                                                                 not use_refIne
    "Use default nSet value" annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={28,32})));
  Modelica.Blocks.Continuous.CriticalDamping heatFlowIneCon(
    final initType=initType,
    final normalized=true,
    final n=nthOrder,
    final f=refIneFre_constant,
    final x_start=x_start,
    final y_start=yRefIne_start) if
                                   use_refIne
    "This n-th order block represents the inertia of the refrigerant cycle and delays the heat flow"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={28,52})));
  Modelica.Blocks.Routing.RealPassThrough realPassThroughnSetEva if
                                                                 not use_refIne
    "Use default nSet value" annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={30,-48})));
  Modelica.Blocks.Interfaces.RealInput iceFac_in
    "Input signal for icing factor" annotation (Placement(transformation(
        extent={{-16,-16},{16,16}},
        rotation=90,
        origin={-76,-136})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTempOutEva if
    use_EvaCap "Foreces heat losses according to ambient temperature"
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={68,-108})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTempOutCon if
    use_ConCap "Foreces heat losses according to ambient temperature"
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={68,108})));

  Modelica.Blocks.Interfaces.RealInput nSet
    "Input signal speed for compressor relative between 0 and 1" annotation (Placement(
        transformation(extent={{-132,4},{-100,36}})));
  AixLib.Controls.Interfaces.HeatPumpControlBus
                           sigBusHP
    annotation (Placement(transformation(extent={{-120,-60},{-90,-26}}),
        iconTransformation(extent={{-108,-52},{-90,-26}})));
  AixLib.Fluid.HeatPumps.BaseClasses.InnerCycle innerCycle(redeclare final
      model                                                                     PerDataHea =
      PerDataHea,
      redeclare final model PerDataChi = PerDataChi,
    final use_revHP=use_revHP,
    final scalingFactor=scalingFactor)                                                   annotation (
      Placement(transformation(
        extent={{-26,-27},{26,27}},
        rotation=90,
        origin={-21,0})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowRateEva(final alpha=0, final T_ref=293.15)
    "Heat flow rate to the evaporator" annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=270,
        origin={49,-59})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowRateCon(final
      T_ref=293.15, final alpha=0)
    "Heat flow rate of the condenser" annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=270,
        origin={48,60})));
  Modelica.Blocks.Interfaces.RealInput T_amb_eva(final unit="K", final
      displayUnit="degC")
    "Ambient temperature on the evaporator side"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={110,-100})));
  Modelica.Blocks.Interfaces.RealInput T_amb_con(final unit="K", final
      displayUnit="degC")
    "Ambient temperature on the condenser side"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={110,100})));

  Modelica.Blocks.Interfaces.BooleanInput modeSet "Set value of HP mode"
    annotation (Placement(transformation(extent={{-132,-36},{-100,-4}})));

equation

  connect(modeSet, sigBusHP.mode) annotation (Line(points={{-116,-20},{-76,-20},
          {-76,-42.915},{-104.925,-42.915}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(innerCycle.Pel, sigBusHP.Pel) annotation (Line(points={{8.835,0.13},{16,
          0.13},{16,30},{-76,30},{-76,-42.915},{-104.925,-42.915}},
                                                  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(port_a1, con.port_a) annotation (Line(points={{-100,60},{-80,60},{-80,
          88},{-16,88}}, color={0,127,255}));
  connect(con.port_b, port_b1) annotation (Line(points={{16,88},{80,88},{80,60},
          {100,60}}, color={0,127,255}));
  connect(heatFlowRateCon.port, con.port_ref)
    annotation (Line(points={{48,68},{48,72},{0,72}}, color={191,0,0}));
  connect(eva.port_a, port_a2) annotation (Line(points={{16,-86},{80,-86},{80,-60},
          {100,-60}}, color={0,127,255}));
  connect(eva.port_b, port_b2) annotation (Line(points={{-16,-86},{-80,-86},{-80,
          -60},{-100,-60}}, color={0,127,255}));
  connect(heatFlowRateEva.port, eva.port_ref)
    annotation (Line(points={{49,-68},{0,-68},{0,-70}}, color={191,0,0}));
  connect(nSet, sigBusHP.N) annotation (Line(points={{-116,20},{-76,20},{-76,-42.915},
          {-104.925,-42.915}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(innerCycle.QEva, realPassThroughnSetEva.u) annotation (Line(
      points={{-21,-28.6},{-21,-48},{22.8,-48}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(innerCycle.QEva, heatFlowIneEva.u) annotation (Line(
      points={{-21,-28.6},{-21,-30},{22.8,-30}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(realPassThroughnSetEva.y, heatFlowRateEva.Q_flow) annotation (Line(
      points={{36.6,-48},{49,-48},{49,-50}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(heatFlowIneEva.y, heatFlowRateEva.Q_flow) annotation (Line(
      points={{36.6,-30},{49,-30},{49,-50}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(innerCycle.QCon, heatFlowIneCon.u) annotation (Line(
      points={{-21,28.6},{-21,52},{20.8,52}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(innerCycle.QCon, realPassThroughnSetCon.u) annotation (Line(
      points={{-21,28.6},{-20,28.6},{-20,32},{20.8,32}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(realPassThroughnSetCon.y, heatFlowRateCon.Q_flow) annotation (Line(
      points={{34.6,32},{48,32},{48,52}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(heatFlowIneCon.y, heatFlowRateCon.Q_flow) annotation (Line(
      points={{34.6,52},{34.6,50},{48,50},{48,52}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sigBusHP, innerCycle.sigBusHP) annotation (Line(
      points={{-105,-43},{-54,-43},{-54,0.26},{-48.81,0.26}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(con.m_flow_out, sigBusHP.m_flow_co) annotation (Line(points={{-17.6,81.6},
          {-76,81.6},{-76,-42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(con.T_ret_out, sigBusHP.T_ret_co) annotation (Line(points={{-17.6,75.2},
          {-76,75.2},{-76,-42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(eva.m_flow_out, sigBusHP.m_flow_ev) annotation (Line(points={{17.6,-79.6},
          {24,-79.6},{24,-110},{-76,-110},{-76,-42.915},{-104.925,-42.915}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(eva.T_ret_out, sigBusHP.T_ret_ev) annotation (Line(points={{17.6,-73.2},
          {24,-73.2},{24,-110},{-76,-110},{-76,-42.915},{-104.925,-42.915}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(eva.T_flow_out, sigBusHP.T_flow_ev) annotation (Line(points={{17.6,-76.4},
          {24,-76.4},{24,-110},{-76,-110},{-76,-42.915},{-104.925,-42.915}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(iceFac_in, sigBusHP.iceFac) annotation (Line(points={{-76,-136},{-76,-42.915},
          {-104.925,-42.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(T_amb_con, varTempOutCon.T) annotation (Line(
      points={{110,100},{84,100},{84,108},{77.6,108}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(varTempOutCon.port, con.port_out) annotation (Line(
      points={{60,108},{0,108},{0,104}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(T_amb_eva, varTempOutEva.T) annotation (Line(
      points={{110,-100},{94,-100},{94,-108},{77.6,-108}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(eva.port_out, varTempOutEva.port) annotation (Line(
      points={{0,-102},{0,-108},{60,-108}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(port_b2, port_b2) annotation (Line(points={{-100,-60},{-100,-60},{-100,
          -60}}, color={0,127,255}));
  connect(con.T_flow_out, sigBusHP.T_flow_co) annotation (Line(points={{-17.6,78.4},
          {-76,78.4},{-76,-42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(extent={{-100,-120},{100,120}}), graphics={
        Rectangle(
          extent={{-16,83},{16,-83}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          origin={1,-64},
          rotation=90),
        Rectangle(
          extent={{-17,83},{17,-83}},
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          origin={1,61},
          rotation=90),
        Text(
          extent={{-76,6},{74,-36}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="%name
"),     Line(
          points={{-9,40},{9,40},{-5,-2},{9,-40},{-9,-40}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={-3,-60},
          rotation=-90),
        Line(
          points={{9,40},{-9,40},{5,-2},{-9,-40},{9,-40}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={-5,56},
          rotation=-90),
        Rectangle(
          extent={{-82,42},{84,-46}},
          lineColor={238,46,47},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-88,60},{88,60}}, color={28,108,200}),
        Line(points={{-88,-60},{88,-60}}, color={28,108,200}),
    Line(
    origin={-75.5,-80.333},
    points={{43.5,8.3333},{37.5,0.3333},{25.5,-1.667},{33.5,-9.667},{17.5,-11.667},{27.5,-21.667},{13.5,-23.667},
              {11.5,-31.667}},
      smooth=Smooth.Bezier,
      visible=use_EvaCap),
        Polygon(
          points={{-70,-122},{-68,-108},{-58,-114},{-70,-122}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,0},
          visible=use_EvaCap),
    Line( origin={40.5,93.667},
          points={{39.5,6.333},{37.5,0.3333},{25.5,-1.667},{33.5,-9.667},{17.5,
              -11.667},{27.5,-21.667},{13.5,-23.667},{11.5,-27.667}},
          smooth=Smooth.Bezier,
          visible=use_ConCap),
        Polygon(
          points={{86,110},{84,96},{74,102},{86,110}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,0},
          visible=use_ConCap),
        Line(
          points={{-42,72},{34,72}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled},
          thickness=0.5),
        Line(
          points={{-38,0},{38,0}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled},
          thickness=0.5,
          origin={0,-74},
          rotation=180)}),                Diagram(coordinateSystem(extent={{-100,
            -120},{100,120}})));
end HeatPump;
