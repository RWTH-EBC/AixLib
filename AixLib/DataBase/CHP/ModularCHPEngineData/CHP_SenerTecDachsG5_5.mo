within AixLib.DataBase.CHP.ModularCHPEngineData;
record CHP_SenerTecDachsG5_5
  extends AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord(
    SIEngine=true,
    VEng=0.000578,
    hStr=0.0897,
    dCyl=0.0906,
    dExh=0.129,
    dCoo=0.04,
    dInn=0.005,
    nEngNominal=40.833,
    Lambda=1.57,
    z=1,
    eps=13.2,
    etaCHP=0.88,
    etaGen=0.91,
    P_elNominal=5500,
    Q_MaxHea=12500,
    T_ExhPowUniOut=423.15,
    i=0.5,
    n0=3000/60,
    n_nominal=3045/60,
    f_1=50,
    U_1=400,
    gearRatio=2450/3045);

end CHP_SenerTecDachsG5_5;
