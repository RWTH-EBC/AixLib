within ControlUnity.twoPositionController.BaseClass.twoPositionControllerCal;
model twoPositionController_layers

  extends
    ControlUnity.twoPositionController.BaseClass.partialTwoPositionController(
      realExpression(y=TLayer_dif), onOffController(bandwidth=bandwidth));
   parameter Boolean layerCal=true
    "If true, the two-position controller uses the mean temperature of the buffer storage";

  parameter Modelica.SIunits.TemperatureDifference TLayer_dif=8 "Reference difference temperature for the on off controller for the buffer storage with layer calculation";
  parameter Modelica.SIunits.Temperature Tlayerref=273.15+65;

  Modelica.Blocks.Sources.RealExpression realExpression(y=TLayer_dif)
    annotation (Placement(transformation(extent={{30,-40},{10,-20}})));
  parameter Real bandwidth "Bandwidth around reference signal";
  Modelica.Blocks.Math.Sum sumTLayers(nin=n)
    annotation (Placement(transformation(extent={{-66,26},{-46,46}})));
  Modelica.Blocks.Math.Division meanTemperatureDynamicStorage
    annotation (Placement(transformation(extent={{-36,20},{-16,40}})));
  Modelica.Blocks.Sources.RealExpression realExpressionDynamic(y=n)
    annotation (Placement(transformation(extent={{-86,2},{-66,22}})));
equation
  connect(sumTLayers.y,meanTemperatureDynamicStorage. u1)
    annotation (Line(points={{-45,36},{-38,36}},                       color={0,0,127}));
  connect(realExpressionDynamic.y,meanTemperatureDynamicStorage. u2)
    annotation (Line(points={{-65,12},{-54,12},{-54,24},{-38,24}},     color={0,0,127}));
  connect(meanTemperatureDynamicStorage.y, add.u1) annotation (Line(points={{-15,
          30},{-12,30},{-12,52},{-2,52}}, color={0,0,127}));
  connect(realExpression.y, add.u2) annotation (Line(points={{9,-30},{-8,-30},{-8,
          40},{-2,40}}, color={0,0,127}));
  connect(TLayers, sumTLayers.u)
    annotation (Line(points={{-100,36},{-68,36}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end twoPositionController_layers;
