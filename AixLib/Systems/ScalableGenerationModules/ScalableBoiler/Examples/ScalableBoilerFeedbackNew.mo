within AixLib.Systems.ScalableGenerationModules.ScalableBoiler.Examples;
model ScalableBoilerFeedbackNew
  "Example for ScalableBoiler - With Pump and simple Pump regulation using a 
  constant supply temperature and feedback control for return temperature"
  extends ScalableBoilerConstantSup(scaBoi(hasFedBac  =true));
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
end ScalableBoilerFeedbackNew;
