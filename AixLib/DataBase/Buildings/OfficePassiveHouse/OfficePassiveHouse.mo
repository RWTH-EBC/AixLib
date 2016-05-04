within AixLib.DataBase.Buildings.OfficePassiveHouse;
record OfficePassiveHouse
    extends DataBase.Buildings.BuildingBaseRecord(
    buildingID = "M4120",
    usage = "Office Building",
    numZones=5,
    zoneSetup={
      AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_1_Meeting(),
      AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_2_Storage(),
      AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_3_Office(),
      AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_4_Restroom(),
      AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_6_Floor()},
    Vair=13128,
    BuildingArea=3282,
    heatingAHU=true,
    coolingAHU=true,
    dehumidificationAHU=true,
    humidificationAHU=true,
    BPF_DeHu=0.2,
    HRS=false,
    efficiencyHRS_enabled=0.8,
    efficiencyHRS_disabled=0.2,
    sampleRateAHU=1800,
    dpAHU_sup=800,
    dpAHU_eta=800,
    effFanAHU_sup=0.7,
    effFanAHU_eta=0.7);

end OfficePassiveHouse;
