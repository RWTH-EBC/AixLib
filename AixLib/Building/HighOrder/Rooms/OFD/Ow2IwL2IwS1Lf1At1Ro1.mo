within AixLib.Building.HighOrder.Rooms.OFD;
model Ow2IwL2IwS1Lf1At1Ro1
  "2 outer walls, 2 inner walls load, 1 inner wall simple, 1 floor towards lower floor, 1 ceiling towards attic, 1 roof towards outside"
  import AixLib;
  ///////// construction parameters
  parameter Integer TMC=1 "Thermal Mass Class" annotation (Dialog(
      group="Construction parameters",
      compact=true,
      descriptionLabel=true), choices(
      choice=1 "Heavy",
      choice=2 "Medium",
      choice=3 "Light",
      radioButtons=true));
  parameter Integer TIR=1 "Thermal Insulation Regulation" annotation (Dialog(
      groupImage="modelica://AixLib/Resources/Images/Building/HighOrder/OW2_2IWl_1IWs_1Pa_1At1Ro.png",
      group="Construction parameters",
      compact=true,
      descriptionLabel=true), choices(
      choice=1 "EnEV_2009",
      choice=2 "EnEV_2002",
      choice=3 "WSchV_1995",
      choice=4 "WSchV_1984",
      radioButtons=true));

  parameter Boolean withFloorHeating=false
    "If true, that floor has different connectors" annotation (Dialog(group="Construction parameters"),
      choices(checkBox=true));
  parameter Modelica.SIunits.Temperature T0_air=295.11 "Air"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_OW1=295.15 "OW1"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_OW2=295.15 "OW2"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_IW1a=295.15 "IW1a"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_IW1b=295.15 "IW1b"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_IW2=295.15 "IW2"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_CE=295.10 "Ceiling"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_RO=295.15 "Roof"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_FL=295.12 "Floor"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  //////////room geometry
  parameter Modelica.SIunits.Length room_length=2 "length "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length room_lengthb=2 "length_b "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length room_width_long=2 "w1 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length room_width_short=2 "w2 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Height room_height_long=2 "h1 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Height room_height_short=2 "h2 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length roof_width=2 "wRO"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  // Outer walls properties
  parameter Real solar_absorptance_OW=0.25 "Solar absoptance outer walls "
    annotation (Dialog(group="Outer wall properties", descriptionLabel=true));
  parameter Real solar_absorptance_RO=0.25 "Solar absoptance roof "
    annotation (Dialog(group="Outer wall properties", descriptionLabel=true));
  parameter Integer ModelConvOW=1 "Heat Convection Model" annotation (Dialog(
      group="Outer wall properties",
      compact=true,
      descriptionLabel=true), choices(
      choice=1 "DIN 6946",
      choice=2 "ASHRAE Fundamentals",
      choice=3 "Custom alpha",
      radioButtons=true));
  // Windows and Doors
  parameter Boolean withWindow2=true "Window 2" annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true), choices(checkBox=true));
  parameter Modelica.SIunits.Area windowarea_OW2=0 "Window area " annotation (
      Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      enable=withWindow2));
  parameter Boolean withWindow3=true "Window 3 " annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true), choices(checkBox=true));
  parameter Modelica.SIunits.Area windowarea_RO=0 "Window area" annotation (
      Dialog(
      group="Windows and Doors",
      naturalWidth=10,
      descriptionLabel=true,
      enable=withWindow3));
  parameter Boolean withDoor2=true "Door 2" annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true), choices(checkBox=true));
  parameter Modelica.SIunits.Length door_width_OD2=0 "width " annotation (
      Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true,
      enable=withDoor2));
  parameter Modelica.SIunits.Length door_height_OD2=0 "height " annotation (
      Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      enable=withDoor2));
  // Sunblind
  parameter Boolean use_sunblind = false
    "Will sunblind become active automatically?"
    annotation(Dialog(group = "Sunblind"));
  parameter Real ratioSunblind(min=0.0, max=1.0) = 0.8
    "Sunblind factor"
    annotation(Dialog(group = "Sunblind", enable=use_sunblind));
  parameter Modelica.SIunits.Irradiance solIrrThreshold(min=0.0) = 350
    "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
    annotation(Dialog(group = "Sunblind", enable=use_sunblind));
  parameter Modelica.SIunits.Temperature TOutAirLimit = 293.15
    "Temperature at which sunblind closes (see also solIrrThreshold)"
    annotation(Dialog(group = "Sunblind", enable=use_sunblind));
  // Dynamic Ventilation
  parameter Boolean withDynamicVentilation=false "Dynamic ventilation"
    annotation (Dialog(group="Dynamic ventilation", descriptionLabel=true),
      choices(checkBox=true));
  parameter Modelica.SIunits.Temperature HeatingLimit=288.15
    "Outside temperature at which the heating activates" annotation (Dialog(
      group="Dynamic ventilation",
      descriptionLabel=true,
      enable=if withDynamicVentilation then true else false));
  parameter Real Max_VR=10 "Maximal ventilation rate" annotation (Dialog(
      group="Dynamic ventilation",
      descriptionLabel=true,
      enable=if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.TemperatureDifference Diff_toTempset=2
    "Difference to set temperature" annotation (Dialog(
      group="Dynamic ventilation",
      descriptionLabel=true,
      enable=if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.Temperature Tset=295.15 "Tset" annotation (Dialog(
      group="Dynamic ventilation",
      descriptionLabel=true,
      enable=if withDynamicVentilation then true else false));
  //Door properties
  AixLib.Building.Components.Walls.Wall outside_wall1(
    solar_absorptance=solar_absorptance_OW,
    T0=T0_OW1,
    wall_length=room_length,
    wall_height=room_height_short,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    windowarea=0,
    withDoor=false,
    door_height=0,
    door_width=0,
    WallType=Type_OW)
    annotation (Placement(transformation(extent={{-68,-18},{-58,38}})));
  AixLib.Building.Components.Walls.Wall outside_wall2(
    solar_absorptance=solar_absorptance_OW,
    windowarea=windowarea_OW2,
    T0=T0_OW2,
    door_height=door_height_OD2,
    door_width=door_width_OD2,
    withWindow=withWindow2,
    withDoor=withDoor2,
    wall_length=room_width_long,
    wall_height=0.5*(room_height_long + room_height_short + room_width_short/
        room_width_long*(room_height_long - room_height_short)),
    WallType=Type_OW,
    WindowType=Type_Win,
    final withSunblind=use_sunblind,
    final Blinding=ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    U_door=U_door_OD2,
    eps_door=eps_door_OD2) annotation (Placement(transformation(
        origin={-25,58},
        extent={{-6,-33},{6,33}},
        rotation=270)));
  AixLib.Building.Components.Walls.Wall inside_wall1a(
    T0=T0_IW1a,
    outside=false,
    WallType=Type_IWload,
    wall_length=room_length - room_lengthb,
    wall_height=room_height_long,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false) annotation (Placement(transformation(
        origin={60,19},
        extent={{-2,-15},{2,15}},
        rotation=180)));
  AixLib.Building.Components.Walls.Wall inside_wall2(
    T0=T0_IW2,
    outside=false,
    WallType=Type_IWsimple,
    wall_length=room_width_long,
    wall_height=0.5*(room_height_long + room_height_short + room_width_short/
        room_width_long*(room_height_long - room_height_short)),
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false) annotation (Placement(transformation(
        origin={28,-60},
        extent={{-4.00002,-26},{4.00001,26}},
        rotation=90)));
  AixLib.Building.Components.DryAir.Airload airload(V=room_V, T(start=T0_air))
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  AixLib.Building.Components.Walls.Wall Ceiling(
    T0=T0_CE,
    outside=false,
    WallType=Type_CE,
    wall_length=room_length,
    wall_height=room_width_short,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false,
    ISOrientation=3) annotation (Placement(transformation(
        origin={28,60},
        extent={{1.99999,-10},{-1.99998,10}},
        rotation=90)));
  AixLib.Building.Components.Walls.Wall floor(
    T0=T0_FL,
    outside=false,
    WallType=Type_FL,
    wall_length=room_length,
    wall_height=room_width_long,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false,
    ISOrientation=2) if withFloorHeating == false annotation (Placement(
        transformation(
        origin={-24,-60},
        extent={{-1.99999,-10},{1.99999,10}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2
    annotation (Placement(transformation(extent={{20,-100},{40,-80}}),
        iconTransformation(extent={{20,-100},{40,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1a
    annotation (Placement(transformation(extent={{80,0},{100,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort
    annotation (Placement(transformation(extent={{-109.5,-60},{-89.5,-40}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1
    annotation (Placement(transformation(extent={{-109.5,20},{-89.5,40}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW2 annotation (Placement(
        transformation(
        origin={44.5,101},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
    annotation (Placement(transformation(extent={{80,40},{100,60}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom annotation (
      Placement(transformation(extent={{-30,10},{-10,30}}), iconTransformation(
          extent={{-30,10},{-10,30}})));
  Utilities.Interfaces.Star starRoom annotation (Placement(transformation(
          extent={{10,10},{30,30}}), iconTransformation(extent={{10,10},{30,30}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation (Placement(
        transformation(
        extent={{-13,-13},{13,13}},
        rotation=270,
        origin={-28,100}), iconTransformation(
        extent={{-10.5,-10.5},{10.5,10.5}},
        rotation=270,
        origin={-26.5,96.5})));
  AixLib.Building.Components.Walls.Wall roof(
    T0=T0_RO,
    solar_absorptance=solar_absorptance_RO,
    wall_length=room_length,
    withDoor=false,
    door_height=0,
    door_width=0,
    wall_height=roof_width,
    withWindow=withWindow3,
    final withSunblind=use_sunblind,
    final Blinding=ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    windowarea=windowarea_RO,
    WallType=Type_RO,
    WindowType=Type_Win) annotation (Placement(transformation(
        origin={59,59},
        extent={{-3.00001,-17},{3.00002,17}},
        rotation=270)));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_Roof annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={74,100})));
  AixLib.Building.Components.Walls.Wall inside_wall1b(
    T0=T0_IW1b,
    outside=false,
    WallType=Type_IWload,
    wall_length=room_lengthb,
    wall_height=room_height_long,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false) annotation (Placement(transformation(
        origin={60,-19},
        extent={{-2,-15},{2,15}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1b
    annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tair
    annotation (Placement(transformation(extent={{22,-20},{36,-6}})));
  AixLib.Building.Components.DryAir.InfiltrationRate_DIN12831 infiltrationRate(
    room_V=room_V,
    n50=n50,
    e=e,
    eps=eps) annotation (Placement(transformation(extent={{-72,42},{-54,50}})));
  AixLib.Building.Components.DryAir.DynamicVentilation dynamicVentilation(
    HeatingLimit=HeatingLimit,
    Max_VR=Max_VR,
    Diff_toTempset=Diff_toTempset,
    Tset=Tset) if withDynamicVentilation
    annotation (Placement(transformation(extent={{-74,-56},{-50,-44}})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation (
      Placement(transformation(
        extent={{-10,8},{10,-8}},
        rotation=90,
        origin={-20,-26})));
  AixLib.Building.Components.DryAir.VarAirExchange NaturalVentilation(V=room_V)
    annotation (Placement(transformation(extent={{-72,-40},{-52,-20}})));
  AixLib.Building.Components.Walls.BaseClasses.SimpleNLayer floor_FH(
    A=room_width_long*room_length,
    n=Type_FL.n,
    d=Type_FL.d,
    rho=Type_FL.rho,
    lambda=Type_FL.lambda,
    c=Type_FL.c,
    T0=T0_FL) if withFloorHeating
    "floor component if using Floor heating" annotation (Placement(
        transformation(
        origin={-30,-85},
        extent={{3.00007,16},{-3,-16}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor annotation (
      Placement(transformation(extent={{-16,-104},{4,-84}}), iconTransformation(
          extent={{-16,-104},{4,-84}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    thermFloorHeatingDownHeatFlow if                                 withFloorHeating
    "Thermal connector for heat flow of floor heating going downwards through the wall/floor/ceiling"
    annotation (Placement(transformation(extent={{-84,-86},{-70,-72}}),
        iconTransformation(extent={{-56,-92},{-36,-72}})));
protected
  parameter Real U_door_OD2=if TIR == 1 then 1.8 else 2.9 "U-value" annotation (
     Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true,
      enable=withDoor2));
  parameter Real eps_door_OD2=0.95 "eps" annotation (Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      enable=withDoor2));
  // Infiltration rate
  parameter Real n50(unit="h-1") = if TIR == 1 or TIR == 2 then 3 else if TIR ==
    3 then 4 else 6 "Air exchange rate at 50 Pa pressure difference"
    annotation (Dialog(tab="Infiltration"));
  parameter Real e=0.03 "Coefficient of windshield"
    annotation (Dialog(tab="Infiltration"));
  parameter Real eps=1.0 "Coefficient of height"
    annotation (Dialog(tab="Infiltration"));
  // Outer wall type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW=if TIR == 1
       then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S()
       else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M()
       else AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR == 2
       then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S()
       else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M()
       else AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR == 3
       then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S()
       else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M()
       else AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else if TMC == 1
       then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if TMC == 2
       then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M() else
      AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L()
    annotation (Dialog(tab="Types"));
  //Inner wall Types
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWsimple=if TIR ==
      1 then if TMC == 1 then
      AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half() else if TMC ==
      2 then AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() else
      AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_L_half() else if TIR ==
      2 then if TMC == 1 then
      AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_S_half() else if TMC ==
      2 then AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_M_half() else
      AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_L_half() else if TIR ==
      3 then if TMC == 1 then
      AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_S_half() else if
      TMC == 2 then
      AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_M_half() else
      AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_L_half() else if
      TMC == 1 then
      AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_S_half() else if
      TMC == 2 then
      AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_M_half() else
      AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_L_half()
    annotation (Dialog(tab="Types"));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload=if TIR == 1
       then if TMC == 1 then
      AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else if TMC ==
      2 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else
      AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else if TIR ==
      2 then if TMC == 1 then
      AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else if TMC ==
      2 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else
      AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else if TIR ==
      3 then if TMC == 1 then
      AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half() else if TMC ==
      2 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half() else
      AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half() else if TMC ==
      1 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half() else
      if TMC == 2 then
      AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half() else
      AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half()
    annotation (Dialog(tab="Types"));
  // Floor to lower floor type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=
  if withFloorHeating==true then AixLib.DataBase.Walls.Dummys.FloorForFloorHeating2Layers()
  else if TIR == 1
       then if TMC == 1 or TMC == 2 then
      AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf()
       else AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_L_upHalf()
       else if TIR == 2 then if TMC == 1 or TMC == 2 then
      AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_SM_upHalf()
       else AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf()
       else if TIR == 3 then if TMC == 1 or TMC == 2 then
      AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf()
       else
      AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_L_upHalf()
       else if TMC == 1 or TMC == 2 then
      AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf()
       else
      AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_L_upHalf()
    annotation (Dialog(tab="Types"));
  // Ceiling to attic type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE=
  if TIR == 1
       then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf()
       else if TIR == 2 then
      AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf()
       else if TIR == 3 then
      AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf()
       else
      AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf()
    annotation (Dialog(tab="Types"));
  // Saddle roof type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_RO=if TIR == 1
       then AixLib.DataBase.Walls.EnEV2009.Ceiling.ROsaddleRoom_EnEV2009_SML()
       else if TIR == 2 then
      AixLib.DataBase.Walls.EnEV2002.Ceiling.ROsaddleRoom_EnEV2002_SML() else
      if TIR == 3 then
      AixLib.DataBase.Walls.WSchV1995.Ceiling.ROsaddleRoom_WSchV1995_SML()
       else AixLib.DataBase.Walls.WSchV1984.Ceiling.ROsaddleRoom_WSchV1984_SML()
    annotation (Dialog(tab="Types"));
  //Window type
  parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
    Type_Win=if TIR == 1 then
      AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else if TIR ==
      2 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else
      if TIR == 3 then
      AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995() else
      AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984()
    annotation (Dialog(tab="Types"));
  parameter Modelica.SIunits.Volume room_V=room_length*room_width_long*
      room_height_long - room_length*(room_width_long - room_width_short)*(
      room_height_long - room_height_short)*0.5;
equation
  connect(outside_wall1.SolarRadiationPort, SolarRadiationPort_OW1) annotation (
     Line(points={{-69.5,35.6667},{-80,35.6667},{-80,30},{-99.5,30}}, color={0,0,
          0}));
  connect(inside_wall2.port_outside, thermInsideWall2)
    annotation (Line(points={{28,-64.2},{28,-90},{30,-90}}, color={191,0,0}));
  connect(thermInsideWall2, thermInsideWall2)
    annotation (Line(points={{30,-90},{30,-90}}, color={191,0,0}));
  connect(outside_wall2.WindSpeedPort, WindSpeedPort) annotation (Line(points={{
          -0.8,64.3},{-0.8,74},{-80,74},{-80,-50},{-99.5,-50}}, color={0,0,127}));
  connect(inside_wall1b.port_outside, thermInsideWall1b)
    annotation (Line(points={{62.1,-19},{90,-19},{90,-30}}, color={191,0,0}));
  connect(inside_wall1a.port_outside, thermInsideWall1a) annotation (Line(
        points={{62.1,19},{84,19},{84,20},{90,20},{90,10}}, color={191,0,0}));
  connect(airload.port, Tair.port) annotation (Line(points={{1,-12},{-6,-12},{-6,
          -40},{22,-40},{22,-13}}, color={191,0,0}));
  connect(thermRoom, thermStar_Demux.therm) annotation (Line(points={{-20,20},{-20,
          6},{-25.1,6},{-25.1,-15.9}}, color={191,0,0}));
  connect(starRoom, thermStar_Demux.star) annotation (Line(
      points={{20,20},{20,4},{-14.2,4},{-14.2,-15.6}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(infiltrationRate.port_a, thermOutside) annotation (Line(points={{-72,46},
          {-80,46},{-80,82},{-90,82},{-90,90}}, color={191,0,0}));
  connect(outside_wall1.port_outside, thermOutside) annotation (Line(points={{-68.25,
          10},{-80,10},{-80,82},{-90,82},{-90,90}}, color={191,0,0}));
  connect(outside_wall2.port_outside, thermOutside) annotation (Line(points={{-25,
          64.3},{-25,74},{-80,74},{-80,82},{-90,82},{-90,90}}, color={191,0,0}));
  connect(roof.port_outside, thermOutside) annotation (Line(points={{59,62.15},
          {59,74},{-80,74},{-80,82},{-90,82},{-90,90}},color={191,0,0}));
  connect(roof.SolarRadiationPort, SolarRadiationPort_Roof) annotation (Line(
        points={{74.5833,62.9},{74.5833,92},{74,92},{74,100}}, color={255,128,0}));
  connect(Ceiling.port_outside, thermCeiling) annotation (Line(points={{28,62.1},
          {28,62.1},{28,74},{90,74},{90,50}}, color={191,0,0}));
  connect(outside_wall2.SolarRadiationPort, SolarRadiationPort_OW2) annotation (
     Line(points={{5.25,65.8},{5.25,74},{44.5,74},{44.5,101}}, color={255,128,0}));
  connect(outside_wall1.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-58,10},{-40,10},{-40,-40},{-20.1,-40},{-20.1,-35.4}},
        color={191,0,0}));
  connect(inside_wall2.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{28,-56},{28,-40},{-20.1,-40},{-20.1,-38},{-20.1,
          -35.4}},
        color={191,0,0}));
  connect(inside_wall1b.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{58,-19},{40,-19},{40,-40},{-20.1,-40},{-20.1,-35.4}},
        color={191,0,0}));
  connect(outside_wall2.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-25,52},{-25,40},{40,40},{40,-40},{-20.1,-40},{-20.1,
          -35.4}}, color={191,0,0}));
  connect(roof.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation (
     Line(points={{59,56},{59,40},{40,40},{40,-40},{-20.1,-40},{-20.1,-35.4}},
        color={191,0,0}));
  connect(Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{28,58},{28,40},{40,40},{40,-40},{-20.1,-40},{
          -20.1,-35.4}},
                   color={191,0,0}));
  connect(outside_wall1.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-68.25,
          30.5333},{-80,30.5333},{-80,-50},{-99.5,-50}},        color={0,0,127}));
  connect(thermStar_Demux.therm, airload.port) annotation (Line(points={{-25.1,-15.9},
          {-25.1,-12},{1,-12}}, color={191,0,0}));
  connect(inside_wall1a.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{58,19},{40,19},{40,-40},{-20.1,-40},{-20.1,-35.4}},
        color={191,0,0}));
  connect(infiltrationRate.port_b, airload.port) annotation (Line(points={{-54,46},
          {-40,46},{-40,-40},{-6,-40},{-6,-12},{1,-12}}, color={191,0,0}));
  connect(NaturalVentilation.InPort1, AirExchangePort) annotation (Line(points={
          {-71,-36.4},{-80,-36.4},{-80,74},{-28,74},{-28,100}}, color={0,0,127}));
  connect(NaturalVentilation.port_a, thermOutside) annotation (Line(points={{-72,
          -30},{-80,-30},{-80,90},{-90,90}}, color={191,0,0}));
  connect(NaturalVentilation.port_b, airload.port) annotation (Line(points={{-52,
          -30},{-40,-30},{-40,-40},{-6,-40},{-6,-12},{1,-12}}, color={191,0,0}));
  connect(roof.WindSpeedPort, WindSpeedPort) annotation (Line(points={{71.4667,
          62.15},{71.4667,74},{-80,74},{-80,-50},{-99.5,-50}},
                                                        color={0,0,127}));
  connect(thermFloorHeatingDownHeatFlow, floor_FH.port_a) annotation (Line(
      points={{-77,-79},{-77,-80},{-30,-80},{-30,-81.9999}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(floor_FH.port_b, thermFloor) annotation (Line(
      points={{-30,-88},{-30,-94},{-6,-94}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(thermFloor, floor.port_outside) annotation (Line(
      points={{-6,-94},{-8,-94},{-8,-66},{-22,-66},{-22,-62.1},{-24,-62.1}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(floor.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(
      points={{-24,-58},{-24,-40},{-20.1,-40},{-20.1,-38},{-20.1,-35.4}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(dynamicVentilation.port_outside, thermOutside) annotation (Line(
      points={{-73.52,-50.6},{-78,-50.6},{-78,92},{-84,92},{-84,90},{-90,90}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(dynamicVentilation.port_inside, airload.port) annotation (Line(
      points={{-50.72,-50.6},{-2,-50.6},{-2,-48},{-2,-48},{-2,-12},{1,-12}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  annotation (Icon(graphics={
        Rectangle(
          extent={{-80,80},{80,60}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,80},{-50,60}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          visible=withWindow2),
        Rectangle(
          extent={{80,60},{68,-68}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,60},{-60,-80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,-68},{80,-80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,60},{68,8}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,30},{-60,-20}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          visible=withWindow3),
        Rectangle(
          extent={{-60,60},{68,-68}},
          lineColor={0,0,0},
          fillColor={47,102,173},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-56,52},{64,40}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString="width"),
        Line(points={{38,46},{68,46}}, color={255,255,255}),
        Line(points={{-46,60},{-46,30}}, color={255,255,255}),
        Line(points={{-60,46},{-30,46}}, color={255,255,255}),
        Text(
          extent={{-120,6},{0,-6}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          origin={-46,56},
          rotation=90,
          textString="length"),
        Line(points={{-46,-42},{-46,-68}}, color={255,255,255}),
        Rectangle(
          extent={{20,80},{40,60}},
          lineColor={0,0,0},
          fillColor={127,127,0},
          fillPattern=FillPattern.Solid,
          visible=withDoor2),
        Text(
          extent={{-50,76},{0,64}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString="Win2",
          visible=withWindow2),
        Text(
          extent={{-25,6},{25,-6}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString="Win3",
          origin={-70,5},
          rotation=90,
          visible=withWindow3),
        Text(
          extent={{20,74},{40,66}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString="D2",
          visible=withDoor2),
        Line(points={{68,8},{54,8}}, color={255,255,255}),
        Line(points={{58,8},{58,0}}, color={255,255,255}),
        Text(
          extent={{50,6},{-50,-6}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          origin={58,-30},
          rotation=90,
          textString="length_b"),
        Line(points={{58,-62},{58,-68}}, color={255,255,255})}), Documentation(
        revisions="<html>
 <ul>
 <li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
 <li><i>July 8, 2011</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>", info="<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for a room with 2&nbsp;outer&nbsp;walls,&nbsp;2&nbsp;inner&nbsp;walls&nbsp;load towards two different rooms but with the same orientation,&nbsp;1&nbsp;inner&nbsp;wall&nbsp;simple,&nbsp;1&nbsp;floor&nbsp;towards&nbsp;lower&nbsp;floor,&nbsp;1&nbsp;ceiling&nbsp;towards&nbsp;attic,&nbsp;1&nbsp;roof&nbsp;towards&nbsp;outside.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The following figure presents the room&apos;s layout:</p>
 <p><img src=\"modelica://AixLib/Resources/Images/Building/HighOrder/OW2_2IWl_1IWs_1Pa_1At1Ro.png\"
    alt=\"Room layout\"/></p>
 </html>"));
end Ow2IwL2IwS1Lf1At1Ro1;
