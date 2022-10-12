within AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope;
model UpperFloorBuildingEnvelope
  extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoomParams(
    final Tset=372.15,
    withDynamicVentilation=false,                                               redeclare replaceable parameter DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes);
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model";

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
        origin={110,64})));
  Utilities.Interfaces.SolarRad_in RoofN annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,88})));
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
    T0_air=T0_air,
    nPorts=2,
    redeclare package Medium = Medium)      annotation (Placement(transformation(extent={{-82,14},{-42,78}})));
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
    final U_door_OD2=UValOutDoors,
    nPorts=2,
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{78,28},
            {40,76}})));
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
    final U_door_OD2=UValOutDoors,
    nPorts=2,
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{80,-36},
            {42,-84}})));
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
    T0_air=T0_air,
    nPorts=2,
    redeclare package Medium = Medium)            annotation (Placement(transformation(extent={{-84,-20},{-44,-84}})));
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
    T0_air=T0_air,
    nPorts=2,
    redeclare final package Medium = Medium)       annotation (Placement(transformation(extent={{78,-28},{
            38,10}})));
  Utilities.Interfaces.SolarRad_in North annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,40})));
  Utilities.Interfaces.SolarRad_in East annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,16})));
  Utilities.Interfaces.SolarRad_in South annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-10})));
  Utilities.Interfaces.SolarRad_in West annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-36})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort if (calcMethodOut == 1 or calcMethodOut == 2)
    annotation (Placement(transformation(extent={{-130,10},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort[5]
    "1(6): Bedroom_UF, 2(7): Child1_UF, 3(8): Corridor_UF, 4(9): Bath_UF, 5(10): Child2_UF"
    annotation (Placement(transformation(extent={{-130,-26},{-100,4}}),
        iconTransformation(extent={{-130,-26},{-100,4}})));

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
  Utilities.Interfaces.Adaptors.ConvRadToCombPort heatStarToCombHeaters[5]
    annotation (Placement(transformation(
        extent={{10,-8},{-10,8}},
        rotation=90,
        origin={0,-28})));
  Utilities.Interfaces.ConvRadComb portConvRadRooms[5]
    "1(6): Bedroom_UF, 2(7): Child1_UF, 3(8): Corridor_UF, 4(9): Bath_UF, 5(10): Child2_UF"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a portVent_in[5](redeclare final package
      Medium = Medium) "Inlet for ventilation" annotation (Placement(
        transformation(extent={{94,-78},{114,-58}}), iconTransformation(extent={
            {94,-70},{108,-56}})));
  Modelica.Fluid.Interfaces.FluidPort_b portVent_out[5](redeclare final package
      Medium = Medium) "Outlet of Ventilation" annotation (Placement(
        transformation(extent={{94,-94},{114,-74}}), iconTransformation(extent={
            {94,-94},{108,-80}})));
equation
  connect(Bedroom.SolarRadiationPort_OW2, West) annotation (Line(points={{-53.1,
          78.32},{-52,78.32},{-52,84},{-40,84},{-40,82},{-12,82},{-12,80},{54,80},
          {54,86},{90,86},{90,-36},{110,-36}},           color={255,128,0}));
  connect(Children1.SolarRadiationPort_OW2, West) annotation (Line(points={{50.545,
          76.24},{50.545,86},{86,86},{86,-36},{110,-36}},        color={255,128,
          0}));
  connect(Children1.SolarRadiationPort_OW1, North) annotation (Line(points={{77.905,
          59.2},{90,59.2},{90,40},{110,40}},      color={255,128,0}));
  connect(Corridor.SolarRadiationPort_OW1, North) annotation (Line(points={{77.9,
          -3.3},{86,-3.3},{86,40},{110,40}},    color={255,128,0}));
  connect(Bath.SolarRadiationPort_OW1, North) annotation (Line(points={{79.905,-67.2},
          {90,-67.2},{90,40},{110,40}},      color={255,128,0}));
  connect(Bath.SolarRadiationPort_OW2, East) annotation (Line(points={{52.545,-84.24},
          {52.545,-88},{84,-88},{84,-30},{92,-30},{92,16},{110,16}},   color={
          255,128,0}));
  connect(Children2.SolarRadiationPort_OW2, East) annotation (Line(points={{-55.1,
          -84.32},{-54,-84.32},{-54,-94},{88,-94},{88,-30},{96,-30},{96,16},{110,
          16}},
        color={255,128,0}));
  connect(Children2.SolarRadiationPort_OW1, South) annotation (Line(points={{-83.9,
          -61.6},{-92,-61.6},{-92,-68},{-94,-68},{-94,-74},{-96,-74},{-96,-94},{
          -58,-94},{-58,-96},{84,-96},{84,-30},{82,-30},{82,-10},{110,-10}},
                                                                   color={255,
          128,0}));
  connect(Bedroom.SolarRadiationPort_OW1, South) annotation (Line(points={{-81.9,
          55.6},{-98,55.6},{-98,-74},{-96,-74},{-96,-94},{-58,-94},{-58,-96},{84,
          -96},{84,-30},{82,-30},{82,-10},{110,-10}},            color={255,128,
          0}));
  connect(Bedroom.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-81.9,30},{-90,30},{-90,25},{-115,25}},
                                            color={0,0,127}));
  connect(Children2.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-83.9,
          -36},{-90,-36},{-90,25},{-115,25}}, color={0,0,127}));
  connect(Bath.WindSpeedPort, WindSpeedPort) annotation (Line(points={{79.905,-50.4},
          {86,-50.4},{86,-92},{-94,-92},{-94,25},{-115,25}}, color={0,0,127}));
  connect(Corridor.WindSpeedPort, WindSpeedPort) annotation (Line(points={{77.9,
          -18.5},{86,-18.5},{86,-92},{-94,-92},{-94,25},{-115,25}}, color={0,0,
          127}));
  connect(Children1.WindSpeedPort, WindSpeedPort) annotation (Line(points={{77.905,
          42.4},{86,42.4},{86,-92},{-94,-92},{-94,25},{-115,25}},        color=
          {0,0,127}));
  connect(Bedroom.thermOutside, thermOutside) annotation (Line(points={{-82,77.36},{-90,77.36},{-90,100},{-100,100}},
                                                color={191,0,0}));
  connect(Children2.thermOutside, thermOutside) annotation (Line(points={{-84,-83.36},{-90,-83.36},{-90,100},{-100,100}},
                                           color={191,0,0}));
  connect(Bath.thermOutside, thermOutside) annotation (Line(points={{80,-83.52},
          {80,-92},{-94,-92},{-94,100},{-100,100}}, color={191,0,0}));
  connect(Corridor.thermOutside, thermOutside) annotation (Line(points={{78,9.62},
          {82,9.62},{82,8},{86,8},{86,-92},{-94,-92},{-94,100},{-100,100}},
                                                                         color=
          {191,0,0}));
  connect(Children1.thermOutside, thermOutside) annotation (Line(points={{78,75.52},
          {86,75.52},{86,86},{-94,86},{-94,100},{-100,100}},    color={191,0,0}));
  connect(Bedroom.thermCeiling, thermCeiling_Bedroom) annotation (Line(points={
          {-44,62},{-32,62},{-32,86},{-90,86},{-90,109}}, color={191,0,0}));
  connect(Children1.thermCeiling, thermCeiling_Children1) annotation (Line(
        points={{41.9,68.8},{32,68.8},{32,86},{-54,86},{-54,109},{-49,109}},
        color={191,0,0}));
  connect(Corridor.thermCeiling, thermCeiling_Corridor) annotation (Line(points={{40,0.5},
          {32,0.5},{32,86},{-16,86},{-16,109},{-11,109}},          color={191,0,
          0}));
  connect(Bath.thermCeiling, thermCeiling_Bath) annotation (Line(points={{43.9,-76.8},
          {32,-76.8},{32,-92},{86,-92},{86,86},{29,86},{29,109}},        color=
          {191,0,0}));
  connect(Children2.thermCeiling, thermCeiling_Children2) annotation (Line(
        points={{-46,-68},{-34,-68},{-34,-92},{90,-92},{90,86},{69,86},{69,109}},
        color={191,0,0}));
  connect(Children2.thermInsideWall1a, Bath.thermInsideWall1) annotation (Line(
        points={{-46,-55.2},{-46,-56},{-38,-56},{-38,-92},{32,-92},{32,-62},{43.9,
          -62},{43.9,-62.4}},      color={191,0,0}));
  connect(Children2.thermInsideWall1b, Corridor.thermInsideWall2b) annotation (
      Line(points={{-46,-42.4},{-38,-42.4},{-38,-92},{32,-92},{32,-14},{40,-14},
          {40,-14.7}}, color={191,0,0}));
  connect(Children2.thermInsideWall2, Bedroom.thermInsideWall2) annotation (
      Line(points={{-58,-23.2},{-58,-14},{-90,-14},{-90,6},{-56,6},{-56,17.2}},
        color={191,0,0}));
  connect(Corridor.thermInsideWall3, Bath.thermInsideWall2) annotation (Line(
        points={{52,-26.1},{52,-32},{55.3,-32},{55.3,-38.4}}, color={191,0,0}));
  connect(Children1.thermInsideWall2, Corridor.thermInsideWall1) annotation (
      Line(points={{53.3,30.4},{53.3,18},{60,18},{60,8.1}}, color={191,0,0}));
  connect(Bedroom.SolarRadiationPort_Roof, RoofS) annotation (Line(points={{-47.2,
          78},{-50,78},{-50,84},{-18,84},{-18,78},{36,78},{36,82},{90,82},{90,64},
          {110,64}},                                       color={255,128,0}));
  connect(Children1.SolarRadiationPort_Roof, RoofN) annotation (Line(points={{44.94,
          76},{44.94,84},{86,84},{86,88},{110,88}},       color={255,128,0}));
  connect(Corridor.SolarRadiationPort_Roof, RoofN) annotation (Line(points={{43.2,10},
          {43.2,14},{86,14},{86,88},{110,88}},                color={255,128,0}));
  connect(Bath.SolarRadiationPort_Roof, RoofN) annotation (Line(points={{46.94,-84},
          {46.94,-90},{84,-90},{84,14},{86,14},{86,88},{110,88}},
                                                             color={255,128,0}));
  connect(Bedroom.thermFloor, thermFloor_Bedroom) annotation (Line(points={{-63.2,
          15.92},{-63.2,6},{-90,6},{-90,-92},{-56,-92},{-56,-94},{-56,-94},{-56,
          -110},{-56,-110}}, color={191,0,0}));
  connect(Children1.thermFloor, thermFloor_Children1) annotation (Line(points={{60.14,
          29.44},{60.14,20},{86,20},{86,-92},{-32,-92},{-32,-110}},
        color={191,0,0}));
  connect(Corridor.thermFloor, thermFloor_Corridor) annotation (Line(points={{59.2,
          -26.86},{59.2,-32},{86,-32},{86,-92},{0,-92},{0,-110}},      color={
          191,0,0}));
  connect(Bath.thermFloor, thermFloor_Bath) annotation (Line(points={{62.14,-37.44},
          {62.14,-32},{86,-32},{86,-92},{30,-92},{30,-110}}, color={191,0,0}));
  connect(Children2.thermFloor, thermFloor_Children2) annotation (Line(points={
          {-65.2,-21.92},{-65.2,-14},{-90,-14},{-90,-92},{70,-92},{70,-110}},
        color={191,0,0}));
  connect(Corridor.thermRoom, thermCorridor) annotation (Line(points={{60.8,-9},
          {60.8,-14},{86,-14},{86,-110},{110,-110}},
                                                   color={191,0,0}));
  connect(Bedroom.thermInsideWall1a, Children1.thermInsideWall1) annotation (
      Line(points={{-44,49.2},{-36,49.2},{-36,86},{32,86},{32,54.4},{41.9,54.4}},
        color={191,0,0}));
  connect(Bedroom.thermInsideWall1b, Corridor.thermInsideWall2a) annotation (
      Line(points={{-44,36.4},{-36,36.4},{-36,86},{32,86},{32,-7.1},{40,-7.1}},
        color={191,0,0}));
  connect(Children2.SolarRadiationPort_Roof, RoofS) annotation (Line(points={{-49.2,
          -84},{-50,-84},{-50,-90},{-34,-90},{-34,84},{-18,84},{-18,78},{36,78},
          {36,82},{90,82},{90,64},{110,64}},                   color={255,128,0}));
  connect(heatStarToCombHeaters.portConvRadComb, portConvRadRooms) annotation (Line(points={{0,-18},{0,0}}, color={191,0,0}));
  connect(Bedroom.starRoom, heatStarToCombHeaters[1].portRad) annotation (Line(points={{-58.8,46},{-58,46},{-58,30},{-14,30},{-14,-38},{-5,-38}}, color={0,0,0}));
  connect(Bedroom.thermRoom, heatStarToCombHeaters[1].portConv) annotation (Line(points={{-64.8,46},{-66,46},{-66,28},{-16,28},{-16,-42},{5,-42},{5,-38}}, color={191,0,0}));
  connect(Children1.starRoom, heatStarToCombHeaters[2].portRad) annotation (Line(points={{55.96,
          52},{56,52},{56,44},{8,44},{8,-44},{-5,-44},{-5,-38}},                                                                                         color={0,0,0}));
  connect(Children1.thermRoom, heatStarToCombHeaters[2].portConv) annotation (Line(points={{61.66,
          52},{61.66,48},{62,48},{62,42},{10,42},{10,-38},{5,-38}},                                                                                         color={191,0,0}));
  connect(Corridor.starRoom, heatStarToCombHeaters[3].portRad) annotation (Line(points={{54.8,-9},
          {54.8,-20},{12,-20},{12,-44},{-5,-44},{-5,-38}},                                                                                         color={0,0,0}));
  connect(Corridor.thermRoom, heatStarToCombHeaters[3].portConv) annotation (Line(points={{60.8,-9},
          {60.8,-22},{14,-22},{14,-38},{5,-38}},                                                                                           color={191,0,0}));
  connect(Bath.starRoom, heatStarToCombHeaters[4].portRad) annotation (Line(points={{57.96,
          -60},{58,-60},{58,-44},{-5,-44},{-5,-38}},                                                                                  color={0,0,0}));
  connect(Bath.thermRoom, heatStarToCombHeaters[4].portConv) annotation (Line(points={{63.66,
          -60},{64,-60},{64,-42},{16,-42},{16,-38},{5,-38}},                                                                                    color={191,0,0}));
  connect(Children2.starRoom, heatStarToCombHeaters[5].portRad) annotation (Line(points={{-60.8,-52},{-60.8,-38},{-5,-38}}, color={0,0,0}));
  connect(Children2.thermRoom, heatStarToCombHeaters[5].portConv) annotation (Line(points={{-66.8,-52},{-66,-52},{-66,-36},{-18,-36},{-18,-42},{5,-42},{5,-38}}, color={191,0,0}));
  connect(AirExchangePort[1], Bedroom.AirExchangePort) annotation (Line(points={{-115,
          -23},{-92,-23},{-92,68.24},{-84,68.24}},                                                                             color={0,0,127}));
  connect(AirExchangePort[2], Children1.AirExchangePort) annotation (Line(points={{-115,
          -17},{-96,-17},{-96,88},{88,88},{88,68.68},{79.9,68.68}},                                                                               color={0,0,127}));
  connect(AirExchangePort[3], Corridor.AirExchangePort) annotation (Line(points={{-115,
          -11},{-96,-11},{-96,88},{88,88},{88,4.205},{80,4.205}},                                                                              color={0,0,127}));
  connect(AirExchangePort[4], Bath.AirExchangePort) annotation (Line(points={{-115,-5},
          {-96,-5},{-96,88},{88,88},{88,-76.68},{81.9,-76.68}},                                                                              color={0,0,127}));
  connect(AirExchangePort[5], Children2.AirExchangePort) annotation (Line(points={{-115,1},
          {-92,1},{-92,-74.24},{-86,-74.24}},                                                                                  color={0,0,127}));
  connect(Bedroom.ports[1], portVent_in[1]) annotation (Line(points={{-65.05,13.52},
          {-58,13.52},{-58,-8},{-20,-8},{-20,-92},{94,-92},{94,-76},{104,-76}},
        color={0,127,255}));
  connect(Bedroom.ports[2], portVent_out[1]) annotation (Line(points={{-58.95,13.52},
          {-58,13.52},{-58,-8},{-20,-8},{-20,-92},{104,-92}},
        color={0,127,255}));
  connect(Children1.ports[1], portVent_in[2]) annotation (Line(points={{61.8975,
          27.64},{40,27.64},{40,28},{20,28},{20,-92},{94,-92},{94,-72},{104,-72}},
        color={0,127,255}));
  connect(Children1.ports[2], portVent_out[2]) annotation (Line(points={{56.1025,
          27.64},{20,27.64},{20,-92},{94,-92},{94,-84},{104,-84},{104,-88}},
        color={0,127,255}));
  connect(Corridor.ports[1], portVent_in[3]) annotation (Line(points={{61.05,-28.285},
          {40,-28.285},{40,-28},{20,-28},{20,-92},{94,-92},{94,-68},{104,-68}},
        color={0,127,255}));
  connect(Corridor.ports[2], portVent_out[3]) annotation (Line(points={{54.95,-28.285},
          {54.95,-32},{20,-32},{20,-92},{94,-92},{94,-84},{104,-84}},
        color={0,127,255}));
  connect(Bath.ports[1], portVent_in[4]) annotation (Line(points={{63.8975,-35.64},
          {62,-35.64},{62,-32},{20,-32},{20,-92},{94,-92},{94,-64},{104,-64}},
        color={0,127,255}));
  connect(Bath.ports[2], portVent_out[4]) annotation (Line(points={{58.1025,-35.64},
          {58.1025,-32},{20,-32},{20,-92},{94,-92},{94,-80},{104,-80}},
        color={0,127,255}));
  connect(Children2.ports[1], portVent_in[5]) annotation (Line(points={{-67.05,-19.52},
          {-58,-19.52},{-58,-8},{-20,-8},{-20,-92},{94,-92},{94,-60},{104,-60}},
        color={0,127,255}));
  connect(Children2.ports[2], portVent_out[5]) annotation (Line(points={{-60.95,
          -19.52},{-58,-19.52},{-58,-8},{-20,-8},{-20,-92},{94,-92},{94,-76},{104,
          -76}},
        color={0,127,255}));

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
