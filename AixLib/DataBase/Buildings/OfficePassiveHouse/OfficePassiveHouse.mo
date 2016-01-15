within AixLib.DataBase.Buildings.OfficePassiveHouse;
record OfficePassiveHouse
    extends DataBase.Buildings.BuildingBaseRecord(
    buildingID = "M4120",
    usage = "Office Building",
    numZones=6,
    zoneSetup={
      AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_1_Meeting(),
      AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_2_Storage(),
      AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_3_Office(),
      AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_4_Restroom(),
      AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_5_ICT(),
      AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_6_Floor()},
    Vair=13396,
    BuildingArea=3349,
    heatingAHU=true,
    coolingAHU=false,
    dehumidificationAHU=false,
    humidificationAHU=false,
    BPF_DeHu=0.2,
    HRS=false,
    efficiencyHRS_enabled=0.8,
    efficiencyHRS_disabled=0.2);

end OfficePassiveHouse;
