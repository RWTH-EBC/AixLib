within AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools;
record NonSwimmerPool "Pool which is mainly used by children"
  extends IndoorSwimmingPoolBaseRecord(
    T_pool = 303.15,
    V_pool = 125.0,
    A_pool = 125.0,
    d_pool = 1.0,
    V_storage = 25.403089268725033,
    V_flow = 0.025720164609053495,
    V_flow_partial = 0.0125,
    beta_inUse = 0.011111111111111112,
    use_partialLoad = true,
    dpHeatExchangerPool = 350.0,
    use_poolCover = false,
    use_waterRecycling = false,
    x_recycling = 0.8,
    m_flow_out = 0.050810083121039906,
    use_HRS = true,
    efficiencyHRS = 0.8,
    use_wavePool = false,
    h_wave = 0,
    w_wave = 0,
    wavePool_period = 1800,
    wavePool_startTime = 0,
    wavePool_width = 33.33333333333333,
    AInnerPoolWall = 17.55,
    APoolWallWithEarthContact = 156.5089194071127,
    APoolFloorWithEarthContact = 156.5089194071127,
    AInnerPoolFloor = 0.001,
    hConWaterHorizontal = 50.0,
    hConWaterVertical = 5200.0,
    PoolWallParam = AixLib.DataBase.Pools.SwimmingPoolWall.ConcreteInsulationConstruction());
annotation (Documentation(info="<html>
<p>The swimming pool &quot;ChildrensPool&quot; describes a typical indoor swimming pool, which is mainly used by children and to teach children swimming. </p>
</html>"));
end NonSwimmerPool;
