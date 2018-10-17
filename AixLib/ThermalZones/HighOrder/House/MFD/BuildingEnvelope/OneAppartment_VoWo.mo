within AixLib.ThermalZones.HighOrder.House.MFD.BuildingEnvelope;
model OneAppartment_VoWo
  parameter Integer TMC = 1 "Thermal Mass Class" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1 "Heavy", choice = 2 "Medium", choice = 3 "Light", radioButtons = true));
  parameter Integer TIR = 4 "Thermal Insulation Regulation" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1
        "EnEV_2009",                                                                                                    choice = 2
        "EnEV_2002",                                                                                                    choice = 3
        "WSchV_1995",                                                                                                    choice = 4
        "WSchV_1984",                                                                                                    radioButtons = true));
  parameter Integer Floor = 1 "Floor" annotation(Dialog(group = "Floor", compact = true, descriptionLabel = true), choices(choice = 1 "GF", choice = 2 "1F", choice = 3 "2F", radioButtons = true));
  // Sunblind
  parameter Boolean use_sunblind = false
    "Will sunblind become active automatically?"
    annotation(Dialog(group = "Sunblind"));
  parameter Real ratioSunblind(min=0.0, max=1.0)
    "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
    annotation(Dialog(group = "Sunblind", enable=use_sunblind));
  parameter Modelica.SIunits.Irradiance solIrrThreshold(min=0.0)
    "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
    annotation(Dialog(group = "Sunblind", enable=use_sunblind));
  parameter Modelica.SIunits.Temperature TOutAirLimit
    "Temperature at which sunblind closes (see also solIrrThreshold)"
    annotation(Dialog(group = "Sunblind", enable=use_sunblind));
  AixLib.ThermalZones.HighOrder.Rooms.MFD.OneAppartment.Livingroom_VoWo Livingroom(TMC = TMC, TIR = TIR, Floor = Floor,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit) annotation(Placement(transformation(extent = {{-68, 26}, {-16, 78}})));
  AixLib.ThermalZones.HighOrder.Rooms.MFD.OneAppartment.Children_VoWo Children(TMC = TMC, TIR = TIR, Floor = Floor,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit) annotation(Placement(transformation(extent = {{36, 38}, {74, 76}})));
  AixLib.ThermalZones.HighOrder.Rooms.MFD.OneAppartment.Corridor_VoWo Corridor(TMC = TMC, TIR = TIR, Floor = Floor,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit) annotation(Placement(transformation(extent = {{22, -12}, {60, 26}})));
  AixLib.ThermalZones.HighOrder.Rooms.MFD.OneAppartment.Bedroom_VoWo Bedroom(TMC = TMC, TIR = TIR, Floor = Floor,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit) annotation(Placement(transformation(extent = {{-64, -74}, {-20, -30}})));
  AixLib.ThermalZones.HighOrder.Rooms.MFD.OneAppartment.Bathroom_VoWo Bathroom(TMC = TMC, TIR = TIR, Floor = Floor,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit) annotation(Placement(transformation(extent = {{-6, -72}, {32, -34}})));
  AixLib.ThermalZones.HighOrder.Rooms.MFD.OneAppartment.Kitchen_VoWo Kitchen(TMC = TMC, TIR = TIR, Floor = Floor,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit) annotation(Placement(transformation(extent = {{46, -74}, {88, -28}})));
  Utilities.Interfaces.SolarRad_in SolarRadiation_SE annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {28, 110})));
  Utilities.Interfaces.SolarRad_in SolarRadiation_NW annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {58, 110})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort[5] annotation(Placement(transformation(extent = {{-15, -15}, {15, 15}}, rotation = 270, origin = {-9, 115}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-4, 110})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation(Placement(transformation(extent = {{-13, -13}, {13, 13}}, rotation = 270, origin = {-41, 113}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-38, 110})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside annotation(Placement(transformation(extent = {{-82, 100}, {-62, 120}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermNeighbour_Livingroom annotation(Placement(transformation(extent = {{-120, 80}, {-100, 100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermNeigbour_Bedroom annotation(Placement(transformation(extent = {{-120, 56}, {-100, 76}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermNeighbour_Child annotation(Placement(transformation(extent = {{100, 80}, {120, 100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermStaircase annotation(Placement(transformation(extent = {{100, 54}, {120, 74}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Livingroom annotation(Placement(transformation(extent = {{-120, 28}, {-100, 48}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Livingroom annotation(Placement(transformation(extent = {{-120, 4}, {-100, 24}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Bedroom annotation(Placement(transformation(extent = {{-120, -22}, {-100, -2}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Bedroom annotation(Placement(transformation(extent = {{-120, -46}, {-100, -26}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Bath annotation(Placement(transformation(extent = {{-120, -72}, {-100, -52}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Bath annotation(Placement(transformation(extent = {{-120, -100}, {-100, -80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Children annotation(Placement(transformation(extent = {{100, 26}, {120, 46}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Children annotation(Placement(transformation(extent = {{100, 2}, {120, 22}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Corridor annotation(Placement(transformation(extent = {{100, -22}, {120, -2}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Corridor annotation(Placement(transformation(extent = {{100, -46}, {120, -26}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Kitchen annotation(Placement(transformation(extent = {{100, -72}, {120, -52}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Kitchen annotation(Placement(transformation(extent = {{100, -96}, {120, -76}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermLivingroom annotation(Placement(transformation(extent = {{-60, 12}, {-44, 28}}), iconTransformation(extent = {{-56, 14}, {-44, 28}})));
  Utilities.Interfaces.Star StarLivingroom annotation(Placement(transformation(extent = {{-40, 12}, {-24, 28}}), iconTransformation(extent = {{-40, 0}, {-24, 14}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermChildren annotation(Placement(transformation(extent={{34,28},
            {50,44}}),                                                                                                                  iconTransformation(extent={{34,28},
            {50,44}})));
  Utilities.Interfaces.Star StarChildren annotation(Placement(transformation(extent = {{60, 24}, {76, 40}}), iconTransformation(extent = {{56, 22}, {76, 42}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermBedroom annotation(Placement(transformation(extent = {{-60, -20}, {-44, -4}}), iconTransformation(extent = {{-60, -20}, {-44, -4}})));
  Utilities.Interfaces.Star StarBedroom annotation(Placement(transformation(extent = {{-40, -20}, {-24, -4}}), iconTransformation(extent = {{-40, -20}, {-24, -2}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermBath annotation(Placement(transformation(extent = {{-20, -28}, {-4, -12}}), iconTransformation(extent = {{-20, -28}, {-4, -12}})));
  Utilities.Interfaces.Star StarBath annotation(Placement(transformation(extent = {{0, -28}, {16, -12}}), iconTransformation(extent = {{-2, -28}, {16, -12}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermKitchen annotation(Placement(transformation(extent = {{40, -22}, {56, -6}}), iconTransformation(extent = {{40, -20}, {56, -4}})));
  Utilities.Interfaces.Star StarKitchen annotation(Placement(transformation(extent = {{62, -22}, {78, -6}}), iconTransformation(extent = {{34, -44}, {52, -26}})));
equation
  connect(Bedroom.SolarRadiation_NW, SolarRadiation_NW) annotation(Line(points = {{-56.96, -74}, {-56, -74}, {-56, -80}, {-80, -80}, {-80, 90}, {58, 90}, {58, 110}}, color = {255, 128, 0}));
  connect(Bathroom.SolarRadiation_NW, SolarRadiation_NW) annotation(Line(points = {{0.688, -72}, {0, -72}, {0, -80}, {-80, -80}, {-80, 90}, {58, 90}, {58, 110}}, color = {255, 128, 0}));
  connect(Kitchen.SolarRadiation_NW, SolarRadiation_NW) annotation(Line(points = {{59.44, -74}, {56, -74}, {56, -80}, {80, -80}, {80, 90}, {58, 90}, {58, 110}}, color = {255, 128, 0}));
  connect(Children.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{36, 66.88}, {20, 66.88}, {20, 90}, {-41, 90}, {-41, 113}}, color = {0, 0, 127}));
  connect(Livingroom.WindSpeedPort, WindSpeedPort) annotation(Line(points={{
          -64.9412,58.9333},{-80,58.9333},{-80,90},{-41,90},{-41,113}},                                                                              color = {0, 0, 127}));
  connect(Bedroom.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{-64, -42.32}, {-80, -42.32}, {-80, 90}, {-41, 90}, {-41, 113}}, color = {0, 0, 127}));
  connect(Bathroom.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{-6.304, -46.16}, {-18, -46.16}, {-18, -80}, {80, -80}, {80, 90}, {-41, 90}, {-41, 113}}, color = {0, 0, 127}));
  connect(Kitchen.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{46.168, -41.064}, {36, -41.064}, {36, -80}, {80, -80}, {80, 90}, {-41, 90}, {-41, 113}}, color = {0, 0, 127}));
  connect(Livingroom.thermOutside, thermOutside) annotation(Line(points={{
          -64.9412,74.5333},{-80,74.5333},{-80,110},{-72,110}},                                                                          color = {191, 0, 0}));
  connect(Children.thermOutside, thermOutside) annotation(Line(points = {{42.08, 75.696}, {20, 75.696}, {20, 90}, {-72, 90}, {-72, 110}}, color = {191, 0, 0}));
  connect(Bedroom.thermOutside, thermOutside) annotation(Line(points = {{-64, -31.76}, {-80, -31.76}, {-80, 90}, {-72, 90}, {-72, 110}}, color = {191, 0, 0}));
  connect(Bathroom.thermOutside, thermOutside) annotation(Line(points = {{-6, -35.52}, {-18, -35.52}, {-18, -80}, {-80, -80}, {-80, 90}, {-72, 90}, {-72, 110}}, color = {191, 0, 0}));
  connect(Kitchen.thermOutside, thermOutside) annotation(Line(points = {{46.336, -29.84}, {42, -29.84}, {42, -30}, {36, -30}, {36, -80}, {-80, -80}, {-80, 90}, {-72, 90}, {-72, 110}}, color = {191, 0, 0}));
  connect(Livingroom.thermNeighbour, thermNeighbour_Livingroom) annotation(Line(points={{
          -64.9412,53.7333},{-80,53.7333},{-80,90},{-110,90}},                                                                                         color = {191, 0, 0}));
  connect(Bedroom.thermNeigbour, thermNeigbour_Bedroom) annotation(Line(points = {{-64, -63.44}, {-80, -63.44}, {-80, 66}, {-110, 66}}, color = {191, 0, 0}));
  connect(Children.thermNeighbour, thermNeighbour_Child) annotation(Line(points = {{36, 62.32}, {20, 62.32}, {20, 90}, {110, 90}}, color = {191, 0, 0}));
  connect(Children.thermStaircase, thermStaircase) annotation(Line(points = {{36, 57.76}, {20, 57.76}, {20, 90}, {80, 90}, {80, 64}, {110, 64}}, color = {191, 0, 0}));
  connect(Corridor.thermStaircase, thermStaircase) annotation(Line(points = {{21.696, 22.96}, {18, 22.96}, {18, -20}, {36, -20}, {36, -80}, {80, -80}, {80, 64}, {110, 64}}, color = {191, 0, 0}));
  connect(Livingroom.thermBedroom, Bedroom.thermLivingroom) annotation(Line(points={{
          -64.9412,48.5333},{-80,48.5333},{-80,-47.6},{-64,-47.6}},                                                                                     color = {191, 0, 0}));
  connect(Corridor.thermLivingroom, Livingroom.thermCorridor) annotation(Line(points={{21.696,
          13.84},{18,13.84},{18,-20},{36,-20},{36,-80},{-80,-80},{-80,43.3333},
          {-64.9412,43.3333}},                                                                                                    color = {191, 0, 0}));
  connect(Livingroom.thermChildren, Children.thermLivingroom) annotation(Line(points={{
          -64.9412,38.1333},{-80,38.1333},{-80,90},{20,90},{20,48.64},{36,48.64}},                                    color = {191, 0, 0}));
  connect(Livingroom.thermCeiling, thermCeiling_Livingroom) annotation(Line(points={{
          -64.9412,32.9333},{-80,32.9333},{-80,38},{-110,38}},                                                                                     color = {191, 0, 0}));
  connect(Livingroom.thermFloor, thermFloor_Livingroom) annotation(Line(points={{
          -64.9412,27.7333},{-80,27.7333},{-80,14},{-110,14}},                                                                                 color = {191, 0, 0}));
  connect(Bedroom.thermCorridor, Corridor.thermBedroom) annotation(Line(points = {{-64, -52.88}, {-80, -52.88}, {-80, -80}, {36, -80}, {36, -20}, {18, -20}, {18, 0}, {22, 0}, {22, 0.16}}, color = {191, 0, 0}));
  connect(Bedroom.thermBath, Bathroom.thermBedroom) annotation(Line(points = {{-64, -58.16}, {-80, -58.16}, {-80, -80}, {-18, -80}, {-18, -59.84}, {-6, -59.84}}, color = {191, 0, 0}));
  connect(Bedroom.thermCeiling, thermCeiling_Bedroom) annotation(Line(points = {{-64, -68.72}, {-80, -68.72}, {-80, -12}, {-110, -12}}, color = {191, 0, 0}));
  connect(Bedroom.thermFloor, thermFloor_Bedroom) annotation(Line(points = {{-64, -74}, {-80, -74}, {-80, -36}, {-110, -36}}, color = {191, 0, 0}));
  connect(Bathroom.thermCorridor, Corridor.thermBath) annotation(Line(points = {{-6, -50.72}, {-18, -50.72}, {-18, -80}, {36, -80}, {36, -20}, {18, -20}, {18, 4}, {22, 4}, {22, 4.72}}, color = {191, 0, 0}));
  connect(Bathroom.thermKitchen, Kitchen.thermBath) annotation(Line(points = {{-6, -55.28}, {-18, -55.28}, {-18, -80}, {36, -80}, {36, -62.96}, {46, -62.96}}, color = {191, 0, 0}));
  connect(Kitchen.thermStaircase, thermStaircase) annotation(Line(points = {{46, -55.6}, {36, -55.6}, {36, -80}, {80, -80}, {80, 64}, {110, 64}}, color = {191, 0, 0}));
  connect(Bathroom.thermCeiling, thermCeiling_Bath) annotation(Line(points = {{-6, -64.4}, {-18, -64.4}, {-18, -80}, {-80, -80}, {-80, -62}, {-110, -62}}, color = {191, 0, 0}));
  connect(Bathroom.thermFloor, thermFloor_Bath) annotation(Line(points = {{-6, -68.96}, {-18, -68.96}, {-18, -80}, {-110, -80}, {-110, -90}}, color = {191, 0, 0}));
  connect(Kitchen.thermCorridor, Corridor.thermKitchen) annotation(Line(points = {{46, -48.24}, {36, -48.24}, {36, -20}, {18, -20}, {18, 18.4}, {21.696, 18.4}}, color = {191, 0, 0}));
  connect(Children.thermCorridor, Corridor.thermChild) annotation(Line(points = {{36, 53.2}, {20, 53.2}, {20, 90}, {80, 90}, {80, -80}, {36, -80}, {36, -20}, {18, -20}, {18, 9.28}, {21.696, 9.28}}, color = {191, 0, 0}));
  connect(Children.thermCeiling, thermCeiling_Children) annotation(Line(points = {{36, 44.08}, {20, 44.08}, {20, 90}, {80, 90}, {80, 36}, {110, 36}}, color = {191, 0, 0}));
  connect(Children.thermFloor, thermFloor_Children) annotation(Line(points = {{36, 39.216}, {20, 39.216}, {20, 90}, {80, 90}, {80, 12}, {110, 12}}, color = {191, 0, 0}));
  connect(Kitchen.thermCeiling, thermCeiling_Kitchen) annotation(Line(points = {{46, -70.32}, {36, -70.32}, {36, -80}, {80, -80}, {80, -62}, {110, -62}}, color = {191, 0, 0}));
  connect(Kitchen.thermFloor, thermFloor_Kitchen) annotation(Line(points = {{52.72, -74}, {36, -74}, {36, -80}, {80, -80}, {80, -86}, {110, -86}}, color = {191, 0, 0}));
  connect(Livingroom.ThermRoom, thermLivingroom) annotation(Line(points={{
          -42.3059,54.4267},{-42.3059,51.64},{-52,51.64},{-52,20}},                                                                          color = {191, 0, 0}));
  connect(Livingroom.StarInside1, StarLivingroom) annotation(Line(points={{
          -38.0235,54.4267},{-38.0235,54},{-32,54},{-32,20}},                                                                           color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(Children.StarRoom, StarChildren) annotation(Line(points = {{53.632, 61.408}, {54, 60}, {72, 60}, {72, 32}, {68, 32}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(Bedroom.StarRoom, StarBedroom) annotation(Line(points = {{-41.472, -53.584}, {-32, -53.584}, {-32, -12}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(Bathroom.ThermRoom, ThermBath) annotation(Line(points = {{6.464, -55.584}, {6.464, -30}, {-12, -30}, {-12, -20}}, color = {191, 0, 0}));
  connect(Bathroom.StarRoom, StarBath) annotation(Line(points = {{12.24, -55.888}, {12.24, -44}, {6, -44}, {6, -30}, {8, -30}, {8, -20}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(Kitchen.StarRoom, StarKitchen) annotation(Line(points = {{63.808, -53.392}, {58, -53.392}, {58, -14}, {70, -14}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(ThermBath, ThermBath) annotation(Line(points = {{-12, -20}, {-12, -20}}, color = {191, 0, 0}));
  connect(Livingroom.AirExchangePort, AirExchangePort[1]) annotation(Line(points={{
          -64.9412,65.8667},{-80,65.8667},{-80,90},{-9,90},{-9,127}},                                                                                     color = {0, 0, 127}));
  connect(Children.AirExchangePort, AirExchangePort[2]) annotation(Line(points = {{36, 71.44}, {20, 71.44}, {20, 90}, {-9, 90}, {-9, 121}}, color = {0, 0, 127}));
  connect(Children.ThermRoom, ThermChildren) annotation(Line(points={{48.768,
          61.712},{46,61.712},{46,36},{42,36}},                                                                             color = {191, 0, 0}));
  connect(Bedroom.ThermRoom, ThermBedroom) annotation(Line(points = {{-48.16, -53.936}, {-52, -53.936}, {-52, -40}, {-48, -40}, {-48, -30}, {-52, -30}, {-52, -12}}, color = {191, 0, 0}));
  connect(Kitchen.AirExchangePort, AirExchangePort[3]) annotation(Line(points = {{46.168, -35.176}, {36, -35.176}, {36, -80}, {80, -80}, {80, 90}, {-9, 90}, {-9, 115}}, color = {0, 0, 127}));
  connect(Bathroom.AirExchangePort, AirExchangePort[4]) annotation(Line(points = {{-6.304, -40.08}, {-18, -40.08}, {-18, -80}, {80, -80}, {80, 90}, {-9, 90}, {-9, 109}}, color = {0, 0, 127}));
  connect(Bedroom.AirExchangePort, AirExchangePort[5]) annotation(Line(points = {{-64, -37.04}, {-80, -37.04}, {-80, 90}, {-9, 90}, {-9, 103}}, color = {0, 0, 127}));
  connect(Corridor.thermFloor, thermFloor_Corridor) annotation(Line(points = {{22, -8.96}, {18, -8.96}, {18, -20}, {36, -20}, {36, -80}, {80, -80}, {80, -36}, {110, -36}}, color = {191, 0, 0}));
  connect(Corridor.thermCeiling, thermCeiling_Corridor) annotation(Line(points = {{22, -4.4}, {18, -4.4}, {18, -20}, {36, -20}, {36, -80}, {80, -80}, {80, -12}, {110, -12}}, color = {191, 0, 0}));
  connect(Kitchen.ThermRoom, ThermKitchen) annotation(Line(points = {{64.144, -47.872}, {58, -47.872}, {58, -14}, {48, -14}}, color = {191, 0, 0}));
  connect(Children.Strahlung_SE, SolarRadiation_SE) annotation(Line(points = {{46.64, 77.52}, {46.64, 90}, {28, 90}, {28, 110}}, color = {255, 128, 0}));
  connect(Livingroom.SolarRadiation_SE, SolarRadiation_SE) annotation(Line(points={{
          -52.0941,75.2267},{-52.0941,90},{28,90},{28,110}},                                                                                    color = {255, 128, 0}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-150, -150}, {150, 150}}), graphics), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-150, -150}, {150, 150}}), graphics={  Bitmap(extent={{
              -86,-96},{88,94}}, fileName=
              "modelica://AixLib/Resources/Images/Building/HighOrder/MFD_FloorPlan_En.PNG"),                                                                                                                                                                                                        Rectangle(extent = {{-52, 56}, {-4, 36}}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid,  pattern=LinePattern.None), Text(extent = {{-72, 58}, {16, 44}}, lineColor = {0, 0, 0}, textString = "Livingroom"), Rectangle(extent = {{28, 56}, {70, 18}}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid,  pattern=LinePattern.None), Text(extent={{
              12,60},{86,48}},                                                                                                                                                                                lineColor = {0, 0, 0}, textString = "Children"), Rectangle(extent = {{-8, 6}, {52, -14}}, fillColor = {170, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid,  pattern=LinePattern.None, lineColor = {170, 255, 255}), Text(extent = {{-16, 4}, {58, -8}}, lineColor = {0, 0, 0}, textString = "Corridor"), Rectangle(extent = {{-62, -28}, {-20, -78}}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid,  pattern=LinePattern.None), Text(extent={{
              -74,-50},{0,-62}},                                                                                                                                                                                  lineColor = {0, 0, 0}, textString = "Bedroom"), Rectangle(extent = {{-8, -28}, {12, -70}}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid,  pattern=LinePattern.None), Text(extent={{
              -32,-46},{42,-58}},                                                                                                                                                                                 lineColor = {0, 0, 0}, textString = "Bath"), Rectangle(extent = {{16, -28}, {52, -68}}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid,  pattern=LinePattern.None), Text(extent = {{0, -54}, {74, -66}}, lineColor = {0, 0, 0}, textString = "Kitchen")}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Complete model appartment</p>
 </html>", revisions = "<html>
 <ul>
 <li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
 <li><i>August 16, 2011</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>"));
end OneAppartment_VoWo;
