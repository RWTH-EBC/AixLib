within AixLib.DataBase.ThermalZones;
record SwimmingHallMultiplePools
  extends SwimminghallBaseRecord(
  use_swimmingPools=false,
    numPools=1,
    poolParam={AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools.SportPool()});
end SwimmingHallMultiplePools;
