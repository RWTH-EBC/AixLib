within AixLib.Controls.HeatPump;
model InverterControlledHP
  "Converter model for an inverter / speed controlled HP modulating between 0 and 1"
  extends BaseClasses.PartialTSetToNSet;
  parameter Real bandwidth "Bandwith of hysteresis of controller";
  parameter Real k     "Gain of controller"
    annotation (Dialog(group="PI Values"));
  parameter Modelica.Units.SI.Time Ti    "Time constant of Integrator block"
    annotation (Dialog(group="PI Values"));

  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=bandwidth,
      pre_y_start=false)                                                                    "Hysteresis controller for set temperature"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Continuous.LimPID InverterControl(
    final controllerType=Modelica.Blocks.Types.SimpleController.PI,
    final k=k,
    final Ti=Ti,
    final yMax=1,
    final yMin=0)
    "PI-Control for a inverter controlled HP"
    annotation (Placement(transformation(extent={{20,40},{40,60}})));

equation
  connect(TSet, onOffController.reference) annotation (Line(points={{-116,60},{
          -77.5,60},{-77.5,36},{-62,36}},    color={0,0,127}));
  connect(InverterControl.y, swiNullHP.u1)
    annotation (Line(points={{41,50},{52,50},{52,-2},{58,-2}},
                                                             color={0,0,127}));
  connect(TSet, InverterControl.u_s) annotation (Line(points={{-116,60},{-43.5,
          60},{-43.5,50},{18,50}}, color={0,0,127}));
  connect(TMea, onOffController.u) annotation (Line(points={{-116,-80},{-70,-80},
          {-70,24},{-62,24}},      color={0,0,127}));
  connect(TMea, InverterControl.u_m) annotation (Line(points={{-116,-80},{-70,
          -80},{-70,16},{30,16},{30,38}},
                                  color={0,0,127}));
  connect(onOffController.y, andHeaLim.u1) annotation (Line(points={{-39,30},{
          -18,30},{-18,-10},{18,-10}},
                                  color={255,0,255}));
  annotation (Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>"));
end InverterControlledHP;
