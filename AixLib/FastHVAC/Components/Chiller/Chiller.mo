within AixLib.FastHVAC.Components.Chiller;
model Chiller "Base model of FastHVAC Chiller"
  import AixLib;

//General
  parameter AixLib.FastHVAC.Media.BaseClasses.MediumSimple Medium_con=
      AixLib.FastHVAC.Media.WaterSimple()
    "Medium at sink side"
    annotation (Dialog(tab = "Condenser"),choicesAllMatching=true);
  parameter AixLib.FastHVAC.Media.BaseClasses.MediumSimple Medium_eva=
      AixLib.FastHVAC.Media.WaterSimple()
    "Medium at source side"
    annotation (Dialog(tab = "Evaporator"),choicesAllMatching=true);
  parameter Boolean use_revChi=true "True if the chiller is reversible"
    annotation(choices(checkBox=true), Dialog(descriptionLabel=true));
  parameter Boolean use_autoCalc=false
    "Enable automatic estimation of volumes and mass flows?"
    annotation(choices(checkBox=true), Dialog(descriptionLabel=true));
  parameter Modelica.SIunits.Power Q_useNominal(start=0)
    "Nominal usable heat flow of the thermal machine (HP: Heating; Chiller: Cooling)"
    annotation (Dialog(enable=use_autoCalc));
  replaceable model PerDataMainChi =
      AixLib.DataBase.Chiller.PerformanceData.BaseClasses.PartialPerformanceData
    "Performance data of chiller in cooling mode"
    annotation (choicesAllMatching=true);
  replaceable model PerDataRevChi =
      AixLib.DataBase.Chiller.PerformanceData.BaseClasses.PartialPerformanceData
    "Performance data of chiller in heating mode"
    annotation (Dialog(enable=use_revHP),choicesAllMatching=true);
  parameter Real scalingFactor=1 "Scaling-factor of chiller";
  parameter Boolean use_refIne=true "Consider the inertia of the refrigerant cycle"
    annotation(choices(checkBox=true), Dialog(
        group="Refrigerant inertia"));
  parameter Modelica.SIunits.Frequency refIneFre_constant
    "Cut off frequency for inertia of refrigerant cycle"
    annotation (Dialog(enable=use_refIne, group="Refrigerant inertia"),Evaluate=true);
  parameter Integer nthOrder=3 "Order of refrigerant cycle interia" annotation (Dialog(enable=
          use_refIne, group="Refrigerant inertia"));
  parameter Boolean useBusConnectorOnly = false "Set true to use bus connector for modeSet, nSet and iceFac input"
    annotation(choices(checkBox=true), Dialog(group="Input Connectors"));

//Condenser
  parameter Modelica.SIunits.MassFlowRate mFlow_conNominal
    "Nominal mass flow rate"
    annotation (Dialog(group="Parameters", tab="Condenser"),Evaluate=true);
  parameter Modelica.SIunits.Volume VCon "Volume in condenser"
    annotation (Evaluate=true,Dialog(group="Parameters", tab="Condenser"));
  parameter Modelica.SIunits.Mass m_fluidCon = VCon_final * con.medium.rho "Mass of working fluid";
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
  parameter Modelica.SIunits.Mass m_fluidEva = VEva_final * eva.medium.rho "Mass of working fluid";
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
  parameter Modelica.Media.Interfaces.Types.Temperature TCon_start=10 + 273.15
    "Start value of temperature"
    annotation (Evaluate=true,Dialog(tab="Initialization", group="Condenser"));
  parameter Modelica.Media.Interfaces.Types.Temperature TEva_start=30 + 273.15
    "Start value of temperature"
    annotation (Evaluate=true,Dialog(tab="Initialization", group="Evaporator"));
  parameter Real yRefIne_start=0 "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Initialization", group="Refrigerant inertia",enable=initType ==
          Init.InitialOutput and use_refIne));

//Advanced
  parameter Boolean homotopyInitialization=false "= true, use homotopy method"
    annotation (Dialog(tab="Advanced", group="Flow resistance"));
    Interfaces.EnthalpyPort_a             enthalpyPort_a(
                     m_flow(min=if allowFlowReversalCon then -Modelica.Constants.inf else 0))
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-104,56},{-96,64}})));
  Interfaces.EnthalpyPort_b             enthalpyPort_b(
                     m_flow(max=if allowFlowReversalCon then +Modelica.Constants.inf else 0))
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{104,56},{96,64}})));
  Interfaces.EnthalpyPort_a             enthalpyPort_a1(
                     m_flow(min=if allowFlowReversalEva then -Modelica.Constants.inf else 0))
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{96,-64},{104,-56}})));
  Interfaces.EnthalpyPort_b             enthalpyPort_b1(
                     m_flow(max=if allowFlowReversalEva then +Modelica.Constants.inf else 0))
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-96,-64},{-104,-56}})));
  AixLib.FastHVAC.BaseClasses.EvaporatorCondenserWithCapacity con(
    final kAOut_nominal=GCon,
    final m_fluid=m_fluidCon,
    final T_start=TCon_start,
    final use_cap=use_ConCap,
    final is_con=true,
    final V=VCon_final*scalingFactor,
    final C=CCon*scalingFactor,
    final kAInn=GCon + GConIns*abs(mFlow_con.dotm/mFlow_conNominal_final)^0.88,
    final medium=Medium_con,
    final m_flow_small=1E-4*abs(mFlow_conNominal_final),
    final m_flow_nominal=mFlow_conNominal_final)
    "Heat exchanger model for the condenser"
    annotation (Placement(transformation(extent={{-16,76},{16,108}})));
  AixLib.FastHVAC.BaseClasses.EvaporatorCondenserWithCapacity eva(
    final medium=Medium_eva,
    final use_cap=use_EvaCap,
    final kAOut_nominal=GEva,
    final m_fluid=m_fluidEva,
    final T_start=TEva_start,
    final m_flow_small=1E-4*abs(mFlow_evaNominal_final),
    final is_con=false,
    final V=VEva_final*scalingFactor,
    final C=CEva*scalingFactor,
    final m_flow_nominal=mFlow_evaNominal_final,
    final kAInn=GEva + GEvaIns*abs(mFlow_eva.dotm/mFlow_evaNominal_final)^0.88)
    "Heat exchanger model for the evaporator"
    annotation (Placement(transformation(extent={{16,-70},{-16,-102}})));
  Modelica.Blocks.Continuous.CriticalDamping heatFlowIneEva(
    final initType=initType,
    final normalized=true,
    final n=nthOrder,
    final f=refIneFre_constant,
    final y_start=yRefIne_start) if use_refIne
    "This n-th order block represents the inertia of the refrigerant cycle and delays the heat flow"
    annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=90,
        origin={-14,-52})));
  Modelica.Blocks.Routing.RealPassThrough realPassThroughnSetCon if not use_refIne
    "Use default nSet value" annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={16,58})));
  Modelica.Blocks.Continuous.CriticalDamping heatFlowIneCon(
    final initType=initType,
    final normalized=true,
    final n=nthOrder,
    final f=refIneFre_constant,
    final y_start=yRefIne_start) if use_refIne
    "This n-th order block represents the inertia of the refrigerant cycle and delays the heat flow"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-16,58})));
  Modelica.Blocks.Routing.RealPassThrough realPassThroughnSetEva if not use_refIne
    "Use default nSet value"
     annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=90,
        origin={16,-52})));
  Modelica.Blocks.Interfaces.RealInput iceFac_in if not useBusConnectorOnly
    "Input signal for icing factor"
     annotation (Placement(transformation(
        extent={{-16,-16},{16,16}},
        rotation=90,
        origin={-76,-136})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTempOutEva if
    use_EvaCap "Forces heat losses according to ambient temperature"
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={68,-108})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTempOutCon if
    use_ConCap "Forces heat losses according to ambient temperature"
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={68,110})));
  Modelica.Blocks.Interfaces.RealInput nSet if not useBusConnectorOnly
    "Input signal speed for compressor relative between 0 and 1" annotation (Placement(
        transformation(extent={{-132,4},{-100,36}})));
  Controls.Interfaces.ThermalMachineControlBus sigBus annotation (Placement(
        transformation(extent={{-120,-60},{-90,-26}}), iconTransformation(
          extent={{-108,-52},{-90,-26}})));
  AixLib.Fluid.Chillers.BaseClasses.InnerCycle_Chiller innerCycle(
    redeclare final model PerDataMainChi = PerDataMainChi,
    redeclare final model PerDataRevChi = PerDataRevChi,
    final use_rev=use_revChi,
    final scalingFactor=scalingFactor) annotation (Placement(transformation(
        extent={{-27,-26},{27,26}},
        rotation=90,
        origin={0,-1})));
  Modelica.Blocks.Interfaces.RealInput T_amb_eva(final unit="K",
    final displayUnit="degC") if use_EvaCap
    "Ambient temperature on the evaporator side"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={110,-100})));
  Modelica.Blocks.Interfaces.RealInput T_amb_con(final unit="K",
    final displayUnit="degC") if use_ConCap
    "Ambient temperature on the condenser side"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={110,100})));
  Modelica.Blocks.Interfaces.BooleanInput modeSet if not useBusConnectorOnly "Set value of HP mode"
    annotation (Placement(transformation(extent={{-132,-34},{-100,-2}})));
  Sensors.TemperatureSensor        senT_a2
    "Temperature at sink inlet"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={40,-86})));
  Sensors.TemperatureSensor        senT_b2
    "Temperature at sink outlet"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-52,-86})));
  Sensors.MassFlowSensor           mFlow_eva
    "Mass flow sensor at the evaporator"
    annotation (Placement(transformation(
        origin={70,-60},
        extent={{10,-10},{-10,10}},
        rotation=0)));
  Sensors.TemperatureSensor        senT_b1
    "Temperature at sink outlet"
    annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={38,92})));
  Sensors.TemperatureSensor        senT_a1
    "Temperature at sink inlet"
    annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-34,92})));
  Sensors.MassFlowSensor           mFlow_con
    "Mass flow sensor at the evaporator"
    annotation (Placement(transformation(
        origin={-80,60},
        extent={{-10,10},{10,-10}},
        rotation=0)));

  //Automatic calculation of mass flow rates and volumes of the evaporator and condenser using linear regressions from data sheets of heat pumps and chillers (water to water)
protected
  parameter Boolean machineType=false "=true if heat pump; =false if chiller";
  parameter Modelica.SIunits.MassFlowRate autoCalc_mFlow_min = 0.3 "Realistic mass flow minimum for simulation plausibility";
  parameter Modelica.SIunits.Volume autoCalc_Vmin = 0.003 "Realistic volume minimum for simulation plausibility";

  parameter Modelica.SIunits.MassFlowRate autoCalc_mFlow_eva = if machineType then max(0.00004*Q_useNominal - 0.3177, autoCalc_mFlow_min) else max(0.00005*Q_useNominal - 0.5662, autoCalc_mFlow_min);
  parameter Modelica.SIunits.MassFlowRate autoCalc_mFlow_con = if machineType then max(0.00004*Q_useNominal - 0.6162, autoCalc_mFlow_min) else max(0.00005*Q_useNominal + 0.3161, autoCalc_mFlow_min);
  parameter Modelica.SIunits.MassFlowRate mFlow_evaNominal_final=if use_autoCalc then autoCalc_mFlow_eva else mFlow_evaNominal;
  parameter Modelica.SIunits.MassFlowRate mFlow_conNominal_final=if use_autoCalc then autoCalc_mFlow_con else mFlow_conNominal;
  parameter Modelica.SIunits.Volume autoCalc_VEva = if machineType then max(0.0000001*Q_useNominal - 0.0075, autoCalc_Vmin) else max(0.0000001*Q_useNominal - 0.0066, autoCalc_Vmin);
  parameter Modelica.SIunits.Volume autoCalc_VCon = if machineType then max(0.0000001*Q_useNominal - 0.0094, autoCalc_Vmin) else max(0.0000002*Q_useNominal - 0.0084, autoCalc_Vmin);
  parameter Modelica.SIunits.Volume VEva_final=if use_autoCalc then autoCalc_VEva else VEva;
  parameter Modelica.SIunits.Volume VCon_final=if use_autoCalc then autoCalc_VCon else VCon;


equation
  //Control and feedback for the auto-calculation of condenser and evaporator data
  assert(not use_autoCalc or (use_autoCalc and Q_useNominal>0), "Can't auto-calculate evaporator and condenser data without a given nominal power flow (Q_useNominal)!",
  level = AssertionLevel.error);
  assert(not use_autoCalc or (autoCalc_mFlow_eva>autoCalc_mFlow_min and autoCalc_mFlow_eva<90),
  "Given nominal power (Q_useNominal) for auto-calculation of evaporator and condenser data is outside the range of data sheets considered. Please control the auto-calculated mass flows!",
  level = AssertionLevel.warning);
  assert(not use_autoCalc or (autoCalc_VEva>autoCalc_Vmin and autoCalc_VEva<0.43),
  "Given nominal power (Q_useNominal) for auto-calculation of evaporator and condenser data is outside the range of data sheets considered. Please control the auto-calculated volumes!",
  level = AssertionLevel.warning);

  connect(enthalpyPort_a, mFlow_con.enthalpyPort_a) annotation (Line(points={{-100,60},
          {-92,60},{-92,60.1},{-88.8,60.1}},     color={176,0,0}));
  connect(mFlow_con.enthalpyPort_b, senT_a1.enthalpyPort_a) annotation (Line(
        points={{-71,60.1},{-52,60.1},{-52,92.1},{-42.8,92.1}}, color={176,0,0}));
  connect(senT_a1.enthalpyPort_b, con.enthalpyPort_a) annotation (Line(points={{-25,
          92.1},{-21.5,92.1},{-21.5,92},{-16,92}},     color={176,0,0}));
  connect(con.enthalpyPort_b, senT_b1.enthalpyPort_a) annotation (Line(points={{16,92},
          {22,92},{22,92.1},{29.2,92.1}},        color={176,0,0}));
  connect(senT_b1.enthalpyPort_b, enthalpyPort_b) annotation (Line(points={{47,92.1},
          {84,92.1},{84,60},{100,60}}, color={176,0,0}));
  connect(T_amb_con, varTempOutCon.T) annotation (Line(points={{110,100},{82,100},
          {82,110},{77.6,110}}, color={0,0,127}));
  connect(varTempOutCon.port, con.port_out)
    annotation (Line(points={{60,110},{0,110},{0,108}}, color={191,0,0}));
  connect(varTempOutEva.port, eva.port_out)
    annotation (Line(points={{60,-108},{0,-108},{0,-102}}, color={191,0,0}));
  connect(T_amb_eva, varTempOutEva.T) annotation (Line(points={{110,-100},{82,-100},
          {82,-108},{77.6,-108}}, color={0,0,127}));
  connect(senT_a2.enthalpyPort_a, mFlow_eva.enthalpyPort_b) annotation (Line(
        points={{48.8,-86.1},{52,-86.1},{52,-60.1},{61,-60.1}}, color={176,0,0}));
  connect(mFlow_eva.enthalpyPort_a, enthalpyPort_a1) annotation (Line(points={{78.8,
          -60.1},{92,-60.1},{92,-60},{100,-60}}, color={176,0,0}));
  connect(senT_a2.enthalpyPort_b, eva.enthalpyPort_a) annotation (Line(points={{
          31,-86.1},{16,-86.1},{16,-86}}, color={176,0,0}));
  connect(eva.enthalpyPort_b, senT_b2.enthalpyPort_a) annotation (Line(points={{
          -16,-86},{-30,-86},{-30,-86.1},{-43.2,-86.1}}, color={176,0,0}));
  connect(senT_b2.enthalpyPort_b, enthalpyPort_b1) annotation (Line(points={{-61,
          -86.1},{-82,-86.1},{-82,-60},{-100,-60}}, color={176,0,0}));
  connect(iceFac_in, sigBus.iceFac) annotation (Line(points={{-76,-136},{-76,-42.915},
          {-104.925,-42.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(innerCycle.QEva, realPassThroughnSetEva.u) annotation (Line(points={{0,
          -30.7},{0,-40},{16,-40},{16,-44.8}}, color={0,0,127}));
  connect(innerCycle.QEva, heatFlowIneEva.u) annotation (Line(points={{0,-30.7},
          {0,-40},{-14,-40},{-14,-44.8}}, color={0,0,127}));
  connect(heatFlowIneEva.y, eva.QFlow_in) annotation (Line(points={{-14,-58.6},{
          -14,-69.04},{0,-69.04}}, color={0,0,127}));
  connect(realPassThroughnSetEva.y, eva.QFlow_in) annotation (Line(points={{16,-58.6},
          {16,-69.04},{0,-69.04}}, color={0,0,127}));
  connect(innerCycle.QCon, realPassThroughnSetCon.u) annotation (Line(points={{0,
          28.7},{0,40},{16,40},{16,50.8}}, color={0,0,127}));
  connect(innerCycle.QCon, heatFlowIneCon.u) annotation (Line(points={{0,28.7},{
          0,40},{-16,40},{-16,50.8}}, color={0,0,127}));
  connect(heatFlowIneCon.y, con.QFlow_in) annotation (Line(points={{-16,64.6},{
          -16,75.04},{0,75.04}},
                             color={0,0,127}));
  connect(realPassThroughnSetCon.y, con.QFlow_in) annotation (Line(points={{16,64.6},
          {16,75.04},{0,75.04}}, color={0,0,127}));
  connect(mFlow_con.dotm, sigBus.m_flow_co) annotation (Line(points={{-79,51},{
          -79,-42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(nSet,sigBus.n)  annotation (Line(points={{-116,20},{-84,20},{-84,-42.915},
          {-104.925,-42.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modeSet, sigBus.mode) annotation (Line(points={{-116,-18},{-84,-18},{
          -84,-42.915},{-104.925,-42.915}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(senT_a1.T, sigBus.T_flow_co) annotation (Line(points={{-33,81},{-33,-42.915},
          {-104.925,-42.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_a2.T, sigBus.T_flow_ev) annotation (Line(points={{39,-75},{39,-36},
          {-30,-36},{-30,-42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_b1.T, sigBus.T_ret_co) annotation (Line(points={{39,81},{39,-36},
          {-30,-36},{-30,-42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(innerCycle.Pel, sigBus.Pel) annotation (Line(points={{28.73,-0.865},{
          42,-0.865},{42,-36},{-30,-36},{-30,-42.915},{-104.925,-42.915}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(innerCycle.sigBus, sigBus) annotation (Line(
      points={{-26.78,-0.73},{-32,-0.73},{-32,-42},{-32,-42},{-32,-43},{-105,-43}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(mFlow_eva.dotm, sigBus.m_flow_ev) annotation (Line(points={{69,-51},{
          69,-36},{-30,-36},{-30,-42.915},{-104.925,-42.915}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_b2.T, sigBus.T_ret_ev) annotation (Line(points={{-53,-75},{-53,-42.915},
          {-104.925,-42.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
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
            -120},{100,120}})),
  Documentation(info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  Chiller model adapted to FastHAVC library.
</p>
<p>
  This model is based on the Fluid model <a href=
  \"modelica://AixLib.Fluid.Chiller.Chiller\">AixLib.Fluid.Chiller.Chiller</a>
  created by Julian Matthes in 2019.
</p>
</html>",
  revisions="<html><ul>
  <li>
    <i>May 22, 2019</i> by Julian Matthes:<br/>
    Rebuild due to the introducion of the thermal machine partial model
    (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
  </li>
  <li>
    <i>January 22, 2019&#160;</i> Niklas Hülsenbeck:<br/>
    Moved into AixLib
  </li>
</ul>
</html>"));
end Chiller;
