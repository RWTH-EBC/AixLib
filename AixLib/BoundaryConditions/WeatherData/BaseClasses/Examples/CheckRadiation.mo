within AixLib.BoundaryConditions.WeatherData.BaseClasses.Examples;
model CheckRadiation "Test model for CheckRadiation"
  extends AixLib.BoundaryConditions.WeatherData.BaseClasses.Examples.ConvertRadiation;
  AixLib.BoundaryConditions.WeatherData.BaseClasses.CheckRadiation cheGloRad
    "Check global horizontal radiation"
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  AixLib.BoundaryConditions.WeatherData.BaseClasses.CheckRadiation cheDifRad
    "Check diffuse horizontal radiation"
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));
equation

  connect(conGloRad.HOut, cheGloRad.HIn) annotation (Line(
      points={{61,20},{60,20},{60,30},{58,30}},
      color={0,0,127}));
  connect(conDifRad.HOut, cheDifRad.HIn) annotation (Line(
      points={{61,-20},{60,-20},{60,-10},{58,-10}},
      color={0,0,127}));
  annotation (
  Documentation(info="<html>
<p>
This example tests the model that constrains the radiation.
</p>
</html>",
revisions="<html>
<ul>
<li>
July 14, 2010, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"),
experiment(Tolerance=1e-6, StartTime=0, StopTime=8640000),
__Dymola_Commands(file=
          "modelica://AixLib/Resources/Scripts/Dymola/BoundaryConditions/WeatherData/BaseClasses/Examples/CheckRadiation.mos"
        "Simulate and plot"));
end CheckRadiation;
