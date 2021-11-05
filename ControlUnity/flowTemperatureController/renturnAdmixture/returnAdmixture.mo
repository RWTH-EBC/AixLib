within ControlUnity.flowTemperatureController.renturnAdmixture;
model returnAdmixture
  "Flow temperature control with return admixture"
  extends ControlUnity.flowTemperatureController.partialFlowtemperatureControl;
  parameter Modelica.SIunits.Temperature T "Fix setpoint boiler temperature; can be determinded before simulation";
  parameter Modelica.SIunits.Temperature T_flow "Flow temperature resulting from the return admixture for each heating curcuit";


  Modelica.Blocks.Sources.RealExpression realExpression(y=T)
    annotation (Placement(transformation(extent={{36,50},{56,70}})));
  Modelica.Blocks.Interfaces.RealOutput Tb
    "Fix setpoint boiler temperature; can be determinded before simulation"
    annotation (Placement(transformation(extent={{92,50},{112,70}})));
equation
  connect(realExpression.y,Tb)
    annotation (Line(points={{57,60},{102,60}}, color={0,0,127}));
  connect(u, PID.u_s)
    annotation (Line(points={{-100,0},{44,0}}, color={0,0,127}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
       coordinateSystem(preserveAspectRatio=false)));
end returnAdmixture;
