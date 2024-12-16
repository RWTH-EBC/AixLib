within AixLib.Utilities.KPIs.BaseClasses;
partial model PartialIntegralError "Partial model for integral error"
  extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Interfaces.RealInput u "Real input signal"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput ref "Real reference signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput y "Output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialIntegralError;
