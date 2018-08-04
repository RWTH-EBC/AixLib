within AixLib.Fluid.HeatPumps.BaseClasses.SecurityControls;
block SecurityControl "Block including all security levels"
  extends BaseClasses.PartialSecurityControl;
  Modelica.Blocks.Sources.BooleanConstant conTru(final k=true)
    "Always true as the two blocks OperationalEnvelope and OnOffControl deal with whether the nSet value is correct or not"
    annotation (Placement(transformation(extent={{58,-6},{70,6}})));
  parameter Boolean useMinRunTim=true "Whether to regard minimal runtime of HP"
    annotation (Dialog(group="OnOffControl"));
  parameter Modelica.SIunits.Time minRunTime "Mimimum runtime of heat pump"
    annotation (Dialog(group="OnOffControl",enable=useMinRunTim));
  parameter Boolean useMinLocTim=true "Whether to regard minimal Lock-Time of HP or not"
    annotation (Dialog(group="OnOffControl"));
  parameter Modelica.SIunits.Time minLocTime "Minimum lock time of heat pump"
    annotation (Dialog(group="OnOffControl",enable=useMinLocTim));
  parameter Boolean useRunPerHour=true
    "Whether to regard a maximal amount of runs per hour or not"
    annotation (Dialog(group="OnOffControl"));
  parameter Real maxRunPerHour "Maximal number of on/off cycles in one hour"
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
    annotation (Placement(transformation(extent={{-18,-18},{20,18}})));
  OnOffControl onOffController(
    final minRunTime=minRunTime,
    final useMinLocTim=useMinLocTim,
    final minLocTime=minLocTime,
    final maxRunPerHour=maxRunPerHour,
    final useRunPerHour=useRunPerHour,
    final useMinRunTim=useMinRunTim)
    annotation (Placement(transformation(extent={{-86,-18},{-50,18}})));

equation
  connect(conTru.y,swiErr.u2)
    annotation (Line(points={{70.6,0},{84,0}}, color={255,0,255}));
  connect(onOffController.nOut, operationalEnvelope.nSet) annotation (Line(
        points={{-48.5,0},{-20.5333,0}},                                  color=
         {0,0,127}));

  connect(nSet, onOffController.nSet) annotation (Line(points={{-136,0},{-88.4,0}},
                                                     color={0,0,127}));
  connect(operationalEnvelope.nOut,swiErr.u1)  annotation (Line(points={{21.5833,
          0},{54,0},{54,12},{72,12},{72,8},{84,8}},   color={0,0,127}));
  connect(heatPumpControlBus, onOffController.heatPumpControlBus) annotation (
      Line(
      points={{-135,-69},{-88.25,-69},{-88.25,-12.42}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(onOffController.heatPumpControlBus, operationalEnvelope.heatPumpControlBus)
    annotation (Line(
      points={{-88.25,-12.42},{-88,-12.42},{-88,-46},{-20,-46},{-20,-12.42},{-20.375,
          -12.42}},
      color={255,204,51},
      thickness=0.5));
end SecurityControl;
