within AixLib.Controls.HeatPump.BaseClasses;
model OnOffHP "Controller gives full speed or stop signal depending on temperature hysteresis"
  extends AixLib.Controls.HeatPump.BaseClasses.PartialTSetToNSet;
  parameter Real hys "Hysteresis of controller";
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=hys, pre_y_start=false) "Hysteresis controller for set temperature"
    annotation (Placement(transformation(extent={{-54,10},{-26,38}})));
  Modelica.Blocks.Sources.Constant conOne(final k=1.0)
                                               "Constant one for on off heat pump" annotation (Placement(transformation(extent={{38,14},{50,26}})));

equation
  connect(TSet, onOffController.reference) annotation (Line(points={{-116,60},{
          -85.5,60},{-85.5,32.4},{-56.8,32.4}},   color={0,0,127}));
  connect(conOne.y, swiNullHP.u1) annotation (Line(points={{50.6,20},{58,20},{
          58,8},{64,8}}, color={0,0,127}));
  connect(TAct, onOffController.u) annotation (Line(points={{-116,-80},{-72,-80},
          {-72,15.6},{-56.8,15.6}},   color={0,0,127}));
  connect(onOffController.y, andHeaLim.u1) annotation (Line(points={{-24.6,24},
          {5.7,24},{5.7,0},{36.8,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>"));
end OnOffHP;
