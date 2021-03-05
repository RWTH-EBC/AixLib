within AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools;
record NoPool
  "This Record is a place holder for zones without pools, to avoid error messages"
  extends IndoorSwimmingPoolBaseRecord(d_pool=0.001,
  A_pool=0.001,
  V_storage=0.01,
  T_pool=273.15,
  nextToSoil=false,
  poolCover=false,
  beta_inUse=28,
  beta_nonUse=7,
  Q=0.001,
  partialLoad = false,
  x_partialLoad=0,
  waterRecycling=false,
  x_recycling=0,
  m_flow_sewer=0.005,
  nPool=1,
  RPool={1.4142107968e-05},
  RPoolRem=0.000380773816236,
  CPool={492976267.489});
end NoPool;
