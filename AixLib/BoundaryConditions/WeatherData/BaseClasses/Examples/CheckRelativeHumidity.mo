within AixLib.BoundaryConditions.WeatherData.BaseClasses.Examples;
model CheckRelativeHumidity "Test model for CheckRelativeHumidity"
  extends AixLib.BoundaryConditions.WeatherData.BaseClasses.Examples.ConvertRelativeHumidity;

  AixLib.BoundaryConditions.WeatherData.BaseClasses.CheckRelativeHumidity cheRelHum
    "Block that constrains the relative humidity"
  annotation (Placement(transformation(extent={{60,0},{80,20}})));
equation
  connect(conRelHum.relHumOut, cheRelHum.relHumIn) annotation (Line(
      points={{61,0},{60,0},{60,10},{58,10}},
      color={0,0,127}));
  annotation (
  Documentation(info="<html><p>
  This example tests the model that constrains the relative humidity.
</p>
</html>",
revisions="<html><ul>
  <li>July 14, 2010, by Wangda Zuo:<br/>
    First implementation.
  </li>
</ul>
</html>"),
  experiment(Tolerance=1e-6, StartTime=0, StopTime=8640000),
__Dymola_Commands(file=
          "modelica://AixLib/Resources/Scripts/Dymola/BoundaryConditions/WeatherData/BaseClasses/Examples/CheckRelativeHumidity.mos"
        "Simulate and plot"));
end CheckRelativeHumidity;
