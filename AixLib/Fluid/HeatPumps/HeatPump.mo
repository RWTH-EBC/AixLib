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

  parameter Modelica.SIunits.Frequency refIneFre_constant
    "Cut off frequency for inertia of refrigerant cycle"
    annotation (Dialog(enable=use_refIne, group="Refrigerant inertia"),Evaluate=true);
  parameter Integer nthOrder=3 "Order of refrigerant cycle interia" annotation (Dialog(enable=
          use_refIne, group="Refrigerant inertia"));

//Condenser
  parameter Modelica.SIunits.MassFlowRate mFlow_conNominal
    "Nominal mass flow rate"
    annotation (Dialog(group="Parameters", tab="Condenser"),Evaluate=true);
  parameter Modelica.SIunits.Volume VCon "Volume in condenser"
    annotation (Evaluate=true,Dialog(group="Parameters", tab="Condenser"));
  parameter Modelica.SIunits.PressureDifference dpCon_nominal
    "Pressure drop at nominal mass flow rate"
    annotation (Dialog(group="Flow resistance", tab="Condenser"), Evaluate=true);
  parameter Real deltaM_con=0.1
    "Fraction of nominal mass flow rate where transition to turbulent occurs"
    annotation (Dialog(tab="Condenser", group="Flow resistance"));
  parameter Boolean use_ConCap=true
    "If heat losses at capacitor side are considered or not"
    annotation (Dialog(group="Heat Losses", tab="Condenser"),
                                          choices(checkBox=true));
  parameter Modelica.SIunits.HeatCapacity CCon
    "Heat capacity of Condenser (= cp*m)" annotation (Evaluate=true,Dialog(group="Heat Losses",
        tab="Condenser",
      enable=use_ConCap));
  parameter Modelica.SIunits.ThermalConductance GCon
    "Constant thermal conductance of condenser material"
    annotation (Evaluate=true,Dialog(group="Heat Losses", tab="Condenser",
      enable=use_ConCap));
  parameter Modelica.SIunits.ThermalConductance GConIns
    "Constant thermal conductance of condenser material"
    annotation (Evaluate=true,Dialog(group="Heat Losses", tab="Condenser",
      enable=use_ConCap));
//Evaporator
  parameter Modelica.SIunits.MassFlowRate mFlow_evaNominal
    "Nominal mass flow rate" annotation (Dialog(group="Parameters", tab="Evaporator"),Evaluate=true);

  parameter Modelica.SIunits.Volume VEva "Volume in evaporator"
    annotation (Evaluate=true,Dialog(group="Parameters", tab="Evaporator"));
  parameter Modelica.SIunits.PressureDifference dpEva_nominal
    "Pressure drop at nominal mass flow rate"
    annotation (Dialog(group="Flow resistance", tab="Evaporator"),Evaluate=true);
  parameter Real deltaM_eva=0.1
    "Fraction of nominal mass flow rate where transition to turbulent occurs"
    annotation (Dialog(tab="Evaporator", group="Flow resistance"));
  parameter Boolean use_EvaCap=true
    "If heat losses at capacitor side are considered or not"
    annotation (Dialog(group="Heat Losses", tab="Evaporator"),
                                          choices(checkBox=true));
  parameter Modelica.SIunits.HeatCapacity CEva
    "Heat capacity of Evaporator (= cp*m)"
    annotation (Evaluate=true,Dialog(group="Heat Losses", tab="Evaporator",
      enable=use_EvaCap));
  parameter Modelica.SIunits.ThermalConductance GEva
    "Constant thermal conductance of Evaporator material"
    annotation (Evaluate=true,Dialog(group="Heat Losses", tab="Evaporator",
      enable=use_EvaCap));
  parameter Modelica.SIunits.ThermalConductance GEvaIns
    "Constant thermal conductance of Evaporator material"
    annotation (Evaluate=true,Dialog(group="Heat Losses", tab="Evaporator",
      enable=use_EvaCap));
//Assumptions
  parameter Boolean allowFlowReversalEva=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Dialog(group="Evaporator", tab="Assumptions"));
  parameter Boolean allowFlowReversalCon=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Dialog(group="Condenser", tab="Assumptions"));

  parameter Modelica.SIunits.Time tauSenT=1
    "Time constant at nominal flow rate (use tau=0 for steady-state sensor, but see user guide for potential problems)"
    annotation (Dialog(tab="Assumptions", group="Temperature sensors"));

  parameter Boolean transferHeat=true
    "If true, temperature T converges towards TAmb when no flow"
    annotation (Dialog(tab="Assumptions", group="Temperature sensors"),choices(checkBox=true));
  parameter Modelica.SIunits.Time tauHeaTra=1200
    "Time constant for heat transfer in temperature sensors, default 20 minutes"
    annotation (Dialog(tab="Assumptions", group="Temperature sensors"),Evaluate=true);
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
    annotation (Evaluate=true,Dialog(tab="Initialization", group="Condenser"));
  parameter Modelica.Media.Interfaces.Types.Temperature TCon_start=Medium_con.T_default
    "Start value of temperature"
    annotation (Evaluate=true,Dialog(tab="Initialization", group="Condenser"));
  parameter Modelica.Media.Interfaces.Types.MassFraction XCon_start[Medium_con.nX]=
     Medium_con.X_default "Start value of mass fractions m_i/m"
    annotation (Evaluate=true,Dialog(tab="Initialization", group="Condenser"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure pEva_start=
      Medium_eva.p_default "Start value of pressure"
    annotation (Evaluate=true,Dialog(tab="Initialization", group="Evaporator"));
  parameter Modelica.Media.Interfaces.Types.Temperature TEva_start=Medium_eva.T_default
    "Start value of temperature"
    annotation (Evaluate=true,Dialog(tab="Initialization", group="Evaporator"));
  parameter Modelica.Media.Interfaces.Types.MassFraction XEva_start[Medium_eva.nX]=
     Medium_eva.X_default "Start value of mass fractions m_i/m"
    annotation (Evaluate=true,Dialog(tab="Initialization", group="Evaporator"));
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
    final m_flow_small=1E-4*abs(mFlow_conNominal),
    final show_T=show_TPort,
    final deltaM=deltaM_con,
    final dp_nominal=dpCon_nominal,
    final tau=tauSenT,
    final T_start=TCon_start,
    final p_start=pCon_start,
    final kAOut_nominal=GCon,
    final use_cap=use_ConCap,
    final X_start=XCon_start,
    final from_dp=from_dp,
    final homotopyInitialization=homotopyInitialization,
    final massDynamics=massDynamics,
    final energyDynamics=energyDynamics,
    final is_con=true,
    final V=VCon*scalingFactor,
    final C=CCon*scalingFactor,
    final m_flow_nominal=mFlow_conNominal,
    final kAInn=GCon + GConIns*abs(mFlow_con.m_flow/mFlow_conNominal)^0.88)
    "Heat exchanger model for the condenser"
    annotation (Placement(transformation(extent={{-16,76},{16,108}})));
  AixLib.Fluid.HeatPumps.BaseClasses.EvaporatorCondenserWithCapacity eva(
    redeclare final package Medium = Medium_eva,
    final deltaM=deltaM_eva,
    final dp_nominal=dpEva_nominal,
    final use_cap=use_EvaCap,
    final kAOut_nominal=GEva,
    final allowFlowReversal=allowFlowReversalEva,
    final m_flow_small=1E-4*abs(mFlow_evaNominal),
    final show_T=show_TPort,
    final tau=tauSenT,
    final T_start=TEva_start,
    final p_start=pEva_start,
    final X_start=XEva_start,
    final from_dp=from_dp,
    final homotopyInitialization=homotopyInitialization,
    final massDynamics=massDynamics,
    final energyDynamics=energyDynamics,
    final is_con=false,
    final V=VEva*scalingFactor,
    final C=CEva*scalingFactor,
    final m_flow_nominal=mFlow_evaNominal,
    kAInn=GEva + GEvaIns*abs(mFlow_eva.m_flow/mFlow_evaNominal)^0.88)
                                "Heat exchanger model for the evaporator"
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
        rotation=90,
        origin={-14,-52})));
  Modelica.Blocks.Routing.RealPassThrough realPassThroughnSetCon if
                                                                 not use_refIne
    "Use default nSet value" annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={16,58})));
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
        rotation=90,
        origin={-16,58})));
  Modelica.Blocks.Routing.RealPassThrough realPassThroughnSetEva if
                                                                 not use_refIne
    "Use default nSet value" annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=90,
        origin={16,-52})));
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
        origin={68,110})));

  Modelica.Blocks.Interfaces.RealInput nSet
    "Input signal speed for compressor relative between 0 and 1" annotation (Placement(
        transformation(extent={{-132,4},{-100,36}})));
  AixLib.Controls.Interfaces.HeatPumpControlBus
                           sigBusHP
    annotation (Placement(transformation(extent={{-120,-60},{-90,-26}}),
        iconTransformation(extent={{-108,-52},{-90,-26}})));
  AixLib.Fluid.HeatPumps.BaseClasses.InnerCycle innerCycle(redeclare final
      model PerDataHea =
      PerDataHea,
      redeclare final model PerDataChi = PerDataChi,
    final use_revHP=use_revHP,
    final scalingFactor=scalingFactor)                                                   annotation (
      Placement(transformation(
        extent={{-27,-26},{27,26}},
        rotation=90,
        origin={0,-1})));
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

  Sensors.TemperatureTwoPort senT_a2(
    redeclare final package Medium = Medium_eva,
    final allowFlowReversal=allowFlowReversalEva,
    final m_flow_nominal=mFlow_evaNominal,
    final m_flow_small=1E-4*mFlow_evaNominal,
    final initType=initType,
    final T_start=TEva_start,
    final transferHeat=transferHeat,
    final TAmb=TAmbEva_nominal,
    final tauHeaTra=tauHeaTra,
    final tau=tauSenT)         "Temperature at sink inlet" annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={38,-86})));
  Sensors.TemperatureTwoPort senT_b2(
    redeclare final package Medium = Medium_eva,
    final allowFlowReversal=allowFlowReversalEva,
    final m_flow_nominal=mFlow_evaNominal,
    final m_flow_small=1E-4*mFlow_evaNominal,
    final initType=initType,
    final T_start=TEva_start,
    final transferHeat=transferHeat,
    final TAmb=TAmbEva_nominal,
    final tauHeaTra=tauHeaTra,
    final tau=tauSenT)         "Temperature at sink outlet" annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-52,-86})));
  Sensors.MassFlowRate mFlow_eva(redeclare final package Medium = Medium_eva,
      final allowFlowReversal=allowFlowReversalEva)
    "Mass flow sensor at the evaporator" annotation (Placement(transformation(
        origin={72,-60},
        extent={{10,-10},{-10,10}},
        rotation=0)));
  Sensors.TemperatureTwoPort senT_b1(
    final initType=initType,
    final transferHeat=transferHeat,
    final TAmb=TAmbEva_nominal,
    final tauHeaTra=tauHeaTra,
    redeclare final package Medium = Medium_con,
    final allowFlowReversal=allowFlowReversalCon,
    final m_flow_nominal=mFlow_conNominal,
    final m_flow_small=1E-4*mFlow_conNominal,
    final T_start=TCon_start,
    final tau=tauSenT)        "Temperature at sink outlet" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={38,92})));
  Sensors.TemperatureTwoPort senT_a1(
    final initType=initType,
    final transferHeat=transferHeat,
    final tauHeaTra=tauHeaTra,
    redeclare final package Medium = Medium_con,
    final allowFlowReversal=allowFlowReversalCon,
    final m_flow_nominal=mFlow_conNominal,
    final m_flow_small=1E-4*mFlow_conNominal,
    final T_start=TCon_start,
    final TAmb=TAmbCon_nominal,
    final tau=tauSenT)          "Temperature at sink inlet" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-34,92})));
  Sensors.MassFlowRate mFlow_con(final allowFlowReversal=allowFlowReversalEva,
      redeclare final package Medium = Medium_con)
    "Mass flow sensor at the evaporator" annotation (Placement(transformation(
        origin={-76,60},
        extent={{-10,10},{10,-10}},
        rotation=0)));

equation

  connect(modeSet, sigBusHP.mode) annotation (Line(points={{-116,-20},{-76,-20},
          {-76,-42.915},{-104.925,-42.915}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(innerCycle.Pel, sigBusHP.Pel) annotation (Line(points={{28.73,-0.865},
          {38,-0.865},{38,-36},{-52,-36},{-52,-42.915},{-104.925,-42.915}},
                                                  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(nSet, sigBusHP.N) annotation (Line(points={{-116,20},{-76,20},{-76,-42.915},
          {-104.925,-42.915}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(innerCycle.QEva, realPassThroughnSetEva.u) annotation (Line(
      points={{-1.77636e-15,-30.7},{-1.77636e-15,-38},{16,-38},{16,-44.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(innerCycle.QEva, heatFlowIneEva.u) annotation (Line(
      points={{-1.77636e-15,-30.7},{-1.77636e-15,-38},{-14,-38},{-14,-44.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(innerCycle.QCon, heatFlowIneCon.u) annotation (Line(
      points={{1.77636e-15,28.7},{1.77636e-15,30},{0,30},{0,40},{-16,40},{-16,50.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(innerCycle.QCon, realPassThroughnSetCon.u) annotation (Line(
      points={{1.77636e-15,28.7},{0,28.7},{0,40},{16,40},{16,50.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sigBusHP, innerCycle.sigBusHP) annotation (Line(
      points={{-105,-43},{-54,-43},{-54,-0.73},{-26.78,-0.73}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(iceFac_in, sigBusHP.iceFac) annotation (Line(points={{-76,-136},{-76,-42.915},
          {-104.925,-42.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(T_amb_con, varTempOutCon.T) annotation (Line(
      points={{110,100},{84,100},{84,110},{77.6,110}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(varTempOutCon.port, con.port_out) annotation (Line(
      points={{60,110},{0,110},{0,108}},
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
  connect(realPassThroughnSetCon.y, con.QFlow_in) annotation (Line(
      points={{16,64.6},{16,75.04},{0,75.04}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(heatFlowIneCon.y, con.QFlow_in) annotation (Line(
      points={{-16,64.6},{-16,75.04},{0,75.04}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(realPassThroughnSetEva.y, eva.QFlow_in) annotation (Line(points={{16,-58.6},
          {16,-69.04},{0,-69.04}}, color={0,0,127}));
  connect(heatFlowIneEva.y, eva.QFlow_in) annotation (Line(points={{-14,-58.6},{
          -14,-69.04},{0,-69.04}}, color={0,0,127}));
  connect(senT_a2.port_b, eva.port_a)
    annotation (Line(points={{28,-86},{16,-86}}, color={0,127,255}));
  connect(senT_b2.port_a, eva.port_b)
    annotation (Line(points={{-42,-86},{-16,-86}}, color={0,127,255}));
  connect(senT_b2.port_b, port_b2) annotation (Line(points={{-62,-86},{-62,-60},
          {-100,-60}}, color={0,127,255}));
  connect(mFlow_eva.port_a, port_a2)
    annotation (Line(points={{82,-60},{100,-60}}, color={0,127,255}));
  connect(mFlow_eva.port_b, senT_a2.port_a) annotation (Line(points={{62,-60},{58,
          -60},{58,-86},{48,-86}}, color={0,127,255}));
  connect(con.port_a, senT_a1.port_b)
    annotation (Line(points={{-16,92},{-24,92}}, color={0,127,255}));
  connect(senT_a1.port_a, mFlow_con.port_b) annotation (Line(points={{-44,92},{
          -56,92},{-56,60},{-66,60}}, color={0,127,255}));
  connect(port_a1, mFlow_con.port_a)
    annotation (Line(points={{-100,60},{-86,60}}, color={0,127,255}));
  connect(con.port_b, senT_b1.port_a)
    annotation (Line(points={{16,92},{28,92}}, color={0,127,255}));
  connect(port_b1, senT_b1.port_b) annotation (Line(points={{100,60},{72,60},{72,
          92},{48,92}}, color={0,127,255}));
  connect(senT_b2.T, sigBusHP.T_ret_ev) annotation (Line(points={{-52,-75},{-52,
          -42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_a2.T, sigBusHP.T_flow_ev) annotation (Line(points={{38,-75},{38,-36},
          {-52,-36},{-52,-42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(mFlow_eva.m_flow, sigBusHP.m_flow_ev) annotation (Line(points={{72,-49},
          {72,-36},{-52,-36},{-52,-42.915},{-104.925,-42.915}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_b1.T, sigBusHP.T_ret_co) annotation (Line(points={{38,81},{38,-36},
          {-52,-36},{-52,-42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_a1.T, sigBusHP.T_flow_co) annotation (Line(points={{-34,81},{-34,
          40},{-76,40},{-76,-42.915},{-104.925,-42.915}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(mFlow_con.m_flow, sigBusHP.m_flow_co) annotation (Line(points={{-76,
          49},{-76,-42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
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
