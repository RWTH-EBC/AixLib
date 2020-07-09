within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.BaseClasses;
block CheckResultsAccordingToASHRAE
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Time endTime
                                         "Simulation end time";

  Modelica.Blocks.Interfaces.RealInput upperLimit
                                                 "maximum Value"
    annotation (Placement(transformation(extent={{-120,30},{-80,70}})));

  Modelica.Blocks.Interfaces.RealInput modelResults
    annotation (Placement(transformation(extent={{-120,-84},{-80,-44}})));
  Modelica.Blocks.Interfaces.RealInput lowerLimit
                                                 "minimum Value"
    annotation (Placement(transformation(extent={{-120,50},{-80,90}})));

  Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
          extent={{100,20},{140,60}}), iconTransformation(extent={{100,42},{140,
            82}})));

equation
  y= if (time == endTime) and modelResults >= lowerLimit and modelResults <= upperLimit then modelResults
      else 0;
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
 <ul>
 <li><i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>Implemented</li>
 </ul>
 </html>", info="<html>
<p>Block to test AnnualHeatingLoad and AnnualCoolingLoad according to reference Validation Data.</p>
</ul>
</ul>
</ul>
</ul>
</html>"));
end CheckResultsAccordingToASHRAE;
