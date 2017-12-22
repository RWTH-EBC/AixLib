within AixLib.Building.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope;


model WholeHouseBuildingEnvelope
  import AixLib;
  ///////// construction parameters
  parameter Integer TMC = 1 "Thermal Mass Class" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1 "Heavy", choice = 2 "Medium", choice = 3 "Light", radioButtons = true));
  parameter Integer TIR = 1 "Thermal Insulation Regulation" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1
        "EnEV_2009",                                                                                                    choice = 2
        "EnEV_2002",                                                                                                    choice = 3
        "WSchV_1995",                                                                                                    choice = 4
        "WSchV_1984",                                                                                                    radioButtons = true));
  parameter Integer TRY = 1 "Region according to TRY" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1 "TRY01", choice = 2 "TRY02", choice = 3 "TRY03", choice = 4 "TRY04", choice = 5 "TRY05", choice = 6 "TRY06", choice = 7 "TRY07", choice = 8 "TRY08", choice = 9 "TRY09", choice = 10 "TRY10", choice = 11 "TRY11", choice = 12 "TRY12", choice = 13 "TRY13", choice = 14 "TRY14", choice = 15 "TRY15", radioButtons = true));
  parameter Boolean withFloorHeating = false
    "If true, that floor has different connectors"                                          annotation(Dialog(group = "Construction parameters"), choices(checkBox = true));
  replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
    "Medium in the system"                                                                             annotation(Dialog(tab = "Hydraulics", group = "Medium"), choicesAllMatching = true);
  parameter Real AirExchangeCorridor = 2 "Air exchange corridors in 1/h " annotation(Dialog(group = "Air Exchange Corridors", descriptionLabel = true));
  parameter Real AirExchangeAttic = 0 "Air exchange attic in 1/h " annotation(Dialog(group = "Air Exchange Attic", descriptionLabel = true));
  // Dynamic Ventilation
  parameter Boolean withDynamicVentilation = true "Dynamic ventilation" annotation(Dialog(group = "Dynamic ventilation", descriptionLabel = true), choices(checkBox = true));
  parameter Modelica.SIunits.Temperature HeatingLimit = 253.15
    "Outside temperature at which the heating activates"                                                            annotation(Dialog(group = "Dynamic ventilation", descriptionLabel = true, enable = if withDynamicVentilation then true else false));
  parameter Real Max_VR = 200 "Maximal ventilation rate" annotation(Dialog(group = "Dynamic ventilation", descriptionLabel = true, enable = if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.TemperatureDifference Diff_toTempset = 3
    "Difference to set temperature"                                                                   annotation(Dialog(group = "Dynamic ventilation", descriptionLabel = true, enable = if withDynamicVentilation then true else false));
  GroundFloorBuildingEnvelope groundFloor_Building(TMC = TMC, TIR = TIR, withDynamicVentilation = withDynamicVentilation, HeatingLimit = HeatingLimit, Max_VR = Max_VR, Diff_toTempset = Diff_toTempset, withFloorHeating = withFloorHeating,
    TRY=TRY)                                                                                                     annotation(Placement(transformation(extent = {{-26, -94}, {22, -42}})));
  AixLib.Building.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope.UpperFloorBuildingEnvelope
                                                                                                      upperFloor_Building(TMC = TMC, TIR = TIR, HeatingLimit = HeatingLimit, Max_VR = Max_VR, Diff_toTempset = Diff_toTempset, withDynamicVentilation = withDynamicVentilation, withFloorHeating = withFloorHeating) annotation(Placement(transformation(extent = {{-26, -22}, {20, 30}})));
  Rooms.OFD.Attic_Ro2Lf5 attic_2Ro_5Rooms(length = 10.64, room1_length = 5.875, room2_length = 3.215, room3_length = 3.92, room4_length = 3.215, room5_length = 4.62, room1_width = 3.84, room2_width = 3.84, room3_width = 3.84, room4_width = 3.84, room5_width = 3.84, roof_width1 = 3.36, roof_width2 = 3.36, solar_absorptance_RO = 0.1, width = 4.75, TMC = TMC, TIR = TIR, alfa = 1.5707963267949) annotation(Placement(transformation(extent = {{-26, 46}, {20, 86}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside annotation(Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation(Placement(transformation(extent = {{-120, 26}, {-80, 66}}), iconTransformation(extent = {{-108, 38}, {-80, 66}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort[4] annotation(Placement(transformation(extent = {{-120, -16}, {-80, 24}}), iconTransformation(extent = {{-108, -4}, {-80, 24}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_RoofS annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {90, 58})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_RoofN annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {90, 90})));
  Utilities.Interfaces.SolarRad_in North annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {90, 18})));
  Utilities.Interfaces.SolarRad_in East annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {90, -18})));
  Utilities.Interfaces.SolarRad_in South annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {90, -56})));
  Utilities.Interfaces.SolarRad_in West annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {90, -90})));
  AixLib.Building.Components.DryAir.VarAirExchange varAirExchange(V = upperFloor_Building.Corridor.airload.V) annotation(Placement(transformation(extent = {{-6, -6}, {6, 6}}, rotation = 270, origin = {36, -32})));
  Modelica.Blocks.Sources.Constant AirExchangeCorridor_Source(k = AirExchangeCorridor) annotation(Placement(transformation(extent = {{22, -34}, {26, -30}})));
  Modelica.Blocks.Sources.Constant AirExchangeAttic_Source(k = AirExchangeAttic) annotation(Placement(transformation(extent = {{-60, 70}, {-52, 78}})));
equation
  connect(groundFloor_Building.thermCeiling_Livingroom, upperFloor_Building.thermFloor_Bedroom) annotation(Line(points = {{-24.08, -39.66}, {-24.08, -32.83}, {-23.7, -32.83}, {-23.7, -24.6}}, color = {191, 0, 0}));
  connect(groundFloor_Building.thermCeiling_Hobby, upperFloor_Building.thermFloor_Children1) annotation(Line(points = {{-13.76, -39.66}, {-13.76, -32.83}, {-14.5, -32.83}, {-14.5, -24.6}}, color = {191, 0, 0}));
  connect(groundFloor_Building.thermCeiling_Corridor, upperFloor_Building.thermFloor_Corridor) annotation(Line(points = {{-4.64, -39.66}, {-4.64, -32.83}, {-5.3, -32.83}, {-5.3, -24.6}}, color = {191, 0, 0}));
  connect(groundFloor_Building.thermCeiling_WCStorage, upperFloor_Building.thermFloor_Bath) annotation(Line(points = {{4.96, -39.66}, {4.96, -32.83}, {3.9, -32.83}, {3.9, -24.6}}, color = {191, 0, 0}));
  connect(groundFloor_Building.thermCeiling_Kitchen, upperFloor_Building.thermFloor_Children2) annotation(Line(points = {{15.04, -39.66}, {15.04, -32.83}, {13.1, -32.83}, {13.1, -24.6}}, color = {191, 0, 0}));
  connect(upperFloor_Building.thermOutside, thermOutside) annotation(Line(points = {{-27.84, 23.24}, {-74, 23.24}, {-74, 90}, {-90, 90}}, color = {191, 0, 0}));
  connect(attic_2Ro_5Rooms.thermOutside, thermOutside) annotation(Line(points = {{-23.7, 84}, {-74, 84}, {-74, 90}, {-90, 90}}, color = {191, 0, 0}));
  connect(groundFloor_Building.thermOutside, thermOutside) annotation(Line(points = {{-27.92, -48.76}, {-74, -48.76}, {-74, 90}, {-90, 90}}, color = {191, 0, 0}));
  connect(upperFloor_Building.thermCeiling_Bedroom, attic_2Ro_5Rooms.thermRoom1) annotation(Line(points = {{-23.7, 32.34}, {-23.7, 48}}, color = {191, 0, 0}));
  connect(upperFloor_Building.thermCeiling_Children1, attic_2Ro_5Rooms.thermRoom2) annotation(Line(points = {{-14.27, 32.34}, {-14.27, 40.17}, {-14.5, 40.17}, {-14.5, 48}}, color = {191, 0, 0}));
  connect(upperFloor_Building.thermCeiling_Corridor, attic_2Ro_5Rooms.thermRoom3) annotation(Line(points = {{-5.53, 32.34}, {-5.53, 40.17}, {-5.3, 40.17}, {-5.3, 48}}, color = {191, 0, 0}));
  connect(upperFloor_Building.thermCeiling_Bath, attic_2Ro_5Rooms.thermRoom4) annotation(Line(points = {{3.67, 32.34}, {3.67, 40.17}, {3.9, 40.17}, {3.9, 48}}, color = {191, 0, 0}));
  connect(upperFloor_Building.thermCeiling_Children2, attic_2Ro_5Rooms.thermRoom5) annotation(Line(points = {{12.87, 32.34}, {12.87, 39.17}, {13.1, 39.17}, {13.1, 48}}, color = {191, 0, 0}));
  connect(attic_2Ro_5Rooms.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{-25.885, 66}, {-74, 66}, {-74, 46}, {-100, 46}}, color = {0, 0, 127}));
  connect(upperFloor_Building.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{-29.45, 10.5}, {-32, 12}, {-74, 12}, {-74, 46}, {-100, 46}}, color = {0, 0, 127}));
  connect(groundFloor_Building.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{-29.6, -60.98}, {-74, -60.98}, {-74, 46}, {-100, 46}}, color = {0, 0, 127}));
  connect(upperFloor_Building.North, North) annotation(Line(points = {{22.3, 5.56}, {60, 5.56}, {60, 18}, {90, 18}}, color = {255, 128, 0}));
  connect(groundFloor_Building.North, North) annotation(Line(points = {{24.4, -45.12}, {60, -45.12}, {60, 18}, {90, 18}}, color = {255, 128, 0}));
  connect(upperFloor_Building.East, East) annotation(Line(points = {{22.3, -2.24}, {60, -2.24}, {60, -18}, {90, -18}}, color = {255, 128, 0}));
  connect(groundFloor_Building.East, East) annotation(Line(points = {{24.4, -52.4}, {60, -52.4}, {60, -18}, {90, -18}}, color = {255, 128, 0}));
  connect(upperFloor_Building.South, South) annotation(Line(points = {{22.3, -10.04}, {60, -10.04}, {60, -56}, {90, -56}}, color = {255, 128, 0}));
  connect(groundFloor_Building.South, South) annotation(Line(points = {{24.4, -61.24}, {60, -61.24}, {60, -56}, {90, -56}}, color = {255, 128, 0}));
  connect(upperFloor_Building.West, West) annotation(Line(points = {{22.3, -17.84}, {60, -17.84}, {60, -90}, {90, -90}}, color = {255, 128, 0}));
  connect(groundFloor_Building.West, West) annotation(Line(points = {{24.4, -72.16}, {60, -72.16}, {60, -90}, {90, -90}}, color = {255, 128, 0}));
  connect(upperFloor_Building.RoofS, SolarRadiationPort_RoofS) annotation(Line(points = {{22.3, 15.44}, {60, 15.44}, {60, 58}, {90, 58}}, color = {255, 128, 0}));
  connect(upperFloor_Building.RoofN, SolarRadiationPort_RoofN) annotation(Line(points = {{22.3, 23.76}, {60, 23.76}, {60, 90}, {90, 90}}, color = {255, 128, 0}));
  connect(groundFloor_Building.thermCorridor, varAirExchange.port_b) annotation(Line(points = {{24.4, -39.4}, {36, -39.4}, {36, -38}}, color = {191, 0, 0}));
  connect(upperFloor_Building.thermCorridor, varAirExchange.port_a) annotation(Line(points = {{22.3, -24.6}, {36, -24.6}, {36, -26}}, color = {191, 0, 0}));
  connect(AirExchangeCorridor_Source.y, varAirExchange.InPort1) annotation(Line(points = {{26.2, -32}, {28, -32}, {28, -24}, {32.16, -24}, {32.16, -26.6}}, color = {0, 0, 127}));
  connect(groundFloor_Building.AirExchangePort, AirExchangePort) annotation(Line(points = {{-29.6, -68.78}, {-74, -68.78}, {-74, 4}, {-100, 4}}, color = {0, 0, 127}));
  connect(upperFloor_Building.AirExchangePort, AirExchangePort) annotation(Line(points = {{-29.45, 1.14}, {-74, 1.14}, {-74, 4}, {-100, 4}}, color = {0, 0, 127}));
  connect(AirExchangeAttic_Source.y, attic_2Ro_5Rooms.AirExchangePort) annotation(Line(points = {{-51.6, 74}, {-26, 74}}, color = {0, 0, 127}));
  connect(attic_2Ro_5Rooms.SolarRadiationPort_RO1, SolarRadiationPort_RoofS) annotation(Line(points = {{-14.5, 84}, {-14, 88}, {-14, 90}, {60, 90}, {60, 58}, {90, 58}}, color = {255, 128, 0}));
  connect(attic_2Ro_5Rooms.SolarRadiationPort_RO2, SolarRadiationPort_RoofN) annotation(Line(points = {{8.5, 84}, {10, 84}, {10, 90}, {90, 90}}, color = {255, 128, 0}));
  connect(attic_2Ro_5Rooms.SolarRadiationPort_OW2, West) annotation (Line(
      points={{22.3,62.4},{60,62.4},{60,-90},{90,-90}},
      color={255,128,0}));
  connect(attic_2Ro_5Rooms.SolarRadiationPort_OW1, East) annotation (Line(
      points={{-27.38,62},{-74,62},{-74,90},{60,90},{60,-18},{90,-18}},
      color={255,128,0}));
  annotation(__Dymola_Images(Parameters(source = "AixLib/Resources/Images/Building/HighOrder/Grundriss.png")), Icon(graphics={  Bitmap(extent = {{-78, 74}, {72, -68}}, fileName = "modelica://AixLib/Resources/Images/Building/HighOrder/Grundriss.PNG")}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for the envelope of the whole one family dwelling.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Resources/Images/Stars/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
 </html>", revisions="<html>

 <ul>
 <li><i>Mai 7, 2015</i> by Ana Constantin:<br/>Corrected connection of gabled vertical walls with solar radiation (E and W)</li>
 <li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
 <li><i>July 10, 2011</i> by Ana Constantin:<br/>Implemented</li>

 </ul>

 </html>"));
end WholeHouseBuildingEnvelope;
