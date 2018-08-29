within AixLib.Fluid.HeatPumps.BaseClasses.HeatPumpControl;
model OnOffHP "Converts a desired temperature to a certain compressor speed"
  extends AixLib.Fluid.HeatPumps.BaseClasses.HeatPumpControl.BaseClasses.partialTSetToNSet;
  Modelica.Blocks.Sources.Constant conOne(k=1) "Constant one for on off heat pump" annotation (Placement(transformation(extent={{38,14},{50,26}})));
  parameter Real hys "Hysteresis of controller";
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=hys, pre_y_start=false) "Hysteresis controller for set temperature"
    annotation (Placement(transformation(extent={{-52,-48},{-24,-20}})));
equation
  connect(TSet, onOffController.reference) annotation (Line(points={{-116,60},{-85.5,
          60},{-85.5,-25.6},{-54.8,-25.6}},       color={0,0,127}));
  connect(conOne.y, swiNullHP.u1) annotation (Line(points={{50.6,20},{58,20},{
          58,8},{64,8}}, color={0,0,127}));
  connect(TAct, onOffController.u) annotation (Line(points={{-116,-80},{-76,-80},
          {-76,-42.4},{-54.8,-42.4}}, color={0,0,127}));
  connect(onOffController.y, swiNullHP.u2) annotation (Line(points={{-22.6,-34},
          {20,-34},{20,0},{64,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                            Rectangle(
          extent={{-84,85.5},{91.5,-82.5}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillPattern=FillPattern.Solid,
          fillColor={255,255,170}), Text(
          extent={{-36,30},{48,-14}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end OnOffHP;
