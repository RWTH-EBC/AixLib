within AixLib.ThermalZones.HighOrder.Rooms.MFD.OneAppartment;
model Kitchen_VoWo "Kitchen from the VoWo appartment"
  import AixLib;
  ///////// construction parameters
  parameter Integer TMC = 1 "Thermal Mass Class" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1 "Heavy", choice = 2 "Medium", choice = 3 "Light", radioButtons = true));
  parameter Integer TIR = 4 "Thermal Insulation Regulation" annotation(Dialog(groupImage = "modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Kitchen.png", group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1
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
  parameter Modelica.SIunits.Temperature T0_IWBath = 297.15 "IWBathroom" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
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
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Corridor1(
    T0=T0_IWCorridor,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWsimple,
    wall_length=2.2,
    wall_height=2.46,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={-3,30},
        extent={{-8,-51},{8,51}},
        rotation=270)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Bath1(
    T0=T0_IWBath,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWsimple,
    wall_length=3.28,
    wall_height=2.46,
    withWindow=false,
    withDoor=false)
    annotation (Placement(transformation(extent={{-68,-50},{-62,-12}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Staircase(
    T0=T0_IWStraicase,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWload,
    wall_length=3.94,
    wall_height=2.46,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={45,-29},
        extent={{-7,-49},{7,49}},
        rotation=180)));
  AixLib.ThermalZones.HighOrder.Components.DryAir.Airload airload(V=room_V, T(
        start=T0_air))
    annotation (Placement(transformation(extent={{-36,-16},{-16,4}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Bath2(
    T0=T0_IWBath,
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
        origin={-46,-75},
        extent={{-2.99998,-16},{2.99998,16}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outsideWall(
    wall_length=1.8,
    wall_height=2.46,
    windowarea=0.75,
    T0=T0_OW,
    solar_absorptance=solar_absorptance_OW,
    withWindow=true,
    withDoor=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_OW,
    WindowType=Type_Win) annotation (Placement(transformation(
        origin={5,-99},
        extent={{-7,-45},{7,45}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Corridor2(
    T0=T0_IWCorridor,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWsimple,
    wall_length=0.6,
    wall_height=2.46,
    withWindow=false,
    withDoor=false)
    annotation (Placement(transformation(extent={{-68,-2},{-64,24}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Ceiling(
    T0=T0_CE,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_CE,
    wall_length=sqrt(8.35),
    wall_height=sqrt(8.35),
    ISOrientation=3,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={80,-72},
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
    wall_length=sqrt(8.35),
    wall_height=sqrt(8.35),
    ISOrientation=2,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={80,-100},
        extent={{-1.99984,-10},{1.99983,10}},
        rotation=90)));
  Utilities.Interfaces.SolarRad_in SolarRadiation_NW annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-20, -150})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation(Placement(transformation(extent = {{-130, 56}, {-90, 96}}), iconTransformation(extent = {{-108, 52}, {-90, 70}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation(Placement(transformation(extent = {{-130, 28}, {-90, 68}}), iconTransformation(extent = {{-108, 20}, {-90, 38}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside annotation(Placement(transformation(extent = {{-108, 80}, {-88, 100}}), iconTransformation(extent = {{-108, 80}, {-88, 100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor annotation(Placement(transformation(extent = {{-110, -20}, {-90, 0}}), iconTransformation(extent = {{-110, -20}, {-90, 0}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermStaircase annotation(Placement(transformation(extent = {{-110, -60}, {-90, -40}}), iconTransformation(extent = {{-110, -60}, {-90, -40}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermBath annotation(Placement(transformation(extent = {{-110, -100}, {-90, -80}}), iconTransformation(extent = {{-110, -100}, {-90, -80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling annotation(Placement(transformation(extent = {{-110, -140}, {-90, -120}}), iconTransformation(extent = {{-110, -140}, {-90, -120}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor annotation(Placement(transformation(extent = {{-70, -160}, {-50, -140}}), iconTransformation(extent = {{-70, -160}, {-50, -140}})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.InfiltrationRate_DIN12831
    infiltrationRate(
    room_V=room_V,
    n50=n50,
    e=e,
    eps=eps) annotation (Placement(transformation(extent={{-42,72},{-18,96}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermRoom annotation(Placement(transformation(extent = {{-2, -18}, {18, 2}})));
  Utilities.Interfaces.Star StarRoom annotation(Placement(transformation(extent = {{-4, -48}, {16, -28}})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation(Placement(transformation(extent = {{10, -8}, {-10, 8}}, rotation = 180, origin = {-30, -40})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange
    NaturalVentilation(V=room_V)
    annotation (Placement(transformation(extent={{-2,72},{22,96}})));
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
  parameter Modelica.SIunits.Volume room_V = 8.35 * 2.46;
equation
  connect(outsideWall.SolarRadiationPort, SolarRadiation_NW) annotation(Line(points = {{-36.25, -108.1}, {-36.25, -120}, {-20, -120}, {-20, -150}}, color = {255, 128, 0}));
  connect(outsideWall.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{-28, -106.35}, {-28, -120}, {-80, -120}, {-80, 48}, {-110, 48}}, color = {0, 0, 127}));
  connect(Wall_Corridor1.port_outside, thermCorridor) annotation(Line(points = {{-3, 38.4}, {-3, 60}, {-80, 60}, {-80, -10}, {-100, -10}}, color = {191, 0, 0}));
  connect(Wall_Corridor2.port_outside, thermCorridor) annotation(Line(points = {{-68.1, 11}, {-80, 11}, {-80, -10}, {-100, -10}}, color = {191, 0, 0}));
  connect(Wall_Staircase.port_outside, thermStaircase) annotation(Line(points = {{52.35, -29}, {100, -29}, {100, -120}, {-80, -120}, {-80, -50}, {-100, -50}}, color = {191, 0, 0}));
  connect(Wall_Bath2.port_outside, thermBath) annotation(Line(points={{-46,
          -78.15},{-46,-90},{-100,-90}},                                                                         color = {191, 0, 0}));
  connect(Wall_Bath1.port_outside, thermBath) annotation(Line(points = {{-68.15, -31}, {-80, -31}, {-80, -90}, {-100, -90}}, color = {191, 0, 0}));
  connect(Wall_Ceiling.port_outside, thermCeiling) annotation(Line(points={{80,
          -69.9},{80,-48},{100,-48},{100,-130},{-100,-130}},                                                                                 color = {191, 0, 0}));
  connect(Wall_Floor.port_outside, thermFloor) annotation(Line(points={{80,
          -102.1},{80,-120},{-60,-120},{-60,-150}},                                                                           color = {191, 0, 0}));
  connect(infiltrationRate.port_b, airload.port) annotation(Line(points = {{-18, 84}, {-12, 84}, {-12, 60}, {-56, 60}, {-56, 10}, {-40, 10}, {-40, -8}, {-35, -8}}, color = {191, 0, 0}));
  connect(thermCeiling, thermCeiling) annotation(Line(points = {{-100, -130}, {-100, -130}}, color = {191, 0, 0}));
  connect(infiltrationRate.port_a, thermOutside) annotation(Line(points = {{-42, 84}, {-98, 84}, {-98, 90}}, color = {191, 0, 0}));
  connect(thermStar_Demux.star, StarRoom) annotation(Line(points = {{-19.6, -45.8}, {-12, -45.8}, {-12, -38}, {6, -38}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(airload.port, thermStar_Demux.therm) annotation(Line(points = {{-35, -8}, {-40, -8}, {-40, -20}, {-12, -20}, {-12, -34.9}, {-19.9, -34.9}}, color = {191, 0, 0}));
  connect(Wall_Bath1.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{-62, -31}, {-52, -31}, {-52, -39.9}, {-39.4, -39.9}}, color = {191, 0, 0}));
  connect(Wall_Corridor2.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{-64, 11}, {-52, 11}, {-52, -40}, {-46, -40}, {-39.4, -39.9}}, color = {191, 0, 0}));
  connect(Wall_Corridor1.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{-3, 22}, {-3, 10}, {-52, 10}, {-52, -39.9}, {-39.4, -39.9}}, color = {191, 0, 0}));
  connect(Wall_Bath2.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{-46,-72},
          {-46,-60},{-52,-60},{-52,-39.9},{-39.4,-39.9}},                                                                                                    color = {191, 0, 0}));
  connect(outsideWall.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{5, -92}, {5, -60}, {-52, -60}, {-52, -39.9}, {-39.4, -39.9}}, color = {191, 0, 0}));
  connect(Wall_Staircase.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{38, -29}, {28, -29}, {28, -60}, {-52, -60}, {-52, -39.9}, {-39.4, -39.9}}, color = {191, 0, 0}));
  connect(Wall_Floor.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{80,
          -98.0002},{80,-86},{28,-86},{28,-60},{-52,-60},{-52,-39.9},{-39.4,
          -39.9}},                                                                                                    color = {191, 0, 0}));
  connect(Wall_Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{80,-74},
          {80,-86},{28,-86},{28,-60},{-52,-60},{-52,-39.9},{-39.4,-39.9}},                                                                                                    color = {191, 0, 0}));
  connect(NaturalVentilation.InPort1, AirExchangePort) annotation(Line(points = {{-0.8, 76.32}, {-12, 76.32}, {-12, 60}, {-80, 60}, {-80, 76}, {-110, 76}}, color = {0, 0, 127}));
  connect(NaturalVentilation.port_a, thermOutside) annotation(Line(points = {{-2, 84}, {-12, 84}, {-12, 60}, {-98, 60}, {-98, 90}}, color = {191, 0, 0}));
  connect(NaturalVentilation.port_b, airload.port) annotation(Line(points = {{22, 84}, {24, 84}, {24, 60}, {-56, 60}, {-56, 10}, {-40, 10}, {-40, -8}, {-35, -8}}, color = {191, 0, 0}));
  connect(outsideWall.port_outside, thermOutside) annotation(Line(points = {{5, -106.35}, {5, -120}, {-80, -120}, {-80, 60}, {-98, 60}, {-98, 90}}, color = {191, 0, 0}));
  connect(ThermRoom, airload.port) annotation(Line(points = {{8, -8}, {-10, -8}, {-10, -20}, {-40, -20}, {-40, -8}, {-35, -8}}, color = {191, 0, 0}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}}), graphics={  Polygon(points = {{-60, 58}, {-60, -62}, {-18, -62}, {-18, -122}, {100, -122}, {100, 58}, {-60, 58}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Forward), Text(extent = {{-32, 38}, {84, 4}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0},
            fillPattern =                                                                                                   FillPattern.Forward, textString = "Kitchen"), Rectangle(extent = {{-18, -114}, {4, -134}}, lineColor = {0, 0, 0}, fillColor = {85, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-16, -116}, {2, -132}}, lineColor = {0, 0, 0}, fillColor = {170, 213, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Line(points = {{-12, -128}, {-2, -118}}, color = {255, 255, 255}, thickness = 1), Line(points = {{-8, -128}, {-2, -122}}, color = {255, 255, 255}, thickness = 1), Line(points = {{-12, -124}, {-6, -118}}, color = {255, 255, 255}, thickness = 1), Text(extent = {{-6, -122}, {44, -138}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "OW"), Text(extent = {{12, 76}, {72, 60}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Corridor"), Rectangle(extent = {{72, 82}, {92, 52}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1, fillColor = {127, 0, 0},
            fillPattern =                                                                                                   FillPattern.Forward), Ellipse(extent = {{74, 70}, {76, 68}}, lineColor = {0, 0, 0}, pattern=LinePattern.None,
            lineThickness =                                                                                                   1,
            fillPattern =                                                                                                   FillPattern.Sphere, fillColor = {255, 255, 0}), Rectangle(extent = {{-70, -140}, {-50, -160}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -120}, {-90, -140}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -80}, {-90, -100}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -40}, {-90, -60}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, 0}, {-90, -20}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-108, 72}, {-88, 18}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-108, 100}, {-88, 80}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5)}), Documentation(revisions = "<html>
 <ul>
 <li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
 <li><i>August 16, 2011</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for the kitchen.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The following figure presents the room&apos;s layout:</p>
 <p><img src=\"modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Kitchen.png\"
    alt=\"Room layout\"/></p>
 </html>"));
end Kitchen_VoWo;
