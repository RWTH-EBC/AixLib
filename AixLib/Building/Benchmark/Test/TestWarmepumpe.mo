within AixLib.Building.Benchmark.Test;
model TestWarmepumpe

  AixLib.Fluid.HeatPumps.HeatPumpDetailed heatPumpDetailed(
    capCalcType=2,
    dataTable=AixLib.DataBase.HeatPump.EN255.Vitocal350BWH113(),
    P_eleOutput=true,
    redeclare package Medium_con =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    dp_conNominal=10000,
    redeclare package Medium_eva =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    dp_evaNominal=10000,
    T_startEva=283.15,
    T_startCon=313.15)
    annotation (Placement(transformation(extent={{-14,-10},{16,10}})));

  Modelica.Fluid.Sources.FixedBoundary boundary1(
    use_p=true,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    p=1000,
    T=283.15)
    annotation (Placement(transformation(extent={{-88,-30},{-68,-10}})));

  AixLib.Fluid.Movers.SpeedControlled_y fan1(
    m_flow_small=0.01,
    redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to8 per,
    addPowerToMedium=false,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    T_start=283.15)
    annotation (Placement(transformation(extent={{-48,8},{-28,28}})));

  Modelica.Fluid.Sources.FixedBoundary boundary3(
    use_p=true,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    p=1000,
    T=278.15)
    annotation (Placement(transformation(extent={{100,36},{80,56}})));

  AixLib.Fluid.Movers.SpeedControlled_y fan2(
    m_flow_small=0.01,
    redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to8 per,
    addPowerToMedium=false,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    T_start=313.15)
    annotation (Placement(transformation(extent={{82,-18},{62,2}})));

  Modelica.Fluid.Sources.FixedBoundary boundary4(
    use_p=true,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    p=10000,
    T=323.15)
    annotation (Placement(transformation(extent={{104,-26},{84,-6}})));

  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{36,6},{56,26}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-30,-30},{-50,-10}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=20)
    annotation (Placement(transformation(extent={{-58,54},{-38,74}})));
  Modelica.Fluid.Sources.Boundary_pT boundary(
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    p=10000)
    annotation (Placement(transformation(extent={{-90,8},{-70,28}})));

  Modelica.Blocks.Sources.Constant const3(k=280)
    annotation (Placement(transformation(extent={{-128,12},{-108,32}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    rising=10,
    width=50,
    falling=10,
    offset=0,
    startTime=10,
    period=100,
    amplitude=3.1)
    annotation (Placement(transformation(extent={{102,6},{82,26}})));
  Modelica.Blocks.Sources.Constant const2(k=0.9)
    annotation (Placement(transformation(extent={{-98,44},{-78,64}})));
equation
  connect(fan1.port_b, heatPumpDetailed.port_evaIn) annotation (Line(points=
         {{-28,18},{-20,18},{-20,7},{-12,7}}, color={0,127,255}));
  connect(boundary4.ports[1], fan2.port_a) annotation (Line(points={{84,-16},
          {84,-8},{82,-8}}, color={0,127,255}));
  connect(fan2.port_b, heatPumpDetailed.port_conIn) annotation (Line(points=
         {{62,-8},{30,-8},{30,-7},{14,-7}}, color={0,127,255}));
  connect(massFlowRate.port_a, heatPumpDetailed.port_conOut) annotation (
      Line(points={{36,16},{26,16},{26,7},{14,7}}, color={0,127,255}));
  connect(massFlowRate.port_b, boundary3.ports[1]) annotation (Line(points=
          {{56,16},{68,16},{68,46},{80,46}}, color={0,127,255}));
  connect(massFlowRate1.port_b, boundary1.ports[1])
    annotation (Line(points={{-50,-20},{-68,-20}}, color={0,127,255}));
  connect(massFlowRate1.port_a, heatPumpDetailed.port_evaOut) annotation (
      Line(points={{-30,-20},{-22,-20},{-22,-7},{-12,-7}}, color={0,127,255}));
  connect(booleanStep.y, heatPumpDetailed.onOff_in)
    annotation (Line(points={{-37,64},{-4,64},{-4,9}}, color={255,0,255}));
  connect(boundary.ports[1], fan1.port_a)
    annotation (Line(points={{-70,18},{-48,18}}, color={0,127,255}));
  connect(const3.y, boundary.T_in)
    annotation (Line(points={{-107,22},{-92,22}}, color={0,0,127}));
  connect(const2.y, fan1.y) annotation (Line(points={{-77,54},{-58,54},{-58,
          30},{-38,30}}, color={0,0,127}));
  connect(trapezoid.y, fan2.y) annotation (Line(points={{81,16},{76,16},{76,
          4},{72,4}}, color={0,0,127}));
end TestWarmepumpe;
