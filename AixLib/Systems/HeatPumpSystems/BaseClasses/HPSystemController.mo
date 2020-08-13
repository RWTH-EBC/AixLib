within AixLib.Systems.HeatPumpSystems.BaseClasses;
model HPSystemController
  "Model including both security and HP controller"
  parameter Boolean use_secHeaGen=true "True if a bivalent setup is required" annotation(choices(checkBox=true), Dialog(
        group="System"));

//HeatPump Control
  replaceable model TSetToNSet = Controls.HeatPump.BaseClasses.OnOffHP
    constrainedby AixLib.Controls.HeatPump.BaseClasses.PartialTSetToNSet annotation (Dialog(tab="Heat Pump Control", group="Controller"),choicesAllMatching=true);

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
  parameter Boolean weekly=true
    "Switch between a daily or weekly trigger approach" annotation(Dialog(
      tab="Heat Pump Control",
      group="Anti Legionella",
      enable=use_antLeg,descriptionLabel=true), choices(choice=true "Weekly",
      choice=false "Daily",
      radioButtons=true));
  parameter Integer trigWeekDay=5
    "Day of the week at which control is triggered" annotation (Dialog(
      tab="Heat Pump Control",
      group="Anti Legionella",
      enable=use_antLeg and weekly));
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
  parameter Modelica.SIunits.Time minRunTime=300
    "Minimum runtime of heat pump"
    annotation (Dialog(tab="Security Control", group="On-/Off Control",
      enable=use_sec and use_minRunTime), Evaluate=false);
  parameter Boolean use_minLocTime=false
    "False if minimal locktime of HP is not considered"
    annotation (Dialog(tab="Security Control", group="On-/Off Control", descriptionLabel = true, enable=use_sec), choices(checkBox=true));
  parameter Modelica.SIunits.Time minLocTime=300
    "Minimum lock time of heat pump"
    annotation (Dialog(tab="Security Control", group="On-/Off Control",
      enable=use_sec and use_minLocTime), Evaluate=false);
  parameter Boolean use_runPerHou=false
    "False if maximal runs per hour of HP are not considered"
    annotation (Dialog(tab="Security Control", group="On-/Off Control", descriptionLabel = true, enable=use_sec), choices(checkBox=true));
  parameter Integer maxRunPerHou=3
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
    "Use a the operational envelope given in the datasheet" annotation(Dialog(tab="Security Control", group="Operational Envelope"),choices(checkBox=true));
  parameter DataBase.HeatPump.HeatPumpBaseDataDefinition
    dataTable "Data Table of HP" annotation (choicesAllMatching=true, Dialog(
      tab="Security Control",
      group="Operational Envelope",
      enable=use_opeEnvFroRec));
  parameter Real tableUpp[:,2] "Table matrix (grid = first column; e.g., table=[0,2])"
    annotation (Dialog(tab="Security Control", group="Operational Envelope", enable=not use_opeEnvFroRec));
  parameter Boolean use_deFro=true "False if defrost in not considered"
                                    annotation (choices(checkBox=true), Dialog(
        tab="Security Control",group="Defrost", descriptionLabel = true, enable=use_sec));
  parameter Real minIceFac "Minimal value above which no defrost is necessary"
    annotation (Dialog(
      tab="Security Control",
      group="Defrost",
      enable=use_sec and use_deFro));
  parameter Real deltaIceFac = 0.1 "Bandwitdth for hystereses. If the icing factor is based on the duration of defrost, this value is necessary to avoid state-events."
  annotation (Dialog(
      tab="Security Control",
      group="Defrost",
      enable=use_sec and use_deFro));
  parameter Boolean use_chiller=false
    "True if defrost operates by changing mode to cooling. False to use an electrical heater"
    annotation (Dialog(
      tab="Security Control",
      group="Defrost",
      enable=use_sec and use_deFro), choices(checkBox=true));
  parameter Modelica.SIunits.Power calcPel_deFro
    "Calculate how much eletrical energy is used to melt ice"
    annotation (Dialog(
      tab="Security Control",
      group="Defrost",
      enable=use_sec and use_deFro and not use_chiller));
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
    final deltaIceFac=deltaIceFac,
    final use_chiller=use_chiller,
    final calcPel_deFro=calcPel_deFro,
    final use_antFre=use_antFre,
    final TantFre=TantFre,
    final tableUpp=tableUpp,
    final use_opeEnvFroRec=use_opeEnvFroRec,
    final dataTable=dataTable) if         use_sec
    annotation (Placement(transformation(extent={{8,-16},{48,24}})));
  Controls.HeatPump.HPControl hPControls(
    final use_antLeg=use_antLeg,
    final use_secHeaGen=use_secHeaGen,
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
  AixLib.DataBase.HeatPump.PerformanceData.calcCOP calcCOP(
      final lowBouPel=200)
    annotation (Placement(transformation(extent={{-46,64},{-20,92}})));
  Utilities.HeatTransfer.CalcQFlow       calcQHeat(final cp=cp_con)
    "Calculates the heat flow added to the source medium"
    annotation (Placement(transformation(extent={{-80,82},{-64,98}})));
  Modelica.Blocks.Routing.RealPassThrough realPasThrSec if not use_sec
                                                                      "No 1. Layer"
    annotation (Placement(transformation(extent={{20,34},{34,48}})));
  Modelica.Blocks.Interfaces.RealInput T_oda "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-128,-14},{-100,14}})));
  Controls.Interfaces.ThermalMachineControlBus
                           sigBusHP
    annotation (Placement(transformation(extent={{-116,-76},{-84,-42}}),
        iconTransformation(extent={{-116,-78},{-82,-40}})));
  Modelica.Blocks.Interfaces.RealInput TSup "Supply temperature of HP system"
    annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-114,40})));
  Modelica.Blocks.Interfaces.RealOutput y_sin annotation (Placement(transformation(
        extent={{14,-14},{-14,14}},
        rotation=90,
        origin={60,-114}), iconTransformation(
        extent={{14,-14},{-14,14}},
        rotation=90,
        origin={60,-114})));
  Modelica.Blocks.Interfaces.RealOutput ySecHeaGen if use_secHeaGen
                                                   "Relative power of second heat generator, from 0 to 1"
    annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=-90,
        origin={0,-114}), iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=-90,
        origin={0,-114})));
  Modelica.Blocks.Interfaces.RealOutput y_sou
    annotation (Placement(transformation(extent={{14,-14},{-14,14}},
        rotation=90,
        origin={-60,-114}), iconTransformation(
        extent={{14,-14},{-14,14}},
        rotation=90,
        origin={-60,-114})));
  Modelica.Blocks.Math.MultiSum multiSum(k=fill(1, if not use_chiller and use_deFro then 2 else 1), nu=if not use_chiller and use_deFro then 2 else 1)
    annotation (Placement(transformation(extent={{-78,64},{-66,76}})));
  AixLib.DataBase.HeatPump.PerformanceData.IcingBlock
    icingBlock(redeclare final function iceFunc =
        DataBase.HeatPump.Functions.IcingFactor.BasicIcingApproach) if
       use_deFro
    annotation (Placement(transformation(extent={{44,76},{62,94}})));
  Modelica.Blocks.Sources.Constant const(final k=1) if not use_deFro
    annotation (Placement(transformation(extent={{44,56},{60,72}})));

  Modelica.Blocks.Routing.BooleanPassThrough booleanPassThroughMode if not
    use_sec "Pass through for mode signal"
    annotation (Placement(transformation(extent={{22,-38},{34,-26}})));

  parameter Modelica.SIunits.SpecificHeatCapacity cp_con=4180
    "specific heat capacity of condenser medium";
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
          0},{5.33333,0}},                                               color={255,0,
          255},
      pattern=LinePattern.Dash));
  connect(sigBusHP,hPControls. sigBusHP) annotation (Line(
      points={{-100,-59},{-80,-59},{-80,-7.6},{-68.38,-7.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP,securityControl. sigBusHP) annotation (Line(
      points={{-100,-59},{-14,-59},{-14,-9.8},{5.5,-9.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TSup, hPControls.TSup) annotation (Line(points={{-114,40},{-80,40},{
          -80,14.8},{-71.8,14.8}},
                               color={0,0,127}));
  connect(y_sou, y_sou)
    annotation (Line(points={{-60,-114},{-60,-114}}, color={0,0,127}));
  connect(hPControls.ySecHeaGen, ySecHeaGen) annotation (Line(points={{-49.76,
          -16.8},{-49.76,-44},{1.77636e-15,-44},{1.77636e-15,-114}},
                                            color={0,0,127}));
  connect(hPControls.y_sin, y_sin) annotation (Line(points={{-38.36,-16},{-38,
          -16},{-38,-40},{60,-40},{60,-114}},
                                         color={0,0,127}));
  connect(hPControls.y_sou, y_sou) annotation (Line(points={{-61.16,-16},{-60,
          -16},{-60,-114}},                           color={0,0,127}));
  connect(multiSum.y, calcCOP.Pel) annotation (Line(points={{-64.98,70},{-56,70},
          {-56,72},{-48,72},{-48,72.4},{-48.6,72.4}},
                                 color={0,0,127}));
  connect(securityControl.Pel_deFro, multiSum.u[2]) annotation (Line(
      points={{49.6667,20},{54,20},{54,26},{-80,26},{-80,70},{-78,70}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sigBusHP.Pel, multiSum.u[1]) annotation (Line(
      points={{-99.92,-58.915},{-78,-58.915},{-78,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(calcCOP.y_COP, sigBusHP.CoP) annotation (Line(points={{-18.7,78},{-14,
          78},{-14,-58.915},{-99.92,-58.915}},   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sigBusHP.T_oda, icingBlock.T_oda) annotation (Line(
      points={{-99.92,-58.915},{-14,-58.915},{-14,74},{28,74},{28,90.4},{43.28,
          90.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.T_flow_ev, icingBlock.T_flow_ev) annotation (Line(
      points={{-99.92,-58.915},{-14,-58.915},{-14,74},{28,74},{28,86.8},{43.28,
          86.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.T_ret_ev, icingBlock.T_ret_ev) annotation (Line(
      points={{-99.92,-58.915},{-14,-58.915},{-14,74},{28,74},{28,83.2},{43.28,
          83.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.m_flow_ev, icingBlock.m_flow_ev) annotation (Line(
      points={{-99.92,-58.915},{-14,-58.915},{-14,74},{28,74},{28,79.6},{43.28,
          79.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(hPControls.modeOut, booleanPassThroughMode.u) annotation (Line(
      points={{-27.34,0},{-10,0},{-10,-32},{20.8,-32}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(calcQHeat.Q_flow, calcCOP.QHeat) annotation (Line(points={{-63.2,90},
          {-56,90},{-56,83.6},{-48.6,83.6}}, color={0,0,127}));
  connect(sigBusHP.m_flow_co, calcQHeat.m_flow) annotation (Line(
      points={{-99.92,-58.915},{-94,-58.915},{-94,94.8},{-81.6,94.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.T_ret_co, calcQHeat.T_a) annotation (Line(
      points={{-99.92,-58.915},{-94,-58.915},{-94,89.2},{-81.6,89.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.T_flow_co, calcQHeat.T_b) annotation (Line(
      points={{-99.92,-58.915},{-94,-58.915},{-94,84.4},{-81.6,84.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(securityControl.modeOut, sigBusHP.mode) annotation (Line(
      points={{49.6667,0},{64,0},{64,-58.915},{-99.92,-58.915}},
      color={255,0,255},
      pattern=LinePattern.Dash), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanPassThroughMode.y, sigBusHP.mode) annotation (Line(
      points={{34.6,-32},{64,-32},{64,-58.915},{-99.92,-58.915}},
      color={255,0,255},
      pattern=LinePattern.Dash), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(securityControl.nOut,sigBusHP.n)  annotation (Line(
      points={{49.6667,8},{90,8},{90,-58.915},{-99.92,-58.915}},
      color={0,0,127},
      pattern=LinePattern.Dash), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realPasThrSec.y,sigBusHP.n)  annotation (Line(
      points={{34.7,41},{90,41},{90,-58.915},{-99.92,-58.915}},
      color={0,0,127},
      pattern=LinePattern.Dash), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(icingBlock.iceFac, sigBusHP.iceFac) annotation (Line(
      points={{62.9,85},{120,85},{120,-58.915},{-99.92,-58.915}},
      color={0,0,127},
      pattern=LinePattern.Dash), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const.y, sigBusHP.iceFac) annotation (Line(
      points={{60.8,64},{120,64},{120,-58.915},{-99.92,-58.915}},
      color={0,0,127},
      pattern=LinePattern.Dash), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
                            Text(
          extent={{-100,26},{100,-18}},
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
          textString="Icing Factor")}),
    Documentation(revisions="<html><ul>
  <li>
    <i>October 31, 2018&#160;</i> by Alexander Kümpel:<br/>
    Connection between controller and heat pump only via bus connector
  </li>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  This system controller aggregates the heat pump controller and
  relevant security controls from <a href=
  \"modelica://AixLib.Controls.HeatPump\">AixLib.Controls.HeatPump</a> to
  control the heat pump based on an ambient temperature and the current
  supply temperature.
</p>
<p>
  Further, the COP is calculated. The icing factor used for air-source
  heat pumps is added to simulate defrost cycles.
</p>
</html>"));
end HPSystemController;
