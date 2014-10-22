within AixLib.HVAC.OFD.Hydraulics;

model GroundFloor
  import AixLib;
  //Pipe lengths
  parameter Modelica.SIunits.Length Length_thSt = 2.5 "L1" annotation(Dialog(group = "Pipe lengths", descriptionLabel = true, joinNext = true));
  parameter Modelica.SIunits.Length Length_thWC = 2.5 "L2  " annotation(Dialog(group = "Pipe lengths", descriptionLabel = true, joinNext = true));
  parameter Modelica.SIunits.Length Length_thCo1 = 2.3 "L3  " annotation(Dialog(group = "Pipe lengths", descriptionLabel = true, joinNext = true));
  parameter Modelica.SIunits.Length Length_thCo2 = 1.5 "L4  " annotation(Dialog(group = "Pipe lengths", descriptionLabel = true));
  parameter Modelica.SIunits.Length Length_toKi = 2.5 "l5" annotation(Dialog(group = "Pipe lengths", descriptionLabel = true, joinNext = true));
  parameter Modelica.SIunits.Length Length_toWC = 2 "l4  " annotation(Dialog(group = "Pipe lengths", descriptionLabel = true, joinNext = true));
  parameter Modelica.SIunits.Length Length_toCo = 0.5 "l3  " annotation(Dialog(group = "Pipe lengths", descriptionLabel = true, joinNext = true));
  parameter Modelica.SIunits.Length Length_toHo = 4.0 "l2  " annotation(Dialog(group = "Pipe lengths", descriptionLabel = true, joinNext = true));
  parameter Modelica.SIunits.Length Length_toLi = 7 "l1  " annotation(Dialog(group = "Pipe lengths", descriptionLabel = true));
  //Pipe diameters
  parameter Modelica.SIunits.Diameter Diam_Main = 0.016 "Diameter main pipe" annotation(Dialog(group = "Pipe diameters", descriptionLabel = true));
  parameter Modelica.SIunits.Diameter Diam_Sec = 0.013 "Diameter secondary pipe  " annotation(Dialog(group = "Pipe diameters", descriptionLabel = true));
  //Hydraulic resistance
  parameter Real zeta_lateral = 2.5 "zeta lateral" annotation(Dialog(group = "Hydraulic resistance", descriptionLabel = true, joinNext = true));
  parameter Real zeta_through = 0.6 "zeta through" annotation(Dialog(group = "Hydraulic resistance", descriptionLabel = true));
  parameter Real zeta_bend = 1.0 "zeta bend" annotation(Dialog(group = "Hydraulic resistance", descriptionLabel = true));
  //Radiators
  parameter AixLib.DataBase.Radiators.RadiatiorBaseDataDefinition Type_Radiator_Livingroom = AixLib.DataBase.Radiators.StandardOFD_EnEV2009.Livingroom() "Livingroom" annotation(Dialog(group = "Radiators", descriptionLabel = true));
  parameter AixLib.DataBase.Radiators.RadiatiorBaseDataDefinition Type_Radiator_Hobby = AixLib.DataBase.Radiators.StandardOFD_EnEV2009.Hobby() "Hobby" annotation(Dialog(group = "Radiators", descriptionLabel = true));
  parameter AixLib.DataBase.Radiators.RadiatiorBaseDataDefinition Type_Radiator_Corridor = AixLib.DataBase.Radiators.StandardOFD_EnEV2009.Corridor() "Corridor" annotation(Dialog(group = "Radiators", descriptionLabel = true));
  parameter AixLib.DataBase.Radiators.RadiatiorBaseDataDefinition Type_Radiator_WC = AixLib.DataBase.Radiators.StandardOFD_EnEV2009.WC() "WC" annotation(Dialog(group = "Radiators", descriptionLabel = true));
  parameter AixLib.DataBase.Radiators.RadiatiorBaseDataDefinition Type_Radiator_Kitchen = AixLib.DataBase.Radiators.StandardOFD_EnEV2009.Kitchen() "Kitchen" annotation(Dialog(group = "Radiators", descriptionLabel = true));
  Radiators.Radiator radiatorKitchen(RadiatorType = Type_Radiator_Kitchen) annotation(Placement(transformation(extent = {{-89, -83}, {-106, -66}})));
  Radiators.Radiator radiatorWC(RadiatorType = Type_Radiator_WC) annotation(Placement(transformation(extent = {{83, -48}, {100, -31}})));
  HVAC.Valves.ThermostaticValve valveKitchen(Kvs = 0.41, Kv_setT = 0.262) annotation(Placement(transformation(extent = {{-67, -82.5}, {-82, -66.5}})));
  Radiators.Radiator radiatorLiving(RadiatorType = Type_Radiator_Livingroom) annotation(Placement(transformation(extent = {{-95, -5}, {-113, 13}})));
  Radiators.Radiator radiatorHobby(RadiatorType = Type_Radiator_Hobby) annotation(Placement(transformation(extent = {{78, 72}, {94, 88}})));
  Radiators.Radiator radiatorCorridor(RadiatorType = Type_Radiator_Corridor) annotation(Placement(transformation(extent = {{86, 33}, {101, 48}})));
  Valves.ThermostaticValve valveWC(Kvs = 0.24, Kv_setT = 0.162) annotation(Placement(transformation(extent = {{38, -47}, {50, -31}})));
  Valves.ThermostaticValve valveLiving(Kvs = 1.43, Kv_setT = 0.4) annotation(Placement(transformation(extent = {{-67, -4}, {-79, 12}})));
  HVAC.Valves.ThermostaticValve valveCorridor(Kvs = 0.16, Kv_setT = 0.088) annotation(Placement(transformation(extent = {{64, 32}, {76, 48}})));
  HVAC.Valves.ThermostaticValve valveHobby(Kvs = 0.24, Kv_setT = 0.182) annotation(Placement(transformation(extent = {{49, 74}, {60, 87}})));
  Pipes.StaticPipe thStF(D = Diam_Main, l = Length_thSt) "through the storage room, flow stream" annotation(Placement(transformation(extent = {{57, -85}, {40, -74}})));
  Pipes.StaticPipe toKiF(D = Diam_Sec, l = Length_toKi) "to kitchen, flow stream" annotation(Placement(transformation(extent = {{8, -5}, {-8, 5}}, rotation = 0, origin = {-49, -74.5})));
  Pipes.StaticPipe thStR(D = Diam_Main, l = Length_thSt) "through the storage room, return stream" annotation(Placement(transformation(extent = {{40, -102}, {58, -90}})));
  Pipes.StaticPipe toKiR(D = Diam_Sec, l = Length_toKi) "to kitchen, return stream" annotation(Placement(transformation(extent = {{-72, -102}, {-56, -90}})));
  Pipes.StaticPipe thWCF(D = Diam_Main, l = Length_thWC) "through WC, flow stream" annotation(Placement(transformation(extent = {{8, 4.5}, {-8, -4.5}}, rotation = 270, origin = {-4.5, -62})));
  Pipes.StaticPipe thWCR(D = Diam_Main, l = Length_thWC) "through WC, return stream" annotation(Placement(transformation(extent = {{8.75, -4.25}, {-8.75, 4.25}}, rotation = 90, origin = {-18.25, -62.75})));
  Pipes.StaticPipe thCo1R(D = Diam_Main, l = Length_thCo1) "through corridor 1, return stream" annotation(Placement(transformation(extent = {{6.5, -5}, {-6.5, 5}}, rotation = 90, origin = {-18, -27.5})));
  Pipes.StaticPipe thCo1F(D = Diam_Main, l = Length_thCo1) "through Corridor 1, flow stream" annotation(Placement(transformation(extent = {{6.5, 5}, {-6.5, -5}}, rotation = 270, origin = {-5, -26.5})));
  Pipes.StaticPipe toWCF(D = Diam_Sec, l = Length_toWC) "to WC, flow stream" annotation(Placement(transformation(extent = {{-8.5, 4.5}, {8.5, -4.5}}, rotation = 0, origin = {18.5, -38.5})));
  Pipes.StaticPipe toWCR(D = Diam_Sec, l = Length_toWC) "to WC, return stream" annotation(Placement(transformation(extent = {{8.5, 4.5}, {-8.5, -4.5}}, rotation = 0, origin = {18.5, -48.5})));
  Interfaces.Port_b RETURN "Fluid connector b (positive design flow direction is from port_a to port_b)" annotation(Placement(transformation(extent = {{66, -114}, {86, -94}})));
  Interfaces.Port_a FLOW "Fluid connector a (positive design flow direction is from port_a to port_b)" annotation(Placement(transformation(extent = {{92, -114}, {112, -94}})));
  Pipes.StaticPipe toCoF(D = Diam_Sec, l = Length_toCo) "to corridor , flow stream" annotation(Placement(transformation(extent = {{-8.5, 4.5}, {8.5, -4.5}}, rotation = 0, origin = {45.5, 40.5})));
  Pipes.StaticPipe toCoR(D = Diam_Sec, l = Length_toCo) "to corridor, return stream" annotation(Placement(transformation(extent = {{7.5, 4.5}, {-7.5, -4.5}}, rotation = 0, origin = {47.5, 27})));
  Pipes.StaticPipe thCo2F(D = Diam_Main, l = Length_thCo2) "through Corridor 2, flow stream" annotation(Placement(transformation(extent = {{7, 5}, {-7, -5}}, rotation = 270, origin = {-5, 13})));
  Pipes.StaticPipe thCoR2(D = Diam_Main, l = Length_thCo2) "through corridor 2, return stream" annotation(Placement(transformation(extent = {{7.5, -5}, {-7.5, 5}}, rotation = 90, origin = {-19, 12.5})));
  Pipes.StaticPipe toHoF(D = Diam_Sec, l = Length_toHo) "to hobby , flow stream" annotation(Placement(transformation(extent = {{-6.5, 4.5}, {6.5, -4.5}}, rotation = 0, origin = {23.5, 80.5})));
  Pipes.StaticPipe toHoR(D = Diam_Sec, l = Length_toHo) "to hobby, return stream" annotation(Placement(transformation(extent = {{6.5, 4.5}, {-6.5, -4.5}}, rotation = 0, origin = {20.5, 66})));
  Pipes.StaticPipe toLiF(D = Diam_Sec, l = Length_toLi) "to livingroom, flow stream" annotation(Placement(transformation(extent = {{6, -4.5}, {-6, 4.5}}, rotation = 0, origin = {-47.5, 3})));
  Pipes.StaticPipe toLiR(D = Diam_Main, l = Length_toLi) "to livingroom, return stream" annotation(Placement(transformation(extent = {{6.5, -5}, {-6.5, 5}}, rotation = 180, origin = {-88.5, -16.5})));
  Interfaces.RadPort Rad_Livingroom annotation(Placement(transformation(extent = {{-148, 38}, {-132, 55}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_Livingroom annotation(Placement(transformation(extent = {{-146, 25}, {-133, 38}})));
  Interfaces.RadPort Rad_Kitchen annotation(Placement(transformation(extent = {{-146, -50}, {-129, -34}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_Kitchen annotation(Placement(transformation(extent = {{-145, -66}, {-131, -51}})));
  Interfaces.RadPort Rad_Hobby annotation(Placement(transformation(extent = {{128, 88}, {146, 106}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_Hobby annotation(Placement(transformation(extent = {{130, 64}, {146, 82}})));
  Interfaces.RadPort Rad_Corridor annotation(Placement(transformation(extent = {{130, 39}, {150, 59}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_Corridor annotation(Placement(transformation(extent = {{131, 17}, {146, 34}})));
  Interfaces.RadPort Rad_WC annotation(Placement(transformation(extent = {{128, -38}, {148, -18}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_WC annotation(Placement(transformation(extent = {{129, -59}, {148, -41}})));
  Modelica.Blocks.Interfaces.RealInput TSet_GF[5] annotation(Placement(transformation(extent = {{-123, 78}, {-95, 108}}), iconTransformation(extent = {{-10.5, -12}, {10.5, 12}}, rotation = 270, origin = {-105.5, 96})));
  HydraulicResistances.HydraulicResistance HydRes_InFl(zeta = zeta_bend, D = Diam_Main) "hydraulic resistance in floor" annotation(Placement(transformation(extent = {{24, -84}, {10, -75}})));
  HydraulicResistances.HydraulicResistance HydRes_RadKi(zeta = 3 * zeta_bend, D = Diam_Sec) annotation(Placement(transformation(extent = {{-113, -100.5}, {-99, -91.5}})));
  HydraulicResistances.HydraulicResistance HydRes_BendRight(zeta = zeta_bend, D = Diam_Main) "hydraulic resistance bend right" annotation(Placement(transformation(extent = {{-3.25, -2.25}, {3.25, 2.25}}, rotation = 90, origin = {-3.75, -75.75})));
  HydraulicResistances.HydraulicResistance HydRes_RadWC(zeta = 2 * zeta_bend, D = Diam_Sec) annotation(Placement(transformation(extent = {{67, -53}, {57, -44}})));
  HydraulicResistances.HydraulicResistance HydRes_RadLi(zeta = 3 * zeta_bend, D = Diam_Sec) annotation(Placement(transformation(extent = {{-116, -21}, {-102, -12}})));
  HydraulicResistances.HydraulicResistance HydRes_RadCor(zeta = 2 * zeta_bend, D = Diam_Sec) annotation(Placement(transformation(extent = {{84, 22.5}, {74, 31.5}})));
  HydraulicResistances.HydraulicResistance HydRes_RadHo(zeta = 3 * zeta_bend, D = Diam_Sec) annotation(Placement(transformation(extent = {{74, 61.5}, {60, 70.5}})));
  Modelica.Blocks.Interfaces.RealInput TIs_GF[5] annotation(Placement(transformation(extent = {{-29, 80}, {-58, 109}}), iconTransformation(extent = {{-10.5, -12}, {10.5, 12}}, rotation = 270, origin = {-41.5, 96})));
equation
  connect(radiatorLiving.port_a, valveLiving.port_b) annotation(Line(points = {{-95.72, 4}, {-79, 4}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(valveWC.port_b, radiatorWC.port_a) annotation(Line(points = {{50, -39}, {83.68, -39}, {83.68, -39.5}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(valveCorridor.port_b, radiatorCorridor.port_a) annotation(Line(points = {{76, 40}, {86.6, 40}, {86.6, 40.5}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(valveHobby.port_b, radiatorHobby.port_a) annotation(Line(points = {{60, 80.5}, {78.64, 80.5}, {78.64, 80}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(thStR.port_b, RETURN) annotation(Line(points = {{58, -96}, {76, -96}, {76, -104}}, color = {0, 0, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(thStF.port_a, FLOW) annotation(Line(points = {{57, -79.5}, {60, -80}, {62, -80}, {62, -95}, {102, -95}, {102, -104}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(toWCF.port_b, valveWC.port_a) annotation(Line(points = {{27, -38.5}, {39, -38.5}, {39, -39}, {38, -39}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(toCoF.port_b, valveCorridor.port_a) annotation(Line(points = {{54, 40.5}, {56, 40}, {64, 40}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(toHoF.port_b, valveHobby.port_a) annotation(Line(points = {{30, 80.5}, {49, 80.5}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(toLiF.port_b, valveLiving.port_a) annotation(Line(points = {{-53.5, 3}, {-53.5, 4}, {-67, 4}}, color = {255, 0, 0}, thickness = 0.5, smooth = Smooth.None));
  connect(valveKitchen.port_a, toKiF.port_b) annotation(Line(points = {{-67, -74.5}, {-57, -74.5}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(radiatorKitchen.port_a, valveKitchen.port_b) annotation(Line(points = {{-89.68, -74.5}, {-82, -74.5}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(HydRes_InFl.port_a, thStF.port_b) annotation(Line(points = {{24, -79.5}, {40, -79.5}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(radiatorKitchen.port_b, HydRes_RadKi.port_a) annotation(Line(points = {{-105.32, -74.5}, {-118, -74.5}, {-118, -75}, {-130, -75}, {-130, -96}, {-113, -96}}, color = {0, 128, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(HydRes_RadKi.port_b, toKiR.port_a) annotation(Line(points = {{-99, -96}, {-72, -96}}, color = {0, 128, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(toWCR.port_a, HydRes_RadWC.port_b) annotation(Line(points = {{27, -48.5}, {57, -48.5}}, color = {0, 128, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(HydRes_RadWC.port_a, radiatorWC.port_b) annotation(Line(points = {{67, -48.5}, {127, -48.5}, {127, -39.5}, {99.32, -39.5}}, color = {0, 128, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(HydRes_RadLi.port_b, toLiR.port_a) annotation(Line(points = {{-102, -16.5}, {-95, -16.5}}, color = {0, 128, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(HydRes_RadLi.port_a, radiatorLiving.port_b) annotation(Line(points = {{-116, -16.5}, {-129, -16.5}, {-129, 4}, {-112.28, 4}}, color = {0, 128, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(toCoR.port_a, HydRes_RadCor.port_b) annotation(Line(points = {{55, 27}, {74, 27}}, color = {0, 128, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(HydRes_RadCor.port_a, radiatorCorridor.port_b) annotation(Line(points = {{84, 27}, {126, 27}, {126, 40.5}, {100.4, 40.5}}, color = {0, 128, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(toHoR.port_a, HydRes_RadHo.port_b) annotation(Line(points = {{27, 66}, {60, 66}}, color = {0, 128, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(HydRes_RadHo.port_a, radiatorHobby.port_b) annotation(Line(points = {{74, 66}, {126, 66}, {126, 80}, {93.36, 80}}, color = {0, 128, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(HydRes_BendRight.port_b, thWCF.port_a) annotation(Line(points = {{-3.75, -72.5}, {-3.75, -70}, {-4.5, -70}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(radiatorKitchen.radPort, Rad_Kitchen) annotation(Line(points = {{-100.9, -67.87}, {-100.9, -42}, {-137.5, -42}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(radiatorKitchen.convPort, Con_Kitchen) annotation(Line(points = {{-93.93, -68.04}, {-93.93, -58.5}, {-138, -58.5}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(radiatorWC.convPort, Con_WC) annotation(Line(points = {{87.93, -33.04}, {88, -33.04}, {88, -33}, {99, -33}, {119, -33}, {119, -50}, {138.5, -50}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(radiatorWC.radPort, Rad_WC) annotation(Line(points = {{94.9, -32.87}, {94.9, -28}, {138, -28}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(radiatorCorridor.radPort, Rad_Corridor) annotation(Line(points = {{96.5, 46.35}, {96.5, 49}, {140, 49}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(radiatorCorridor.convPort, Con_Corridor) annotation(Line(points = {{90.35, 46.2}, {90, 46.2}, {90, 46}, {113, 46}, {113, 25.5}, {126, 25.5}, {138.5, 25.5}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(radiatorHobby.convPort, Con_Hobby) annotation(Line(points = {{82.64, 86.08}, {82.64, 87}, {82.64, 91}, {98, 91}, {119, 91}, {119, 73}, {138, 73}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(radiatorHobby.radPort, Rad_Hobby) annotation(Line(points = {{89.2, 86.24}, {89.2, 97}, {137, 97}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(radiatorLiving.radPort, Rad_Livingroom) annotation(Line(points = {{-107.6, 11.02}, {-107.6, 11}, {-108, 11}, {-108, 11}, {-131, 11}, {-131, 40}, {-131, 40}, {-131, 46}, {-136, 46}, {-136, 46.5}, {-140, 46.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(radiatorLiving.convPort, Con_Livingroom) annotation(Line(points = {{-100.22, 10.84}, {-100.22, 12}, {-100, 12}, {-100, 14}, {-133, 14}, {-133, 32}, {-137, 32}, {-137, 31.5}, {-139.5, 31.5}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(toKiR.port_b, thStR.port_a) annotation(Line(points = {{-56, -96}, {40, -96}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(thWCR.port_b, thStR.port_a) annotation(Line(points = {{-18.25, -71.5}, {-18.25, -96}, {40, -96}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(thCo1R.port_b, thWCR.port_a) annotation(Line(points = {{-18, -34}, {-18, -54}, {-18.25, -54}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(thCoR2.port_b, thCo1R.port_a) annotation(Line(points = {{-19, 5}, {-19, -21}, {-18, -21}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(toLiR.port_b, thCo1R.port_a) annotation(Line(points = {{-82, -16.5}, {-19, -16.5}, {-19, -21}, {-18, -21}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(toHoR.port_b, thCoR2.port_a) annotation(Line(points = {{14, 66}, {-19, 66}, {-19, 20}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(toCoR.port_b, thCoR2.port_a) annotation(Line(points = {{40, 27}, {-19, 27}, {-19, 20}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(toWCR.port_b, thWCR.port_a) annotation(Line(points = {{10, -48.5}, {-18, -48.5}, {-18, -54}, {-18.25, -54}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
  connect(HydRes_BendRight.port_a, HydRes_InFl.port_b) annotation(Line(points = {{-3.75, -79}, {-3.75, -79.5}, {10, -79.5}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(thWCF.port_b, toWCF.port_a) annotation(Line(points = {{-4.5, -54}, {-4.5, -38.5}, {10, -38.5}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(toKiF.port_a, HydRes_InFl.port_b) annotation(Line(points = {{-41, -74.5}, {-23, -74.5}, {-23, -80}, {10, -80}, {10, -79.5}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(thWCF.port_b, thCo1F.port_a) annotation(Line(points = {{-4.5, -54}, {-4.5, -44}, {-5, -44}, {-5, -33}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(thCo1F.port_b, thCo2F.port_a) annotation(Line(points = {{-5, -20}, {-5, 6}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(thCo2F.port_b, toCoF.port_a) annotation(Line(points = {{-5, 20}, {-5, 40.5}, {37, 40.5}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(thCo2F.port_b, toHoF.port_a) annotation(Line(points = {{-5, 20}, {-5, 80.5}, {17, 80.5}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(thCo1F.port_b, toLiF.port_a) annotation(Line(points = {{-5, -20}, {-5, 3}, {-41.5, 3}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 0.5));
  connect(valveHobby.T_setRoom, TSet_GF[2]) annotation(Line(points = {{57.58, 86.87}, {57.58, 87}, {-109, 87}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(valveCorridor.T_setRoom, TSet_GF[3]) annotation(Line(points = {{73.36, 47.84}, {73.36, 57}, {-77, 57}, {-77, 92}, {-109, 92}, {-109, 93}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(valveWC.T_setRoom, TSet_GF[4]) annotation(Line(points = {{47.36, -31.16}, {47.36, -7}, {18, -7}, {18, 29}, {-76, 29}, {-76, 99}, {-93, 99}, {-93, 99}, {-109, 99}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(valveKitchen.T_setRoom, TSet_GF[5]) annotation(Line(points = {{-78.7, -66.66}, {-78.7, -62}, {-76, -62}, {-76, 105}, {-109, 105}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(valveLiving.T_setRoom, TSet_GF[1]) annotation(Line(points = {{-76.36, 11.84}, {-76.36, 52}, {-76, 52}, {-76, 92}, {-109, 92}, {-109, 81}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(valveHobby.T_room, TIs_GF[2]) annotation(Line(points = {{50.98, 86.87}, {50.98, 87}, {-76, 87}, {-76, 95}, {-43.5, 95}, {-43.5, 88.7}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(valveCorridor.T_room, TIs_GF[3]) annotation(Line(points = {{66.16, 47.84}, {66.16, 57}, {-76, 57}, {-76, 95}, {-60, 95}, {-60, 94.5}, {-43.5, 94.5}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(valveWC.T_room, TIs_GF[4]) annotation(Line(points = {{40.16, -31.16}, {40.16, -7}, {18, -7}, {18, 29}, {-76, 29}, {-76, 100.3}, {-43.5, 100.3}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(valveKitchen.T_room, TIs_GF[5]) annotation(Line(points = {{-69.7, -66.66}, {-69.7, -62}, {-76, -62}, {-76, 106}, {-56, 106}, {-56, 106.1}, {-43.5, 106.1}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(TIs_GF[1], valveLiving.T_room) annotation(Line(points = {{-43.5, 82.9}, {-76, 82.9}, {-76, 20}, {-69.16, 20}, {-69.16, 11.84}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(__Dymola_Images(Parameters(source = "Images/OFD/GroundFloor_Hydraulics.png")), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-130, -100}, {130, 100}}, grid = {1, 1}), graphics = {Rectangle(extent = {{1, 100}, {126, 63}}, pattern = LinePattern.None, lineColor = {0, 0, 0}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid), Rectangle(extent = {{4, 58}, {127, 15}}, pattern = LinePattern.None, lineColor = {0, 0, 0}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid), Rectangle(extent = {{4, -14}, {127, -67}}, pattern = LinePattern.None, lineColor = {0, 0, 0}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-129, 29}, {-22, -25}}, pattern = LinePattern.None, lineColor = {0, 0, 0}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-130, -49}, {-23, -103}}, pattern = LinePattern.None, lineColor = {0, 0, 0}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid), Text(extent = {{-120, -81}, {-69, -96}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "Kitchen"), Text(extent = {{-156.5, 29}, {-49.5, 16}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "Livingroom"), Text(extent = {{31, -15}, {138, -28}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "WC/Storage"), Text(extent = {{-27, 56}, {80, 43}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "Corridor"), Text(extent = {{-34, 100}, {73, 87}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "Hobby")}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-130, -100}, {130, 100}}, grid = {1, 1}), graphics = {Rectangle(extent = {{-119, 92}, {123, -79}}, lineColor = {255, 0, 0}, fillColor = {135, 135, 135}, fillPattern = FillPattern.Solid), Line(points = {{-99, 22}, {104, 22}, {104, -6}}, color = {255, 0, 0}, smooth = Smooth.None, thickness = 1), Line(points = {{-98, 13}, {95, 13}, {95, -6}}, color = {0, 0, 255}, smooth = Smooth.None, thickness = 1), Line(points = {{-21, 13}, {-21, 35}}, color = {0, 0, 255}, thickness = 1, smooth = Smooth.None), Line(points = {{-14, 23}, {-14, 45}}, color = {255, 0, 0}, thickness = 1, smooth = Smooth.None), Text(extent = {{-124, 119}, {-84, 111}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, textString = "Set"), Text(extent = {{-61, 118}, {-21, 110}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, textString = "Is")}), Documentation(revisions = "<html>
 <p><ul>
 <li><i>November 25, 2013</i> by Ana Constantin:<br/>Implemented</li>
 </ul></p>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This model reflects the heat distribution and transfer of a full floor for a one-family-dwelling. It focuses on thermohydraulics, building physics can be connected via heat ports.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The model is based on a specific one-family-dwelling and thus only reflects the thermohydraulic behavior of this specific building. The building hydraulics are thought as a reference example for model and technology comparisons.</p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.OFD.Examples.GroundfloorBoiler\">AixLib.HVAC.OFD.Examples.GroundfloorBoiler</a></p>
 <p><a href=\"AixLib.HVAC.OFD.Examples.GroundfloorHeatPump\">AixLib.HVAC.OFD.Examples.GroundfloorHeatPump</a></p>
 </html>"));
end GroundFloor;