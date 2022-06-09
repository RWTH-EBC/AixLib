within AixLib.Fluid.Pools.obsolete;
model MultiplePools

  replaceable parameter AixLib.Fluid.Pools.obsolete.SwimmingHallMultiplePools
    Swimminghall "Choose setup for this zone"
    annotation (choicesAllMatching=true);

  final parameter Boolean use_swimmingPools = Swimminghall.use_swimmingPools;
  final parameter Integer numPools = Swimminghall.numPools;

  parameter AixLib.DataBase.Pools.IndoorSwimmingPoolBaseRecord poolParam[numPools] = Swimminghall.poolParam
    "Setup for Swimming Pools" annotation (choicesAllMatching=false,Dialog(tab="Moisture", group="Swimming Pools", enable = use_swimmingPools));
    //if use_swimmingPools and  ATot > 0

  IndoorSwimmingPool indoorSwimmingPool[numPools] if
                              use_swimmingPools
    annotation (Placement(transformation(extent={{-38,-46},{16,18}})));
  Modelica.Blocks.Interfaces.RealInput TSoil if
    use_swimmingPools "Temperature of Soil"
    annotation (Placement(transformation(extent={{128,62},{88,102}})));
  Modelica.Blocks.Interfaces.RealInput X_w if
    use_swimmingPools "Absolute humidty of the room Air"
    annotation (Placement(transformation(extent={{-128,64},{-88,104}})));
  Modelica.Blocks.Interfaces.RealInput TAir if
    use_swimmingPools "Temperature of the surrounding room air"
    annotation (Placement(transformation(extent={{-128,34},{-88,74}})));
  Modelica.Blocks.Interfaces.RealInput openingHours if
    use_swimmingPools "Input profile for opening hours"
    annotation (Placement(transformation(extent={{-124,0},{-84,40}}),
        iconTransformation(extent={{-124,0},{-84,40}})));
  Modelica.Blocks.Interfaces.RealInput persons if  use_swimmingPools
   "Input profile for persons" annotation (Placement(transformation(extent={{-122,
            -30},{-82,10}}), iconTransformation(extent={{-122,-30},{-82,10}})));
  Modelica.Blocks.Interfaces.RealOutput QEvap1[numPools] if
    use_swimmingPools
                     "Heat needed to compensate losses"
    annotation (Placement(transformation(extent={{96,-20},{116,0}})));
  Modelica.Blocks.Interfaces.RealOutput QPool1[numPools] if
    use_swimmingPools
    "Heat flow rate to maintain the pool at the set temperature"
    annotation (Placement(transformation(extent={{96,-38},{116,-18}})));
  Modelica.Blocks.Interfaces.RealOutput PPool1[numPools] if
    use_swimmingPools
    "Output eletric energy needed for pool operation"
    annotation (Placement(transformation(extent={{96,-54},{116,-34}})));
  Modelica.Blocks.Interfaces.RealOutput MFlowFreshWater1[numPools] if use_swimmingPools
    "Flow rate of added fresh water to the pool and water treatment system"
    annotation (Placement(transformation(extent={{96,-74},{116,-54}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a convPoolSurface1[size(
    indoorSwimmingPool, 1)]
    "Air Temperature in Zone"
    annotation (Placement(transformation(extent={{38,88},{58,108}})));
  Utilities.Interfaces.RadPort radPoolSurface1[size(indoorSwimmingPool, 1)]
  "Mean Radiation Temperature of surrounding walls"
    annotation (Placement(transformation(extent={{12,90},{32,110}})));
  Modelica.Blocks.Interfaces.RealOutput T_Pool1[size(indoorSwimmingPool, 1)]
                                               "Value of Real output"
    annotation (Placement(transformation(extent={{94,16},{114,36}})));

  parameter Integer numNonIdeal = numPools - sum(if poolParam[i].use_idealHeatExchanger then 1 else 0 for i in 1:numPools);
equation

  if use_swimmingPools then
      connect(indoorSwimmingPool.TSoil, TSoil) annotation (Line(points={{16.81,7.44},
            {62,7.44},{62,82},{108,82}},
                              color={0,0,127}));
      connect(indoorSwimmingPool.X_w, X_w) annotation (Line(points={{6.55,20.24},
            {6.55,84.12},{-108,84.12},{-108,84}},
                                    color={0,0,127}));
      connect(indoorSwimmingPool.TAir, TAir) annotation (Line(points={{-3.17,20.24},
            {-3.17,54},{-108,54}},       color={0,0,127}));
      connect(indoorSwimmingPool.openingHours, openingHours) annotation (Line(
        points={{-38.27,12.56},{-60,12.56},{-60,20},{-104,20}},
                                                      color={0,0,127}));
      connect(indoorSwimmingPool.persons, persons) annotation (Line(points={{-38.27,
            0.4},{-68,0.4},{-68,-10},{-102,-10}},
                                      color={0,0,127}));
      connect(indoorSwimmingPool.QEvap, QEvap1) annotation (Line(points={{18.7,-10.16},
            {106,-10.16},{106,-10}},
                                 color={0,0,127}));
      connect(indoorSwimmingPool.QPool, QPool1) annotation (Line(points={{18.7,-19.76},
            {40,-19.76},{40,-28},{106,-28}},
                                          color={0,0,127}));
      connect(indoorSwimmingPool.PPool, PPool1) annotation (Line(points={{18.7,-30.64},
            {32,-30.64},{32,-44},{106,-44}},       color={0,0,127}));
      connect(indoorSwimmingPool.MFlowFreshWater, MFlowFreshWater1) annotation (
      Line(points={{18.7,-41.52},{26,-41.52},{26,-64},{106,-64}},color={0,0,127}));
  end if;

  connect(indoorSwimmingPool.convPoolSurface, convPoolSurface1) annotation (
      Line(points={{-14.78,19.28},{-14.78,38},{48,38},{48,98}}, color={191,0,0}));
  connect(indoorSwimmingPool.radPoolSurface, radPoolSurface1) annotation (Line(
        points={{-29.36,19.28},{-29.36,68},{24,68},{24,100},{22,100}}, color={0,
          0,0}));
  connect(indoorSwimmingPool.T_Pool, T_Pool1) annotation (Line(points={{18.7,15.44},
          {46,15.44},{46,26},{104,26}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{-22,-48},{28,16}})),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MultiplePools;
