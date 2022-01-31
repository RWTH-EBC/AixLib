within ControlUnity;
model hierarchicalControl_Tester

  parameter Real x[3]= {273.15+52, 273.15+55, 273.15+58};

  Modelica.Blocks.Sources.RealExpression realExpression(y=0.2)
    annotation (Placement(transformation(extent={{-96,36},{-76,56}})));
  Modelica.Blocks.Sources.RealExpression Tamb[3](y=x)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  twoPositionController.BaseClass.twoPositionControllerCal.TwoPositionController_layers
    twoPositionController_layers(bandwidth=2)
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
equation


  connect(realExpression.y, twoPositionController_layers.PLRin) annotation (
      Line(points={{-75,46},{-58,46},{-58,49},{-40,49}}, color={0,0,127}));
  connect(Tamb.y, twoPositionController_layers.TLayers) annotation (Line(points=
         {{-79,20},{-60,20},{-60,43.6},{-40,43.6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end hierarchicalControl_Tester;
