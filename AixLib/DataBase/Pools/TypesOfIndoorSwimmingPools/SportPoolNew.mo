within AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools;
record SportPoolNew "Pool which is mainly used by sport swimmers"

  extends IndoorSwimmingPoolBaseRecord(
    T_pool_start = 301.15,
    T_pool = 301.15,
    V_pool = 942.956,
    A_pool = 416.5,
    d_pool = 2.2640000000000002,
    V_storage = 69.333925940005700,
    V_flow = 0.0856995884773662,
    V_flow_partial = 0.023144444444444443,
    use_partialLoad = true,
    use_idealHeatExchanger = true,
    beta_inUse = 0.011111111111111112,
    use_poolCover = false,
    use_waterRecycling = false,
    x_recycling = 0.0,
    m_flow_out = 0.170038866026520,
    use_HRS = true,
    efficiencyHRS = 0.8,
    use_wavePool = false,
    h_wave = 0,
    w_wave = 0,
    AInnerPoolWall = 21.658,
    APoolWallWithEarthContact = 143.32,
    APoolFloorWithEarthContact = 559.82,
    AInnerPoolFloor = 0.001,
    nPoolWall = 6,
    dPool = {0.05,0.002,0.05,0.2,0.002,0.1},
    rhoPool = {250,900,250,2104.2,900,30},
    lambdaPool = {1.4,0.35,1.4,1.94,0.35,0.041},
    cPool = {2000,2300,2000,780,2300,1380},
    hConWaterHorizontal = 50.0,
    hConWaterVertical = 5200.0);

  annotation (Documentation(info="<html>

  This is the base definition of indoor swimming pool records used in <a href=
  \"AixLib.Fluid.Pools.IndoorSwimmingPool\">AixLib.Fluid.Pools.IndoorSwimmingPool</a>.
  It aggregates all parameters at one record to enhance usability,
  exchanging entire datasets and automatic generation of these
  datasets.
<h4>References </h4>
<ul>
<li>German Association of Engineers: Guideline VDI 2089-1, January 2010: Building Services in swimming baths - Indoor Pools</li>
<li>German Institute for Standardization DIN 19643-1, November 2012: Treatment of water of swimming pools and baths - Part 1 General Requirements</li>
<li>Chroistoph Saunus, 2005: Schwimmb&auml;der Planung - Ausf&uuml;hrung - Betrieb</li>
</ul>
</html>"));
end SportPoolNew;
