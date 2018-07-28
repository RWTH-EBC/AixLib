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
    annotation (Placement(transformation(extent={{-18,2},{18,36}})));
  OnOffControl onOffController
    annotation (Placement(transformation(extent={{-84,2},{-48,36}})));
  Modelica.Blocks.Sources.BooleanConstant conTru(final k=true)
    "Always true as the two blocks OperationalEnvelope and OnOffControl deal with whether the nSet value is correct or not"
    annotation (Placement(transformation(extent={{58,-6},{70,6}})));
equation
  connect(conTru.y,swiErr.u2)
    annotation (Line(points={{70.6,0},{84,0}}, color={255,0,255}));
  connect(onOffController.nOut, operationalEnvelope.nSet) annotation (Line(
        points={{-46.5,19},{-34,19},{-34,26},{-20.25,26},{-20.25,25.29}}, color=
         {0,0,127}));

  connect(nSet, onOffController.nSet) annotation (Line(points={{-135,37},{
          -110.5,37},{-110.5,25.29},{-86.25,25.29}}, color={0,0,127}));
  connect(operationalEnvelope.nOut,swiErr.u1)  annotation (Line(points={{19.5,
          19},{54,19},{54,12},{72,12},{72,8},{84,8}}, color={0,0,127}));
  connect(heatPumpControlBus, onOffController.heatPumpControlBus) annotation (
      Line(
      points={{-137,-27},{-86.55,-27},{-86.55,14.41}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(onOffController.heatPumpControlBus, operationalEnvelope.heatPumpControlBus)
    annotation (Line(
      points={{-86.55,14.41},{-88,14.41},{-88,-26},{-20,-26},{-20,14.41},{
          -20.55,14.41}},
      color={255,204,51},
      thickness=0.5));
end SecurityControl;
