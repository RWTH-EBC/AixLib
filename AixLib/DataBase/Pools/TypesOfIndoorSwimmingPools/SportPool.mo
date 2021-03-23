within AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools;
record SportPool "Pool which is mainly used for sport swimmers"

  extends IndoorSwimmingPoolBaseRecord(
  d_pool=2.264,
  A_pool=425,
  V_storage=150,
  T_pool=301.15,
  beta_inUse=28/3600,
  Q=0.1319,
  Q_night=0.02314,
  use_partialLoad = true,
  use_waterRecycling=false,
  x_recycling=0,
  m_flow_out=0.2618,
  AExt = 164.978,
  hConExt = 5200.0,
  nExt = 1,
  RExt = {0.0003812646385344414},
  RExtRem = 0.01553059839503766,
  CExt = {85540555.50315893},
  AInt = 43.316,
  hConInt = 2625.0,
  nInt = 1,
  RInt = {0.0014521257165051032},
  CInt = {21889123.333219472},
  AFloor = 0.0,
  hConFloor = 0.0,
  nFloor = 1,
  RFloor = {0.00001},
  RFloorRem =  0.00001,
  CFloor = {0.00001});


end SportPool;
