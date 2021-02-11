within AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools;
record SportPool "Pool which is mainly used for sport swimmers"

  extends IndoorSwimmingPoolBaseRecord(
  name="Training Pool",
  poolType="Schwimmerbecken",
  d_pool=1.80,
  A_pool=1250,
  u_pool=150,
  T_pool=301.15,
  NextToSoil=false,
  PoolCover=false,
  k=0.5,
  N=277.778,
  beta_inUse=28,
  beta_nonUse=7,
  v_Filter=50,
  Q_hygenic=0.15432,
  Q_hydraulic=0.04167);

   annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SportPool;
