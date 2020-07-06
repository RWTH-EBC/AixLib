within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.BaseClasses;
block checkResultsAccordingToASHRAE
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Time endTime = 0 "Simulation end time";

  Modelica.Blocks.Interfaces.RealInput upperLimit
    annotation (Placement(transformation(extent={{-120,30},{-80,70}})));

  Modelica.Blocks.Interfaces.RealInput modelResults
    annotation (Placement(transformation(extent={{-120,-84},{-80,-44}})));
  Modelica.Blocks.Interfaces.RealInput lowerLimit
    annotation (Placement(transformation(extent={{-120,50},{-80,90}})));

  Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
          extent={{100,20},{140,60}}), iconTransformation(extent={{100,42},{140,
            82}})));
protected
  parameter Modelica.SIunits.Time t1(fixed=false) "Simulation end time";

initial equation
  t1 = endTime;

equation
  y= if (time == t1) and modelResults >= lowerLimit and modelResults <= upperLimit then modelResults
      else 0;
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end checkResultsAccordingToASHRAE;
