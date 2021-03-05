within AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools;
record ChildrensPool
  "Pool which is mainly used by children for slpashing"
  extends IndoorSwimmingPoolBaseRecord(
  d_pool=0.4,
  A_pool=80,
  V_storage=30,
  T_pool=305.15,
  nextToSoil=false,
  poolCover=false,
  beta_inUse=40,
  beta_nonUse=7,
  Q=0.04444,
  waterRecycling=false,
  x_recycling=0,
  m_flow_sewer=0.005,
  partialLoad=true,
  x_partialLoad=0.23,
  nPool=1,
  RPool={1.4142107968e-05},
  RPoolRem=0.000380773816236,
  CPool={492976267.489});

end ChildrensPool;
