within AixLib.Utilities.Math.Examples;
model MovingAverage "Example for moving average model"
  extends Modelica.Icons.Example;

    AixLib.Utilities.Math.MovingAverage movingAverage(final aveTime=pulse.period/2, u_start=
        0)
    annotation (Placement(transformation(extent={{-28,-34},{36,34}})));
  Modelica.Blocks.Sources.Pulse pulse(amplitude=1, period=10)
    annotation (Placement(transformation(extent={{-94,-10},{-74,10}})));
  Modelica.Blocks.Interfaces.RealOutput y "Continuous output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation

  connect(movingAverage.y, y)
    annotation (Line(points={{39.2,0},{110,0}}, color={0,0,127}));
  connect(pulse.y, movingAverage.u)
    annotation (Line(points={{-73,0},{-34.4,0}}, color={0,0,127}));

annotation(experiment(Tolerance=1e-6, StopTime=50.0, Algorithm="CVode"),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Utilities/Math/Examples/MovingAverage.mos"
        "Simulate and plot"),
    Documentation(info="<html><p>
  This model tests the implementation of the moving average model.
</p>
</html>", revisions="<html>
<ul>
  <li>November 09, 2021, by Fabian Wuellhorst:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end MovingAverage;
