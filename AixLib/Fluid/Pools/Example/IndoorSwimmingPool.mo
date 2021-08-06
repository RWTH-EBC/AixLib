within AixLib.Fluid.Pools.Example;
model IndoorSwimmingPool
    extends Modelica.Icons.Example;
  AixLib.Fluid.Pools.IndoorSwimmingPool                indoorSwimmingPool2_1(poolParam=
       AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools.SportPool(
        use_idealHeatExchanger=false),redeclare package WaterMedium =
        WaterMedium)
    annotation (Placement(transformation(extent={{-36,-36},{32,38}})));

    replaceable package WaterMedium = AixLib.Media.Water (
    cp_const = 4180,
    d_const = 995.65,
    eta_const = 0.00079722,
    lambda_const = 0.61439)
    "Water properties for water with 30 °C" annotation (choicesAllMatching=true);

  Modelica.Blocks.Sources.RealExpression TSoil(y=8)
    annotation (Placement(transformation(extent={{88,32},{72,48}})));
  Modelica.Blocks.Sources.RealExpression X_W(y=14.3)
    annotation (Placement(transformation(extent={{88,58},{72,74}})));
  Modelica.Blocks.Sources.RealExpression T_Air(y=20)
    annotation (Placement(transformation(extent={{86,80},{70,96}})));
  Modelica.Blocks.Sources.Step step(
    height=1,
    offset=0,
    startTime=3600)
    annotation (Placement(transformation(extent={{-86,74},{-72,88}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1 - 0.6,
    duration=7200,
    offset=0.6,
    startTime=3600)
    annotation (Placement(transformation(extent={{-86,42},{-72,56}})));
  Modelica.Blocks.Interfaces.RealOutput QEvap1
                     "Heat needed to compensate losses"
    annotation (Placement(transformation(extent={{96,-6},{118,16}}),
        iconTransformation(extent={{96,-6},{118,16}})));
  Modelica.Blocks.Interfaces.RealOutput PPool1
    "Output eletric energy needed for pool operation"
    annotation (Placement(transformation(extent={{96,-28},{116,-8}})));
  Modelica.Blocks.Interfaces.RealOutput MFlowFreshWater1
    "Flow rate of added fresh water to the pool and water treatment system"
    annotation (Placement(transformation(extent={{96,-52},{116,-32}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(redeclare package Medium =
        WaterMedium,
    m_flow=150,
    T=293.15,                                    nPorts=1) if
    indoorSwimmingPool2_1.poolParam.use_idealHeatExchanger == false
    annotation (Placement(transformation(extent={{-88,-88},{-68,-66}})));
  AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        WaterMedium,
    p=200000,                          nPorts=1) if indoorSwimmingPool2_1.poolParam.use_idealHeatExchanger
     == false
    annotation (Placement(transformation(extent={{-90,-48},{-70,-28}})));
equation
  connect(TSoil.y, indoorSwimmingPool2_1.TSoil) annotation (Line(points={{71.2,40},
          {64,40},{64,25.79},{33.02,25.79}},     color={0,0,127}));
  connect(indoorSwimmingPool2_1.X_w, X_W.y) annotation (Line(points={{20.1,
          40.59},{20.1,66},{71.2,66}}, color={0,0,127}));
  connect(indoorSwimmingPool2_1.TAir, T_Air.y) annotation (Line(points={{7.86,
          40.59},{7.86,88},{69.2,88}}, color={0,0,127}));
  connect(step.y, indoorSwimmingPool2_1.openingHours) annotation (Line(points={{-71.3,
          81},{-54.65,81},{-54.65,31.71},{-36.34,31.71}},        color={0,0,127}));
  connect(ramp.y, indoorSwimmingPool2_1.persons) annotation (Line(points={{-71.3,
          49},{-57.65,49},{-57.65,17.65},{-36.34,17.65}}, color={0,0,127}));
  connect(indoorSwimmingPool2_1.QEvap, QEvap1)
    annotation (Line(points={{35.4,5.44},{107,5.44},{107,5}},
                                                            color={0,0,127}));
  connect(indoorSwimmingPool2_1.PPool, PPool1) annotation (Line(points={{35.4,
          -18.24},{44.7,-18.24},{44.7,-18},{106,-18}},
                                              color={0,0,127}));
  connect(indoorSwimmingPool2_1.MFlowFreshWater, MFlowFreshWater1) annotation (
      Line(points={{35.4,-30.82},{48,-30.82},{48,-42},{106,-42}},color={0,0,127}));
  connect(boundary.ports[1], indoorSwimmingPool2_1.port_a1) annotation (Line(
        points={{-68,-77},{-50,-77},{-50,-9.36},{-36,-9.36}},
        color={0,127,255}));
  connect(bou.ports[1], indoorSwimmingPool2_1.port_b1) annotation (Line(points={{-70,-38},
          {-54,-38},{-54,0},{-36,0},{-36,-0.48}},       color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10800, __Dymola_Algorithm="Dassl"));
end IndoorSwimmingPool;
