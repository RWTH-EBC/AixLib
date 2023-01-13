within AixLib.DataBase.Pools;
record IndoorSwimmingPoolDummy
  "This is a dummy record with non-physical parameter values."
  extends IndoorSwimmingPoolBaseRecord(
    TPool=Modelica.Constants.eps,
    VPool=Modelica.Constants.inf,
    APool=Modelica.Constants.inf,
    depthPool=Modelica.Constants.inf,
    VStorage=Modelica.Constants.inf,
    V_flow_nominal=Modelica.Constants.inf,
    V_flow_partial=Modelica.Constants.inf,
    use_partialLoad=false,
    dpHeaExcPool=Modelica.Constants.inf,
    use_idealHeater=true,
    KHeat=Modelica.Constants.inf,
    THeat=Modelica.Constants.inf,
    QMaxHeat=Modelica.Constants.inf,
    QMinHeat=Modelica.Constants.inf,
    betaInUse=Modelica.Constants.inf,
    use_poolCover=false,
    use_waterRecycling=false,
    x_recycling=Modelica.Constants.inf,
    m_flow_out=Modelica.Constants.inf,
    use_HRS=false,
    etaHRS=Modelica.Constants.eps,
    use_wavePool=false,
    heightWave=Modelica.Constants.inf,
    widthWave=Modelica.Constants.inf,
    periodeWavePul=Modelica.Constants.eps,
    timeWavePul_start=Modelica.Constants.eps,
    widthWavePul=Modelica.Constants.eps,
    AWalInt=Modelica.Constants.inf,
    AWalExt=Modelica.Constants.inf,
    AFloExt=Modelica.Constants.inf,
    AFloInt=Modelica.Constants.inf,
    hConWaterHorizontal=Modelica.Constants.inf,
    hConWaterVertical=Modelica.Constants.inf,
    PoolWallParam=AixLib.DataBase.Pools.SwimmingPoolWalls.WallDummy());
  annotation (Documentation(info="<html>
<p>This record is a place holder for zones without swimming pools to avoid error messages.</p>
</html>"));
end IndoorSwimmingPoolDummy;
