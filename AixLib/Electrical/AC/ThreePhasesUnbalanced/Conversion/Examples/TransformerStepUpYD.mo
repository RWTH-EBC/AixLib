within AixLib.Electrical.AC.ThreePhasesUnbalanced.Conversion.Examples;
model TransformerStepUpYD
  "Test for the AC/AC transformer model with Wye-Delta configuration (step-up voltage)"
  extends BaseClasses.TransformerExample(
  V_primary = 4160,
  V_secondary = 12470,
  redeclare AixLib.Electrical.AC.ThreePhasesUnbalanced.Sensors.ProbeDelta probe_2,
  redeclare
      AixLib.Electrical.AC.ThreePhasesUnbalanced.Conversion.ACACTransformerStepUpYD
  tra(VHigh=V_primary,
      VLow=V_secondary,
      XoverR=6,
      Zperc=sqrt(0.01^2 + 0.06^2),
      VABase=6000000));

equation
  connect(probe_2.term, load.terminal) annotation (Line(
      points={{30,31},{30,0},{50,0}},
      color={0,120,120},
      smooth=Smooth.None));
annotation (Documentation(revisions="<html>
<ul>
<li>
October 3, 2014, by Marco Bonvini:<br/>
Created model and documentation.
</li>
</ul>
</html>", info="<html>
<p>
This example model tests the
<a href=\"modelica://AixLib.Electrical.AC.ThreePhasesUnbalanced.Conversion.ACACTransformerStepUpYD\">
AixLib.Electrical.AC.ThreePhasesUnbalanced.Conversion.ACACTransformerStepUpYD</a> model.
</p>
<h4>Note:</h4>
<p>
When the secondary side of the transformer is in the Delta (D) configuration,
measuring the voltage with a Wye (Y) is not possible because the voltage vectors
in the connector do not have a neutral reference.
</p>
</html>"),
experiment(Tolerance=1e-6, StopTime=1.0),
__Dymola_Commands(file=
 "modelica://AixLib/Resources/Scripts/Dymola/Electrical/AC/ThreePhasesUnbalanced/Conversion/Examples/TransformerStepUpYD.mos"
        "Simulate and plot"), 
   __Dymola_LockedEditing="Model from IBPSA");
end TransformerStepUpYD;
