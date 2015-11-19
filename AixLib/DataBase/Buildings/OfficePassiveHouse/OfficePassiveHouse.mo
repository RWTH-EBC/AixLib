within AixLib.DataBase.Buildings.OfficePassiveHouse;
record OfficePassiveHouse
    extends DataBase.Buildings.BuildingBaseRecord(
    buildingID = "M4120",
    usage = "Office Building",
    numZones=6,
    zoneSetup={
      AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_1_Meeting(
        withAHU=true,
        minAHU=0,
        maxAHU=12),
      AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_2_Storage(),
      AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_3_Office(),
      AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_4_Restroom(
        withAHU=true,
        minAHU=0,
        maxAHU=8),
      AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_5_ICT(
        withAHU=true,
        minAHU=0,
        maxAHU=130),
      AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_6_Floor()},
    Vair=13396,
    BuildingArea=3349,
    h_heater=334900,
    Heater_on=true,
    l_cooler=0,
    Cooler_on=false,
    heating=true,
    cooling=true,
    dehumidification=true,
    humidification=true,
    BPF_DeHu=0.2,
    HRS=true,
    efficiencyHRS_enabled=0.8,
    efficiencyHRS_disabled=0.2);

end OfficePassiveHouse;
