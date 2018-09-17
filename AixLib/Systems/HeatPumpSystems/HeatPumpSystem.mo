within AixLib.Systems.HeatPumpSystems;
model HeatPumpSystem
  "Model containing the basic heat pump block and different control blocks(optional)"
  import Modelica.Blocks.Types.Init;
  Fluid.HeatPumps.HeatPump heatPump(
    redeclare final package Medium_con = Medium_con,
    redeclare final package Medium_eva = Medium_eva,
    final allowFlowReversalEva=allowFlowReversalEva,
    final allowFlowReversalCon=allowFlowReversalCon,
    final mFlow_conNominal=mFlow_conNominal,
    final mFlow_evaNominal=mFlow_evaNominal,
    final VCon=VCon,
    final VEva=VEva,
    final dpEva_nominal=dpEva_nominal,
    final dpCon_nominal=dpCon_nominal,
    final refIneFre_constant=refIneFre_constant,
    final CEva=CEva,
    final GEva=GEva,
    final CCon=CCon,
    final GCon=GCon,
    redeclare final model PerDataChi = PerDataChi,
    redeclare final model PerDataHea = PerDataHea,
    final scalingFactor=scalingFactor,
    final use_EvaCap=use_evaCap,
    final use_ConCap=false,
    final use_refIne=true,
    final deltaM_con=deltaM_con,
    final deltaM_eva=deltaM_eva,
    final initType=initType,
    final pCon_start=pCon_start,
    final TCon_start=TCon_start,
    final XCon_start=XCon_start,
    final pEva_start=pEva_start,
    final TEva_start=TEva_start,
    final XEva_start=XEva_start,
    final x_start=x_start,
    final massDynamics=massDynamics,
    final energyDynamics=energyDynamics,
    final mSenFacCon=mSenFacCon,
    final mSenFacEva=mSenFacEva,
    final tauSenT=tauSenT,
    final transferHeat=transferHeat,
    final tauHeaTra=tauHeaTra,
    final TAmbCon_nom=TAmbCon_nom,
    final TAmbEva_nom=TAmbEva_nom,
    final use_revHP=false,
    final nthOrder=nthOrder,
    final yRefIne_start=yRefIne_start)
    annotation (Placement(transformation(extent={{-24,-32},{26,28}})));
  Controls.HeatPump.SecurityControls.SecurityControl securityControl(
    final use_minRunTime=use_minRunTime,
    final minRunTime(displayUnit="min") = minRunTime,
    final minLocTime(displayUnit="min") = minLocTime,
    final use_runPerHou=use_runPerHou,
    final maxRunPerHou=maxRunPerHou,
    final use_opeEnv=use_opeEnv,
    final tableLow=tableLow,
    final tableUpp=tableUpp,
    final use_minLocTime=use_minLocTime,
    pre_n_start=pre_n_start,
    final use_deFro=use_deFro,
    final minIceFac=minIceFac,
    final use_chiller=use_chiller,
    final calcPel_deFro=calcPel_deFro,
    final use_antFre=use_antFre,
    final TantFre=TantFre) if             use_sec
    annotation (Placement(transformation(extent={{-102,-24},{-72,6}})));
  Fluid.Movers.SpeedControlled_y           pumSin(
    redeclare final package Medium = Medium_con,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics,
    final p_start=pCon_start,
    final T_start=TCon_start,
    final X_start=XCon_start,
    final allowFlowReversal=allowFlowReversalCon,
    final m_flow_small=1E-4*abs(mFlow_conNominal),
    final init=initType,
    final addPowerToMedium=addPowerToMediumCon,
    final per=perCon,
    final inputType=AixLib.Fluid.Types.InputType.Continuous) if
                            use_conPum
    "Fan or pump at sink side of HP" annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=90,
        origin={-20,56})));
  Fluid.Movers.SpeedControlled_y      pumSou(
    redeclare package Medium = Medium_eva,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    final p_start=pEva_start,
    final T_start=TEva_start,
    final X_start=XEva_start,
    final allowFlowReversal=allowFlowReversalEva,
    final m_flow_small=1E-4*abs(mFlow_evaNominal),
    final init=initType,
    final addPowerToMedium=addPowerToMediumEva,
    final per=perEva,
    final inputType=AixLib.Fluid.Types.InputType.Continuous) if
                            use_evaPum
    "Fan or pump at source side of HP" annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={26,-60})));
  Controls.HeatPump.HPControl hPControls(
    final use_antLeg=use_antLeg,
    redeclare model TSetToNSet = Controls.HeatPump.BaseClasses.OnOffHP,
    use_bivPar=use_bivPar,
    use_secHeaGen=use_secHeaGen,
    hys=hys) annotation (Placement(transformation(extent={{-102,18},{-68,46}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(
    redeclare final package Medium = Medium_eva,
    h_outflow(start=Medium_eva.h_default),
    m_flow(min=if allowFlowReversalEva then -Modelica.Constants.inf else 0))
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-70,110},{-50,130}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(
    redeclare final package Medium = Medium_eva,
    h_outflow(start=Medium_eva.h_default),
    m_flow(max=if allowFlowReversalEva then +Modelica.Constants.inf else 0))
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{70,110},{50,130}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(
    redeclare final package Medium = Medium_con,
    h_outflow(start=Medium_con.h_default),
    m_flow(min=if allowFlowReversalCon then -Modelica.Constants.inf else 0))
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{50,-130},{70,-110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(
    redeclare final package Medium = Medium_con,
    h_outflow(start=Medium_con.h_default),
    m_flow(max=if allowFlowReversalCon then +Modelica.Constants.inf else 0))
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-50,-130},{-70,-110}})));


  Fluid.HeatPumps.BaseClasses.PerformanceData.calcCOP calcCOP(
    final n_QHeat=1,
    final lowBouPel=200,
    final n_Pel=4)
    annotation (Placement(transformation(extent={{92,-44},{114,-18}})));

  Modelica.Blocks.Interfaces.RealInput T_oda "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-150,64},{-120,94}})));
 Modelica.Blocks.Sources.RealExpression calcQHeat(final y=heatPump.sigBusHP.m_flow_co
        *(senTSup.T - heatPump.sigBusHP.T_flow_co)*4180)
    annotation (Placement(transformation(extent={{62,-36},{80,-18}})));
  Fluid.HeatPumps.BaseClasses.PerformanceData.IcingBlock icingBlock if
    use_deFro
    annotation (Placement(transformation(extent={{-72,-74},{-62,-64}})));
  Modelica.Blocks.Sources.Constant constIceFacOne(final k=1) if not use_deFro
    "If defrost is neglacted, iceFac is constant 1"
    annotation (Placement(transformation(extent={{-72,-88},{-62,-78}})));
  Modelica.Blocks.Routing.RealPassThrough realPasThrSec if not use_sec
                                                                      "No 1. Layer"
    annotation (Placement(transformation(extent={{-92,-44},{-78,-30}})));
  Fluid.Interfaces.PassThroughMedium mediumPassThroughSin(
    redeclare final package Medium = Medium_eva,
    final allowFlowReversal=allowFlowReversalEva,
    final m_flow_nominal=mFlow_evaNominal,
    final m_flow_small=1E-4*abs(mFlow_evaNominal),
    final show_T=false) if                    not use_conPum
                                                            annotation (
      Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=90,
        origin={-50,56})));
  Fluid.Interfaces.PassThroughMedium mediumPassThroughSou(
    redeclare final package Medium = Medium_con,
    final allowFlowReversal=allowFlowReversalCon,
    final m_flow_nominal=mFlow_conNominal,
    final m_flow_small=1E-4*abs(mFlow_conNominal),
    final show_T=false) if                    not use_evaPum
                                                            annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={50,-58})));
 secHeatGen secHeaGen(redeclare package Medium = Medium_con,
    allowFlowReversal=allowFlowReversalCon,
    m_flow_nominal=mFlow_conNominal,
    dp_nominal=0,
    final m_flow_small=1E-4*abs(mFlow_conNominal),
    Q_flow_nominal=2000) if  use_secHeaGen annotation (Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=-90,
        origin={32,64})));

  Fluid.Interfaces.PassThroughMedium mediumPassThroughSecHeaGen(
    redeclare final package Medium = Medium_eva,
    final allowFlowReversal=allowFlowReversalEva,
    final m_flow_nominal=mFlow_evaNominal,
    final m_flow_small=1E-4*abs(mFlow_evaNominal),
    final show_T=false) if                    not use_secHeaGen
    "Used if monovalent HP System" annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=270,
        origin={64,62})));
  Fluid.Sensors.TemperatureTwoPort
                             senTSup(
    final transferHeat=true,
    redeclare final package Medium = Medium_con,
    final allowFlowReversal=allowFlowReversalCon,
    final m_flow_nominal=mFlow_conNominal,
    tauHeaTra=1200,
    final m_flow_small=1E-4*mFlow_conNominal,
    final initType=initType,
    final T_start=TCon_start,
    TAmb=291.15)       "Supply temperature"
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=90,
        origin={32,98})));
//General
  replaceable package Medium_con = Modelica.Media.Interfaces.PartialMedium "Medium at sink side"
    annotation (Dialog(group="Sink"),choicesAllMatching=true);
  replaceable package Medium_eva = Modelica.Media.Interfaces.PartialMedium "Medium at source side"
    annotation (Dialog(group="Source"), choicesAllMatching=true);
  parameter Boolean use_secHeaGen=true "True if a bivalent setup is required" annotation(choices(checkBox=true), Dialog(
        group="System"));

  replaceable model secHeatGen =
      AixLib.Fluid.HeatExchangers.HeaterCooler_u constrainedby
    AixLib.Fluid.Interfaces.PartialTwoPortInterface                                                                  annotation(Dialog(group="System", enable=
          use_secHeaGen), choicesAllMatching=true);
  parameter Boolean use_conPum=true
    "True if pump or fan at condenser side are included into this model"
    annotation (Dialog(group="Sink"),choices(checkBox=true));
  parameter Boolean use_evaPum=true
    "True if pump or fan at evaporator side are included into this model"
    annotation (Dialog(group="Source"),choices(checkBox=true));
  parameter Fluid.Movers.Data.Generic perEva "Record with performance data"
    annotation (choicesAllMatching=true, Dialog(
      group="Source",
      enable=use_evaPum));
  parameter Fluid.Movers.Data.Generic perCon "Record with performance data"
    annotation (choicesAllMatching=true, Dialog(
      group="Sink",
      enable=use_conPum));

//Heat Pump
  parameter Boolean use_revHP=true "True if the HP is reversible" annotation(Dialog(tab="Heat Pump"),choices(choice=true "reversible HP",
      choice=false "only heating",
      radioButtons=true));
  replaceable model PerDataHea =
      Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D constrainedby
    AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.BaseClasses.PartialPerformanceData
  "Performance data of HP in heating mode"
    annotation (Dialog(tab="Heat Pump"),choicesAllMatching=true);

  replaceable model PerDataChi =
      Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D constrainedby
    AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.BaseClasses.PartialPerformanceData
  "Performance data of HP in chilling mode"
    annotation (Dialog(tab="Heat Pump",enable=use_revHP), choicesAllMatching=true);
  parameter Real scalingFactor=1 "Scaling-factor of HP" annotation(Dialog(tab="Heat Pump"));
  parameter Boolean use_refIne=false "Consider the inertia of the refrigerant cycle"
    annotation (Dialog(tab="Heat Pump",group="Refrigerant cycle inertia"), choices(checkBox=true));
  constant Modelica.SIunits.Frequency refIneFre_constant
    "Cut off frequency representing inertia of refrigerant cycle"
    annotation (Dialog(tab="Heat Pump",group="Refrigerant cycle inertia", enable=use_refIne));
  parameter Integer nthOrder=3 "Order of refrigerant cycle interia"
    annotation (Dialog(tab="Heat Pump",group="Refrigerant cycle inertia", enable=use_refIne));
//Condenser/Evaporator
  parameter Modelica.SIunits.MassFlowRate mFlow_conNominal
    "Nominal mass flow rate, used for regularization near zero flow"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"));
  parameter Modelica.SIunits.MassFlowRate mFlow_evaNominal
    "Nominal mass flow rate"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"));
  parameter Modelica.SIunits.Volume VCon "Volume in condenser"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"));
  parameter Modelica.SIunits.Volume VEva "Volume in evaporator"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"));
  parameter Modelica.SIunits.PressureDifference dpEva_nominal
    "Pressure drop at nominal mass flow rate"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"));
  parameter Modelica.SIunits.PressureDifference dpCon_nominal
    "Pressure drop at nominal mass flow rate"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"));
  parameter Real deltaM_con=0.1
    "Fraction of nominal mass flow rate where transition to turbulent occurs"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"));
  parameter Real deltaM_eva=0.1
    "Fraction of nominal mass flow rate where transition to turbulent occurs"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"));

  parameter Boolean use_conCap=false
    "If heat losses at capacitor side are considered or not"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"),
                                          choices(checkBox=true));
  parameter Boolean use_evaCap=false
    "If heat losses at capacitor side are considered or not"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"),
                                          choices(checkBox=true));
  parameter Modelica.SIunits.HeatCapacity CEva
    "Heat capacity of Evaporator (= cp*m)"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator",
      enable=use_evaCap));
  parameter Modelica.SIunits.ThermalConductance GEva
    "Constant thermal conductance of Evaporator material"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator",
      enable=use_evaCap));
  parameter Modelica.SIunits.HeatCapacity CCon
    "Heat capacity of Condenser (= cp*m)"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser",
      enable=use_conCap));
  parameter Modelica.SIunits.ThermalConductance GCon
    "Constant thermal conductance of condenser material"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser",
      enable=use_conCap));
//HP Control
  parameter Boolean use_antLeg=false
    "True if Anti-Legionella control is considered"
    annotation (Dialog(tab="HP Control", group="Anti Legionella", descriptionLabel = true),choices(checkBox=true));
  parameter Boolean use_bivPar=true
    "Switch between bivalent parallel and bivalent alternative control"
    annotation (Dialog(group="System"),choices(choice=true "Parallel",
      choice=false "Alternativ",
      radioButtons=true));
  parameter Real hys=5 "Hysteresis of controller"
    annotation (Dialog(tab="HP Control", group="Control"));
//Security Control
  parameter Boolean use_sec=true
    "False if the Security block should be disabled"
                                     annotation (choices(checkBox=true), Dialog(
        tab="Security Control", group="General", descriptionLabel = true));

  parameter Boolean use_minRunTime=false
    "False if minimal runtime of HP is not considered"
    annotation (Dialog(enable=use_sec, tab="Security Control", group="On-/Off Control", descriptionLabel = true), choices(checkBox=true));
  parameter Modelica.SIunits.Time minRunTime=12000
    "Minimum runtime of heat pump"
    annotation (Dialog(tab="Security Control", group="On-/Off Control",
      enable=use_sec and use_minRunTime));
  parameter Boolean use_minLocTime=false
    "False if minimal locktime of HP is not considered"
    annotation (Dialog(tab="Security Control", group="On-/Off Control", descriptionLabel = true, enable=use_sec), choices(checkBox=true));
  parameter Modelica.SIunits.Time minLocTime=600
    "Minimum lock time of heat pump"
    annotation (Dialog(tab="Security Control", group="On-/Off Control",
      enable=use_sec and use_minLocTime));
  parameter Boolean use_runPerHou=false
    "False if maximal runs per hour of HP are not considered"
    annotation (Dialog(tab="Security Control", group="On-/Off Control", descriptionLabel = true, enable=use_sec), choices(checkBox=true));
  parameter Real maxRunPerHou=5
                              "Maximal number of on/off cycles in one hour"
    annotation (Dialog(tab="Security Control", group="On-/Off Control",
      enable=use_sec and use_runPerHou));
  parameter Boolean pre_n_start=false
                                     "Start value of pre(n) at initial time"
    annotation (Dialog(
      tab="Security Control",
      group="On-/Off Control",
      enable=use_sec), choices(checkBox=true));
  parameter Boolean use_opeEnv=true
    "False to allow HP to run out of operational envelope"
    annotation (Dialog(tab="Security Control", group="Operational Envelope",
      enable=use_sec, descriptionLabel = true),choices(checkBox=true));
  parameter Real tableUpp[:,2] "Upper boundary of envelope" annotation (Dialog(
      tab="Security Control",
      group="Operational Envelope",
      enable=use_sec and use_opeEnv));
  parameter Real tableLow[:,2] "Lower boundary of envelope" annotation (Dialog(
      tab="Security Control",
      group="Operational Envelope",
      enable=use_sec and use_opeEnv));
  parameter Boolean use_deFro=true "False if defrost in not considered"
                                    annotation (choices(checkBox=true), Dialog(
        tab="Security Control",group="Defrost", descriptionLabel = true, enable=use_sec));
  parameter Real minIceFac "Minimal value above which no defrost is necessary"
    annotation (Dialog(
      tab="Security Control",
      group="Defrost",
      enable=use_sec and use_deFro));
  parameter Boolean use_chiller=false
    "True if ice is defrost operates by changing mode to cooling. False to use an electrical heater"
    annotation (Dialog(
      tab="Security Control",
      group="Defrost",
      enable=use_sec and use_deFro), choices(checkBox=true));
  parameter Modelica.SIunits.Power calcPel_deFro
    "Calculate how much eletrical energy is used to melt ice. Insert a formular"
    annotation (Dialog(
      tab="Security Control",
      group="Defrost",
      enable=use_sec and use_deFro and use_chiller));
  parameter Boolean use_antFre=false
    "True if anti freeze control is part of security control" annotation (
      Dialog(
      tab="Security Control",
      group="Anti Freeze Control",
      enable=use_sec),choices(checkBox=true));
  parameter Modelica.SIunits.ThermodynamicTemperature TantFre=276.15
    "Limit temperature for anti freeze control" annotation (Dialog(
      tab="Security Control",
      group="Anti Freeze Control",
      enable=use_sec and use_antFre));
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
    annotation (Dialog(tab="Initialization", group="System inertia", enable=use_refIne));
  parameter Real yRefIne_start=0 "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Initialization", group="System inertia",enable=initType ==
          Init.InitialOutput and use_refIne));

//Dynamics
  parameter Modelica.Fluid.Types.Dynamics massDynamics
    "Type of mass balance: dynamic (3 initialization options) or steady state"
    annotation (Dialog(tab="Dynamics", group="Equation"));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Dialog(tab="Dynamics", group="Equation"));
  parameter Real mSenFacCon=1
    "Factor for scaling the sensible thermal mass of the volume in the condenser"
    annotation (Dialog(tab="Dynamics",group="Condenser"));
  parameter Real mSenFacEva=1
    "Factor for scaling the sensible thermal mass of the volume in the evaporator"
    annotation (Dialog(tab="Dynamics", group="Evaporator"));
//Assumptions
  parameter Boolean allowFlowReversalEva=false
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Dialog(tab="Assumptions", group="Evaporator"),            choices(checkBox=true));
  parameter Boolean allowFlowReversalCon=false
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Dialog(tab="Assumptions", group="Condenser"),           choices(checkBox=true));
  parameter Boolean addPowerToMediumEva=true
    "Set to false to avoid any power (=heat and flow work) being added to medium (may give simpler equations)"
    annotation (Dialog(tab="Assumptions", group="Evaporator",
      enable=use_evaPum), choices(checkBox=true));
  parameter Boolean addPowerToMediumCon=true
    "Set to false to avoid any power (=heat and flow work) being added to medium (may give simpler equations)"
    annotation (Dialog(tab="Assumptions", group="Condenser",
      enable=use_conPum), choices(checkBox=true));
  parameter Modelica.SIunits.Time tauSenT=1
    "Time constant at nominal flow rate (use tau=0 for steady-state sensor, but see user guide for potential problems)"
    annotation (Dialog(tab="Assumptions", group="Temperature sensors"));
  parameter Boolean transferHeat=true
    "If true, temperature T converges towards TAmb when no flow"
    annotation (Dialog(tab="Assumptions", group="Temperature sensors"));
  parameter Modelica.SIunits.Time tauHeaTra=1200
    "Time constant for heat transfer in temperature sensors, default 20 minutes"
    annotation (Dialog(
      tab="Assumptions",
      group="Temperature sensors",
      enable=transferHeat));
  parameter Modelica.SIunits.Temperature TAmbCon_nom=291.15
    "Fixed ambient temperature for heat transfer of sensors at the condenser side"
    annotation (Dialog(
      tab="Assumptions",
      group="Condenser",
      enable=transferHeat));
  parameter Modelica.SIunits.Temperature TAmbEva_nom=273.15
    "Fixed ambient temperature for heat transfer of sensors at the evaporator side"
    annotation (Dialog(
      tab="Assumptions",
      group="Evaporator",
      enable=transferHeat));
  Modelica.Blocks.Sources.Constant const(final k=273.15 + 18)
    annotation (Placement(transformation(extent={{86,-8},{66,12}})));
  Controls.Interfaces.HeatPumpControlBus
                           sigBusHP
    annotation (Placement(transformation(extent={{-108,-84},{-78,-50}}),
        iconTransformation(extent={{-96,-76},{-78,-50}})));
equation
  connect(heatPump.sigBusHP, securityControl.sigBusHP) annotation (Line(
      points={{-23.75,-11.75},{-44,-11.75},{-44,-50},{-114,-50},{-114,-19.35},{-103.875,
          -19.35}},
      color={255,204,51},
      thickness=0.5));
  connect(T_oda,hPControls.T_oda)  annotation (Line(points={{-135,79},{-114,79},
          {-114,32.6222},{-105.4,32.6222}},
                                     color={0,0,127}));
  connect(pumSin.port_b, heatPump.port_a1)
    annotation (Line(points={{-20,48},{-20,36},{-24,36},{-24,13}},
                                                 color={0,127,255},
      pattern=LinePattern.Dash));
  connect(pumSin.port_a, port_a1)
    annotation (Line(points={{-20,64},{-20,102},{-60,102},{-60,120}},
                                                color={0,127,255},
      pattern=LinePattern.Dash));

  connect(port_a2, pumSou.port_a)
    annotation (Line(points={{60,-120},{60,-98},{26,-98},{26,-68}},
                                                    color={0,127,255},
      pattern=LinePattern.Dash));
  connect(pumSou.port_b, heatPump.port_a2)
    annotation (Line(points={{26,-52},{26,-17}},     color={0,127,255},
      pattern=LinePattern.Dash));
  connect(heatPump.sigBusHP, hPControls.sigBusHP) annotation (Line(
      points={{-23.75,-11.75},{-44,-11.75},{-44,-50},{-114,-50},{-114,24.5333},
          {-102.34,24.5333}},
      color={255,204,51},
      thickness=0.5));
  connect(realPasThrSec.y, heatPump.nSet) annotation (Line(
      points={{-77.3,-37},{-56,-37},{-56,3},{-28,3}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(securityControl.nOut, heatPump.nSet) annotation (Line(
      points={{-70.75,-6},{-56,-6},{-56,3},{-28,3}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(port_a1, mediumPassThroughSin.port_a) annotation (Line(
      points={{-60,120},{-60,102},{-20,102},{-20,74},{-50,74},{-50,62}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(mediumPassThroughSin.port_b, heatPump.port_a1) annotation (Line(
      points={{-50,50},{-50,36},{-24,36},{-24,13}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(mediumPassThroughSou.port_a, port_a2) annotation (Line(
      points={{50,-64},{50,-80},{26,-80},{26,-98},{60,-98},{60,-120}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(mediumPassThroughSou.port_b, heatPump.port_a2) annotation (Line(
      points={{50,-52},{50,-40},{26,-40},{26,-17}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(hPControls.nOut, securityControl.nSet) annotation (Line(
      points={{-65.62,36.6667},{-68,36.6667},{-68,12},{-108,12},{-108,-6},{-104,
          -6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(hPControls.nOut, realPasThrSec.u) annotation (Line(
      points={{-65.62,36.6667},{-68,36.6667},{-68,12},{-108,12},{-108,-37},{
          -93.4,-37}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(heatPump.port_b1, secHeaGen.port_a) annotation (Line(
      points={{26,13},{26,30},{32,30},{32,52}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(heatPump.port_b1, mediumPassThroughSecHeaGen.port_a) annotation (Line(
      points={{26,13},{26,30},{64,30},{64,56}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(port_b1, senTSup.port_b)
    annotation (Line(points={{60,120},{60,114},{32,114},{32,106}},
                                                  color={0,127,255}));
  connect(secHeaGen.port_b, senTSup.port_a) annotation (Line(
      points={{32,76},{32,90}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(mediumPassThroughSecHeaGen.port_b, senTSup.port_a) annotation (Line(
      points={{64,68},{64,90},{32,90}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(senTSup.T, hPControls.TSup) annotation (Line(points={{23.2,98},{-110,
          98},{-110,42},{-106,42},{-106,41.9556},{-105.4,41.9556}},
                              color={0,0,127}));
  connect(heatPump.port_b2, port_b2) annotation (Line(points={{-24,-17},{-24,-98},
          {-60,-98},{-60,-120}}, color={0,127,255}));
  connect(hPControls.modeOut, securityControl.modeSet) annotation (Line(points={{-65.62,
          30.4444},{-68,30.4444},{-68,12},{-110,12},{-110,-12},{-104,-12}},
                                                                         color={
          255,0,255}));
  connect(securityControl.modeOut, heatPump.modeSet) annotation (Line(points={{-70.75,
          -12},{-54,-12},{-54,-7},{-28,-7}}, color={255,0,255}));
  connect(calcQHeat.y, calcCOP.QHeat[1]) annotation (Line(points={{80.9,-27},{88,
          -27},{88,-25.8},{89.8,-25.8}},          color={0,0,127}));
  connect(pumSou.P, calcCOP.Pel[2]) annotation (Line(points={{18.8,-51.2},{18.8,
          -36.85},{89.8,-36.85}}, color={0,0,127}));
  connect(pumSin.P, calcCOP.Pel[3]) annotation (Line(points={{-27.2,47.2},{-27.2,38},
          {52,38},{52,-35.55},{89.8,-35.55}},     color={0,0,127}));
  connect(icingBlock.iceFac, heatPump.iceFac_in) annotation (Line(
      points={{-61.5,-69},{-18,-69},{-18,-36}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(constIceFacOne.y, heatPump.iceFac_in) annotation (Line(
      points={{-61.5,-83},{-18,-83},{-18,-36}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(const.y, heatPump.T_amb_con) annotation (Line(points={{65,2},{48,2},{48,
          23},{28.5,23}}, color={0,0,127}));
  connect(const.y, heatPump.T_amb_eva) annotation (Line(points={{65,2},{48,2},{48,
          -27},{28.5,-27}}, color={0,0,127}));
  connect(hPControls.y_sou, pumSou.y) annotation (Line(points={{-95.2,51.2889},
          {-95.2,66},{-60,66},{-60,-60},{16.4,-60}},color={0,0,127}));
  connect(hPControls.ySecHeaGen, secHeaGen.u) annotation (Line(points={{-85,
          50.6667},{-85,80},{2,80},{2,40},{39.2,40},{39.2,49.6}},
                                                         color={0,0,127}));
  connect(secHeaGen.Q_flow, calcCOP.Pel[4]) annotation (Line(points={{39.2,77.2},
          {39.2,84},{54,84},{54,-34.25},{89.8,-34.25}}, color={0,0,127}));
  connect(hPControls.y_sin, pumSin.y) annotation (Line(points={{-74.8,51.2889},
          {-74.8,56},{-29.6,56}},
                           color={0,0,127}));
  connect(heatPump.sigBusHP, sigBusHP) annotation (Line(
      points={{-23.75,-11.75},{-34,-11.75},{-34,-12},{-44,-12},{-44,-50},{-94,-50},{-94,
          -67},{-93,-67}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.Pel, calcCOP.Pel[1]) annotation (Line(
      points={{-92.925,-66.915},{-86,-66.915},{-86,-104},{78,-104},{78,-38.15},{89.8,
          -38.15}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-120},
            {120,120}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-120,-120},{120,120}})));
end HeatPumpSystem;
