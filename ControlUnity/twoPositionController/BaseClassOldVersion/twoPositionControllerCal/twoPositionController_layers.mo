within ControlUnity.twoPositionController.BaseClassOldVersion.twoPositionControllerCal;
model twoPositionController_layers

  extends
    ControlUnity.twoPositionController.BaseClassOldVersion.partialTwoPositionController(
      realExpression(y=TLayer_dif), onOffController(bandwidth=bandwidth));
   parameter Boolean layerCal=true
    "If true, the two-position controller uses the mean temperature of the buffer storage";

  parameter Modelica.SIunits.TemperatureDifference TLayer_dif=8 "Reference difference temperature for the on off controller for the buffer storage with layer calculation";
  parameter Modelica.SIunits.Temperature Tlayerref=273.15+65;

  Modelica.Blocks.Math.Sum sumTLayers(nin=n)
    annotation (Placement(transformation(extent={{-72,20},{-52,40}})));
  Modelica.Blocks.Math.Division meanTemperatureBufferStorage
    annotation (Placement(transformation(extent={{-34,14},{-14,34}})));
  Modelica.Blocks.Sources.RealExpression realExpressionDynamic(y=n)
    annotation (Placement(transformation(extent={{-74,-10},{-54,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=TLayer_dif)
    annotation (Placement(transformation(extent={{-36,-32},{-16,-10}})));
  parameter Real bandwidth "Bandwidth around reference signal";
equation
  connect(sumTLayers.y, meanTemperatureBufferStorage.u1) annotation (Line(
        points={{-51,30},{-36,30}},                   color={0,0,127}));
  connect(realExpressionDynamic.y, meanTemperatureBufferStorage.u2) annotation (
     Line(points={{-53,0},{-42,0},{-42,18},{-36,18}}, color={0,0,127}));
  connect(meanTemperatureBufferStorage.y, add.u1) annotation (Line(points={{-13,24},
          {-2,24},{-2,38},{-12,38}},    color={0,0,127}));
  connect(realExpression.y, add.u2) annotation (Line(points={{-15,-21},{-15,-10},
          {-12,-10},{-12,26}},
                             color={0,0,127}));
  connect(TLayers, sumTLayers.u) annotation (Line(points={{-100,36},{-87,36},{-87,
          30},{-74,30}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end twoPositionController_layers;
