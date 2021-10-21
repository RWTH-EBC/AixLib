within ControlUnity.flowTemperatureController.renturnAdmixture;
model returnAdmixture
  "Flow temperature control with return admixture"
  extends ControlUnity.flowTemperatureController.partialFlowtemperatureControl;
  parameter Modelica.SIunits.Temperature T "Fix setpoint boiler temperature; can be determinded before simulation";
  parameter Modelica.SIunits.Temperature T_flow "Flow temperature resulting from the return admixture for each heating curcuit";


  Modelica.Blocks.Sources.RealExpression realExpression(y=T)
    annotation (Placement(transformation(extent={{34,58},{54,78}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=T_flow)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Interfaces.RealOutput Tb
    "Fix setpoint boiler temperature; can be determinded before simulation"
    annotation (Placement(transformation(extent={{90,58},{110,78}})));
equation
  connect(realExpression.y,Tb)
    annotation (Line(points={{55,68},{100,68}}, color={0,0,127}));
  connect(realExpression1.y, PID.u_s)
    annotation (Line(points={{-79,0},{44,0}}, color={0,0,127}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
       coordinateSystem(preserveAspectRatio=false)));
end returnAdmixture;
