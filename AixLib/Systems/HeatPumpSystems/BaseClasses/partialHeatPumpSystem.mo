within AixLib.Systems.HeatPumpSystems.BaseClasses;
partial model partialHeatPumpSystem
  "Partial model containing the basic heat pump block and different control blocks(optional)"
    extends AixLib.Fluid.Interfaces.PartialFourPortInterface(
    redeclare final package Medium1 = Medium_con,
    final m1_flow_nominal=mFlow_conNominal,
    final m2_flow_nominal=mFlow_evaNominal,
    final allowFlowReversal1=allowFlowReversalCon,
    final allowFlowReversal2=allowFlowReversalEva,
    final m1_flow_small=1E-4*abs(mFlow_conNominal),
    final m2_flow_small=1E-4*abs(mFlow_evaNominal),
    final show_T=false,
    redeclare package Medium2 = Medium_eva);
  import Modelica.Blocks.Types.Init;
//General
  replaceable package Medium_con = Modelica.Media.Interfaces.PartialMedium "Medium at sink side"
    annotation (Dialog(group="Sink"),choicesAllMatching=true);
  replaceable package Medium_eva = Modelica.Media.Interfaces.PartialMedium "Medium at source side"
    annotation (Dialog(group="Source"), choicesAllMatching=true);
  parameter Modelica.SIunits.MassFlowRate mFlow_conNominal
    "Nominal mass flow rate, used for regularization near zero flow"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.MassFlowRate mFlow_evaNominal
    "Nominal mass flow rate"
    annotation (Dialog(group="Nominal condition"));
  parameter Boolean use_secHeaGen=true "True if a bivalent setup is required" annotation(choices(checkBox=true), Dialog(
        group="System"));

  replaceable model secHeatGen = AixLib.Fluid.HeatExchangers.HeaterCooler_u                                                                                   annotation(Dialog(group="System", enable=
          use_secHeaGen), choicesAllMatching=true);
  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal
    "Nominal heat flow rate of second heat generator. Used to calculate input singal y."
    annotation (Dialog(group="System", enable=use_secHeaGen));
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


//HP Control
  replaceable model TSetToNSet = Controls.HeatPump.BaseClasses.OnOffHP
    constrainedby Controls.HeatPump.BaseClasses.OnOffHP annotation (Dialog(tab="HP Control"),choicesAllMatching=true);
  parameter Boolean use_antLeg=false
    "True if Anti-Legionella control is considered"
    annotation (Dialog(tab="HP Control", group="Anti Legionella", descriptionLabel = true),choices(checkBox=true));
  parameter Boolean use_bivPar=true
    "Switch between bivalent parallel and bivalent alternative control"
    annotation (Dialog(group="System",enable=use_secHeaGen),choices(choice=true "Parallel",
      choice=false "Alternativ",
      radioButtons=true));

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
  parameter Boolean use_opeEnvFroRec=true
    "Use a the operational envelope given in the datasheet" annotation (Dialog(
      tab="Security Control",
      group="Operational Envelope",
      enable=use_sec and use_opeEnv,
      descriptionLabel=true),choices(checkBox=true));
  parameter DataBase.HeatPump.HeatPumpBaseDataDefinition dataTable
    "Data Table of HP" annotation (Dialog(
      tab="Security Control",
      group="Operational Envelope",
      enable=use_sec and use_opeEnv and use_opeEnvFroRec),choicesAllMatching=true);
  parameter Real tableUpp[:,2] "Upper boundary of envelope" annotation (Dialog(
      tab="Security Control",
      group="Operational Envelope",
      enable=use_sec and use_opeEnv and not use_opeEnvFroRec));
  parameter Real tableLow[:,2] "Lower boundary of envelope" annotation (Dialog(
      tab="Security Control",
      group="Operational Envelope",
      enable=use_sec and use_opeEnv and not use_opeEnvFroRec));
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

  replaceable Fluid.Interfaces.PartialFourPortInterface heatPump constrainedby
    Fluid.Interfaces.PartialFourPortInterface annotation (Placement(
        transformation(extent={{-26,-24},{18,20}})),
      __Dymola_choicesAllMatching=true);
  Controls.HeatPump.SecurityControls.SecurityControl securityControl(
    final use_minRunTime=use_minRunTime,
    final minRunTime(displayUnit="min") = minRunTime,
    final minLocTime(displayUnit="min") = minLocTime,
    final use_runPerHou=use_runPerHou,
    final maxRunPerHou=maxRunPerHou,
    final use_opeEnv=use_opeEnv,
    final use_minLocTime=use_minLocTime,
    pre_n_start=pre_n_start,
    final use_deFro=use_deFro,
    final minIceFac=minIceFac,
    final use_chiller=use_chiller,
    final calcPel_deFro=calcPel_deFro,
    final use_antFre=use_antFre,
    final TantFre=TantFre,
    final tableLow=tableLow,
    final tableUpp=tableUpp,
    final use_opeEnvFroRec=use_opeEnvFroRec,
    final dataTable=dataTable) if         use_sec
    annotation (Placement(transformation(extent={{16,120},{56,158}})));
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
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-70,40})));
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
        extent={{8,8},{-8,-8}},
        rotation=0,
        origin={60,-42})));
  Controls.HeatPump.HPControl hPControls(
    final use_antLeg=use_antLeg,
    use_bivPar=use_bivPar,
    use_secHeaGen=use_secHeaGen,
    Q_flow_nominal=Q_flow_nominal,
    redeclare model TSetToNSet = TSetToNSet)
             annotation (Placement(transformation(extent={{-68,120},{-30,154}})));

  Fluid.HeatPumps.BaseClasses.PerformanceData.calcCOP calcCOP(
    final lowBouPel=200)
    annotation (Placement(transformation(extent={{66,170},{92,198}})));

  Modelica.Blocks.Interfaces.RealInput T_oda "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-130,140},{-100,170}})));
  Modelica.Blocks.Sources.RealExpression calcQHeat
    annotation (Placement(transformation(extent={{28,180},{52,198}})));
  Modelica.Blocks.Routing.RealPassThrough realPasThrSec if not use_sec
                                                                      "No 1. Layer"
    annotation (Placement(transformation(extent={{-10,160},{4,174}})));
  Fluid.Interfaces.PassThroughMedium mediumPassThroughSin(
    final allowFlowReversal=allowFlowReversalEva,
    final m_flow_small=1E-4*abs(mFlow_evaNominal),
    final show_T=false,
    final m_flow_nominal=mFlow_conNominal,
    redeclare final package Medium = Medium_con) if
                                              not use_conPum
                                                            annotation (
      Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-70,12})));
  Fluid.Interfaces.PassThroughMedium mediumPassThroughSou(
    final allowFlowReversal=allowFlowReversalCon,
    final m_flow_small=1E-4*abs(mFlow_conNominal),
    final show_T=false,
    final m_flow_nominal=mFlow_evaNominal,
    redeclare final package Medium = Medium_eva) if
                                              not use_evaPum
                                                            annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={58,-16})));
 secHeatGen secHeaGen(redeclare final package Medium = Medium_con,
    final allowFlowReversal=allowFlowReversalCon,
    final m_flow_nominal=mFlow_conNominal,
    final dp_nominal=0,
    final m_flow_small=1E-4*abs(mFlow_conNominal),
    final Q_flow_nominal=Q_flow_nominal) if
                             use_secHeaGen annotation (Placement(transformation(
        extent={{8,9},{-8,-9}},
        rotation=180,
        origin={36,43})));

  Fluid.Interfaces.PassThroughMedium mediumPassThroughSecHeaGen(
    final allowFlowReversal=allowFlowReversalEva,
    final m_flow_small=1E-4*abs(mFlow_evaNominal),
    final show_T=false,
    final m_flow_nominal=mFlow_conNominal,
    redeclare final package Medium = Medium_con) if
                                              not use_secHeaGen
    "Used if monovalent HP System" annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={50,12})));
  Fluid.Sensors.TemperatureTwoPort
                             senTSup(
    final transferHeat=true,
    redeclare final package Medium = Medium_con,
    final allowFlowReversal=allowFlowReversalCon,
    final m_flow_nominal=mFlow_conNominal,
    final tauHeaTra=tauHeaTra,
    final m_flow_small=1E-4*mFlow_conNominal,
    final initType=initType,
    final T_start=TCon_start,
    TAmb=291.15)       "Supply temperature"
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={78,44})));

  Controls.Interfaces.HeatPumpControlBus
                           sigBusHP
    annotation (Placement(transformation(extent={{-120,96},{-90,130}}),
        iconTransformation(extent={{-108,104},{-90,130}})));

  Modelica.Blocks.Sources.RealExpression calcPel_total(y=0.0)
    "Real expression to calculate total power consumption"
    annotation (Placement(transformation(extent={{28,168},{52,186}})));

equation
  connect(T_oda,hPControls.T_oda)  annotation (Line(points={{-115,155},{-92,155},
          {-92,137.756},{-71.8,137.756}},
                                     color={0,0,127}));
  connect(pumSin.port_b, heatPump.port_a1) annotation (Line(
      points={{-62,40},{-62,11.2},{-26,11.2}},
      color={0,127,255},
      pattern=LinePattern.Dash));

  connect(pumSou.port_b, heatPump.port_a2) annotation (Line(
      points={{52,-42},{30,-42},{30,-15.2},{18,-15.2}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(mediumPassThroughSin.port_b, heatPump.port_a1) annotation (Line(
      points={{-64,12},{-26,12},{-26,11.2}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(mediumPassThroughSou.port_b, heatPump.port_a2) annotation (Line(
      points={{52,-16},{18,-16},{18,-15.2}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(hPControls.nOut, securityControl.nSet) annotation (Line(
      points={{-27.34,142.667},{-10,142.667},{-10,142.8},{13.3333,142.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(hPControls.nOut, realPasThrSec.u) annotation (Line(
      points={{-27.34,142.667},{-24,142.667},{-24,167},{-11.4,167}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(heatPump.port_b1, secHeaGen.port_a) annotation (Line(
      points={{18,11.2},{18,44},{28,44},{28,43}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(heatPump.port_b1, mediumPassThroughSecHeaGen.port_a) annotation (Line(
      points={{18,11.2},{18,12},{44,12}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(secHeaGen.port_b, senTSup.port_a) annotation (Line(
      points={{44,43},{44,44},{70,44}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(mediumPassThroughSecHeaGen.port_b, senTSup.port_a) annotation (Line(
      points={{56,12},{64,12},{64,44},{70,44}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(hPControls.modeOut, securityControl.modeSet) annotation (Line(points={{-27.34,
          135.111},{-24,135.111},{-24,135.2},{13.3333,135.2}},           color={
          255,0,255}));
  connect(hPControls.y_sou, pumSou.y) annotation (Line(points={{-61.16,120},{-60,
          120},{-60,102},{-50,102},{-50,-64},{60,-64},{60,-51.6}},
                                                    color={0,0,127}));
  connect(hPControls.ySecHeaGen, secHeaGen.u) annotation (Line(points={{-49.76,
          119.244},{-49.76,56},{-50,56},{-50,48.4},{26.4,48.4}},
                                                         color={0,0,127}));
  connect(sigBusHP, hPControls.sigBusHP) annotation (Line(
      points={{-105,113},{-80,113},{-80,127.933},{-68.38,127.933}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP, securityControl.sigBusHP) annotation (Line(
      points={{-105,113},{-14,113},{-14,125.89},{13.5,125.89}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatPump.port_b2, port_b2) annotation (Line(points={{-26,-15.2},{-60,-15.2},
          {-60,-60},{-100,-60}}, color={0,127,255}));
  connect(pumSou.port_a, port_a2) annotation (Line(
      points={{68,-42},{86,-42},{86,-16},{100,-16},{100,-60}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(mediumPassThroughSou.port_a, port_a2) annotation (Line(
      points={{64,-16},{100,-16},{100,-60}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(senTSup.port_b, port_b1)
    annotation (Line(points={{86,44},{86,60},{100,60}}, color={0,127,255}));
  connect(port_a1, pumSin.port_a) annotation (Line(
      points={{-100,60},{-100,40},{-78,40}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(mediumPassThroughSin.port_a, port_a1) annotation (Line(
      points={{-76,12},{-100,12},{-100,60}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(senTSup.T, hPControls.TSup) annotation (Line(points={{78,52.8},{78,88},
          {-130,88},{-130,176},{-84,176},{-84,149.089},{-71.8,149.089}},
                                                   color={0,0,127}));
  connect(calcPel_total.y, calcCOP.Pel) annotation (Line(points={{53.2,177},{57.6,
          177},{57.6,178.4},{63.4,178.4}},color={0,0,127}));
  connect(calcQHeat.y, calcCOP.QHeat) annotation (Line(points={{53.2,189},{57.6,
          189},{57.6,189.6},{63.4,189.6}}, color={0,0,127}));
  connect(hPControls.y_sin, pumSin.y) annotation (Line(points={{-38.36,120},{-38,
          120},{-38,102},{-48,102},{-48,56},{-70,56},{-70,49.6}}, color={0,0,127}));
  connect(port_b1, port_b1) annotation (Line(points={{100,60},{104,60},{104,60},
          {100,60}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,200}}), graphics={
        Rectangle(
          extent={{-17,50},{17,-50}},
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          origin={-4,61},
          rotation=90),
        Line(
          points={{9,40},{-9,40},{5,-2},{-9,-40},{9,-40}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={-5,56},
          rotation=-90),
        Rectangle(
          extent={{-54,42},{46,-44}},
          lineColor={238,46,47},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-14,50},{14,-50}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          origin={-4,-62},
          rotation=90),
        Line(
          points={{-9,40},{9,40},{-5,-2},{9,-40},{-9,-40}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={-3,-60},
          rotation=-90),
        Line(points={{-88,60},{88,60}}, color={28,108,200}),
        Line(points={{-88,-60},{88,-60}}, color={28,108,200}),
        Ellipse(
          extent={{82,-44},{50,-74}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible= use_evaPum),
        Line(
          points={{52,-52},{74,-46}},
          color={0,0,127},
          visible=use_evaPum),
        Line(
          points={{52,-66},{74,-72}},
          color={0,0,127},
          visible=use_evaPum),
        Ellipse(
          extent={{-88,74},{-56,44}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=use_conPum),
        Line(
          points={{-58,66},{-80,72}},
          color={0,0,127},
          visible=use_conPum),
        Line(
          points={{-58,52},{-80,46}},
          color={0,0,127},
          visible=use_conPum),
        Rectangle(
          extent={{52,74},{82,46}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=use_secHeaGen),
        Text(
          extent={{44,66},{92,56}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="Heater"),                      Rectangle(
          extent={{-100,200},{100,140}},
          lineColor={135,135,135},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Text(
          extent={{-84,184},{-38,160}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="Control"),
        Text(
          extent={{-14,190},{50,152}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="Security",
          visible=use_sec),
        Rectangle(
          extent={{-16,190},{52,152}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          visible=use_sec),
        Rectangle(
          extent={{-94,190},{-26,152}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.None)}),
                          Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,200}}), graphics={Rectangle(
          extent={{-100,200},{100,80}},
          lineColor={135,135,135},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          lineThickness=1), Text(
          extent={{-16,192},{18,200}},
          lineColor={135,135,135},
          lineThickness=1,
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Controls")}));
end partialHeatPumpSystem;
