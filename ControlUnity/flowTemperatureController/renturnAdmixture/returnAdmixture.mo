within ControlUnity.flowTemperatureController.renturnAdmixture;
model returnAdmixture
  "Model for return admixture curcuit with a fixed setpoint temperature (before every simulation)"
  parameter Modelica.SIunits.Temperature Tb "Fix boiler temperature for return admixture";
  extends ControlUnity.flowTemperatureController.renturnAdmixture.partialReturnAdmixture(
  y=valveSet);

  Modelica.Blocks.Sources.RealExpression realExpression
    annotation (Placement(transformation(extent={{-100,-26},{-80,-6}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end returnAdmixture;
