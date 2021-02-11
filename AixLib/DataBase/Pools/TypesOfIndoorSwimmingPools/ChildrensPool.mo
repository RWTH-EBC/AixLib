within AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools;
record ChildrensPool
  "Pool which is mainly used by children for slpashing"
  extends IndoorSwimmingPoolBaseRecord(
  name="Playpool for children",
  poolType="Kleinkinderbecken",
  d_pool=0.4,
  A_pool=80,
  u_pool=36,
  T_pool=305.15,
  NextToSoil=false,
  PoolCover=false,
  k=0.5,
  N=80,
  beta_inUse=40,
  beta_nonUse=7,
  v_Filter=50,
  Q_hygenic=0.04444,
  Q_hydraulic=0.01);

end ChildrensPool;
