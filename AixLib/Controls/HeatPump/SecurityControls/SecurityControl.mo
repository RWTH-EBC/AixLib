within AixLib.Controls.HeatPump.SecurityControls;
block SecurityControl "Block including all security levels"
  extends BaseClasses.PartialSecurityControl;
  Modelica.Blocks.Sources.BooleanConstant conTru(final k=true)
    "Always true as the two blocks OperationalEnvelope and OnOffControl deal with whether the nSet value is correct or not"
    annotation (Placement(transformation(extent={{58,-6},{70,6}})));
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
  parameter Real tableLow[:,2] "Lower boundary of envelope"
    annotation (Dialog(group="Operational Envelope", enable=use_opeEnv));
  parameter Real tableUpp[:,2] "Upper boundary of envelope"
    annotation (Dialog(group="Operational Envelope", enable=use_opeEnv));
  OperationalEnvelope operationalEnvelope(
    final use_opeEnv=use_opeEnv,
    final tableLow=tableLow,
    final tableUpp=tableUpp)
    annotation (Placement(transformation(extent={{-10,-10},{14,12}})));
  OnOffControl onOffController(
    final minRunTime=minRunTime,
    final minLocTime=minLocTime,
    use_minRunTime=use_minRunTime,
    use_minLocTime=use_minLocTime,
    use_runPerHou=use_runPerHou,
    maxRunPerHou=maxRunPerHou,
    pre_n_start=pre_n_start)
    annotation (Placement(transformation(extent={{-62,-16},{-26,20}})));

  parameter Boolean pre_n_start=true "Start value of pre(n) at initial time"
    annotation (Dialog(group="OnOffControl", descriptionLabel=true),choices(checkBox=true));
  DefrostControl defrostControl(
    final minIceFac=minIceFac,
    use_chiller=use_chiller,
    calcPel_deFro=calcPel_deFro) if use_deFro
    annotation (Placement(transformation(extent={{-110,-14},{-74,16}})));
  Modelica.Blocks.Routing.RealPassThrough realPasThrDef if not use_deFro
    "No 2. Layer"
    annotation (Placement(transformation(extent={{-92,32},{-76,48}})),
      choicesAllMatching=true);
  parameter Boolean use_deFro
    "True if defrost control should be enabled(only air-source HPs)"
    annotation (Dialog(group="Defrost"), choices(checkBox=true));
  parameter Real minIceFac "Minimal value above which no defrost is necessary"
    annotation (Dialog(group="Defrost", enable=use_deFro));
  Modelica.Blocks.Routing.BooleanPassThrough boolPasThrDef if
                                                           not use_deFro
    "No 2. Layer" annotation (Placement(transformation(extent={{-92,-50},{-76,
            -34}})), choicesAllMatching=true);
  parameter Boolean use_chiller=true
    "True if ice is defrost operates by changing mode to cooling. False to use an electrical heater"
    annotation (Dialog(group="Defrost", enable=use_deFro),
                                        choices(checkBox=true));
  parameter Modelica.SIunits.Power calcPel_deFro
    "Calculate how much eletrical energy is used to melt ice"
    annotation (Dialog(enable=use_chiller and use_deFro, group="Defrost"));
  Modelica.Blocks.Interfaces.RealOutput Pel_deFro if not use_chiller and
    use_deFro
    "Relative speed of compressor. From 0 to 1" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={130,80})));
  AntiFreeze antiFreeze(final TantFre=TantFre, final use_antFre=use_antFre)
    annotation (Placement(transformation(extent={{24,-8},{48,12}})));
  parameter Boolean use_antFre=true
    "True if anti freeze control is part of security control"
    annotation (Dialog(group="Anti Freeze Control"), choices(checkBox=true));
  parameter Modelica.SIunits.ThermodynamicTemperature TantFre=276.15
    "Limit temperature for anti freeze control"
    annotation (Dialog(group="Anti Freeze Control", enable=use_antFre));

equation
  connect(conTru.y,swiErr.u2)
    annotation (Line(points={{70.6,0},{84,0}}, color={255,0,255}));
  connect(onOffController.nOut, operationalEnvelope.nSet) annotation (Line(
        points={{-24.5,3.63636},{-24,3.63636},{-24,4},{-11.6,4}},         color=
         {0,0,127}));

  connect(sigBusHP, onOffController.sigBusHP) annotation (Line(
      points={{-135,-69},{-64.25,-69},{-64.25,-7.65455}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP, operationalEnvelope.sigBusHP) annotation (Line(
      points={{-135,-69},{-11.5,-69},{-11.5,-4.9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP, defrostControl.sigBusHP) annotation (Line(
      points={{-135,-69},{-111.08,-69},{-111.08,-7.66667}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(nSet, defrostControl.nSet) annotation (Line(
      points={{-136,20},{-124,20},{-124,6},{-112.88,6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(nSet, realPasThrDef.u) annotation (Line(
      points={{-136,20},{-116,20},{-116,40},{-93.6,40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(realPasThrDef.y, onOffController.nSet) annotation (Line(
      points={{-75.2,40},{-60,40},{-60,3.63636},{-64.4,3.63636}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(modeSet, defrostControl.modeSet) annotation (Line(
      points={{-136,-20},{-120,-20},{-120,-0.666667},{-112.88,-0.666667}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(defrostControl.nOut, onOffController.nSet) annotation (Line(
      points={{-72.2,6},{-72.2,3.63636},{-64.4,3.63636}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(defrostControl.modeOut, operationalEnvelope.modeSet) annotation (
      Line(
      points={{-72.2,-0.666667},{-68,-0.666667},{-68,-32},{-22,-32},{-22,0},{-11.6,
          0}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(modeSet, boolPasThrDef.u) annotation (Line(
      points={{-136,-20},{-120,-20},{-120,-42},{-93.6,-42}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(boolPasThrDef.y, operationalEnvelope.modeSet) annotation (Line(
      points={{-75.2,-42},{-22,-42},{-22,0},{-11.6,0}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(defrostControl.Pel_deFro, Pel_deFro) annotation (Line(
      points={{-92,21},{-92,28},{-54,28},{-54,80},{130,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(antiFreeze.nSet, operationalEnvelope.nOut)
    annotation (Line(points={{22.4,4},{15,4}}, color={0,0,127}));
  connect(antiFreeze.modeSet, operationalEnvelope.modeOut)
    annotation (Line(points={{22.4,0},{15,0}}, color={255,0,255}));
  connect(antiFreeze.nOut, swiErr.u1) annotation (Line(points={{49,4},{54,4},{54,
          18},{76,18},{76,8},{84,8}}, color={0,0,127}));
  connect(antiFreeze.modeOut, modeOut) annotation (Line(points={{49,0},{52,0},{52,
          -36},{100,-36},{100,-20},{130,-20}}, color={255,0,255}));
end SecurityControl;
