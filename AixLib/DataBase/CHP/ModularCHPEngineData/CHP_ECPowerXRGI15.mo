within AixLib.DataBase.CHP.ModularCHPEngineData;
record CHP_ECPowerXRGI15
  extends AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord(
    SIEngine=true,
    EngMat = "CastIron",
    VEng=0.002237,
    hStr=0.086,
    dCyl=0.091,
    dExh=0.06,
    dCoo=0.0418,
    dInn=0.005,
    nEngNominal=25.583,
    xO2Exh=0.05,
    z=4,
    eps=10.5,
    mEng=122,
    m_floCooNominal=0.55,
    p_meNominal=540000,
    dp_Coo=15000,
    etaCHP=0.92,
    P_elNominal=15000,
    P_mecNominal=16200,
    P_FueNominal=49000,
    Q_MaxHea=30400,
    T_ExhPowUniOut=383.15,
    i=0.5,
    p=2,
    n_nominal=1530/60,
    f_1=50,
    U_1=400,
    useHeat=true);

end CHP_ECPowerXRGI15;
