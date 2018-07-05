within AixLib.Building.Benchmark.Test;
model TestErdsonde

  HVAC.Components.GeothermalField.Ground.BoundaryDeepGroundLinear
    boundaryDeepGroundLinear(depth=190, gradient=0.03)
    annotation (Placement(transformation(extent={{-108,-56},{-88,-36}})));
  HVAC.Components.GeothermalField.BoreHoleHeatExchanger.UPipe uPipe(
    redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    boreholeDepth=190,
    boreholeDiameter=0.5,
    boreholeFilling=DataBase.Materials.FillingMaterials.Concrete(),
    n=10,
    pipeType=DataBase.Pipes.Copper.Copper_22x0_9(),
    T_start=278.15)
    annotation (Placement(transformation(extent={{-88,-8},{-72,8}})));

  Modelica.Fluid.Sources.FixedBoundary boundary1(
    redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    use_p=true,
    nPorts=1,
    p=100000,
    T=293.15)
    annotation (Placement(transformation(extent={{172,-2},{152,18}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  HVAC.Components.GeothermalField.BoreHoleHeatExchanger.UPipe uPipe1(
    redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    boreholeDepth=190,
    boreholeDiameter=0.5,
    boreholeFilling=DataBase.Materials.FillingMaterials.Concrete(),
    n=10,
    pipeType=DataBase.Pipes.Copper.Copper_22x0_9(),
    T_start=278.15)
    annotation (Placement(transformation(extent={{-44,-8},{-28,8}})));

  HVAC.Components.GeothermalField.BoreHoleHeatExchanger.UPipe uPipe2(
    redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    boreholeDepth=190,
    boreholeDiameter=0.5,
    boreholeFilling=DataBase.Materials.FillingMaterials.Concrete(),
    n=10,
    pipeType=DataBase.Pipes.Copper.Copper_22x0_9(),
    T_start=278.15)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}})));

  HVAC.Components.GeothermalField.BoreHoleHeatExchanger.UPipe uPipe3(
    redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    boreholeDepth=190,
    boreholeDiameter=0.5,
    boreholeFilling=DataBase.Materials.FillingMaterials.Concrete(),
    n=10,
    pipeType=DataBase.Pipes.Copper.Copper_22x0_9(),
    T_start=278.15)
    annotation (Placement(transformation(extent={{22,-8},{38,8}})));

  HVAC.Components.GeothermalField.BoreHoleHeatExchanger.UPipe uPipe4(
    redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    boreholeDepth=190,
    boreholeDiameter=0.5,
    boreholeFilling=DataBase.Materials.FillingMaterials.Concrete(),
    n=10,
    pipeType=DataBase.Pipes.Copper.Copper_22x0_9(),
    T_start=278.15)
    annotation (Placement(transformation(extent={{48,-8},{64,8}})));

  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS)
    annotation (Placement(transformation(extent={{72,-2},{92,18}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate1(
                                                   redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS)
    annotation (Placement(transformation(extent={{-116,24},{-96,44}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate3(
                                                   redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS)
    annotation (Placement(transformation(extent={{122,-2},{142,18}})));
  Modelica.Fluid.Sensors.Temperature temperature5(redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS)
    annotation (Placement(transformation(extent={{98,8},{118,28}})));
  Modelica.Fluid.Sources.FixedBoundary boundary2(
    redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    use_p=true,
    nPorts=1,
    p=100000,
    T=293.15)
    annotation (Placement(transformation(extent={{-178,24},{-158,44}})));
  AixLib.Fluid.Movers.SpeedControlled_y fan1(
    redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    m_flow_small=0.01,
    addPowerToMedium=false,
    T_start=293.15,
    redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12 per)
    annotation (Placement(transformation(extent={{-146,24},{-126,44}})));
  Modelica.Blocks.Sources.Constant const1(k=4)
    annotation (Placement(transformation(extent={{-176,72},{-156,92}})));
equation
  connect(boundaryDeepGroundLinear.outerThermalBoundary, uPipe.thermalConnectors2Ground)
    annotation (Line(points={{-91,-45},{-87.5,-45},{-87.5,2},{-84,2}},
        color={191,0,0}));
  connect(uPipe1.thermalConnectors2Ground, boundaryDeepGroundLinear.outerThermalBoundary)
    annotation (Line(points={{-40,2},{-66,2},{-66,-45},{-91,-45}}, color={
          191,0,0}));
  connect(uPipe2.thermalConnectors2Ground, boundaryDeepGroundLinear.outerThermalBoundary)
    annotation (Line(points={{-4,2},{-46,2},{-46,-45},{-91,-45}}, color={
          191,0,0}));
  connect(uPipe3.thermalConnectors2Ground, boundaryDeepGroundLinear.outerThermalBoundary)
    annotation (Line(points={{26,2},{-32,2},{-32,-45},{-91,-45}}, color={
          191,0,0}));
  connect(uPipe4.thermalConnectors2Ground, boundaryDeepGroundLinear.outerThermalBoundary)
    annotation (Line(points={{52,2},{-18,2},{-18,-45},{-91,-45}}, color={
          191,0,0}));
  connect(massFlowRate.port_a, uPipe4.fluidPortOut)
    annotation (Line(points={{72,8},{58,8}}, color={0,127,255}));
  connect(massFlowRate1.port_b, uPipe.fluidPortIn) annotation (Line(points=
          {{-96,34},{-90,34},{-90,8},{-82,8}}, color={0,127,255}));
  connect(boundary1.ports[1], massFlowRate3.port_b)
    annotation (Line(points={{152,8},{142,8}}, color={0,127,255}));
  connect(massFlowRate3.port_a, massFlowRate.port_b)
    annotation (Line(points={{122,8},{92,8}}, color={0,127,255}));
  connect(massFlowRate3.port_a, temperature5.port)
    annotation (Line(points={{122,8},{108,8}}, color={0,127,255}));
  connect(const1.y,fan1. y) annotation (Line(points={{-155,82},{-136,82},{
          -136,46}},color={0,0,127}));
  connect(fan1.port_b, massFlowRate1.port_a)
    annotation (Line(points={{-126,34},{-116,34}}, color={0,127,255}));
  connect(fan1.port_a, boundary2.ports[1])
    annotation (Line(points={{-146,34},{-158,34}}, color={0,127,255}));
  connect(uPipe1.fluidPortIn, uPipe.fluidPortIn) annotation (Line(points={{
          -38,8},{-40,8},{-40,34},{-90,34},{-90,8},{-82,8}}, color={0,127,
          255}));
  connect(uPipe2.fluidPortIn, uPipe.fluidPortIn) annotation (Line(points={{
          -2,8},{-4,8},{-4,34},{-90,34},{-90,8},{-82,8}}, color={0,127,255}));
  connect(uPipe3.fluidPortIn, uPipe.fluidPortIn) annotation (Line(points={{
          28,8},{26,8},{26,30},{-4,30},{-4,34},{-90,34},{-90,8},{-82,8}},
        color={0,127,255}));
  connect(uPipe4.fluidPortIn, uPipe.fluidPortIn) annotation (Line(points={{
          54,8},{54,30},{-4,30},{-4,34},{-90,34},{-90,8},{-82,8}}, color={0,
          127,255}));
  connect(uPipe.fluidPortOut, uPipe4.fluidPortOut) annotation (Line(points=
          {{-78,8},{-54,8},{-54,-24},{70,-24},{70,8},{58,8}}, color={0,127,
          255}));
  connect(uPipe1.fluidPortOut, uPipe4.fluidPortOut) annotation (Line(points=
         {{-34,8},{-24,8},{-24,6},{-10,6},{-10,-24},{70,-24},{70,8},{58,8}},
        color={0,127,255}));
  connect(uPipe2.fluidPortOut, uPipe4.fluidPortOut) annotation (Line(points=
         {{2,8},{16,8},{16,-24},{70,-24},{70,8},{58,8}}, color={0,127,255}));
  connect(uPipe3.fluidPortOut, uPipe4.fluidPortOut) annotation (Line(points=
         {{32,8},{40,8},{40,-16},{44,-16},{44,-24},{70,-24},{70,8},{58,8}},
        color={0,127,255}));
  annotation ();
end TestErdsonde;
