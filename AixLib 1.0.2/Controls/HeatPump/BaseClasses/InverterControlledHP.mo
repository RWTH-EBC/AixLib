within AixLib.Controls.HeatPump.BaseClasses;
model InverterControlledHP "Converter model for an inverter / speed controlled HP modulating between 0 and 1"
  extends PartialTSetToNSet;
  parameter Real hys "Hysteresis of controller";
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=hys,
      pre_y_start=false)                                                                    "Hysteresis controller for set temperature"
    annotation (Placement(transformation(extent={{-58,-6},{-30,22}})));
  Modelica.Blocks.Continuous.LimPID InverterControl(
    final controllerType=Modelica.Blocks.Types.SimpleController.PI,
    final k=k,
    final Ti=Ti,
    final yMax=1,
    final yMin=0)
    "PI-Control for a inverter controlled HP"
    annotation (Placement(transformation(extent={{14,38},{34,58}})));
  parameter Real k=0.1 "Gain of controller"
    annotation (Dialog(group="PI Values"));
  parameter Modelica.SIunits.Time Ti=30 "Time constant of Integrator block"
    annotation (Dialog(group="PI Values"));
equation
  connect(TSet, onOffController.reference) annotation (Line(points={{-116,60},{
          -77.5,60},{-77.5,16.4},{-60.8,16.4}},
                                             color={0,0,127}));
  connect(InverterControl.y, swiNullHP.u1)
    annotation (Line(points={{35,48},{52,48},{52,8},{64,8}}, color={0,0,127}));
  connect(TSet, InverterControl.u_s) annotation (Line(points={{-116,60},{-43.5,
          60},{-43.5,48},{12,48}}, color={0,0,127}));
  connect(TAct, onOffController.u) annotation (Line(points={{-116,-80},{-70,-80},
          {-70,-0.4},{-60.8,-0.4}},color={0,0,127}));
  connect(TAct, InverterControl.u_m) annotation (Line(points={{-116,-80},{-70,
          -80},{-70,32},{24,32},{24,36}},
                                  color={0,0,127}));
  connect(onOffController.y, andHeaLim.u1) annotation (Line(points={{-28.6,8},{
          24,8},{24,0},{36.8,0}}, color={255,0,255}));
  annotation (Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>"));
end InverterControlledHP;
