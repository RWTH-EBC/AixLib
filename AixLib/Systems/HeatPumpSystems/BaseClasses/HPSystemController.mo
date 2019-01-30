within AixLib.Systems.HeatPumpSystems.BaseClasses;
model HPSystemController
  "Model including both security and HP controller"
  parameter Boolean use_secHeaGen=true "True if a bivalent setup is required" annotation(choices(checkBox=true), Dialog(
        group="System"));
  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal
    "Nominal heat flow rate of second heat generator. Used to calculate input singal y."
    annotation (Dialog(group="System", enable=use_secHeaGen), Evaluate=false);
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
  parameter Boolean use_runPerHou=use_runPerHou
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
    annotation (Placement(transformation(extent={{8,-16},{48,24}})));
  Controls.HeatPump.HPControl hPControls(
    final use_antLeg=use_antLeg,
    final use_bivPar=use_bivPar,
    final use_secHeaGen=use_secHeaGen,
    final Q_flow_nominal=Q_flow_nominal,
    redeclare final model TSetToNSet = TSetToNSet,
    final heatingCurveRecord=heatingCurveRecord,
    final declination=declination,
    final day_hour=day_hour,
    final night_hour=night_hour,
    final zerTim=zerTim,
    final TLegMin=TLegMin,
    final minTimeAntLeg=minTimeAntLeg,
    final trigWeekDay=trigWeekDay,
    final trigHour=trigHour,
    final use_tableData=use_tableData,
    redeclare final function HeatingCurveFunction = HeatingCurveFunction)
             annotation (Placement(transformation(extent={{-68,-16},{-30,20}})));
  Fluid.HeatPumps.BaseClasses.PerformanceData.calcCOP calcCOP(final lowBouPel=200) if
    use_calcCOP
    annotation (Placement(transformation(extent={{-46,64},{-20,92}})));
  Modelica.Blocks.Sources.RealExpression calcQHeat(y=sigBusHP.m_flow_co*(TSup
         - sigBusHP.T_flow_co)*4180) if use_calcCOP
    "Calculates the heat flow added to the source medium"
    annotation (Placement(transformation(extent={{-90,78},{-66,96}})));
  Modelica.Blocks.Routing.RealPassThrough realPasThrSec if not use_sec
                                                                      "No 1. Layer"
    annotation (Placement(transformation(extent={{20,34},{34,48}})));
  Modelica.Blocks.Interfaces.RealInput T_oda "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-128,-14},{-100,14}})));
  Controls.Interfaces.HeatPumpControlBus
                           sigBusHP
    annotation (Placement(transformation(extent={{-122,-70},{-92,-36}}),
        iconTransformation(extent={{-110,-62},{-92,-36}})));
  Modelica.Blocks.Interfaces.RealInput TSup "Supply temperature of HP system"
    annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-114,40})));
  Modelica.Blocks.Interfaces.RealOutput nOut
    annotation (Placement(transformation(extent={{-14,-14},{14,14}},
        rotation=270,
        origin={0,-114})));
  Modelica.Blocks.Interfaces.BooleanOutput modeOut
    annotation (Placement(transformation(extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-40,-114})));
  Modelica.Blocks.Interfaces.RealOutput y_sin annotation (Placement(transformation(
        extent={{14,-14},{-14,14}},
        rotation=90,
        origin={80,-114})));
  Modelica.Blocks.Interfaces.RealOutput ySecHeaGen if use_secHeaGen
                                                   "Relative power of second heat generator, from 0 to 1"
    annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=-90,
        origin={40,-114})));
  Modelica.Blocks.Interfaces.RealOutput y_sou
    annotation (Placement(transformation(extent={{14,-14},{-14,14}},
        rotation=90,
        origin={-80,-114})));
  Modelica.Blocks.Math.MultiSum multiSum(k={1}, nu=1) if use_calcCOP
    annotation (Placement(transformation(extent={{-78,64},{-66,76}})));
  Fluid.HeatPumps.BaseClasses.PerformanceData.IcingBlock icingBlock(redeclare
      final function iceFunc =
        Fluid.HeatPumps.BaseClasses.Functions.IcingFactor.BasicIcingApproach)
    if use_deFro
    annotation (Placement(transformation(extent={{44,76},{62,94}})));
  Modelica.Blocks.Interfaces.RealOutput iceFac_out
    "Output value of icing factor" annotation (Placement(transformation(
        extent={{14,-14},{-14,14}},
        rotation=180,
        origin={114,80})));
  Modelica.Blocks.Sources.Constant const(final k=1) if not use_deFro
    annotation (Placement(transformation(extent={{44,56},{60,72}})));
  parameter Boolean use_calcCOP=true
    "Only relevant for Carnot system simulation";
equation
  connect(T_oda,hPControls.T_oda)  annotation (Line(points={{-114,1.77636e-15},
          {-92,1.77636e-15},{-92,2.8},{-71.8,2.8}},
                                     color={0,0,127}));
  connect(hPControls.nOut,securityControl. nSet) annotation (Line(
      points={{-27.34,8},{5.33333,8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(hPControls.nOut,realPasThrSec. u) annotation (Line(
      points={{-27.34,8},{-10,8},{-10,41},{18.6,41}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(hPControls.modeOut,securityControl. modeSet) annotation (Line(points={{-27.34,
          0},{5.33333,0}},                                               color={
          255,0,255}));
  connect(sigBusHP,hPControls. sigBusHP) annotation (Line(
      points={{-107,-53},{-80,-53},{-80,-7.6},{-68.38,-7.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP,securityControl. sigBusHP) annotation (Line(
      points={{-107,-53},{-14,-53},{-14,-9.8},{5.5,-9.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(calcQHeat.y,calcCOP. QHeat) annotation (Line(points={{-64.8,87},{
          -54.4,87},{-54.4,83.6},{-48.6,83.6}},
                                           color={0,0,127}));
  connect(TSup, hPControls.TSup) annotation (Line(points={{-114,40},{-80,40},{
          -80,14.8},{-71.8,14.8}},
                               color={0,0,127}));
  connect(y_sou, y_sou)
    annotation (Line(points={{-80,-114},{-80,-114}}, color={0,0,127}));
  connect(realPasThrSec.y, nOut) annotation (Line(
      points={{34.7,41},{76,41},{76,-58},{1.77636e-15,-58},{1.77636e-15,-114}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(securityControl.nOut, nOut) annotation (Line(
      points={{49.6667,8},{76,8},{76,-58},{1.77636e-15,-58},{1.77636e-15,-114}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(securityControl.modeOut, modeOut) annotation (Line(points={{49.6667,0},
          {62,0},{62,-58},{-40,-58},{-40,-114}}, color={255,0,255}));
  connect(hPControls.ySecHeaGen, ySecHeaGen) annotation (Line(points={{-49.76,
          -16.8},{-49.76,-44},{40,-44},{40,-114}},
                                            color={0,0,127}));
  connect(hPControls.y_sin, y_sin) annotation (Line(points={{-38.36,-16},{-38,-16},
          {-38,-40},{80,-40},{80,-114}}, color={0,0,127}));
  connect(hPControls.y_sou, y_sou) annotation (Line(points={{-61.16,-16},{-62,
          -16},{-62,-58},{-80,-58},{-80,-114}},       color={0,0,127}));
  connect(multiSum.y, calcCOP.Pel) annotation (Line(points={{-64.98,70},{-48,70},
          {-48,72.4},{-48.6,72.4}},
                                 color={0,0,127}));
  connect(securityControl.Pel_deFro, multiSum.u[1]) annotation (Line(
      points={{49.6667,20},{54,20},{54,26},{-80,26},{-80,70},{-78,70}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sigBusHP.Pel, multiSum.u[1]) annotation (Line(
      points={{-106.925,-52.915},{-78,-52.915},{-78,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(calcCOP.y_COP, sigBusHP.CoP) annotation (Line(points={{-18.7,78},{-14,
          78},{-14,-52.915},{-106.925,-52.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(icingBlock.iceFac, iceFac_out) annotation (Line(
      points={{62.9,85},{76,85},{76,80},{114,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(const.y, iceFac_out) annotation (Line(
      points={{60.8,64},{76,64},{76,80},{114,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sigBusHP.T_oda, icingBlock.T_oda) annotation (Line(
      points={{-106.925,-52.915},{-14,-52.915},{-14,74},{28,74},{28,90.4},{
          43.28,90.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.T_flow_ev, icingBlock.T_flow_ev) annotation (Line(
      points={{-106.925,-52.915},{-14,-52.915},{-14,74},{28,74},{28,86.8},{
          43.28,86.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.T_ret_ev, icingBlock.T_ret_ev) annotation (Line(
      points={{-106.925,-52.915},{-14,-52.915},{-14,74},{28,74},{28,83.2},{
          43.28,83.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.m_flow_ev, icingBlock.m_flow_ev) annotation (Line(
      points={{-106.925,-52.915},{-14,-52.915},{-14,74},{28,74},{28,79.6},{
          43.28,79.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                     Rectangle(
          extent={{100,100},{-100,-100}},
          lineColor={135,135,135},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          lineThickness=1), Text(
          extent={{-100,28},{100,-16}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
                            Text(
          extent={{-16,92},{18,100}},
          lineColor={135,135,135},
          lineThickness=1,
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Controls"),                    Rectangle(
          extent={{34,100},{100,54}},
          lineColor={135,135,135},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Text(
          extent={{64,108},{98,82}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Icing Factor")}));
end HPSystemController;
