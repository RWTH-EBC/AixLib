within AixLib.Building.Benchmark.Generation;
model Generation_geothermalProbe
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    isCircular=true,
    diameter=0.02,
    height_ab=0,
    use_HeatTransfer=true,
    length=240,
    nNodes=8,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
        (alpha0=100))
    annotation (Placement(transformation(extent={{-10,-14},{10,6}})));

  Modelica.Fluid.Interfaces.FluidPort_b Fulid_out_Geothermal(redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_Geothermal(redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=284.15)   annotation(Placement(transformation(extent={{-82,6},
            {-74,14}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T=285.15)  annotation(Placement(transformation(extent={{-82,26},
            {-74,34}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature2(T=286.15)  annotation(Placement(transformation(extent={{-82,44},
            {-74,52}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature3(T=287.15)  annotation(Placement(transformation(extent={{-82,62},
            {-74,70}})));
equation
  connect(pipe.port_b, Fulid_out_Geothermal)
    annotation (Line(points={{10,-4},{56,-4},{56,60},{100,60}},
                                                color={0,127,255}));
  connect(fixedTemperature.port, pipe.heatPorts[1]) annotation (Line(points={{
          -74,10},{-2.6125,10},{-2.6125,0.4}}, color={191,0,0}));
  connect(pipe.heatPorts[8], fixedTemperature.port) annotation (Line(points={{
          2.8125,0.4},{2.8125,10},{-74,10}}, color={127,0,0}));
  connect(fixedTemperature1.port, pipe.heatPorts[2]) annotation (Line(points={{
          -74,30},{-1.8375,30},{-1.8375,0.4}}, color={191,0,0}));
  connect(pipe.heatPorts[7], fixedTemperature1.port) annotation (Line(points={{
          2.0375,0.4},{2.0375,30},{-74,30}}, color={127,0,0}));
  connect(fixedTemperature2.port, pipe.heatPorts[3]) annotation (Line(points={{
          -74,48},{-1.0625,48},{-1.0625,0.4}}, color={191,0,0}));
  connect(pipe.heatPorts[6], fixedTemperature2.port) annotation (Line(points={{
          1.2625,0.4},{1.2625,48},{-74,48}}, color={127,0,0}));
  connect(fixedTemperature3.port, pipe.heatPorts[4]) annotation (Line(points={{
          -74,66},{-0.2875,66},{-0.2875,0.4}}, color={191,0,0}));
  connect(pipe.heatPorts[5], fixedTemperature3.port) annotation (Line(points={{
          0.4875,0.4},{0.4875,66},{-74,66}}, color={127,0,0}));
  connect(Fluid_in_Geothermal, pipe.port_a) annotation (Line(points={{100,-60},
          {-40,-60},{-40,-4},{-10,-4}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation_geothermalProbe;
