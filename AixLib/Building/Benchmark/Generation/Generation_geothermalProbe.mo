within AixLib.Building.Benchmark.Generation;
model Generation_geothermalProbe

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
  Modelica.Fluid.Pipes.DynamicPipe pipe2(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    allowFlowReversal=true,
    nParallel=1,
    length=240,
    isCircular=true,
    diameter=0.02,
    roughness=2.5e-5,
    height_ab=0,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    use_T_start=true,
    h_start=100,
    momentumDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    m_flow_start=0,
    nNodes=8,
    use_HeatTransfer=true,
    useLumpedPressure=false,
    useInnerPortProperties=false,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_vb,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer (
          T_ambient=293.15),
    crossArea=1,
    perimeter=0.5,
    C_start=fill(0, 0),
    p_a_start=100000,
    p_b_start=100000,
    T_start=293.15,
    X_start={0})
    annotation (Placement(transformation(extent={{-30,-26},{6,10}})));
equation
  connect(pipe2.port_b, Fulid_out_Geothermal) annotation (Line(points={{6,-8},{
          46,-8},{46,60},{100,60}}, color={0,127,255}));
  connect(pipe2.port_a, Fluid_in_Geothermal) annotation (Line(points={{-30,-8},
          {-62,-8},{-62,-60},{100,-60}}, color={0,127,255}));
  connect(fixedTemperature.port, pipe2.heatPorts[1]) annotation (Line(points={{
          -74,10},{-16.7025,10},{-16.7025,-0.08}}, color={191,0,0}));
  connect(fixedTemperature.port, pipe2.heatPorts[8]) annotation (Line(points={{
          -74,10},{-6.9375,10},{-6.9375,-0.08}}, color={191,0,0}));
  connect(fixedTemperature1.port, pipe2.heatPorts[2]) annotation (Line(points={
          {-74,30},{-15.3075,30},{-15.3075,-0.08}}, color={191,0,0}));
  connect(fixedTemperature1.port, pipe2.heatPorts[7]) annotation (Line(points={
          {-74,30},{-8.3325,30},{-8.3325,-0.08}}, color={191,0,0}));
  connect(fixedTemperature2.port, pipe2.heatPorts[3]) annotation (Line(points={
          {-74,48},{-44,48},{-44,48},{-13.9125,48},{-13.9125,-0.08}}, color={
          191,0,0}));
  connect(fixedTemperature2.port, pipe2.heatPorts[6]) annotation (Line(points={
          {-74,48},{-9.7275,48},{-9.7275,-0.08}}, color={191,0,0}));
  connect(fixedTemperature3.port, pipe2.heatPorts[4]) annotation (Line(points={
          {-74,66},{-12.5175,66},{-12.5175,-0.08}}, color={191,0,0}));
  connect(fixedTemperature3.port, pipe2.heatPorts[5]) annotation (Line(points={
          {-74,66},{-11.1225,66},{-11.1225,-0.08}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation_geothermalProbe;
