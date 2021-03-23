within AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools;
record ChildrensPool
  "Pool which is mainly used by children for slpashing"
  extends IndoorSwimmingPoolBaseRecord(
  d_pool=0.4,
  A_pool=125,
  V_storage=25.43,
  T_pool=303.15,
  beta_inUse=40/3600,
  Q=0.0325,
  Q_night=0.01258,
  use_waterRecycling=false,
  x_recycling=0,
  m_flow_out=0.06349,
  use_partialLoad=true,
  AExt = 156.5089194071127,
  hConExt = 5200.0,
  nExt = 1,
  RExt = {0.000401895801047084},
  RExtRem = 0.016370997076222103,
  CExt = {81149364.8079353},
  AInt = 0.002,
  hConInt = 2624.999999999999,
  nInt = 1,
  RInt = {31.450138768067536},
  CInt = {1010.6714993637211},
  AFloor = 0.0,
  hConFloor = 0.0,
  nFloor = 1,
  RFloor = {0.00001},
  RFloorRem =  0.00001,
  CFloor = {0.00001});


end ChildrensPool;
