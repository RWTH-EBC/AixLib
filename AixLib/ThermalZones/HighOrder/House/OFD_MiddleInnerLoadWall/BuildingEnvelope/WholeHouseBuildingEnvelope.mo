within AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope;
model WholeHouseBuildingEnvelope

  extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoomParams(    redeclare replaceable parameter DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes);
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  parameter Real AirExchangeCorridor=2 "Air exchange corridors in 1/h "
    annotation (Dialog(group="Air Exchange Corridors", descriptionLabel=true));

  parameter Real solar_absorptance_RO=0.1 "Solar absoptance roof "
    annotation (Dialog(tab="Outer walls", group="Solar absorptance", descriptionLabel=true));

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer UValOutDoors=2.5
    "U-value (thermal transmittance) of doors in outer walls"
    annotation (Dialog(tab="Outer walls", group="Doors"));
  parameter Modelica.Units.SI.Emissivity epsOutDoors(
    min=0,
    max=1) = 0.95 "Emissivity of inside surface of outer doors"
    annotation (Dialog(tab="Outer walls", group="Doors"));

  // Dynamic ventilation (individual temperatures)
  parameter Modelica.Units.SI.Temperature TDynVentLivingroom_set=295.15
    "Livingroom set temperature for dyn. vent." annotation (Dialog(tab=
          "Dynamic ventilation", enable=withDynamicVentilation));
  parameter Modelica.Units.SI.Temperature TDynVentHobby_set=295.15
    "Hobby set temperature for dyn. vent." annotation (Dialog(tab=
          "Dynamic ventilation", enable=withDynamicVentilation));
  parameter Modelica.Units.SI.Temperature TDynVentCorridorGF_set=291.15
    "Corridor (GF) set temperature for dyn. vent." annotation (Dialog(tab=
          "Dynamic ventilation", enable=withDynamicVentilation));
  parameter Modelica.Units.SI.Temperature TDynVentWCStorage_set=291.15
    "WC / Storage room set temperature for dyn. vent." annotation (Dialog(tab=
          "Dynamic ventilation", enable=withDynamicVentilation));
  parameter Modelica.Units.SI.Temperature TDynVentKitchen_set=295.15
    "Kitchen set temperature for dyn. vent." annotation (Dialog(tab=
          "Dynamic ventilation", enable=withDynamicVentilation));
  parameter Modelica.Units.SI.Temperature TDynVentBedroom_set=295.15
    "Bedroom set temperature for dyn. vent." annotation (Dialog(tab=
          "Dynamic ventilation", enable=withDynamicVentilation));
  parameter Modelica.Units.SI.Temperature TDynVentChildren1_set=295.15
    "Children 1 room set temperature for dyn. vent." annotation (Dialog(tab=
          "Dynamic ventilation", enable=withDynamicVentilation));
  parameter Modelica.Units.SI.Temperature TDynVentCorridorUF_set=291.15
    "Corridor (UF) set temperature for dyn. vent." annotation (Dialog(tab=
          "Dynamic ventilation", enable=withDynamicVentilation));
  parameter Modelica.Units.SI.Temperature TDynVentBath_set=297.15
    "Bathroom set temperature for dyn. vent." annotation (Dialog(tab=
          "Dynamic ventilation", enable=withDynamicVentilation));
  parameter Modelica.Units.SI.Temperature TDynVentChildren2_set=295.15
    "Children 2 room set temperature for dyn. vent." annotation (Dialog(tab=
          "Dynamic ventilation", enable=withDynamicVentilation));
  parameter Modelica.Units.SI.Temperature TDynVentAttic_set=288.15
    "Attic set temperature for dyn. vent." annotation (Dialog(tab=
          "Dynamic ventilation", enable=withDynamicVentilation));

  AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope.GroundFloorBuildingEnvelope groundFloor_Building(
    final denAir=denAir,
    final cAir=cAir,
    final wallTypes=wallTypes,
    final energyDynamicsWalls=energyDynamicsWalls,
    final energyDynamics=energyDynamics,
    final T0_air=T0_air,
    final TWalls_start=TWalls_start,
    final calcMethodIn=calcMethodIn,
    final hConIn_const=hConIn_const,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    final Type_Win=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final solar_absorptance_OW=solar_absorptance_OW,
    final calcMethodOut=calcMethodOut,
    final surfaceType=surfaceType,
    final hConOut_const=hConOut_const,
    final use_infiltEN12831=use_infiltEN12831,
    final n50=n50,
    final e=e,
    final eps=eps,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    final withDynamicVentilation=withDynamicVentilation,
    final HeatingLimit=HeatingLimit,
    final Max_VR=Max_VR,
    final Diff_toTempset=Diff_toTempset,
    final UValOutDoors=UValOutDoors,
    final epsOutDoors=epsOutDoors,
    final Tset_Livingroom=TDynVentLivingroom_set,
    final Tset_Hobby=TDynVentHobby_set,
    final Tset_Corridor=TDynVentCorridorGF_set,
    final Tset_WC=TDynVentWCStorage_set,
    final Tset_Kitchen=TDynVentKitchen_set) annotation (Placement(transformation(extent={{-20,-74},{20,-26}})));
  AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope.UpperFloorBuildingEnvelope upperFloor_Building(
    final denAir=denAir,
    final cAir=cAir,
    final wallTypes=wallTypes,
    final energyDynamicsWalls=energyDynamicsWalls,
    final energyDynamics=energyDynamics,
    final T0_air=T0_air,
    final TWalls_start=TWalls_start,
    final calcMethodIn=calcMethodIn,
    final hConIn_const=hConIn_const,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    final Type_Win=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final solar_absorptance_OW=solar_absorptance_OW,
    final calcMethodOut=calcMethodOut,
    final surfaceType=surfaceType,
    final hConOut_const=hConOut_const,
    final use_infiltEN12831=use_infiltEN12831,
    final n50=n50,
    final e=e,
    final eps=eps,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    final HeatingLimit=HeatingLimit,
    final Max_VR=Max_VR,
    final Diff_toTempset=Diff_toTempset,
    final withDynamicVentilation=withDynamicVentilation,
    final solar_absorptance_RO=solar_absorptance_RO,
    final Tset_Bedroom=TDynVentBedroom_set,
    final Tset_Children1=TDynVentChildren1_set,
    final Tset_Corridor=TDynVentCorridorUF_set,
    final Tset_Bath=TDynVentBath_set,
    final Tset_Children2=TDynVentChildren2_set,
    final UValOutDoors=UValOutDoors,
    final epsOutDoors=epsOutDoors) annotation (Placement(transformation(extent={{-24,-12},{22,34}})));
  AixLib.ThermalZones.HighOrder.Rooms.OFD.Attic_Ro2Lf5 attic_2Ro_5Rooms(
    final denAir=denAir,
    final cAir=cAir,
    final wallTypes=wallTypes,
    final energyDynamicsWalls=energyDynamicsWalls,
    final energyDynamics=energyDynamics,
    final T0_air=T0_air,
    final TWalls_start=TWalls_start,
    final calcMethodIn=calcMethodIn,
    final hConIn_const=hConIn_const,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    final Type_Win=Type_Win,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final solar_absorptance_OW=solar_absorptance_OW,
    final calcMethodOut=calcMethodOut,
    final surfaceType=surfaceType,
    final hConOut_const=hConOut_const,
    final use_infiltEN12831=use_infiltEN12831,
    final n50=n50,
    final e=e,
    final eps=eps,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    final withDynamicVentilation=withDynamicVentilation,
    final HeatingLimit=HeatingLimit,
    final Max_VR=Max_VR,
    final Diff_toTempset=Diff_toTempset,
    final Tset=TDynVentAttic_set,
    final solar_absorptance_RO=solar_absorptance_RO,
    length=10.64,
    width=4.75,
    roof_width1=3.36,
    roof_width2=3.36,
    room1_length=5.875,
    room2_length=3.215,
    room3_length=3.92,
    room4_length=3.215,
    room5_length=4.62,
    room1_width=2.28,
    room2_width=2.28,
    room3_width=2.28,
    room4_width=2.28,
    room5_width=2.28,
    alfa=1.5707963267949) annotation (Placement(transformation(extent={{-22,44},{22,82}})));

  Modelica.Blocks.Interfaces.RealInput WindSpeedPort if (calcMethodOut == 1 or calcMethodOut == 2)
                                                     annotation (Placement(
        transformation(extent={{-128,66},{-100,94}}),iconTransformation(extent={{-120,60},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort[11] "1: LivingRoom_GF, 2: Hobby_GF, 3: Corridor_GF, 4: WC_Storage_GF, 5: Kitchen_GF, 6: Bedroom_UF, 7: Child1_UF, 8: Corridor_UF, 9: Bath_UF, 10: Child2_UF, 11: Attic"
                                                                                                                                                                                                        annotation (Placement(transformation(extent={{-128,42},{-100,70}}), iconTransformation(extent={{-120,40},{-100,60}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_RoofS annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={106,58}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={106,60})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_RoofN annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={106,90}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={106,90})));
  Utilities.Interfaces.SolarRad_in North annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={106,18}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={106,30})));
  Utilities.Interfaces.SolarRad_in East annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={106,-18}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={106,0})));
  Utilities.Interfaces.SolarRad_in South annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={106,-56}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={106,-30})));
  Utilities.Interfaces.SolarRad_in West annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={106,-90}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={106,-60})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange varAirExchange(
    final V=0.5*(upperFloor_Building.Corridor.airload.V + groundFloor_Building.Corridor.airload.V),
    final c=cAir,
    final rho=denAir)                           annotation (Placement(
        transformation(
        extent={{-5,5},{5,-5}},
        rotation=270,
        origin={39,-21})));
  Modelica.Blocks.Sources.Constant AirExchangeCorridor_Source(final k=AirExchangeCorridor)
    annotation (Placement(transformation(extent={{56,-16},{50,-10}})));
  AixLib.Utilities.Interfaces.ConvRadComb heatingToRooms[11] "1: LivingRoom_GF, 2: Hobby_GF, 3: Corridor_GF, 4: WC_Storage_GF, 5: Kitchen_GF, 6: Bedroom_UF, 7: Child1_UF, 8: Corridor_UF, 9: Bath_UF, 10: Child2_UF, 11: Attic"
                                                                                                                                                                                                        annotation (Placement(transformation(extent={{-112,-30},{-92,-10}}), iconTransformation(extent={{-110,-38},{-90,-18}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a groundTemp[5] "HeatPorts to force ground temperature(s) for the ground floor."
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
        iconTransformation(extent={{-10,-110},{10,-90}})));
  Components.Walls.BaseClasses.SimpleNLayer groPlateLowPart[5](
    final A={groundFloor_Building.Livingroom.floor.Wall.simpleNLayer.A,groundFloor_Building.Hobby.floor.Wall.simpleNLayer.A,groundFloor_Building.Corridor.floor.Wall.simpleNLayer.A,groundFloor_Building.WC_Storage.floor.Wall.simpleNLayer.A,groundFloor_Building.Kitchen.floor.Wall.simpleNLayer.A},
    each final T_start=fill(TWalls_start, wallTypes.groundPlate_low_half.n),
    each final wallRec=wallTypes.groundPlate_low_half,
    each final energyDynamics=energyDynamicsWalls)    annotation (Placement(transformation(
        extent={{-4,-18},{4,18}},
        rotation=-90,
        origin={0,-86})));
  Utilities.Interfaces.Adaptors.ConvRadToCombPort heatStarToCombAttic annotation (Placement(transformation(
        extent={{6,-5},{-6,5}},
        rotation=180,
        origin={-36,51})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a uppFloDown[5] "Heat port floor of upper floor" annotation (Placement(transformation(extent={{-110,18},{-90,38}}), iconTransformation(extent={{-110,14},{-90,34}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a groFloUp[5] "Heat port ceiling of ground floor" annotation (Placement(transformation(extent={{-110,-4},{-90,16}}), iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a groFloDown[5] "Heat port floor of ground floor (towards ground plate)" annotation (Placement(transformation(extent={{-112,-78},{-92,-58}}), iconTransformation(extent={{-110,-66},{-90,-46}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a groPlateUp[5] "Heat port ground plate towards ground floor" annotation (Placement(transformation(extent={{-112,-100},{-92,-80}}), iconTransformation(extent={{-110,-90},{-90,-70}})));
equation
  connect(upperFloor_Building.thermOutside, thermOutside) annotation (Line(
        points={{-24,33.54},{-74,33.54},{-74,100},{-100,100}}, color={191,0,0}));
  connect(attic_2Ro_5Rooms.thermOutside, thermOutside) annotation (Line(points={{-22,81.62},{-74,81.62},{-74,100},{-100,100}},
                                                   color={191,0,0}));
  connect(groundFloor_Building.thermOutside, thermOutside) annotation (Line(
        points={{-20,-26.48},{-74,-26.48},{-74,100},{-100,100}}, color={191,0,0}));
  connect(attic_2Ro_5Rooms.WindSpeedPort, WindSpeedPort) annotation (Line(
        points={{-24.09,66.8},{-74,66.8},{-74,80},{-114,80}},
                                                           color={0,0,127}));
  connect(upperFloor_Building.WindSpeedPort, WindSpeedPort) annotation (Line(
        points={{-27.45,16.75},{-74,16.75},{-74,80},{-114,80}},      color={0,0,
          127}));
  connect(groundFloor_Building.WindSpeedPort, WindSpeedPort) annotation (Line(
        points={{-23,-43.52},{-74,-43.52},{-74,80},{-114,80}},   color={0,0,127}));
  connect(upperFloor_Building.North, North) annotation (Line(points={{24.3,12.38},{60,12.38},{60,18},{106,18}},
                                      color={255,128,0}));
  connect(groundFloor_Building.North, North) annotation (Line(points={{22,-28.88},{60,-28.88},{60,18},{106,18}},
                                        color={255,128,0}));
  connect(upperFloor_Building.East, East) annotation (Line(points={{24.3,5.48},{60,5.48},{60,-18},{106,-18}},
                                         color={255,128,0}));
  connect(groundFloor_Building.East, East) annotation (Line(points={{22,-35.6},{60,-35.6},{60,-18},{106,-18}},
                                         color={255,128,0}));
  connect(upperFloor_Building.South, South) annotation (Line(points={{24.3,-1.42},{60,-1.42},{60,-56},{106,-56}},
                                          color={255,128,0}));
  connect(groundFloor_Building.South, South) annotation (Line(points={{22,-43.76},{60,-43.76},{60,-56},{106,-56}},
                                          color={255,128,0}));
  connect(upperFloor_Building.West, West) annotation (Line(points={{24.3,-8.32},{60,-8.32},{60,-90},{106,-90}},
                                          color={255,128,0}));
  connect(groundFloor_Building.West, West) annotation (Line(points={{22,-53.84},{60,-53.84},{60,-90},{106,-90}},
                                          color={255,128,0}));
  connect(upperFloor_Building.RoofS, SolarRadiationPort_RoofS) annotation (Line(
        points={{24.3,21.12},{60,21.12},{60,58},{106,58}},color={255,128,0}));
  connect(upperFloor_Building.RoofN, SolarRadiationPort_RoofN) annotation (Line(
        points={{24.3,28.48},{60,28.48},{60,90},{106,90}},color={255,128,0}));
  connect(groundFloor_Building.thermCorridor, varAirExchange.port_b)
    annotation (Line(points={{22,-23.6},{28,-23.6},{28,-26},{39,-26}},
                                                                color={191,0,0}));
  connect(upperFloor_Building.thermCorridor, varAirExchange.port_a) annotation (
     Line(points={{24.3,-14.3},{39,-14.3},{39,-16}}, color={191,0,0}));
  connect(AirExchangeCorridor_Source.y, varAirExchange.ventRate) annotation (
      Line(points={{49.7,-13},{28,-13},{28,-24},{42.2,-24},{42.2,-16.5}},
        color={0,0,127}));
  connect(upperFloor_Building.AirExchangePort[1:5], AirExchangePort[6:10]) annotation (Line(points={{-27.45,
          9.85},{-74,9.85},{-74,61.0909},{-114,61.0909}},                                                                                                     color={0,0,127}));
  connect(AirExchangePort[1:5], groundFloor_Building.AirExchangePort[1:5]) annotation (Line(points={{-114,
          54.7273},{-76,54.7273},{-76,-49.28},{-23,-49.28}},                                                                                               color={0,0,127}));
  connect(attic_2Ro_5Rooms.SolarRadiationPort_RO1, SolarRadiationPort_RoofS)
    annotation (Line(points={{-11,80.1},{-11,90},{60,90},{60,58},{106,58}},
                color={255,128,0}));
  connect(attic_2Ro_5Rooms.SolarRadiationPort_RO2, SolarRadiationPort_RoofN)
    annotation (Line(points={{11,80.1},{12,80.1},{12,90},{106,90}},
                                                                color={255,128,
          0}));

  connect(East, attic_2Ro_5Rooms.SolarRadiationPort_OW1) annotation (Line(
        points={{106,-18},{60,-18},{60,90},{-74,90},{-74,59.2},{-24.2,59.2}},
                                                                          color=
         {255,128,0}));
  connect(West, attic_2Ro_5Rooms.SolarRadiationPort_OW2) annotation (Line(
        points={{106,-90},{60,-90},{60,59.2},{24.2,59.2}},color={255,128,0}));
  connect(attic_2Ro_5Rooms.thermRoom1, upperFloor_Building.thermCeiling_Bedroom) annotation (Line(points={{-17.6,45.9},{-21.7,45.9},{-21.7,36.07}},
                                                                                                                                                color={191,0,0}));
  connect(attic_2Ro_5Rooms.thermRoom2, upperFloor_Building.thermCeiling_Children1) annotation (Line(points={{-8.8,45.9},{-12.27,45.9},{-12.27,36.07}},
                                                                                                                                                    color={191,0,0}));
  connect(attic_2Ro_5Rooms.thermRoom3, upperFloor_Building.thermCeiling_Corridor) annotation (Line(points={{0,45.9},{-3.53,45.9},{-3.53,36.07}},
                                                                                                                                              color={191,0,0}));
  connect(attic_2Ro_5Rooms.thermRoom4, upperFloor_Building.thermCeiling_Bath) annotation (Line(points={{8.8,45.9},{8.8,43},{5.67,43},{5.67,36.07}},
                                                                                                                                                  color={191,0,0}));
  connect(attic_2Ro_5Rooms.thermRoom5, upperFloor_Building.thermCeiling_Children2) annotation (Line(points={{17.6,45.9},{14.87,45.9},{14.87,36.07}},
                                                                                                                                                 color={191,0,0}));

  connect(heatingToRooms[1:5], groundFloor_Building.portConvRadRooms[1:5]) annotation (Line(points={{-102,
          -20.9091},{-90,-20.9091},{-90,-22},{-78,-22},{-78,-46},{0,-46},{0,-49.04}},                                                                  color={191,0,0}));
  connect(heatingToRooms[6:10], upperFloor_Building.portConvRadRooms[1:5]) annotation (Line(points={{-102,
          -16.3636},{-76,-16.3636},{-76,-6},{-1,-6},{-1,11.92}},                                                                                   color={191,0,0}));
  connect(heatStarToCombAttic.portConv, attic_2Ro_5Rooms.thermRoom) annotation (Line(points={{-30,54.125},{-20,54.125},{-20,54},{-3.08,54},{-3.08,63}}, color={191,0,0}));
  connect(attic_2Ro_5Rooms.starRoom, heatStarToCombAttic.portRad) annotation (Line(points={{3.52,63},{3.52,52},{-26,52},{-26,47.875},{-30,47.875}}, color={0,0,0}));
  connect(heatStarToCombAttic.portConvRadComb, heatingToRooms[11]) annotation (Line(points={{-42,51},
          {-46,51},{-46,50},{-72,50},{-72,-15.4545},{-102,-15.4545}},                                                                                            color={191,0,0}));
  connect(AirExchangePort[11], attic_2Ro_5Rooms.AirExchangePort) annotation (Line(points={{-114,
          62.3636},{-76,62.3636},{-76,76.205},{-24.2,76.205}},                                                                                       color={0,0,127}));
  connect(groPlateLowPart.port_b, groundTemp) annotation (Line(points={{0,-90},{0,-100}}, color={191,0,0}));
  connect(groPlateLowPart.port_a, groPlateUp) annotation (Line(points={{8.88178e-16,-82},{0,-82},{0,-80},{-38,-80},{-38,-90},{-102,-90}}, color={191,0,0}));
  connect(groFloDown, groundFloor_Building.groundTemp) annotation (Line(points={{-102,-68},{-38,-68},{-38,-74},{0,-74}}, color={191,0,0}));
  connect(upperFloor_Building.thermFloor_Bedroom, uppFloDown[1]) annotation (Line(points={{-13.88,
          -14.3},{-13.88,-18},{-40,-18},{-40,24},{-100,24}},                                                                                         color={191,0,0}));
  connect(upperFloor_Building.thermFloor_Children1, uppFloDown[2]) annotation (Line(points={{-8.36,
          -14.3},{-8.36,-18},{-40,-18},{-40,26},{-100,26}},                                                                                          color={191,0,0}));
  connect(upperFloor_Building.thermFloor_Corridor, uppFloDown[3]) annotation (Line(points={{-1,-14.3},{-1,-18},{-40,-18},{-40,28},{-100,28}}, color={191,0,0}));
  connect(upperFloor_Building.thermFloor_Bath, uppFloDown[4]) annotation (Line(points={{5.9,
          -14.3},{5.9,-18},{-40,-18},{-40,30},{-100,30}},                                                                                   color={191,0,0}));
  connect(upperFloor_Building.thermFloor_Children2, uppFloDown[5]) annotation (Line(points={{15.1,
          -14.3},{15.1,-18},{-40,-18},{-40,32},{-100,32}},                                                                                         color={191,0,0}));
  connect(groundFloor_Building.thermCeiling_Livingroom, groFloUp[1]) annotation (Line(points={{-18.4,
          -23.84},{-18.4,-20},{-44,-20},{-44,2},{-100,2}},                                                                                              color={191,0,0}));
  connect(groundFloor_Building.thermCeiling_Hobby, groFloUp[2]) annotation (Line(points={{-9.8,
          -23.84},{-9.8,-20},{-44,-20},{-44,4},{-100,4}},                                                                                      color={191,0,0}));
  connect(groundFloor_Building.thermCeiling_Corridor, groFloUp[3]) annotation (Line(points={{-2.2,-23.84},{-2.2,-20},{-44,-20},{-44,6},{-100,6}}, color={191,0,0}));
  connect(groundFloor_Building.thermCeiling_WCStorage, groFloUp[4]) annotation (Line(points={{5.8,
          -23.84},{5.8,-20},{-44,-20},{-44,8},{-100,8}},                                                                                           color={191,0,0}));
  connect(groundFloor_Building.thermCeiling_Kitchen, groFloUp[5]) annotation (Line(points={{14.2,
          -23.84},{14.2,-20},{-44,-20},{-44,10},{-100,10}},                                                                                        color={191,0,0}));

  annotation (Icon(graphics={Rectangle(
          extent={{100,100},{-100,-100}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
                             Bitmap(extent={{-98,100},{98,-100}},
                                                                fileName=
              "modelica://AixLib/Resources/Images/Building/HighOrder/Grundriss.PNG")}),
      Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for the envelope of the whole one family dwelling.
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
<ul>
  <li>
    <i>April 23, 2020</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/752\">#752</a>:
    Propagate all parameters correctly (not geometry). Vectorize
    thermal ports. Delete TIR and TMC.
  </li>
  <li>
    <i>August 1, 2017</i> by Philipp Mehrfeld:<br/>
    Add heat-star-combi to connect heaters in a more clever way
  </li>
  <li>
    <i>Mai 7, 2015</i> by Ana Constantin:<br/>
    Corrected connection of gabled vertical walls with solar radiation
    (E and W)
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
</html>"));
end WholeHouseBuildingEnvelope;
