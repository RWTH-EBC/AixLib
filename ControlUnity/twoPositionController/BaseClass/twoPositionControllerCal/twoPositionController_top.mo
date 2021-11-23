within ControlUnity.twoPositionController.BaseClass.twoPositionControllerCal;
model twoPositionController_top
  "Two position controller using top level of buffer storage for calculation"
  extends
    ControlUnity.twoPositionController.BaseClass.partialTwoPositionController(
      realExpression(y=Tref), onOffController(bandwidth=bandwidth), n=1);
  parameter Modelica.SIunits.Temperature Tref=273.15+60 "Reference temperature for two position controller using top level temperature";
  parameter Modelica.SIunits.Temperature Ttop=273.15+70 "Temperature on the top level of the buffer storage";
  parameter Boolean layerCal=true
    "If true, the two-position controller uses the mean temperature of the buffer storage";

  parameter Real bandwidth "Bandwidth around reference signal";
equation

  connect(TLayers[1], onOffController.u) annotation (Line(points={{-100,-22},{12,
          -22},{12,0},{32,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end twoPositionController_top;
