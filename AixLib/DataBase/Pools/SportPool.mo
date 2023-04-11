within AixLib.DataBase.Pools;
record SportPool "Pool which is mainly used by sport swimmers"
  extends IndoorSwimmingPoolBaseDataDefinition(
    TPool=301.15,
    VPool=942.956,
    APool=416.5,
    depPool=2.2640000000000002,
    VSto=69.333925940005700,
    V_flow_nominal=0.0856995884773662,
    V_flow_par=0.023144444444444443,
    use_parLoa=true,
    dpHeaExcPool=0,
    use_ideHeaExc=true,
    KHeat=1000,
    timeHea=1,
    QMaxHeat=1000000,
    QMinHeat=0,
    betaInUse=0.011111111111111112,
    use_poolCov=false,
    use_watRec=false,
    x_rec=0.0,
    m_flow_out=0.170038866026520,
    use_HRS=true,
    etaHRS=0.8,
    use_wavPool=false,
    heiWav=0,
    widWav=0,
    perWavPul=1800,
    timeWavPul_start=0,
    widWavPul=10/30*100,
    AWalInt=21.658,
    AWalExt=143.32,
    AFloInt=0.001,
    AFloExt=559.82,
    hConWatHor=50.0,
    hConWatVer=5200.0,
    PoolWallParam=
        AixLib.DataBase.Pools.SwimmingPoolWalls.ConcreteInsulationConstruction());
  annotation (Documentation(info="<html>
<p>The swimming pool &quot;SportPool&quot; describes a typical indoor swimming pool, which is mainly used for sport swimming. </p>
</html>"));
end SportPool;
