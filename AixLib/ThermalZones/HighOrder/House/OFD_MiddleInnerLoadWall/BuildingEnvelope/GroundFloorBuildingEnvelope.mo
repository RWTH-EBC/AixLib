within AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope;
model GroundFloorBuildingEnvelope
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
      groupImage = "modelica://AixLib/Resources/Images/Building/HighOrder/Groundfloor_5Rooms.png",
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
  parameter Modelica.SIunits.Length room_width=if TIR == 1 then 3.86 else 3.97
    "width" annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Height room_height=2.60 "height"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length length1=if TIR == 1 then 3.23 else 3.34
    "l1 " annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length length2=2.44 "l2 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length length3=1.33 "l3 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length length4=if TIR == 1 then 3.23 else 3.34
    "l4 " annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length thickness_IWsimple=0.145
    "thickness IWsimple "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  // Outer walls properties
  parameter Real solar_absorptance_OW=0.6 "Solar absoptance outer walls "
    annotation (Dialog(group="Outer wall properties", descriptionLabel=true));

  //Windows and Doors
  parameter Modelica.SIunits.Area windowarea_11=8.44 " Area Window11"
    annotation (Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.SIunits.Area windowarea_12=1.73 " Area Window12  "
    annotation (Dialog(group="Windows and Doors", descriptionLabel=true));
  parameter Modelica.SIunits.Area windowarea_22=1.73 " Area Window22"
    annotation (Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.SIunits.Area windowarea_41=1.4 " Area Window41  "
    annotation (Dialog(group="Windows and Doors", descriptionLabel=true));
  parameter Modelica.SIunits.Area windowarea_51=3.46 " Area Window51"
    annotation (Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.SIunits.Area windowarea_52=1.73 " Area Window52  "
    annotation (Dialog(group="Windows and Doors", descriptionLabel=true));
  parameter Modelica.SIunits.Length door_width_31=1.01 "Width Door31"
    annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true));
  parameter Modelica.SIunits.Length door_height_31=2.25 "Height Door31  "
    annotation (Dialog(group="Windows and Doors", descriptionLabel=true));
  parameter Modelica.SIunits.Length door_width_42=1.25 "Width Door42"
    annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true));
  parameter Modelica.SIunits.Length door_height_42=2.25 "Height Door42  "
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
  parameter Modelica.SIunits.Temperature Tset_Livingroom=295.15
    "Tset_livingroom" annotation (Dialog(
      group="Dynamic ventilation",
      descriptionLabel=true,
      joinNext=true,
      enable=if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.Temperature Tset_Hobby=295.15 "Tset_hobby"
    annotation (Dialog(
      group="Dynamic ventilation",
      descriptionLabel=true,
      enable=if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.Temperature Tset_WC=291.15 "Tset_WC" annotation (
      Dialog(
      group="Dynamic ventilation",
      descriptionLabel=true,
      joinNext=true,
      enable=if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.Temperature Tset_Kitchen=295.15 "Tset_kitchen"
    annotation (Dialog(
      group="Dynamic ventilation",
      descriptionLabel=true,
      enable=if withDynamicVentilation then true else false));
  Modelica.Blocks.Sources.Constant AirExchangePort_doorSt(k=0) "Storage"
    annotation (Placement(transformation(extent={{-116,-68},{-100,-52}})));
  Rooms.OFD.Ow2IwL2IwS1Gr1Uf1 Livingroom(
    TMC=TMC,
    TIR=TIR,
    room_lengthb=length2,
    room_width=room_width,
    room_height=room_height,
    room_length=length1 + length2 + thickness_IWsimple,
    solar_absorptance_OW=solar_absorptance_OW,
    windowarea_OW1=windowarea_11,
    windowarea_OW2=windowarea_12,
    withDoor1=false,
    withDoor2=false,
    withWindow1=true,
    withWindow2=true,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withFloorHeating=withFloorHeating,
    withDynamicVentilation=withDynamicVentilation,
    HeatingLimit=HeatingLimit,
    Max_VR=Max_VR,
    Diff_toTempset=Diff_toTempset,
    Tset=Tset_Livingroom,
    T0_air=295.15,
    T0_OW1=295.15,
    T0_OW2=295.15,
    T0_IW1a=295.15,
    T0_IW1b=295.15,
    T0_IW2=295.15,
    T0_CE=295.13,
    T0_FL=295.13)
    annotation (Placement(transformation(extent={{-86,14},{-42,78}})));
  Rooms.OFD.Ow2IwL1IwS1Gr1Uf1 Hobby(
    TMC=TMC,
    TIR=TIR,
    room_length=length1,
    room_width=room_width,
    room_height=room_height,
    solar_absorptance_OW=solar_absorptance_OW,
    windowarea_OW2=windowarea_22,
    withDoor1=false,
    withDoor2=false,
    withWindow1=false,
    withWindow2=true,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withFloorHeating=withFloorHeating,
    withDynamicVentilation=withDynamicVentilation,
    HeatingLimit=HeatingLimit,
    Max_VR=Max_VR,
    Diff_toTempset=Diff_toTempset,
    Tset=Tset_Hobby,
    T0_air=295.15,
    T0_OW1=295.15,
    T0_OW2=295.15,
    T0_IW1=295.15,
    T0_IW2=295.15,
    T0_CE=295.13,
    T0_FL=295.13)
    annotation (Placement(transformation(extent={{84,28},{46,76}})));
  Rooms.OFD.Ow2IwL1IwS1Gr1Uf1 WC_Storage(
    TMC=TMC,
    TIR=TIR,
    room_length=length4,
    room_width=room_width,
    room_height=room_height,
    solar_absorptance_OW=solar_absorptance_OW,
    withWindow1=true,
    windowarea_OW1=windowarea_41,
    withDoor2=true,
    door_width_OD2=door_width_42,
    door_height_OD2=door_height_42,
    withWindow2=false,
    withDoor1=false,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withFloorHeating=withFloorHeating,
    withDynamicVentilation=withDynamicVentilation,
    HeatingLimit=HeatingLimit,
    Max_VR=Max_VR,
    Diff_toTempset=Diff_toTempset,
    Tset=Tset_WC,
    T0_air=291.15,
    T0_OW1=291.15,
    T0_OW2=291.15,
    T0_IW1=291.15,
    T0_IW2=291.15,
    T0_CE=291.13,
    T0_FL=291.13)
    annotation (Placement(transformation(extent={{84,-36},{46,-84}})));
  Rooms.OFD.Ow2IwL2IwS1Gr1Uf1 Kitchen(
    TMC=TMC,
    TIR=TIR,
    room_length=length3 + length4 + thickness_IWsimple,
    room_width=room_width,
    room_height=room_height,
    solar_absorptance_OW=solar_absorptance_OW,
    withWindow1=true,
    windowarea_OW1=windowarea_51,
    withWindow2=true,
    windowarea_OW2=windowarea_52,
    room_lengthb=length3,
    withDoor1=false,
    withDoor2=false,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withFloorHeating=withFloorHeating,
    withDynamicVentilation=withDynamicVentilation,
    HeatingLimit=HeatingLimit,
    Max_VR=Max_VR,
    Diff_toTempset=Diff_toTempset,
    Tset=Tset_Kitchen,
    T0_air=295.15,
    T0_OW1=295.15,
    T0_OW2=295.15,
    T0_IW1a=295.15,
    T0_IW1b=295.15,
    T0_IW2=295.15,
    T0_CE=295.13,
    T0_FL=295.13)
    annotation (Placement(transformation(extent={{-84,-20},{-44,-84}})));
  Rooms.OFD.Ow1IwL2IwS1Gr1Uf1 Corridor(
    TMC=TMC,
    TIR=TIR,
    room_length=length2 + length3 + thickness_IWsimple,
    room_width=room_width,
    room_height=room_height,
    solar_absorptance_OW=solar_absorptance_OW,
    withDoor1=true,
    door_width_OD1=door_width_31,
    door_height_OD1=door_height_31,
    room_lengthb=length3,
    withWindow1=false,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withFloorHeating=withFloorHeating,
    T0_air=291.15,
    T0_OW1=291.15,
    T0_IW1=291.15,
    T0_IW2a=291.15,
    T0_IW2b=291.15,
    T0_IW3=291.15,
    T0_CE=291.13,
    T0_FL=291.13)
    annotation (Placement(transformation(extent={{82,-28},{42,10}})));
  Utilities.Interfaces.SolarRad_in North annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,88})));
  Utilities.Interfaces.SolarRad_in East annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,60})));
  Utilities.Interfaces.SolarRad_in South annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,26})));
  Utilities.Interfaces.SolarRad_in West annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-16})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort
    annotation (Placement(transformation(extent={{-130,12},{-100,42}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort[4]
    "1: LivingRoom_GF, 2: Hobby_GF, 3: WC_Storage_GF, 4: Kitchen_GF"
    annotation (Placement(transformation(extent={{-130,-18},{-100,12}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
    annotation (Placement(transformation(extent={{-116,66},{-100,82}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Livingroom
    annotation (Placement(transformation(extent={{-100,100},{-84,118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Hobby
    annotation (Placement(transformation(extent={{-58,100},{-40,118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Corridor
    annotation (Placement(transformation(extent={{-20,100},{-2,118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_WCStorage
    annotation (Placement(transformation(extent={{20,100},{38,118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Kitchen
    annotation (Placement(transformation(extent={{62,100},{80,118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor
    annotation (Placement(transformation(extent={{100,100},{120,120}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermLivingroom
    annotation (Placement(transformation(extent={{-26,54},{-14,66}}),
        iconTransformation(extent={{-28,56},{-14,66}})));
  Utilities.Interfaces.Star StarLivingroom
    annotation (Placement(transformation(extent={{-28,32},{-12,48}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermHobby
    annotation (Placement(transformation(extent={{14,54},{26,66}})));
  Utilities.Interfaces.Star StarHobby
    annotation (Placement(transformation(extent={{12,32},{28,48}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermCorridor annotation (
     Placement(transformation(extent={{8,-2},{20,10}}), iconTransformation(
          extent={{8,-2},{20,10}})));
  Utilities.Interfaces.Star StarCorridor annotation (Placement(transformation(
          extent={{6,-24},{22,-8}}), iconTransformation(extent={{6,-24},{22,-8}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermWC_Storage
    annotation (Placement(transformation(extent={{16,-56},{28,-44}}),
        iconTransformation(extent={{16,-56},{28,-44}})));
  Utilities.Interfaces.Star StarWC_Storage annotation (Placement(transformation(
          extent={{14,-78},{30,-62}}), iconTransformation(extent={{14,-78},{30,
            -62}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermKitchen annotation (
      Placement(transformation(extent={{-24,-56},{-12,-44}}),
        iconTransformation(extent={{-24,-56},{-12,-44}})));
  Utilities.Interfaces.Star StarKitchen annotation (Placement(transformation(
          extent={{-26,-78},{-10,-62}}), iconTransformation(extent={{-26,-78},{
            -10,-62}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    thermFloorHeatingDownHeatFlow[5] if                                withFloorHeating
    "Thermal connector for heat flow of floor heating going downwards through the wall/floor/ceiling. 1: LivingRoom_GF, 2: Hobby_GF, 3: Corridor_GF, 4: WC_Storage_GF, 5: Kitchen_GF"
    annotation (Placement(transformation(extent={{-102,-100},{-90,-88}}),
        iconTransformation(extent={{-100,-100},{-86,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a groundTemp[5]
    "HeatPort to force a ground temperature for the ground level's floor."
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
equation
  connect(Livingroom.SolarRadiationPort_OW2, West) annotation (Line(points={{-52.89,
          77.68},{-52.89,86},{90,86},{90,-16},{110,-16}}, color={255,128,0}));
  connect(Hobby.SolarRadiationPort_OW2, West) annotation (Line(points={{55.405,
          75.76},{55.405,86},{90,86},{90,-16},{110,-16}}, color={255,128,0}));
  connect(Hobby.SolarRadiationPort_OW1, North) annotation (Line(points={{83.905,
          59.2},{90,59.2},{90,88},{110,88}}, color={255,128,0}));
  connect(Corridor.SolarRadiationPort_OW1, North) annotation (Line(points={{
          81.9,2.4},{90,2.4},{90,88},{110,88}}, color={255,128,0}));
  connect(WC_Storage.SolarRadiationPort_OW1, North) annotation (Line(points={{
          83.905,-67.2},{90,-67.2},{90,88},{110,88}}, color={255,128,0}));
  connect(WC_Storage.SolarRadiationPort_OW2, East) annotation (Line(points={{
          55.405,-83.76},{55.405,-92},{-90,-92},{-90,86},{90,86},{90,60},{110,
          60}}, color={255,128,0}));
  connect(Kitchen.SolarRadiationPort_OW2, East) annotation (Line(points={{-53.9,
          -83.68},{-53.9,-92},{-90,-92},{-90,86},{90,86},{90,60},{110,60}},
        color={255,128,0}));
  connect(Livingroom.SolarRadiationPort_OW1, South) annotation (Line(points={{-85.89,
          55.6},{-90,55.6},{-90,86},{90,86},{90,26},{110,26}}, color={255,128,0}));
  connect(Livingroom.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-85.89,
          33.2},{-90,33.2},{-90,27},{-115,27}}, color={0,0,127}));
  connect(Kitchen.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-83.9,
          -39.2},{-90,-39.2},{-90,27},{-115,27}}, color={0,0,127}));
  connect(WC_Storage.WindSpeedPort, WindSpeedPort) annotation (Line(points={{
          83.905,-50.4},{90,-50.4},{90,-92},{-90,-92},{-90,27},{-115,27}},
        color={0,0,127}));
  connect(Corridor.WindSpeedPort, WindSpeedPort) annotation (Line(points={{81.9,
          -20.4},{90,-20.4},{90,-92},{-90,-92},{-90,27},{-115,27}}, color={0,0,
          127}));
  connect(Hobby.WindSpeedPort, WindSpeedPort) annotation (Line(points={{83.905,
          42.4},{90,42.4},{90,-92},{-90,-92},{-90,27},{-115,27}}, color={0,0,
          127}));
  connect(Livingroom.thermOutside, thermOutside) annotation (Line(points={{-83.8,
          74.8},{-90,74.8},{-90,74},{-108,74}}, color={191,0,0}));
  connect(Kitchen.thermOutside, thermOutside) annotation (Line(points={{-82,-80.8},
          {-90,-80.8},{-90,74},{-108,74}}, color={191,0,0}));
  connect(WC_Storage.thermOutside, thermOutside) annotation (Line(points={{82.1,
          -81.6},{82.1,-92},{-90,-92},{-90,74},{-108,74}}, color={191,0,0}));
  connect(Corridor.thermOutside, thermOutside) annotation (Line(points={{80,8.1},
          {86,8.1},{86,8},{90,8},{90,-92},{-90,-92},{-90,74},{-108,74}}, color=
          {191,0,0}));
  connect(Hobby.thermOutside, thermOutside) annotation (Line(points={{82.1,73.6},
          {90,73.6},{90,86},{-90,86},{-90,74},{-108,74}}, color={191,0,0}));
  connect(Livingroom.thermCeiling, thermCeiling_Livingroom) annotation (Line(
        points={{-44.2,68.4},{-32,68.4},{-32,86},{-92,86},{-92,109}}, color={
          191,0,0}));
  connect(Livingroom.thermInsideWall1a, Hobby.thermInsideWall1) annotation (
      Line(points={{-44.2,55.6},{-32,55.6},{-32,86},{36,86},{36,54.4},{47.9,
          54.4}}, color={191,0,0}));
  connect(Hobby.thermCeiling, thermCeiling_Hobby) annotation (Line(points={{
          47.9,68.8},{36,68.8},{36,86},{-50,86},{-50,109},{-49,109}}, color={
          191,0,0}));
  connect(Corridor.thermCeiling, thermCeiling_Corridor) annotation (Line(points=
         {{44,4.3},{36,4.3},{36,86},{-10,86},{-10,109},{-11,109}}, color={191,0,
          0}));
  connect(WC_Storage.thermCeiling, thermCeiling_WCStorage) annotation (Line(
        points={{47.9,-76.8},{36,-76.8},{36,-92},{90,-92},{90,86},{29,86},{29,
          109}}, color={191,0,0}));
  connect(Kitchen.thermCeiling, thermCeiling_Kitchen) annotation (Line(points={
          {-46,-74.4},{-34,-74.4},{-34,-92},{90,-92},{90,86},{71,86},{71,109}},
        color={191,0,0}));
  connect(Kitchen.thermInsideWall1a, WC_Storage.thermInsideWall1) annotation (
      Line(points={{-46,-61.6},{-34,-61.6},{-34,-92},{36,-92},{36,-62},{47.9,-62},
          {47.9,-62.4}}, color={191,0,0}));
  connect(Livingroom.thermInsideWall1b, Corridor.thermInsideWall2a) annotation (
     Line(points={{-44.2,42.8},{-32,42.8},{-32,86},{36,86},{36,-3.3},{44,-3.3}},
        color={191,0,0}));
  connect(Kitchen.thermInsideWall2, Livingroom.thermInsideWall2) annotation (
      Line(points={{-58,-23.2},{-58,-14},{-90,-14},{-90,6},{-57.4,6},{-57.4,
          17.2}}, color={191,0,0}));
  connect(Corridor.thermInsideWall3, WC_Storage.thermInsideWall2) annotation (
      Line(points={{53.2,-26.86},{53.2,-32},{59.3,-32},{59.3,-38.4}}, color={
          191,0,0}));
  connect(Hobby.thermInsideWall2, Corridor.thermInsideWall1) annotation (Line(
        points={{59.3,30.4},{59.3,22},{90,22},{90,14},{56,14},{56,8.1}}, color=
          {191,0,0}));
  connect(Corridor.thermRoom, thermCorridor) annotation (Line(points={{66,-5.2},
          {66,-32},{90,-32},{90,100},{110,100},{110,110}}, color={191,0,0}));
  connect(Hobby.starRoom, StarHobby) annotation (Line(
      points={{61.2,56.8},{61.2,44},{36,44},{36,40},{20,40}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(Corridor.starRoom, StarCorridor) annotation (Line(
      points={{58,-5.2},{58,-16},{14,-16}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(Corridor.thermRoom, ThermCorridor) annotation (Line(points={{66,-5.2},
          {66,14},{36,14},{36,4},{14,4}}, color={191,0,0}));
  connect(Hobby.thermRoom, ThermHobby) annotation (Line(points={{69.18,56.8},{
          69.18,44},{36,44},{36,60},{20,60}}, color={191,0,0}));
  connect(ThermLivingroom, Livingroom.thermRoom) annotation (Line(points={{-20,
          60},{-32,60},{-32,48},{-68.4,48},{-68.4,52.4}}, color={191,0,0}));
  connect(Livingroom.AirExchangePort, AirExchangePort[1]) annotation (Line(
        points={{-68.51,77.52},{-68.51,86},{-90,86},{-90,-14.25},{-115,-14.25}},
        color={0,0,127}));
  connect(Hobby.AirExchangePort, AirExchangePort[2]) annotation (Line(points={{
          68.895,75.64},{68.895,86},{-90,86},{-90,-6.75},{-115,-6.75}}, color={
          0,0,127}));
  connect(Kitchen.SolarRadiationPort_OW1, South) annotation (Line(points={{-83.9,
          -61.6},{-90,-61.6},{-90,-92},{90,-92},{90,26},{110,26}}, color={255,
          128,0}));
  connect(Corridor.thermInsideWall2b, Kitchen.thermInsideWall1b) annotation (
      Line(points={{44,-10.9},{36,-10.9},{36,-92},{-34,-92},{-34,-48.8},{-46,-48.8}},
        color={191,0,0}));
  connect(WC_Storage.starRoom, StarWC_Storage) annotation (Line(
      points={{61.2,-64.8},{61.2,-70},{36,-70},{36,-70},{22,-70}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(WC_Storage.thermRoom, ThermWC_Storage) annotation (Line(points={{
          69.18,-64.8},{69.18,-70},{36,-70},{36,-50},{22,-50}}, color={191,0,0}));
  connect(WC_Storage.AirExchangePort, AirExchangePort[3]) annotation (Line(
        points={{68.895,-83.64},{68.895,-92},{-90,-92},{-90,0.75},{-115,0.75}},
        color={0,0,127}));
  connect(Kitchen.AirExchangePort, AirExchangePort[4]) annotation (Line(points=
          {{-68.1,-83.52},{-68.1,-92},{-90,-92},{-90,8.25},{-115,8.25}}, color=
          {0,0,127}));
  connect(Kitchen.starRoom, StarKitchen) annotation (Line(
      points={{-60,-58.4},{-60,-54},{-34,-54},{-34,-70},{-18,-70}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(Kitchen.thermRoom, ThermKitchen) annotation (Line(points={{-68,-58.4},
          {-68,-54},{-34,-54},{-34,-50},{-18,-50}}, color={191,0,0}));
  connect(Corridor.AirExchangePort, AirExchangePort_doorSt.y) annotation (Line(
        points={{82,-12.8},{90,-12.8},{90,-92},{-90,-92},{-90,-60},{-99.2,-60}},
        color={0,0,127}));
  connect(Livingroom.starRoom, StarLivingroom) annotation (Line(
      points={{-59.6,52.4},{-59.6,48},{-32,48},{-32,40},{-20,40}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(Livingroom.thermFloorHeatingDownHeatFlow,
    thermFloorHeatingDownHeatFlow[1]) annotation (Line(
      points={{-74.12,19.76},{-74.12,12},{-88,12},{-88,-98.8},{-96,-98.8}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(Hobby.thermFloorHeatingDownHeatFlow, thermFloorHeatingDownHeatFlow[2])
    annotation (Line(
      points={{73.74,32.32},{73.74,24},{-8,24},{-8,2},{-88,2},{-88,-96.4},{-96,
          -96.4}},
      color={191,0,0},
      pattern=LinePattern.Dash));

  connect(Corridor.thermFloorHeatingDownHeatFlow, thermFloorHeatingDownHeatFlow[
    3]) annotation (Line(
      points={{71.2,-24.58},{71.2,-30},{-8,-30},{-8,2},{-88,2},{-88,-94},{-96,-94}},
      color={191,0,0},
      pattern=LinePattern.Dash));

  connect(WC_Storage.thermFloorHeatingDownHeatFlow,
    thermFloorHeatingDownHeatFlow[4]) annotation (Line(
      points={{73.74,-40.32},{73.74,-30},{-8,-30},{-8,2},{-88,2},{-88,-91.6},{-96,
          -91.6}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(Kitchen.thermFloorHeatingDownHeatFlow, thermFloorHeatingDownHeatFlow[
    5]) annotation (Line(
      points={{-73.2,-25.76},{-73.2,2},{-88,2},{-88,-89.2},{-96,-89.2}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(Livingroom.ground, groundTemp[1]) annotation (Line(points={{-65.32,
          15.92},{-65.32,-4},{0,-4},{0,-108}}, color={191,0,0}));
  connect(Hobby.ground, groundTemp[2]) annotation (Line(points={{66.14,29.44},{
          66.14,26},{0,26},{0,-104},{0,-104}}, color={191,0,0}));
  connect(Corridor.ground, groundTemp[3]) annotation (Line(points={{63.2,-26.86},
          {63.2,-34},{0,-34},{0,-100}}, color={191,0,0}));
  connect(WC_Storage.ground, groundTemp[4]) annotation (Line(points={{66.14,-37.44},
          {66.14,-34},{0,-34},{0,-96},{0,-96}}, color={191,0,0}));
  connect(Kitchen.ground, groundTemp[5]) annotation (Line(points={{-65.2,-21.92},
          {-65.2,-4},{0,-4},{0,-92}},         color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Bitmap(extent={{-100,-100},{100,100}}, fileName=
              "modelica://AixLib/Resources/Images/Building/HighOrder/Groundfloor_icon.png"),
        Text(
          extent={{-66,66},{10,54}},
          lineColor={0,0,0},
          textString="Livingroom"),
        Text(
          extent={{14,76},{64,62}},
          lineColor={0,0,0},
          textString="Hobby"),
        Text(
          extent={{22,24},{56,14}},
          lineColor={0,0,0},
          textString="Corridor"),
        Text(
          extent={{-2,-42},{74,-52}},
          lineColor={0,0,0},
          textString="WC_Storage"),
        Text(
          extent={{-50,-10},{-6,-24}},
          lineColor={0,0,0},
          textString="Kitchen")}), Documentation(revisions="<html>
 <ul>
 <li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
 <li><i>July 10, 2011</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>", info="<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for the envelope of the ground floor.</p>
<p><b><span style=\"color: #008000;\">Ground temperature</span></b> </p>
<p>The ground temperature can be coupled to any desired prescriped temperature. Anyway, suitable ground temperatures depending on locations in Germany are listed as &Theta;'_m,e in the comprehensive table 1 in &quot;Beiblatt 1&quot; in the norm DIN EN 12831.</p>
<p>Or a ground temperature can be chosen according to a TRY region, which is listed below: if ...</p><p>TRY_Region == 1 then 282.15 K</p><p>TRY_Region == 2 then 281.55 K</p><p>TRY_Region == 3 then 281.65 K</p><p>TRY_Region == 4 then 282.65 K</p><p>TRY_Region == 5 then 281.25 K</p><p>TRY_Region == 6 then 279.95 K</p><p>TRY_Region == 7 then 281.95 K</p><p>TRY_Region == 8 then 279.95 K</p><p>TRY_Region == 9 then 281.05 K</p><p>TRY_Region == 10 then 276.15 K</p><p>TRY_Region == 11 then 279.45 K</p><p>TRY_Region == 12 then 283.35 K</p><p>TRY_Region == 13 then 281.05 K</p><p>TRY_Region == 14 then 281.05 K</p><p>TRY_Region == 15 then 279.95 K </p>
 </html>"));
end GroundFloorBuildingEnvelope;
