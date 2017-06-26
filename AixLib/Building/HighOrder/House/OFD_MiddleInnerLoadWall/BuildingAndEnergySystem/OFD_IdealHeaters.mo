within AixLib.Building.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingAndEnergySystem;


model OFD_IdealHeaters
  parameter Real ratioRadHeat = 0.3
    "ratio of radiative heat from total heat generated";
  parameter Integer TMC = 1 "Thermal Mass Class" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1 "Heavy", choice = 2 "Medium", choice = 3 "Light", radioButtons = true));
  parameter Integer TIR = 1 "Thermal Insulation Regulation" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1
        "EnEV_2009",                                                                                                    choice = 2
        "EnEV_2002",                                                                                                    choice = 3
        "WSchV_1995",                                                                                                    choice = 4
        "WSchV_1984",                                                                                                    radioButtons = true));
  parameter Real AirExchangeCorridor = 2 "Air exchange corridors in 1/h " annotation(Dialog(group = "Air Exchange Corridors", descriptionLabel = true));
  parameter Real AirExchangeAttic = 0 "Air exchange attic in 1/h " annotation(Dialog(group = "Air Exchange Attic", descriptionLabel = true));
  // Dynamic Ventilation
  parameter Boolean withDynamicVentilation = true "Dynamic ventilation" annotation(Dialog(group = "Dynamic ventilation", descriptionLabel = true), choices(checkBox = true));
  parameter Modelica.SIunits.Temperature HeatingLimit = 253.15
    "Outside temperature at which the heating activates"                                                            annotation(Dialog(group = "Dynamic ventilation", descriptionLabel = true, enable = if withDynamicVentilation then true else false));
  parameter Real Max_VR = 200 "Maximal ventilation rate" annotation(Dialog(group = "Dynamic ventilation", descriptionLabel = true, enable = if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.TemperatureDifference Diff_toTempset = 3
    "Difference to set temperature"                                                                   annotation(Dialog(group = "Dynamic ventilation", descriptionLabel = true, enable = if withDynamicVentilation then true else false));
  BuildingEnvelope.GroundFloorBuildingEnvelope GF(TMC = TMC, TIR = TIR, withDynamicVentilation = withDynamicVentilation, HeatingLimit = HeatingLimit, Max_VR = Max_VR, Diff_toTempset = Diff_toTempset, withFloorHeating = false) annotation(Placement(transformation(extent = {{-26, -94}, {22, -42}})));
  BuildingEnvelope.UpperFloorBuildingEnvelope UF(TMC = TMC, TIR = TIR, withDynamicVentilation = withDynamicVentilation, HeatingLimit = HeatingLimit, Max_VR = Max_VR, Diff_toTempset = Diff_toTempset, withFloorHeating = false) annotation(Placement(transformation(extent = {{-26, -24}, {20, 28}})));
  Rooms.OFD.Attic_Ro2Lf5 Attic(length = 10.64, room1_length = 5.875, room2_length = 3.215, room3_length = 3.92, room4_length = 3.215, room5_length = 4.62, roof_width1 = 3.36, roof_width2 = 3.36, solar_absorptance_RO = 0.1, width = 4.75, room1_width = 2.28, room2_width = 2.28, room3_width = 2.28, room4_width = 2.28, room5_width = 2.28, alfa = 1.5707963267949) annotation(Placement(transformation(extent = {{-26, 46}, {20, 86}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {-74, 120}), iconTransformation(extent = {{-14, -14}, {14, 14}}, rotation = 270, origin = {-68, 114})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort[6]
    "[1:6]=[N, E, S, W, RoofN, RoofS]"                                                      annotation(Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 180, origin = {190, 90})));
  Modelica.Blocks.Interfaces.RealInput NaturalVentilation_UF[4] annotation(Placement(transformation(extent = {{-118, 42}, {-86, 74}}), iconTransformation(extent = {{-118, 42}, {-86, 74}})));
  Modelica.Blocks.Interfaces.RealInput NaturalVentilation_GF[4] annotation(Placement(transformation(extent = {{-116, -2}, {-84, 30}}), iconTransformation(extent = {{-116, -2}, {-84, 30}})));
  Modelica.Blocks.Interfaces.RealInput TSet_UF[4] annotation(Placement(transformation(extent = {{-118, -52}, {-84, -18}}), iconTransformation(extent = {{-118, -52}, {-84, -18}})));
  Modelica.Blocks.Interfaces.RealInput TSet_GF[5] annotation(Placement(transformation(extent = {{-118, -100}, {-82, -64}}), iconTransformation(extent = {{-118, -100}, {-82, -64}})));
  Modelica.Blocks.Sources.Constant AirExchangeCorridor_Source(k = AirExchangeCorridor) annotation(Placement(transformation(extent = {{20, -34}, {24, -30}})));
  AixLib.Building.Components.DryAir.VarAirExchange varAirExchange(V = UF.Corridor.airload.V) annotation(Placement(transformation(extent = {{-6, -6}, {6, 6}}, rotation = 270, origin = {34, -32})));
  EnergySystem.IdealHeaters.GroundFloor GF_Hydraulic(ratioRadHeat = ratioRadHeat) annotation(Placement(transformation(extent = {{86, -84}, {128, -52}})));
  EnergySystem.IdealHeaters.UpperFloor UF_Hydraulic(ratioRadHeat = ratioRadHeat) annotation(Placement(transformation(extent = {{88, -10}, {132, 24}})));
  Modelica.Blocks.Sources.Constant AirExchangeAttic_Source(k = AirExchangeAttic)
    "Storage"                                                                              annotation(Placement(transformation(extent = {{-96, 80}, {-80, 96}}), iconTransformation(extent = {{-122, -72}, {-100, -50}})));
  Modelica.Blocks.Interfaces.RealInput Air_Temp annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = -90, origin = {120, 116}), iconTransformation(extent = {{-14, -14}, {14, 14}}, rotation = -90, origin = {120, 114})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempOutside annotation(Placement(transformation(extent = {{138.5, 62}, {158, 80}})));
equation
  connect(GF.thermCeiling_Livingroom, UF.thermFloor_Bedroom) annotation(Line(points = {{-24.08, -39.66}, {-24.08, -32.83}, {-23.7, -32.83}, {-23.7, -26.6}}, color = {191, 0, 0}));
  connect(GF.thermCeiling_Hobby, UF.thermFloor_Children1) annotation(Line(points = {{-13.76, -39.66}, {-13.76, -32.83}, {-14.5, -32.83}, {-14.5, -26.6}}, color = {191, 0, 0}));
  connect(GF.thermCeiling_Kitchen, UF.thermFloor_Children2) annotation(Line(points = {{15.04, -39.66}, {15.04, -32.83}, {13.1, -32.83}, {13.1, -26.6}}, color = {191, 0, 0}));
  connect(UF.thermCeiling_Bedroom, Attic.thermRoom1) annotation(Line(points = {{-23.7, 30.34}, {-23.7, 48}}, color = {191, 0, 0}));
  connect(UF.thermCeiling_Children1, Attic.thermRoom2) annotation(Line(points = {{-14.27, 30.34}, {-14.27, 40.17}, {-14.5, 40.17}, {-14.5, 48}}, color = {191, 0, 0}));
  connect(UF.thermCeiling_Corridor, Attic.thermRoom3) annotation(Line(points = {{-5.53, 30.34}, {-5.53, 40.17}, {-5.3, 40.17}, {-5.3, 48}}, color = {191, 0, 0}));
  connect(UF.thermCeiling_Bath, Attic.thermRoom4) annotation(Line(points = {{3.67, 30.34}, {3.67, 40.17}, {3.9, 40.17}, {3.9, 48}}, color = {191, 0, 0}));
  connect(UF.thermCeiling_Children2, Attic.thermRoom5) annotation(Line(points = {{12.87, 30.34}, {12.87, 39.17}, {13.1, 39.17}, {13.1, 48}}, color = {191, 0, 0}));
  connect(Attic.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{-25.885, 66}, {-74, 66}, {-74, 120}}, color = {0, 0, 127}));
  connect(UF.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{-29.45, 8.5}, {-29.45, 12}, {-74, 12}, {-74, 120}}, color = {0, 0, 127}));
  connect(GF.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{-29.6, -60.98}, {-74, -60.98}, {-74, 120}}, color = {0, 0, 127}));
  connect(AirExchangeCorridor_Source.y, varAirExchange.InPort1) annotation(Line(points = {{24.2, -32}, {26, -32}, {26, -24}, {30.16, -24}, {30.16, -26.6}}, color = {0, 0, 127}));
  connect(UF.thermCorridor, varAirExchange.port_a) annotation(Line(points = {{22.3, -26.6}, {34, -26.6}, {34, -26}}, color = {191, 0, 0}));
  connect(GF.thermCorridor, varAirExchange.port_b) annotation(Line(points = {{24.4, -39.4}, {34, -39.4}, {34, -38}}, color = {191, 0, 0}));
  connect(UF.StarBedroom, UF_Hydraulic.Rad_Bedroom) annotation(Line(points={{-7.6,
          12.4},{-2,12.4},{-2,4},{74,4},{74,22.3},{86.4769,22.3}},                                                                                      color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(UF.StarChildren1, UF_Hydraulic.Rad_Children1) annotation(Line(points={{1.6,
          12.4},{-2,12.4},{-2,4},{74,4},{74,30},{146,30},{146,20},{136,20},{136,
          19.41},{133.185,19.41}},                                                                                                    color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(GF.StarLivingroom, GF_Hydraulic.Rad_Livingroom) annotation(Line(points={{-6.8,
          -57.6},{-6.8,-68},{76,-68},{76,-53.2},{84.8692,-53.2}},                                                                                          color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(GF.StarHobby, GF_Hydraulic.Rad_Hobby) annotation(Line(points={{2.8,
          -57.6},{2.8,-62},{0,-62},{0,-68},{76,-68},{76,-46},{140,-46},{140,
          -52.16},{129.131,-52.16}},                                                                                                    color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(GF.StarCorridor, GF_Hydraulic.Rad_Corridor) annotation(Line(points={{-2,
          -73.2},{0,-73.2},{0,-68},{76,-68},{76,-46},{140,-46},{140,-60.96},{
          129.292,-60.96}},                                                                                                    color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(GF.StarWC_Storage, GF_Hydraulic.Rad_WC) annotation(Line(points={{2.8,
          -83.6},{0,-83.6},{0,-68},{76,-68},{76,-46},{140,-46},{140,-70.56},{
          129.454,-70.56}},                                                                                                    color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(GF.StarKitchen, GF_Hydraulic.Rad_Kitchen) annotation(Line(points={{-6.8,
          -83.6},{0,-83.6},{0,-68},{76,-68},{76,-72.8},{84.7885,-72.8}},                                                                                      color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(UF.ThermBedroom, UF_Hydraulic.Con_Bedroom) annotation(Line(points={{-7.6,
          17.6},{-2,17.6},{-2,4},{74,4},{74,17.03},{86.3077,17.03}},                                                                                       color = {191, 0, 0}));
  connect(UF.ThermChildren1, UF_Hydraulic.Con_Chidlren1) annotation(Line(points={{1.6,
          17.6},{-2,17.6},{-2,4},{74,4},{74,30},{146,30},{146,15.5},{133.523,
          15.5}},                                                                                                    color = {191, 0, 0}));
  connect(UF.ThermChildren2, UF_Hydraulic.Con_Children2) annotation(Line(points={{-7.6,
          -8.4},{-2,-8.4},{-2,4},{74,4},{74,-1.67},{86.1385,-1.67}},                                                                                           color = {191, 0, 0}));
  connect(UF.ThermBath, UF_Hydraulic.Con_Bath) annotation(Line(points={{1.6,
          -8.4},{-2,-8.4},{-2,4},{74,4},{74,30},{146,30},{146,-4.56},{133.523,
          -4.56}},                                                                                                    color = {191, 0, 0}));
  connect(UF.StarBath, UF_Hydraulic.Rad_Bath) annotation(Line(points={{1.6,
          -13.6},{-2,-13.6},{-2,4},{74,4},{74,30},{146,30},{146,0.2},{133.692,
          0.2}},                                                                                                    color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(GF.ThermLivingroom, GF_Hydraulic.Con_Livingroom) annotation(Line(points = {{-7.04, -52.14}, {-7.04, -68}, {76, -68}, {76, -56.72}, {84.95, -56.72}}, color = {191, 0, 0}));
  connect(GF.ThermHobby, GF_Hydraulic.Con_Hobby) annotation(Line(points={{2.8,
          -52.4},{2.8,-58},{0,-58},{0,-68},{76,-68},{76,-46},{140,-46},{140,
          -56.32},{129.292,-56.32}},                                                                                                    color = {191, 0, 0}));
  connect(GF.ThermKitchen, GF_Hydraulic.Con_Kitchen) annotation(Line(points={{-6.8,
          -78.4},{54,-78.4},{54,-80},{76,-80},{76,-78},{82,-78},{82,-77.36},{
          84.7077,-77.36}},                                                                                                    color = {191, 0, 0}));
  connect(GF.ThermCorridor, GF_Hydraulic.Con_Corridor) annotation(Line(points={{-2,-68},
          {76,-68},{76,-46},{140,-46},{140,-65.52},{129.212,-65.52}},                                                                                            color = {191, 0, 0}));
  connect(GF.ThermWC_Storage, GF_Hydraulic.Con_Storage) annotation(Line(points={{2.8,
          -78.4},{0,-78.4},{0,-68},{76,-68},{76,-46},{140,-46},{140,-74.72},{
          129.696,-74.72}},                                                                                                    color = {191, 0, 0}));
  connect(UF_Hydraulic.Rad_Children2, UF.StarChildren2) annotation(Line(points={{86.4769,
          4.45},{74,4.45},{74,4},{-2,4},{-2,-13.6},{-7.6,-13.6}},                                                                                             color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(GF.thermCeiling_Corridor, UF.thermFloor_Corridor) annotation(Line(points = {{-4.64, -39.66}, {-4.64, -32.83}, {-5.3, -32.83}, {-5.3, -26.6}}, color = {191, 0, 0}));
  connect(GF.thermCeiling_WCStorage, UF.thermFloor_Bath) annotation(Line(points = {{4.96, -39.66}, {4.96, -33.83}, {3.9, -33.83}, {3.9, -26.6}}, color = {191, 0, 0}));
  connect(TSet_UF, UF_Hydraulic.TSet_UF) annotation(Line(points={{-101,-35},{
          -74,-35},{-74,90},{98,90},{98,24.17},{98.6615,24.17}},                                                                                 color = {0, 0, 127}));
  connect(TSet_GF, GF_Hydraulic.TSet_GF) annotation(Line(points={{-100,-82},{
          -74,-82},{-74,90},{74,90},{74,-46},{95.9346,-46},{95.9346,-51.52}},                                                                                   color = {0, 0, 127}));
  connect(UF.AirExchangePort, NaturalVentilation_UF) annotation(Line(points = {{-29.45, -0.86}, {-74, -0.86}, {-74, 58}, {-102, 58}}, color = {0, 0, 127}));
  connect(GF.AirExchangePort, NaturalVentilation_GF) annotation(Line(points = {{-29.6, -68.78}, {-74, -68.78}, {-74, 14}, {-100, 14}}, color = {0, 0, 127}));
  connect(Attic.AirExchangePort, AirExchangeAttic_Source.y) annotation(Line(points = {{-26, 74}, {-74, 74}, {-74, 88}, {-79.2, 88}}, color = {0, 0, 127}));
  connect(UF.North, SolarRadiationPort[1]) annotation(Line(points={{22.3,3.56},
          {36,3.56},{36,-22},{172,-22},{172,81.6667},{190,81.6667}},                                                                                   color = {255, 128, 0}));
  connect(UF.RoofS, SolarRadiationPort[6]) annotation(Line(points={{22.3,13.44},
          {36,13.44},{36,-22},{172,-22},{172,98.3333},{190,98.3333}},                                                                                    color = {255, 128, 0}));
  connect(UF.RoofN, SolarRadiationPort[5]) annotation(Line(points = {{22.3, 21.76}, {36, 21.76}, {36, -22}, {172, -22}, {172, 95}, {190, 95}}, color = {255, 128, 0}));
  connect(UF.East, SolarRadiationPort[2]) annotation(Line(points = {{22.3, -4.24}, {36, -4.24}, {36, -22}, {172, -22}, {172, 85}, {190, 85}}, color = {255, 128, 0}));
  connect(UF.South, SolarRadiationPort[3]) annotation(Line(points={{22.3,-12.04},
          {36,-12.04},{36,-22},{172,-22},{172,88.3333},{190,88.3333}},                                                                                     color = {255, 128, 0}));
  connect(UF.West, SolarRadiationPort[4]) annotation(Line(points={{22.3,-19.84},
          {36,-19.84},{36,-22},{172,-22},{172,91.6667},{190,91.6667}},                                                                                    color = {255, 128, 0}));
  connect(GF.North, SolarRadiationPort[1]) annotation(Line(points={{24.4,-45.12},
          {46,-45.12},{46,-22},{172,-22},{172,81.6667},{190,81.6667}},                                                                                     color = {255, 128, 0}));
  connect(GF.East, SolarRadiationPort[2]) annotation(Line(points = {{24.4, -52.4}, {46, -52.4}, {46, -22}, {172, -22}, {172, 85}, {190, 85}}, color = {255, 128, 0}));
  connect(GF.South, SolarRadiationPort[3]) annotation(Line(points={{24.4,-61.24},
          {46,-61.24},{46,-22},{172,-22},{172,88.3333},{190,88.3333}},                                                                                     color = {255, 128, 0}));
  connect(GF.West, SolarRadiationPort[4]) annotation(Line(points={{24.4,-72.16},
          {46,-72.16},{46,-22},{172,-22},{172,91.6667},{190,91.6667}},                                                                                    color = {255, 128, 0}));
  connect(tempOutside.port, GF.thermOutside) annotation(Line(points = {{158, 71}, {98, 71}, {98, 90}, {-74, 90}, {-74, -48.76}, {-27.92, -48.76}}, color = {191, 0, 0}));
  connect(tempOutside.T, Air_Temp) annotation(Line(points = {{136.55, 71}, {120, 71}, {120, 116}}, color = {0, 0, 127}));
  connect(UF.thermOutside, tempOutside.port) annotation(Line(points = {{-27.84, 21.24}, {-74, 21.24}, {-74, 90}, {98, 90}, {98, 71}, {158, 71}}, color = {191, 0, 0}));
  connect(Attic.thermOutside, tempOutside.port) annotation(Line(points = {{-23.7, 84}, {-24, 84}, {-24, 90}, {98, 90}, {98, 71}, {158, 71}}, color = {191, 0, 0}));
  connect(Attic.SolarRadiationPort_RO1, SolarRadiationPort[6]) annotation(Line(points={{-14.5,
          84},{-16,84},{-16,90},{74,90},{74,-22},{172,-22},{172,98.3333},{190,
          98.3333}},                                                                                                    color = {255, 128, 0}));
  connect(Attic.SolarRadiationPort_RO2, SolarRadiationPort[5]) annotation(Line(points = {{8.5, 84}, {8, 84}, {8, 90}, {74, 90}, {74, -22}, {172, -22}, {172, 95}, {190, 95}}, color = {255, 128, 0}));
  connect(Attic.SolarRadiationPort_OW1, SolarRadiationPort[4]) annotation(Line(points={{-27.38,
          62},{-44,62},{-44,90},{74,90},{74,-22},{172,-22},{172,91.6667},{190,
          91.6667}},                                                                                                    color = {255, 128, 0}));
  connect(Attic.SolarRadiationPort_OW2, SolarRadiationPort[2]) annotation(Line(points = {{22.3, 62.4}, {36, 62.4}, {36, 90}, {74, 90}, {74, -20}, {172, -20}, {172, 85}, {190, 85}}, color = {255, 128, 0}));
  annotation(__Dymola_Images(Parameters(source = "AixLib/Resources/Images/Building/HighOrder/Hydraulik.png")), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {200, 100}}), graphics={  Bitmap(extent=  {{-76, 122}, {172, -124}}, fileName=  "modelica://AixLib/Resources/Images/Building/HighOrder/Hydraulik.png")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {200, 100}}), graphics={  Text(extent=  {{-160, 84}, {-110, 82}}, lineColor=  {0, 0, 255}, textString=  "1-Bedroom"), Text(extent=  {{-160, 78}, {-110, 76}}, lineColor=  {0, 0, 255}, textString=  "2-Children1"), Text(extent=  {{-160, 72}, {-110, 70}}, lineColor=  {0, 0, 255}, textString=  "3-Bath"), Text(extent=  {{-160, 66}, {-110, 64}}, lineColor=  {0, 0, 255}, textString=  "4-Children2"), Text(extent=  {{-164, -4}, {-114, -6}}, lineColor=  {0, 0, 255}, textString=  "1-Bedroom"), Text(extent=  {{-164, -10}, {-114, -12}}, lineColor=  {0, 0, 255}, textString=  "2-Children1"), Text(extent=  {{-164, -16}, {-114, -18}}, lineColor=  {0, 0, 255}, textString=  "3-Bath"), Text(extent=  {{-164, -22}, {-114, -24}}, lineColor=  {0, 0, 255}, textString=  "4-Children2"), Text(extent=  {{-164, -48}, {-114, -50}}, lineColor=  {0, 0, 255}, textString=  "1-Livingroom"), Text(extent=  {{-164, -54}, {-114, -56}}, lineColor=  {0, 0, 255}, textString=  "2-Hobby"), Text(extent=  {{-164, -60}, {-114, -62}}, lineColor=  {0, 0, 255}, textString=  "3-Corridor"), Text(extent=  {{-164, -66}, {-114, -68}}, lineColor=  {0, 0, 255}, textString=  "4-WC"), Text(extent=  {{-164, -72}, {-114, -74}}, lineColor=  {0, 0, 255}, textString=  "5-Kitchen"), Text(extent=  {{-162, 42}, {-112, 40}}, lineColor=  {0, 0, 255}, textString=  "1-Livingroom"), Text(extent=  {{-162, 36}, {-112, 34}}, lineColor=  {0, 0, 255}, textString=  "2-Hobby"), Text(extent=  {{-162, 30}, {-112, 28}}, lineColor=  {0, 0, 255}, textString=  "3-WC"), Text(extent=  {{-162, 24}, {-112, 22}}, lineColor=  {0, 0, 255}, textString=  "4-Kitchen")}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for a complete model with building envelope and an energy system based on ideal heaters.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Resources/Images/Stars/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
 </html>", revisions = "<html>
 <ul>
 <li><i>June 19, 2014</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>"));
end OFD_IdealHeaters;
