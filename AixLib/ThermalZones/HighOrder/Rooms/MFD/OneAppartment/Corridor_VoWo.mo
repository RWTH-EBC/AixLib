within AixLib.ThermalZones.HighOrder.Rooms.MFD.OneAppartment;
model Corridor_VoWo "Corridor from the VoWo appartment"
  import AixLib;
  ///////// construction parameters
  parameter Integer TMC = 1 "Thermal Mass Class" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1 "Heavy", choice = 2 "Medium", choice = 3 "Light", radioButtons = true));
  parameter Integer TIR = 4 "Thermal Insulation Regulation" annotation(Dialog(groupImage = "modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Corridor.png", group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1
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
  parameter Modelica.SIunits.Temperature T0_air = 290.15 "Air" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_Staircase = 288.15 "IWStaircase" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_IWKitchen = 295.15 "IWKitchen" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_IWBath = 297.15 "IWBath" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_IWBedroom = 295.15 "IWBedroom" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_IWLivingroom = 295.15
    "IWLivingroom"                                                               annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_IWChild = 295.15 "IWChild" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
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
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Children(
    T0=T0_IWChild,
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
        origin={46,24},
        extent={{-3.99999,-24},{3.99999,24}},
        rotation=270)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Kitchen2(
    T0=T0_IWKitchen,
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
        origin={52,-63},
        extent={{-5.00001,-30},{5.00001,30}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Bath(
    T0=T0_IWBath,
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
        origin={-20,-99},
        extent={{-3.00001,-18},{3.00001,18}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Kitchen1(
    T0=T0_IWKitchen,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWsimple,
    wall_length=0.6,
    wall_height=2.46,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={-2,-74},
        extent={{-2,-12},{2,12}},
        rotation=180)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Bedroom(
    T0=T0_IWBedroom,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWload,
    wall_length=1.96,
    wall_height=2.46,
    withWindow=false,
    withDoor=false)
    annotation (Placement(transformation(extent={{-66,-70},{-54,2}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Staircase(
    T0=T0_Staircase,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWload,
    wall_length=1.34,
    wall_height=2.46,
    withWindow=false,
    withDoor=true,
    U_door=30/31,
    eps_door=0.95,
    door_height=2) annotation (Placement(transformation(
        origin={109,-32},
        extent={{-3.00013,-22},{5.0002,22}},
        rotation=180)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Livingroom(
    T0=T0_IWLivingroom,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_IWload,
    wall_length=1.25,
    wall_height=2.46,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={-28,24},
        extent={{-3.99999,-24},{3.99999,24}},
        rotation=270)));
  AixLib.ThermalZones.HighOrder.Components.DryAir.Airload airload(V=room_V, T(
        start=T0_air))
    annotation (Placement(transformation(extent={{-12,-12},{-32,8}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Ceiling(
    T0=T0_CE,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_CE,
    wall_length=sqrt(5.73),
    wall_height=sqrt(5.73),
    ISOrientation=3,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={117,80},
        extent={{-2,-15},{2,15}},
        rotation=270)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Floor(
    T0=T0_FL,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_FL,
    wall_length=sqrt(5.73),
    wall_height=sqrt(5.73),
    ISOrientation=2,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={118,55},
        extent={{-2.99998,-16},{2.99998,16}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.DryAir.InfiltrationRate_DIN12831
    infiltrationRate(
    room_V=room_V,
    n50=n50,
    e=e,
    eps=eps) annotation (Placement(transformation(extent={{-44,60},{-18,86}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermStaircase annotation(Placement(transformation(extent = {{-112, 70}, {-92, 90}}), iconTransformation(extent = {{-112, 70}, {-92, 90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermKitchen annotation(Placement(transformation(extent = {{-112, 40}, {-92, 60}}), iconTransformation(extent = {{-112, 40}, {-92, 60}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermBath annotation(Placement(transformation(extent = {{-110, -50}, {-90, -30}}), iconTransformation(extent = {{-110, -50}, {-90, -30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermBedroom annotation(Placement(transformation(extent = {{-110, -80}, {-90, -60}}), iconTransformation(extent = {{-110, -80}, {-90, -60}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling annotation(Placement(transformation(extent = {{-110, -110}, {-90, -90}}), iconTransformation(extent = {{-110, -110}, {-90, -90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor annotation(Placement(transformation(extent = {{-110, -140}, {-90, -120}}), iconTransformation(extent = {{-110, -140}, {-90, -120}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermLivingroom annotation(Placement(transformation(extent = {{-112, 10}, {-92, 30}}), iconTransformation(extent = {{-112, 10}, {-92, 30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermChild annotation(Placement(transformation(extent = {{-112, -20}, {-92, 0}}), iconTransformation(extent = {{-112, -20}, {-92, 0}})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation = 90, origin = {46, -26})));
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
  parameter Modelica.SIunits.Volume room_V = 5.73 * 2.46;
equation
  connect(infiltrationRate.port_b, airload.port) annotation(Line(points = {{-18, 73}, {0, 73}, {0, -4}, {-13, -4}}, color = {191, 0, 0}));
  connect(Wall_Staircase.port_outside, thermStaircase) annotation(Line(points={{112.2,
          -32},{140,-32},{140,-130},{-80,-130},{-80,80},{-102,80}},                                                                                          color = {191, 0, 0}));
  connect(Wall_Kitchen2.port_outside, thermKitchen) annotation(Line(points={{52,
          -68.25},{52,-130},{-80,-130},{-80,50},{-102,50}},                                                                                  color = {191, 0, 0}));
  connect(infiltrationRate.port_a, thermStaircase) annotation(Line(points = {{-44, 73}, {-80, 73}, {-80, 80}, {-102, 80}}, color = {191, 0, 0}));
  connect(Wall_Kitchen1.port_outside, thermKitchen) annotation(Line(points = {{0.1, -74}, {20, -74}, {20, -130}, {-80, -130}, {-80, 50}, {-102, 50}}, color = {191, 0, 0}));
  connect(Wall_Bath.port_outside, thermBath) annotation(Line(points={{-20,
          -102.15},{-20,-130},{-80,-130},{-80,-40},{-100,-40}},                                                                            color = {191, 0, 0}));
  connect(Wall_Bedroom.port_outside, thermBedroom) annotation(Line(points = {{-66.3, -34}, {-80, -34}, {-80, -70}, {-100, -70}}, color = {191, 0, 0}));
  connect(Wall_Ceiling.port_outside, thermCeiling) annotation(Line(points = {{117, 82.1}, {117, 96}, {140, 96}, {140, -130}, {-80, -130}, {-80, -100}, {-100, -100}}, color = {191, 0, 0}));
  connect(Wall_Floor.port_outside, thermFloor) annotation(Line(points={{118,
          51.85},{118,36},{140,36},{140,-130},{-100,-130}},                                                                              color = {191, 0, 0}));
  connect(Wall_Livingroom.port_outside, thermLivingroom) annotation(Line(points={{-28,
          28.2},{-28,52},{-80,52},{-80,20},{-102,20}},                                                                                        color = {191, 0, 0}));
  connect(Wall_Children.port_outside, thermChild) annotation(Line(points={{46,28.2},
          {46,52},{-80,52},{-80,-10},{-102,-10}},                                                                                      color = {191, 0, 0}));
  connect(Wall_Kitchen2.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{52,-58},
          {52,-44.0875},{45.9,-44.0875},{45.9,-35.4}},                                                                                                    color = {191, 0, 0}));
  connect(Wall_Staircase.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{104,-32},
          {94,-32},{94,-44},{45.9,-44},{45.9,-35.4}},                                                                                                    color = {191, 0, 0}));
  connect(Wall_Kitchen1.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{-4, -74}, {-14, -74}, {-14, -44}, {45.9, -44}, {45.9, -35.4}}, color = {191, 0, 0}));
  connect(Wall_Bath.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{-20,-96},
          {-20,-80},{-14,-80},{-14,-44},{45.9,-44},{45.9,-35.4}},                                                                                                    color = {191, 0, 0}));
  connect(Wall_Bedroom.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{-54, -34}, {-40, -34}, {-40, -80}, {-14, -80}, {-14, -44}, {45.9, -44}, {45.9, -35.4}}, color = {191, 0, 0}));
  connect(Wall_Livingroom.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{-28,20},
          {-28,12},{-40,12},{-40,-80},{-14,-80},{-14,-44},{45.9,-44},{45.9,
          -35.4}},                                                                                                    color = {191, 0, 0}));
  connect(Wall_Children.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{46,20},
          {46,10},{94,10},{94,-44},{45.9,-44},{45.9,-35.4}},                                                                                                    color = {191, 0, 0}));
  connect(Wall_Floor.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{118,58},
          {118,64},{94,64},{94,-44},{45.9,-44},{45.9,-35.4}},                                                                                                    color = {191, 0, 0}));
  connect(Wall_Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{117, 78}, {117, 64}, {94, 64}, {94, -44}, {45.9, -44}, {45.9, -35.4}}, color = {191, 0, 0}));
  connect(airload.port, thermStar_Demux.therm) annotation(Line(points = {{-13, -4}, {40.9, -4}, {40.9, -15.9}}, color = {191, 0, 0}));
  annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}}), graphics={  Polygon(points = {{-60, 60}, {120, 60}, {120, -60}, {20, -60}, {20, -100}, {-60, -100}, {-60, -18}, {-60, 60}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Forward), Text(extent = {{-26, 6}, {82, -26}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0},
            fillPattern =                                                                                                   FillPattern.Forward, textString = "Corridor"), Rectangle(extent = {{-110, -120}, {-90, -140}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -90}, {-90, -110}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -60}, {-90, -80}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -30}, {-90, -50}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-112, 60}, {-92, 40}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-112, 90}, {-92, 70}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{108, 12}, {128, -18}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1, fillColor = {127, 0, 0},
            fillPattern =                                                                                                   FillPattern.Forward), Ellipse(extent = {{110, 0}, {112, -2}}, lineColor = {0, 0, 0}, pattern=LinePattern.None,
            lineThickness =                                                                                                   1,
            fillPattern =                                                                                                   FillPattern.Sphere, fillColor = {255, 255, 0}), Text(extent = {{78, 38}, {164, 18}}, lineColor = {0, 0, 255}, textString = "Staircase"), Rectangle(extent = {{-112, 0}, {-92, -20}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Rectangle(extent = {{-112, 30}, {-92, 10}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5)}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}}), graphics), Documentation(revisions = "<html>
 <ul>
 <li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
 <li><i>August 16, 2011</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for the corridor.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The following figure presents the room&apos;s layout:</p>
 <p><img src=\"modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Corridor.png\"
    alt=\"Room layout\"/></p>
 </html>"));
end Corridor_VoWo;
