within AixLib.Controls.HeatPump.SecurityControls;
block SecurityControl "Block including all security levels"
  extends BaseClasses.PartialSecurityControl;

  parameter Boolean use_minRunTime=true
    "False if minimal runtime of HP is not considered"
    annotation (Dialog(group="OnOffControl"), choices(checkBox=true));
  parameter Modelica.SIunits.Time minRunTime "Mimimum runtime of heat pump"
    annotation (Dialog(group="OnOffControl",enable=use_minRunTime));
  parameter Boolean use_minLocTime=true
    "False if minimal locktime of HP is not considered"
    annotation (Dialog(group="OnOffControl"), choices(checkBox=true));
  parameter Modelica.SIunits.Time minLocTime "Minimum lock time of heat pump"
    annotation (Dialog(group="OnOffControl",enable=use_minLocTime));
  parameter Boolean use_runPerHou=true
    "False if maximal runs per hour HP are not considered"
    annotation (Dialog(group="OnOffControl"), choices(checkBox=true));
  parameter Real maxRunPerHou "Maximal number of on/off cycles in one hour"
    annotation (Dialog(group="OnOffControl",enable=use_runPerHou));
  parameter Boolean use_opeEnv=true
    "False to allow HP to run out of operational envelope"
    annotation (Dialog(group="Operational Envelope"), choices(checkBox=true));
  parameter Boolean use_opeEnvFroRec=true
    "Use a the operational envelope given in the datasheet"
    annotation (Dialog(group="Operational Envelope", enable=use_opeEnv),choices(checkBox=true));
  parameter DataBase.HeatPump.HeatPumpBaseDataDefinition dataTable
    "Data Table of HP" annotation (Dialog(group="Operational Envelope", enable=
          use_opeEnv and use_opeEnvFroRec),choicesAllMatching=true);
  parameter Real tableLow[:,2] "Lower boundary of envelope"
    annotation (Dialog(group="Operational Envelope", enable=use_opeEnv and not use_opeEnvFroRec));
  parameter Real tableUpp[:,2] "Upper boundary of envelope"
    annotation (Dialog(group="Operational Envelope", enable=use_opeEnv and not use_opeEnvFroRec));
  parameter Boolean pre_n_start=true "Start value of pre(n) at initial time"
    annotation (Dialog(group="OnOffControl", descriptionLabel=true),choices(checkBox=true));
  parameter Boolean use_deFro
    "True if defrost control should be enabled(only air-source HPs)"
    annotation (Dialog(group="Defrost"), choices(checkBox=true));
  parameter Real minIceFac "Minimal value above which no defrost is necessary"
    annotation (Dialog(group="Defrost", enable=use_deFro));
  parameter Boolean use_chiller=true
    "True if ice is defrost operates by changing mode to cooling. False to use an electrical heater"
    annotation (Dialog(group="Defrost", enable=use_deFro),
                                        choices(checkBox=true));
  parameter Modelica.SIunits.Power calcPel_deFro
    "Calculate how much eletrical energy is used to melt ice"
    annotation (Dialog(enable=use_chiller and use_deFro, group="Defrost"));
  parameter Boolean use_antFre=true
    "True if anti freeze control is part of security control"
    annotation (Dialog(group="Anti Freeze Control"), choices(checkBox=true));
  parameter Modelica.SIunits.ThermodynamicTemperature TantFre=276.15
    "Limit temperature for anti freeze control"
    annotation (Dialog(group="Anti Freeze Control", enable=use_antFre));

  OperationalEnvelope operationalEnvelope(
    final use_opeEnv=use_opeEnv,
    final tableLow=tableLow,
    final tableUpp=tableUpp,
    final use_opeEnvFroRec=use_opeEnvFroRec,
    final dataTable=dataTable)
    annotation (Placement(transformation(extent={{-10,-10},{14,12}})));
  OnOffControl onOffController(
    final minRunTime=minRunTime,
    final minLocTime=minLocTime,
    use_minRunTime=use_minRunTime,
    use_minLocTime=use_minLocTime,
    use_runPerHou=use_runPerHou,
    maxRunPerHou=maxRunPerHou,
    pre_n_start=pre_n_start)
    annotation (Placement(transformation(extent={{-62,-18},{-26,18}})));

  DefrostControl defrostControl(
    final minIceFac=minIceFac,
    use_chiller=use_chiller,
    calcPel_deFro=calcPel_deFro) if use_deFro
    annotation (Placement(transformation(extent={{-112,-16},{-76,14}})));
  Modelica.Blocks.Routing.RealPassThrough realPasThrDef if not use_deFro
    "No 2. Layer"
    annotation (Placement(transformation(extent={{-92,32},{-76,48}})),
      choicesAllMatching=true);
  Modelica.Blocks.Sources.BooleanConstant conTru(final k=true)
    "Always true as the two blocks OperationalEnvelope and OnOffControl deal with whether the nSet value is correct or not"
    annotation (Placement(transformation(extent={{58,-6},{70,6}})));
  Modelica.Blocks.Interfaces.RealOutput Pel_deFro if not use_chiller and
    use_deFro
    "Relative speed of compressor. From 0 to 1" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={130,80})));
  AntiFreeze antiFreeze(final TAntFre=TantFre, final use_antFre=use_antFre)
    annotation (Placement(transformation(extent={{24,-8},{48,12}})));
  Modelica.Blocks.Routing.BooleanPassThrough boolPasThrDef if
                                                           not use_deFro
    "No 2. Layer" annotation (Placement(transformation(extent={{-92,-50},{-76,
            -34}})), choicesAllMatching=true);
  Modelica.Blocks.Interfaces.IntegerOutput ERR_opeEnv if
                                                     use_opeEnv annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-110})));
  Modelica.Blocks.Interfaces.IntegerOutput ERR_antFre if
                                                     use_antFre annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={100,-110})));
equation
  connect(conTru.y,swiErr.u2)
    annotation (Line(points={{70.6,0},{84,0}}, color={255,0,255}));
  connect(onOffController.nOut, operationalEnvelope.nSet) annotation (Line(
        points={{-24.5,1.63636},{-24,1.63636},{-24,3.2},{-11.6,3.2}},     color=
         {0,0,127}));

  connect(sigBusHP, onOffController.sigBusHP) annotation (Line(
      points={{-135,-69},{-64.25,-69},{-64.25,-9.65455}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP, operationalEnvelope.sigBusHP) annotation (Line(
      points={{-135,-69},{-11.5,-69},{-11.5,-6.59}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP, defrostControl.sigBusHP) annotation (Line(
      points={{-135,-69},{-113.08,-69},{-113.08,-9.66667}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(nSet, defrostControl.nSet) annotation (Line(
      points={{-136,20},{-124,20},{-124,4},{-114.88,4}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(nSet, realPasThrDef.u) annotation (Line(
      points={{-136,20},{-116,20},{-116,40},{-93.6,40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(realPasThrDef.y, onOffController.nSet) annotation (Line(
      points={{-75.2,40},{-60,40},{-60,1.63636},{-64.4,1.63636}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(modeSet, defrostControl.modeSet) annotation (Line(
      points={{-136,-20},{-120,-20},{-120,-2.66667},{-114.88,-2.66667}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(defrostControl.nOut, onOffController.nSet) annotation (Line(
      points={{-74.2,4},{-74.2,1.63636},{-64.4,1.63636}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(defrostControl.modeOut, operationalEnvelope.modeSet) annotation (
      Line(
      points={{-74.2,-2.66667},{-68,-2.66667},{-68,-32},{-22,-32},{-22,-1.2},{
          -11.6,-1.2}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(modeSet, boolPasThrDef.u) annotation (Line(
      points={{-136,-20},{-120,-20},{-120,-42},{-93.6,-42}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(boolPasThrDef.y, operationalEnvelope.modeSet) annotation (Line(
      points={{-75.2,-42},{-22,-42},{-22,-1.2},{-11.6,-1.2}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(defrostControl.Pel_deFro, Pel_deFro) annotation (Line(
      points={{-94,19},{-94,28},{-54,28},{-54,80},{130,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(antiFreeze.nSet, operationalEnvelope.nOut)
    annotation (Line(points={{22.4,4},{18,4},{18,3.2},{15,3.2}},
                                               color={0,0,127}));
  connect(antiFreeze.modeSet, operationalEnvelope.modeOut)
    annotation (Line(points={{22.4,0},{18,0},{18,-1.2},{15,-1.2}},
                                               color={255,0,255}));
  connect(antiFreeze.nOut, swiErr.u1) annotation (Line(points={{49,4},{54,4},{54,
          18},{76,18},{76,8},{84,8}}, color={0,0,127}));
  connect(antiFreeze.modeOut, modeOut) annotation (Line(points={{49,0},{52,0},{52,
          -36},{100,-36},{100,-20},{130,-20}}, color={255,0,255}));
  connect(sigBusHP, antiFreeze.sigBusHP) annotation (Line(
      points={{-135,-69},{18,-69},{18,-4.9},{22.5,-4.9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(conTru.y, not1.u) annotation (Line(points={{70.6,0},{76,0},{76,-54},{
          -21,-54},{-21,-63}}, color={255,0,255}));
  connect(antiFreeze.ERR, ERR_antFre) annotation (Line(points={{36,-9},{36,-50},
          {100,-50},{100,-110}}, color={255,127,0}));
  connect(operationalEnvelope.ERR, ERR_opeEnv) annotation (Line(points={{2,-11.1},
          {2,-50},{60,-50},{60,-110}}, color={255,127,0}));
end SecurityControl;
