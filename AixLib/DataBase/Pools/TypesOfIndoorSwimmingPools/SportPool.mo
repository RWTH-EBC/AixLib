within AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools;
record SportPool "Pool which is mainly used by sport swimmers"
  extends IndoorSwimmingPoolBaseRecord(
    TPool=301.15,
    VPool=942.956,
    APool=416.5,
    depthPool=2.2640000000000002,
    VStorage=69.333925940005700,
    V_flow_nominal=0.0856995884773662,
    V_flow_partial=0.023144444444444443,
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
    m_flow_out=0.170038866026520,
    use_HRS=true,
    etaHRS=0.8,
    use_wavePool=false,
    heightWave=0,
    widthWave=0,
    periodeWavePul=1800,
    timeWavePul_start=0,
    widthWavePul=10/30*100,
    AWalInt=21.658,
    AWalExt=143.32,
    AFloInt=0.001,
    AFloExt=559.82,
    hConWaterHorizontal=50.0,
    hConWaterVertical=5200.0,
    PoolWallParam=
        AixLib.DataBase.Pools.SwimmingPoolWalls.ConcreteInsulationConstruction());
  annotation (Documentation(info="<html>
<p>The swimming pool &quot;SportPool&quot; describes a typical indoor swimming pool, which is mainly used for sport swimming. </p>
</html>"));
end SportPool;
