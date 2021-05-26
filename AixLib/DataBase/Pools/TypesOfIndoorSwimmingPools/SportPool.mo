within AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools;
record SportPool "Pool which is mainly used by sport swimmers"

  extends IndoorSwimmingPoolBaseRecord(
    T_pool = 301.15,
    V_storage=69.333925940005700,
    V_pool = 942.956,
    A_pool = 416.5,
    d_pool = 2.2640000000000002,
    Q = 0.0856995884773662,
    Q_night = 0.023144444444444443,
    beta_inUse = 0.011111111111111112,
    use_partialLoad = true,
    use_poolCover = false,
    use_wavePool = false,
    h_wave = 0.0,
    w_wave = 0.0,
    use_waterRecycling = false,
    x_recycling = 0.8,
    m_flow_out = 0.170038866026520,
    nExt = 1,
    RExt = {0.00042929482347894534},
    RExtRem = 0.017487080685343458,
    CExt = {75970142.63915703},
    AExt = 146.52,
    hConExt = 5200.0,
    nInt = 1,
    RInt = {0.0007313900714658561},
    CInt = {43459379.80838968},
    AInt = 86.001,
    hConInt = 5199.940116975383,
    nFloor = 1,
    RFloor = {0.00015102107451653077},
    RFloorRem =  0.0061517576519004155,
    CFloor = {215953893.04674378},
    AFloor = 416.5,
    hConFloor = 50.0);


  annotation (Documentation(info="<html>
<p>The swimming pool &quot;SportPool&quot; describes a typical indoor swimming pool, which is mainly used for sport swimming. </p>
</html>"));
end SportPool;
