within AixLib.Fluid.Pools.obsolete;
record SwimmingHallMultiplePools
  extends SwimminghallBaseRecord(
    use_swimmingPools=true,
    numPools=5,
    poolParam={AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools.SwimmerPool(
        use_idealHeatExchanger=false),
        AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools.SwimmerPool(
        use_idealHeatExchanger=false),
        AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools.SwimmerPool(
        use_idealHeatExchanger=false),
        AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools.SwimmerPool(
        use_idealHeatExchanger=false),
        AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools.SwimmerPool(
        use_idealHeatExchanger=false)});
end SwimmingHallMultiplePools;
