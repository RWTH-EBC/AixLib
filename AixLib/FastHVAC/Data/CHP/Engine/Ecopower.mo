within AixLib.FastHVAC.Data.CHP.Engine;
record Ecopower

  extends Engine.BaseDataDefinition(
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
    tauQ_th_start=882.35,
    tauQ_th_stop = 90,
    tauP_el=73.52,
    dotm_max=0.287,
    dotm_min=0.073,
    dotQ_thRated = 7609,
    dotE_fuelRated = 18785,
    P_elStop = -190,
    P_elStart = -190,
    P_elStandby = -90);
    // the last three parameters where only available for the AisinSeiki ICE, so they are just copied!
end Ecopower;
