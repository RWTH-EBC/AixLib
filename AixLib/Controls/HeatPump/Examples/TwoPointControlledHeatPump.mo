within AixLib.Controls.HeatPump.Examples;
model TwoPointControlledHeatPump
  extends Modelica.Icons.Example;
  extends PartialHeatPumpController(redeclare TwoPointControlledHP hPController(
        bandwidth=2));

annotation(experiment(Tolerance=1e-6, StartTime=0, StopTime=10000), __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/Examples/GeothermalHeatPump.mos"
        "Simulate and plot"),
    Documentation(info="<html><p>
  Example for an two-point hysteresis controlled heat pump. Play around
  with the bandwith settings to see how it influence nSet depending on
  TSet and TMea.
</p>
</html>", revisions="<html><ul>
  <li>
    <i>July 14, 2022</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1128\">#1128</a>)
  </li>
</ul>
</html>"));
end TwoPointControlledHeatPump;
