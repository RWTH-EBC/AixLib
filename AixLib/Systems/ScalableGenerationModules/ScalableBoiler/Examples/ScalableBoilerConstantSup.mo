within AixLib.Systems.ScalableGenerationModules.ScalableBoiler.Examples;
model ScalableBoilerConstantSup
  "Example for ScalableBoiler - With Pump and simple Pump regulation using a 
  constant supply temperature"
  extends ScalableBoilerHeatingCurve(scaBoi(use_HeaCur=false));
  Modelica.Blocks.Sources.Constant TSupSet(k=273 + 60) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,20})));
equation
  connect(TSupSet.y, boiBus.TSupSet) annotation (Line(points={{-59,20},{-42,20},
          {-42,40},{14,40},{14,62},{0,62}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

annotation (
    experiment(StopTime=86400, Tolerance=1e-06, __Dymola_Algorithm="Dassl"),
     __Dymola_Commands(file=
        "modelica://AixLib/Resources/Scripts/Dymola/Systems/ScalableGenerationModules/Examples/ScalableBoilerConstantSup.mos"
        "Simulate and Plot"), Documentation(info="<html>
<p>Example with a predefined constant flow set temperature via input.</p>
</html>", revisions="<html>
<ul>
<li>
<i>June, 2023</i> by Moritz Zuschlag; David Jansen<br/>
    First Implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1147\">#1147</a>)
</li>
</ul>
</html>"));
end ScalableBoilerConstantSup;
