within AixLib.ThermalZones.HighOrder.Rooms.OFD;
model Ow1IwL2IwS1Lf1At1Ro1
  "1 outer wall, 2 inner walls load, 2 inner walls simple, 1 floor towards lower floor, 1 ceiling towards attic, 1 roof towards outside"
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
      groupImage=
          "modelica://AixLib/Resources/Images/Building/HighOrder/OW1_2IWl_2IWs_1Pa_1At1Ro.png",
      group="Construction parameters",
      compact=true,
      descriptionLabel=true), choices(
      choice=1 "EnEV_2009",
      choice=2 "EnEV_2002",
      choice=3 "WSchV_1995",
      choice=4 "WSchV_1984",
      radioButtons=true));

  parameter Boolean withFloorHeating=false
    "If true, that floor has different connectors" annotation (Dialog(group=
          "Construction parameters"), choices(checkBox=true));
  parameter Modelica.SIunits.Temperature T0_air=295.11 "Air"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_OW1=295.15 "OW1"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_IW1=295.15 "IW1"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_IW2a=295.15 "IW2a"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_IW2b=295.15 "IW2b"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_IW3=295.15 "IW3"
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
  parameter Boolean withWindow3=true "Window 3 " annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true), choices(checkBox=true));
  parameter Modelica.SIunits.Area windowarea_RO=0 "Window area" annotation (
      Dialog(
      group="Windows and Doors",
      naturalWidth=10,
      descriptionLabel=true,
      enable=if withWindow3 then true else false));
  // Sunblind
  parameter Boolean use_sunblind = false
    "Will sunblind become active automatically?"
    annotation(Dialog(group = "Sunblind"));
  parameter Real ratioSunblind(min=0.0, max=1.0) = 0.8
    "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
    annotation(Dialog(group = "Sunblind", enable=use_sunblind));
  parameter Modelica.SIunits.Temperature TOutAirLimit = 293.15
    "Temperature at which sunblind closes (see also solIrrThreshold)"
    annotation(Dialog(group = "Sunblind", enable=use_sunblind));
  parameter Modelica.SIunits.Irradiance solIrrThreshold(min=0.0) = 350
    "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
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
  // Infiltration rate
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outside_wall1(
    solar_absorptance=solar_absorptance_OW,
    T0=T0_OW1,
    wall_length=room_length,
    wall_height=room_height_short,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    windowarea=0,
    withDoor=false,
    door_height=0,
    door_width=0,
    WallType=Type_OW)
    annotation (Placement(transformation(extent={{-64,-12},{-54,46}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall inner_wall1(
    T0=T0_IW1,
    outside=false,
    WallType=Type_IWsimple,
    wall_length=room_width_long,
    wall_height=0.5*(room_height_long + room_height_short + room_width_short/
        room_width_long*(room_height_long - room_height_short)),
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false) annotation (Placement(transformation(
        origin={-14,58},
        extent={{-3.99997,-22},{3.99999,22}},
        rotation=270)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall2a(
    T0=T0_IW2a,
    outside=false,
    WallType=Type_IWload,
    wall_length=room_length - room_lengthb,
    wall_height=room_height_long,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false) annotation (Placement(transformation(
        origin={61,19},
        extent={{-3,-15},{3,15}},
        rotation=180)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall3(
    T0=T0_IW3,
    outside=false,
    WallType=Type_IWsimple,
    wall_length=room_width_long,
    wall_height=0.5*(room_height_long + room_height_short + room_width_short/
        room_width_long*(room_height_long - room_height_short)),
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false) annotation (Placement(transformation(
        origin={20,-60},
        extent={{-4,-24},{4,24}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.DryAir.Airload airload(V=room_V, T(
        start=T0_air))
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Ceiling(
    T0=T0_CE,
    outside=false,
    WallType=Type_CE,
    wall_length=room_length,
    wall_height=room_width_short,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false,
    ISOrientation=3) annotation (Placement(transformation(
        origin={28,60},
        extent={{1.99999,-10},{-1.99998,10}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall floor(
    T0=T0_FL,
    outside=false,
    WallType=Type_FL,
    wall_length=room_length,
    wall_height=room_width_long,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false,
    ISOrientation=2) if withFloorHeating == false annotation (Placement(
        transformation(
        origin={-24,-60},
        extent={{-1.99999,-10},{1.99999,10}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall3
    annotation (Placement(transformation(extent={{20,-100},{40,-80}}),
        iconTransformation(extent={{20,-100},{40,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2a
    annotation (Placement(transformation(extent={{80,0},{100,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort
    annotation (Placement(transformation(extent={{-109.5,-60},{-89.5,-40}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1
    annotation (Placement(transformation(extent={{-109.5,20},{-89.5,40}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation (Placement(
        transformation(origin={-100,-9}, extent={{-10,-10},{10,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
    annotation (Placement(transformation(extent={{80,40},{100,60}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom annotation (
      Placement(transformation(extent={{-30,10},{-10,30}}), iconTransformation(
          extent={{-30,10},{-10,30}})));
  Utilities.Interfaces.Star starRoom annotation (Placement(transformation(
          extent={{10,10},{30,30}}), iconTransformation(extent={{10,10},{30,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor annotation (
      Placement(transformation(extent={{-16,-104},{4,-84}}), iconTransformation(
          extent={{-16,-104},{4,-84}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall roof(
    T0=T0_RO,
    solar_absorptance=solar_absorptance_RO,
    wall_length=room_length,
    withDoor=false,
    door_height=0,
    door_width=0,
    wall_height=roof_width,
    withWindow=withWindow3,
    windowarea=windowarea_RO,
    WallType=Type_RO,
    WindowType=Type_Win,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    ISOrientation=1) annotation (Placement(transformation(
        origin={58,59},
        extent={{-2.99997,-16},{2.99999,16}},
        rotation=270)));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_Roof annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={74,100})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall2b(
    T0=T0_IW2b,
    outside=false,
    WallType=Type_IWload,
    wall_length=room_lengthb,
    wall_height=room_height_long,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false) annotation (Placement(transformation(
        origin={61,-20},
        extent={{-2.99998,-16},{2.99998,16}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2b
    annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1
    annotation (Placement(transformation(extent={{-20,80},{0,100}}),
        iconTransformation(extent={{-20,80},{0,100}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tair
    annotation (Placement(transformation(extent={{24,-20},{38,-6}})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.InfiltrationRate_DIN12831
    infiltrationRate(
    room_V=room_V,
    n50=n50,
    e=e,
    eps=eps) annotation (Placement(transformation(extent={{-72,52},{-54,60}})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.DynamicVentilation
    dynamicVentilation(
    HeatingLimit=HeatingLimit,
    Max_VR=Max_VR,
    Diff_toTempset=Diff_toTempset,
    Tset=Tset) if withDynamicVentilation
    annotation (Placement(transformation(extent={{-70,-54},{-46,-42}})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation (
      Placement(transformation(
        extent={{-10,8},{10,-8}},
        rotation=90,
        origin={-20,-26})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange
    NaturalVentilation(V=room_V)
    annotation (Placement(transformation(extent={{-68,-38},{-48,-18}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    thermFloorHeatingDownHeatFlow if withFloorHeating
    "Thermal connector for heat flow of floor heating going downwards through the wall/floor/ceiling"
    annotation (Placement(transformation(extent={{-84,-86},{-70,-72}}),
        iconTransformation(extent={{-56,-92},{-36,-72}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer
    floor_FH(
    A=room_width_long*room_length,
    n=Type_FL.n,
    d=Type_FL.d,
    rho=Type_FL.rho,
    lambda=Type_FL.lambda,
    c=Type_FL.c,
    T0=T0_FL) if withFloorHeating "floor component if using Floor heating"
    annotation (Placement(transformation(
        origin={-30,-85},
        extent={{3.00007,16},{-3,-16}},
        rotation=90)));
protected
  parameter Real n50(unit="h-1") = if TIR == 1 or TIR == 2 then 3 else if TIR
     == 3 then 4 else 6 "Air exchange rate at 50 Pa pressure difference"
    annotation (Dialog(tab="Infiltration"));
  parameter Real e=0.02 "Coefficient of windshield"
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
       else AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else if TMC ==
      1 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if TMC
       == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M() else
      AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L()
    annotation (Dialog(tab="Types"));
  //Inner wall Types
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWsimple=if TIR
       == 1 then if TMC == 1 then
      AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half() else if TMC
       == 2 then AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half()
       else AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_L_half() else
      if TIR == 2 then if TMC == 1 then
      AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_S_half() else if TMC
       == 2 then AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_M_half()
       else AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_L_half() else
      if TIR == 3 then if TMC == 1 then
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
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload=if TIR ==
      1 then if TMC == 1 then
      AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else if TMC
       == 2 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half()
       else AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else if
      TIR == 2 then if TMC == 1 then
      AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else if TMC
       == 2 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half()
       else AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else if
      TIR == 3 then if TMC == 1 then
      AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half() else if TMC
       == 2 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half()
       else AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half() else
      if TMC == 1 then
      AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half() else if TMC
       == 2 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half()
       else AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half()
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
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE=if TIR == 1
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
      AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else if TIR
       == 2 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002()
       else if TIR == 3 then
      AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995() else
      AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984()
    annotation (Dialog(tab="Types"));
  parameter Modelica.SIunits.Volume room_V=room_length*room_width_long*
      room_height_long - room_length*(room_width_long - room_width_short)*(
      room_height_long - room_height_short)*0.5;
equation
  connect(outside_wall1.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-64.25,
          38.2667},{-80,38.2667},{-80,-50},{-99.5,-50}},         color={0,0,127}));
  connect(outside_wall1.SolarRadiationPort, SolarRadiationPort_OW1) annotation (
     Line(points={{-65.5,43.5833},{-80,43.5833},{-80,30},{-99.5,30}}, color={0,
          0,0}));
  connect(inside_wall3.port_outside, thermInsideWall3) annotation (Line(points=
          {{20,-64.2},{20,-74},{30,-74},{30,-90}}, color={191,0,0}));
  connect(thermInsideWall3, thermInsideWall3)
    annotation (Line(points={{30,-90},{30,-90}}, color={191,0,0}));
  connect(Ceiling.port_outside, thermCeiling) annotation (Line(points={{28,62.1},
          {28,72},{92,72},{92,50},{90,50}}, color={191,0,0}));
  connect(inside_wall2b.port_outside, thermInsideWall2b)
    annotation (Line(points={{64.15,-20},{90,-20},{90,-30}}, color={191,0,0}));
  connect(inside_wall2a.port_outside, thermInsideWall2a) annotation (Line(
        points={{64.15,19},{84,19},{84,20},{90,20},{90,10}}, color={191,0,0}));
  connect(inner_wall1.port_outside, thermInsideWall1)
    annotation (Line(points={{-14,62.2},{-14,90},{-10,90}}, color={191,0,0}));
  connect(thermOutside, thermOutside) annotation (Line(points={{-90,90},{-90,84},
          {-90,84},{-90,90}}, color={191,0,0}));
  connect(airload.port, Tair.port) annotation (Line(points={{1,-12},{-6,-12},{-6,
          -40},{24,-40},{24,-13}}, color={191,0,0}));
  connect(infiltrationRate.port_a, thermOutside) annotation (Line(points={{-72,
          56},{-72,56},{-80,56},{-80,82},{-90,82},{-90,90}}, color={191,0,0}));
  connect(outside_wall1.port_outside, thermOutside) annotation (Line(points={{-64.25,
          17},{-80,17},{-80,82},{-90,82},{-90,90}}, color={191,0,0}));
  connect(roof.SolarRadiationPort, SolarRadiationPort_Roof) annotation (Line(
        points={{72.6667,62.9},{72.6667,72},{74,72},{74,100}}, color={255,128,0}));
  connect(roof.port_outside, thermOutside) annotation (Line(points={{58,62.15},
          {58,72},{-80,72},{-80,82},{-90,82},{-90,90}}, color={191,0,0}));
  connect(inside_wall2b.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{58,-20},{40,-20},{40,-40},{-20.1,-40},{-20.1,
          -35.4}}, color={191,0,0}));
  connect(inside_wall2a.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{58,19},{40,19},{40,-40},{-20.1,-40},{-20.1,-35.4}},
        color={191,0,0}));
  connect(roof.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation (
     Line(points={{58,56},{58,40},{40,40},{40,-40},{-20.1,-40},{-20.1,-35.4}},
        color={191,0,0}));
  connect(Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{28,58},{28,40},{40,40},{40,-40},{-20.1,-40},{
          -20.1,-35.4}}, color={191,0,0}));
  connect(inner_wall1.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-14,54},{-14,40},{40,40},{40,-40},{-20.1,-40},{
          -20.1,-35.4}},
                   color={191,0,0}));
  connect(infiltrationRate.port_b, airload.port) annotation (Line(points={{-54,
          56},{-40,56},{-40,-40},{-6,-40},{-6,-12},{1,-12}}, color={191,0,0}));
  connect(outside_wall1.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-54,17},{-40,17},{-40,-40},{-20.1,-40},{-20.1,-35.4}},
        color={191,0,0}));
  connect(inside_wall3.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{20,-56},{20,-40},{-20.1,-40},{-20.1,-35.4}},
        color={191,0,0}));
  connect(starRoom, thermStar_Demux.star) annotation (Line(
      points={{20,20},{20,4},{-14.2,4},{-14.2,-15.6}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(thermRoom, thermStar_Demux.therm) annotation (Line(points={{-20,20},{
          -20,3},{-25.1,3},{-25.1,-15.9}}, color={191,0,0}));
  connect(thermStar_Demux.therm, airload.port) annotation (Line(points={{-25.1,
          -15.9},{-25.1,-12},{1,-12}}, color={191,0,0}));
  connect(NaturalVentilation.InPort1, AirExchangePort) annotation (Line(points=
          {{-67,-34.4},{-80,-34.4},{-80,-9},{-100,-9}}, color={0,0,127}));
  connect(NaturalVentilation.port_a, thermOutside) annotation (Line(points={{-68,
          -28},{-80,-28},{-80,90},{-90,90}}, color={191,0,0}));
  connect(NaturalVentilation.port_b, airload.port) annotation (Line(points={{-48,
          -28},{-40,-28},{-40,-40},{-6,-40},{-6,-12},{1,-12}}, color={191,0,0}));
  connect(roof.WindSpeedPort, WindSpeedPort) annotation (Line(points={{69.7333,
          62.15},{69.7333,72},{-80,72},{-80,-50},{-99.5,-50}}, color={0,0,127}));
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
      points={{-24,-58},{-24,-40},{-20.1,-40},{-20.1,-35.4}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(dynamicVentilation.port_outside, thermOutside) annotation (Line(
      points={{-69.52,-48.6},{-78,-48.6},{-78,92},{-84,92},{-84,90},{-90,90}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(dynamicVentilation.port_inside, airload.port) annotation (Line(
      points={{-46.72,-48.6},{-2,-48.6},{-2,-46},{-2,-46},{-2,-12},{1,-12}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  annotation (Icon(graphics={
        Rectangle(
          extent={{-80,80},{80,68}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,60},{68,-68}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,68},{68,-68}},
          lineColor={0,0,0},
          fillColor={47,102,173},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,68},{-60,-80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,-68},{80,-80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,50},{-60,0}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          visible=withWindow3),
        Rectangle(
          extent={{80,68},{68,12}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-25,6},{25,-6}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString="Win3",
          origin={-70,25},
          rotation=90,
          visible=withWindow3),
        Line(points={{38,54},{68,54}}, color={255,255,255}),
        Text(
          extent={{-56,60},{62,48}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString="width"),
        Line(points={{-46,68},{-46,38}}, color={255,255,255}),
        Line(points={{-60,54},{-30,54}}, color={255,255,255}),
        Text(
          extent={{-126,6},{0,-6}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          origin={-46,64},
          rotation=90,
          textString="length"),
        Line(points={{-46,-42},{-46,-68}}, color={255,255,255}),
        Line(points={{68,12},{54,12}}, color={255,255,255}),
        Text(
          extent={{53,6},{-53,-6}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          origin={58,-27},
          rotation=90,
          textString="length_b"),
        Line(points={{58,-58},{58,-68}}, color={255,255,255}),
        Line(points={{58,12},{58,2}}, color={255,255,255})}), Documentation(
        revisions="<html>
 <ul>
 <li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
 <li><i>July 8, 2011</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>", info="<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for a room with 1&nbsp;outer&nbsp;wall,&nbsp;2&nbsp;inner&nbsp;walls&nbsp;load,&nbsp;2&nbsp;inner&nbsp;walls&nbsp;simple,&nbsp;1&nbsp;floor&nbsp;towards&nbsp;lower&nbsp;floor,&nbsp;1&nbsp;ceiling&nbsp;towards&nbsp;attic,&nbsp;1&nbsp;roof&nbsp;towards&nbsp;outside.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The following figure presents the room&apos;s layout:</p>
 <p><img src=\"modelica://AixLib/Resources/Images/Building/HighOrder/OW1_2IWl_2IWs_1Pa_1At1Ro.png\"
    alt=\"Room layout\"/></p>
 </html>"));
end Ow1IwL2IwS1Lf1At1Ro1;
