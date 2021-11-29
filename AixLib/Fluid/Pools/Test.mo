within AixLib.Fluid.Pools;
model Test

   replaceable parameter AixLib.DataBase.ThermalZones.SwimmingHallMultiplePools Swimminghall
    "Choose setup for this zone" annotation (choicesAllMatching=true);

  final parameter Boolean use_swimmingPools = Swimminghall.use_swimmingPools;
  final parameter Integer numPools = Swimminghall.numPools;


  parameter AixLib.DataBase.Pools.IndoorSwimmingPoolBaseRecord poolParam[numPools] = Swimminghall.poolParam
    "Setup for Swimming Pools" annotation (choicesAllMatching=false,Dialog(tab="Moisture", group="Swimming Pools", enable = use_swimmingPools));
    //if use_swimmingPools and  ATot > 0

  Integer nIdealTest;
  Integer nNonIdealTest;
  Boolean TestArray[3] = {true, false, true};
  Boolean TestArray2[2] = {poolParam[1].use_idealHeatExchanger,poolParam[2].use_idealHeatExchanger};

  Integer nIdeal;
  Integer nNonIdeal;
  Boolean IdealPools[1,numPools] = {poolParam[:].use_idealHeatExchanger};
  Boolean IdealPooolVector[numPools];


equation
  nIdealTest = Modelica.Math.BooleanVectors.countTrue(TestArray);
  nNonIdealTest = ndims(TestArray);

  for i in 1:numPools loop
    IdealPooolVector[i] = IdealPools[1,i];
  end for;

  nIdeal = Modelica.Math.BooleanVectors.countTrue(IdealPooolVector);
  nNonIdeal = ndims(IdealPooolVector)-nIdeal;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test;
