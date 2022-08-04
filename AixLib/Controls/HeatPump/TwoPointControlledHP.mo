within AixLib.Controls.HeatPump;
model TwoPointControlledHP
  "Controller gives full speed or stop signal depending on temperature hysteresis"
  extends AixLib.Controls.HeatPump.BaseClasses.PartialTSetToNSet;
  parameter Real bandwidth "Bandwith of hysteresis of controller";
  Modelica.Blocks.Logical.OnOffController onOffController(final bandwidth=bandwidth,
      final pre_y_start=false)                                                              "Hysteresis controller for set temperature"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Constant conOne(final k=1)
                                               "Constant one for on off heat pump" annotation (Placement(transformation(extent={{20,20},
            {40,40}})));

equation
  connect(TSet, onOffController.reference) annotation (Line(points={{-116,60},{
          -85.5,60},{-85.5,36},{-62,36}},         color={0,0,127}));
  connect(conOne.y, swiNullHP.u1) annotation (Line(points={{41,30},{58,30},{58,
          -2}},          color={0,0,127}));
  connect(TMea, onOffController.u) annotation (Line(points={{-116,-80},{-72,-80},
          {-72,24},{-62,24}},         color={0,0,127}));
  connect(onOffController.y, andHeaLim.u1) annotation (Line(points={{-39,30},{
          5.7,30},{5.7,-10},{18,-10}},color={255,0,255}));
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
end TwoPointControlledHP;
