within AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools;
record ChildrensPool "Pool which is mainly used by children"
  extends IndoorSwimmingPoolBaseRecord(
    TPool=303.15,
    VPool=126.8,
    APool=125.0,
    depthPool=0.9303008070432868,
    VStorage=69.333925940005700,
    V_flow_nominal=0.028045267489711933,
    V_flow_partial=0.0125,
    use_partialLoad=true,
    dpHeaExcPool=0,
    use_idealHeater=true,
    KHeat=1000,
    THeat=1,
    QMaxHeat=1000000,
    QMinHeat=0,
    betaInUse=0.011111111111111112,
    use_poolCover=false,
    use_waterRecycling=false,
    x_recycling=0.0,
    m_flow_out=0.055645372003397,
    use_HRS=true,
    etaHRS=0.8,
    use_wavePool=false,
    heightWave=0,
    widthWave=0,
    periodeWavePul=1800,
    timeWavePul_start=0,
    widthWavePul=0,
    AWalInt=0.001,
    AWalExt=156.5,
    AFloInt=0.001,
    AFloExt=156.5,
    hConWaterHorizontal=50.0,
    hConWaterVertical=5200.0,
    PoolWallParam=
        AixLib.DataBase.Pools.SwimmingPoolWalls.ConcreteInsulationConstruction());
annotation (Documentation(info="<html>
<p>The swimming pool &quot;ChildrensPool&quot; describes a typical indoor swimming pool, which is mainly used by children and to teach children swimming. </p>
</html>"));
end ChildrensPool;
