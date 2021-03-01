within AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools;
record SportPool "Pool which is mainly used for sport swimmers"

  extends IndoorSwimmingPoolBaseRecord(
  d_pool=1.80,
  A_pool=1250,
  V_storage=150,
  T_pool=301.15,
  nextToSoil=false,
  poolCover=false,
  beta_inUse=28,
  beta_nonUse=7,
  Q=0.15432,
  partialLoad = true,
  x_partialLoad=0.27,
  waterRecycling=false,
  x_recycling=0,
  m_flow_sewer=0.005,
  nExt=1,
  RExt={1.4142107968e-05},
  RExtRem=0.000380773816236,
  CExt={492976267.489});

   annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SportPool;
