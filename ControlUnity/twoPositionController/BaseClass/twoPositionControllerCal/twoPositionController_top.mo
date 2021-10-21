within ControlUnity.twoPositionController.BaseClass.twoPositionControllerCal;
model twoPositionController_top
  "Two position controller using top level of buffer storage for calculation"
  extends
    ControlUnity.twoPositionController.BaseClass.partialTwoPositionController(
      realExpression(y=Tref), onOffController(bandwidth=bandwidth));
  parameter Modelica.SIunits.Temperature Tref=273.15+60 "Reference temperature for two position controller using top level temperature";
  parameter Modelica.SIunits.Temperature Ttop=273.15+70 "Temperature on the top level of the buffer storage";
  parameter Boolean layerCal=true
    "If true, the two-position controller uses the mean temperature of the buffer storage";

  Modelica.Blocks.Sources.RealExpression realExpression1(y=0)
    annotation (Placement(transformation(extent={{-92,-6},{-72,14}})));
  parameter Real bandwidth "Bandwidth around reference signal";
equation

  connect(TLayers[n], add.u1) annotation (Line(points={{-100,36},{-46,36},{-46,52},
          {-2,52}}, color={0,0,127}));
  connect(realExpression1.y, add.u2) annotation (Line(points={{-71,4},{-12,4},{-12,
          40},{-2,40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end twoPositionController_top;
