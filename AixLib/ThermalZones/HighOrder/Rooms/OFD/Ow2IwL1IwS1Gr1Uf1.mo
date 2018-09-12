within AixLib.ThermalZones.HighOrder.Rooms.OFD;
model Ow2IwL1IwS1Gr1Uf1
  "2 outer walls, 1 inner wall load, 1 inner wall simple, 1 floor towards ground, 1 ceiling towards upper floor"
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
  //Initial temperatures
  parameter Modelica.SIunits.Temperature T0_air=295.15 "Air"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_OW1=295.15 "OW1"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_OW2=295.15 "OW2"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_IW1=295.15 "IW1"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_IW2=295.15 "IW2"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_CE=295.13 "Ceiling"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_FL=295.13 "Floor"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  //////////room geometry
  parameter Modelica.SIunits.Length room_length=2 "length "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length room_width=2 "width"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Height room_height=2 "height"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  // Outer wall properties
  parameter Real solar_absorptance_OW=0.25 "Solar absoptance outer walls "
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
  parameter Boolean withWindow1=true "Window 1" annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true), choices(checkBox=true));
  parameter Modelica.SIunits.Area windowarea_OW1=0 "Window area " annotation (
      Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      enable=withWindow1));
  parameter Boolean withWindow2=true "Window 2 " annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true), choices(checkBox=true));
  parameter Modelica.SIunits.Area windowarea_OW2=0 "Window area" annotation (
      Dialog(
      group="Windows and Doors",
      naturalWidth=10,
      descriptionLabel=true,
      enable=withWindow2));
  parameter Boolean withDoor1=true "Door 1" annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true), choices(checkBox=true));
  parameter Modelica.SIunits.Length door_width_OD1=0 "width " annotation (
      Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true,
      enable=withDoor1));
  parameter Modelica.SIunits.Length door_height_OD1=0 "height " annotation (
      Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      enable=withDoor1));
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
    "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
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

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outside_wall1(
    solar_absorptance=solar_absorptance_OW,
    windowarea=windowarea_OW1,
    T0=T0_OW1,
    door_height=door_height_OD1,
    door_width=door_width_OD1,
    wall_length=room_length,
    wall_height=room_height,
    withWindow=withWindow1,
    withDoor=withDoor1,
    WallType=Type_OW,
    Model=ModelConvOW,
    WindowType=Type_Win,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    U_door=U_door_OD1,
    eps_door=eps_door_OD1)
    annotation (Placement(transformation(extent={{-66,-22},{-56,42}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outside_wall2(
    solar_absorptance=solar_absorptance_OW,
    windowarea=windowarea_OW2,
    T0=T0_OW2,
    door_height=door_height_OD2,
    door_width=door_width_OD2,
    wall_length=room_width,
    wall_height=room_height,
    withWindow=withWindow2,
    withDoor=withDoor2,
    WallType=Type_OW,
    Model=ModelConvOW,
    WindowType=Type_Win,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    U_door=U_door_OD2,
    eps_door=eps_door_OD2) annotation (Placement(transformation(
        origin={19,57},
        extent={{-5.00018,-29},{5.00003,29}},
        rotation=270)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall1(
    T0=T0_IW1,
    outside=false,
    wall_length=room_length,
    wall_height=room_height,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false,
    WallType=Type_IWload) annotation (Placement(transformation(
        origin={58,5},
        extent={{-6,-35},{6,35}},
        rotation=180)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall2(
    T0=T0_IW2,
    outside=false,
    WallType=Type_IWsimple,
    wall_length=room_width,
    wall_height=room_height,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false) annotation (Placement(transformation(
        origin={16,-60},
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
    wall_height=room_width,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false,
    ISOrientation=3) annotation (Placement(transformation(
        origin={-30,59},
        extent={{2.99997,-16},{-3.00002,16}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall floor(
    T0=T0_FL,
    WallType=Type_FL,
    wall_length=room_length,
    wall_height=room_width,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    outside=false,
    withDoor=false,
    ISOrientation=2) if withFloorHeating == false annotation (Placement(
        transformation(
        origin={-29,-65},
        extent={{-3.00001,-15},{2.99998,15}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1
    annotation (Placement(transformation(extent={{80,0},{100,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort
    annotation (Placement(transformation(extent={{-109.5,-50},{-89.5,-30}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1
    annotation (Placement(transformation(extent={{-109.5,20},{-89.5,40}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW2 annotation (Placement(
        transformation(
        origin={50.5,99},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
    annotation (Placement(transformation(extent={{80,60},{100,80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom annotation (
      Placement(transformation(extent={{-32,10},{-12,30}}), iconTransformation(
          extent={{-32,10},{-12,30}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation (Placement(
        transformation(
        extent={{-13,-13},{13,13}},
        rotation=270,
        origin={-20,100}), iconTransformation(
        extent={{-10.5,-10.5},{10.5,10.5}},
        rotation=270,
        origin={-20.5,98.5})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tair
    annotation (Placement(transformation(extent={{24,-20},{38,-6}})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.InfiltrationRate_DIN12831
    infiltrationRate(
    room_V=room_V,
    n50=n50,
    e=e,
    eps=eps) annotation (Placement(transformation(extent={{-70,50},{-52,58}})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.DynamicVentilation
    dynamicVentilation(
    HeatingLimit=HeatingLimit,
    Max_VR=Max_VR,
    Diff_toTempset=Diff_toTempset,
    Tset=Tset) if withDynamicVentilation
    annotation (Placement(transformation(extent={{-70,-60},{-48,-48}})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation (
      Placement(transformation(
        extent={{-10,8},{10,-8}},
        rotation=90,
        origin={-20,-26})));
  Utilities.Interfaces.Star starRoom annotation (Placement(transformation(
          extent={{10,10},{30,30}}), iconTransformation(extent={{10,10},{30,30}})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange
    NaturalVentilation(V=room_V)
    annotation (Placement(transformation(extent={{-70,-44},{-50,-24}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer
    floor_FH(
    A=room_width*room_length,
    n=Type_FL.n,
    d=Type_FL.d,
    rho=Type_FL.rho,
    lambda=Type_FL.lambda,
    c=Type_FL.c,
    T0=T0_FL) if withFloorHeating "floor component if using Floor heating"
    annotation (Placement(transformation(
        origin={-30,-87},
        extent={{3.00007,16},{-3,-16}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ground
    annotation (Placement(transformation(extent={{-16,-104},{4,-84}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    thermFloorHeatingDownHeatFlow if                                withFloorHeating
    "Thermal connector for heat flow of floor heating going downwards through the wall/floor/ceiling"
    annotation (Placement(transformation(extent={{-84,-86},{-70,-72}}),
        iconTransformation(extent={{-56,-92},{-36,-72}})));
protected
  parameter Real U_door_OD1=if TIR == 1 then 1.8 else 2.9 "U-value" annotation (
     Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true,
      enable=withDoor1));
  parameter Real eps_door_OD1=0.95 "eps" annotation (Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      enable=withDoor1));
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
  // Floor to ground type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=
   if withFloorHeating==true then AixLib.DataBase.Walls.Dummys.FloorForFloorHeating4Layers()
  else if TIR == 1
       then AixLib.DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML() else
      if TIR == 2 then
      AixLib.DataBase.Walls.EnEV2002.Floor.FLground_EnEV2002_SML() else if TIR ==
      3 then AixLib.DataBase.Walls.WSchV1995.Floor.FLground_WSchV1995_SML()
       else AixLib.DataBase.Walls.WSchV1984.Floor.FLground_WSchV1984_SML()
    annotation (Dialog(tab="Types"));
  // Ceiling to upper floor type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE=
  if withFloorHeating==true then AixLib.DataBase.Walls.Dummys.CeilingForFloorHeating3Layers()
  else if TIR == 1
       then if TMC == 1 or TMC == 2 then
      AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf()
       else
      AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_L_loHalf()
       else if TIR == 2 then if TMC == 1 or TMC == 2 then
      AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_SM_loHalf()
       else
      AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_L_loHalf()
       else if TIR == 3 then if TMC == 1 or TMC == 2 then
      AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_SM_loHalf()
       else
      AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_L_loHalf()
       else if TMC == 1 or TMC == 2 then
      AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_SM_loHalf()
       else
      AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_L_loHalf()
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
  parameter Modelica.SIunits.Volume room_V=room_length*room_width*room_height;
equation
  connect(outside_wall1.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-66.25,
          33.4667},{-80,33.4667},{-80,-40},{-99.5,-40}},        color={0,0,127}));
  connect(thermInsideWall2, thermInsideWall2)
    annotation (Line(points={{30,-90},{30,-90}}, color={191,0,0}));
  connect(inside_wall1.port_outside, thermInsideWall1)
    annotation (Line(points={{64.3,5},{90,5},{90,10}}, color={191,0,0}));
  connect(outside_wall2.WindSpeedPort, WindSpeedPort) annotation (Line(points={{40.2667,
          62.2502},{40.2667,68},{40.2667,70},{-80,70},{-80,-40},{-99.5,-40}},
        color={0,0,127}));
  connect(infiltrationRate.port_a, thermOutside) annotation (Line(points={{-70,54},
          {-80,54},{-80,80},{-90,80},{-90,90}}, color={191,0,0}));
  connect(outside_wall1.port_outside, thermOutside) annotation (Line(points={{-66.25,
          10},{-80,10},{-80,80},{-90,80},{-90,90}}, color={191,0,0}));
  connect(thermRoom, thermRoom)
    annotation (Line(points={{-22,20},{-22,20}}, color={191,0,0}));
  connect(starRoom, thermStar_Demux.star) annotation (Line(
      points={{20,20},{20,4},{-14.2,4},{-14.2,-15.6}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(outside_wall2.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{19,52},{19,52},{19,40},{-40,40},{-40,-40},{-20.1,
          -40},{-20.1,-35.4}},
                          color={191,0,0}));
  connect(outside_wall2.SolarRadiationPort, SolarRadiationPort_OW2) annotation (
     Line(points={{45.5833,63.5002},{45.5833,80.7501},{50.5,80.7501},{50.5,99}},
        color={255,128,0}));
  connect(SolarRadiationPort_OW1, outside_wall1.SolarRadiationPort) annotation (
     Line(points={{-99.5,30},{-80,30},{-80,39.3333},{-67.5,39.3333}}, color={255,
          128,0}));
  connect(thermOutside, thermOutside)
    annotation (Line(points={{-90,90},{-90,90}}, color={191,0,0}));
  connect(inside_wall2.port_outside, thermInsideWall2) annotation (Line(points={
          {16,-64.2},{16,-75.45},{30,-75.45},{30,-90}}, color={191,0,0}));
  connect(inside_wall1.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{52,5},{50,6},{40,6},{40,-40},{-20.1,-40},{-20.1,-35.4}},
        color={191,0,0}));
  connect(Ceiling.port_outside, thermCeiling)
    annotation (Line(points={{-30,62.15},{-30,70},{90,70}}, color={191,0,0}));
  connect(thermStar_Demux.therm, thermRoom) annotation (Line(points={{-25.1,-15.9},
          {-25.1,1.05},{-22,1.05},{-22,20}}, color={191,0,0}));
  connect(thermStar_Demux.therm, airload.port) annotation (Line(points={{-25.1,-15.9},
          {-25.1,-12},{1,-12}}, color={191,0,0}));
  connect(outside_wall2.port_outside, thermOutside) annotation (Line(points={{19,
          62.2502},{19,70},{-80,70},{-80,80},{-90,80},{-90,90}}, color={191,0,0}));
  connect(infiltrationRate.port_b, airload.port) annotation (Line(points={{-52,54},
          {-40,54},{-40,-40},{-6,-40},{-6,-12},{1,-12}}, color={191,0,0}));
  connect(Tair.port, airload.port) annotation (Line(points={{24,-13},{24,-40},{-6,
          -40},{-6,-12},{1,-12}}, color={191,0,0}));
  connect(Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-30,56},{-30,40},{-40,40},{-40,-40},{-20.1,-40},{
          -20.1,-35.4}},
                   color={191,0,0}));
  connect(inside_wall2.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{16,-56},{16,-40},{-20.1,-40},{-20.1,-35.4}},
        color={191,0,0}));
  connect(outside_wall1.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-56,10},{-40,10},{-40,-40},{-20.1,-40},{-20.1,-35.4}},
        color={191,0,0}));
  connect(AirExchangePort, NaturalVentilation.InPort1) annotation (Line(points={
          {-20,100},{-20,70},{-80,70},{-80,-40.4},{-69,-40.4}}, color={0,0,127}));
  connect(thermOutside, NaturalVentilation.port_a) annotation (Line(points={{-90,
          90},{-80,90},{-80,-34},{-70,-34}}, color={191,0,0}));
  connect(NaturalVentilation.port_b, airload.port) annotation (Line(points={{-50,
          -34},{-40,-34},{-40,-40},{-6,-40},{-6,-12},{1,-12}}, color={191,0,0}));
  connect(ground, floor_FH.port_b) annotation (Line(
      points={{-6,-94},{-32,-94},{-32,-90},{-30,-90}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(thermFloorHeatingDownHeatFlow, floor_FH.port_a) annotation (Line(
      points={{-77,-79},{-77,-80},{-30,-80},{-30,-83.9999}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(ground, floor.port_outside) annotation (Line(
      points={{-6,-94},{-6,-74},{-24,-74},{-24,-68.15},{-29,-68.15}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(floor.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(
      points={{-29,-62},{-29,-40},{-20.1,-40},{-20.1,-35.4}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(dynamicVentilation.port_inside, airload.port) annotation (Line(
      points={{-48.66,-54.6},{-2,-54.6},{-2,-48},{-2,-48},{-2,-12},{1,-12}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(dynamicVentilation.port_outside, thermOutside) annotation (Line(
      points={{-69.56,-54.6},{-78,-54.6},{-78,92},{-84,92},{-84,90},{-90,90}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
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
          extent={{6,64},{-6,-64}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={74,-4},
          rotation=360),
        Rectangle(
          extent={{-60,-68},{80,-80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,60},{-60,-80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,50},{-60,0}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          visible=withWindow1),
        Rectangle(
          extent={{-60,60},{68,-68}},
          lineColor={0,0,0},
          fillColor={47,102,173},
          fillPattern=FillPattern.Solid),
        Line(points={{38,46},{68,46}}, color={255,255,255}),
        Text(
          extent={{64,52},{-56,40}},
          lineColor={255,255,255},
          textString="width"),
        Line(points={{-46,-38},{-46,-68}}, color={255,255,255}),
        Text(
          extent={{3,-6},{-117,6}},
          lineColor={255,255,255},
          origin={-46,53},
          rotation=90,
          textString="length"),
        Rectangle(
          extent={{-80,-20},{-60,-40}},
          fillColor={127,127,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          visible=withDoor1),
        Rectangle(
          extent={{20,80},{40,60}},
          lineColor={0,0,0},
          fillColor={127,127,0},
          fillPattern=FillPattern.Solid,
          visible=withDoor2),
        Text(
          extent={{-50,76},{0,64}},
          lineColor={255,255,255},
          fillColor={255,85,85},
          fillPattern=FillPattern.Solid,
          visible=withWindow2,
          textString="Win2",
          lineThickness=0.5),
        Text(
          extent={{-25,6},{25,-6}},
          lineColor={255,255,255},
          fillColor={255,85,85},
          fillPattern=FillPattern.Solid,
          origin={-70,25},
          rotation=90,
          visible=withWindow1,
          textString="Win1"),
        Text(
          extent={{20,74},{40,66}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          visible=withDoor2,
          textString="D2"),
        Text(
          extent={{-10,4},{10,-4}},
          lineColor={255,255,255},
          fillColor={255,85,85},
          fillPattern=FillPattern.Solid,
          origin={-70,-30},
          rotation=90,
          visible=withDoor1,
          textString="D1"),
        Line(points={{-60,46},{-30,46}}, color={255,255,255}),
        Line(points={{-46,60},{-46,30}}, color={255,255,255})}), Documentation(
        revisions="<html>
 <ul>
 <li><i>Mai 7, 2015</i> by Ana Constantin:<br/>Grount temperature depends on TRY</li>
 <li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
 <li><i>July 7, 2011</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>", info="<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for a room with 2&nbsp;outer&nbsp;walls,&nbsp;1&nbsp;inner&nbsp;wall&nbsp;load,&nbsp;1&nbsp;inner&nbsp;wall&nbsp;simple,&nbsp;1&nbsp;floor&nbsp;towards&nbsp;ground,&nbsp;1&nbsp;ceiling&nbsp;towards&nbsp;upper&nbsp;floor.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The following figure presents the room&apos;s layout:</p>
 <p><img src=\"modelica://AixLib/Resources/Images/Building/HighOrder/2OW_1IWl_1IWs_1Gr_Pa.png\"
    alt=\"Room layout\"/></p>
<p><b><span style=\"color: #008000;\">Ground temperature</span></b> </p>
<p>The ground temperature can be coupled to any desired prescriped temperature. Anyway, suitable ground temperatures depending on locations in Germany are listed as &Theta;'_m,e in the comprehensive table 1 in &quot;Beiblatt 1&quot; in the norm DIN EN 12831.</p>
<p>Or a ground temperature can be chosen according to a TRY region, which is listed below: if ...</p><p>TRY_Region == 1 then 282.15 K</p><p>TRY_Region == 2 then 281.55 K</p><p>TRY_Region == 3 then 281.65 K</p><p>TRY_Region == 4 then 282.65 K</p><p>TRY_Region == 5 then 281.25 K</p><p>TRY_Region == 6 then 279.95 K</p><p>TRY_Region == 7 then 281.95 K</p><p>TRY_Region == 8 then 279.95 K</p><p>TRY_Region == 9 then 281.05 K</p><p>TRY_Region == 10 then 276.15 K</p><p>TRY_Region == 11 then 279.45 K</p><p>TRY_Region == 12 then 283.35 K</p><p>TRY_Region == 13 then 281.05 K</p><p>TRY_Region == 14 then 281.05 K</p><p>TRY_Region == 15 then 279.95 K </p>
</html>"));
end Ow2IwL1IwS1Gr1Uf1;
