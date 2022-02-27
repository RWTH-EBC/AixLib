within AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools;
record ChildrensPool "Pool which is mainly used by children"

  extends IndoorSwimmingPoolBaseRecord(
    T_pool=303.15,
    V_pool=126.8,
    A_pool=125.0,
    d_pool=0.9303008070432868,
    V_storage=69.333925940005700,
    V_flow=0.028045267489711933,
    V_flow_partial=0.0125,
    use_partialLoad=true,
    use_idealHeatExchanger=true,
    dpHeatExchangerPool=300,
    beta_inUse=0.011111111111111112,
    use_poolCover=false,
    use_waterRecycling=false,
    x_recycling=0.0,
    m_flow_out=0.055645372003397,
    use_HRS=true,
    efficiencyHRS=0.8,
    use_wavePool=false,
    h_wave=0,
    w_wave=0,
    wavePool_period=1800,
    wavePool_startTime=0,
    wavePool_width=0,
    AInnerPoolWall=0.001,
    APoolWallWithEarthContact=156.5,
    APoolFloorWithEarthContact=156.5,
    AInnerPoolFloor=0.001,
    hConWaterHorizontal=50.0,
    hConWaterVertical=5200.0,
    PoolWallParam=
        AixLib.DataBase.Pools.SwimmingPoolWall.ConcreteInsulationConstruction());
annotation (Documentation(info="<html>
<p>The swimming pool &quot;ChildrensPool&quot; describes a typical indoor swimming pool, which is mainly used by children and to teach children swimming. </p>
</html>"));
end ChildrensPool;
