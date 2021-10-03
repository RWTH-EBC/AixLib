within Regelungseinheit.BaseClass.twoPositionControllerCal;
model twoPositionController_layers
  extends Regelungseinheit.BaseClass.partialTwoPositionController(
      realExpression(y=TLayer_dif));
  parameter Boolean layerCal=true "If true, the two-position controller uses the mean temperature of the buffer storage";
  parameter Integer n=3 "Number of layers in buffer storage";
  parameter Modelica.SIunits.TemperatureDifference TLayer_dif=8 "Reference difference temperature for the on off controller for the buffer storage with layer calculation";
  parameter Modelica.SIunits.Temperature Tlayerref=273.15+65;

  Modelica.Blocks.Math.Sum sumDynamic(nin=n)
    annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
  Modelica.Blocks.Math.Division meanTemperatureBufferStorage
    annotation (Placement(transformation(extent={{-34,14},{-14,34}})));
  Modelica.Blocks.Sources.RealExpression realExpressionDynamic(y=n)
    annotation (Placement(transformation(extent={{-74,-10},{-54,10}})));
  Modelica.Blocks.Interfaces.RealInput TLayers[n]
    "Temperature of Dynamic Storage Layers" annotation (Placement(
        transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-100,30}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-50})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=TLayer_dif)
    annotation (Placement(transformation(extent={{-36,-32},{-16,-10}})));
equation
  connect(TLayers, sumDynamic.u)
    annotation (Line(points={{-100,30},{-72,30}}, color={0,0,127}));
  connect(sumDynamic.y, meanTemperatureBufferStorage.u1) annotation (Line(
        points={{-49,30},{-36,30}},                   color={0,0,127}));
  connect(realExpressionDynamic.y, meanTemperatureBufferStorage.u2) annotation (
     Line(points={{-53,0},{-42,0},{-42,18},{-36,18}}, color={0,0,127}));
  connect(meanTemperatureBufferStorage.y, add.u1) annotation (Line(points={{-13,
          24},{-2,24},{-2,32},{10,32}}, color={0,0,127}));
  connect(realExpression.y, add.u2) annotation (Line(points={{-15,-21},{-15,-10},
          {10,-10},{10,20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end twoPositionController_layers;
