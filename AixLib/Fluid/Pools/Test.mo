within AixLib.Fluid.Pools;
model Test

   replaceable parameter AixLib.DataBase.ThermalZones.SwimmingHallMultiplePools Swimminghall
    "Choose setup for this zone" annotation (choicesAllMatching=true);

  final parameter Boolean use_swimmingPools = Swimminghall.use_swimmingPools;
  final parameter Integer numPools = Swimminghall.numPools;


  parameter AixLib.DataBase.Pools.IndoorSwimmingPoolBaseRecord poolParam[numPools] = Swimminghall.poolParam
    "Setup for Swimming Pools" annotation (choicesAllMatching=false,Dialog(tab="Moisture", group="Swimming Pools", enable = use_swimmingPools));


  parameter Integer numNonIdeal = numPools - sum(if poolParam[i].use_idealHeatExchanger then 1 else 0 for i in 1:numPools);
 // Integer counter(start=0);

  Modelica.Blocks.Math.Sum sum1(nin=numPools)
    annotation (Placement(transformation(extent={{-10,-2},{10,18}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-88,14},{-68,34}})));
  Modelica.Blocks.Sources.Constant const1[numNonIdeal](each k=1)
    annotation (Placement(transformation(extent={{-88,-28},{-68,-8}})));
  Modelica.Blocks.Interfaces.RealOutput y1   "Connector of Real output signal"   annotation (Placement(transformation(extent={{28,-2},{48,18}})));

equation
  for i in 1:numPools loop
    if numNonIdeal > 0 then
        connect(sum1.u[i], const1[i].y);
    else
      connect(sum1.u[i], const.y);
    end if;
   end for;


  connect(sum1.y, y1)
    annotation (Line(points={{11,8},{38,8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test;
