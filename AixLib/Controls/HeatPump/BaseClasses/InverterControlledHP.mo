within AixLib.Controls.HeatPump.BaseClasses;
model InverterControlledHP "Converter model for a inverter controlled HP"
  extends PartialTSetToNSet;
  parameter Real hys "Hysteresis of controller";
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=hys,
      pre_y_start=false)                                                                    "Hysteresis controller for set temperature"
    annotation (Placement(transformation(extent={{0,-14},{28,14}})));
  Modelica.Blocks.Continuous.LimPID InverterControl(final k=1, controllerType=
        Modelica.Blocks.Types.SimpleController.PI)
    "PI-Control for a inverter controlled HP"
    annotation (Placement(transformation(extent={{14,38},{34,58}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(final k=true)
                                                          annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={12,-54})));
equation
  connect(TSet, onOffController.reference) annotation (Line(points={{-116,60},{
          -21.5,60},{-21.5,8.4},{-2.8,8.4}}, color={0,0,127}));
  connect(InverterControl.y, swiNullHP.u1)
    annotation (Line(points={{35,48},{52,48},{52,8},{64,8}}, color={0,0,127}));
  connect(TSet, InverterControl.u_s) annotation (Line(points={{-116,60},{-43.5,
          60},{-43.5,48},{12,48}}, color={0,0,127}));
  connect(onOffController.y, swiNullHP.u2) annotation (Line(points={{29.4,
          1.77636e-15},{46,1.77636e-15},{46,0},{64,0}}, color={255,0,255}));
  connect(TAct, onOffController.u) annotation (Line(points={{-116,-80},{-60,-80},
          {-60,-8.4},{-2.8,-8.4}}, color={0,0,127}));
  connect(TAct, InverterControl.u_m) annotation (Line(points={{-116,-80},{-60,
          -80},{-60,36},{24,36}}, color={0,0,127}));
  connect(booleanConstant.y, swiNullsecHeaGen.u2)
    annotation (Line(points={{12,-62.8},{12,-74.4}}, color={255,0,255}));
end InverterControlledHP;
