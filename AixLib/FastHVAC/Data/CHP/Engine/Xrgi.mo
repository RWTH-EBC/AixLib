within AixLib.FastHVAC.Data.CHP.Engine;
record Xrgi

  extends Engine.BaseDataDefinition(
    a_0=-1.3036,
    a_1=0.0009,
    a_2=0.0982,
    a_3=-0.0000,
    a_4=0.0000,
    a_5=-0.0000,
    a_6=0.0000,
    b_0=0.1822,
    b_1=0.0011,
    b_2=0.0123,
    b_3=0.6963,
    b_4=-0.5130,
    b_5=-0.0000,
    b_6=0.0011,
    P_elRated=14300,
    tauQ_th_start=661.76,
    tauQ_th_stop = 90,
    tauP_el=102.94,
    dotm_max=0.3509,
    dotm_min=0.0586,
    dotQ_thRated = 17044,
    dotE_fuelRated = 50228,
    P_elStop = 190,
    P_elStart = 190,
    P_elStandby = 90);
    // the last three parameters where only available for the AisinSeiki ICE, so they are just copied!
end Xrgi;
