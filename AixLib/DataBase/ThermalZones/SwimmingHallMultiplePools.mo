within AixLib.DataBase.ThermalZones;
record SwimmingHallMultiplePools
  extends SwimminghallBaseRecord(
    use_swimmingPools=false,
    numPools=5,
    poolParam={
    AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools.SportPool(),
    AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools.SportPool(),
    AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools.SportPool(),
    AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools.SportPool(),
    AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools.SportPool()});
end SwimmingHallMultiplePools;
