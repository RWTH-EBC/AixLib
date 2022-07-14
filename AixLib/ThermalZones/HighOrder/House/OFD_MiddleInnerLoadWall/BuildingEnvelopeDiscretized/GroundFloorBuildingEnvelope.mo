within AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelopeDiscretized;
model GroundFloorBuildingEnvelope

  extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoomParams(
    final Tset=372.15,
    withDynamicVentilation=false,                                               redeclare replaceable parameter
      AixLib.DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes);
  parameter Integer dis = 1 "Discretisation layers for underfloor heating" annotation (Dialog(enable = use_UFH));

  //////////room geometry
  parameter Modelica.Units.SI.Length room_width=3.92
    "width" annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Height room_height=2.60 "height"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Length length1=3.3
    "l1 " annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Length length2=2.44 "l2 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Length length3=1.33 "l3 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Length length4=3.3
    "l4 " annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Length thickness_IWsimple=0.145
    "thickness IWsimple "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));

  //Windows and Doors
  parameter Modelica.Units.SI.Area windowarea_11=8.44 " Area Window11"
    annotation (Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Area windowarea_12=1.73 " Area Window12  "
    annotation (Dialog(group="Windows and Doors", descriptionLabel=true));
  parameter Modelica.Units.SI.Area windowarea_22=1.73 " Area Window22"
    annotation (Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Area windowarea_41=1.4 " Area Window41  "
    annotation (Dialog(group="Windows and Doors", descriptionLabel=true));
  parameter Modelica.Units.SI.Area windowarea_51=3.46 " Area Window51"
    annotation (Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Area windowarea_52=1.73 " Area Window52  "
    annotation (Dialog(group="Windows and Doors", descriptionLabel=true));
  parameter Modelica.Units.SI.Length door_width_31=1.01 "Width Door31"
    annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true));
  parameter Modelica.Units.SI.Length door_height_31=2.25 "Height Door31  "
    annotation (Dialog(group="Windows and Doors", descriptionLabel=true));
  parameter Modelica.Units.SI.Length door_width_42=1.25 "Width Door42"
    annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true));
  parameter Modelica.Units.SI.Length door_height_42=2.25 "Height Door42  "
    annotation (Dialog(group="Windows and Doors", descriptionLabel=true));

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer UValOutDoors "U-value (thermal transmittance) of doors in outer walls" annotation (
     Dialog(
      tab="Outer walls",
      group="Doors"));
  parameter Modelica.Units.SI.Emissivity epsOutDoors(min=0, max=1)=0.95 "Emissivity of inside surface of outer doors" annotation (
     Dialog(
      tab="Outer walls",
      group="Doors"));

  // Dynamic Ventilation
  parameter Modelica.Units.SI.Temperature Tset_Livingroom=295.15
    "Tset_livingroom" annotation (Dialog(
      tab="Dynamic ventilation",
      descriptionLabel=true,
      joinNext=true,
      enable=withDynamicVentilation));
  parameter Modelica.Units.SI.Temperature Tset_Hobby=295.15 "Tset_hobby"
    annotation (Dialog(
      tab="Dynamic ventilation",
      descriptionLabel=true,
      enable=withDynamicVentilation));
  parameter Modelica.Units.SI.Temperature Tset_Corridor=291.15 "Tset_corridor"
    annotation (Dialog(
      tab="Dynamic ventilation",
      descriptionLabel=true,
      enable=withDynamicVentilation));
  parameter Modelica.Units.SI.Temperature Tset_WC=291.15 "Tset_WC" annotation (
      Dialog(
      tab="Dynamic ventilation",
      descriptionLabel=true,
      joinNext=true,
      enable=withDynamicVentilation));
  parameter Modelica.Units.SI.Temperature Tset_Kitchen=295.15 "Tset_kitchen"
    annotation (Dialog(
      tab="Dynamic ventilation",
      descriptionLabel=true,
      enable=withDynamicVentilation));

  Rooms.Ow2IwL2IwS1Gr1Uf1 Livingroom(
    final denAir=denAir,
    final cAir=cAir,
    final wallTypes=wallTypes,
    energyDynamicsWalls=energyDynamicsWalls,
    final TWalls_start=TWalls_start,
    final calcMethodIn=calcMethodIn,
    final hConIn_const=hConIn_const,
    redeclare model WindowModel = WindowModel,
    final Type_Win=Type_Win,
    redeclare model CorrSolarGainWin = CorrSolarGainWin,
    final calcMethodOut=calcMethodOut,
    final surfaceType=surfaceType,
    final hConOut_const=hConOut_const,
    final use_infiltEN12831=use_infiltEN12831,
    final n50=n50,
    final e=e,
    final eps=eps,
    dis=dis,
    final U_door_OD1=UValOutDoors,
    final eps_door_OD1=epsOutDoors,
    room_lengthb=length2,
    room_width=room_width,
    room_height=room_height,
    room_length=length1 + length2 + thickness_IWsimple,
    final solar_absorptance_OW=solar_absorptance_OW,
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
    withDynamicVentilation=withDynamicVentilation,
    HeatingLimit=HeatingLimit,
    Max_VR=Max_VR,
    Diff_toTempset=Diff_toTempset,
    Tset=Tset_Livingroom,
    final T0_air=T0_air,
    final U_door_OD2=UValOutDoors,
    final eps_door_OD2=epsOutDoors,
    final use_UFH=use_UFH)
    annotation (Placement(transformation(extent={{-84,12},{-40,76}})));
  Rooms.Ow2IwL1IwS1Gr1Uf1 Hobby(
    final denAir=denAir,
    final cAir=cAir,
    final wallTypes=wallTypes,
    energyDynamicsWalls=energyDynamicsWalls,
    final TWalls_start=TWalls_start,
    final calcMethodIn=calcMethodIn,
    final hConIn_const=hConIn_const,
    redeclare model WindowModel = WindowModel,
    final Type_Win=Type_Win,
    redeclare model CorrSolarGainWin = CorrSolarGainWin,
    final calcMethodOut=calcMethodOut,
    final surfaceType=surfaceType,
    final hConOut_const=hConOut_const,
    final use_infiltEN12831=use_infiltEN12831,
    final n50=n50,
    final e=e,
    final eps=eps,
    dis=dis,
    room_length=length1,
    room_width=room_width,
    room_height=room_height,
    final solar_absorptance_OW=solar_absorptance_OW,
    final U_door_OD1=UValOutDoors,
    final eps_door_OD1=epsOutDoors,
    windowarea_OW2=windowarea_22,
    withDoor1=false,
    withDoor2=false,
    withWindow1=false,
    withWindow2=true,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDynamicVentilation=withDynamicVentilation,
    HeatingLimit=HeatingLimit,
    Max_VR=Max_VR,
    Diff_toTempset=Diff_toTempset,
    Tset=Tset_Hobby,
    final T0_air=T0_air,
    final U_door_OD2=UValOutDoors,
    final eps_door_OD2=epsOutDoors,
    final use_UFH=use_UFH)
    annotation (Placement(transformation(extent={{84,28},{46,76}})));
  Rooms.Ow2IwL1IwS1Gr1Uf1 WC_Storage(
    final denAir=denAir,
    final cAir=cAir,
    final wallTypes=wallTypes,
    energyDynamicsWalls=energyDynamicsWalls,
    final TWalls_start=TWalls_start,
    final calcMethodIn=calcMethodIn,
    final hConIn_const=hConIn_const,
    redeclare model WindowModel = WindowModel,
    final Type_Win=Type_Win,
    redeclare model CorrSolarGainWin = CorrSolarGainWin,
    final calcMethodOut=calcMethodOut,
    final surfaceType=surfaceType,
    final hConOut_const=hConOut_const,
    final use_infiltEN12831=use_infiltEN12831,
    final n50=n50,
    final e=e,
    final eps=eps,
    dis=dis,
    room_length=length4,
    room_width=room_width,
    room_height=room_height,
    final solar_absorptance_OW=solar_absorptance_OW,
    withWindow1=true,
    windowarea_OW1=windowarea_41,
    final U_door_OD1=UValOutDoors,
    final eps_door_OD1=epsOutDoors,
    withDoor2=true,
    door_width_OD2=door_width_42,
    door_height_OD2=door_height_42,
    withWindow2=false,
    withDoor1=false,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDynamicVentilation=withDynamicVentilation,
    HeatingLimit=HeatingLimit,
    Max_VR=Max_VR,
    Diff_toTempset=Diff_toTempset,
    Tset=Tset_WC,
    final T0_air=T0_air,
    final U_door_OD2=UValOutDoors,
    final eps_door_OD2=epsOutDoors,
    final use_UFH=use_UFH)
    annotation (Placement(transformation(extent={{82,-36},{44,-84}})));
  Rooms.Ow2IwL2IwS1Gr1Uf1 Kitchen(
    final denAir=denAir,
    final cAir=cAir,
    final wallTypes=wallTypes,
    energyDynamicsWalls=energyDynamicsWalls,
    final TWalls_start=TWalls_start,
    final calcMethodIn=calcMethodIn,
    final hConIn_const=hConIn_const,
    redeclare model WindowModel = WindowModel,
    final Type_Win=Type_Win,
    redeclare model CorrSolarGainWin = CorrSolarGainWin,
    final calcMethodOut=calcMethodOut,
    final surfaceType=surfaceType,
    final hConOut_const=hConOut_const,
    final use_infiltEN12831=use_infiltEN12831,
    final n50=n50,
    final e=e,
    final eps=eps,
    dis=dis,
    room_length=length3 + length4 + thickness_IWsimple,
    room_width=room_width,
    room_height=room_height,
    final solar_absorptance_OW=solar_absorptance_OW,
    withWindow1=true,
    windowarea_OW1=windowarea_51,
    final U_door_OD1=UValOutDoors,
    final eps_door_OD1=epsOutDoors,
    withWindow2=true,
    windowarea_OW2=windowarea_52,
    room_lengthb=length3,
    withDoor1=false,
    withDoor2=false,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDynamicVentilation=withDynamicVentilation,
    HeatingLimit=HeatingLimit,
    Max_VR=Max_VR,
    Diff_toTempset=Diff_toTempset,
    Tset=Tset_Kitchen,
    final T0_air=T0_air,
    final U_door_OD2=UValOutDoors,
    final eps_door_OD2=epsOutDoors,
    final use_UFH=use_UFH) annotation (Placement(transformation(extent=
            {{-84,-20},{-44,-84}})));
  Rooms.Ow1IwL2IwS1Gr1Uf1 Corridor(
    final denAir=denAir,
    final cAir=cAir,
    final wallTypes=wallTypes,
    energyDynamicsWalls=energyDynamicsWalls,
    final TWalls_start=TWalls_start,
    final calcMethodIn=calcMethodIn,
    final hConIn_const=hConIn_const,
    redeclare model WindowModel = WindowModel,
    final Type_Win=Type_Win,
    redeclare model CorrSolarGainWin = CorrSolarGainWin,
    final calcMethodOut=calcMethodOut,
    final surfaceType=surfaceType,
    final hConOut_const=hConOut_const,
    final use_infiltEN12831=use_infiltEN12831,
    final n50=n50,
    final e=e,
    final eps=eps,
    withDynamicVentilation=withDynamicVentilation,
    final HeatingLimit=HeatingLimit,
    final Max_VR=Max_VR,
    final Diff_toTempset=Diff_toTempset,
    final Tset=Tset_Corridor,
    dis=dis,
    room_length=length2 + length3 + thickness_IWsimple,
    room_width=room_width,
    room_height=room_height,
    final solar_absorptance_OW=solar_absorptance_OW,
    withDoor1=true,
    door_width_OD1=door_width_31,
    door_height_OD1=door_height_31,
    final U_door_OD1=UValOutDoors,
    final eps_door_OD1=epsOutDoors,
    room_lengthb=length3,
    withWindow1=false,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    final T0_air=T0_air,
    final use_UFH=use_UFH)
    annotation (Placement(transformation(extent={{82,-28},{42,10}})));
  AixLib.Utilities.Interfaces.SolarRad_in North annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,88})));
  AixLib.Utilities.Interfaces.SolarRad_in East annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,60})));
  AixLib.Utilities.Interfaces.SolarRad_in South annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,26})));
  AixLib.Utilities.Interfaces.SolarRad_in West annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-16})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort if (calcMethodOut == 1 or calcMethodOut == 2)
    annotation (Placement(transformation(extent={{-130,12},{-100,42}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort[5] "1: LivingRoom_GF, 2: Hobby_GF, 3: Corridor, 4: WC_Storage_GF, 5: Kitchen_GF"
    annotation (Placement(transformation(extent={{-130,-18},{-100,12}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Livingroom[dis]
    annotation (Placement(transformation(extent={{-100,100},{-84,118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Hobby[dis]
    annotation (Placement(transformation(extent={{-58,100},{-40,118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Corridor[dis]
    annotation (Placement(transformation(extent={{-20,100},{-2,118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_WCStorage[dis]
    annotation (Placement(transformation(extent={{20,100},{38,118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Kitchen[dis]
    annotation (Placement(transformation(extent={{62,100},{80,118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor
    annotation (Placement(transformation(extent={{100,100},{120,120}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a groundTemp[5*dis]
    "HeatPort to force a ground temperature for the ground level's floor."
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort heatStarToCombHeaters[5]
    annotation (Placement(transformation(
        extent={{10,-8},{-10,8}},
        rotation=90,
        origin={0,-28})));
  AixLib.Utilities.Interfaces.ConvRadComb portConvRadRooms[5]
    "1: LivingRoom_GF, 2: Hobby_GF, 3: Corridor, 4: WC_Storage_GF, 5: Kitchen_GF"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  for i in 1:dis loop
  connect(Livingroom.thermCeiling[i], thermCeiling_Livingroom[i]) annotation (Line(
        points={{-42.2,66.4},{-32,66.4},{-32,86},{-92,86},{-92,109}}, color={
          191,0,0}));
  connect(Hobby.thermCeiling[i], thermCeiling_Hobby[i]) annotation (Line(points={{
          47.9,68.8},{36,68.8},{36,86},{-50,86},{-50,109},{-49,109}}, color={
          191,0,0}));
  connect(Corridor.thermCeiling[i], thermCeiling_Corridor[i]) annotation (Line(points=
         {{44,4.3},{36,4.3},{36,86},{-10,86},{-10,109},{-11,109}}, color={191,0,
          0}));
  connect(WC_Storage.thermCeiling[i], thermCeiling_WCStorage[i]) annotation (Line(
        points={{45.9,-76.8},{36,-76.8},{36,-92},{90,-92},{90,86},{29,86},{29,109}},
                 color={191,0,0}));
  connect(Kitchen.thermCeiling[i], thermCeiling_Kitchen[i]) annotation (Line(points={
          {-46,-74.4},{-34,-74.4},{-34,-92},{90,-92},{90,86},{71,86},{71,109}},
        color={191,0,0}));
  connect(Livingroom.ground[i], groundTemp[i]) annotation (Line(points={{-63.32,
            13.92},{-63.32,-8},{-32,-8},{-32,-88},{0,-88},{0,-100}},
                                               color={191,0,0}));
  connect(Hobby.ground[i], groundTemp[dis+i]) annotation (Line(points={{66.14,29.44},
            {66.14,26},{34,26},{34,-88},{0,-88},{0,-100}},
                                               color={191,0,0}));
  connect(Corridor.ground[i], groundTemp[2*dis+i]) annotation (Line(points={{63.2,-26.86},{63.2,-34},{34,-34},{34,-88},{0,-88},{0,-100}},
                                        color={191,0,0}));
  connect(WC_Storage.ground[i], groundTemp[3*dis+i]) annotation (Line(points={{64.14,
            -37.44},{64.14,-34},{34,-34},{34,-88},{0,-88},{0,-100}},
                                                color={191,0,0}));
  connect(Kitchen.ground[i], groundTemp[4*dis+i]) annotation (Line(points={{-65.2,
            -21.92},{-65.2,-14},{-32,-14},{-32,-88},{0,-88},{0,-100}},
                                              color={191,0,0}));
  end for;
  connect(Livingroom.SolarRadiationPort_OW2, West) annotation (Line(points={{-50.89,75.68},{-50.89,86},{90,86},{90,-16},{110,-16}},
                                                          color={255,128,0}));
  connect(Hobby.SolarRadiationPort_OW2, West) annotation (Line(points={{55.405,
          75.76},{55.405,86},{90,86},{90,-16},{110,-16}}, color={255,128,0}));
  connect(Hobby.SolarRadiationPort_OW1, North) annotation (Line(points={{83.905,
          59.2},{90,59.2},{90,88},{110,88}}, color={255,128,0}));
  connect(Corridor.SolarRadiationPort_OW1, North) annotation (Line(points={{
          81.9,2.4},{90,2.4},{90,88},{110,88}}, color={255,128,0}));
  connect(WC_Storage.SolarRadiationPort_OW1, North) annotation (Line(points={{81.905,-67.2},{90,-67.2},{90,88},{110,88}},
                                                      color={255,128,0}));
  connect(WC_Storage.SolarRadiationPort_OW2, East) annotation (Line(points={{53.405,-83.76},{53.405,-92},{-90,-92},{-90,86},{90,86},{90,60},{110,60}},
                color={255,128,0}));
  connect(Kitchen.SolarRadiationPort_OW2, East) annotation (Line(points={{-53.9,
          -83.68},{-53.9,-92},{-90,-92},{-90,86},{90,86},{90,60},{110,60}},
        color={255,128,0}));
  connect(Livingroom.SolarRadiationPort_OW1, South) annotation (Line(points={{-83.89,53.6},{-90,53.6},{-90,86},{90,86},{90,26},{110,26}},
                                                               color={255,128,0}));
  connect(Livingroom.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-83.89,31.2},{-90,31.2},{-90,27},{-115,27}},
                                                color={0,0,127}));
  connect(Kitchen.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-83.9,
          -39.2},{-90,-39.2},{-90,27},{-115,27}}, color={0,0,127}));
  connect(WC_Storage.WindSpeedPort, WindSpeedPort) annotation (Line(points={{81.905,-50.4},{90,-50.4},{90,-92},{-90,-92},{-90,27},{-115,27}},
        color={0,0,127}));
  connect(Corridor.WindSpeedPort, WindSpeedPort) annotation (Line(points={{81.9,
          -20.4},{90,-20.4},{90,-92},{-90,-92},{-90,27},{-115,27}}, color={0,0,
          127}));
  connect(Hobby.WindSpeedPort, WindSpeedPort) annotation (Line(points={{83.905,
          42.4},{90,42.4},{90,-92},{-90,-92},{-90,27},{-115,27}}, color={0,0,
          127}));
  connect(Livingroom.thermOutside, thermOutside) annotation (Line(points={{-84,75.36},{-90,75.36},{-90,100},{-100,100}},
                                                color={191,0,0}));
  connect(Kitchen.thermOutside, thermOutside) annotation (Line(points={{-84,-83.36},{-90,-83.36},{-90,100},{-100,100}},
                                           color={191,0,0}));
  connect(WC_Storage.thermOutside, thermOutside) annotation (Line(points={{82,-83.52},{82,-92},{-90,-92},{-90,100},{-100,100}},
                                                           color={191,0,0}));
  connect(Corridor.thermOutside, thermOutside) annotation (Line(points={{82,9.62},{86,9.62},{86,8},{90,8},{90,-92},{-90,-92},{-90,100},{-100,100}},
                                                                         color=
          {191,0,0}));
  connect(Hobby.thermOutside, thermOutside) annotation (Line(points={{84,75.52},{90,75.52},{90,86},{-90,86},{-90,100},{-100,100}},
                                                          color={191,0,0}));
  connect(Livingroom.thermInsideWall1a, Hobby.thermInsideWall1) annotation (
      Line(points={{-42.2,53.6},{-32,53.6},{-32,86},{36,86},{36,54.4},{47.9,54.4}},
                  color={191,0,0}));
  connect(Kitchen.thermInsideWall1a, WC_Storage.thermInsideWall1) annotation (
      Line(points={{-46,-61.6},{-34,-61.6},{-34,-92},{36,-92},{36,-62},{45.9,-62},{45.9,-62.4}},
                         color={191,0,0}));
  connect(Livingroom.thermInsideWall1b, Corridor.thermInsideWall2a) annotation (
     Line(points={{-42.2,40.8},{-32,40.8},{-32,86},{36,86},{36,-3.3},{44,-3.3}},
        color={191,0,0}));
  connect(Kitchen.thermInsideWall2, Livingroom.thermInsideWall2) annotation (
      Line(points={{-58,-23.2},{-58,-14},{-90,-14},{-90,6},{-55.4,6},{-55.4,15.2}},
                  color={191,0,0}));
  connect(Corridor.thermInsideWall3, WC_Storage.thermInsideWall2) annotation (
      Line(points={{53.2,-26.86},{53.2,-32},{57.3,-32},{57.3,-38.4}}, color={
          191,0,0}));
  connect(Hobby.thermInsideWall2, Corridor.thermInsideWall1) annotation (Line(
        points={{59.3,30.4},{59.3,22},{90,22},{90,14},{56,14},{56,8.1}}, color=
          {191,0,0}));
  connect(Corridor.thermRoom, thermCorridor) annotation (Line(points={{64.8,-9},{64.8,-32},{90,-32},{90,100},{110,100},{110,110}},
                                                           color={191,0,0}));
  connect(Livingroom.AirExchangePort, AirExchangePort[1]) annotation (Line(
        points={{-86.2,66.24},{-86.2,66},{-92,66},{-92,-15},{-115,-15}},
        color={0,0,127}));
  connect(Hobby.AirExchangePort, AirExchangePort[2]) annotation (Line(points={{85.9,68.68},{85.9,78},{86,78},{86,88},{-92,88},{-92,-9},{-115,-9}},
                                                                        color={
          0,0,127}));
  connect(Kitchen.SolarRadiationPort_OW1, South) annotation (Line(points={{-83.9,
          -61.6},{-90,-61.6},{-90,-92},{90,-92},{90,26},{110,26}}, color={255,
          128,0}));
  connect(Corridor.thermInsideWall2b, Kitchen.thermInsideWall1b) annotation (
      Line(points={{44,-10.9},{36,-10.9},{36,-92},{-34,-92},{-34,-48.8},{-46,-48.8}},
        color={191,0,0}));

  connect(Corridor.AirExchangePort, AirExchangePort[3]) annotation (Line(points={{84,4.205},{86,4.205},{86,4},{88,4},{88,-90},{-92,-90},{-92,-3},{-115,-3}}, color={0,0,127}));
  connect(WC_Storage.AirExchangePort, AirExchangePort[4]) annotation (Line(points={{83.9,-76.68},{88,-76.68},{88,-90},{-92,-90},{-92,3},{-115,3}}, color={0,0,127}));
  connect(Kitchen.AirExchangePort, AirExchangePort[5]) annotation (Line(points={{-86,-74.24},{-92,-74.24},{-92,9},{-115,9}}, color={0,0,127}));
  connect(heatStarToCombHeaters.portConvRadComb, portConvRadRooms) annotation (Line(points={{0,-18},{0,0}}, color={191,0,0}));
  connect(Livingroom.starRoom, heatStarToCombHeaters[1].portRad) annotation (Line(points={{-58.48,44},{-58,44},{-58,30},{-16,30},{-16,-38},{-5,-38}}, color={0,0,0}));
  connect(Livingroom.thermRoom, heatStarToCombHeaters[1].portConv) annotation (Line(points={{-65.08,44},{-66,44},{-66,26},{-20,26},{-20,-44},{5,-44},{5,-38}}, color={191,0,0}));
  connect(Hobby.starRoom, heatStarToCombHeaters[2].portRad) annotation (Line(points={{61.96,52},{62,52},{62,46},{14,46},{14,-48},{-5,-48},{-5,-38}}, color={0,0,0}));
  connect(Hobby.thermRoom, heatStarToCombHeaters[2].portConv) annotation (Line(points={{67.66,52},{68,52},{68,42},{18,42},{18,-38},{5,-38}}, color={191,0,0}));
  connect(Corridor.starRoom, heatStarToCombHeaters[3].portRad) annotation (Line(points={{58.8,-9},{58.8,-18},{14,-18},{14,-48},{-5,-48},{-5,-38}}, color={0,0,0}));
  connect(Corridor.thermRoom, heatStarToCombHeaters[3].portConv) annotation (Line(points={{64.8,-9},{64.8,-22},{18,-22},{18,-38},{5,-38}}, color={191,0,0}));
  connect(WC_Storage.starRoom, heatStarToCombHeaters[4].portRad) annotation (Line(points={{59.96,-60},{59.96,-48},{-5,-48},{-5,-38}}, color={0,0,0}));
  connect(WC_Storage.thermRoom, heatStarToCombHeaters[4].portConv) annotation (Line(points={{65.66,-60},{66,-60},{66,-44},{5,-44},{5,-38}}, color={191,0,0}));
  connect(Kitchen.starRoom, heatStarToCombHeaters[5].portRad) annotation (Line(points={{-60.8,-52},{-60,-52},{-60,-38},{-5,-38}}, color={0,0,0}));
  connect(Kitchen.thermRoom, heatStarToCombHeaters[5].portConv) annotation (Line(points={{-66.8,-52},{-66,-52},{-66,-44},{5,-44},{5,-38}}, color={191,0,0}));
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
          textString="Kitchen")}), Documentation(revisions="<html><ul>
  <li>
    <i>April 23, 2020</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/752\">#752</a>:
    Propagate all parameters correctly (not geometry). Vectorize
    thermal ports. Delete TIR and TMC.
  </li>
  <li>
    <i>April 18, 2014</i> by Ana Constantin:<br/>
    Added documentation
  </li>
  <li>
    <i>July 10, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for the envelope of the ground floor.
</p>
<p>
  <b><span style=\"color: #008000;\">Ground temperature</span></b>
</p>
<p>
  The ground temperature can be coupled to any desired prescriped
  temperature. Anyway, suitable ground temperatures depending on
  locations in Germany are listed as Θ'_m,e in the comprehensive table
  1 in \"Beiblatt 1\" in the norm DIN EN 12831.
</p>
<p>
  Or a ground temperature can be chosen according to a TRY region,
  which is listed below: if ...
</p>
<p>
  TRY_Region == 1 then 282.15 K
</p>
<p>
  TRY_Region == 2 then 281.55 K
</p>
<p>
  TRY_Region == 3 then 281.65 K
</p>
<p>
  TRY_Region == 4 then 282.65 K
</p>
<p>
  TRY_Region == 5 then 281.25 K
</p>
<p>
  TRY_Region == 6 then 279.95 K
</p>
<p>
  TRY_Region == 7 then 281.95 K
</p>
<p>
  TRY_Region == 8 then 279.95 K
</p>
<p>
  TRY_Region == 9 then 281.05 K
</p>
<p>
  TRY_Region == 10 then 276.15 K
</p>
<p>
  TRY_Region == 11 then 279.45 K
</p>
<p>
  TRY_Region == 12 then 283.35 K
</p>
<p>
  TRY_Region == 13 then 281.05 K
</p>
<p>
  TRY_Region == 14 then 281.05 K
</p>
<p>
  TRY_Region == 15 then 279.95 K
</p>
</html>"));
end GroundFloorBuildingEnvelope;
