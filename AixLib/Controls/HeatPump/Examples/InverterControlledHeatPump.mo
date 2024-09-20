within AixLib.Controls.HeatPump.Examples;
model InverterControlledHeatPump
  extends Modelica.Icons.Example;
  extends PartialHeatPumpController(redeclare InverterControlledHP hPController(
      bandwidth=2,
      k=0.05,
      Ti=100));

annotation(experiment(Tolerance=1e-6, StartTime=0, StopTime=10000),
    Documentation(info="<html><p>
  Example for an inverter controlled heat pump. Play around with the PI
  settings to see how they influence nSet depending on TSet and TMea.
</p>
</html>", revisions="<html><ul>
  <li>
    <i>July 14, 2022</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1128\">#1128</a>)
  </li>
</ul>
</html>"));
end InverterControlledHeatPump;
