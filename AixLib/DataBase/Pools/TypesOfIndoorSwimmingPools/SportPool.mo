within AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools;
record SportPool "Pool which is mainly used by sport swimmers"
  extends IndoorSwimmingPoolBaseRecord(
    T_pool=301.15,
    V_pool=942.956,
    A_pool=416.5,
    d_pool=2.2640000000000002,
    V_storage=69.333925940005700,
    V_flow=0.0856995884773662,
    V_flow_partial=0.023144444444444443,
    use_partialLoad=true,
    use_idealHeatExchanger=true,
    dpHeatExchangerPool = 300,
    beta_inUse=0.011111111111111112,
    use_poolCover=false,
    use_waterRecycling=false,
    x_recycling=0.0,
    m_flow_out=0.170038866026520,
    use_HRS=true,
    efficiencyHRS=0.8,
    use_wavePool=false,
    h_wave=0,
    w_wave=0,
    wavePool_period=1800,
    wavePool_startTime=0,
    wavePool_width=10/30*100,
    AInnerPoolWall=21.658,
    APoolWallWithEarthContact=143.32,
    APoolFloorWithEarthContact=559.82,
    AInnerPoolFloor=0.001,
    hConWaterHorizontal=50.0,
    hConWaterVertical=5200.0,
    PoolWallParam=
        AixLib.DataBase.Pools.SwimmingPoolWall.ConcreteIsulationConstruction());

  annotation (Documentation(info="<html>
<p>The swimming pool &quot;SportPool&quot; describes a typical indoor swimming pool, which is mainly used for sport swimming. </p>
</html>"));
end SportPool;
