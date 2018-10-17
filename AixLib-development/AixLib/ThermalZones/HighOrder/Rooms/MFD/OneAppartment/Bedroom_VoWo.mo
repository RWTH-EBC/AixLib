within AixLib.ThermalZones.HighOrder.Rooms.MFD.OneAppartment;
model Bedroom_VoWo "Bedroom from the VoWo appartment"
  import AixLib;
  ///////// construction parameters
  parameter Integer TMC = 1 "Thermal Mass Class" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1 "Heavy", choice = 2 "Medium", choice = 3 "Light", radioButtons = true));
  parameter Integer TIR = 4 "Thermal Insulation Regulation" annotation(Dialog(groupImage = "modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Bedroom.png", group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1
        "EnEV_2009",                                                                                                    choice = 2
        "EnEV_2002",                                                                                                    choice = 3
        "WSchV_1995",                                                                                                    choice = 4
        "WSchV_1984",                                                                                                    radioButtons = true));
  parameter Integer Floor = 1 "Floor" annotation(Dialog(group = "Floor", compact = true, descriptionLabel = true), choices(choice = 1 "GF", choice = 2 "1F", choice = 3 "2F", radioButtons = true));
  // Outer walls properties
  parameter Real solar_absorptance_OW = 0.7 "Solar absoptance outer walls " annotation(Dialog(group = "Outer wall properties", descriptionLabel = true));
  parameter Integer ModelConvOW = 1 "Heat Convection Model" annotation(Dialog(group = "Outer wall properties", compact = true, descriptionLabel = true), choices(choice = 1
        "DIN 6946",                                                                                                    choice = 2
        "ASHRAE Fundamentals",                                                                                                    choice = 3
        "Custom alpha",                                                                                                    radioButtons = true));
  //Initial temperatures
  parameter Modelica.SIunits.Temperature T0_air = 295.15 "Air" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_OW = 295.15 "OW" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_IWLivingroom = 295.15
    "IWLivingroom"                                                               annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_IWCorridor = 290.15 "IWCorridor" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_IWBathroom = 297.15 "IWBathroom" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_IWNeighbour = 295.15 "IWNeighbour" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_CE = 295.35 "Ceiling" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_FL = 294.95 "Floor" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
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
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Livingroom(
    T0=T0_IWLivingroom,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWload,
    wall_length=3.105,
    wall_height=2.46,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={-10,42},
        extent={{-7.99999,-48},{7.99999,48}},
        rotation=270)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Neighbour(
    T0=T0_IWNeighbour,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWNeigbour,
    wall_length=5.3,
    wall_height=2.46,
    withWindow=false,
    withDoor=false)
    annotation (Placement(transformation(extent={{-74,-58},{-60,20}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Bath(
    T0=T0_IWBathroom,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWload,
    wall_length=3.28,
    wall_height=2.46,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={61,-40},
        extent={{-4.99999,-28},{4.99999,28}},
        rotation=180)));
  AixLib.ThermalZones.HighOrder.Components.DryAir.Airload airload(V=room_V, T(
        start=T0_air))
    annotation (Placement(transformation(extent={{30,-2},{10,18}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outsideWall(
    wall_length=3.105,
    wall_height=2.46,
    windowarea=1.84,
    withWindow=true,
    T0=T0_OW,
    solar_absorptance=solar_absorptance_OW,
    WallType=Type_OW,
    WindowType=Type_Win,
    outside=true,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false) annotation (Placement(transformation(
        origin={-4,-92},
        extent={{-10,-60},{10,60}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Ceiling(
    T0=T0_CE,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_CE,
    wall_length=3.105,
    wall_height=5.30,
    ISOrientation=3,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={96,-62},
        extent={{-2,-12},{2,12}},
        rotation=270)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Floor(
    T0=T0_FL,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_FL,
    wall_length=3.105,
    wall_height=5.30,
    ISOrientation=2,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={96,-100},
        extent={{-1.99983,-10},{1.99984,10}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Corridor(
    T0=T0_IWCorridor,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWload,
    wall_length=1.96,
    wall_height=2.46,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={59,16},
        extent={{-3.00002,-16},{2.99997,16}},
        rotation=180)));
  AixLib.ThermalZones.HighOrder.Components.DryAir.InfiltrationRate_DIN12831
    infiltrationRate(
    room_V=room_V,
    n50=n50,
    e=e,
    eps=eps) annotation (Placement(transformation(extent={{-44,80},{-18,106}})));
  Utilities.Interfaces.SolarRad_in SolarRadiation_NW annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-60, -150})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation(Placement(transformation(extent = {{-128, -24}, {-88, 16}}), iconTransformation(extent = {{-110, 20}, {-90, 40}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation(Placement(transformation(extent = {{-130, 30}, {-90, 70}}), iconTransformation(extent = {{-110, 50}, {-90, 70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside annotation(Placement(transformation(extent = {{-110, 80}, {-90, 100}}), iconTransformation(extent = {{-110, 80}, {-90, 100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermLivingroom annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}}), iconTransformation(extent = {{-110, -10}, {-90, 10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor annotation(Placement(transformation(extent = {{-110, -40}, {-90, -20}}), iconTransformation(extent = {{-110, -40}, {-90, -20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermBath annotation(Placement(transformation(extent = {{-110, -70}, {-90, -50}}), iconTransformation(extent = {{-110, -70}, {-90, -50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling annotation(Placement(transformation(extent = {{-110, -130}, {-90, -110}}), iconTransformation(extent = {{-110, -130}, {-90, -110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor annotation(Placement(transformation(extent = {{-110, -160}, {-90, -140}}), iconTransformation(extent = {{-110, -160}, {-90, -140}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermNeigbour annotation(Placement(transformation(extent = {{-110, -100}, {-90, -80}}), iconTransformation(extent = {{-110, -100}, {-90, -80}})));
  Utilities.Interfaces.Star StarRoom annotation(Placement(transformation(extent = {{18, -44}, {38, -24}}), iconTransformation(extent = {{18, -44}, {38, -24}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermRoom annotation(Placement(transformation(extent = {{-20, -46}, {0, -26}}), iconTransformation(extent = {{-20, -46}, {0, -26}})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation = 90, origin = {14, -60})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange
    NaturalVentilation(V=room_V)
    annotation (Placement(transformation(extent={{66,72},{94,98}})));
protected
  parameter Real n50(unit = "h-1") = if TIR == 1 or TIR == 2 then 3 else if TIR == 3 then 4 else 6
    "Air exchange rate at 50 Pa pressure difference"                                                                                                annotation(Dialog(tab = "Infiltration"));
  parameter Real e = 0.03 "Coefficient of windshield" annotation(Dialog(tab = "Infiltration"));
  parameter Real eps = 1.0 "Coefficient of height" annotation(Dialog(tab = "Infiltration"));
  // Outer wall type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M() else AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M() else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L() annotation(Dialog(tab = "Types"));
  //Inner wall Types
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half() else AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half() else AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half() annotation(Dialog(tab = "Types"));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWNeigbour = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.IW.IWneighbour_EnEV2009_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.IW.IWneighbour_EnEV2009_M_half() else AixLib.DataBase.Walls.EnEV2009.IW.IWneighbour_EnEV2009_L_half() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.IW.IWneighbour_EnEV2002_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.IW.IWneighbour_EnEV2002_M_half() else AixLib.DataBase.Walls.EnEV2002.IW.IWneighbour_EnEV2002_L_half() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.IW.IWneighbour_WSchV1995_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.IW.IWneighbour_WSchV1995_M_half() else AixLib.DataBase.Walls.WSchV1995.IW.IWneighbour_WSchV1995_L_half() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.IW.IWneighbour_WSchV1984_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.IW.IWneighbour_WSchV1984_M_half() else AixLib.DataBase.Walls.WSchV1984.IW.IWneighbour_WSchV1984_L_half() annotation(Dialog(tab = "Types"));
  // Floor type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL = if Floor == 1 then if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Floor.FLcellar_EnEV2009_SML_upHalf() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Floor.FLcellar_EnEV2002_SML_upHalf() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Floor.FLcellar_WSchV1995_SML_upHalf() else AixLib.DataBase.Walls.WSchV1984.Floor.FLcellar_WSchV1984_SML_upHalf() else if TIR == 1 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf() else AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_L_upHalf() else if TIR == 2 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_SM_upHalf() else AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf() else if TIR == 3 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf() else AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_L_upHalf() else if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf() else AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_L_upHalf() annotation(Dialog(tab = "Types"));
  // Ceiling  type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE = if Floor == 1 or Floor == 2 then if TIR == 1 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf() else AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_L_loHalf() else if TIR == 2 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_SM_loHalf() else AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_L_loHalf() else if TIR == 3 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_SM_loHalf() else AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_L_loHalf() else if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_SM_loHalf() else AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_L_loHalf() else if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf() else AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf() annotation(Dialog(tab = "Types"));
  //Window type
  parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple Type_Win = if TIR == 1 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else if TIR == 2 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else if TIR == 3 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995() else AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984() annotation(Dialog(tab = "Types"));
  parameter Modelica.SIunits.Volume room_V = 3.105 * 5.30 * 2.46;
equation
  connect(outsideWall.SolarRadiationPort, SolarRadiation_NW) annotation(Line(points = {{-59, -105}, {-59, -118.691}, {-60, -118.691}, {-60, -150}}, color = {255, 128, 0}));
  connect(outsideWall.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{-48, -102.5}, {-48, -130}, {-80, -130}, {-80, -4}, {-108, -4}}, color = {0, 0, 127}));
  connect(infiltrationRate.port_a, thermOutside) annotation(Line(points = {{-44, 93}, {-61.35, 93}, {-61.35, 90}, {-100, 90}}, color = {191, 0, 0}));
  connect(infiltrationRate.port_b, airload.port) annotation(Line(points = {{-18, 93}, {-18, 92}, {44, 92}, {44, 6}, {29, 6}}, color = {191, 0, 0}));
  connect(Wall_Livingroom.port_outside, thermLivingroom) annotation(Line(points={{-10,
          50.4},{-10,50.4},{-10,66},{-80,66},{-80,0},{-100,0}},                                                                                          color = {191, 0, 0}));
  connect(Wall_Corridor.port_outside, thermCorridor) annotation(Line(points={{62.15,
          16},{84,16},{84,66},{-80,66},{-80,-30},{-100,-30}},                                                                                        color = {191, 0, 0}));
  connect(Wall_Bath.port_outside, thermBath) annotation(Line(points={{66.25,-40},
          {80,-40},{80,-130},{-80,-130},{-80,-60},{-100,-60}},                                                                                     color = {191, 0, 0}));
  connect(Wall_Ceiling.port_outside, thermCeiling) annotation(Line(points = {{96, -59.9}, {96, -48}, {130, -48}, {130, -130}, {-80, -130}, {-80, -120}, {-100, -120}}, color = {191, 0, 0}));
  connect(Wall_Neighbour.port_outside, thermNeigbour) annotation(Line(points = {{-74.35, -19}, {-80, -19}, {-80, -90}, {-100, -90}}, color = {191, 0, 0}));
  connect(thermFloor, Wall_Floor.port_outside) annotation(Line(points={{-100,
          -150},{-90,-150},{-90,-142},{-80,-142},{-80,-130},{96,-130},{96,
          -102.1}},                                                                                                    color = {191, 0, 0}));
  connect(outsideWall.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{-4, -82}, {-4, -74}, {13.9, -74}, {13.9, -69.4}}, color = {191, 0, 0}));
  connect(thermStar_Demux.thermStarComb, Wall_Ceiling.thermStarComb_inside) annotation(Line(points = {{13.9, -69.4}, {13.9, -74}, {96, -74}, {96, -64}}, color = {191, 0, 0}));
  connect(Wall_Floor.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{96,
          -98.0002},{96,-74},{13.9,-74},{13.9,-69.4}},                                                                                                    color = {191, 0, 0}));
  connect(thermStar_Demux.star, StarRoom) annotation(Line(points = {{19.8, -49.6}, {19.8, -43.8}, {28, -43.8}, {28, -34}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(thermStar_Demux.therm, airload.port) annotation(Line(points = {{8.9, -49.9}, {8.9, -16}, {44, -16}, {44, 6}, {29, 6}}, color = {191, 0, 0}));
  connect(thermStar_Demux.therm, ThermRoom) annotation(Line(points = {{8.9, -49.9}, {8.9, -36}, {-10, -36}}, color = {191, 0, 0}));
  connect(Wall_Neighbour.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{-60, -19}, {-48, -19}, {-48, -74}, {13.9, -74}, {13.9, -69.4}}, color = {191, 0, 0}));
  connect(Wall_Livingroom.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{-10,34},
          {-10,24},{-48,24},{-48,-74},{13.9,-74},{13.9,-69.4}},                                                                                                    color = {191, 0, 0}));
  connect(Wall_Corridor.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{56,16},
          {44,16},{44,-74},{13.9,-74},{13.9,-69.4}},                                                                                                    color = {191, 0, 0}));
  connect(Wall_Bath.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{56,-40},
          {44,-40},{44,-74},{13.9,-74},{13.9,-69.4}},                                                                                                    color = {191, 0, 0}));
  connect(AirExchangePort, NaturalVentilation.InPort1) annotation(Line(points = {{-110, 50}, {-80, 50}, {-80, 66}, {44, 66}, {44, 76.68}, {67.4, 76.68}}, color = {0, 0, 127}));
  connect(NaturalVentilation.port_a, thermOutside) annotation(Line(points = {{66, 85}, {44, 85}, {44, 90}, {-100, 90}}, color = {191, 0, 0}));
  connect(airload.port, NaturalVentilation.port_b) annotation(Line(points = {{29, 6}, {44, 6}, {44, 66}, {100, 66}, {100, 85}, {94, 85}}, color = {191, 0, 0}));
  connect(outsideWall.port_outside, thermOutside) annotation(Line(points = {{-4, -102.5}, {-4, -130}, {-80, -130}, {-80, 90}, {-100, 90}}, color = {191, 0, 0}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}}), graphics={  Rectangle(extent = {{-54, 68}, {98, -112}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Forward), Text(extent = {{-40, 2}, {84, -26}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0},
            fillPattern =                                                                                                   FillPattern.Forward, textString = "Bedroom"), Rectangle(extent = {{-42, -104}, {-20, -124}}, lineColor = {0, 0, 0}, fillColor = {85, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-40, -106}, {-22, -122}}, lineColor = {0, 0, 0}, fillColor = {170, 213, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Line(points = {{-36, -118}, {-26, -108}}, color = {255, 255, 255}, thickness = 1), Line(points = {{-32, -118}, {-26, -112}}, color = {255, 255, 255}, thickness = 1), Line(points = {{-36, -114}, {-30, -108}}, color = {255, 255, 255}, thickness = 1), Text(extent = {{-32, -112}, {18, -128}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "OW"), Text(extent = {{26, 92}, {76, 76}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Corridor"), Rectangle(extent = {{-54, 94}, {-34, 64}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1, fillColor = {127, 0, 0},
            fillPattern =                                                                                                   FillPattern.Forward), Ellipse(extent = {{-52, 82}, {-50, 80}}, lineColor = {0, 0, 0}, pattern=LinePattern.None,
            lineThickness =                                                                                                   1,
            fillPattern =                                                                                                   FillPattern.Sphere, fillColor = {255, 255, 0}), Text(extent = {{-72, -16}, {-76, -18}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5, textString = "Edit Here"), Rectangle(extent = {{-110, -110}, {-90, -130}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -80}, {-90, -100}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -20}, {-90, -40}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, 10}, {-90, -10}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, 72}, {-90, 18}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, 100}, {-90, 80}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -50}, {-90, -70}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -140}, {-90, -160}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5)}), Documentation(revisions = "<html>
 <ul>
 <li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
 <li><i>August 16, 2011</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for the bedroom.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The following figure presents the room&apos;s layout:</p>
 <p><img src=\"modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Bedroom.png\"
    alt=\"Room layout\"/></p>
 </html>"));
end Bedroom_VoWo;
