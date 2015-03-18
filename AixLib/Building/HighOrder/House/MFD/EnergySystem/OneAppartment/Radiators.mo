within AixLib.Building.HighOrder.House.MFD.EnergySystem.OneAppartment;


model Radiators
  //Pipe lengths
  parameter Modelica.SIunits.Length Length_thSt = 2.5 "L1" annotation(Dialog(group = "Pipe lengths", descriptionLabel = true, joinNext = true));
  parameter Modelica.SIunits.Length Length_thBath = 2.5 "L2  " annotation(Dialog(group = "Pipe lengths", descriptionLabel = true, joinNext = true));
  parameter Modelica.SIunits.Length Length_thChildren1 = 2.3 "L3  " annotation(Dialog(group = "Pipe lengths", descriptionLabel = true, joinNext = true));
  parameter Modelica.SIunits.Length Length_thChildren2 = 1.5 "L4  " annotation(Dialog(group = "Pipe lengths", descriptionLabel = true));
  parameter Modelica.SIunits.Length Length_toKi = 2.5 "l5" annotation(Dialog(group = "Pipe lengths", descriptionLabel = true, joinNext = true));
  parameter Modelica.SIunits.Length Length_toBath = 2 "l4  " annotation(Dialog(group = "Pipe lengths", descriptionLabel = true, joinNext = true));
  parameter Modelica.SIunits.Length Length_toChildren = 0.5 "l3  " annotation(Dialog(group = "Pipe lengths", descriptionLabel = true, joinNext = true));
  parameter Modelica.SIunits.Length Length_toBedroom = 4.0 "l2  " annotation(Dialog(group = "Pipe lengths", descriptionLabel = true, joinNext = true));
  parameter Modelica.SIunits.Length Length_toLi = 7 "l1  " annotation(Dialog(group = "Pipe lengths", descriptionLabel = true));
  //Pipe diameters
  parameter Modelica.SIunits.Diameter Diam_Main = 0.016 "Diameter main pipe" annotation(Dialog(group = "Pipe diameters", descriptionLabel = true));
  parameter Modelica.SIunits.Diameter Diam_Sec = 0.013
    "Diameter secondary pipe  "                                                    annotation(Dialog(group = "Pipe diameters", descriptionLabel = true));
  //Hydraulic resistance
  parameter Real zeta_lateral = 2.5 "zeta lateral" annotation(Dialog(group = "Hydraulic resistance", descriptionLabel = true, joinNext = true));
  parameter Real zeta_through = 0.6 "zeta through" annotation(Dialog(group = "Hydraulic resistance", descriptionLabel = true));
  parameter Real zeta_bend = 1.0 "zeta bend" annotation(Dialog(group = "Hydraulic resistance", descriptionLabel = true));
  //Radiators
  parameter AixLib.DataBase.Radiators.RadiatiorBaseDataDefinition Type_Radiator_Livingroom = AixLib.DataBase.Radiators.StandardMFD_WSchV1984_OneAppartment.Livingroom()
    "Livingroom"                                                                                                     annotation(Dialog(group = "Radiators", descriptionLabel = true));
  parameter AixLib.DataBase.Radiators.RadiatiorBaseDataDefinition Type_Radiator_Bedroom = AixLib.DataBase.Radiators.StandardMFD_WSchV1984_OneAppartment.Bedroom()
    "Bedroom"                                                                                                     annotation(Dialog(group = "Radiators", descriptionLabel = true));
  parameter AixLib.DataBase.Radiators.RadiatiorBaseDataDefinition Type_Radiator_Children = AixLib.DataBase.Radiators.StandardMFD_WSchV1984_OneAppartment.Children()
    "Corridor"                                                                                                     annotation(Dialog(group = "Radiators", descriptionLabel = true));
  parameter AixLib.DataBase.Radiators.RadiatiorBaseDataDefinition Type_Radiator_Bath = AixLib.DataBase.Radiators.StandardMFD_WSchV1984_OneAppartment.Bathroom() "Bath" annotation(Dialog(group = "Radiators", descriptionLabel = true));
  parameter AixLib.DataBase.Radiators.RadiatiorBaseDataDefinition Type_Radiator_Kitchen = AixLib.DataBase.Radiators.StandardMFD_WSchV1984_OneAppartment.Kitchen()
    "Kitchen"                                                                                                     annotation(Dialog(group = "Radiators", descriptionLabel = true));
  HVAC.Radiators.Radiator radiatorKitchen(RadiatorType = Type_Radiator_Kitchen) annotation(Placement(transformation(extent = {{-89, -83}, {-106, -66}})));
  HVAC.Radiators.Radiator radiator_bath(RadiatorType = Type_Radiator_Bath) annotation(Placement(transformation(extent = {{83, -48}, {100, -31}})));
  HVAC.Valves.ThermostaticValve valve_kitchen(Kvs = 0.41, Kv_setT = 0.262, dp(start = 1000)) annotation(Placement(transformation(extent = {{-67, -82.5}, {-82, -66.5}})));
  HVAC.Radiators.Radiator radiator_livingroom(RadiatorType = Type_Radiator_Livingroom) annotation(Placement(transformation(extent = {{-95, -5}, {-113, 13}})));
  HVAC.Radiators.Radiator radiator_bedroom(RadiatorType = Type_Radiator_Bedroom) annotation(Placement(transformation(extent = {{78, 72}, {94, 88}})));
  HVAC.Radiators.Radiator radiatorCorridor(RadiatorType = Type_Radiator_Children) annotation(Placement(transformation(extent = {{86, 33}, {101, 48}})));
  HVAC.Valves.ThermostaticValve valve_bath(Kvs = 0.24, Kv_setT = 0.162, dp(start = 1000)) annotation(Placement(transformation(extent = {{38, -47}, {50, -31}})));
  HVAC.Valves.ThermostaticValve valve_livingroom(Kvs = 1.43, Kv_setT = 0.4, dp(start = 1000)) annotation(Placement(transformation(extent = {{-67, -4}, {-79, 12}})));
  HVAC.Valves.ThermostaticValve valve_children(Kvs = 0.16, Kv_setT = 0.088, dp(start = 1000)) annotation(Placement(transformation(extent = {{64, 32}, {76, 48}})));
  HVAC.Valves.ThermostaticValve valve_bedroom(Kvs = 0.24, Kv_setT = 0.182, dp(start = 1000)) annotation(Placement(transformation(extent = {{49, 74}, {60, 87}})));
  HVAC.Pipes.StaticPipe thStF(D = Diam_Main, l = Length_thSt)
    "through the storage room, flow stream"                                                           annotation(Placement(transformation(extent = {{57, -85}, {40, -74}})));
  HVAC.Pipes.StaticPipe toKiF(D = Diam_Sec, l = Length_toKi)
    "to kitchen, flow stream"                                                          annotation(Placement(transformation(extent = {{8, -5}, {-8, 5}}, rotation = 0, origin = {-49, -74.5})));
  HVAC.Pipes.StaticPipe thStR(D = Diam_Main, l = Length_thSt)
    "through the storage room, return stream"                                                           annotation(Placement(transformation(extent = {{40, -102}, {58, -90}})));
  HVAC.Pipes.StaticPipe toKiR(D = Diam_Sec, l = Length_toKi)
    "to kitchen, return stream"                                                          annotation(Placement(transformation(extent = {{-72, -102}, {-56, -90}})));
  HVAC.Pipes.StaticPipe thBathF(D = Diam_Main, l = Length_thBath)
    "through Bath, flow stream"                                                               annotation(Placement(transformation(extent = {{8, 4.5}, {-8, -4.5}}, rotation = 270, origin = {-4.5, -62})));
  HVAC.Pipes.StaticPipe thBathR(D = Diam_Main, l = Length_thBath)
    "through bath, return stream"                                                               annotation(Placement(transformation(extent = {{8.75, -4.25}, {-8.75, 4.25}}, rotation = 90, origin = {-18.25, -62.75})));
  HVAC.Pipes.StaticPipe thChildren1R(D = Diam_Main, l = Length_thChildren1)
    "through chidlren room 1, return stream"                                                                         annotation(Placement(transformation(extent = {{6.5, -5}, {-6.5, 5}}, rotation = 90, origin = {-18, -27.5})));
  HVAC.Pipes.StaticPipe thChildren1F(D = Diam_Main, l = Length_thChildren1)
    "through chidlren room 1, flow stream"                                                                         annotation(Placement(transformation(extent = {{6.5, 5}, {-6.5, -5}}, rotation = 270, origin = {-5, -26.5})));
  HVAC.Pipes.StaticPipe toBathF(D = Diam_Sec, l = Length_toBath)
    "to Bath, flow stream"                                                              annotation(Placement(transformation(extent = {{-8.5, 4.5}, {8.5, -4.5}}, rotation = 0, origin = {18.5, -38.5})));
  HVAC.Pipes.StaticPipe toBathR(D = Diam_Sec, l = Length_toBath)
    "to bath return stream"                                                              annotation(Placement(transformation(extent = {{8.5, 4.5}, {-8.5, -4.5}}, rotation = 0, origin = {18.5, -49.5})));
  HVAC.Interfaces.Port_b RETURN
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
                                                                                                        annotation(Placement(transformation(extent = {{66, -114}, {86, -94}})));
  HVAC.Interfaces.Port_a FLOW
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
                                                                                                        annotation(Placement(transformation(extent = {{92, -114}, {112, -94}})));
  HVAC.Pipes.StaticPipe toChildrenF(D = Diam_Sec, l = Length_toChildren)
    "to Children, flow stream"                                                                      annotation(Placement(transformation(extent = {{-8.5, 4.5}, {8.5, -4.5}}, rotation = 0, origin = {45.5, 40.5})));
  HVAC.Pipes.StaticPipe toChildrenR(D = Diam_Sec, l = Length_toChildren)
    "to Children, return stream"                                                                      annotation(Placement(transformation(extent = {{7.5, 4.5}, {-7.5, -4.5}}, rotation = 0, origin = {47.5, 27})));
  HVAC.Pipes.StaticPipe thChildrenF2(D = Diam_Main, l = Length_thChildren2)
    "through chidlren room, flow stream"                                                                         annotation(Placement(transformation(extent = {{7, 5}, {-7, -5}}, rotation = 270, origin = {-5, 13})));
  HVAC.Pipes.StaticPipe thChildrenR2(D = Diam_Main, l = Length_thChildren2)
    "through chidlren room, return stream"                                                                         annotation(Placement(transformation(extent = {{7.5, -5}, {-7.5, 5}}, rotation = 90, origin = {-19, 12.5})));
  HVAC.Pipes.StaticPipe toBedroomF(D = Diam_Sec, l = Length_toBedroom)
    "to Bedroom , flow stream"                                                                    annotation(Placement(transformation(extent = {{-6.5, 4.5}, {6.5, -4.5}}, rotation = 0, origin = {23.5, 80.5})));
  HVAC.Pipes.StaticPipe toBedroomR(D = Diam_Sec, l = Length_toBedroom)
    "to Bedroom, return stream"                                                                    annotation(Placement(transformation(extent = {{6.5, 4.5}, {-6.5, -4.5}}, rotation = 0, origin = {20.5, 66})));
  HVAC.Pipes.StaticPipe toLiF(D = Diam_Sec, l = Length_toLi)
    "to livingroom, flow stream"                                                          annotation(Placement(transformation(extent = {{6, -4.5}, {-6, 4.5}}, rotation = 0, origin = {-47.5, 3})));
  HVAC.Pipes.StaticPipe toLiR(D = Diam_Main, l = Length_toLi)
    "to livingroom, return stream"                                                           annotation(Placement(transformation(extent = {{6.5, -5}, {-6.5, 5}}, rotation = 180, origin = {-88.5, -16.5})));
  HVAC.Interfaces.RadPort Rad_Livingroom annotation(Placement(transformation(extent = {{-148, 38}, {-132, 55}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_Livingroom annotation(Placement(transformation(extent = {{-146, 25}, {-133, 38}})));
  HVAC.Interfaces.RadPort Rad_kitchen annotation(Placement(transformation(extent = {{-146, -50}, {-129, -34}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_kitchen annotation(Placement(transformation(extent = {{-145, -66}, {-131, -51}})));
  HVAC.Interfaces.RadPort Rad_bedroom annotation(Placement(transformation(extent = {{128, 88}, {146, 106}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_bedroom annotation(Placement(transformation(extent = {{130, 64}, {146, 82}})));
  HVAC.Interfaces.RadPort Rad_children annotation(Placement(transformation(extent = {{130, 39}, {150, 59}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_children annotation(Placement(transformation(extent = {{131, 17}, {146, 34}})));
  HVAC.Interfaces.RadPort Rad_bath annotation(Placement(transformation(extent = {{128, -38}, {148, -18}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_bath annotation(Placement(transformation(extent = {{129, -59}, {148, -41}})));
  Modelica.Blocks.Interfaces.RealInput TSet[5] annotation(Placement(transformation(extent = {{-123, 78}, {-95, 108}}), iconTransformation(extent = {{-10.5, -12}, {10.5, 12}}, rotation = 270, origin = {-105.5, 96})));
  HVAC.HydraulicResistances.HydraulicResistance HydRes_InFl(zeta = zeta_bend, D = Diam_Main)
    "hydraulic resistance in floor"                                                                                          annotation(Placement(transformation(extent = {{24, -84}, {10, -75}})));
  HVAC.HydraulicResistances.HydraulicResistance HydRes_RadKi(zeta = 3 * zeta_bend, D = Diam_Sec) annotation(Placement(transformation(extent = {{-113, -100.5}, {-99, -91.5}})));
  HVAC.HydraulicResistances.HydraulicResistance HydRes_BendRight(zeta = zeta_bend, D = Diam_Main)
    "hydraulic resistance bend right"                                                                                               annotation(Placement(transformation(extent = {{-3.25, -2.25}, {3.25, 2.25}}, rotation = 90, origin = {-3.75, -75.75})));
  HVAC.HydraulicResistances.HydraulicResistance HydRes_RadWC(zeta = 2 * zeta_bend, D = Diam_Sec) annotation(Placement(transformation(extent = {{67, -53}, {57, -44}})));
  HVAC.HydraulicResistances.HydraulicResistance HydRes_RadLi(zeta = 3 * zeta_bend, D = Diam_Sec) annotation(Placement(transformation(extent = {{-116, -21}, {-102, -12}})));
  HVAC.HydraulicResistances.HydraulicResistance HydRes_RadChildren(zeta = 2 * zeta_bend, D = Diam_Sec) annotation(Placement(transformation(extent = {{84, 22.5}, {74, 31.5}})));
  HVAC.HydraulicResistances.HydraulicResistance HydRes_RadBedroom(zeta = 3 * zeta_bend, D = Diam_Sec) annotation(Placement(transformation(extent = {{74, 61.5}, {60, 70.5}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensor_livingroom annotation(Placement(transformation(extent = {{-108, 30}, {-96, 42}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensor_bedroom annotation(Placement(transformation(extent = {{75, 92}, {63, 104}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensor_children annotation(Placement(transformation(extent = {{88, 49}, {76, 61}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensor_bath annotation(Placement(transformation(extent = {{66, -21}, {54, -9}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensor_bath1 annotation(Placement(transformation(extent = {{-91, -57}, {-79, -45}})));
equation
  connect(radiator_livingroom.port_a, valve_livingroom.port_b) annotation(Line(points = {{-95.72, 4}, {-79, 4}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(valve_bath.port_b, radiator_bath.port_a) annotation(Line(points = {{50, -39}, {83.68, -39}, {83.68, -39.5}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(valve_children.port_b, radiatorCorridor.port_a) annotation(Line(points = {{76, 40}, {86.6, 40}, {86.6, 40.5}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(valve_bedroom.port_b, radiator_bedroom.port_a) annotation(Line(points = {{60, 80.5}, {78.64, 80.5}, {78.64, 80}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(thStR.port_b, RETURN) annotation(Line(points = {{58, -96}, {76, -96}, {76, -104}}, color = {0, 0, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(thStF.port_a, FLOW) annotation(Line(points = {{57, -79.5}, {60, -80}, {62, -80}, {62, -95}, {102, -95}, {102, -104}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(toBathF.port_b, valve_bath.port_a) annotation(Line(points = {{27, -38.5}, {39, -38.5}, {39, -39}, {38, -39}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(toChildrenF.port_b, valve_children.port_a) annotation(Line(points = {{54, 40.5}, {56, 40}, {64, 40}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(toBedroomF.port_b, valve_bedroom.port_a) annotation(Line(points = {{30, 80.5}, {49, 80.5}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(toLiF.port_b, valve_livingroom.port_a) annotation(Line(points = {{-53.5, 3}, {-53.5, 4}, {-67, 4}}, color = {255, 0, 0}, thickness = 0.5, smooth = Smooth.None));
  connect(valve_kitchen.port_a, toKiF.port_b) annotation(Line(points = {{-67, -74.5}, {-57, -74.5}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(radiatorKitchen.port_a, valve_kitchen.port_b) annotation(Line(points = {{-89.68, -74.5}, {-82, -74.5}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(HydRes_InFl.port_a, thStF.port_b) annotation(Line(points = {{24, -79.5}, {40, -79.5}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(radiatorKitchen.port_b, HydRes_RadKi.port_a) annotation(Line(points = {{-105.32, -74.5}, {-118, -74.5}, {-118, -75}, {-130, -75}, {-130, -96}, {-113, -96}}, color = {0, 128, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(HydRes_RadKi.port_b, toKiR.port_a) annotation(Line(points = {{-99, -96}, {-72, -96}}, color = {0, 128, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(toBathR.port_a, HydRes_RadWC.port_b) annotation(Line(points = {{27, -49.5}, {42, -49.5}, {42, -48.5}, {57, -48.5}}, color = {0, 128, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(HydRes_RadWC.port_a, radiator_bath.port_b) annotation(Line(points = {{67, -48.5}, {127, -48.5}, {127, -39.5}, {99.32, -39.5}}, color = {0, 128, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(HydRes_RadLi.port_b, toLiR.port_a) annotation(Line(points = {{-102, -16.5}, {-95, -16.5}}, color = {0, 128, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(HydRes_RadLi.port_a, radiator_livingroom.port_b) annotation(Line(points = {{-116, -16.5}, {-129, -16.5}, {-129, 4}, {-112.28, 4}}, color = {0, 128, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(toChildrenR.port_a, HydRes_RadChildren.port_b) annotation(Line(points = {{55, 27}, {74, 27}}, color = {0, 128, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(HydRes_RadChildren.port_a, radiatorCorridor.port_b) annotation(Line(points = {{84, 27}, {126, 27}, {126, 40.5}, {100.4, 40.5}}, color = {0, 128, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(toBedroomR.port_a, HydRes_RadBedroom.port_b) annotation(Line(points = {{27, 66}, {60, 66}}, color = {0, 128, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(HydRes_RadBedroom.port_a, radiator_bedroom.port_b) annotation(Line(points = {{74, 66}, {126, 66}, {126, 80}, {93.36, 80}}, color = {0, 128, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(HydRes_BendRight.port_b, thBathF.port_a) annotation(Line(points = {{-3.75, -72.5}, {-3.75, -70}, {-4.5, -70}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(radiatorKitchen.radPort, Rad_kitchen) annotation(Line(points = {{-100.9, -67.87}, {-100.9, -42}, {-137.5, -42}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(radiatorKitchen.convPort, Con_kitchen) annotation(Line(points = {{-93.93, -68.04}, {-93.93, -58.5}, {-138, -58.5}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(radiator_bath.convPort, Con_bath) annotation(Line(points = {{87.93, -33.04}, {88, -33.04}, {88, -33}, {119, -33}, {119, -50}, {138.5, -50}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(radiator_bath.radPort, Rad_bath) annotation(Line(points = {{94.9, -32.87}, {94.9, -28}, {138, -28}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(radiatorCorridor.radPort, Rad_children) annotation(Line(points = {{96.5, 46.35}, {96.5, 49}, {140, 49}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(radiatorCorridor.convPort, Con_children) annotation(Line(points = {{90.35, 46.2}, {90, 46.2}, {90, 46}, {113, 46}, {113, 25.5}, {138.5, 25.5}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(radiator_bedroom.convPort, Con_bedroom) annotation(Line(points = {{82.64, 86.08}, {82.64, 91}, {119, 91}, {119, 73}, {138, 73}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(radiator_bedroom.radPort, Rad_bedroom) annotation(Line(points = {{89.2, 86.24}, {89.2, 97}, {137, 97}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(radiator_livingroom.radPort, Rad_Livingroom) annotation(Line(points = {{-107.6, 11.02}, {-107.6, 11}, {-131, 11}, {-131, 46}, {-136, 46}, {-136, 46.5}, {-140, 46.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(radiator_livingroom.convPort, Con_Livingroom) annotation(Line(points = {{-100.22, 10.84}, {-100.22, 12}, {-100, 12}, {-100, 14}, {-133, 14}, {-133, 32}, {-137, 32}, {-137, 31.5}, {-139.5, 31.5}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(toKiR.port_b, thStR.port_a) annotation(Line(points = {{-56, -96}, {40, -96}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(thBathR.port_b, thStR.port_a) annotation(Line(points = {{-18.25, -71.5}, {-18.25, -96}, {40, -96}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(thChildren1R.port_b, thBathR.port_a) annotation(Line(points = {{-18, -34}, {-18, -54}, {-18.25, -54}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(thChildrenR2.port_b, thChildren1R.port_a) annotation(Line(points = {{-19, 5}, {-19, -21}, {-18, -21}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(toLiR.port_b, thChildren1R.port_a) annotation(Line(points = {{-82, -16.5}, {-19, -16.5}, {-19, -21}, {-18, -21}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(toBedroomR.port_b, thChildrenR2.port_a) annotation(Line(points = {{14, 66}, {-19, 66}, {-19, 20}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(toChildrenR.port_b, thChildrenR2.port_a) annotation(Line(points = {{40, 27}, {-19, 27}, {-19, 20}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(toBathR.port_b, thBathR.port_a) annotation(Line(points = {{10, -49.5}, {-18, -49.5}, {-18, -54}, {-18.25, -54}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(HydRes_BendRight.port_a, HydRes_InFl.port_b) annotation(Line(points = {{-3.75, -79}, {-3.75, -79.5}, {10, -79.5}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(thBathF.port_b, toBathF.port_a) annotation(Line(points = {{-4.5, -54}, {-4.5, -38.5}, {10, -38.5}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(toKiF.port_a, HydRes_InFl.port_b) annotation(Line(points = {{-41, -74.5}, {-23, -74.5}, {-23, -80}, {10, -80}, {10, -79.5}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(thBathF.port_b, thChildren1F.port_a) annotation(Line(points = {{-4.5, -54}, {-4.5, -44}, {-5, -44}, {-5, -33}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(thChildren1F.port_b, thChildrenF2.port_a) annotation(Line(points = {{-5, -20}, {-5, 6}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(thChildrenF2.port_b, toChildrenF.port_a) annotation(Line(points = {{-5, 20}, {-5, 40.5}, {37, 40.5}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(thChildrenF2.port_b, toBedroomF.port_a) annotation(Line(points = {{-5, 20}, {-5, 80.5}, {17, 80.5}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(thChildren1F.port_b, toLiF.port_a) annotation(Line(points = {{-5, -20}, {-5, 3}, {-41.5, 3}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(valve_bedroom.T_setRoom, TSet[2]) annotation(Line(points = {{57.58, 86.87}, {57.58, 87}, {-109, 87}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(valve_children.T_setRoom, TSet[3]) annotation(Line(points = {{73.36, 47.84}, {73.36, 57}, {-77, 57}, {-77, 92}, {-109, 92}, {-109, 93}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(valve_bath.T_setRoom, TSet[4]) annotation(Line(points = {{47.36, -31.16}, {47.36, -7}, {18, -7}, {18, 29}, {-76, 29}, {-76, 99}, {-109, 99}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(valve_kitchen.T_setRoom, TSet[5]) annotation(Line(points = {{-78.7, -66.66}, {-78.7, -62}, {-76, -62}, {-76, 105}, {-109, 105}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(valve_livingroom.T_setRoom, TSet[1]) annotation(Line(points = {{-76.36, 11.84}, {-76.36, 52}, {-76, 52}, {-76, 92}, {-109, 92}, {-109, 81}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(Con_Livingroom, tempSensor_livingroom.port) annotation(Line(points = {{-139.5, 31.5}, {-120, 31.5}, {-120, 36}, {-108, 36}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(tempSensor_livingroom.T, valve_livingroom.T_room) annotation(Line(points = {{-96, 36}, {-69.16, 36}, {-69.16, 11.84}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(valve_bedroom.T_room, tempSensor_bedroom.T) annotation(Line(points = {{50.98, 86.87}, {50.98, 98}, {63, 98}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(tempSensor_bedroom.port, Con_bedroom) annotation(Line(points = {{75, 98}, {89, 98}, {89, 97}, {141, 97}, {141, 73}, {138, 73}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(valve_children.T_room, tempSensor_children.T) annotation(Line(points = {{66.16, 47.84}, {66.16, 55}, {76, 55}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(tempSensor_children.port, Con_children) annotation(Line(points = {{88, 55}, {138, 55}, {138, 53}, {138.5, 53}, {138.5, 25.5}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(valve_bath.T_room, tempSensor_bath.T) annotation(Line(points = {{40.16, -31.16}, {40.16, -15}, {54, -15}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(tempSensor_bath.port, Con_bath) annotation(Line(points = {{66, -15}, {97, -15}, {97, -21}, {138.5, -21}, {138.5, -50}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(tempSensor_bath1.port, Con_kitchen) annotation(Line(points = {{-91, -51}, {-107, -51}, {-107, -50}, {-138, -50}, {-138, -58.5}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(tempSensor_bath1.T, valve_kitchen.T_room) annotation(Line(points = {{-79, -51}, {-69.7, -51}, {-69.7, -66.66}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-150, -100}, {150, 110}}, grid = {1, 1}), graphics = {Rectangle(extent=  {{1, 100}, {126, 63}}, pattern=  LinePattern.None, lineColor=  {0, 0, 0}, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid), Rectangle(extent=  {{4, 58}, {127, 15}}, pattern=  LinePattern.None, lineColor=  {0, 0, 0}, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid), Rectangle(extent=  {{4, -14}, {127, -67}}, pattern=  LinePattern.None, lineColor=  {0, 0, 0}, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid), Rectangle(extent=  {{-129, 29}, {-22, -25}}, pattern=  LinePattern.None, lineColor=  {0, 0, 0}, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid), Rectangle(extent=  {{-130, -49}, {-23, -103}}, pattern=  LinePattern.None, lineColor=  {0, 0, 0}, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid), Text(extent=  {{-120, -81}, {-69, -96}}, lineColor=  {0, 0, 0}, fillColor=  {0, 0, 0}, fillPattern=  FillPattern.Solid, textString=  "Kitchen"), Text(extent=  {{-156.5, 29}, {-49.5, 16}}, lineColor=  {0, 0, 0}, fillColor=  {0, 0, 0}, fillPattern=  FillPattern.Solid, textString=  "Livingroom"), Text(extent=  {{31, -15}, {138, -28}}, lineColor=  {0, 0, 0}, fillColor=  {0, 0, 0}, fillPattern=  FillPattern.Solid, textString=  "Bath"), Text(extent=  {{-27, 56}, {80, 43}}, lineColor=  {0, 0, 0}, fillColor=  {0, 0, 0}, fillPattern=  FillPattern.Solid, textString=  "Children"), Text(extent=  {{-34, 100}, {73, 87}}, lineColor=  {0, 0, 0}, fillColor=  {0, 0, 0}, fillPattern=  FillPattern.Solid, textString=  "Bedroom"), Text(extent=  {{-70, 103}, {-17, 71}}, lineColor=  {0, 0, 0}, textString=  "1 - Livingroom
 2- Bedroom
 3 - Children
 4 - Bath
 5 - Kitchen")}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-150, -100}, {150, 110}}, grid = {1, 1}), graphics = {Rectangle(extent=  {{-119, 92}, {123, -79}}, lineColor=  {255, 0, 0}, fillColor=  {135, 135, 135}, fillPattern=  FillPattern.Solid), Line(points=  {{-99, 22}, {104, 22}, {104, -6}}, color=  {255, 0, 0}, smooth=  Smooth.None, thickness=  1), Line(points=  {{-98, 13}, {95, 13}, {95, -6}}, color=  {0, 0, 255}, smooth=  Smooth.None, thickness=  1), Line(points=  {{-21, 13}, {-21, 35}}, color=  {0, 0, 255}, thickness=  1, smooth=  Smooth.None), Line(points=  {{-14, 23}, {-14, 45}}, color=  {255, 0, 0}, thickness=  1, smooth=  Smooth.None), Text(extent=  {{-124, 119}, {-84, 111}}, lineColor=  {0, 0, 0}, lineThickness=  0.5, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, textString=  "Set"), Text(extent=  {{-70, 81}, {-17, 49}}, lineColor=  {0, 0, 0}, textString=  "1 - Livingroom
 2- Bedroom
 3 - Children
 4 - Bath
 5 - Kitchen")}), Documentation(revisions = "<html>
 <p><ul>
 <li><i>June 19, 2014</i> by Ana Constantin:<br/>Implemented</li>
 </ul></p>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>The model is exemplarly build with components found in the HVAC package.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The model should be used as an example on how such a system can be built and connected to the building envelope.</p>
 </html>"));
end Radiators;
