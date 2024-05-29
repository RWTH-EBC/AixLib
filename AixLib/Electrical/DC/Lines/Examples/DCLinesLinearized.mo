within AixLib.Electrical.DC.Lines.Examples;
 model DCLinesLinearized
   "Example model to test the possible combinations between line and load models"
   extends AixLib.Electrical.DC.Lines.Examples.DCLines(linearLoads = true);
 
   annotation (Documentation(info="<html>
 <p>
 This model is the linearized version of the model
 <a href=\"modelica://AixLib.Electrical.DC.Lines.Examples.DCLines\">
 AixLib.Electrical.DC.Lines.Examples.DCLines</a> and
 can be used to test how the linearized loads are affected by the voltage drop
 caused by the lines. The longer the distance between the load and the source,
 the bigger is the voltage drop and thus the error introduced by the linearization.
 </p>
 </html>"),
 experiment(Tolerance=1e-06, StopTime=4000),
 __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Electrical/DC/Lines/Examples/DCLinesLinearized.mos"
         "Simulate and plot"), 
   __Dymola_LockedEditing="Model from IBPSA");
 end DCLinesLinearized;
