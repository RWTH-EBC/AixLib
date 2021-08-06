within AixLib.Fluid.Pools;
model MultiplePools

 parameter AixLib.DataBase.ThermalZones.SwimminghallBaseRecord Swimminghall
    "Choose setup for this zone" annotation (choicesAllMatching=true);

  final parameter Boolean use_swimmingPools = Swimminghall.use_swimmingPools;
  final parameter Real numPools = Swimminghall.numPools;


  parameter AixLib.DataBase.Pools.IndoorSwimmingPoolBaseRecord poolParam[numPools] = Swimminghall.poolParam
    "Setup for Swimming Pools" annotation (choicesAllMatching=false,Dialog(tab="Moisture", group="Swimming Pools", enable = use_swimmingPools));
    //if use_swimmingPools and  ATot > 0

  IndoorSwimmingPool indoorSwimmingPool[numPools](
    poolParam = poolParam) if use_swimmingPools
    annotation (Placement(transformation(extent={{-38,-48},{16,16}})));
  Modelica.Blocks.Interfaces.RealInput TSoil if
    use_swimmingPools "Temperature of Soil"
    annotation (Placement(transformation(extent={{42,30},{82,70}})));
  Modelica.Blocks.Interfaces.RealInput X_w if
    use_swimmingPools "Absolute humidty of the room Air"
    annotation (Placement(transformation(extent={{-14,46},{26,86}})));
  Modelica.Blocks.Interfaces.RealInput TAir if
    use_swimmingPools "Temperature of the surrounding room air"
    annotation (Placement(transformation(extent={{-60,60},{-20,100}})));
  Modelica.Blocks.Interfaces.RealInput openingHours if
    use_swimmingPools "Input profile for opening hours"
    annotation (Placement(transformation(extent={{-88,32},{-48,72}})));
  Modelica.Blocks.Interfaces.RealInput persons if  use_swimmingPools
   "Input profile for persons" annotation (Placement(transformation(extent={{-106,-22},{-66,18}})));
  Modelica.Blocks.Interfaces.RealOutput QEvap1[numPools] if
    use_swimmingPools
                     "Heat needed to compensate losses"
    annotation (Placement(transformation(extent={{48,-24},{68,-4}})));
  Modelica.Blocks.Interfaces.RealOutput QPool1[numPools] if
    use_swimmingPools
    "Heat flow rate to maintain the pool at the set temperature"
    annotation (Placement(transformation(extent={{70,-40},{90,-20}})));
  Modelica.Blocks.Interfaces.RealOutput PPool1[numPools] if
    use_swimmingPools
    "Output eletric energy needed for pool operation"
    annotation (Placement(transformation(extent={{58,-56},{78,-36}})));
  Modelica.Blocks.Interfaces.RealOutput MFlowFreshWater1[numPools] if use_swimmingPools
    "Flow rate of added fresh water to the pool and water treatment system"
    annotation (Placement(transformation(extent={{56,-76},{76,-56}})));
equation
  connect(indoorSwimmingPool.TSoil, TSoil) annotation (Line(points={{16.81,5.44},
          {62,5.44},{62,50}}, color={0,0,127}));
  connect(indoorSwimmingPool.X_w, X_w) annotation (Line(points={{6.55,18.24},{6.55,
          42.12},{6,42.12},{6,66}}, color={0,0,127}));
  connect(indoorSwimmingPool.TAir, TAir) annotation (Line(points={{-3.17,18.24},
          {-3.17,68},{-40,68},{-40,80}}, color={0,0,127}));
  connect(indoorSwimmingPool.openingHours, openingHours) annotation (Line(
        points={{-38.27,10.56},{-68,10.56},{-68,52}}, color={0,0,127}));
  connect(indoorSwimmingPool.persons, persons) annotation (Line(points={{-38.27,
          -1.6},{-86,-1.6},{-86,-2}}, color={0,0,127}));
  connect(indoorSwimmingPool.QEvap, QEvap1) annotation (Line(points={{18.7,-12.16},
          {58,-12.16},{58,-14}}, color={0,0,127}));
  connect(indoorSwimmingPool.QPool, QPool1) annotation (Line(points={{18.7,-21.76},
          {38,-21.76},{38,-30},{80,-30}}, color={0,0,127}));
  connect(indoorSwimmingPool.PPool, PPool1) annotation (Line(points={{18.7,-32.64},
          {32,-32.64},{32,-44},{68,-44},{68,-46}}, color={0,0,127}));
  connect(indoorSwimmingPool.MFlowFreshWater, MFlowFreshWater1) annotation (
      Line(points={{18.7,-43.52},{26,-43.52},{26,-66},{66,-66}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{-22,-48},{28,16}})),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MultiplePools;
