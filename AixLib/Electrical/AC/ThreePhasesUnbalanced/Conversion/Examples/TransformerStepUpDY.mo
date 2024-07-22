within AixLib.Electrical.AC.ThreePhasesUnbalanced.Conversion.Examples;
model TransformerStepUpDY
  "Test for the AC/AC transformer model with Delta-Wye configuration (step-up voltage)"
  extends BaseClasses.TransformerExample(
  V_primary = 4160,
  V_secondary = 12470,
  redeclare AixLib.Electrical.AC.ThreePhasesUnbalanced.Sensors.ProbeWye probe_2,
  redeclare
      AixLib.Electrical.AC.ThreePhasesUnbalanced.Conversion.ACACTransformerStepUpDY
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
<a href=\"modelica://AixLib.Electrical.AC.ThreePhasesUnbalanced.Conversion.ACACTransformerStepUpDY\">
AixLib.Electrical.AC.ThreePhasesUnbalanced.Conversion.ACACTransformerStepUpDY</a> model.
</p>
</html>"),
experiment(Tolerance=1e-6, StopTime=1.0),
__Dymola_Commands(file=
 "modelica://AixLib/Resources/Scripts/Dymola/Electrical/AC/ThreePhasesUnbalanced/Conversion/Examples/TransformerStepUpDY.mos"
        "Simulate and plot"));
end TransformerStepUpDY;
