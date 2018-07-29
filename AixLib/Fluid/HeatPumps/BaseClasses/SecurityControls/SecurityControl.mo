within AixLib.Fluid.HeatPumps.BaseClasses.SecurityControls;
block SecurityControl "Block including all security levels"
  extends BaseClasses.PartialSecurityControl;
  parameter Modelica.SIunits.Temp_K TEva_min "Minimum source inlet temperature"
    annotation (Dialog(group="Operational Envelope"));
  parameter Modelica.SIunits.Temp_K TEva_max "Maximum source inlet temperature"
    annotation (Dialog(group="Operational Envelope"));
  parameter Modelica.SIunits.Temp_K TCon_min "Minimum sink inlet temperature"
    annotation (Dialog(group="Operational Envelope"));
  parameter Modelica.SIunits.Temp_K TCon_max "Maximum sink inlet temperature"
    annotation (Dialog(group="Operational Envelope"));
  OperationalEnvelope operationalEnvelope
    annotation (Placement(transformation(extent={{-18,-18},{20,18}})));
  OnOffControl onOffController
    annotation (Placement(transformation(extent={{-84,-18},{-48,18}})));
  Modelica.Blocks.Sources.BooleanConstant conTru(final k=true)
    "Always true as the two blocks OperationalEnvelope and OnOffControl deal with whether the nSet value is correct or not"
    annotation (Placement(transformation(extent={{58,-6},{70,6}})));
equation
  connect(conTru.y,swiErr.u2)
    annotation (Line(points={{70.6,0},{84,0}}, color={255,0,255}));
  connect(onOffController.nOut, operationalEnvelope.nSet) annotation (Line(
        points={{-46.5,0},{-22,0},{-22,0},{-20.5333,0},{-20.5333,0}},     color=
         {0,0,127}));

  connect(nSet, onOffController.nSet) annotation (Line(points={{-136,0},{-86.4,
          0}},                                       color={0,0,127}));
  connect(operationalEnvelope.nOut,swiErr.u1)  annotation (Line(points={{21.5833,
          0},{54,0},{54,12},{72,12},{72,8},{84,8}},   color={0,0,127}));
  connect(heatPumpControlBus, onOffController.heatPumpControlBus) annotation (
      Line(
      points={{-135,-69},{-86.25,-69},{-86.25,-12.42}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(onOffController.heatPumpControlBus, operationalEnvelope.heatPumpControlBus)
    annotation (Line(
      points={{-86.25,-12.42},{-88,-12.42},{-88,-46},{-20,-46},{-20,-12.42},{
          -20.375,-12.42}},
      color={255,204,51},
      thickness=0.5));
end SecurityControl;
