within AixLib.Obsolete.YearIndependent.FastHVAC.Data.CHP;
record Ecopower
  //import Mikro_KWK_model = CHP_package.Records.Records_model;
  extends BaseDataDefinition(
    a_0=-0.0417,
    a_1=0.0117,
    a_2=0.0104,
    a_3=-0.0000,
    a_4=0.0000,
    a_5=-0.0000,
    a_6=0.0000,
    b_0=-2.0000,
    b_1=0.0905,
    b_2=0.1875,
    b_3=-0.0000,
    b_4=0.0000,
    b_5=-0.0000,
    b_6=-0.0000,
    P_elRated=4460,
    tauQ_th=882.35,
    tauP_el=73.52,
    dotm_max=0.287,
    dotm_min=0.073);
end Ecopower;
