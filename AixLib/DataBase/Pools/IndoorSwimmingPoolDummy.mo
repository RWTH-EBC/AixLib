within AixLib.DataBase.Pools;
record IndoorSwimmingPoolDummy
  "This is a dummy record with non-physical parameter values."
  extends IndoorSwimmingPoolBaseRecord(
    T_pool = Modelica.Constants.eps,
    V_pool= Modelica.Constants.inf,
    A_pool = Modelica.Constants.inf,
    d_pool = Modelica.Constants.inf,
    V_storage = Modelica.Constants.inf,
    V_flow = Modelica.Constants.inf,
    V_flow_partial = Modelica.Constants.inf,
    use_partialLoad = false,
    use_idealHeatExchanger = true,
    dpHeatExchangerPool = Modelica.Constants.inf,
    beta_inUse = Modelica.Constants.inf,
    use_poolCover = false,
    use_waterRecycling = false,
    x_recycling = Modelica.Constants.inf,
    m_flow_out = Modelica.Constants.inf,
    use_HRS = false,
    efficiencyHRS = Modelica.Constants.eps,
    use_wavePool = false,
    h_wave = Modelica.Constants.inf,
    w_wave = Modelica.Constants.inf,
    wavePool_period = Modelica.Constants.eps,
    wavePool_startTime = Modelica.Constants.eps,
    wavePool_width = Modelica.Constants.eps,
    AInnerPoolWall = Modelica.Constants.inf,
    APoolWallWithEarthContact = Modelica.Constants.inf,
    APoolFloorWithEarthContact = Modelica.Constants.inf,
    AInnerPoolFloor = Modelica.Constants.inf,
    hConWaterHorizontal = Modelica.Constants.inf,
    hConWaterVertical = Modelica.Constants.inf,
    PoolWallParam= AixLib.DataBase.Pools.SwimmingPoolWall.WallDummy());
  annotation (Documentation(info="<html>
<p>This record is a place holder for zones without swimming pools to avoid error messages.</p>
</html>"));
end IndoorSwimmingPoolDummy;
