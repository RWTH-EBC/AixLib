within ;
partial block partialCalcSOC "Partial block to calculate the state of charge"

  parameter Integer nLayersDynamic = 10 "Number of layers in dynamic storage";
  parameter Integer nLayersStatic = 10 "Number of layers in static storage";

  parameter Modelica.SIunits.Volume DynamicStorageVolume=6 "Volume of dynamic storage" annotation (Dialog(tab= "",  group=""));
  parameter Modelica.SIunits.Volume StaticStorageVolume=6 "Volume of static storage" annotation (Dialog(tab= "", group=""));

  Modelica.Blocks.Interfaces.RealInput TLayersDynamic[nLayersDynamic]
    "Temperature of Dynamic Storage Layers"
    annotation (Placement(transformation(extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-50}),
                          iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-50})));
  Modelica.Blocks.Interfaces.RealInput TLayersStatic[nLayersStatic]
    "Temperature of Static Storage Layers"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,-50}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,-50})));
  BusSystems.EnergySystemBus energySystemBus
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));

  Modelica.Blocks.Math.Sum sumDynamic(nin=nLayersDynamic)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Blocks.Math.Sum sumStatic(nin=nLayersDynamic)
    annotation (Placement(transformation(extent={{80,-60},{60,-40}})));
  Modelica.Blocks.Math.Division meanTemperatureDynamicStorage
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpressionDynamic(y=nLayersDynamic)
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Modelica.Blocks.Math.Division meanTemperatureStaticStorage
    annotation (Placement(transformation(extent={{40,-70},{20,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpressionStatic(y=nLayersStatic)
    annotation (Placement(transformation(extent={{80,-90},{60,-70}})));
equation

  connect(TLayersDynamic, sumDynamic.u) annotation (Line(points={{-120,-50},{-82,-50}}, color={0,0,127}));
  connect(TLayersStatic, sumStatic.u) annotation (Line(points={{120,-50},{82,-50}}, color={0,0,127}));
  connect(sumDynamic.y, meanTemperatureDynamicStorage.u1)
    annotation (Line(points={{-59,-50},{-50,-50},{-50,-54},{-42,-54}}, color={0,0,127}));
  connect(sumStatic.y, meanTemperatureStaticStorage.u1)
    annotation (Line(points={{59,-50},{50,-50},{50,-54},{42,-54}}, color={0,0,127}));
  connect(realExpressionDynamic.y, meanTemperatureDynamicStorage.u2)
    annotation (Line(points={{-59,-80},{-50,-80},{-50,-66},{-42,-66}}, color={0,0,127}));
  connect(realExpressionStatic.y, meanTemperatureStaticStorage.u2)
    annotation (Line(points={{59,-80},{50,-80},{50,-66},{42,-66}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
                                 Text(
          extent={{-149,-113},{151,-153}},
          lineColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255},
          textString="%name"),   Text(
          extent={{-148,26},{151,-29}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255},
          textString="SOC")}),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end partialCalcSOC;
