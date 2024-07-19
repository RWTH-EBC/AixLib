within AixLib.DataBase.Pools;
record IndoorSwimmingPoolDummy
  "This is a dummy record with non-physical parameter values."
  extends AixLib.DataBase.Pools.IndoorSwimmingPoolBaseDataDefinition(
    TPool=Modelica.Constants.eps,
    VPool=Modelica.Constants.inf,
    APool=Modelica.Constants.inf,
    depthPool=Modelica.Constants.inf,
    VSto=Modelica.Constants.inf,
    V_flow_nominal=Modelica.Constants.inf,
    V_flow_par=Modelica.Constants.inf,
    use_parLoa=false,
    dpHeaExcPool=Modelica.Constants.inf,
    use_ideHeaExc=true,
    KHeat=Modelica.Constants.inf,
    timeHea=Modelica.Constants.inf,
    QMaxHeat=Modelica.Constants.inf,
    QMinHeat=Modelica.Constants.inf,
    betaInUse=Modelica.Constants.inf,
    use_poolCov=false,
    use_watRec=false,
    x_rec=Modelica.Constants.inf,
    m_flow_out=Modelica.Constants.inf,
    use_HRS=false,
    etaHRS=Modelica.Constants.eps,
    use_wavPool=false,
    heiWav=Modelica.Constants.inf,
    widWav=Modelica.Constants.inf,
    perWavPul=Modelica.Constants.eps,
    timeWavPul_start=Modelica.Constants.eps,
    widWavPul=Modelica.Constants.eps,
    AWalInt=Modelica.Constants.inf,
    AWalExt=Modelica.Constants.inf,
    AFloExt=Modelica.Constants.inf,
    AFloInt=Modelica.Constants.inf,
    hConWatHor=Modelica.Constants.inf,
    hConWatVer=Modelica.Constants.inf);
  annotation (Documentation(info="<html>
<p>This record is a place holder for zones without swimming pools to avoid error messages.</p>
</html>"));
end IndoorSwimmingPoolDummy;
