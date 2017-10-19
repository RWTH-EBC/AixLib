within AixLib.Utilities.Time.Examples;
model ModelTime "Test model for the ModelTime block"
  extends Modelica.Icons.Example;
  AixLib.Utilities.Time.ModelTime modTim "Model time"
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
equation

  annotation (
  Documentation(info="<html>
<p>
This model tests the implementation of
the block that outputs the model time.
</p>
</html>", revisions="<html>
<ul>
<li>
January 16, 2015, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
  experiment(
  StartTime=-1,
  Tolerance=1e-6, StopTime=1),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Utilities/Time/Examples/ModelTime.mos"
        "Simulate and plot"));
end ModelTime;
