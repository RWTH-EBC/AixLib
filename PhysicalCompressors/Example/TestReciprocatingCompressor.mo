within PhysicalCompressors.Example;
model TestReciprocatingCompressor
  ReciprocatingCompressor.Geometry.Volumes volumes
    annotation (Placement(transformation(extent={{-28,50},{-8,70}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=20)
    annotation (Placement(transformation(extent={{-72,74},{-52,94}})));
  Modelica.Fluid.Sources.FixedBoundary boundary(
    use_p=true,
    use_T=true,
    T(displayUnit="K") = 250,
    redeclare package Medium = ReciprocatingCompressor.Medium,
    p=500000) annotation (Placement(transformation(extent={{-78,30},{-58,50}})));
  Modelica.Fluid.Sources.FixedBoundary boundary1(
    T(displayUnit="K") = 300,
    redeclare package Medium = ReciprocatingCompressor.Medium,
    p=6000000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={48,40})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=
        10) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-6,14})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Ambient(T=298.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-6,-74})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor CompressorWall(C=200,
      T(start=298.15)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-24,-16})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G
      =10) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-6,-38})));
  ReciprocatingCompressor.test_closedVolume3 test_closedVolume3_1
    annotation (Placement(transformation(extent={{-16,32},{4,52}})));
equation
  connect(constantSpeed.flange, volumes.flange_a) annotation (Line(points={{-52,
          84},{-44,84},{-44,60},{-28,60}}, color={0,0,0}));
  connect(thermalConductor.port_a, CompressorWall.port)
    annotation (Line(points={{-6,4},{-6,-16},{-14,-16}}, color={191,0,0}));
  connect(Ambient.port, thermalConductor1.port_a)
    annotation (Line(points={{-6,-64},{-6,-48}}, color={191,0,0}));
  connect(thermalConductor1.port_b, CompressorWall.port)
    annotation (Line(points={{-6,-28},{-6,-16},{-14,-16}}, color={191,0,0}));
  connect(volumes.V1, test_closedVolume3_1.u)
    annotation (Line(points={{-7,60},{-6,60},{-6,52}}, color={0,0,127}));
  connect(test_closedVolume3_1.port_a, thermalConductor.port_b)
    annotation (Line(points={{-6,32},{-6,24}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestReciprocatingCompressor;
