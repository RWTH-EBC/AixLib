within AixLib.Building.Benchmark.Test;
model TestWarmwasser
  Modelica.Fluid.Pipes.DynamicPipe pipe(
    use_HeatTransfer=false,
    redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    length=5,
    diameter=0.3,
    m_flow_start=0,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
    T_start=293.15)
    annotation (Placement(transformation(extent={{-30,-24},{-10,-4}})));

  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS)
    annotation (Placement(transformation(extent={{-4,-24},{16,-4}})));
  AixLib.Fluid.Movers.SpeedControlled_y fan(
    redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    m_flow_small=0.01,
    redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to8 per,
    addPowerToMedium=false,
    T_start=293.15)
    annotation (Placement(transformation(extent={{60,22},{80,42}})));

  Modelica.Blocks.Sources.Ramp ramp(
    height=0.75,
    duration=60,
    offset=0,
    startTime=50)
    annotation (Placement(transformation(extent={{-86,20},{-66,40}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=283.15)   annotation(Placement(transformation(extent={{-40,38},
            {-32,46}})));
  Modelica.Fluid.Sensors.Temperature temperature2(redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS)
    annotation (Placement(transformation(extent={{-48,-4},{-28,16}})));
  Modelica.Fluid.Vessels.OpenTank tank(
    height=1,
    crossArea=1,
    redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    T_start=293.15,
    use_portsData=false,
    nPorts=2)
    annotation (Placement(transformation(extent={{24,32},{38,46}})));

  AixLib.Fluid.Actuators.Valves.ThreeWayLinear val(
    redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    m_flow_nominal=2,
    dpValve_nominal=100,
    y_start=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={18,8})));

  AixLib.Fluid.Storage.BufferStorage bufferStorage(
    useHeatingRod=false,
    upToDownHC1=false,
    redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    redeclare package MediumHC1 =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    redeclare package MediumHC2 =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    TStart(displayUnit="degC") = 283.15,
    data=AixLib.DataBase.Storage.Generic_New_2000l(),
    alphaHC2=10000,
    TStartWall=283.15,
    TStartIns=283.15,
    redeclare model HeatTransfer =
        AixLib.Fluid.Storage.BaseClasses.HeatTransferLambdaEffSmooth)
    annotation (Placement(transformation(extent={{6,26},{-18,56}})));

  Modelica.Fluid.Pipes.DynamicPipe pipe1(
    redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    diameter=0.3,
    m_flow_start=0,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
    length=20,
    use_HeatTransfer=true,
    T_start=293.15,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer)
    annotation (Placement(transformation(extent={{-78,-24},{-58,-4}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T=323.15)  annotation(Placement(transformation(extent={{-88,6},
            {-80,14}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe2(
    use_HeatTransfer=false,
    redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    length=5,
    diameter=0.3,
    m_flow_start=0,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
    T_start=293.15)
    annotation (Placement(transformation(extent={{-20,-82},{0,-62}})));

  Modelica.Fluid.Sensors.Temperature temperature3(redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS)
    annotation (Placement(transformation(extent={{-38,-62},{-18,-42}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe3(
    redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    diameter=0.3,
    m_flow_start=0,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
    length=20,
    use_HeatTransfer=true,
    T_start=293.15,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer)
    annotation (Placement(transformation(extent={{-68,-82},{-48,-62}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature2(T=363.15)  annotation(Placement(transformation(extent={{-78,-52},
            {-70,-44}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunctionIdeal(redeclare package
      Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={88,-26})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate1(redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS)
    annotation (Placement(transformation(extent={{10,-82},{30,-62}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Modelica.Fluid.Sources.FixedBoundary boundary2(
    nPorts=1,
    redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    use_p=true,
    p=100000,
    T=278.15)
    annotation (Placement(transformation(extent={{108,42},{88,62}})));

  Modelica.Fluid.Sources.FixedBoundary boundary1(
    nPorts=1,
    redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    use_p=true,
    p=100000,
    T=278.15)
    annotation (Placement(transformation(extent={{24,76},{4,96}})));

  AixLib.Fluid.Movers.SpeedControlled_y fan1(
    redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    m_flow_small=0.01,
    redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to8 per,
    addPowerToMedium=false,
    T_start=293.15)
    annotation (Placement(transformation(extent={{-40,74},{-20,94}})));

  Modelica.Fluid.Vessels.OpenTank tank1(
    height=1,
    crossArea=1,
    redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS,
    T_start=293.15,
    use_portsData=false,
    nPorts=4)
    annotation (Placement(transformation(extent={{-88,52},{-74,66}})));

  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-86,94},{-66,114}})));
  Modelica.Fluid.Sensors.Temperature temperature1(redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS)
    annotation (Placement(transformation(extent={{54,-8},{74,12}})));
  Modelica.Fluid.Sensors.Temperature temperature4(redeclare package Medium =
        HVAC.Components.HeatExchanger.SubStation.Components.ConstantPropertyLiquidWater_TMax_HS)
    annotation (Placement(transformation(extent={{38,18},{58,38}})));
equation
  connect(temperature2.port, pipe.port_a) annotation (Line(points={{-38,-4},
          {-38,-14},{-30,-14}}, color={0,127,255}));
  connect(fixedTemperature.port, bufferStorage.heatportOutside) annotation (
     Line(points={{-32,42},{-22,42},{-22,41.9},{-17.7,41.9}}, color={191,0,
          0}));
  connect(val.port_2, bufferStorage.portHC2In) annotation (Line(points={{18,
          18},{18,37.25},{6.15,37.25}}, color={0,127,255}));
  connect(fixedTemperature1.port, pipe1.heatPorts[1]) annotation (Line(
        points={{-80,10},{-67.9,10},{-67.9,-9.6}}, color={191,0,0}));
  connect(pipe1.port_b, pipe.port_a)
    annotation (Line(points={{-58,-14},{-30,-14}}, color={0,127,255}));
  connect(temperature3.port, pipe2.port_a) annotation (Line(points={{-28,
          -62},{-28,-72},{-20,-72}}, color={0,127,255}));
  connect(fixedTemperature2.port, pipe3.heatPorts[1]) annotation (Line(
        points={{-70,-48},{-57.9,-48},{-57.9,-67.6}}, color={191,0,0}));
  connect(pipe3.port_b, pipe2.port_a)
    annotation (Line(points={{-48,-72},{-20,-72}}, color={0,127,255}));
  connect(bufferStorage.portHC2Out, tank.ports[1]) annotation (Line(points=
          {{6.15,32.45},{30.075,32.45},{30.075,32},{29.6,32}}, color={0,127,
          255}));
  connect(tank.ports[2], fan.port_a)
    annotation (Line(points={{32.4,32},{60,32}}, color={0,127,255}));
  connect(fan.port_b, teeJunctionIdeal.port_2) annotation (Line(points={{80,
          32},{88,32},{88,-16}}, color={0,127,255}));
  connect(teeJunctionIdeal.port_3, pipe1.port_a) annotation (Line(points={{
          78,-26},{-90,-26},{-90,-14},{-78,-14}}, color={0,127,255}));
  connect(teeJunctionIdeal.port_1, pipe3.port_a) annotation (Line(points={{
          88,-36},{88,-92},{-82,-92},{-82,-72},{-68,-72}}, color={0,127,255}));
  connect(pipe.port_b, massFlowRate.port_a)
    annotation (Line(points={{-10,-14},{-4,-14}}, color={0,127,255}));
  connect(massFlowRate.port_b, val.port_1) annotation (Line(points={{16,-14},
          {18,-14},{18,-2}}, color={0,127,255}));
  connect(pipe2.port_b, massFlowRate1.port_a)
    annotation (Line(points={{0,-72},{10,-72}}, color={0,127,255}));
  connect(massFlowRate1.port_b, val.port_3) annotation (Line(points={{30,
          -72},{40,-72},{40,8},{28,8}}, color={0,127,255}));
  connect(ramp.y, val.y) annotation (Line(points={{-65,30},{-24,30},{-24,8},
          {6,8}}, color={0,0,127}));
  connect(const.y, fan.y)
    annotation (Line(points={{61,70},{70,70},{70,44}}, color={0,0,127}));
  connect(boundary2.ports[1], bufferStorage.portHC1Out) annotation (Line(
        points={{88,52},{16,52},{16,44.9},{6.15,44.9}}, color={0,127,255}));
  connect(fan1.port_b, boundary1.ports[1]) annotation (Line(points={{-20,84},
          {-8,84},{-8,86},{4,86}}, color={0,127,255}));
  connect(fan1.port_a, bufferStorage.portHC1In) annotation (Line(points={{
          -40,84},{-52,84},{-52,88},{-58,88},{-58,62},{10,62},{10,49.55},{
          6.3,49.55}}, color={0,127,255}));
  connect(tank1.ports[1], bufferStorage.fluidportTop2) annotation (Line(
        points={{-83.1,52},{-44,52},{-44,56.15},{-9.75,56.15}}, color={0,
          127,255}));
  connect(bufferStorage.fluidportBottom2, tank1.ports[2]) annotation (Line(
        points={{-9.45,25.85},{-43.725,25.85},{-43.725,52},{-81.7,52}},
        color={0,127,255}));
  connect(bufferStorage.fluidportTop1, tank1.ports[3]) annotation (Line(
        points={{-1.8,56.15},{-1.8,52},{-80.3,52}}, color={0,127,255}));
  connect(bufferStorage.fluidportBottom1, tank1.ports[4]) annotation (Line(
        points={{-1.95,25.7},{-1.95,52},{-78.9,52}}, color={0,127,255}));
  connect(const1.y, fan1.y) annotation (Line(points={{-65,104},{-30,104},{
          -30,96}}, color={0,0,127}));
  connect(temperature1.port, teeJunctionIdeal.port_2) annotation (Line(
        points={{64,-8},{76,-8},{76,-10},{88,-10},{88,-16}}, color={0,127,
          255}));
  connect(temperature4.port, bufferStorage.portHC2In) annotation (Line(
        points={{48,18},{34,18},{34,26},{18,26},{18,37.25},{6.15,37.25}},
        color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestWarmwasser;
