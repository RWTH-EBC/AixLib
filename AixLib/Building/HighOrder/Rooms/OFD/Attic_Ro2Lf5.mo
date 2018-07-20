within AixLib.Building.HighOrder.Rooms.OFD;
model Attic_Ro2Lf5
  "Attic with 2 saddle roofs and a floor toward 5 rooms on the lower floor, with all other walls towards the outside"
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
      descriptionLabel=true,
      groupImage=
          "modelica://AixLib/Resources/Images/Building/HighOrder/Attic_2Ro_5Rooms.png"),
      choices(
      choice=1 "EnEV_2009",
      choice=2 "EnEV_2002",
      choice=3 "WSchV_1995",
      choice=4 "WSchV_1984",
      radioButtons=true));
  parameter Modelica.SIunits.Temperature T0_air=283.15 "Air"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_RO1=282.15 "RO1"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_RO2=282.15 "RO2"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_OW1=282.15 "OW1"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_OW2=282.15 "OW2"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_FL1=284.15 "FL1"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_FL2=284.15 "FL2"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_FL3=284.15 "FL3"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_FL4=284.15 "FL4"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_FL5=284.15 "FL5"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  //////////room geometry
  parameter Modelica.SIunits.Length length=2 "length " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.SIunits.Length room1_length=2 "l1 " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.SIunits.Length room2_length=2 "l2 " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.SIunits.Length room3_length=2 "l3 " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.SIunits.Length room4_length=2 "l4 " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.SIunits.Length room5_length=2 "l5 " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true));
  parameter Modelica.SIunits.Length width=2 "width " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.SIunits.Length room1_width=2 "w1 " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.SIunits.Length room2_width=2 "w2 " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.SIunits.Length room3_width=2 "w3 " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.SIunits.Length room4_width=2 "w4 " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.SIunits.Length room5_width=2 "w5 " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true));
  parameter Modelica.SIunits.Length roof_width1=2 "wRO1" annotation (Dialog(
      group="Dimensions",
      absoluteWidth=28,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.SIunits.Length roof_width2=2 "wRO2" annotation (Dialog(
      group="Dimensions",
      absoluteWidth=28,
      descriptionLabel=true));
  parameter Modelica.SIunits.Angle alfa=Modelica.SIunits.Conversions.from_deg(
      90) "alfa" annotation (Dialog(group="Dimensions", descriptionLabel=true));
  // Outer walls properties
  parameter Real solar_absorptance_RO=0.25 "Solar absoptance roof "
    annotation (Dialog(group="Outer wall properties", descriptionLabel=true));
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
  parameter Boolean withWindow1=false "Window 1 " annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true), choices(checkBox=true));
  parameter Modelica.SIunits.Area windowarea_RO1=0 "Window area" annotation (
      Dialog(
      group="Windows and Doors",
      naturalWidth=10,
      descriptionLabel=true,
      enable=withWindow1));
  parameter Boolean withWindow2=false "Window 2 " annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true), choices(checkBox=true));
  parameter Modelica.SIunits.Area windowarea_RO2=0 "Window area" annotation (
      Dialog(
      group="Windows and Doors",
      naturalWidth=10,
      descriptionLabel=true,
      enable=withWindow2));
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
  // Infiltration rate
  AixLib.Building.Components.Walls.Wall roof1(
    withDoor=false,
    door_height=0,
    door_width=0,
    T0=T0_RO1,
    solar_absorptance=solar_absorptance_RO,
    withWindow=withWindow1,
    final withSunblind=use_sunblind,
    final Blinding=ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    windowarea=windowarea_RO1,
    wall_length=length,
    wall_height=roof_width1,
    WallType=Type_RO,
    WindowType=Type_Win,
    ISOrientation=1) annotation (Placement(transformation(
        extent={{-5.00001,-29},{5.00001,29}},
        rotation=270,
        origin={-41,59})));
  AixLib.Building.Components.Walls.Wall floorRoom2(
    T0=T0_FL2,
    WallType=Type_FL,
    wall_length=room2_length,
    wall_height=room2_width,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    ISOrientation=2,
    outside=false,
    withDoor=false) annotation (Placement(transformation(
        origin={-29,-40},
        extent={{-1.99999,-13},{1.99999,13}},
        rotation=90)));
  AixLib.Building.Components.DryAir.Airload airload(V=room_V, T(start=T0_air))
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  AixLib.Building.Components.Walls.Wall floorRoom1(
    T0=T0_FL1,
    WallType=Type_FL,
    wall_length=room1_length,
    wall_height=room1_width,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    ISOrientation=2,
    outside=false,
    withDoor=false) annotation (Placement(transformation(
        origin={-60,-40},
        extent={{-2,-12},{2,12}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation (Placement(
        transformation(extent={{-109.5,-10},{-89.5,10}}), iconTransformation(
          extent={{-109.5,-10},{-89.5,10}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_RO1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-45.5,100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,90})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation (Placement(
        transformation(origin={-100,17}, extent={{-10,-10},{10,10}}),
        iconTransformation(extent={{-110,30},{-90,50}})));
  AixLib.Building.Components.Walls.Wall roof2(
    solar_absorptance=solar_absorptance_RO,
    withDoor=false,
    door_height=0,
    door_width=0,
    T0=T0_RO2,
    wall_height=roof_width2,
    withWindow=withWindow2,
    final withSunblind=use_sunblind,
    final Blinding=ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    windowarea=windowarea_RO2,
    wall_length=length,
    WallType=Type_RO,
    WindowType=Type_Win,
    ISOrientation=1) annotation (Placement(transformation(
        origin={47,59},
        extent={{-5,-27},{5,27}},
        rotation=270)));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_RO2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={48,100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,90})));
  AixLib.Building.Components.Walls.Wall floorRoom3(
    T0=T0_FL3,
    WallType=Type_FL,
    wall_length=room3_length,
    wall_height=room3_width,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    ISOrientation=2,
    outside=false,
    withDoor=false) annotation (Placement(transformation(
        origin={3,-40},
        extent={{-1.99999,-13},{1.99999,13}},
        rotation=90)));
  AixLib.Building.Components.Walls.Wall floorRoom4(
    T0=T0_FL4,
    WallType=Type_FL,
    wall_length=room4_length,
    wall_height=room4_width,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    ISOrientation=2,
    outside=false,
    withDoor=false) annotation (Placement(transformation(
        origin={35,-40},
        extent={{-1.99998,-13},{1.99999,13}},
        rotation=90)));
  AixLib.Building.Components.Walls.Wall floorRoom5(
    T0=T0_FL5,
    WallType=Type_FL,
    wall_length=room5_length,
    wall_height=room5_width,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    ISOrientation=2,
    outside=false,
    withDoor=false) annotation (Placement(transformation(
        origin={69,-40},
        extent={{-1.99998,-13},{1.99998,13}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom1
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom2
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom3
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom4
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom5
    annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tair
    annotation (Placement(transformation(extent={{24,-20},{38,-6}})));
  AixLib.Building.Components.DryAir.InfiltrationRate_DIN12831 infiltrationRate(
    room_V=room_V,
    n50=n50,
    e=e,
    eps=eps) annotation (Placement(transformation(extent={{-62,0},{-46,16}})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation (
      Placement(transformation(
        extent={{-10,-8},{10,8}},
        rotation=90,
        origin={-30,-10})));
  AixLib.Building.Components.DryAir.VarAirExchange NaturalVentilation(V=room_V)
    annotation (Placement(transformation(extent={{-64,16},{-44,36}})));
  AixLib.Building.Components.Walls.Wall OW1(
    withDoor=false,
    door_height=0,
    door_width=0,
    windowarea=windowarea_RO1,
    WindowType=Type_Win,
    final withSunblind=use_sunblind,
    final Blinding=ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    ISOrientation=1,
    WallType=Type_OW,
    wall_length=sqrt(VerticalWall_Area),
    wall_height=sqrt(VerticalWall_Area),
    solar_absorptance=solar_absorptance_OW,
    withWindow=false,
    T0=T0_OW1) annotation (Placement(transformation(extent={{-4,-21},{4,21}},
          origin={-75,-22})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1
    annotation (Placement(transformation(extent={{-116,-30},{-96,-10}})));
  AixLib.Building.Components.Walls.Wall OW2(
    withDoor=false,
    door_height=0,
    door_width=0,
    windowarea=windowarea_RO1,
    WindowType=Type_Win,
    final withSunblind=use_sunblind,
    final Blinding=ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    ISOrientation=1,
    WallType=Type_OW,
    wall_length=sqrt(VerticalWall_Area),
    wall_height=sqrt(VerticalWall_Area),
    solar_absorptance=solar_absorptance_OW,
    withWindow=false,
    T0=T0_OW2) annotation (Placement(transformation(
        extent={{-4,21},{4,-21}},
        rotation=180,
        origin={85,-16})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-18})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermAttic annotation (
      Placement(transformation(extent={{8,8},{28,28}}), iconTransformation(
          extent={{8,8},{28,28}})));
protected
  parameter Real n50(unit="h-1") = if TIR == 1 or TIR == 2 then 3 else if TIR
     == 3 then 4 else 6 "Air exchange rate at 50 Pa pressure difference"
    annotation (Dialog(tab="Infiltration"));
  parameter Real e=0.03 "Coefficient of windshield"
    annotation (Dialog(tab="Infiltration"));
  parameter Real eps=1.0 "Coefficient of height"
    annotation (Dialog(tab="Infiltration"));
  parameter Modelica.SIunits.Length p=(width + roof_width2 + roof_width1)*0.5;
  // semi perimeter
  parameter Modelica.SIunits.Area VerticalWall_Area=sqrt(p*(p - width)*(p -
      roof_width2)*(p - roof_width1));
  // Heron's formula
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
  // Floor to lower floor type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=if TIR == 1
       then AixLib.DataBase.Walls.EnEV2009.Floor.FLattic_EnEV2009_SML_upHalf()
       else if TIR == 2 then
      AixLib.DataBase.Walls.EnEV2002.Floor.FLattic_EnEV2002_SML_upHalf() else
      if TIR == 3 then
      AixLib.DataBase.Walls.WSchV1995.Floor.FLattic_WSchV1995_SML_upHalf()
       else AixLib.DataBase.Walls.WSchV1984.Floor.FLattic_WSchV1984_SML_upHalf()
    annotation (Dialog(tab="Types"));
  // Saddle roof type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_RO=if TIR == 1
       then AixLib.DataBase.Walls.EnEV2009.Ceiling.ROsaddleAttic_EnEV2009_SML()
       else if TIR == 2 then
      AixLib.DataBase.Walls.EnEV2002.Ceiling.ROsaddleAttic_EnEV2002_SML() else
      if TIR == 3 then
      AixLib.DataBase.Walls.WSchV1995.Ceiling.ROsaddleAttic_WSchV1995_SML()
       else AixLib.DataBase.Walls.WSchV1984.Ceiling.ROsaddleAttic_WSchV1984_SML()
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
  parameter Modelica.SIunits.Volume room_V=roof_width1*roof_width2*sin(alfa)*
      0.5*length;
equation
  connect(SolarRadiationPort_RO1, roof1.SolarRadiationPort) annotation (Line(
        points={{-45.5,100},{-45.5,80},{-14.4167,80},{-14.4167,65.5}}, color={
          255,128,0}));
  connect(SolarRadiationPort_RO2, roof2.SolarRadiationPort) annotation (Line(
        points={{48,100},{48,80},{71.75,80},{71.75,65.5}}, color={255,128,0}));
  connect(thermOutside, thermOutside)
    annotation (Line(points={{-90,90},{-90,90}}, color={191,0,0}));
  connect(roof1.WindSpeedPort, WindSpeedPort) annotation (Line(points={{
          -19.7333,64.25},{-19.7333,80},{-80,80},{-80,0},{-99.5,0}}, color={0,0,
          127}));
  connect(roof2.WindSpeedPort, WindSpeedPort) annotation (Line(points={{66.8,
          64.25},{66.8,80},{-80,80},{-80,0},{-99.5,0}}, color={0,0,127}));
  connect(floorRoom1.port_outside, thermRoom1) annotation (Line(points={{-60,-42.1},
          {-60,-90},{-90,-90}}, color={191,0,0}));
  connect(floorRoom2.port_outside, thermRoom2) annotation (Line(points={{-29,
          -42.1},{-29,-90},{-50,-90}}, color={191,0,0}));
  connect(thermRoom3, floorRoom3.port_outside)
    annotation (Line(points={{-10,-90},{3,-90},{3,-42.1}}, color={191,0,0}));
  connect(thermRoom4, floorRoom4.port_outside) annotation (Line(points={{30,-90},
          {38,-90},{38,-70},{35,-70},{35,-42.1}}, color={191,0,0}));
  connect(floorRoom5.port_outside, thermRoom5) annotation (Line(points={{69,
          -42.1},{69,-84},{72,-84},{72,-88},{70,-88},{70,-90}}, color={191,0,0}));
  connect(airload.port, Tair.port) annotation (Line(points={{1,-12},{-10,-12},{
          -10,8},{24,8},{24,-13}}, color={191,0,0}));
  connect(infiltrationRate.port_a, thermOutside) annotation (Line(points={{-62,
          8},{-80,8},{-80,90},{-90,90}}, color={191,0,0}));
  connect(infiltrationRate.port_b, airload.port) annotation (Line(points={{-46,
          8},{-10,8},{-10,-12},{1,-12}}, color={191,0,0}));
  connect(thermStar_Demux.therm, airload.port) annotation (Line(points={{-24.9,
          0.1},{-24.9,8},{-10,8},{-10,-12},{1,-12}}, color={191,0,0}));
  connect(roof1.port_outside, thermOutside) annotation (Line(points={{-41,64.25},
          {-41,80},{-90,80},{-90,90}}, color={191,0,0}));
  connect(roof2.port_outside, thermOutside) annotation (Line(points={{47,64.25},
          {47,80},{-90,80},{-90,90}}, color={191,0,0}));
  connect(floorRoom3.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{3,-38},{3,-28},{-30,-28},{-30,-19.4},{-29.9,-19.4}},
        color={191,0,0}));
  connect(floorRoom1.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-60,-38},{-60,-28},{-30,-28},{-30,-19.4},{-29.9,-19.4}},
        color={191,0,0}));
  connect(floorRoom2.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-29,-38},{-29,-28},{-29.9,-28},{-29.9,-19.4}},
        color={191,0,0}));
  connect(floorRoom4.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{35,-38},{35,-28},{-29.9,-28},{-29.9,-19.4}},
        color={191,0,0}));
  connect(floorRoom5.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{69,-38},{69,-28},{-29.9,-28},{-29.9,-19.4}},
        color={191,0,0}));
  connect(roof2.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{47,54},{47,40},{60,40},{60,-28},{-29.9,-28},{-29.9,
          -19.4}}, color={191,0,0}));
  connect(roof1.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-41,54},{-41,40},{60,40},{60,-28},{-29.9,-28},{
          -29.9,-19.4}}, color={191,0,0}));
  connect(NaturalVentilation.InPort1, AirExchangePort) annotation (Line(points=
          {{-63,19.6},{-80,19.6},{-80,17},{-100,17}}, color={0,0,127}));
  connect(NaturalVentilation.port_a, thermOutside) annotation (Line(points={{-64,
          26},{-80,26},{-80,90},{-90,90}}, color={191,0,0}));
  connect(NaturalVentilation.port_b, airload.port) annotation (Line(points={{-44,
          26},{-40,26},{-40,8},{-10,8},{-10,-12},{1,-12}}, color={191,0,0}));
  connect(OW1.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation (
      Line(points={{-71,-22},{-64,-22},{-64,-28},{-29.9,-28},{-29.9,-19.4}},
        color={191,0,0}));
  connect(OW1.port_outside, thermOutside) annotation (Line(points={{-79.2,-22},
          {-86,-22},{-86,0},{-80,0},{-80,90},{-90,90}}, color={191,0,0}));
  connect(OW1.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-79.2,-6.6},
          {-86,-6.6},{-86,0},{-99.5,0}}, color={0,0,127}));
  connect(OW1.SolarRadiationPort, SolarRadiationPort_OW1) annotation (Line(
        points={{-80.2,-2.75},{-86,-2.75},{-86,-20},{-106,-20}}, color={255,128,
          0}));
  connect(OW2.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation (
      Line(points={{81,-16},{76,-16},{76,-28},{-29.9,-28},{-29.9,-19.4}}, color=
         {191,0,0}));
  connect(OW2.port_outside, thermOutside) annotation (Line(points={{89.2,-16},{
          100,-16},{100,80},{-90,80},{-90,90}}, color={191,0,0}));
  connect(OW2.WindSpeedPort, WindSpeedPort) annotation (Line(points={{89.2,-0.6},
          {96,-0.6},{96,-48},{-88,-48},{-88,0},{-99.5,0}}, color={0,0,127}));
  connect(OW2.SolarRadiationPort, SolarRadiationPort_OW2) annotation (Line(
        points={{90.2,3.25},{100,3.25},{100,-18},{110,-18}}, color={255,128,0}));
  connect(airload.port, ThermAttic) annotation (Line(points={{1,-12},{-4,-12},{
          -4,18},{8,18},{8,18},{18,18},{18,18}}, color={191,0,0}));
  annotation (Icon(graphics={
        Polygon(
          points={{-58,-20},{16,54},{90,-20},{76,-20},{16,40},{-44,-20},{-58,-20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175}),
        Polygon(
          points={{-24,0},{6,30},{-8,30},{-38,0},{-24,0}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          visible=withWindow1),
        Text(
          extent={{-36,10},{12,22}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          textString="Win1",
          visible=withWindow1),
        Polygon(
          points={{26,30},{56,0},{70,0},{40,30},{26,30}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          visible=withWindow2),
        Text(
          extent={{22,10},{70,22}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          textString="Win2",
          visible=withWindow2),
        Text(
          extent={{-44,-14},{74,-26}},
          lineColor={0,0,0},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString="width"),
        Line(points={{48,-20},{76,-20}}, color={0,0,0}),
        Line(points={{-44,-20},{-20,-20}}, color={0,0,0}),
        Line(points={{-62,-16},{12,58}}, color={0,0,0}),
        Line(points={{16,54},{10,60}}, color={0,0,0}),
        Line(points={{-58,-20},{-64,-14}}, color={0,0,0}),
        Text(
          extent={{-40,52},{16,42}},
          lineColor={0,0,0},
          textString="wRO1"),
        Line(
          points={{3,-3},{-3,3}},
          color={0,0,0},
          origin={93,-17},
          rotation=90),
        Line(
          points={{-37,-37},{37,37}},
          color={0,0,0},
          origin={57,21},
          rotation=90),
        Line(
          points={{3,-3},{-3,3}},
          color={0,0,0},
          origin={19,57},
          rotation=90),
        Text(
          extent={{-28,5},{28,-5}},
          lineColor={0,0,0},
          origin={44,47},
          textString="wRO2"),
        Line(points={{-44,-20},{-44,-24}}, color={0,0,0}),
        Line(points={{76,-20},{76,-24}}, color={0,0,0})}), Documentation(
        revisions="<html>
 <ul>
 <li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
 <li><i>July 8, 2011</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>", info="<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for an attic&nbsp;with&nbsp;2&nbsp;saddle&nbsp;roofs&nbsp;and&nbsp;a&nbsp;floor&nbsp;toward&nbsp;5&nbsp;rooms&nbsp;on&nbsp;the&nbsp;lower&nbsp;floor,&nbsp;with&nbsp;all&nbsp;other&nbsp;walls&nbsp;towards&nbsp;the&nbsp;outside.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The following figure presents the room&apos;s layout:</p>
 <p><img src=\"modelica://AixLib/Resources/Images/Building/HighOrder/Attic_2Ro_5Rooms.png\"
    alt=\"Room layout\"/></p>
 <p>We also tested a model where the attic has just one floor, over the whole building and each room connects to this component through the ceiling. However the model didn&apos;t lead to the expected lower simulation times, on the contrary. This model is also more correct, as it is not realistic to think that every layer of the attic&apos;s floor has a single temperature.</p>
 </html>"));
end Attic_Ro2Lf5;
