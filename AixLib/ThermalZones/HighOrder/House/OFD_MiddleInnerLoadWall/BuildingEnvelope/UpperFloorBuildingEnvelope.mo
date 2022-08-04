within AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope;
model UpperFloorBuildingEnvelope

  extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoomParams(
    final Tset=372.15,
    withDynamicVentilation=false,                                               redeclare replaceable parameter DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes);
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  //////////room geometry
  parameter Modelica.Units.SI.Length room_width_long=3.92 "w1 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Length room_width_short=2.28 "w2 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Height room_height_long=2.60 "h1 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Height room_height_short=1 "h2 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Length roof_width=2.21 "wRO"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Length length5=3.3 "l5 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Length length6=2.44 "l6 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Length length7=1.33 "l7 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Length length8=3.3 "l8 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Length thickness_IWsimple=0.145
    "thickness IWsimple "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  // Outer walls properties
  parameter Real solar_absorptance_RO=0.1 "Solar absoptance roof "
    annotation (Dialog(tab="Outer walls", group="Solar absorptance", descriptionLabel=true));
  //Windows and Doors
  parameter Modelica.Units.SI.Area windowarea_62=1.73 " Area Window62"
    annotation (Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Area windowarea_63=1.73 " Area Window63  "
    annotation (Dialog(group="Windows and Doors", descriptionLabel=true));
  parameter Modelica.Units.SI.Area windowarea_72=1.73 " Area Window72"
    annotation (Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Area windowarea_73=1.73 " Area Window73  "
    annotation (Dialog(group="Windows and Doors", descriptionLabel=true));
  parameter Modelica.Units.SI.Area windowarea_92=1.73 " Area Window51"
    annotation (Dialog(group="Windows and Doors", descriptionLabel=true));
  parameter Modelica.Units.SI.Area windowarea_102=1.73 " Area Window102"
    annotation (Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Area windowarea_103=1.73 " Area Window103  "
    annotation (Dialog(group="Windows and Doors", descriptionLabel=true));

  parameter Modelica.Units.SI.Temperature Tset_Bedroom=295.15 "Tset_bedroom"
    annotation (Dialog(
      tab="Dynamic ventilation",
      descriptionLabel=true,
      joinNext=true,
      enable=withDynamicVentilation));
  parameter Modelica.Units.SI.Temperature Tset_Children1=295.15
    "Tset_children1" annotation (Dialog(
      tab="Dynamic ventilation",
      descriptionLabel=true,
      enable=withDynamicVentilation));
  parameter Modelica.Units.SI.Temperature Tset_Corridor=291.15 "Tset_corridor"
    annotation (Dialog(
      tab="Dynamic ventilation",
      descriptionLabel=true,
      enable=withDynamicVentilation));
  parameter Modelica.Units.SI.Temperature Tset_Bath=297.15 "Tset_Bath"
    annotation (Dialog(
      tab="Dynamic ventilation",
      descriptionLabel=true,
      joinNext=true,
      enable=withDynamicVentilation));
  parameter Modelica.Units.SI.Temperature Tset_Children2=295.15
    "Tset_children2" annotation (Dialog(
      group="Dynamic ventilation",
      descriptionLabel=true,
      enable=withDynamicVentilation));

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer UValOutDoors
    "U-value (thermal transmittance) of doors in outer walls"
    annotation (Dialog(tab="Outer walls", group="Doors"));
  parameter Modelica.Units.SI.Emissivity epsOutDoors(
    min=0,
    max=1) = 0.95 "Emissivity of inside surface of outer doors"
    annotation (Dialog(tab="Outer walls", group="Doors"));

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
    final denAir=denAir,
    final cAir=cAir,
    final wallTypes=wallTypes,
    final energyDynamicsWalls=energyDynamicsWalls,
    final energyDynamics=energyDynamics,
    final TWalls_start=TWalls_start,
    final calcMethodIn=calcMethodIn,
    final hConIn_const=hConIn_const,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    final Type_Win=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final calcMethodOut=calcMethodOut,
    final surfaceType=surfaceType,
    final hConOut_const=hConOut_const,
    final use_infiltEN12831=use_infiltEN12831,
    final n50=n50,
    final e=e,
    final eps=eps,
    final solar_absorptance_OW=solar_absorptance_OW,
    withWindow2=true,
    room_length=length5 + length6 + thickness_IWsimple,
    final eps_door_OD2=epsOutDoors,
    final U_door_OD2=UValOutDoors,
    room_lengthb=length6,
    room_width_long=room_width_long,
    room_width_short=room_width_short,
    room_height_long=room_height_long,
    room_height_short=room_height_short,
    roof_width=roof_width,
    final solar_absorptance_RO=solar_absorptance_RO,
    windowarea_OW2=windowarea_62,
    withWindow3=true,
    windowarea_RO=windowarea_63,
    withDoor2=false,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    final withDynamicVentilation=withDynamicVentilation,
    final HeatingLimit=HeatingLimit,
    final Max_VR=Max_VR,
    final Diff_toTempset=Diff_toTempset,
    final Tset=Tset_Bedroom,
    T0_air=T0_air)       annotation (Placement(transformation(extent={{-82,14},{-42,78}})));
  Rooms.OFD.Ow2IwL1IwS1Lf1At1Ro1 Children1(
    final denAir=denAir,
    final cAir=cAir,
    final wallTypes=wallTypes,
    final energyDynamicsWalls=energyDynamicsWalls,
    final energyDynamics=energyDynamics,
    final TWalls_start=TWalls_start,
    final calcMethodIn=calcMethodIn,
    final hConIn_const=hConIn_const,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    final Type_Win=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final calcMethodOut=calcMethodOut,
    final surfaceType=surfaceType,
    final hConOut_const=hConOut_const,
    final use_infiltEN12831=use_infiltEN12831,
    final n50=n50,
    final e=e,
    final eps=eps,
    final solar_absorptance_OW=solar_absorptance_OW,
    withWindow2=true,
    room_length=length5,
    room_width_long=room_width_long,
    room_width_short=room_width_short,
    room_height_long=room_height_long,
    room_height_short=room_height_short,
    roof_width=roof_width,
    final solar_absorptance_RO=solar_absorptance_RO,
    windowarea_OW2=windowarea_72,
    withWindow3=true,
    windowarea_RO=windowarea_73,
    withDoor2=false,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    final withDynamicVentilation=withDynamicVentilation,
    final HeatingLimit=HeatingLimit,
    final Max_VR=Max_VR,
    final Diff_toTempset=Diff_toTempset,
    final Tset=Tset_Children1,
    T0_air=T0_air,
    final eps_door_OD2=epsOutDoors,
    final U_door_OD2=UValOutDoors) annotation (Placement(transformation(extent={{82,28},{44,76}})));
  Rooms.OFD.Ow2IwL1IwS1Lf1At1Ro1 Bath(
    final denAir=denAir,
    final cAir=cAir,
    final wallTypes=wallTypes,
    final energyDynamicsWalls=energyDynamicsWalls,
    final energyDynamics=energyDynamics,
    final TWalls_start=TWalls_start,
    final calcMethodIn=calcMethodIn,
    final hConIn_const=hConIn_const,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    final Type_Win=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final calcMethodOut=calcMethodOut,
    final surfaceType=surfaceType,
    final hConOut_const=hConOut_const,
    final use_infiltEN12831=use_infiltEN12831,
    final n50=n50,
    final e=e,
    final eps=eps,
    final solar_absorptance_OW=solar_absorptance_OW,
    room_length=length8,
    room_width_long=room_width_long,
    room_width_short=room_width_short,
    room_height_long=room_height_long,
    room_height_short=room_height_short,
    roof_width=roof_width,
    final solar_absorptance_RO=solar_absorptance_RO,
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
    final withDynamicVentilation=withDynamicVentilation,
    final HeatingLimit=HeatingLimit,
    final Max_VR=Max_VR,
    final Diff_toTempset=Diff_toTempset,
    final Tset=Tset_Bath,
    T0_air=T0_air,
    final eps_door_OD2=epsOutDoors,
    final U_door_OD2=UValOutDoors) annotation (Placement(transformation(extent={{84,-36},{46,-84}})));
  Rooms.OFD.Ow2IwL2IwS1Lf1At1Ro1 Children2(
    final denAir=denAir,
    final cAir=cAir,
    final wallTypes=wallTypes,
    final energyDynamicsWalls=energyDynamicsWalls,
    final energyDynamics=energyDynamics,
    final TWalls_start=TWalls_start,
    final calcMethodIn=calcMethodIn,
    final hConIn_const=hConIn_const,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    final Type_Win=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final calcMethodOut=calcMethodOut,
    final surfaceType=surfaceType,
    final hConOut_const=hConOut_const,
    final use_infiltEN12831=use_infiltEN12831,
    final n50=n50,
    final e=e,
    final eps=eps,
    final solar_absorptance_OW=solar_absorptance_OW,
    withWindow2=true,
    room_length=length7 + length8 + thickness_IWsimple,
    room_width_long=room_width_long,
    room_width_short=room_width_short,
    room_height_long=room_height_long,
    room_height_short=room_height_short,
    roof_width=roof_width,
    final solar_absorptance_RO=solar_absorptance_RO,
    windowarea_OW2=windowarea_102,
    withWindow3=true,
    windowarea_RO=windowarea_103,
    final eps_door_OD2=epsOutDoors,
    final U_door_OD2=UValOutDoors,
    room_lengthb=length7,
    withDoor2=false,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    final withDynamicVentilation=withDynamicVentilation,
    final HeatingLimit=HeatingLimit,
    final Max_VR=Max_VR,
    final Diff_toTempset=Diff_toTempset,
    final Tset=Tset_Children2,
    T0_air=T0_air)       annotation (Placement(transformation(extent={{-84,-20},{-44,-84}})));
  Rooms.OFD.Ow1IwL2IwS1Lf1At1Ro1 Corridor(
    final denAir=denAir,
    final cAir=cAir,
    final wallTypes=wallTypes,
    final energyDynamicsWalls=energyDynamicsWalls,
    final energyDynamics=energyDynamics,
    final TWalls_start=TWalls_start,
    final calcMethodIn=calcMethodIn,
    final hConIn_const=hConIn_const,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    final Type_Win=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final calcMethodOut=calcMethodOut,
    final surfaceType=surfaceType,
    final hConOut_const=hConOut_const,
    final use_infiltEN12831=use_infiltEN12831,
    final n50=n50,
    final e=e,
    final eps=eps,
    final withDynamicVentilation=withDynamicVentilation,
    final HeatingLimit=HeatingLimit,
    final Max_VR=Max_VR,
    final Diff_toTempset=Diff_toTempset,
    final Tset=Tset_Corridor,
    final solar_absorptance_OW=solar_absorptance_OW,
    room_length=length6 + length7 + thickness_IWsimple,
    room_lengthb=length7,
    room_width_long=room_width_long,
    room_width_short=room_width_short,
    room_height_long=room_height_long,
    room_height_short=room_height_short,
    roof_width=roof_width,
    final solar_absorptance_RO=solar_absorptance_RO,
    withWindow3=false,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    T0_air=T0_air)       annotation (Placement(transformation(extent={{82,-28},{42,10}})));
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
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort if (calcMethodOut == 1 or calcMethodOut == 2)
    annotation (Placement(transformation(extent={{-130,10},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort[5] "1(6): Bedroom_UF, 2(7): Child1_UF, 3(8): Corridor_UF, 4(9): Bath_UF, 5(10): Child2_UF"
    annotation (Placement(transformation(extent={{-130,-26},{-100,4}}), iconTransformation(extent={{-130,-26},{-100,4}})));

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
  Utilities.Interfaces.Adaptors.ConvRadToCombPort        heatStarToCombHeaters[5] annotation (Placement(transformation(extent={{10,-8},{-10,8}},
        rotation=90,
        origin={0,-28})));
  Utilities.Interfaces.ConvRadComb portConvRadRooms[5] "1(6): Bedroom_UF, 2(7): Child1_UF, 3(8): Corridor_UF, 4(9): Bath_UF, 5(10): Child2_UF" annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
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
  connect(Bedroom.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-81.9,30},{-90,30},{-90,25},{-115,25}},
                                            color={0,0,127}));
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
  connect(Bedroom.thermOutside, thermOutside) annotation (Line(points={{-82,77.36},{-90,77.36},{-90,100},{-100,100}},
                                                color={191,0,0}));
  connect(Children2.thermOutside, thermOutside) annotation (Line(points={{-84,-83.36},{-90,-83.36},{-90,100},{-100,100}},
                                           color={191,0,0}));
  connect(Bath.thermOutside, thermOutside) annotation (Line(points={{84,-83.52},{84,-92},{-90,-92},{-90,100},{-100,100}},
                                                    color={191,0,0}));
  connect(Corridor.thermOutside, thermOutside) annotation (Line(points={{82,9.62},{86,9.62},{86,8},{90,8},{90,-92},{-90,-92},{-90,100},{-100,100}},
                                                                         color=
          {191,0,0}));
  connect(Children1.thermOutside, thermOutside) annotation (Line(points={{82,75.52},{90,75.52},{90,86},{-90,86},{-90,100},{-100,100}},
                                                                color={191,0,0}));
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
  connect(Corridor.thermRoom, thermCorridor) annotation (Line(points={{64.8,-9},{64.8,-14},{90,-14},{90,-110},{110,-110}},
                                                   color={191,0,0}));
  connect(Bedroom.thermInsideWall1a, Children1.thermInsideWall1) annotation (
      Line(points={{-44,49.2},{-32,49.2},{-32,86},{36,86},{36,54.4},{45.9,54.4}},
        color={191,0,0}));
  connect(Bedroom.thermInsideWall1b, Corridor.thermInsideWall2a) annotation (
      Line(points={{-44,36.4},{-32,36.4},{-32,86},{36,86},{36,-7.1},{44,-7.1}},
        color={191,0,0}));
  connect(Children2.SolarRadiationPort_Roof, RoofS) annotation (Line(points={{-49.2,
          -84},{-50,-84},{-50,-92},{90,-92},{90,44},{110,44}}, color={255,128,0}));
  connect(heatStarToCombHeaters.portConvRadComb, portConvRadRooms) annotation (Line(points={{0,-18},{0,0}}, color={191,0,0}));
  connect(Bedroom.starRoom, heatStarToCombHeaters[1].portRad) annotation (Line(points={{-58.8,46},{-58,46},{-58,30},{-14,30},{-14,-38},{-5,-38}}, color={0,0,0}));
  connect(Bedroom.thermRoom, heatStarToCombHeaters[1].portConv) annotation (Line(points={{-64.8,46},{-66,46},{-66,28},{-16,28},{-16,-42},{5,-42},{5,-38}}, color={191,0,0}));
  connect(Children1.starRoom, heatStarToCombHeaters[2].portRad) annotation (Line(points={{59.96,52},{60,52},{60,44},{12,44},{12,-44},{-5,-44},{-5,-38}}, color={0,0,0}));
  connect(Children1.thermRoom, heatStarToCombHeaters[2].portConv) annotation (Line(points={{65.66,52},{65.66,48},{66,48},{66,42},{14,42},{14,-38},{5,-38}}, color={191,0,0}));
  connect(Corridor.starRoom, heatStarToCombHeaters[3].portRad) annotation (Line(points={{58.8,-9},{58.8,-20},{16,-20},{16,-44},{-5,-44},{-5,-38}}, color={0,0,0}));
  connect(Corridor.thermRoom, heatStarToCombHeaters[3].portConv) annotation (Line(points={{64.8,-9},{64.8,-22},{18,-22},{18,-38},{5,-38}}, color={191,0,0}));
  connect(Bath.starRoom, heatStarToCombHeaters[4].portRad) annotation (Line(points={{61.96,-60},{62,-60},{62,-44},{-5,-44},{-5,-38}}, color={0,0,0}));
  connect(Bath.thermRoom, heatStarToCombHeaters[4].portConv) annotation (Line(points={{67.66,-60},{68,-60},{68,-42},{20,-42},{20,-38},{5,-38}}, color={191,0,0}));
  connect(Children2.starRoom, heatStarToCombHeaters[5].portRad) annotation (Line(points={{-60.8,-52},{-60.8,-38},{-5,-38}}, color={0,0,0}));
  connect(Children2.thermRoom, heatStarToCombHeaters[5].portConv) annotation (Line(points={{-66.8,-52},{-66,-52},{-66,-36},{-18,-36},{-18,-42},{5,-42},{5,-38}}, color={191,0,0}));
  connect(AirExchangePort[1], Bedroom.AirExchangePort) annotation (Line(points={{-115,
          -17},{-92,-17},{-92,68.24},{-84,68.24}},                                                                             color={0,0,127}));
  connect(AirExchangePort[2], Children1.AirExchangePort) annotation (Line(points={{-115,
          -14},{-92,-14},{-92,88},{92,88},{92,68.68},{83.9,68.68}},                                                                               color={0,0,127}));
  connect(AirExchangePort[3], Corridor.AirExchangePort) annotation (Line(points={{-115,-11},{-92,-11},{-92,88},{92,88},{92,4.205},{84,4.205}}, color={0,0,127}));
  connect(AirExchangePort[4], Bath.AirExchangePort) annotation (Line(points={{-115,-8},
          {-92,-8},{-92,88},{92,88},{92,-76.68},{85.9,-76.68}},                                                                              color={0,0,127}));
  connect(AirExchangePort[5], Children2.AirExchangePort) annotation (Line(points={{-115,-5},
          {-92,-5},{-92,-74.24},{-86,-74.24}},                                                                                 color={0,0,127}));
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
          textString="Children2")}), Documentation(revisions="<html><ul>
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
  Model for the envelope of the upper floor.
</p>
</html>"));
end UpperFloorBuildingEnvelope;
