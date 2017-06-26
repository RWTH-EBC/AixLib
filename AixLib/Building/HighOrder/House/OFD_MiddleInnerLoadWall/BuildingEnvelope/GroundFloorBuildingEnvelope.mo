within AixLib.Building.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope;


model GroundFloorBuildingEnvelope
  ///////// construction parameters
  parameter Integer TMC = 1 "Thermal Mass Class" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1 "Heavy", choice = 2 "Medium", choice = 3 "Light", radioButtons = true));
  parameter Integer TIR = 1 "Thermal Insulation Regulation" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1
        "EnEV_2009",                                                                                                    choice = 2
        "EnEV_2002",                                                                                                    choice = 3
        "WSchV_1995",                                                                                                    choice = 4
        "WSchV_1984",                                                                                                    radioButtons = true));
  parameter Integer TRY = 1 "Region according to TRY" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "TRY01",
                 choice = 2 "TRY02", choice = 3 "TRY03",  choice = 4 "TRY04", choice = 5 "TRY05", choice = 6 "TRY06", choice = 7 "TRY07", choice = 8 "TRY08",
        choice = 9 "TRY09", choice = 10 "TRY10", choice = 11 "TRY11", choice = 12 "TRY12", choice = 13 "TRY13", choice = 14 "TRY14", choice= 15 "TRY15",radioButtons = true));
  parameter Boolean withFloorHeating = false
    "If true, that floor has different connectors"                                          annotation(Dialog(group = "Construction parameters"), choices(checkBox = true));
  //////////room geometry
  parameter Modelica.SIunits.Length room_width = if TIR == 1 then 3.86 else 3.97 "width" annotation(Dialog(group = "Dimensions", descriptionLabel = true));
  parameter Modelica.SIunits.Height room_height = 2.60 "height" annotation(Dialog(group = "Dimensions", descriptionLabel = true));
  parameter Modelica.SIunits.Length length1 = if TIR == 1 then 3.23 else 3.34 "l1 " annotation(Dialog(group = "Dimensions", descriptionLabel = true));
  parameter Modelica.SIunits.Length length2 = 2.44 "l2 " annotation(Dialog(group = "Dimensions", descriptionLabel = true));
  parameter Modelica.SIunits.Length length3 = 1.33 "l3 " annotation(Dialog(group = "Dimensions", descriptionLabel = true));
  parameter Modelica.SIunits.Length length4 = if TIR == 1 then 3.23 else 3.34 "l4 " annotation(Dialog(group = "Dimensions", descriptionLabel = true));
  parameter Modelica.SIunits.Length thickness_IWsimple = 0.145
    "thickness IWsimple "                                                            annotation(Dialog(group = "Dimensions", descriptionLabel = true));
  // Outer walls properties
  parameter Real solar_absorptance_OW = 0.6 "Solar absoptance outer walls " annotation(Dialog(group = "Outer wall properties", descriptionLabel = true));

  //Windows and Doors
  parameter Modelica.SIunits.Area windowarea_11 = 8.44 " Area Window11" annotation(Dialog(group = "Windows and Doors", descriptionLabel = true, joinNext = true));
  parameter Modelica.SIunits.Area windowarea_12 = 1.73 " Area Window12  " annotation(Dialog(group = "Windows and Doors", descriptionLabel = true));
  parameter Modelica.SIunits.Area windowarea_22 = 1.73 " Area Window22" annotation(Dialog(group = "Windows and Doors", descriptionLabel = true, joinNext = true));
  parameter Modelica.SIunits.Area windowarea_41 = 1.4 " Area Window41  " annotation(Dialog(group = "Windows and Doors", descriptionLabel = true));
  parameter Modelica.SIunits.Area windowarea_51 = 3.46 " Area Window51" annotation(Dialog(group = "Windows and Doors", descriptionLabel = true, joinNext = true));
  parameter Modelica.SIunits.Area windowarea_52 = 1.73 " Area Window52  " annotation(Dialog(group = "Windows and Doors", descriptionLabel = true));
  parameter Modelica.SIunits.Length door_width_31 = 1.01 "Width Door31" annotation(Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true));
  parameter Modelica.SIunits.Length door_height_31 = 2.25 "Height Door31  " annotation(Dialog(group = "Windows and Doors", descriptionLabel = true));
  parameter Modelica.SIunits.Length door_width_42 = 1.25 "Width Door42" annotation(Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true));
  parameter Modelica.SIunits.Length door_height_42 = 2.25 "Height Door42  " annotation(Dialog(group = "Windows and Doors", descriptionLabel = true));
  parameter Real AirExchangeCorridor = 2 "Air exchange corridors in 1/h " annotation(Dialog(group = "Air Exchange Corridors", descriptionLabel = true));
  // Dynamic Ventilation
  parameter Boolean withDynamicVentilation = true "Dynamic ventilation" annotation(Dialog(group = "Dynamic ventilation", descriptionLabel = true), choices(checkBox = true));
  parameter Modelica.SIunits.Temperature HeatingLimit = 253.15
    "Outside temperature at which the heating activates"                                                            annotation(Dialog(group = "Dynamic ventilation", descriptionLabel = true, enable = if withDynamicVentilation then true else false));
  parameter Real Max_VR = 200 "Maximal ventilation rate" annotation(Dialog(group = "Dynamic ventilation", descriptionLabel = true, enable = if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.TemperatureDifference Diff_toTempset = 3
    "Difference to set temperature"                                                                   annotation(Dialog(group = "Dynamic ventilation", descriptionLabel = true, enable = if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.Temperature Tset_Livingroom = 295.15
    "Tset_livingroom"                                                               annotation(Dialog(group = "Dynamic ventilation", descriptionLabel = true, joinNext = true, enable = if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.Temperature Tset_Hobby = 295.15 "Tset_hobby" annotation(Dialog(group = "Dynamic ventilation", descriptionLabel = true, enable = if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.Temperature Tset_WC = 291.15 "Tset_WC" annotation(Dialog(group = "Dynamic ventilation", descriptionLabel = true, joinNext = true, enable = if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.Temperature Tset_Kitchen = 295.15 "Tset_kitchen" annotation(Dialog(group = "Dynamic ventilation", descriptionLabel = true, enable = if withDynamicVentilation then true else false));
  Modelica.Blocks.Sources.Constant AirExchangePort_doorSt(k = 0) "Storage" annotation(Placement(transformation(extent = {{-116, -68}, {-100, -52}})));
  Rooms.OFD.Ow2IwL2IwS1Gr1Uf1 Livingroom(TMC = TMC, TIR = TIR, room_lengthb = length2, room_width = room_width, room_height = room_height, room_length = length1 + length2 + thickness_IWsimple, solar_absorptance_OW = solar_absorptance_OW, windowarea_OW1 = windowarea_11, windowarea_OW2 = windowarea_12, withDoor1 = false, withDoor2 = false, withWindow1 = true, withWindow2 = true, withFloorHeating = withFloorHeating, withDynamicVentilation = withDynamicVentilation, HeatingLimit = HeatingLimit, Max_VR = Max_VR, Diff_toTempset = Diff_toTempset, Tset = Tset_Livingroom,
    TRY=TRY,
    T0_air=295.15,
    T0_OW1=295.15,
    T0_OW2=295.15,
    T0_IW1a=295.15,
    T0_IW1b=295.15,
    T0_IW2=295.15,
    T0_CE=295.13,
    T0_FL=295.13)                                                                                                     annotation(Placement(transformation(extent = {{-86, 14}, {-42, 78}})));
  Rooms.OFD.Ow2IwL1IwS1Gr1Uf1 Hobby(TMC = TMC, TIR = TIR, room_length = length1, room_width = room_width, room_height = room_height, solar_absorptance_OW = solar_absorptance_OW, windowarea_OW2 = windowarea_22, withDoor1 = false, withDoor2 = false, withWindow1 = false, withWindow2 = true, withFloorHeating = withFloorHeating,                                                                                                    withDynamicVentilation = withDynamicVentilation, HeatingLimit = HeatingLimit, Max_VR = Max_VR, Diff_toTempset = Diff_toTempset, Tset = Tset_Hobby,
    TRY=TRY,
    T0_air=295.15,
    T0_OW1=295.15,
    T0_OW2=295.15,
    T0_IW1=295.15,
    T0_IW2=295.15,
    T0_CE=295.13,
    T0_FL=295.13)                                                                                                     annotation(Placement(transformation(extent = {{84, 28}, {46, 76}})));
  Rooms.OFD.Ow2IwL1IwS1Gr1Uf1 WC_Storage(TMC = TMC, TIR = TIR, room_length = length4, room_width = room_width, room_height = room_height, solar_absorptance_OW = solar_absorptance_OW, withWindow1 = true, windowarea_OW1 = windowarea_41, withDoor2 = true, door_width_OD2 = door_width_42, door_height_OD2 = door_height_42, withWindow2 = false, withDoor1 = false, withFloorHeating = withFloorHeating,                                                                                                    withDynamicVentilation = withDynamicVentilation, HeatingLimit = HeatingLimit, Max_VR = Max_VR, Diff_toTempset = Diff_toTempset, Tset = Tset_WC,
    TRY=TRY,
    T0_air=291.15,
    T0_OW1=291.15,
    T0_OW2=291.15,
    T0_IW1=291.15,
    T0_IW2=291.15,
    T0_CE=291.13,
    T0_FL=291.13)                                                                                                     annotation(Placement(transformation(extent = {{84, -36}, {46, -84}})));
  Rooms.OFD.Ow2IwL2IwS1Gr1Uf1 Kitchen(TMC = TMC, TIR = TIR, room_length = length3 + length4 + thickness_IWsimple, room_width = room_width, room_height = room_height, solar_absorptance_OW = solar_absorptance_OW, withWindow1 = true, windowarea_OW1 = windowarea_51, withWindow2 = true, windowarea_OW2 = windowarea_52, room_lengthb = length3, withDoor1 = false, withDoor2 = false, withFloorHeating = withFloorHeating,                                                                                                    withDynamicVentilation = withDynamicVentilation, HeatingLimit = HeatingLimit, Max_VR = Max_VR, Diff_toTempset = Diff_toTempset, Tset = Tset_Kitchen,
    TRY=TRY,
    T0_air=295.15,
    T0_OW1=295.15,
    T0_OW2=295.15,
    T0_IW1a=295.15,
    T0_IW1b=295.15,
    T0_IW2=295.15,
    T0_CE=295.13,
    T0_FL=295.13)                                                                                                     annotation(Placement(transformation(extent = {{-84, -20}, {-44, -84}})));
  Rooms.OFD.Ow1IwL2IwS1Gr1Uf1 Corridor(TMC = TMC, TIR = TIR, room_length = length2 + length3 + thickness_IWsimple, room_width = room_width, room_height = room_height, solar_absorptance_OW = solar_absorptance_OW, withDoor1 = true, door_width_OD1 = door_width_31, door_height_OD1 = door_height_31, room_lengthb = length3, withWindow1 = false, withFloorHeating = withFloorHeating,
    TRY=TRY,
    T0_air=291.15,
    T0_OW1=291.15,
    T0_IW1=291.15,
    T0_IW2a=291.15,
    T0_IW2b=291.15,
    T0_IW3=291.15,
    T0_CE=291.13,
    T0_FL=291.13)                                                                                                     annotation(Placement(transformation(extent = {{82, -28}, {42, 10}})));
  Utilities.Interfaces.SolarRad_in North annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {110, 88})));
  Utilities.Interfaces.SolarRad_in East annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {110, 60})));
  Utilities.Interfaces.SolarRad_in South annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {110, 26})));
  Utilities.Interfaces.SolarRad_in West annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {110, -16})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation(Placement(transformation(extent = {{-130, 12}, {-100, 42}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort[4] annotation(Placement(transformation(extent = {{-130, -18}, {-100, 12}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside annotation(Placement(transformation(extent = {{-116, 66}, {-100, 82}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Livingroom annotation(Placement(transformation(extent = {{-100, 100}, {-84, 118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Hobby annotation(Placement(transformation(extent = {{-58, 100}, {-40, 118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Corridor annotation(Placement(transformation(extent = {{-20, 100}, {-2, 118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_WCStorage annotation(Placement(transformation(extent = {{20, 100}, {38, 118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Kitchen annotation(Placement(transformation(extent = {{62, 100}, {80, 118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor annotation(Placement(transformation(extent = {{100, 100}, {120, 120}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermLivingroom annotation(Placement(transformation(extent = {{-26, 54}, {-14, 66}}), iconTransformation(extent = {{-28, 56}, {-14, 66}})));
  Utilities.Interfaces.Star StarLivingroom annotation(Placement(transformation(extent = {{-28, 32}, {-12, 48}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermHobby annotation(Placement(transformation(extent = {{14, 54}, {26, 66}})));
  Utilities.Interfaces.Star StarHobby annotation(Placement(transformation(extent = {{12, 32}, {28, 48}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermCorridor annotation(Placement(transformation(extent = {{-6, -6}, {6, 6}})));
  Utilities.Interfaces.Star StarCorridor annotation(Placement(transformation(extent = {{-8, -28}, {8, -12}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermWC_Storage annotation(Placement(transformation(extent = {{14, -46}, {26, -34}})));
  Utilities.Interfaces.Star StarWC_Storage annotation(Placement(transformation(extent = {{12, -68}, {28, -52}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermKitchen annotation(Placement(transformation(extent = {{-26, -46}, {-14, -34}})));
  Utilities.Interfaces.Star StarKitchen annotation(Placement(transformation(extent = {{-28, -68}, {-12, -52}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermFloor[5] if withFloorHeating annotation(Placement(transformation(extent = {{-4, -100}, {8, -88}}), iconTransformation(extent = {{0, -88}, {14, -78}})));
equation
  if withFloorHeating then
    connect(Livingroom.thermFloor, ThermFloor[1]) annotation(Line(points = {{-68.84, 38.32}, {-68.84, 6}, {-90, 6}, {-90, -92}, {2, -92}, {2, -98.8}}, color = {191, 0, 0}, pattern = LinePattern.Dash));
    connect(Hobby.thermFloor, ThermFloor[2]) annotation(Line(points = {{69.18, 46.24}, {69.18, 22}, {90, 22}, {90, -92}, {8, -92}, {2, -96.4}}, color = {191, 0, 0}, pattern = LinePattern.Dash));
    connect(Corridor.thermFloor, ThermFloor[3]) annotation(Line(points = {{66.4, -13.56}, {66.4, -32}, {90, -32}, {90, -92}, {4, -92}, {4, -94}, {2, -94}}, color = {191, 0, 0}, pattern = LinePattern.Dash));
    connect(WC_Storage.thermFloor, ThermFloor[4]) annotation(Line(points = {{69.18, -54.24}, {90, -54.24}, {90, -91.6}, {2, -91.6}}, color = {191, 0, 0}, pattern = LinePattern.Dash));
    connect(Kitchen.thermFloor, ThermFloor[5]) annotation(Line(points = {{-68.4, -44.32}, {-90, -44.32}, {-90, -92}, {-4, -92}, {2, -89.2}}, color = {191, 0, 0}, pattern = LinePattern.Dash));
  end if;
  connect(Livingroom.SolarRadiationPort_OW2, West) annotation(Line(points = {{-52.89, 77.68}, {-52.89, 86}, {90, 86}, {90, -16}, {110, -16}}, color = {255, 128, 0}));
  connect(Hobby.SolarRadiationPort_OW2, West) annotation(Line(points = {{55.405, 75.76}, {55.405, 86}, {90, 86}, {90, -16}, {110, -16}}, color = {255, 128, 0}));
  connect(Hobby.SolarRadiationPort_OW1, North) annotation(Line(points = {{83.905, 59.2}, {90, 59.2}, {90, 88}, {110, 88}}, color = {255, 128, 0}));
  connect(Corridor.SolarRadiationPort_OW1, North) annotation(Line(points = {{81.9, 2.4}, {90, 2.4}, {90, 88}, {110, 88}}, color = {255, 128, 0}));
  connect(WC_Storage.SolarRadiationPort_OW1, North) annotation(Line(points = {{83.905, -67.2}, {90, -67.2}, {90, 88}, {110, 88}}, color = {255, 128, 0}));
  connect(WC_Storage.SolarRadiationPort_OW2, East) annotation(Line(points = {{55.405, -83.76}, {55.405, -92}, {-90, -92}, {-90, 86}, {90, 86}, {90, 60}, {110, 60}}, color = {255, 128, 0}));
  connect(Kitchen.SolarRadiationPort_OW2, East) annotation(Line(points = {{-53.9, -83.68}, {-53.9, -92}, {-90, -92}, {-90, 86}, {90, 86}, {90, 60}, {110, 60}}, color = {255, 128, 0}));
  connect(Livingroom.SolarRadiationPort_OW1, South) annotation(Line(points = {{-85.89, 55.6}, {-90, 55.6}, {-90, 86}, {90, 86}, {90, 26}, {110, 26}}, color = {255, 128, 0}));
  connect(Livingroom.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{-85.89, 33.2}, {-90, 33.2}, {-90, 27}, {-115, 27}}, color = {0, 0, 127}));
  connect(Kitchen.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{-83.9, -39.2}, {-90, -39.2}, {-90, 27}, {-115, 27}}, color = {0, 0, 127}));
  connect(WC_Storage.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{83.905, -50.4}, {90, -50.4}, {90, -92}, {-90, -92}, {-90, 27}, {-115, 27}}, color = {0, 0, 127}));
  connect(Corridor.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{81.9, -20.4}, {90, -20.4}, {90, -92}, {-90, -92}, {-90, 27}, {-115, 27}}, color = {0, 0, 127}));
  connect(Hobby.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{83.905, 42.4}, {90, 42.4}, {90, -92}, {-90, -92}, {-90, 27}, {-115, 27}}, color = {0, 0, 127}));
  connect(Livingroom.thermOutside, thermOutside) annotation(Line(points = {{-83.8, 74.8}, {-90, 74.8}, {-90, 74}, {-108, 74}}, color = {191, 0, 0}));
  connect(Kitchen.thermOutside, thermOutside) annotation(Line(points = {{-82, -80.8}, {-90, -80.8}, {-90, 74}, {-108, 74}}, color = {191, 0, 0}));
  connect(WC_Storage.thermOutside, thermOutside) annotation(Line(points = {{82.1, -81.6}, {82.1, -92}, {-90, -92}, {-90, 74}, {-108, 74}}, color = {191, 0, 0}));
  connect(Corridor.thermOutside, thermOutside) annotation(Line(points = {{80, 8.1}, {86, 8.1}, {86, 8}, {90, 8}, {90, -92}, {-90, -92}, {-90, 74}, {-108, 74}}, color = {191, 0, 0}));
  connect(Hobby.thermOutside, thermOutside) annotation(Line(points = {{82.1, 73.6}, {90, 73.6}, {90, 86}, {-90, 86}, {-90, 74}, {-108, 74}}, color = {191, 0, 0}));
  connect(Livingroom.thermCeiling, thermCeiling_Livingroom) annotation(Line(points = {{-44.2, 68.4}, {-32, 68.4}, {-32, 86}, {-92, 86}, {-92, 109}}, color = {191, 0, 0}));
  connect(Livingroom.thermInsideWall1a, Hobby.thermInsideWall1) annotation(Line(points = {{-44.2, 55.6}, {-32, 55.6}, {-32, 86}, {36, 86}, {36, 54.4}, {47.9, 54.4}}, color = {191, 0, 0}));
  connect(Hobby.thermCeiling, thermCeiling_Hobby) annotation(Line(points = {{47.9, 68.8}, {36, 68.8}, {36, 86}, {-50, 86}, {-50, 109}, {-49, 109}}, color = {191, 0, 0}));
  connect(Corridor.thermCeiling, thermCeiling_Corridor) annotation(Line(points = {{44, 4.3}, {36, 4.3}, {36, 86}, {-10, 86}, {-10, 109}, {-11, 109}}, color = {191, 0, 0}));
  connect(WC_Storage.thermCeiling, thermCeiling_WCStorage) annotation(Line(points = {{47.9, -76.8}, {36, -76.8}, {36, -92}, {90, -92}, {90, 86}, {29, 86}, {29, 109}}, color = {191, 0, 0}));
  connect(Kitchen.thermCeiling, thermCeiling_Kitchen) annotation(Line(points = {{-46, -74.4}, {-34, -74.4}, {-34, -92}, {90, -92}, {90, 86}, {71, 86}, {71, 109}}, color = {191, 0, 0}));
  connect(Kitchen.thermInsideWall1a, WC_Storage.thermInsideWall1) annotation(Line(points = {{-46, -61.6}, {-34, -61.6}, {-34, -92}, {36, -92}, {36, -62}, {47.9, -62}, {47.9, -62.4}}, color = {191, 0, 0}));
  connect(Livingroom.thermInsideWall1b, Corridor.thermInsideWall2a) annotation(Line(points = {{-44.2, 42.8}, {-32, 42.8}, {-32, 86}, {36, 86}, {36, -3.3}, {44, -3.3}}, color = {191, 0, 0}));
  connect(Kitchen.thermInsideWall2, Livingroom.thermInsideWall2) annotation(Line(points = {{-58, -23.2}, {-58, -14}, {-90, -14}, {-90, 6}, {-57.4, 6}, {-57.4, 17.2}}, color = {191, 0, 0}));
  connect(Corridor.thermInsideWall3, WC_Storage.thermInsideWall2) annotation(Line(points = {{56, -26.1}, {56, -32}, {59.3, -32}, {59.3, -38.4}}, color = {191, 0, 0}));
  connect(Hobby.thermInsideWall2, Corridor.thermInsideWall1) annotation(Line(points = {{59.3, 30.4}, {59.3, 22}, {90, 22}, {90, 14}, {56, 14}, {56, 8.1}}, color = {191, 0, 0}));
  connect(Corridor.thermRoom, thermCorridor) annotation(Line(points = {{66, -5.2}, {66, -32}, {90, -32}, {90, 100}, {110, 100}, {110, 110}}, color = {191, 0, 0}));
  connect(Hobby.starRoom, StarHobby) annotation(Line(points = {{61.2, 56.8}, {61.2, 44}, {36, 44}, {36, 40}, {20, 40}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(Corridor.starRoom, StarCorridor) annotation(Line(points = {{58, -5.2}, {58, -20}, {0, -20}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(StarWC_Storage, StarWC_Storage) annotation(Line(points = {{20, -60}, {20, -60}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(Corridor.thermRoom, ThermCorridor) annotation(Line(points = {{66, -5.2}, {66, 14}, {36, 14}, {36, 0}, {0, 0}}, color = {191, 0, 0}));
  connect(Hobby.thermRoom, ThermHobby) annotation(Line(points = {{69.18, 56.8}, {69.18, 44}, {36, 44}, {36, 60}, {20, 60}}, color = {191, 0, 0}));
  connect(ThermLivingroom, Livingroom.thermRoom) annotation(Line(points = {{-20, 60}, {-32, 60}, {-32, 48}, {-68.4, 48}, {-68.4, 52.4}}, color = {191, 0, 0}));
  connect(Livingroom.AirExchangePort, AirExchangePort[1]) annotation(Line(points = {{-68.51, 77.52}, {-68.51, 86}, {-90, 86}, {-90, -14.25}, {-115, -14.25}}, color = {0, 0, 127}));
  connect(Hobby.AirExchangePort, AirExchangePort[2]) annotation(Line(points = {{68.895, 75.64}, {68.895, 86}, {-90, 86}, {-90, -6.75}, {-115, -6.75}}, color = {0, 0, 127}));
  connect(Kitchen.SolarRadiationPort_OW1, South) annotation(Line(points = {{-83.9, -61.6}, {-90, -61.6}, {-90, -92}, {90, -92}, {90, 26}, {110, 26}}, color = {255, 128, 0}));
  connect(Corridor.thermInsideWall2b, Kitchen.thermInsideWall1b) annotation(Line(points = {{44, -10.9}, {36, -10.9}, {36, -92}, {-34, -92}, {-34, -48.8}, {-46, -48.8}}, color = {191, 0, 0}));
  connect(WC_Storage.starRoom, StarWC_Storage) annotation(Line(points = {{61.2, -64.8}, {61.2, -70}, {36, -70}, {36, -60}, {20, -60}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(WC_Storage.thermRoom, ThermWC_Storage) annotation(Line(points = {{69.18, -64.8}, {69.18, -70}, {36, -70}, {36, -40}, {20, -40}}, color = {191, 0, 0}));
  connect(WC_Storage.AirExchangePort, AirExchangePort[3]) annotation(Line(points = {{68.895, -83.64}, {68.895, -92}, {-90, -92}, {-90, 0.75}, {-115, 0.75}}, color = {0, 0, 127}));
  connect(Kitchen.AirExchangePort, AirExchangePort[4]) annotation(Line(points = {{-68.1, -83.52}, {-68.1, -92}, {-90, -92}, {-90, 8.25}, {-115, 8.25}}, color = {0, 0, 127}));
  connect(Kitchen.starRoom, StarKitchen) annotation(Line(points = {{-60, -58.4}, {-60, -54}, {-34, -54}, {-34, -60}, {-20, -60}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(Kitchen.thermRoom, ThermKitchen) annotation(Line(points = {{-68, -58.4}, {-68, -54}, {-34, -54}, {-34, -40}, {-20, -40}}, color = {191, 0, 0}));
  connect(Corridor.AirExchangePort, AirExchangePort_doorSt.y) annotation(Line(points = {{82, -12.8}, {90, -12.8}, {90, -92}, {-90, -92}, {-90, -60}, {-99.2, -60}}, color = {0, 0, 127}));
  connect(Livingroom.starRoom, StarLivingroom) annotation(Line(points = {{-59.6, 52.4}, {-59.6, 48}, {-32, 48}, {-32, 40}, {-20, 40}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(Livingroom.thermFloor, ThermFloor[1]) annotation(Line(points = {{-68.84, 38.32}, {-68.84, 6}, {-90, 6}, {-90, -92}, {2, -92}, {2, -98.8}}, color = {191, 0, 0}, pattern = LinePattern.Dash));
  connect(Hobby.thermFloor, ThermFloor[2]) annotation(Line(points = {{69.18, 46.24}, {69.18, 22}, {90, 22}, {90, -92}, {8, -92}, {2, -96.4}}, color = {191, 0, 0}, pattern = LinePattern.Dash));
  connect(Corridor.thermFloor, ThermFloor[3]) annotation(Line(points = {{66.4, -13.56}, {66.4, -32}, {90, -32}, {90, -92}, {4, -92}, {4, -94}, {2, -94}}, color = {191, 0, 0}, pattern = LinePattern.Dash));
  connect(WC_Storage.thermFloor, ThermFloor[4]) annotation(Line(points = {{69.18, -54.24}, {90, -54.24}, {90, -91.6}, {2, -91.6}}, color = {191, 0, 0}, pattern = LinePattern.Dash));
  connect(Kitchen.thermFloor, ThermFloor[5]) annotation(Line(points = {{-68.4, -44.32}, {-90, -44.32}, {-90, -92}, {-4, -92}, {2, -89.2}}, color = {191, 0, 0}, pattern = LinePattern.Dash));
  annotation(__Dymola_Images(Parameters(source = "AixLib/Resources/Images/Building/HighOrder/Groundfloor_5Rooms.png")), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Bitmap(extent = {{-96, 90}, {100, -106}}, fileName = "modelica://AixLib/Resources/Images/Building/HighOrder/Groundfloor_icon.png"), Text(extent = {{-66, 66}, {10, 54}}, lineColor = {0, 0, 0}, textString = "Livingroom"), Text(extent = {{14, 76}, {64, 62}}, lineColor = {0, 0, 0}, textString = "Hobby"), Text(extent = {{22, 24}, {56, 14}}, lineColor = {0, 0, 0}, textString = "Corridor"), Text(extent = {{-2, -42}, {74, -52}}, lineColor = {0, 0, 0}, textString = "WC_Storage"), Text(extent = {{-50, -10}, {-6, -24}}, lineColor = {0, 0, 0}, textString = "Kitchen")}), Documentation(revisions = "<html>
 <ul>
 <li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
 <li><i>July 10, 2011</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for the envelope of the ground floor.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Resources/Images/Stars/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
 </html>"));
end GroundFloorBuildingEnvelope;
