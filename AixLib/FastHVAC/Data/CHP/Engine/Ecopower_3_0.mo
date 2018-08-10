within AixLib.FastHVAC.Data.CHP.Engine;
record Ecopower_3_0

  extends Engine.BaseDataDefinition(
    a_0=0.25,
    a_1=0,
    a_2=0,
    a_3=-0.0000,
    a_4=0.0000,
    a_5=-0.0000,
    a_6=0.0000,
    b_0=0.65,
    b_1=0,
    b_2=0,
    b_3=-0.0000,
    b_4=0.0000,
    b_5=-0.0000,
    b_6=-0.0000,
    P_elRated=3000,
    tauQ_th_start=882.35,
    tauQ_th_stop = 90,
    tauP_el=73.52,
    dotm_max=0.06,
    dotm_min=0.06,
    dotQ_thRated = 5070,
    dotE_fuelRated = 12000,
    P_elStop = -190,
    P_elStart = -190,
    P_elStandby = -90);
    // the last three parameters where only available for the AisinSeiki ICE, so they are just copied!
end Ecopower_3_0;
