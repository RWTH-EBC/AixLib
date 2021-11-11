within ControlUnity.flowTemperatureController.renturnAdmixture;
model returnAdmixture
  "Flow temperature control with return admixture"
  extends ControlUnity.flowTemperatureController.partialFlowtemperatureControl(severalHeatcurcuits=true);
  parameter Modelica.SIunits.Temperature T "Fix setpoint boiler temperature; can be determinded before simulation";
  parameter Modelica.SIunits.Temperature T_flow "Flow temperature resulting from the return admixture for each heating curcuit";


equation
  connect(u, PID1.u_s) annotation (Line(points={{-100,-24},{-58,-24},{-58,44},{
          -12,44}}, color={0,0,127}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
       coordinateSystem(preserveAspectRatio=false)));
end returnAdmixture;
