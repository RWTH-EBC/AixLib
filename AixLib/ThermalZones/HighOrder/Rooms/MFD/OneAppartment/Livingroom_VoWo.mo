within AixLib.ThermalZones.HighOrder.Rooms.MFD.OneAppartment;
model Livingroom_VoWo "Livingroom from the VoWo appartment"
  import AixLib;
  ///////// construction parameters
  parameter Integer TMC = 1 "Thermal Mass Class" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1 "Heavy", choice = 2 "Medium", choice = 3 "Light", radioButtons = true));
  parameter Integer TIR = 4 "Thermal Insulation Regulation" annotation(Dialog(groupImage = "modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Livingroom.png", group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1
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
  parameter Modelica.SIunits.Temperature T0_IWChild = 295.15 "IWChild" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_IWCorridor = 290.15 "IWCorridor" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_IWBedroom = 295.15 "IWBedroom" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
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
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Neighbour(
    T0=T0_IWNeighbour,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWNeigbour,
    wall_length=4.2,
    wall_height=2.46,
    withWindow=false,
    withDoor=false)
    annotation (Placement(transformation(extent={{-80,-24},{-68,54}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Corridor(
    T0=T0_IWCorridor,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWload,
    wall_length=1.54,
    wall_height=2.46,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={19,-43},
        extent={{-4.99999,-31},{4.99998,31}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Children(
    T0=T0_IWChild,
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
        origin={75,14.9756},
        extent={{-7.00003,-39.0244},{7.00003,40.9756}},
        rotation=180)));
  AixLib.ThermalZones.HighOrder.Components.DryAir.Airload airload(V=room_V, T(
        start=T0_air))
    annotation (Placement(transformation(extent={{-28,0},{-48,20}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outsideWall(
    wall_length=4.645,
    wall_height=2.46,
    windowarea=3.99,
    door_height=0.1,
    door_width=0.1,
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
        origin={-14.9999,71},
        extent={{-13,-61.0001},{11,82.9999}},
        rotation=270)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Bedroom(
    T0=T0_IWBedroom,
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
        origin={-45,-44},
        extent={{-3.99999,-25},{3.99998,25}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Ceiling(
    T0=T0_CE,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_CE,
    wall_length=4.2,
    wall_height=4.645,
    Model=1,
    ISOrientation=3,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={104,70},
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
    wall_length=4.2,
    wall_height=4.645,
    ISOrientation=2,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={104,32},
        extent={{-1.99998,-10},{1.99998,10}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermRoom annotation(Placement(transformation(extent = {{-12, 4}, {8, 24}}), iconTransformation(extent = {{-12, 4}, {8, 24}})));
  Utilities.Interfaces.Star StarInside1 annotation(Placement(transformation(extent = {{16, 4}, {36, 24}}), iconTransformation(extent = {{16, 4}, {36, 24}})));
  Utilities.Interfaces.SolarRad_in SolarRadiation_SE annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-66, 134})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside annotation(Placement(transformation(extent = {{-160, 120}, {-140, 140}}), iconTransformation(extent = {{-160, 120}, {-140, 140}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation(Placement(transformation(extent = {{-180, 50}, {-140, 90}}), iconTransformation(extent = {{-160, 70}, {-140, 90}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation(Placement(transformation(extent = {{-180, 10}, {-140, 50}}), iconTransformation(extent = {{-160, 30}, {-140, 50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling annotation(Placement(transformation(extent = {{-160, -120}, {-140, -100}}), iconTransformation(extent = {{-160, -120}, {-140, -100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor annotation(Placement(transformation(extent = {{-160, -150}, {-140, -130}}), iconTransformation(extent = {{-160, -150}, {-140, -130}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermChildren annotation(Placement(transformation(extent = {{-160, -90}, {-140, -70}}), iconTransformation(extent = {{-160, -90}, {-140, -70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor annotation(Placement(transformation(extent = {{-160, -60}, {-140, -40}}), iconTransformation(extent = {{-160, -60}, {-140, -40}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermBedroom annotation(Placement(transformation(extent = {{-160, -30}, {-140, -10}}), iconTransformation(extent = {{-160, -30}, {-140, -10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermNeighbour annotation(Placement(transformation(extent = {{-160, 0}, {-140, 20}}), iconTransformation(extent = {{-160, 0}, {-140, 20}})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.InfiltrationRate_DIN12831
    infiltrationRate(
    room_V=room_V,
    n50=n50,
    e=e,
    eps=eps)
    annotation (Placement(transformation(extent={{-72,-84},{-46,-58}})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation = 180, origin = {24, -14})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange
    NaturalVentilation(V=room_V)
    annotation (Placement(transformation(extent={{-72,-112},{-46,-86}})));
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
  parameter Modelica.SIunits.Volume room_V = 4.20 * 4.645 * 2.46;
equation
  connect(outsideWall.SolarRadiationPort, SolarRadiation_SE) annotation(Line(points = {{62, 87.6}, {62, 100}, {-66, 100}, {-66, 134}}, color = {255, 128, 0}));
  connect(outsideWall.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{48.8, 84.6}, {48.8, 100}, {-86, 100}, {-86, 30}, {-160, 30}}, color = {0, 0, 127}));
  connect(Wall_Ceiling.port_outside, thermCeiling) annotation(Line(points={{104,
          72.1},{104,84},{134,84},{134,-56},{-86,-56},{-86,-110},{-150,-110}},                                                                                      color = {191, 0, 0}));
  connect(Wall_Floor.port_outside, thermFloor) annotation(Line(points={{104,
          29.9},{104,4},{134,4},{134,-56},{-86,-56},{-86,-140},{-150,-140}},                                                                                  color = {191, 0, 0}));
  connect(Wall_Children.port_outside, thermChildren) annotation(Line(points={{82.35,
          14},{104,14},{104,4},{134,4},{134,-80},{-150,-80}},                                                                                        color = {191, 0, 0}));
  connect(Wall_Corridor.port_outside, thermCorridor) annotation(Line(points={{19,
          -48.25},{19,-48.25},{19,-56},{-86,-56},{-86,-50},{-150,-50}},                                                                                     color = {191, 0, 0}));
  connect(Wall_Bedroom.port_outside, thermBedroom) annotation(Line(points={{-45,
          -48.2},{-45,-56},{-86,-56},{-86,-20},{-150,-20}},                                                                                  color = {191, 0, 0}));
  connect(Wall_Neighbour.port_outside, thermNeighbour) annotation(Line(points = {{-80.3, 15}, {-86, 15}, {-86, 10}, {-150, 10}}, color = {191, 0, 0}));
  connect(infiltrationRate.port_a, thermOutside) annotation(Line(points = {{-72, -71}, {-86, -71}, {-86, 130}, {-150, 130}}, color = {191, 0, 0}));
  connect(ThermRoom, ThermRoom) annotation(Line(points = {{-2, 14}, {-7, 14}, {-7, 14}, {-2, 14}}, color = {191, 0, 0}));
  connect(thermStar_Demux.star, StarInside1) annotation(Line(points = {{13.6, -8.2}, {13.6, 3.2}, {26, 3.2}, {26, 14}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(Wall_Children.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{68,14},
          {54,14},{54,-32},{33.4,-32},{33.4,-14.1}},                                                                                                    color = {191, 0, 0}));
  connect(Wall_Corridor.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{19,-38},
          {19,-32},{33.4,-32},{33.4,-14.1}},                                                                                                    color = {191, 0, 0}));
  connect(Wall_Bedroom.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{-45,-40},
          {-45,-32},{33.4,-32},{33.4,-14.1}},                                                                                                    color = {191, 0, 0}));
  connect(Wall_Neighbour.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{-68, 15}, {-56, 15}, {-56, -32}, {33.4, -32}, {33.4, -14.1}}, color = {191, 0, 0}));
  connect(outsideWall.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{-4, 60}, {-4, 48}, {-56, 48}, {-56, -32}, {33.4, -32}, {33.4, -14.1}}, color = {191, 0, 0}));
  connect(Wall_Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{104,68},
          {104,58},{54,58},{54,-32},{33.4,-32},{33.4,-14.1}},                                                                                                    color = {191, 0, 0}));
  connect(Wall_Floor.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{104,34},
          {104,58},{54,58},{54,-32},{33.4,-32},{33.4,-14.1}},                                                                                                    color = {191, 0, 0}));
  connect(thermStar_Demux.therm, ThermRoom) annotation(Line(points = {{13.9, -19.1}, {13.9, -20}, {-20, -20}, {-20, 14}, {-2, 14}}, color = {191, 0, 0}));
  connect(airload.port, infiltrationRate.port_b) annotation(Line(points = {{-29, 8}, {-20, 8}, {-20, -71}, {-46, -71}}, color = {191, 0, 0}));
  connect(NaturalVentilation.InPort1, AirExchangePort) annotation(Line(points = {{-70.7, -107.32}, {-86, -107.32}, {-86, 70}, {-160, 70}}, color = {0, 0, 127}));
  connect(NaturalVentilation.port_a, thermOutside) annotation(Line(points = {{-72, -99}, {-86, -99}, {-86, 130}, {-150, 130}}, color = {191, 0, 0}));
  connect(airload.port, ThermRoom) annotation(Line(points = {{-29, 8}, {-20, 8}, {-20, 14}, {-2, 14}}, color = {191, 0, 0}));
  connect(NaturalVentilation.port_b, airload.port) annotation(Line(points = {{-46, -99}, {-20, -99}, {-20, 8}, {-29, 8}}, color = {191, 0, 0}));
  connect(outsideWall.port_outside, thermOutside) annotation(Line(points = {{-4, 84.6}, {-4, 100}, {-86, 100}, {-86, 130}, {-150, 130}}, color = {191, 0, 0}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-170, -150}, {170, 150}}), graphics), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-170, -150}, {170, 150}}), graphics={  Rectangle(extent = {{-62, 60}, {112, -92}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Forward), Rectangle(extent = {{38, 72}, {60, 52}}, lineColor = {0, 0, 0}, fillColor = {85, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{40, 70}, {58, 54}}, lineColor = {0, 0, 0}, fillColor = {170, 213, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-56, -14}, {104, -32}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0},
            fillPattern =                                                                                                   FillPattern.Forward, textString = "Livingroom"), Text(extent = {{42, -98}, {92, -114}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Corridor"), Rectangle(extent = {{92, -88}, {112, -118}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1, fillColor = {127, 0, 0},
            fillPattern =                                                                                                   FillPattern.Forward), Ellipse(extent = {{94, -100}, {96, -102}}, lineColor = {0, 0, 0}, pattern=LinePattern.None,
            lineThickness =                                                                                                   1,
            fillPattern =                                                                                                   FillPattern.Sphere, fillColor = {255, 255, 0}), Rectangle(extent = {{-62, 84}, {-42, 54}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1, fillColor = {127, 0, 0},
            fillPattern =                                                                                                   FillPattern.Forward), Ellipse(extent = {{-44, 68}, {-46, 66}}, lineColor = {0, 0, 0}, pattern = LinePattern.Solid,
            lineThickness =                                                                                                   1,
            fillPattern =                                                                                                   FillPattern.Sphere, fillColor = {255, 255, 0}), Rectangle(extent = {{-160, -130}, {-140, -150}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-160, -100}, {-140, -120}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-160, -70}, {-140, -90}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-160, -10}, {-140, -30}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-160, 20}, {-140, 0}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-160, 140}, {-140, 120}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-160, -40}, {-140, -60}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-160, 90}, {-140, 28}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Line(points = {{44, 62}, {50, 68}}, color = {255, 255, 255}, thickness = 1), Line(points = {{44, 58}, {54, 68}}, color = {255, 255, 255}, thickness = 1), Line(points = {{48, 58}, {54, 64}}, color = {255, 255, 255}, thickness = 1), Text(extent = {{50, 78}, {100, 62}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "OW")}), Documentation(revisions = "<html>
 <ul>
 <li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
 <li><i>August 16, 2011</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for the livingroom. </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The following figure presents the room&apos;s layout:</p>
 <p><img src=\"modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Livingroom.png\"
    alt=\"Room layout\"/></p>
 </html>"));
end Livingroom_VoWo;
