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
</html>"));
end ScalableBoilerFeedbackNew;
