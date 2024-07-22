within AixLib.Electrical.AC.ThreePhasesBalanced.Sensors.Examples;
model GeneralizedSensor "Example model for generalized sensor"
  extends Modelica.Icons.Example;
  AixLib.Electrical.AC.ThreePhasesBalanced.Sensors.GeneralizedSensor
    sen "Sensor model"
    annotation (Placement(transformation(extent={{-20,2},{0,22}})));
  AixLib.Electrical.AC.ThreePhasesBalanced.Loads.Capacitive loa(
                   V_nominal=480, P_nominal=-100) "Constant load"
    annotation (Placement(transformation(extent={{40,2},{60,22}})));
  AixLib.Electrical.AC.ThreePhasesBalanced.Sources.FixedVoltage
    sou(f=60, V=480) "Voltage source"
    annotation (Placement(transformation(extent={{-60,2},{-40,22}})));
equation
  connect(sen.terminal_p, loa.terminal)
    annotation (Line(points={{5.55112e-16,12},{40,12}}, smooth=Smooth.None));
  connect(sen.terminal_n, sou.terminal)
    annotation (Line(points={{-20,12},{-40,12}}, smooth=Smooth.None));
  annotation (Documentation(
  info="<html>
<p>
This example illustrates the use of the generalized sensor.
</p>
</html>",
revisions="<html>
<ul>
<li>
July 24, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
experiment(Tolerance=1e-6, StopTime=1.0),
__Dymola_Commands(file=
          "modelica://AixLib/Resources/Scripts/Dymola/Electrical/AC/ThreePhasesBalanced/Sensors/Examples/GeneralizedSensor.mos"
        "Simulate and plot"));
end GeneralizedSensor;
