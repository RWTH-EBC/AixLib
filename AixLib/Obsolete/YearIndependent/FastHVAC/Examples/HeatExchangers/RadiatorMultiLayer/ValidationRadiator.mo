within AixLib.Obsolete.YearIndependent.FastHVAC.Examples.HeatExchangers.RadiatorMultiLayer;
model ValidationRadiator
  extends Modelica.Icons.Example;
  Modelica.Fluid.Sources.MassFlowSource_T source(
    use_m_flow_in=true,
    m_flow=1,
    T(displayUnit="K") = 333,
    use_T_in=true,
    nPorts=1,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-80,26},{-60,46}})));
  Modelica.Fluid.Pipes.StaticPipe pipe1(
    length=10,
    diameter=0.02,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{32,38},{48,52}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature T_room1(T=293.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-62,74})));
  inner Modelica.Fluid.System system(p_start=system.p_ambient,
      p_ambient(displayUnit="Pa"))
    annotation (Placement(transformation(extent={{60,80},{80,100}})));
  Modelica.Fluid.Sensors.Temperature temperatureOut(redeclare package
      Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{16,60},{36,80}})));
  Modelica.Fluid.Sources.FixedBoundary
                                  sink(
    nPorts=1, redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-11,-11},{11,11}},
        rotation=180,
        origin={67,45})));
  Modelica.Blocks.Sources.Constant dotm_source1(k=0.0405)
    annotation (Placement(transformation(extent={{-120,64},{-100,84}})));
  Modelica.Blocks.Sources.Constant T_source1(k=348.15)
    annotation (Placement(transformation(extent={{-120,30},{-100,50}})));
  Fluid.HeatExchangers.Radiators.Radiator radiatorFluid(
    selectable=true,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    radiatorType=
        DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment.Radiator_Livingroom(),
    m_flow_nominal=0.05,
    calc_dT=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp.exp)
    annotation (Placement(transformation(extent={{-36,22},{6,64}})));

  Modelica.Blocks.Sources.Constant T_source(k=348.15)
    annotation (Placement(transformation(extent={{-110,-56},{-90,-36}})));
  Components.Sinks.Vessel vessel
    annotation (Placement(transformation(extent={{44,-68},{66,-50}})));

  Modelica.Blocks.Sources.Constant dotm_source(k=0.0405)
    annotation (Placement(transformation(extent={{-110,-88},{-90,-68}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature T_room(T=293.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-58,-30})));
  Components.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{14,-68},{32,-50}})));
  Components.HeatExchangers.RadiatorMultiLayer radiatorFastHvac(
    selectable=true,
    medium=FastHVAC.Media.WaterSimple(),
    radiatorType=
        DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment.Radiator_Livingroom(),
    calc_dT=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp.exp)
    annotation (Placement(transformation(extent={{-32,-76},{2,-42}})));

  Components.Pumps.FluidSource fluidSource(medium=
        FastHVAC.Media.WaterSimple(c=4119, rho=995))
    annotation (Placement(transformation(extent={{-64,-70},{-44,-50}})));
equation

  connect(temperatureSensor.enthalpyPort_b, vessel.enthalpyPort_a)
    annotation (Line(
      points={{31.1,-59.09},{39.55,-59.09},{39.55,-59},{47.3,-59}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(radiatorFastHvac.enthalpyPort_b1, temperatureSensor.enthalpyPort_a)
    annotation (Line(
      points={{-1.4,-59.34},{-0.7,-59.34},{-0.7,-59.09},{15.08,-59.09}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(fluidSource.enthalpyPort_b, radiatorFastHvac.enthalpyPort_a1)
    annotation (Line(
      points={{-44,-59},{-29,-59},{-29,-59.34},{-28.6,-59.34}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(T_source.y, fluidSource.T_fluid) annotation (Line(
      points={{-89,-46},{-62,-46},{-62,-55.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_room.port, radiatorFastHvac.RadiativeHeat) annotation (Line(
      points={{-48,-30},{-5.48,-30},{-5.48,-48.8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(T_room.port, radiatorFastHvac.ConvectiveHeat) annotation (Line(
      points={{-48,-30},{-24.18,-30},{-24.18,-49.14}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(dotm_source.y, fluidSource.dotm) annotation (Line(
      points={{-89,-78},{-62,-78},{-62,-62.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pipe1.port_b,sink. ports[1]) annotation (Line(
      points={{48,45},{56,45}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(temperatureOut.port,pipe1. port_a) annotation (Line(
      points={{26,60},{26,45},{32,45}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(T_source1.y,source. T_in) annotation (Line(
      points={{-99,40},{-82,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dotm_source1.y,source. m_flow_in) annotation (Line(
      points={{-99,74},{-98,74},{-98,44},{-80,44}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(source.ports[1], radiatorFluid.port_a) annotation (Line(
      points={{-60,36},{-48,36},{-48,43},{-36,43}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(radiatorFluid.port_b, pipe1.port_a) annotation (Line(
      points={{6,43},{10,43},{10,45},{32,45}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(radiatorFluid.ConvectiveHeat, T_room1.port) annotation (Line(
      points={{-19.2,47.2},{-22,47.2},{-22,74},{-52,74}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(radiatorFluid.RadiativeHeat, T_room1.port) annotation (Line(
      points={{-6.6,47.2},{-8,47.2},{-8,74},{-52,74}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -100},{80,100}}),  graphics={
        Rectangle(
          extent={{-120,100},{80,2}},
          lineColor={170,213,255},
          fillPattern=FillPattern.Solid,
          fillColor={170,213,255}),
        Text(
          extent={{-48,98},{0,84}},
          lineColor={0,0,255},
          fillColor={213,170,255},
          fillPattern=FillPattern.Solid,
          textString="HVAC"),
        Rectangle(
          extent={{-120,-2},{80,-100}},
          lineColor={215,215,215},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-44,-2},{4,-16}},
          lineColor={0,0,255},
          fillColor={213,170,255},
          fillPattern=FillPattern.Solid,
          textString="FastHVAC")}),       Icon(graphics,
                                               coordinateSystem(extent={{-120,
            -100},{80,100}})),
    experiment(StopTime=86400));
end ValidationRadiator;
