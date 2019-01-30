within AixLib.Systems.HeatPumpSystems.BaseClasses;
partial model PartialHeatPumpSystem
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

  replaceable model SecHeatGen = AixLib.Fluid.HeatExchangers.HeaterCooler_u                                                                                   annotation(Dialog(group="System", enable=
          use_secHeaGen), choicesAllMatching=true);
  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal
    "Nominal heat flow rate of second heat generator. Used to calculate input singal y."
    annotation (Dialog(group="System", enable=use_secHeaGen), Evaluate=false);
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

//HeatPump Control
  replaceable model TSetToNSet = Controls.HeatPump.BaseClasses.OnOffHP
    constrainedby Controls.HeatPump.BaseClasses.OnOffHP annotation (Dialog(tab="Heat Pump Control"),choicesAllMatching=true);
  parameter Boolean use_bivPar=true
    "Switch between bivalent parallel and bivalent alternative control"
    annotation (Dialog(group="System",enable=use_secHeaGen),choices(choice=true "Parallel",
      choice=false "Alternativ",
      radioButtons=true));
  parameter Boolean use_tableData=true
    "Choose between tables or function to calculate TSet"
    annotation (Dialog(tab="Heat Pump Control", group="Heating Curve"),choices(
      choice=true "Table Data",
      choice=false "Function",
      radioButtons=true));
  replaceable function HeatingCurveFunction =
      Controls.SetPoints.Functions.HeatingCurveFunction annotation (Dialog(tab="Heat Pump Control", group="Heating Curve", enable=not use_tableData),choicesAllMatching=true);

  parameter
    DataBase.Boiler.DayNightMode.HeatingCurvesDayNightBaseDataDefinition
    heatingCurveRecord=
      AixLib.DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day25_Night10()
         "Record with information about heating curve data"
    annotation (Dialog(tab="Heat Pump Control", group="Heating Curve", enable=use_tableData),choicesAllMatching=true);
  parameter Real declination=2 "Declination of heating curve"
    annotation (Dialog(tab="Heat Pump Control", group="Heating Curve", enable=use_tableData));
  parameter Real day_hour=6 "Hour of day at which day mode is enabled"
    annotation (Dialog(tab="Heat Pump Control", group="Heating Curve"));
  parameter Real night_hour=22 "Hour of day at which night mode is enabled"
    annotation (Dialog(tab="Heat Pump Control", group="Heating Curve"));
  parameter AixLib.Utilities.Time.Types.ZeroTime zerTim=AixLib.Utilities.Time.Types.ZeroTime.NY2017
    "Enumeration for choosing how reference time (time = 0) should be defined. Used for heating curve and antilegionella"
    annotation (Dialog(tab="Heat Pump Control", group="Heating Curve"));
  parameter Boolean use_antLeg=true
    "True if Anti-Legionella control is considered"
    annotation (Dialog(tab="Heat Pump Control", group="Anti Legionella", descriptionLabel = true),choices(checkBox=true));
  parameter Modelica.SIunits.ThermodynamicTemperature TLegMin=333.15
    "Temperature at which the legionella in DWH dies" annotation (Dialog(
      tab="Heat Pump Control",
      group="Anti Legionella",
      enable=use_antLeg), Evaluate=false);
  parameter Modelica.SIunits.Time minTimeAntLeg
    "Minimal duration of antilegionella control" annotation (Dialog(
      tab="Heat Pump Control",
      group="Anti Legionella",
      enable=use_antLeg));
  parameter Integer trigWeekDay=5
    "Day of the week at which control is triggered" annotation (Dialog(
      tab="Heat Pump Control",
      group="Anti Legionella",
      enable=use_antLeg));
  parameter Integer trigHour=3 "Hour of the day at which control is triggered"
    annotation (Dialog(
      tab="Heat Pump Control",
      group="Anti Legionella",
      enable=use_antLeg));
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
      enable=use_sec and use_minRunTime), Evaluate=false);
  parameter Boolean use_minLocTime=false
    "False if minimal locktime of HP is not considered"
    annotation (Dialog(tab="Security Control", group="On-/Off Control", descriptionLabel = true, enable=use_sec), choices(checkBox=true));
  parameter Modelica.SIunits.Time minLocTime=600
    "Minimum lock time of heat pump"
    annotation (Dialog(tab="Security Control", group="On-/Off Control",
      enable=use_sec and use_minLocTime), Evaluate=false);
  parameter Boolean use_runPerHou=false
    "False if maximal runs per hour of HP are not considered"
    annotation (Dialog(tab="Security Control", group="On-/Off Control", descriptionLabel = true, enable=use_sec), choices(checkBox=true));
  parameter Real maxRunPerHou=5
                              "Maximal number of on/off cycles in one hour"
    annotation (Dialog(tab="Security Control", group="On-/Off Control",
      enable=use_sec and use_runPerHou), Evaluate=false);
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
  parameter Modelica.SIunits.Temperature TAmbCon_nominal=291.15
    "Fixed ambient temperature for heat transfer of sensors at the condenser side"
    annotation (Dialog(
      tab="Assumptions",
      group="Condenser",
      enable=transferHeat), Evaluate=false);
  parameter Modelica.SIunits.Temperature TAmbEva_nominal=273.15
    "Fixed ambient temperature for heat transfer of sensors at the evaporator side"
    annotation (Dialog(
      tab="Assumptions",
      group="Evaporator",
      enable=transferHeat), Evaluate=false);

  replaceable Fluid.Interfaces.PartialFourPortInterface heatPump constrainedby
    Fluid.Interfaces.PartialFourPortInterface annotation (Placement(
        transformation(extent={{-26,-24},{18,20}})),
      __Dymola_choicesAllMatching=true);
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

  Modelica.Blocks.Interfaces.RealInput T_oda(unit="K")
    "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-130,104},{-100,134}})));
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
        origin={60,-16})));
 SecHeatGen secHeaGen(redeclare final package Medium = Medium_con,
    final allowFlowReversal=allowFlowReversalCon,
    final m_flow_nominal=mFlow_conNominal,
    final dp_nominal=0,
    final m_flow_small=1E-4*abs(mFlow_conNominal),
    final Q_flow_nominal=Q_flow_nominal) if
                             use_secHeaGen annotation (Placement(transformation(
        extent={{8,9},{-8,-9}},
        rotation=180,
        origin={40,61})));

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
        origin={38,34})));

  HPSystemController hPSystemController(
    final use_secHeaGen=use_secHeaGen,
    final Q_flow_nominal=Q_flow_nominal,
    final use_bivPar=use_bivPar,
    final heatingCurveRecord=heatingCurveRecord,
    final declination=declination,
    final day_hour=day_hour,
    final night_hour=night_hour,
    final zerTim=zerTim,
    final use_antLeg=use_antLeg,
    final TLegMin=TLegMin,
    final minTimeAntLeg=minTimeAntLeg,
    final trigWeekDay=trigWeekDay,
    final trigHour=trigHour,
    redeclare final model TSetToNSet = TSetToNSet,
    final use_tableData=use_tableData,
    redeclare final function HeatingCurveFunction = HeatingCurveFunction,
    final use_sec=use_sec,
    final use_minRunTime=use_minRunTime,
    final minRunTime=minRunTime,
    final use_minLocTime=use_minLocTime,
    final pre_n_start=pre_n_start,
    final use_opeEnv=use_opeEnv,
    final use_opeEnvFroRec=use_opeEnvFroRec,
    final dataTable=dataTable,
    final tableUpp=tableUpp,
    final tableLow=tableLow,
    final use_deFro=use_deFro,
    final minIceFac=minIceFac,
    final use_chiller=use_chiller,
    final calcPel_deFro=calcPel_deFro,
    final use_antFre=use_antFre,
    final TantFre=TantFre,
    final use_runPerHou=use_runPerHou,
    final maxRunPerHou=5)
    annotation (Placement(transformation(extent={{-50,98},{48,168}})));
  Modelica.Blocks.Interfaces.RealInput TAct(unit="K") "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-130,146},{-100,176}})));
equation
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
      points={{54,-16},{18,-16},{18,-15.2}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(heatPump.port_b1, secHeaGen.port_a) annotation (Line(
      points={{18,11.2},{18,60},{32,60},{32,61}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(heatPump.port_b1, mediumPassThroughSecHeaGen.port_a) annotation (Line(
      points={{18,11.2},{18,34},{32,34}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(heatPump.port_b2, port_b2) annotation (Line(points={{-26,-15.2},{-60,
          -15.2},{-60,-60},{-100,-60}},
                                 color={0,127,255}));
  connect(pumSou.port_a, port_a2) annotation (Line(
      points={{68,-42},{86,-42},{86,-16},{100,-16},{100,-60}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(mediumPassThroughSou.port_a, port_a2) annotation (Line(
      points={{66,-16},{100,-16},{100,-60}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(port_a1, pumSin.port_a) annotation (Line(
      points={{-100,60},{-100,40},{-78,40}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(mediumPassThroughSin.port_a, port_a1) annotation (Line(
      points={{-76,12},{-100,12},{-100,60}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(port_b1, port_b1) annotation (Line(points={{100,60},{104,60},{104,60},
          {100,60}}, color={0,127,255}));
  connect(T_oda, hPSystemController.T_oda) annotation (Line(points={{-115,119},
          {-90,119},{-90,133},{-56.86,133}},color={0,0,127}));
  connect(hPSystemController.y_sou, pumSin.y) annotation (Line(points={{-40.2,93.1},
          {-40.2,66},{-70,66},{-70,49.6}}, color={0,0,127}));
  connect(hPSystemController.ySecHeaGen, secHeaGen.u) annotation (Line(points={{
          18.6,93.1},{18.6,66.4},{30.4,66.4}}, color={0,0,127}));
  connect(hPSystemController.y_sin, pumSou.y) annotation (Line(points={{38.2,93.1},
          {38.2,76},{58,76},{58,-2},{36,-2},{36,-66},{60,-66},{60,-51.6}},
        color={0,0,127}));
  connect(secHeaGen.port_b, port_b1) annotation (Line(
      points={{48,61},{82,61},{82,60},{100,60}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(mediumPassThroughSecHeaGen.port_b, port_b1) annotation (Line(
      points={{44,34},{82,34},{82,60},{100,60}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(TAct, hPSystemController.TSup) annotation (Line(points={{-115,161},{
          -88.5,161},{-88.5,147},{-56.86,147}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,180}}), graphics={
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
          extent={{-100,186},{100,138}},
          lineColor={135,135,135},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Text(
          extent={{-84,176},{-38,152}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="Control"),
        Text(
          extent={{-12,180},{48,146}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="Security",
          visible=use_sec),
        Rectangle(
          extent={{-16,182},{52,144}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          visible=use_sec),
        Rectangle(
          extent={{-94,182},{-26,144}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.None)}),
                          Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,180}})));
end PartialHeatPumpSystem;
