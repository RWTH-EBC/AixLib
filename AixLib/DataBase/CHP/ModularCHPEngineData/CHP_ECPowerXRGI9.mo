within AixLib.DataBase.CHP.ModularCHPEngineData;
record CHP_ECPowerXRGI9
  extends AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord(
    SIEngine=true,
    VEng=0.000952,
    hStr=0.078,
    dCyl=0.072,
    dExh=0.06,
    dCoo=0.0272,
    dInn=0.005,
    nEngNominal=40.833,
    xO2Exh=0.05,
    z=3,
    eps=12,
    mEng=52,
    m_floCooNominal=0.4167,
    etaCHP=0.925,
    etaGen=0.908,
    P_elNominal=9000,
    Q_MaxHea=20000,
    T_ExhPowUniOut=373.15,
    i=0.5,
    p=2,
    n_nominal=1550/60,
    f_1=50,
    U_1=400,
    useHeat=true);

end CHP_ECPowerXRGI9;
