within AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools;
record SwimmerPool "Pool which is mainly used by sport swimmers"
  extends IndoorSwimmingPoolBaseRecord(
    T_pool = 301.15,
    V_pool = 915.2,
    A_pool = 416.0,
    d_pool = 2.2,
    V_storage = 59.44708720147993,
    V_flow = 0.05135802469135802,
    V_flow_partial = 0.023144444444444443,
    beta_inUse = 0.0077777777777777776,
    use_partialLoad = true,
    dpHeatExchangerPool = 350.0,
    use_poolCover = false,
    use_waterRecycling = false,
    x_recycling = 0.8,
    m_flow_out = 0.10157951817558299,
    use_HRS = true,
    efficiencyHRS = 0.8,
    use_wavePool = false,
    h_wave = 0,
    w_wave = 0,
    wavePool_period = 1800,
    wavePool_startTime = 0,
    wavePool_width = 33.33333333333333,
    AInnerPoolWall = 21.658,
    APoolWallWithEarthContact = 143.32000000000002,
    APoolFloorWithEarthContact = 559.82,
    AInnerPoolFloor = 0.001,
    hConWaterHorizontal = 50.0,
    hConWaterVertical = 5200.0,
    PoolWallParam = AixLib.DataBase.Pools.SwimmingPoolWall.ConcreteInsulationConstruction());
  annotation (Documentation(info="<html>
<p>The swimming pool &quot;SportPool&quot; describes a typical indoor swimming pool, which is mainly used for sport swimming. </p>
</html>"));
end SwimmerPool;
