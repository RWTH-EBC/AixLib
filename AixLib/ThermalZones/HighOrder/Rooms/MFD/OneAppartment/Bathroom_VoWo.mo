within AixLib.ThermalZones.HighOrder.Rooms.MFD.OneAppartment;
model Bathroom_VoWo "Bathroom from the VoWo appartment"
  import AixLib;
  ///////// construction parameters
  parameter Integer TMC = 1 "Thermal Mass Class" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1 "Heavy", choice = 2 "Medium", choice = 3 "Light", radioButtons = true));
  parameter Integer TIR = 4 "Thermal Insulation Regulation" annotation(Dialog(groupImage = "modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Bath.png", group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1
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
  parameter Modelica.SIunits.Temperature T0_air = 297.15 "Air" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_Corridor = 290.15 "IWCorridor" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_IWKitchen = 295.15 "IWKitchen" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_IWBedroom = 295.15 "IWBedroom" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_OW = 295.15 "OW" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
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
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Corridor(
    T0=T0_Corridor,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWsimple,
    wall_length=1.31,
    wall_height=2.46,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={7,37},
        extent={{-7,-39},{7,39}},
        rotation=270)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Bedroom(
    T0=T0_IWBedroom,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWload,
    wall_length=3.28,
    wall_height=2.46,
    withWindow=false,
    withDoor=false)
    annotation (Placement(transformation(extent={{-60,-76},{-46,8}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Kitchen1(
    T0=T0_IWKitchen,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWsimple,
    wall_length=3.28,
    wall_height=2.46,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={58,-22},
        extent={{-6,-36},{6,36}},
        rotation=180)));
  AixLib.ThermalZones.HighOrder.Components.DryAir.Airload airload(V=room_V, T(
        start=T0_air))
    annotation (Placement(transformation(extent={{-12,-26},{8,-6}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Kitchen2(
    T0=T0_IWKitchen,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWsimple,
    wall_length=0.44,
    wall_height=2.46,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={77,-59},
        extent={{-3,-15},{3,15}},
        rotation=270)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outsideWall(
    wall_height=2.46,
    windowarea=0.75,
    wall_length=1.75,
    withWindow=true,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    T0=T0_OW,
    solar_absorptance=solar_absorptance_OW,
    withDoor=false,
    WallType=Type_OW,
    WindowType=Type_Win) annotation (Placement(transformation(
        origin={8,-105},
        extent={{-11,-66},{11,66}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Ceiling(
    T0=T0_CE,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_CE,
    wall_length=sqrt(4.65),
    wall_height=sqrt(4.65),
    ISOrientation=3,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={106,-80},
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
    wall_length=sqrt(4.65),
    wall_height=sqrt(4.65),
    ISOrientation=2,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={106,-116},
        extent={{-1.99983,-10},{1.99984,10}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.DryAir.InfiltrationRate_DIN12831
    infiltrationRate(
    room_V=room_V,
    n50=n50,
    e=e,
    eps=eps) annotation (Placement(transformation(extent={{-42,60},{-16,86}})));
  Utilities.Interfaces.SolarRad_in SolarRadiation_NW annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-56, -150})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation(Placement(transformation(extent = {{-122, -30}, {-82, 10}}), iconTransformation(extent = {{-110, 12}, {-94, 28}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation(Placement(transformation(extent = {{-122, 0}, {-82, 40}}), iconTransformation(extent = {{-110, 52}, {-94, 68}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside annotation(Placement(transformation(extent = {{-110, 80}, {-90, 100}}), iconTransformation(extent = {{-110, 80}, {-90, 100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor annotation(Placement(transformation(extent = {{-110, -20}, {-90, 0}}), iconTransformation(extent = {{-110, -20}, {-90, 0}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermKitchen annotation(Placement(transformation(extent = {{-110, -50}, {-90, -30}}), iconTransformation(extent = {{-110, -50}, {-90, -30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermBedroom annotation(Placement(transformation(extent = {{-110, -80}, {-90, -60}}), iconTransformation(extent = {{-110, -80}, {-90, -60}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling annotation(Placement(transformation(extent = {{-110, -110}, {-90, -90}}), iconTransformation(extent = {{-110, -110}, {-90, -90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor annotation(Placement(transformation(extent = {{-110, -140}, {-90, -120}}), iconTransformation(extent = {{-110, -140}, {-90, -120}})));
  Utilities.Interfaces.Star StarRoom annotation(Placement(transformation(extent = {{10, -54}, {30, -34}}), iconTransformation(extent = {{10, -54}, {30, -34}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermRoom annotation(Placement(transformation(extent = {{-28, -52}, {-8, -32}}), iconTransformation(extent = {{-28, -52}, {-8, -32}})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation = 90, origin = {0, -68})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange
    NaturalVentilation(V=room_V)
    annotation (Placement(transformation(extent={{16,68},{44,94}})));
protected
  parameter Real n50(unit = "h-1") = if TIR == 1 or TIR == 2 then 3 else if TIR == 3 then 4 else 6
    "Air exchange rate at 50 Pa pressure difference"                                                                                                annotation(Dialog(tab = "Infiltration"));
  parameter Real e = 0.03 "Coefficient of windshield" annotation(Dialog(tab = "Infiltration"));
  parameter Real eps = 1.0 "Coefficient of height" annotation(Dialog(tab = "Infiltration"));
  // Outer wall type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M() else AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M() else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L() annotation(Dialog(tab = "Types"));
  //Inner wall Types
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWsimple = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() else AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_L_half() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_M_half() else AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_L_half() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_M_half() else AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_L_half() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_M_half() else AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_L_half() annotation(Dialog(tab = "Types"));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half() else AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half() else AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half() annotation(Dialog(tab = "Types"));
  // Floor type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL = if Floor == 1 then if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Floor.FLcellar_EnEV2009_SML_upHalf() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Floor.FLcellar_EnEV2002_SML_upHalf() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Floor.FLcellar_WSchV1995_SML_upHalf() else AixLib.DataBase.Walls.WSchV1984.Floor.FLcellar_WSchV1984_SML_upHalf() else if TIR == 1 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf() else AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_L_upHalf() else if TIR == 2 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_SM_upHalf() else AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf() else if TIR == 3 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf() else AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_L_upHalf() else if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf() else AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_L_upHalf() annotation(Dialog(tab = "Types"));
  // Ceiling  type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE = if Floor == 1 or Floor == 2 then if TIR == 1 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf() else AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_L_loHalf() else if TIR == 2 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_SM_loHalf() else AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_L_loHalf() else if TIR == 3 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_SM_loHalf() else AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_L_loHalf() else if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_SM_loHalf() else AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_L_loHalf() else if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf() else AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf() annotation(Dialog(tab = "Types"));
  //Window type
  parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple Type_Win = if TIR == 1 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else if TIR == 2 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else if TIR == 3 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995() else AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984() annotation(Dialog(tab = "Types"));
  parameter Modelica.SIunits.Volume room_V = 4.65 * 2.46;
equation
  connect(outsideWall.SolarRadiationPort, SolarRadiation_NW) annotation(Line(points = {{-52.5, -119.3}, {-52.5, -131.905}, {-56, -131.905}, {-56, -150}}, color = {255, 128, 0}));
  connect(outsideWall.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{-40.4, -116.55}, {-40.4, -140}, {-80, -140}, {-80, -10}, {-102, -10}}, color = {0, 0, 127}));
  connect(Wall_Corridor.port_outside, thermCorridor) annotation(Line(points = {{7, 44.35}, {7, 60}, {-80, 60}, {-80, -10}, {-100, -10}}, color = {191, 0, 0}));
  connect(Wall_Kitchen1.port_outside, thermKitchen) annotation(Line(points = {{64.3, -22}, {94, -22}, {94, 60}, {-80, 60}, {-80, -40}, {-100, -40}}, color = {191, 0, 0}));
  connect(Wall_Kitchen2.port_outside, thermKitchen) annotation(Line(points = {{77, -55.85}, {94, -55.85}, {94, 60}, {-80, 60}, {-80, -40}, {-100, -40}}, color = {191, 0, 0}));
  connect(Wall_Bedroom.port_outside, thermBedroom) annotation(Line(points = {{-60.35, -34}, {-80, -34}, {-80, -70}, {-100, -70}}, color = {191, 0, 0}));
  connect(Wall_Ceiling.port_outside, thermCeiling) annotation(Line(points={{106,
          -77.9},{106,-60},{134,-60},{134,-140},{-80,-140},{-80,-100},{-100,
          -100}},                                                                                                    color = {191, 0, 0}));
  connect(Wall_Floor.port_outside, thermFloor) annotation(Line(points={{106,
          -118.1},{106,-140},{-80,-140},{-80,-130},{-100,-130}},                                                                              color = {191, 0, 0}));
  connect(infiltrationRate.port_a, thermOutside) annotation(Line(points = {{-42, 73}, {-80, 73}, {-80, 90}, {-100, 90}}, color = {191, 0, 0}));
  connect(infiltrationRate.port_b, airload.port) annotation(Line(points = {{-16, 73}, {4, 73}, {4, 60}, {94, 60}, {94, 16}, {-36, 16}, {-36, -18}, {-11, -18}}, color = {191, 0, 0}));
  connect(outsideWall.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{8, -94}, {8, -84}, {-0.1, -84}, {-0.1, -77.4}}, color = {191, 0, 0}));
  connect(Wall_Bedroom.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{-46, -34}, {-36, -34}, {-36, -84}, {-0.1, -84}, {-0.1, -77.4}}, color = {191, 0, 0}));
  connect(Wall_Corridor.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{7, 30}, {7, 16}, {-36, 16}, {-36, -84}, {-0.1, -84}, {-0.1, -77.4}}, color = {191, 0, 0}));
  connect(Wall_Kitchen1.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{52, -22}, {40, -22}, {40, 16}, {-36, 16}, {-36, -84}, {-0.1, -84}, {-0.1, -77.4}}, color = {191, 0, 0}));
  connect(Wall_Kitchen2.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{77, -62}, {77, -84}, {-0.1, -84}, {-0.1, -77.4}}, color = {191, 0, 0}));
  connect(Wall_Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{106,-82},
          {106,-92},{76,-92},{76,-84},{-0.1,-84},{-0.1,-77.4}},                                                                                                    color = {191, 0, 0}));
  connect(Wall_Floor.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{106,
          -114},{106,-92},{76,-92},{76,-84},{-0.1,-84},{-0.1,-77.4}},                                                                                                    color = {191, 0, 0}));
  connect(thermStar_Demux.therm, ThermRoom) annotation(Line(points = {{-5.1, -57.9}, {-5.1, -42}, {-18, -42}}, color = {191, 0, 0}));
  connect(thermStar_Demux.star, StarRoom) annotation(Line(points = {{5.8, -57.6}, {5.8, -44}, {20, -44}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(airload.port, thermStar_Demux.therm) annotation(Line(points = {{-11, -18}, {-36, -18}, {-36, -57.9}, {-5.1, -57.9}}, color = {191, 0, 0}));
  connect(AirExchangePort, NaturalVentilation.InPort1) annotation(Line(points = {{-102, 20}, {-80, 20}, {-80, 60}, {4, 60}, {4, 72.68}, {17.4, 72.68}}, color = {0, 0, 127}));
  connect(thermOutside, NaturalVentilation.port_a) annotation(Line(points = {{-100, 90}, {-80, 90}, {-80, 60}, {4, 60}, {4, 81}, {16, 81}}, color = {191, 0, 0}));
  connect(airload.port, NaturalVentilation.port_b) annotation(Line(points = {{-11, -18}, {-36, -18}, {-36, 16}, {94, 16}, {94, 60}, {48, 60}, {48, 81}, {44, 81}}, color = {191, 0, 0}));
  connect(outsideWall.port_outside, thermOutside) annotation(Line(points = {{8, -116.55}, {8, -140}, {-80, -140}, {-80, 90}, {-100, 90}}, color = {191, 0, 0}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}}), graphics={  Polygon(points = {{-58, 62}, {-58, -118}, {104, -118}, {104, -58}, {42, -58}, {42, 62}, {-58, 62}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Forward), Text(extent = {{-44, -108}, {82, -58}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Forward, textString = "Bath"), Rectangle(extent = {{-30, -108}, {-8, -128}}, lineColor = {0, 0, 0}, fillColor = {85, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-28, -110}, {-10, -126}}, lineColor = {0, 0, 0}, fillColor = {170, 213, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Line(points = {{-24, -122}, {-14, -112}}, color = {255, 255, 255}, thickness = 1), Line(points = {{-20, -122}, {-14, -116}}, color = {255, 255, 255}, thickness = 1), Line(points = {{-24, -118}, {-18, -112}}, color = {255, 255, 255}, thickness = 1), Text(extent = {{-20, -118}, {30, -134}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "OW"), Rectangle(extent = {{20, 92}, {40, 62}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1, fillColor = {127, 0, 0},
            fillPattern =                                                                                                   FillPattern.Forward), Ellipse(extent = {{22, 80}, {24, 78}}, lineColor = {0, 0, 0}, pattern=LinePattern.None,
            lineThickness =                                                                                                   1,
            fillPattern =                                                                                                   FillPattern.Sphere, fillColor = {255, 255, 0}), Text(extent = {{36, 84}, {86, 68}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Corridor"), Rectangle(extent = {{-110, -120}, {-90, -140}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -90}, {-90, -110}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -60}, {-90, -80}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -30}, {-90, -50}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, 0}, {-90, -20}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, 68}, {-90, 12}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, 100}, {-90, 80}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5)}), Documentation(revisions = "<html>
 <ul>
 <li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
 <li><i>August 16, 2011</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for the bathroom.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The following figure presents the room&apos;s layout:</p>
 <p><img src=\"modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Bath.png\"
    alt=\"Room layout\"/></p>
 </html>"));
end Bathroom_VoWo;
