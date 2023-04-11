within AixLib.DataBase.Pools;
record ChildrensPool "Pool which is mainly used by children"
  extends IndoorSwimmingPoolBaseDataDefinition(
    TPool=303.15,
    VPool=126.8,
    APool=125.0,
    depthPool=0.9303008070432868,
    VSto=69.333925940005700,
    V_flow_nominal=0.028045267489711933,
    V_flow_par=0.0125,
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
    m_flow_out=0.055645372003397,
    use_HRS=true,
    etaHRS=0.8,
    use_wavPool=false,
    heightWav=0,
    widthWav=0,
    perWavPul=1800,
    timeWavPul_start=0,
    widthWavPul=0,
    AWalInt=0.001,
    AWalExt=156.5,
    AFloInt=0.001,
    AFloExt=156.5,
    hConWatHor=50.0,
    hConWatVer=5200.0,
    PoolWallParam=
        AixLib.DataBase.Pools.SwimmingPoolWalls.ConcreteInsulationConstruction());
annotation (Documentation(info="<html>
<p>The swimming pool &quot;ChildrensPool&quot; describes a typical indoor swimming pool, which is mainly used by children and to teach children swimming. </p>
</html>"));
end ChildrensPool;
