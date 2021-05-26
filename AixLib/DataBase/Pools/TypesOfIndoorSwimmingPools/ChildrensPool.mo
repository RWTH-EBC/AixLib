within AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools;
record ChildrensPool
  "Pool which is mainly used by children"
  extends IndoorSwimmingPoolBaseRecord(T_pool = 303.15,
    V_storage = 23.981625529066100,
    V_pool = 126.8,
    A_pool = 136.3,
    d_pool = 0.9303008070432868,
    Q = 0.028045267489711933,
    Q_night = 0.0125,
    beta_inUse = 0.011111111111111112,
    use_partialLoad = true,
    use_poolCover = false,
    use_wavePool = false,
    h_wave = 0.0,
    w_wave = 0.0,
    use_waterRecycling = false,
    x_recycling = 0.8,
    m_flow_out = 0.055645372003397,
    nExt = 1,
    RExt = {0.001693325729180398},
    RExtRem = 0.06897666133679328,
    CExt = {19260079.978665892},
    AExt = 37.146,
    hConExt = 5200.0,
    nInt = 1,
    RInt = {31.450138768067536},
    CInt = {1010.6714993637211},
    AInt = 0.0,
    hConInt = 2624.999999999999,
    nFloor = 1,
    RFloor = {0.0004955509141742304},
    RFloorRem =  0.020185984889439245,
    CFloor = {65812791.46320092},
    AFloor = 126.93,
    hConFloor = 49.99999999999999);


  annotation (Documentation(info="<html>
<p>The swimming pool &quot;ChildrensPool&quot; describes a typical indoor swimming pool, which is mainly used by children and to teach children swimming. </p>
</html>"));
end ChildrensPool;
