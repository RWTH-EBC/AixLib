within AixLib.Utilities.Sources.HeaterCoolerVDI6007AC1;
model MovingAverageTest
  Math.MovingAverage movingAverage(aveTime=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Sources.Pulse pulse(amplitude=1, period=7200)
    annotation (Placement(transformation(extent={{-82,70},{-62,90}})));
  Modelica.Blocks.Sources.Step step(height=20, startTime=5*3600)
    annotation (Placement(transformation(extent={{-76,-10},{-56,10}})));
equation
  connect(movingAverage.y, y)
    annotation (Line(points={{11,0},{100,0}}, color={0,0,127}));
  connect(step.y, movingAverage.u)
    annotation (Line(points={{-55,0},{-12,0}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      __Dymola_NumberOfIntervals=900,
      __Dymola_Algorithm="Dassl"));
end MovingAverageTest;
