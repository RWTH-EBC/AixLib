within AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope;
model UpperFloorBuildingEnvelope
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
          "modelica://AixLib/Resources/Images/Building/HighOrder/Upperfloor_5Rooms.png",
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
  //////////room geometry
  parameter Modelica.SIunits.Length room_width_long=if TIR == 1 then 3.86 else
      3.97 "w1 " annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length room_width_short=2.28 "w2 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Height room_height_long=2.60 "h1 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Height room_height_short=1 "h2 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length roof_width=2.21 "wRO"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length length5=if TIR == 1 then 3.23 else 3.34
    "l5 " annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length length6=2.44 "l6 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length length7=1.33 "l7 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length length8=if TIR == 1 then 3.23 else 3.34
    "l8 " annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length thickness_IWsimple=0.145
    "thickness IWsimple "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  // Outer walls properties
  parameter Real solar_absorptance_OW=0.6 "Solar absoptance outer walls "
    annotation (Dialog(group="Outer wall properties", descriptionLabel=true));
  parameter Real solar_absorptance_RO=0.1 "Solar absoptance roof "
    annotation (Dialog(group="Outer wall properties", descriptionLabel=true));
  //Windows and Doors
  parameter Modelica.SIunits.Area windowarea_62=1.73 " Area Window62"
    annotation (Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.SIunits.Area windowarea_63=1.73 " Area Window63  "
    annotation (Dialog(group="Windows and Doors", descriptionLabel=true));
  parameter Modelica.SIunits.Area windowarea_72=1.73 " Area Window72"
    annotation (Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.SIunits.Area windowarea_73=1.73 " Area Window73  "
    annotation (Dialog(group="Windows and Doors", descriptionLabel=true));
  parameter Modelica.SIunits.Area windowarea_92=1.73 " Area Window51"
    annotation (Dialog(group="Windows and Doors", descriptionLabel=true));
  parameter Modelica.SIunits.Area windowarea_102=1.73 " Area Window102"
    annotation (Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.SIunits.Area windowarea_103=1.73 " Area Window103  "
    annotation (Dialog(group="Windows and Doors", descriptionLabel=true));
  parameter Real AirExchangeCorridor=2 "Air exchange corridors in 1/h "
    annotation (Dialog(group="Air Exchange Corridors", descriptionLabel=true));
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
  parameter Boolean withDynamicVentilation=true "Dynamic ventilation"
    annotation (Dialog(group="Dynamic ventilation", descriptionLabel=true),
      choices(checkBox=true));
  parameter Modelica.SIunits.Temperature HeatingLimit=253.15
    "Outside temperature at which the heating activates" annotation (Dialog(
      group="Dynamic ventilation",
      descriptionLabel=true,
      enable=if withDynamicVentilation then true else false));
  parameter Real Max_VR=200 "Maximal ventilation rate" annotation (Dialog(
      group="Dynamic ventilation",
      descriptionLabel=true,
      enable=if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.TemperatureDifference Diff_toTempset=3
    "Difference to set temperature" annotation (Dialog(
      group="Dynamic ventilation",
      descriptionLabel=true,
      enable=if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.Temperature Tset_Bedroom=295.15 "Tset_bedroom"
    annotation (Dialog(
      group="Dynamic ventilation",
      descriptionLabel=true,
      joinNext=true,
      enable=if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.Temperature Tset_Children1=295.15 "Tset_children1"
    annotation (Dialog(
      group="Dynamic ventilation",
      descriptionLabel=true,
      enable=if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.Temperature Tset_Bath=297.15 "Tset_Bath"
    annotation (Dialog(
      group="Dynamic ventilation",
      descriptionLabel=true,
      joinNext=true,
      enable=if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.Temperature Tset_Children2=295.15 "Tset_children2"
    annotation (Dialog(
      group="Dynamic ventilation",
      descriptionLabel=true,
      enable=if withDynamicVentilation then true else false));
  Utilities.Interfaces.SolarRad_in RoofS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,44})));
  Utilities.Interfaces.SolarRad_in RoofN annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,76})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Bedroom
    annotation (Placement(transformation(extent={{-66,-120},{-46,-100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Children1
    annotation (Placement(transformation(extent={{-42,-120},{-22,-100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Corridor
    annotation (Placement(transformation(extent={{-10,-120},{10,-100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Bath
    annotation (Placement(transformation(extent={{20,-120},{40,-100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Children2
    annotation (Placement(transformation(extent={{60,-120},{80,-100}})));
  Rooms.OFD.Ow2IwL2IwS1Lf1At1Ro1 Bedroom(
    TMC=TMC,
    TIR=TIR,
    solar_absorptance_OW=solar_absorptance_OW,
    withWindow2=true,
    room_length=length5 + length6 + thickness_IWsimple,
    room_lengthb=length6,
    room_width_long=room_width_long,
    room_width_short=room_width_short,
    room_height_long=room_height_long,
    room_height_short=room_height_short,
    roof_width=roof_width,
    solar_absorptance_RO=solar_absorptance_RO,
    windowarea_OW2=windowarea_62,
    withWindow3=true,
    windowarea_RO=windowarea_63,
    withDoor2=false,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDynamicVentilation=withDynamicVentilation,
    HeatingLimit=HeatingLimit,
    Max_VR=Max_VR,
    Diff_toTempset=Diff_toTempset,
    Tset=Tset_Bedroom,
    withFloorHeating=withFloorHeating,
    T0_air=295.11,
    T0_OW1=295.15,
    T0_OW2=295.15,
    T0_IW1a=295.15,
    T0_IW1b=295.15,
    T0_IW2=295.15,
    T0_CE=295.1,
    T0_RO=295.15,
    T0_FL=295.12)
    annotation (Placement(transformation(extent={{-82,14},{-42,78}})));
  Rooms.OFD.Ow2IwL1IwS1Lf1At1Ro1 Children1(
    TMC=TMC,
    TIR=TIR,
    solar_absorptance_OW=solar_absorptance_OW,
    withWindow2=true,
    room_length=length5,
    room_width_long=room_width_long,
    room_width_short=room_width_short,
    room_height_long=room_height_long,
    room_height_short=room_height_short,
    roof_width=roof_width,
    solar_absorptance_RO=solar_absorptance_RO,
    windowarea_OW2=windowarea_72,
    withWindow3=true,
    windowarea_RO=windowarea_73,
    withDoor2=false,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDynamicVentilation=withDynamicVentilation,
    HeatingLimit=HeatingLimit,
    Max_VR=Max_VR,
    Diff_toTempset=Diff_toTempset,
    Tset=Tset_Children1,
    withFloorHeating=withFloorHeating,
    T0_air=295.11,
    T0_OW1=295.15,
    T0_OW2=295.15,
    T0_IW1=295.15,
    T0_IW2=295.15,
    T0_CE=295.1,
    T0_RO=295.15,
    T0_FL=295.12)
    annotation (Placement(transformation(extent={{82,28},{44,76}})));
  Rooms.OFD.Ow2IwL1IwS1Lf1At1Ro1 Bath(
    TMC=TMC,
    TIR=TIR,
    solar_absorptance_OW=solar_absorptance_OW,
    room_length=length8,
    room_width_long=room_width_long,
    room_width_short=room_width_short,
    room_height_long=room_height_long,
    room_height_short=room_height_short,
    roof_width=roof_width,
    solar_absorptance_RO=solar_absorptance_RO,
    windowarea_OW2=windowarea_92,
    withDoor2=false,
    door_width_OD2=0,
    door_height_OD2=0,
    withWindow2=true,
    withWindow3=false,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDynamicVentilation=withDynamicVentilation,
    HeatingLimit=HeatingLimit,
    Max_VR=Max_VR,
    Diff_toTempset=Diff_toTempset,
    Tset=Tset_Bath,
    withFloorHeating=withFloorHeating,
    T0_air=297.11,
    T0_OW1=297.15,
    T0_OW2=297.15,
    T0_IW1=297.15,
    T0_IW2=297.15,
    T0_CE=297.1,
    T0_RO=297.15,
    T0_FL=297.12)
    annotation (Placement(transformation(extent={{84,-36},{46,-84}})));
  Rooms.OFD.Ow2IwL2IwS1Lf1At1Ro1 Children2(
    TMC=TMC,
    TIR=TIR,
    solar_absorptance_OW=solar_absorptance_OW,
    withWindow2=true,
    room_length=length7 + length8 + thickness_IWsimple,
    room_width_long=room_width_long,
    room_width_short=room_width_short,
    room_height_long=room_height_long,
    room_height_short=room_height_short,
    roof_width=roof_width,
    solar_absorptance_RO=solar_absorptance_RO,
    windowarea_OW2=windowarea_102,
    withWindow3=true,
    windowarea_RO=windowarea_103,
    room_lengthb=length7,
    withDoor2=false,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDynamicVentilation=withDynamicVentilation,
    HeatingLimit=HeatingLimit,
    Max_VR=Max_VR,
    Diff_toTempset=Diff_toTempset,
    Tset=Tset_Children2,
    withFloorHeating=withFloorHeating,
    T0_air=295.11,
    T0_OW1=295.15,
    T0_OW2=295.15,
    T0_IW1a=295.15,
    T0_IW1b=295.15,
    T0_IW2=295.15,
    T0_CE=295.1,
    T0_RO=295.15,
    T0_FL=295.12)
    annotation (Placement(transformation(extent={{-84,-20},{-44,-84}})));
  Rooms.OFD.Ow1IwL2IwS1Lf1At1Ro1 Corridor(
    TMC=TMC,
    TIR=TIR,
    solar_absorptance_OW=solar_absorptance_OW,
    room_length=length6 + length7 + thickness_IWsimple,
    room_lengthb=length7,
    room_width_long=room_width_long,
    room_width_short=room_width_short,
    room_height_long=room_height_long,
    room_height_short=room_height_short,
    roof_width=roof_width,
    solar_absorptance_RO=solar_absorptance_RO,
    withWindow3=false,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withFloorHeating=withFloorHeating,
    T0_air=291.11,
    T0_OW1=291.15,
    T0_IW1=291.15,
    T0_IW2a=291.15,
    T0_IW2b=291.15,
    T0_IW3=291.15,
    T0_CE=291.1,
    T0_RO=291.15,
    T0_FL=291.12)
    annotation (Placement(transformation(extent={{82,-28},{42,10}})));
  Utilities.Interfaces.SolarRad_in North annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,6})));
  Utilities.Interfaces.SolarRad_in East annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-24})));
  Utilities.Interfaces.SolarRad_in South annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-54})));
  Utilities.Interfaces.SolarRad_in West annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-84})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort
    annotation (Placement(transformation(extent={{-130,10},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort[4]
    "1(5): Bedroom_UF, 2 (6): Child1_UF, 3(7): Bath_UF, 4(8): Child2_UF"
    annotation (Placement(transformation(extent={{-130,-26},{-100,4}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
    annotation (Placement(transformation(extent={{-116,66},{-100,82}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Bedroom
    annotation (Placement(transformation(extent={{-98,100},{-82,118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Children1
    annotation (Placement(transformation(extent={{-58,100},{-40,118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Corridor
    annotation (Placement(transformation(extent={{-20,100},{-2,118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Bath
    annotation (Placement(transformation(extent={{20,100},{38,118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Children2
    annotation (Placement(transformation(extent={{60,100},{78,118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor
    annotation (Placement(transformation(extent={{100,-120},{120,-100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermBedroom
    annotation (Placement(transformation(extent={{-26,54},{-14,66}})));
  Utilities.Interfaces.Star StarBedroom
    annotation (Placement(transformation(extent={{-28,32},{-12,48}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermChildren1
    annotation (Placement(transformation(extent={{14,54},{26,66}})));
  Utilities.Interfaces.Star StarChildren1
    annotation (Placement(transformation(extent={{12,32},{28,48}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermBath
    annotation (Placement(transformation(extent={{14,-46},{26,-34}})));
  Utilities.Interfaces.Star StarBath
    annotation (Placement(transformation(extent={{12,-68},{28,-52}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermChildren2
    annotation (Placement(transformation(extent={{-26,-46},{-14,-34}})));
  Utilities.Interfaces.Star StarChildren2
    annotation (Placement(transformation(extent={{-28,-68},{-12,-52}})));
  Modelica.Blocks.Sources.Constant AirExchangePort_doorSt(k=0) "Storage"
    annotation (Placement(transformation(extent={{-116,-68},{-100,-52}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloorHeatingDownHeatFlow[4] if
                                                                       withFloorHeating
    "1(6): Bedroom_UF, 2(7): Child1_UF, 3(8): Bath_UF, 4(9): Child2_UF"
    annotation (Placement(transformation(extent={{-102,-102},{-90,-90}}),
        iconTransformation(extent={{-100,-100},{-86,-90}})));
equation
  connect(Bedroom.SolarRadiationPort_OW2, West) annotation (Line(points={{-53.1,
          78.32},{-53.1,86},{90,86},{90,-84},{110,-84}}, color={255,128,0}));
  connect(Children1.SolarRadiationPort_OW2, West) annotation (Line(points={{
          54.545,76.24},{54.545,86},{90,86},{90,-84},{110,-84}}, color={255,128,
          0}));
  connect(Children1.SolarRadiationPort_OW1, North) annotation (Line(points={{
          81.905,59.2},{90,59.2},{90,6},{110,6}}, color={255,128,0}));
  connect(Corridor.SolarRadiationPort_OW1, North) annotation (Line(points={{
          81.9,-3.3},{90,-3.3},{90,6},{110,6}}, color={255,128,0}));
  connect(Bath.SolarRadiationPort_OW1, North) annotation (Line(points={{83.905,
          -67.2},{90,-67.2},{90,6},{110,6}}, color={255,128,0}));
  connect(Bath.SolarRadiationPort_OW2, East) annotation (Line(points={{56.545,-84.24},
          {56.545,-92},{-90,-92},{-90,86},{90,86},{90,-24},{110,-24}}, color={
          255,128,0}));
  connect(Children2.SolarRadiationPort_OW2, East) annotation (Line(points={{-55.1,
          -84.32},{-55.1,-92},{-90,-92},{-90,86},{90,86},{90,-24},{110,-24}},
        color={255,128,0}));
  connect(Children2.SolarRadiationPort_OW1, South) annotation (Line(points={{-83.9,
          -61.6},{-90,-61.6},{-90,86},{90,86},{90,-54},{110,-54}}, color={255,
          128,0}));
  connect(Bedroom.SolarRadiationPort_OW1, South) annotation (Line(points={{-81.9,
          55.6},{-90,55.6},{-90,86},{90,86},{90,-54},{110,-54}}, color={255,128,
          0}));
  connect(Bedroom.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-81.9,
          30},{-90,30},{-90,25},{-115,25}}, color={0,0,127}));
  connect(Children2.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-83.9,
          -36},{-90,-36},{-90,25},{-115,25}}, color={0,0,127}));
  connect(Bath.WindSpeedPort, WindSpeedPort) annotation (Line(points={{83.905,-50.4},
          {90,-50.4},{90,-92},{-90,-92},{-90,25},{-115,25}}, color={0,0,127}));
  connect(Corridor.WindSpeedPort, WindSpeedPort) annotation (Line(points={{81.9,
          -18.5},{90,-18.5},{90,-92},{-90,-92},{-90,25},{-115,25}}, color={0,0,
          127}));
  connect(Children1.WindSpeedPort, WindSpeedPort) annotation (Line(points={{
          81.905,42.4},{90,42.4},{90,-92},{-90,-92},{-90,25},{-115,25}}, color=
          {0,0,127}));
  connect(Bedroom.thermOutside, thermOutside) annotation (Line(points={{-80,
          74.8},{-90,74.8},{-90,74},{-108,74}}, color={191,0,0}));
  connect(Children2.thermOutside, thermOutside) annotation (Line(points={{-82,-80.8},
          {-90,-80.8},{-90,74},{-108,74}}, color={191,0,0}));
  connect(Bath.thermOutside, thermOutside) annotation (Line(points={{82.1,-81.6},
          {82.1,-92},{-90,-92},{-90,74},{-108,74}}, color={191,0,0}));
  connect(Corridor.thermOutside, thermOutside) annotation (Line(points={{80,8.1},
          {86,8.1},{86,8},{90,8},{90,-92},{-90,-92},{-90,74},{-108,74}}, color=
          {191,0,0}));
  connect(Children1.thermOutside, thermOutside) annotation (Line(points={{80.1,
          73.6},{90,73.6},{90,86},{-90,86},{-90,74},{-108,74}}, color={191,0,0}));
  connect(Bedroom.thermCeiling, thermCeiling_Bedroom) annotation (Line(points={
          {-44,62},{-32,62},{-32,86},{-90,86},{-90,109}}, color={191,0,0}));
  connect(Children1.thermCeiling, thermCeiling_Children1) annotation (Line(
        points={{45.9,68.8},{36,68.8},{36,86},{-50,86},{-50,110},{-49,109}},
        color={191,0,0}));
  connect(Corridor.thermCeiling, thermCeiling_Corridor) annotation (Line(points=
         {{44,0.5},{36,0.5},{36,86},{-12,86},{-12,110},{-11,109}}, color={191,0,
          0}));
  connect(Bath.thermCeiling, thermCeiling_Bath) annotation (Line(points={{47.9,
          -76.8},{36,-76.8},{36,-92},{90,-92},{90,86},{29,86},{29,109}}, color=
          {191,0,0}));
  connect(Children2.thermCeiling, thermCeiling_Children2) annotation (Line(
        points={{-46,-68},{-34,-68},{-34,-92},{90,-92},{90,86},{69,86},{69,109}},
        color={191,0,0}));
  connect(Children2.thermInsideWall1a, Bath.thermInsideWall1) annotation (Line(
        points={{-46,-55.2},{-46,-56},{-34,-56},{-34,-92},{36,-92},{36,-62},{
          47.9,-62},{47.9,-62.4}}, color={191,0,0}));
  connect(Children2.thermInsideWall1b, Corridor.thermInsideWall2b) annotation (
      Line(points={{-46,-42.4},{-34,-42.4},{-34,-92},{36,-92},{36,-14},{44,-14},
          {44,-14.7}}, color={191,0,0}));
  connect(Children2.thermInsideWall2, Bedroom.thermInsideWall2) annotation (
      Line(points={{-58,-23.2},{-58,-14},{-90,-14},{-90,6},{-56,6},{-56,17.2}},
        color={191,0,0}));
  connect(Corridor.thermInsideWall3, Bath.thermInsideWall2) annotation (Line(
        points={{56,-26.1},{56,-32},{59.3,-32},{59.3,-38.4}}, color={191,0,0}));
  connect(Children1.thermInsideWall2, Corridor.thermInsideWall1) annotation (
      Line(points={{57.3,30.4},{57.3,18},{64,18},{64,8.1}}, color={191,0,0}));
  connect(Bedroom.SolarRadiationPort_Roof, RoofS) annotation (Line(points={{-47.2,
          78},{-48,78},{-48,86},{90,86},{90,44},{110,44}}, color={255,128,0}));
  connect(Children1.SolarRadiationPort_Roof, RoofN) annotation (Line(points={{
          48.94,76},{48.94,86},{90,86},{90,76},{110,76}}, color={255,128,0}));
  connect(Corridor.SolarRadiationPort_Roof, RoofN) annotation (Line(points={{
          47.2,10},{48,10},{48,18},{90,18},{90,76},{110,76}}, color={255,128,0}));
  connect(Bath.SolarRadiationPort_Roof, RoofN) annotation (Line(points={{50.94,
          -84},{50,-84},{50,-92},{90,-92},{90,76},{110,76}}, color={255,128,0}));
  connect(Bedroom.thermFloor, thermFloor_Bedroom) annotation (Line(points={{-63.2,
          15.92},{-63.2,6},{-90,6},{-90,-92},{-56,-92},{-56,-94},{-56,-94},{-56,
          -110},{-56,-110}}, color={191,0,0}));
  connect(Children1.thermFloor, thermFloor_Children1) annotation (Line(points={
          {64.14,29.44},{64.14,20},{90,20},{90,-92},{-32,-92},{-32,-110}},
        color={191,0,0}));
  connect(Corridor.thermFloor, thermFloor_Corridor) annotation (Line(points={{
          63.2,-26.86},{63.2,-32},{90,-32},{90,-92},{0,-92},{0,-110}}, color={
          191,0,0}));
  connect(Bath.thermFloor, thermFloor_Bath) annotation (Line(points={{66.14,-37.44},
          {66.14,-32},{90,-32},{90,-92},{30,-92},{30,-110}}, color={191,0,0}));
  connect(Children2.thermFloor, thermFloor_Children2) annotation (Line(points={
          {-65.2,-21.92},{-65.2,-14},{-90,-14},{-90,-92},{70,-92},{70,-110}},
        color={191,0,0}));
  connect(Corridor.thermRoom, thermCorridor) annotation (Line(points={{66,-5.2},
          {66,-14},{90,-14},{90,-110},{110,-110}}, color={191,0,0}));
  connect(Bedroom.AirExchangePort, AirExchangePort[1]) annotation (Line(points=
          {{-67.3,76.88},{-67.3,86},{-90,86},{-90,-22.25},{-115,-22.25}}, color=
         {0,0,127}));
  connect(Children1.AirExchangePort, AirExchangePort[2]) annotation (Line(
        points={{66.895,75.64},{66.895,86},{-90,86},{-90,-14.75},{-115,-14.75}},
        color={0,0,127}));
  connect(Bath.AirExchangePort, AirExchangePort[3]) annotation (Line(points={{
          68.895,-83.64},{68.895,-92},{-90,-92},{-90,-7.25},{-115,-7.25}},
        color={0,0,127}));
  connect(Children2.AirExchangePort, AirExchangePort[4]) annotation (Line(
        points={{-69.3,-82.88},{-69.3,-92},{-90,-92},{-90,0.25},{-115,0.25}},
        color={0,0,127}));
  connect(Children1.starRoom, StarChildren1) annotation (Line(
      points={{59.2,56.8},{59.2,46},{36,46},{36,40},{20,40}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(Children1.thermRoom, ThermChildren1) annotation (Line(points={{66.8,
          56.8},{66.8,46},{36,46},{36,60},{20,60}}, color={191,0,0}));
  connect(Bedroom.thermInsideWall1a, Children1.thermInsideWall1) annotation (
      Line(points={{-44,49.2},{-32,49.2},{-32,86},{36,86},{36,54.4},{45.9,54.4}},
        color={191,0,0}));
  connect(Bedroom.thermRoom, ThermBedroom) annotation (Line(points={{-66,52.4},
          {-66,28},{-32,28},{-32,60},{-20,60}}, color={191,0,0}));
  connect(Bedroom.starRoom, StarBedroom) annotation (Line(
      points={{-58,52.4},{-58,28},{-32,28},{-32,40},{-20,40}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(Bedroom.thermInsideWall1b, Corridor.thermInsideWall2a) annotation (
      Line(points={{-44,36.4},{-32,36.4},{-32,86},{36,86},{36,-7.1},{44,-7.1}},
        color={191,0,0}));
  connect(Children2.starRoom, StarChildren2) annotation (Line(
      points={{-60,-58.4},{-60,-34},{-34,-34},{-34,-60},{-20,-60}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(Children2.thermRoom, ThermChildren2) annotation (Line(points={{-68,-58.4},
          {-68,-34},{-34,-34},{-34,-40},{-20,-40}}, color={191,0,0}));
  connect(Bath.starRoom, StarBath) annotation (Line(
      points={{61.2,-64.8},{61.2,-52},{36,-52},{36,-60},{20,-60}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(Bath.thermRoom, ThermBath) annotation (Line(points={{68.8,-64.8},{
          68.8,-52},{36,-52},{36,-40},{20,-40}}, color={191,0,0}));
  connect(Children2.SolarRadiationPort_Roof, RoofS) annotation (Line(points={{-49.2,
          -84},{-50,-84},{-50,-92},{90,-92},{90,44},{110,44}}, color={255,128,0}));
  connect(Corridor.AirExchangePort, AirExchangePort_doorSt.y) annotation (Line(
        points={{82,-10.71},{90,-10.71},{90,-92},{-90,-92},{-90,-60},{-99.2,-60}},
        color={0,0,127}));
  connect(Bedroom.thermFloorHeatingDownHeatFlow, thermFloorHeatingDownHeatFlow[
    1]) annotation (Line(
      points={{-71.2,19.76},{-71.2,-2},{-88,-2},{-88,-100.5},{-96,-100.5}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(Children1.thermFloorHeatingDownHeatFlow,
    thermFloorHeatingDownHeatFlow[2]) annotation (Line(
      points={{71.74,32.32},{71.74,22},{-4,22},{-4,-2},{-88,-2},{-88,-97.5},{-96,
          -97.5}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(Bath.thermFloorHeatingDownHeatFlow, thermFloorHeatingDownHeatFlow[3])
    annotation (Line(
      points={{73.74,-40.32},{73.74,-30},{-4,-30},{-4,-2},{-88,-2},{-88,-94.5},
          {-96,-94.5}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(Children2.thermFloorHeatingDownHeatFlow,
    thermFloorHeatingDownHeatFlow[4]) annotation (Line(
      points={{-73.2,-25.76},{-73.2,-2},{-88,-2},{-88,-91.5},{-96,-91.5}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Bitmap(extent={{-100,-100},{100,100}}, fileName=
              "modelica://AixLib/Resources/Images/Building/HighOrder/Upperfloor_icon.png"),
        Text(
          extent={{-56,74},{-4,60}},
          lineColor={0,0,0},
          textString="Bedroom"),
        Text(
          extent={{16,76},{62,66}},
          lineColor={0,0,0},
          textString="Children1"),
        Text(
          extent={{22,28},{64,14}},
          lineColor={0,0,0},
          textString="Corridor"),
        Text(
          extent={{22,-42},{58,-56}},
          lineColor={0,0,0},
          textString="Bath"),
        Text(
          extent={{-62,-2},{-6,-16}},
          lineColor={0,0,0},
          textString="Children2")}), Documentation(revisions="<html>

 <ul>
 <li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
 <li><i>July 10, 2011</i> by Ana Constantin:<br/>Implemented</li>

 </ul>

 </html>", info="<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for the envelope of the upper floor.</p>
 </html>"));
end UpperFloorBuildingEnvelope;
