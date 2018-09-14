within AixLib.ThermalZones.HighOrder.Rooms.MFD.OneAppartment;
model Children_VoWo "Children room from the VoWo appartment"
  import AixLib;
  ///////// construction parameters
  parameter Integer TMC = 1 "Thermal Mass Class" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1 "Heavy", choice = 2 "Medium", choice = 3 "Light", radioButtons = true));
  parameter Integer TIR = 4 "Thermal Insulation Regulation" annotation(Dialog(groupImage = "modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Children.png", group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1
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
  parameter Modelica.SIunits.Temperature T0_IWLivingroom = 294.15
    "IWLivingroom"                                                               annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_IWNeighbour = 294.15 "IWNeighbour" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_IWCorridor = 290.15 "IWCorridor" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_IWStraicase = 288.15 "IWStaircase" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
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
    wall_length=4.2,
    wall_height=2.46,
    withWindow=false,
    withDoor=false)
    annotation (Placement(transformation(extent={{-76,-40},{-66,20}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Corridor(
    T0=T0_IWCorridor,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWload,
    wall_length=2.13,
    wall_height=2.46,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={-25.6,-49},
        extent={{-3,-21.6},{5,26.4}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Neighbour(
    T0=T0_IWNeighbour,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWload,
    wall_length=4.2,
    wall_height=2.46,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={60,4.92309},
        extent={{-2,-35.0769},{10,36.9231}},
        rotation=180)));
  AixLib.ThermalZones.HighOrder.Components.DryAir.Airload airload(V=room_V, T(
        start=T0_air))
    annotation (Placement(transformation(extent={{-38,16},{-58,36}})));
  Utilities.Interfaces.SolarRad_in Strahlung_SE annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-82, 110}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-30, 110})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outsideWall(
    wall_length=3.38,
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
        origin={-12,51},
        extent={{-9,-54},{9,54}},
        rotation=270)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Staircase(
    T0=T0_IWStraicase,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWload,
    wall_length=0.86,
    wall_height=2.46,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={36.9565,-47},
        extent={{-3,-21.0435},{5,22.9565}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Ceiling(
    T0=T0_CE,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_CE,
    wall_length=4.20,
    wall_height=3.38,
    ISOrientation=3,
    withWindow=false,
    withDoor=false) "Decke" annotation (Placement(transformation(
        origin={112,76},
        extent={{-1.99998,-10},{1.99998,10}},
        rotation=270)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Floor(
    T0=T0_FL,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_FL,
    wall_length=4.20,
    wall_height=3.38,
    ISOrientation=2,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={112,42},
        extent={{-1.99998,-10},{1.99998,10}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.DryAir.InfiltrationRate_DIN12831
    infiltrationRate(
    room_V=room_V,
    n50=n50,
    e=e,
    eps=eps)
    annotation (Placement(transformation(extent={{-44,-120},{-18,-94}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside annotation(Placement(transformation(extent = {{-70, 88}, {-50, 108}}), iconTransformation(extent = {{-70, 88}, {-50, 108}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation(Placement(transformation(extent = {{-124, -8}, {-84, 32}}), iconTransformation(extent = {{-110, 30}, {-90, 50}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation(Placement(transformation(extent = {{-124, 20}, {-84, 60}}), iconTransformation(extent = {{-110, 60}, {-90, 80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermNeighbour annotation(Placement(transformation(extent = {{-110, 0}, {-90, 20}}), iconTransformation(extent = {{-110, 0}, {-90, 20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermStaircase annotation(Placement(transformation(extent = {{-110, -30}, {-90, -10}}), iconTransformation(extent = {{-110, -30}, {-90, -10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor annotation(Placement(transformation(extent = {{-110, -60}, {-90, -40}}), iconTransformation(extent = {{-110, -60}, {-90, -40}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermLivingroom annotation(Placement(transformation(extent = {{-108, -130}, {-88, -110}}), iconTransformation(extent = {{-110, -90}, {-90, -70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling annotation(Placement(transformation(extent = {{-110, -120}, {-90, -100}}), iconTransformation(extent = {{-110, -120}, {-90, -100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor annotation(Placement(transformation(extent = {{-110, -152}, {-90, -132}}), iconTransformation(extent = {{-110, -152}, {-90, -132}})));
  Utilities.Interfaces.Star StarRoom annotation(Placement(transformation(extent = {{6, -6}, {26, 14}}), iconTransformation(extent = {{6, -6}, {26, 14}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermRoom annotation(Placement(transformation(extent = {{-26, -4}, {-6, 16}}), iconTransformation(extent = {{-26, -4}, {-6, 16}})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation = 90, origin = {0, -22})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange
    NaturalVentilation(V=room_V)
    annotation (Placement(transformation(extent={{-44,-94},{-16,-68}})));
protected
  parameter Real n50(unit = "h-1") = if TIR == 1 or TIR == 2 then 3 else if TIR == 3 then 4 else 6
    "Air exchange rate at 50 Pa pressure difference"                                                                                                annotation(Dialog(tab = "Infiltration"));
  parameter Real e = 0.03 "Coefficient of windshield" annotation(Dialog(tab = "Infiltration"));
  parameter Real eps = 1.0 "Coefficient of height" annotation(Dialog(tab = "Infiltration"));
  // Outer wall type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M() else AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M() else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L() annotation(Dialog(tab = "Types"));
  //Inner wall Types
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half() else AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half() else AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half() annotation(Dialog(tab = "Types"));
  // Floor type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL = if Floor == 1 then if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Floor.FLcellar_EnEV2009_SML_upHalf() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Floor.FLcellar_EnEV2002_SML_upHalf() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Floor.FLcellar_WSchV1995_SML_upHalf() else AixLib.DataBase.Walls.WSchV1984.Floor.FLcellar_WSchV1984_SML_upHalf() else if TIR == 1 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf() else AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_L_upHalf() else if TIR == 2 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_SM_upHalf() else AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf() else if TIR == 3 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf() else AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_L_upHalf() else if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf() else AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_L_upHalf() annotation(Dialog(tab = "Types"));
  // Ceiling  type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE = if Floor == 1 or Floor == 2 then if TIR == 1 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf() else AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_L_loHalf() else if TIR == 2 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_SM_loHalf() else AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_L_loHalf() else if TIR == 3 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_SM_loHalf() else AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_L_loHalf() else if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_SM_loHalf() else AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_L_loHalf() else if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf() else AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf() annotation(Dialog(tab = "Types"));
  //Window type
  parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple Type_Win = if TIR == 1 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else if TIR == 2 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else if TIR == 3 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995() else AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984() annotation(Dialog(tab = "Types"));
  parameter Modelica.SIunits.Volume room_V = 3.38 * 4.20 * 2.46;
equation
  connect(Strahlung_SE, outsideWall.SolarRadiationPort) annotation(Line(points = {{-82, 110}, {-82, 78}, {58, 78}, {58, 62.7}, {37.5, 62.7}}, color = {255, 128, 0}));
  connect(infiltrationRate.port_b, airload.port) annotation(Line(points = {{-18, -107}, {0, -107}, {0, -36}, {-32, -36}, {-32, 24}, {-39, 24}}, color = {191, 0, 0}));
  connect(infiltrationRate.port_a, thermOutside) annotation(Line(points = {{-44, -107}, {-80, -107}, {-80, 98}, {-60, 98}}, color = {191, 0, 0}));
  connect(outsideWall.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{27.6, 60.45}, {27.6, 78}, {-80, 78}, {-80, 12}, {-104, 12}}, color = {0, 0, 127}));
  connect(Wall_Neighbour.port_outside, thermNeighbour) annotation(Line(points = {{62.3, 3.99999}, {100, 3.99999}, {100, -68}, {-80, -68}, {-80, 10}, {-100, 10}}, color = {191, 0, 0}));
  connect(Wall_Staircase.port_outside, thermStaircase) annotation(Line(points = {{36, -50.2}, {36, -68}, {-80, -68}, {-80, -20}, {-100, -20}}, color = {191, 0, 0}));
  connect(Wall_Corridor.port_outside, thermCorridor) annotation(Line(points = {{-28, -52.2}, {-28, -68}, {-80, -68}, {-80, -50}, {-100, -50}}, color = {191, 0, 0}));
  connect(Wall_Livingroom.port_outside, thermLivingroom) annotation(Line(points = {{-76.25, -10}, {-80, -10}, {-80, -120}, {-98, -120}}, color = {191, 0, 0}));
  connect(Wall_Ceiling.port_outside, thermCeiling) annotation(Line(points={{112,
          78.1},{112,88},{100,88},{100,-68},{-80,-68},{-80,-110},{-100,-110}},                                                                                      color = {191, 0, 0}));
  connect(Wall_Floor.port_outside, thermFloor) annotation(Line(points={{112,
          39.9},{112,8},{100,8},{100,-68},{-100,-68},{-100,-142}},                                                                                color = {191, 0, 0}));
  connect(thermStar_Demux.star, StarRoom) annotation(Line(points = {{5.8, -11.6}, {6, -10}, {6, -8}, {16, -8}, {16, 4}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(thermStar_Demux.therm, ThermRoom) annotation(Line(points = {{-5.1, -11.9}, {-5.1, -3.95}, {-16, -3.95}, {-16, 6}}, color = {191, 0, 0}));
  connect(thermStar_Demux.therm, airload.port) annotation(Line(points = {{-5.1, -11.9}, {-32, -11.9}, {-32, 24}, {-39, 24}}, color = {191, 0, 0}));
  connect(Wall_Corridor.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{-28, -44}, {-28, -36}, {-0.1, -36}, {-0.1, -31.4}}, color = {191, 0, 0}));
  connect(Wall_Staircase.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{36, -42}, {36, -36}, {-0.1, -36}, {-0.1, -31.4}}, color = {191, 0, 0}));
  connect(Wall_Neighbour.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{50, 3.99999}, {40, 3.99999}, {40, -36}, {-0.1, -36}, {-0.1, -31.4}}, color = {191, 0, 0}));
  connect(outsideWall.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{-12, 42}, {-12, 30}, {40, 30}, {40, -36}, {-0.1, -36}, {-0.1, -31.4}}, color = {191, 0, 0}));
  connect(Wall_Floor.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{112,44},
          {112,52},{40,52},{40,-36},{-0.1,-36},{-0.1,-31.4}},                                                                                                    color = {191, 0, 0}));
  connect(Wall_Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{112,74},
          {112,52},{40,52},{40,-36},{-0.1,-36},{-0.1,-31.4}},                                                                                                    color = {191, 0, 0}));
  connect(Wall_Livingroom.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{-66, -10}, {-50, -10}, {-50, -36}, {-0.1, -36}, {-0.1, -31.4}}, color = {191, 0, 0}));
  connect(thermOutside, NaturalVentilation.port_a) annotation(Line(points = {{-60, 98}, {-80, 98}, {-80, -68}, {-50, -68}, {-50, -81}, {-44, -81}}, color = {191, 0, 0}));
  connect(AirExchangePort, NaturalVentilation.InPort1) annotation(Line(points = {{-104, 40}, {-80, 40}, {-80, -68}, {-50, -68}, {-50, -89.32}, {-42.6, -89.32}}, color = {0, 0, 127}));
  connect(NaturalVentilation.port_b, airload.port) annotation(Line(points = {{-16, -81}, {0, -81}, {0, -36}, {-32, -36}, {-32, 24}, {-39, 24}}, color = {191, 0, 0}));
  connect(outsideWall.port_outside, thermOutside) annotation(Line(points = {{-12, 60.45}, {-12, 98}, {-60, 98}}, color = {191, 0, 0}));
  connect(thermOutside, thermOutside) annotation(Line(points = {{-60, 98}, {-86, 98}, {-86, 98}, {-60, 98}}, color = {191, 0, 0}));
  annotation(DDiagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}}), graphics={  Rectangle(extent = {{-54, 68}, {116, -108}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Forward), Text(extent = {{-36, -20}, {98, -54}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0},
            fillPattern =                                                                                                   FillPattern.Forward, textString = "Children"), Rectangle(extent = {{-10, 80}, {12, 60}}, lineColor = {0, 0, 0}, fillColor = {85, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-8, 78}, {10, 62}}, lineColor = {0, 0, 0}, fillColor = {170, 213, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Line(points = {{-4, 66}, {6, 76}}, color = {255, 255, 255}, thickness = 1), Line(points = {{0, 66}, {6, 72}}, color = {255, 255, 255}, thickness = 1), Line(points = {{-4, 70}, {2, 76}}, color = {255, 255, 255}, thickness = 1), Text(extent = {{2, 82}, {52, 66}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "OW"), Text(extent = {{6, -110}, {56, -126}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Corridor"), Rectangle(extent = {{90, -96}, {110, -126}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1, fillColor = {127, 0, 0},
            fillPattern =                                                                                                   FillPattern.Forward), Ellipse(extent = {{92, -108}, {94, -110}}, lineColor = {0, 0, 0}, pattern=LinePattern.None,
            lineThickness =                                                                                                   1,
            fillPattern =                                                                                                   FillPattern.Sphere, fillColor = {255, 255, 0}), Rectangle(extent = {{-110, -100}, {-90, -120}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -70}, {-90, -90}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -40}, {-90, -60}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, 20}, {-90, 0}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-70, 88}, {-50, 88}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -10}, {-90, -30}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, 82}, {-90, 28}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -132}, {-90, -152}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5)}), Documentation(revisions = "<html>
 <ul>
 <li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
 <li><i>August 16, 2011</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for a second bedroom: the childrens&apos; room. </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The following figure presents the room&apos;s layout:</p>
 <p><img src=\"modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Children.png\"
    alt=\"Room layout\"/></p>
 </html>"));
end Children_VoWo;
