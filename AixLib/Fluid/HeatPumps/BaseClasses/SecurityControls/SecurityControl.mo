within AixLib.Fluid.HeatPumps.BaseClasses.SecurityControls;
block SecurityControl "Block including all security levels"
  extends BaseClasses.PartialSecurityControl;
  Modelica.Blocks.Sources.BooleanConstant conTru(final k=true)
    "Always true as the two blocks OperationalEnvelope and OnOffControl deal with whether the nSet value is correct or not"
    annotation (Placement(transformation(extent={{58,-6},{70,6}})));
  parameter Boolean useMinRunTime=true
    "False if minimal runtime of HP is not considered"
    annotation (Dialog(group="OnOffControl"));
  parameter Modelica.SIunits.Time minRunTime "Mimimum runtime of heat pump"
    annotation (Dialog(group="OnOffControl",enable=useMinRunTim));
  parameter Boolean useMinLocTime=true
    "False if minimal locktime of HP is not considered"
    annotation (Dialog(group="OnOffControl"));
  parameter Modelica.SIunits.Time minLocTime "Minimum lock time of heat pump"
    annotation (Dialog(group="OnOffControl",enable=useMinLocTim));
  parameter Boolean useRunPerHou=true
    "False if maximal runs per hour HP are not considered"
    annotation (Dialog(group="OnOffControl"));
  parameter Real maxRunPerHou "Maximal number of on/off cycles in one hour"
    annotation (Dialog(group="OnOffControl",enable=useRunPerHour));

  parameter Boolean useOpeEnv=true
    "False to allow HP to run out of operational envelope"
    annotation (Dialog(group="Operational Envelope"));
  parameter Real tableLow[:,2] "Lower boundary of envelope"
    annotation (Dialog(group="Operational Envelope"));
  parameter Real tableUpp[:,2] "Upper boundary of envelope"
    annotation (Dialog(group="Operational Envelope"));
  OperationalEnvelope operationalEnvelope(final useOpeEnv=useOpeEnv,
    final tableLow=tableLow,
    final tableUpp=tableUpp)
    annotation (Placement(transformation(extent={{6,-18},{44,18}})));
  OnOffControl onOffController(
    final minRunTime=minRunTime,
    final minLocTime=minLocTime,
    useMinRunTime=useMinRunTime,
    useMinLocTime=useMinLocTime,
    useRunPerHou=useRunPerHou,
    maxRunPerHou=maxRunPerHou,
    pre_n_start=pre_n_start)
    annotation (Placement(transformation(extent={{-42,-18},{-6,18}})));

  parameter Boolean pre_n_start=true "Start value of pre(n) at initial time"
    annotation (Dialog(group="OnOffControl", descriptionLabel=true),choices(checkBox=true));
  DefrostControl defrostControl(final minIceFac=minIceFac) if
                                   use_deFro
    annotation (Placement(transformation(extent={{-104,-22},{-62,22}})));
  Modelica.Blocks.Routing.RealPassThrough realPasThrDef if not use_deFro
    "No 2. Layer"
    annotation (Placement(transformation(extent={{-92,28},{-76,44}})),
      choicesAllMatching=true);
  parameter Boolean use_deFro
    "True if defrost control should be enabled(only air-source HPs)"
    annotation (Dialog(group="Defrost"));
  parameter Real minIceFac "Minimal value above which no defrost is necessary"
    annotation (Dialog(group="Defrost"));
  Modelica.Blocks.Routing.BooleanPassThrough boolPasThrDef if
                                                           not use_deFro
    "No 2. Layer" annotation (Placement(transformation(extent={{-92,-50},{-76,
            -34}})), choicesAllMatching=true);
equation
  connect(conTru.y,swiErr.u2)
    annotation (Line(points={{70.6,0},{84,0}}, color={255,0,255}));
  connect(onOffController.nOut, operationalEnvelope.nSet) annotation (Line(
        points={{-4.5,0},{0,0},{0,3.6},{3.46667,3.6}},                    color=
         {0,0,127}));

  connect(sigBusHP, onOffController.sigBusHP) annotation (Line(
      points={{-135,-69},{-44.25,-69},{-44.25,-12.42}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP, operationalEnvelope.sigBusHP) annotation (Line(
      points={{-135,-69},{3.625,-69},{3.625,-12.42}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP, defrostControl.sigBusHP) annotation (Line(
      points={{-135,-69},{-105.26,-69},{-105.26,-13.64}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(operationalEnvelope.nOut, swiErr.u1) annotation (Line(points={{45.5833,
          3.6},{50,3.6},{50,16},{78,16},{78,8},{84,8}},
                                                    color={0,0,127}));
  connect(nSet, defrostControl.nSet) annotation (Line(
      points={{-136,20},{-124,20},{-124,4.4},{-107.36,4.4}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(nSet, realPasThrDef.u) annotation (Line(
      points={{-136,20},{-116,20},{-116,36},{-93.6,36}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(realPasThrDef.y, onOffController.nSet) annotation (Line(
      points={{-75.2,36},{-52,36},{-52,0},{-44.4,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(operationalEnvelope.modeOut, modeOut) annotation (Line(points={{
          45.5833,-3.6},{50,-3.6},{50,-36},{114,-36},{114,-20},{130,-20}},
        color={255,0,255}));
  connect(modeSet, defrostControl.modeSet) annotation (Line(
      points={{-136,-20},{-120,-20},{-120,-4.4},{-107.36,-4.4}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(defrostControl.nOut1, onOffController.nSet) annotation (Line(
      points={{-59.9,4.4},{-59.9,0},{-44.4,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(defrostControl.modeOut, operationalEnvelope.modeSet) annotation (Line(
      points={{-59.9,-4.4},{-56,-4.4},{-56,-28},{0,-28},{0,-4},{4,-4},{4,-3.6},
          {3.46667,-3.6}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(modeSet, boolPasThrDef.u) annotation (Line(
      points={{-136,-20},{-120,-20},{-120,-42},{-93.6,-42}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(boolPasThrDef.y, operationalEnvelope.modeSet) annotation (Line(
      points={{-75.2,-42},{-2,-42},{-2,-4},{3.46667,-4},{3.46667,-3.6}},
      color={255,0,255},
      pattern=LinePattern.Dash));
end SecurityControl;
