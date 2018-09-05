within AixLib.Fluid.HeatPumps;
model HeatPump "Base model of realistic heat pump"
  extends AixLib.Fluid.Interfaces.PartialFourPortInterface(
    redeclare final package Medium1 = Medium_con,
    final m1_flow_nominal=mFlow_conNominal,
    final m2_flow_nominal=mFlow_evaNominal,
    final allowFlowReversal1=allowFlowReversalCon,
    final allowFlowReversal2=allowFlowReversalEva,
    redeclare package Medium2 = Medium_eva);
  MixingVolumes.MixingVolume Condenser(
    nPorts=2,
    redeclare final package Medium = Medium_con,
    final allowFlowReversal=allowFlowReversalCon,
    final m_flow_nominal=mFlow_conNominal,
    final use_C_flow=false,
    final p_start=pCon_start,
    final T_start=TCon_start,
    final X_start=XCon_start,
    final C_start=fill(0, Medium_con.nC),
    final C_nominal=fill(1E-2, Medium_con.nC),
    final V=VCon*scalingFactor)            "Volume of Condenser"
    annotation (Placement(transformation(extent={{-6,86},{14,66}})));
  MixingVolumes.MixingVolume Evaporator(
    nPorts=2,
    redeclare final package Medium = Medium_eva,
    final allowFlowReversal=allowFlowReversalEva,
    final m_flow_nominal=mFlow_evaNominal,
    final p_start=pEva_start,
    final T_start=TEva_start,
    final X_start=XEva_start,
    final use_C_flow=false,
    final C_start=fill(0, Medium_eva.nC),
    final C_nominal=fill(1E-2, Medium_eva.nC),
    final V=VEva*scalingFactor)
                  "Volume of Evaporator"
    annotation (Placement(transformation(extent={{-8,-84},{12,-64}})));
  Sensors.MassFlowRate mFlow_a1(redeclare final package Medium = Medium_con,
      final allowFlowReversal=allowFlowReversalCon)
    "Mass flow rate at source inlet"
    annotation (Placement(transformation(extent={{-72,90},{-52,70}})));
  Sensors.TemperatureTwoPort senT_b2(
    final transferHeat=true,
    redeclare final package Medium = Medium_eva,
    final allowFlowReversal=allowFlowReversalEva,
    final m_flow_nominal=mFlow_evaNominal,
    final initType=initType,
    final T_start=TEva_start,
    final TAmb=TAmbEva_nom,
    final tau=tauSenT,
    final tauHeaTra=tauHeaTra)
                            "Temperature at source outlet"
    annotation (Placement(transformation(extent={{-26,-92},{-46,-72}})));
  Sensors.TemperatureTwoPort senT_b1(
    final transferHeat=true,
    redeclare final package Medium = Medium_con,
    final allowFlowReversal=allowFlowReversalCon,
    final m_flow_nominal=mFlow_conNominal,
    final T_start=TCon_start,
    final TAmb(displayUnit="K") = TAmbCon_nom,
    final initType=initType,
    final tauHeaTra=tauHeaTra,
    final tau=tauSenT)       "Temperature at sink outlet"
    annotation (Placement(transformation(extent={{26,90},{46,70}})));
  Sensors.TemperatureTwoPort senT_a2(
    final transferHeat=true,
    redeclare final package Medium = Medium_eva,
    final allowFlowReversal=allowFlowReversalEva,
    final m_flow_nominal=mFlow_evaNominal,
    final T_start=TEva_start,
    final TAmb(displayUnit="K") = TAmbEva_nom,
    final initType=initType,
    final tau=tauSenT,
    final tauHeaTra=tauHeaTra)                 "Temperature at source inlet"
    annotation (Placement(transformation(extent={{32,-92},{12,-72}})));
  Sensors.TemperatureTwoPort senT_a1(
    final transferHeat=true,
    redeclare final package Medium = Medium_con,
    final allowFlowReversal=allowFlowReversalCon,
    final m_flow_nominal=mFlow_conNominal,
    final initType=initType,
    final T_start=TCon_start,
    final TAmb=TAmbCon_nom,
    final tauHeaTra=tauHeaTra,
    final tau=tauSenT)      "Temperature at sink  inlet"
    annotation (Placement(transformation(extent={{-44,90},{-24,70}})));
  Sensors.MassFlowRate mFlow_a2(redeclare package Medium = Medium_eva, final
      allowFlowReversal=allowFlowReversalEva) "Mass flow rate at sink inlet"
    annotation (Placement(transformation(extent={{76,-84},{56,-64}})));
  FixedResistances.PressureDrop preDro_2(
    redeclare final package Medium = Medium_eva,
    final allowFlowReversal=allowFlowReversalEva,
    final m_flow_nominal=mFlow_evaNominal,
    final dp_nominal=dpEva_nominal) "Pressure drop at sink side"
    annotation (Placement(transformation(extent={{-60,-84},{-80,-64}})));
  FixedResistances.PressureDrop preDro_1(
    redeclare final package Medium = Medium_con,
    final allowFlowReversal=allowFlowReversalCon,
    final m_flow_nominal=mFlow_conNominal,
    final dp_nominal=dpCon_nominal,
    from_dp=true)                   "Pressure drop at sink side"
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
  Modelica.Blocks.Interfaces.RealInput nSet
    "Input signal speed for compressor relative between 0 and 1" annotation (Placement(
        transformation(extent={{-132,4},{-100,36}})));
  Controls.Interfaces.HeatPumpControlBus
                           sigBusHP
    annotation (Placement(transformation(extent={{-132,-62},{-102,-28}}),
        iconTransformation(extent={{-120,-54},{-102,-28}})));
  BaseClasses.InnerCycle innerCycle(redeclare final model PerDataHea =
      PerDataHea,
      redeclare final model PerDataChi = PerDataChi,
    final use_revHP=use_revHP)                                                           annotation (
      Placement(transformation(
        extent={{-30,-30},{30,30}},
        rotation=90,
        origin={-12,8})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowRateEva
    "Heat flow rate of the evaporator" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-46})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowRateCon
    "Heat flow rate of the condenser" annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=270,
        origin={-16,54})));
  replaceable package Medium_con = Modelica.Media.Interfaces.PartialMedium "Medium at sink side"
    annotation (choicesAllMatching=true);
  replaceable package Medium_eva = Modelica.Media.Interfaces.PartialMedium "Medium at source side"
    annotation (choicesAllMatching=true);
  parameter Boolean allowFlowReversalEva=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Dialog(group="Evaporator", tab="Assumptions"));
  parameter Boolean allowFlowReversalCon=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Evaluate=false,Dialog(group="Condenser", tab="Assumptions"));
  parameter Modelica.SIunits.MassFlowRate mFlow_conNominal
    "Nominal mass flow rate, used for regularization near zero flow"
    annotation (Evaluate=false,Dialog(group="General", tab="Condenser"));
  parameter Modelica.SIunits.MassFlowRate mFlow_evaNominal
    "Nominal mass flow rate" annotation (Evaluate=false,Dialog(group="General", tab="Evaporator"));
  parameter Modelica.SIunits.Volume VCon "Volume in condenser"
    annotation (Evaluate=false,Dialog(group="General", tab="Condenser"));
  parameter Modelica.SIunits.Volume VEva "Volume in evaporator"
    annotation (Evaluate=false,Dialog(group="General", tab="Evaporator"));
  parameter Modelica.SIunits.PressureDifference dpEva_nominal
    "Pressure drop at nominal mass flow rate"
    annotation (Evaluate=false,Dialog(group="General", tab="Evaporator"));
  parameter Modelica.SIunits.PressureDifference dpCon_nominal
    "Pressure drop at nominal mass flow rate"
    annotation (Evaluate=false,Dialog(group="General", tab="Condenser"));

  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    final k=1,
    final T=comIneTime_constant,
    final initType=initType,
    final y_start=yComIne_start) if
                              use_comIne
    "As all changes in a compressor have certain inertia, no nSet is directly obtained. This first order block represents the inertia of the compressor."
    annotation (Placement(transformation(extent={{-92,20},{-80,32}})));
  parameter Boolean use_comIne=false "Consider the inertia of the compressor" annotation(Evaluate=false,choices(checkBox=true));

  constant Modelica.SIunits.Time comIneTime_constant
    "Time constant representing inertia of compressor"
    annotation (Dialog(enable=use_comIne));

  parameter Boolean use_EvaCap=false
    "If heat losses at capacitor side are considered or not"
    annotation (Evaluate=false,Dialog(group="Heat Losses", tab="Evaporator"),
                                          choices(checkBox=true));
  parameter Boolean use_ConCap=false
    "If heat losses at capacitor side are considered or not"
    annotation (Evaluate=false,Dialog(group="Heat Losses", tab="Condenser"),
                                          choices(checkBox=true));


  parameter Modelica.SIunits.HeatCapacity CEva
    "Heat capacity of Evaporator (= cp*m)"
    annotation (Evaluate=false,Dialog(group="Heat Losses", tab="Evaporator",
      enable=use_EvaCap));
  parameter Modelica.SIunits.ThermalConductance GEva
    "Constant thermal conductance of Evaporator material"
    annotation (Evaluate=false,Dialog(group="Heat Losses", tab="Evaporator",
      enable=use_EvaCap));
  parameter Modelica.SIunits.HeatCapacity CCon
    "Heat capacity of Condenser (= cp*m)" annotation (Evaluate=false,Dialog(group="Heat Losses",
        tab="Condenser",
      enable=use_ConCap));
  parameter Modelica.SIunits.ThermalConductance GCon
    "Constant thermal conductance of condenser material"
    annotation (Evaluate=false,Dialog(group="Heat Losses", tab="Condenser",
      enable=use_ConCap));
  Modelica.Blocks.Interfaces.RealInput T_amb_eva(final unit="K", final
      displayUnit="degC")
    "Ambient temperature on the evaporator side"
    annotation (Placement(transformation(extent={{122,-50},{100,-28}})));

  replaceable model PerDataHea =
      AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.BaseClasses.PartialPerformanceData
  "Performance data of HP in heating mode"
    annotation (choicesAllMatching=true);
  replaceable model PerDataChi =
      AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.BaseClasses.PartialPerformanceData
  "Performance data of HP in chilling mode"
    annotation (Dialog(enable=use_revHP),choicesAllMatching=true);

  Modelica.Blocks.Math.RealToBoolean realToBoolean(threshold=0.1)
    "To generate the on off signal" annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=90,
        origin={-140,-14})));
  Modelica.Blocks.Routing.RealPassThrough realPassThroughnSet if not use_comIne
    "Use default nSet value" annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-87,7})));
  Modelica.Blocks.Interfaces.RealInput T_amb_con(final unit="K", final
      displayUnit="degC")
    "Ambient temperature on the condenser side"
    annotation (Placement(transformation(extent={{122,30},{100,52}})));
  Utilities.HeatTransfer.CapacityWithLosses ConCapacity(
    final use_ForConv=false,
    final scalingFactor=scalingFactor,
    final mFlowIns_nominal=mFlow_conNominal,
    final kAOutNat_nominal=GCon,
    final T_amb_nominal=TAmbCon_nom,
    final C=CCon*scalingFactor) if              use_ConCap
    "Model calculating the heat losses to the ambient based on current parameters"
    annotation (Placement(transformation(extent={{-100,94},{-72,120}})));
  Utilities.HeatTransfer.CapacityWithLosses EvaCapacity(
    final scalingFactor=scalingFactor,
    final use_ForConv=false,
    final mFlowIns_nominal=mFlow_evaNominal,
    kAOutNat_nominal=GEva,
    final T_amb_nominal=TAmbEva_nom,
    final C=CEva*scalingFactor) if              use_EvaCap
    "Model calculating the heat losses to the ambient based on current parameters"
    annotation (Placement(transformation(extent={{-100,-120},{-72,-94}})));
  parameter Real scalingFactor "Scaling-factor of HP";

  Modelica.Blocks.Interfaces.BooleanInput modeSet "Set value of HP mode"
    annotation (Placement(transformation(extent={{-132,-36},{-100,-4}})));
  parameter Boolean use_revHP=true "True if the HP is reversible" annotation(Evaluate=false,choices(choice=true "reversible HP",
      choice=false "only heating",
      radioButtons=true));
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
  parameter Modelica.SIunits.Temperature TAmbCon_nom=291.15
    "Fixed ambient temperature for heat transfer at condenser side" annotation (Evaluate=false,Dialog(tab="Condenser", group="Nominal conditions"));
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (InitialState and InitialOutput are identical)"
    annotation (Evaluate=false,Dialog(tab="Initialization", group="General"));
  parameter Modelica.SIunits.Temperature TAmbEva_nom=273.15
    "Fixed ambient temperature for heat transfer at evaporator"
    annotation (Evaluate=false,Dialog(tab="Evaporator", group="Nominal conditions"));
  parameter Modelica.SIunits.Time tauHeaTra=1200
    "Time constant for heat transfer in temperature sensors, default 20 minutes"
    annotation (Evaluate=false,Dialog(tab="Assumptions"));
  parameter Modelica.SIunits.Time tauSenT=1
    "Time constant at nominal flow rate (use tau=0 for steady-state sensor, but see user guide for potential problems)"
    annotation (Evaluate=false,Dialog(tab="Assumptions"));
  parameter Real yComIne_start=0 "Initial or guess value of output (= state)"
    annotation (Evaluate=false,Dialog(tab="Initialization", group="General"));
equation
  connect(port_a1, mFlow_a1.port_a) annotation (Line(points={{-100,60},{-100,80},
          {-72,80}},          color={0,127,255}));
  connect(mFlow_a1.port_b, senT_a1.port_a) annotation (Line(points={{-52,80},{-44,
          80}},                   color={0,127,255}));
  connect(senT_a1.port_b, Condenser.ports[1]) annotation (Line(points={{-24,80},
          {-14,80},{-14,86},{2,86}},   color={0,127,255}));
  connect(Condenser.ports[2], senT_b1.port_a) annotation (Line(points={{6,86},{
          18,86},{18,80},{26,80}},   color={0,127,255}));
  connect(preDro_1.port_b, port_b1)
    annotation (Line(points={{80,80},{92,80},{92,60},{100,60}},
                                                color={0,127,255}));
  connect(preDro_1.port_a, senT_b1.port_b) annotation (Line(points={{60,80},{46,
          80}},                 color={0,127,255}));
  connect(mFlow_a2.port_a, port_a2)
    annotation (Line(points={{76,-74},{90,-74},{90,-60},{100,-60}},
                                                  color={0,127,255}));
  connect(senT_a2.port_a, mFlow_a2.port_b) annotation (Line(points={{32,-82},{
          46,-82},{46,-74},{56,-74}}, color={0,127,255}));
  connect(senT_a2.port_b, Evaporator.ports[1])
    annotation (Line(points={{12,-82},{12,-84},{0,-84}}, color={0,127,255}));
  connect(senT_b2.port_a, Evaporator.ports[2]) annotation (Line(points={{-26,-82},
          {-16,-82},{-16,-84},{4,-84}}, color={0,127,255}));
  connect(preDro_2.port_b, port_b2)
    annotation (Line(points={{-80,-74},{-90,-74},{-90,-60},{-100,-60}},
                                                    color={0,127,255}));
  connect(preDro_2.port_a, senT_b2.port_b) annotation (Line(points={{-60,-74},{
          -54,-74},{-54,-82},{-46,-82}}, color={0,127,255}));
  connect(mFlow_a1.m_flow, sigBusHP.m_flow_co) annotation (Line(points={{-62,69},
          {-62,62},{-70,62},{-70,-44},{-116,-44},{-116,-44.915},{-116.925,
          -44.915}},                     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(mFlow_a2.m_flow, sigBusHP.m_flow_ev) annotation (Line(points={{66,-63},
          {66,-44},{-70,-44},{-70,-44.915},{-116.925,-44.915}},
                                                            color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_b2.T, sigBusHP.T_ret_ev) annotation (Line(points={{-36,-71},{-36,
          -44},{-70,-44},{-70,-44.915},{-116.925,-44.915}},
                                                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_a2.T, sigBusHP.T_flow_ev) annotation (Line(points={{22,-71},{22,
          -44},{-70,-44},{-70,-44.915},{-116.925,-44.915}},
                                                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_a1.T, sigBusHP.T_ret_co) annotation (Line(points={{-34,69},{-34,
          62},{-70,62},{-70,-44.915},{-116.925,-44.915}},
                                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_b1.T, sigBusHP.T_flow_co) annotation (Line(points={{36,69},{36,
          62},{-70,62},{-70,-44.915},{-116.925,-44.915}},
                                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatFlowRateEva.port, Evaporator.heatPort) annotation (Line(points={{-10,-56},
          {-10,-74},{-8,-74}},                        color={191,0,0}));
  connect(innerCycle.QEva, heatFlowRateEva.Q_flow)
    annotation (Line(points={{-12,-25},{-12,-30},{-10,-30},{-10,-36}},
                                                           color={0,0,127}));
  connect(Condenser.heatPort, heatFlowRateCon.port)
    annotation (Line(points={{-6,76},{-16,76},{-16,60}},color={191,0,0}));
    connect(nSet, firstOrder.u)
                               annotation (Line(points={{-116,20},{-104,20},{
          -104,26},{-93.2,26}},                                              color={0,0,127},
        pattern=LinePattern.Dash));

    connect(firstOrder.y, sigBusHP.N) annotation (Line(points={{-79.4,26},{-70,
          26},{-70,-44.915},{-116.925,-44.915}},
                                            color={0,0,127},
        pattern=LinePattern.Dash),                            Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));

  connect(innerCycle.QCon, heatFlowRateCon.Q_flow) annotation (Line(points={{-12,41},
          {-12,43.5},{-16,43.5},{-16,48}},         color={0,0,127}));
  connect(T_amb_eva, sigBusHP.T_amb_eva) annotation (Line(points={{111,-39},{54,
          -39},{54,-44},{-94,-44},{-94,-44.915},{-116.925,-44.915}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP, innerCycle.sigBusHP) annotation (Line(
      points={{-117,-45},{-77.5,-45},{-77.5,8.3},{-42.9,8.3}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(realToBoolean.y, sigBusHP.onOff) annotation (Line(points={{-140,-20.6},
          {-140,-44.915},{-116.925,-44.915}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(nSet, realToBoolean.u) annotation (Line(points={{-116,20},{-140,20},{
          -140,-6.8}},          color={0,0,127}));
  connect(realPassThroughnSet.y, sigBusHP.N) annotation (Line(
      points={{-81.5,7},{-69.5,7},{-69.5,-44.915},{-116.925,-44.915}},
      color={0,0,127},
      pattern=LinePattern.Dash), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(nSet, realPassThroughnSet.u) annotation (Line(
      points={{-116,20},{-104,20},{-104,7},{-93,7}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(T_amb_con, sigBusHP.T_amb_con) annotation (Line(points={{111,41},{36,41},
          {36,62},{-70,62},{-70,-44.915},{-116.925,-44.915}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(mFlow_a1.m_flow, ConCapacity.mFlowIns) annotation (Line(
      points={{-62,69},{-62,114.8},{-69.2,114.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(Condenser.heatPort, ConCapacity.fluidPort) annotation (Line(
      points={{-6,76},{-14,76},{-14,97.64},{-71.44,97.64}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(sigBusHP.T_amb_con, ConCapacity.T_amb) annotation (Line(
      points={{-116.925,-44.915},{-116.925,34},{-116,34},{-116,98},{-100,98},{
          -100,97.64},{-102.8,97.64}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dash), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(mFlow_a2.m_flow, EvaCapacity.mFlowIns) annotation (Line(
      points={{66,-63},{66,-99.2},{-69.2,-99.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(Evaporator.heatPort, EvaCapacity.fluidPort) annotation (Line(
      points={{-8,-74},{-18,-74},{-18,-116.36},{-71.44,-116.36}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(sigBusHP.T_amb_eva, EvaCapacity.T_amb) annotation (Line(
      points={{-116.925,-44.915},{-116.925,-116},{-108,-116},{-108,-116.36},{
          -102.8,-116.36}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dash), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(modeSet, sigBusHP.mode) annotation (Line(points={{-116,-20},{-86,-20},
          {-86,-44.915},{-116.925,-44.915}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(innerCycle.Pel, sigBusHP.Pel) annotation (Line(points={{21.15,8.15},{40,
          8.15},{40,-44.915},{-116.925,-44.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
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
    Line(
    origin={40.5,93.667},
    points={{39.5,6.333},{37.5,0.3333},{25.5,-1.667},{33.5,-9.667},{17.5,-11.667},{27.5,-21.667},{13.5,-23.667},
              {11.5,-27.667}},
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
