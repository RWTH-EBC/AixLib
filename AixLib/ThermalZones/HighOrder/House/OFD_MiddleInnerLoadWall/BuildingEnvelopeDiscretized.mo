within AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall;
package BuildingEnvelopeDiscretized
  extends Modelica.Icons.Package;

  model GroundFloorBuildingEnvelope

    extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoomParams(
      final Tset=372.15,
      withDynamicVentilation=false,                                               redeclare replaceable parameter
        AixLib.DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes);
    parameter Integer dis = 1 "Discretisation layers for underfloor heating" annotation (Dialog(enable = use_UFH));

    //////////room geometry
    parameter Modelica.SIunits.Length room_width=3.92
      "width" annotation (Dialog(group="Dimensions", descriptionLabel=true));
    parameter Modelica.SIunits.Height room_height=2.60 "height"
      annotation (Dialog(group="Dimensions", descriptionLabel=true));
    parameter Modelica.SIunits.Length length1=3.3
      "l1 " annotation (Dialog(group="Dimensions", descriptionLabel=true));
    parameter Modelica.SIunits.Length length2=2.44 "l2 "
      annotation (Dialog(group="Dimensions", descriptionLabel=true));
    parameter Modelica.SIunits.Length length3=1.33 "l3 "
      annotation (Dialog(group="Dimensions", descriptionLabel=true));
    parameter Modelica.SIunits.Length length4=3.3
      "l4 " annotation (Dialog(group="Dimensions", descriptionLabel=true));
    parameter Modelica.SIunits.Length thickness_IWsimple=0.145
      "thickness IWsimple "
      annotation (Dialog(group="Dimensions", descriptionLabel=true));

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

    parameter Modelica.SIunits.CoefficientOfHeatTransfer UValOutDoors "U-value (thermal transmittance) of doors in outer walls" annotation (
       Dialog(
        tab="Outer walls",
        group="Doors"));
    parameter Modelica.SIunits.Emissivity epsOutDoors(min=0, max=1)=0.95 "Emissivity of inside surface of outer doors" annotation (
       Dialog(
        tab="Outer walls",
        group="Doors"));

    // Dynamic Ventilation
    parameter Modelica.SIunits.Temperature Tset_Livingroom=295.15
      "Tset_livingroom" annotation (Dialog(
        tab="Dynamic ventilation",
        descriptionLabel=true,
        joinNext=true,
        enable=withDynamicVentilation));
    parameter Modelica.SIunits.Temperature Tset_Hobby=295.15 "Tset_hobby"
      annotation (Dialog(
        tab="Dynamic ventilation",
        descriptionLabel=true,
        enable=withDynamicVentilation));
    parameter Modelica.SIunits.Temperature Tset_Corridor=291.15 "Tset_corridor"
      annotation (Dialog(
        tab="Dynamic ventilation",
        descriptionLabel=true,
        enable=withDynamicVentilation));
    parameter Modelica.SIunits.Temperature Tset_WC=291.15 "Tset_WC" annotation (
        Dialog(
        tab="Dynamic ventilation",
        descriptionLabel=true,
        joinNext=true,
        enable=withDynamicVentilation));
    parameter Modelica.SIunits.Temperature Tset_Kitchen=295.15 "Tset_kitchen"
      annotation (Dialog(
        tab="Dynamic ventilation",
        descriptionLabel=true,
        enable=withDynamicVentilation));

    Rooms.Ow2IwL2IwS1Gr1Uf1 Livingroom(
      final denAir=denAir,
      final cAir=cAir,
      final wallTypes=wallTypes,
      energyDynamicsWalls=energyDynamicsWalls,
      final initDynamicsAir=initDynamicsAir,
      final TWalls_start=TWalls_start,
      final calcMethodIn=calcMethodIn,
      final hConIn_const=hConIn_const,
      final Type_Win=Type_Win,
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
      final initDynamicsAir=initDynamicsAir,
      final TWalls_start=TWalls_start,
      final calcMethodIn=calcMethodIn,
      final hConIn_const=hConIn_const,
      final Type_Win=Type_Win,
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
      final initDynamicsAir=initDynamicsAir,
      final TWalls_start=TWalls_start,
      final calcMethodIn=calcMethodIn,
      final hConIn_const=hConIn_const,
      final Type_Win=Type_Win,
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
      final initDynamicsAir=initDynamicsAir,
      final TWalls_start=TWalls_start,
      final calcMethodIn=calcMethodIn,
      final hConIn_const=hConIn_const,
      final Type_Win=Type_Win,
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
      final initDynamicsAir=initDynamicsAir,
      final TWalls_start=TWalls_start,
      final calcMethodIn=calcMethodIn,
      final hConIn_const=hConIn_const,
      final Type_Win=Type_Win,
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
    Modelica.Blocks.Sources.Constant constAirEx[5](k=fill(0.5, 5))
      "1: LivingRoom_GF, 2: Hobby_GF, 3: Corridor_GF, 4: WC_Storage_GF, 5: Kitchen_GF, 6: Bedroom_UF, 7: Child1_UF, 8: Corridor_UF, 9: Bath_UF, 10: Child2_UF, 11: Attic"
      annotation (Placement(transformation(extent={{-180,-12},{-160,8}})));
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
</html>",   info="<html>
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

  model UpperFloorBuildingEnvelope

    extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoomParams(
      final Tset=372.15,
      withDynamicVentilation=false,                                               redeclare replaceable parameter
        AixLib.DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes);
   parameter Integer dis = 2 "Discretisation layers for underfloor heating" annotation (Dialog(enable = use_UFH));
    //////////room geometry
    parameter Modelica.SIunits.Length room_width_long=3.92 "w1 "
      annotation (Dialog(group="Dimensions", descriptionLabel=true));
    parameter Modelica.SIunits.Length room_width_short=2.28 "w2 "
      annotation (Dialog(group="Dimensions", descriptionLabel=true));
    parameter Modelica.SIunits.Height room_height_long=2.60 "h1 "
      annotation (Dialog(group="Dimensions", descriptionLabel=true));
    parameter Modelica.SIunits.Height room_height_short=1 "h2 "
      annotation (Dialog(group="Dimensions", descriptionLabel=true));
    parameter Modelica.SIunits.Length roof_width=2.21 "wRO"
      annotation (Dialog(group="Dimensions", descriptionLabel=true));
    parameter Modelica.SIunits.Length length5=3.3
      "l5 " annotation (Dialog(group="Dimensions", descriptionLabel=true));
    parameter Modelica.SIunits.Length length6=2.44 "l6 "
      annotation (Dialog(group="Dimensions", descriptionLabel=true));
    parameter Modelica.SIunits.Length length7=1.33 "l7 "
      annotation (Dialog(group="Dimensions", descriptionLabel=true));
    parameter Modelica.SIunits.Length length8=3.3
      "l8 " annotation (Dialog(group="Dimensions", descriptionLabel=true));
    parameter Modelica.SIunits.Length thickness_IWsimple=0.145
      "thickness IWsimple "
      annotation (Dialog(group="Dimensions", descriptionLabel=true));
    // Outer walls properties
    parameter Real solar_absorptance_RO=0.1 "Solar absoptance roof "
      annotation (Dialog(tab="Outer walls", group="Solar absorptance", descriptionLabel=true));
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

    parameter Modelica.SIunits.Temperature Tset_Bedroom=295.15 "Tset_bedroom"
      annotation (Dialog(
        tab="Dynamic ventilation",
        descriptionLabel=true,
        joinNext=true,
        enable=withDynamicVentilation));
    parameter Modelica.SIunits.Temperature Tset_Children1=295.15 "Tset_children1"
      annotation (Dialog(
        tab="Dynamic ventilation",
        descriptionLabel=true,
        enable=withDynamicVentilation));
    parameter Modelica.SIunits.Temperature Tset_Corridor=291.15 "Tset_corridor"
      annotation (Dialog(
        tab="Dynamic ventilation",
        descriptionLabel=true,
        enable=withDynamicVentilation));
    parameter Modelica.SIunits.Temperature Tset_Bath=297.15 "Tset_Bath"
      annotation (Dialog(
        tab="Dynamic ventilation",
        descriptionLabel=true,
        joinNext=true,
        enable=withDynamicVentilation));
    parameter Modelica.SIunits.Temperature Tset_Children2=295.15 "Tset_children2"
      annotation (Dialog(
        group="Dynamic ventilation",
        descriptionLabel=true,
        enable=withDynamicVentilation));

    parameter Modelica.SIunits.CoefficientOfHeatTransfer UValOutDoors "U-value (thermal transmittance) of doors in outer walls" annotation (
       Dialog(
        tab="Outer walls",
        group="Doors"));
    parameter Modelica.SIunits.Emissivity epsOutDoors(min=0, max=1)=0.95 "Emissivity of inside surface of outer doors" annotation (
       Dialog(
        tab="Outer walls",
        group="Doors"));

    AixLib.Utilities.Interfaces.SolarRad_in RoofS annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={110,44})));
    AixLib.Utilities.Interfaces.SolarRad_in RoofN annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={110,76})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Bedroom[dis]
      annotation (Placement(transformation(extent={{-66,-122},{-46,-102}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Children1[dis]
      annotation (Placement(transformation(extent={{-42,-120},{-22,-100}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Corridor[dis]
      annotation (Placement(transformation(extent={{-10,-120},{10,-100}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Bath[dis]
      annotation (Placement(transformation(extent={{20,-120},{40,-100}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Children2[dis]
      annotation (Placement(transformation(extent={{60,-120},{80,-100}})));
    Rooms.Ow2IwL2IwS1Lf1At1Ro1 Bedroom(
      final denAir=denAir,
      final cAir=cAir,
      final wallTypes=wallTypes,
      final energyDynamicsWalls=energyDynamicsWalls,
      final initDynamicsAir=initDynamicsAir,
      final TWalls_start=TWalls_start,
      calcMethodIn=calcMethodIn,
      final hConIn_const=hConIn_const,
      final Type_Win=Type_Win,
      calcMethodOut=calcMethodOut,
      final surfaceType=surfaceType,
      final hConOut_const=hConOut_const,
      final use_infiltEN12831=use_infiltEN12831,
      final n50=n50,
      final e=e,
      final eps=eps,
      final solar_absorptance_OW=solar_absorptance_OW,
      dis=dis,
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
      withDynamicVentilation=withDynamicVentilation,
      HeatingLimit=HeatingLimit,
      Max_VR=Max_VR,
      Diff_toTempset=Diff_toTempset,
      Tset=Tset_Bedroom,
      final T0_air=T0_air,
      final use_UFH=use_UFH)
      annotation (Placement(transformation(extent={{-82,14},{-42,78}})));
    Rooms.Ow2IwL1IwS1Lf1At1Ro1 Children1(
      final denAir=denAir,
      final cAir=cAir,
      final wallTypes=wallTypes,
      final energyDynamicsWalls=energyDynamicsWalls,
      final initDynamicsAir=initDynamicsAir,
      final TWalls_start=TWalls_start,
      calcMethodIn=calcMethodIn,
      final hConIn_const=hConIn_const,
      final Type_Win=Type_Win,
      calcMethodOut=calcMethodOut,
      final surfaceType=surfaceType,
      final hConOut_const=hConOut_const,
      final use_infiltEN12831=use_infiltEN12831,
      final n50=n50,
      final e=e,
      final eps=eps,
      final solar_absorptance_OW=solar_absorptance_OW,
      dis=dis,
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
      withDynamicVentilation=withDynamicVentilation,
      HeatingLimit=HeatingLimit,
      Max_VR=Max_VR,
      Diff_toTempset=Diff_toTempset,
      Tset=Tset_Children1,
      final T0_air=T0_air,
      final eps_door_OD2=epsOutDoors,
      final U_door_OD2=UValOutDoors,
      final use_UFH=use_UFH)
      annotation (Placement(transformation(extent={{82,28},{44,76}})));
    Rooms.Ow2IwL1IwS1Lf1At1Ro1 Bath(
      final denAir=denAir,
      final cAir=cAir,
      final wallTypes=wallTypes,
      final energyDynamicsWalls=energyDynamicsWalls,
      final initDynamicsAir=initDynamicsAir,
      final TWalls_start=TWalls_start,
      calcMethodIn=calcMethodIn,
      final hConIn_const=hConIn_const,
      final Type_Win=Type_Win,
      calcMethodOut=calcMethodOut,
      final surfaceType=surfaceType,
      final hConOut_const=hConOut_const,
      final use_infiltEN12831=use_infiltEN12831,
      final n50=n50,
      final e=e,
      final eps=eps,
      final solar_absorptance_OW=solar_absorptance_OW,
      dis=dis,
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
      withDynamicVentilation=withDynamicVentilation,
      HeatingLimit=HeatingLimit,
      Max_VR=Max_VR,
      Diff_toTempset=Diff_toTempset,
      Tset=Tset_Bath,
      final T0_air=T0_air,
      final eps_door_OD2=epsOutDoors,
      final U_door_OD2=UValOutDoors,
      final use_UFH=use_UFH)
      annotation (Placement(transformation(extent={{84,-36},{46,-84}})));
    Rooms.Ow2IwL2IwS1Lf1At1Ro1 Children2(
      final denAir=denAir,
      final cAir=cAir,
      final wallTypes=wallTypes,
      final energyDynamicsWalls=energyDynamicsWalls,
      final initDynamicsAir=initDynamicsAir,
      final TWalls_start=TWalls_start,
      calcMethodIn=calcMethodIn,
      final hConIn_const=hConIn_const,
      final Type_Win=Type_Win,
      calcMethodOut=calcMethodOut,
      final surfaceType=surfaceType,
      final hConOut_const=hConOut_const,
      final use_infiltEN12831=use_infiltEN12831,
      final n50=n50,
      final e=e,
      final eps=eps,
      final solar_absorptance_OW=solar_absorptance_OW,
      dis=dis,
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
      withDynamicVentilation=withDynamicVentilation,
      HeatingLimit=HeatingLimit,
      Max_VR=Max_VR,
      Diff_toTempset=Diff_toTempset,
      Tset=Tset_Children2,
      final T0_air=T0_air,
      final use_UFH=use_UFH) annotation (Placement(transformation(extent=
              {{-84,-20},{-44,-84}})));
    Rooms.Ow1IwL2IwS1Lf1At1Ro1 Corridor(
      final denAir=denAir,
      final cAir=cAir,
      final wallTypes=wallTypes,
      final energyDynamicsWalls=energyDynamicsWalls,
      final initDynamicsAir=initDynamicsAir,
      final TWalls_start=TWalls_start,
      calcMethodIn=calcMethodIn,
      final hConIn_const=hConIn_const,
      final Type_Win=Type_Win,
      calcMethodOut=calcMethodOut,
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
      dis=dis,
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
      final T0_air=T0_air,
      final use_UFH=use_UFH)
      annotation (Placement(transformation(extent={{82,-28},{42,10}})));
    AixLib.Utilities.Interfaces.SolarRad_in North annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={110,6})));
    AixLib.Utilities.Interfaces.SolarRad_in East annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={110,-24})));
    AixLib.Utilities.Interfaces.SolarRad_in South annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={110,-54})));
    AixLib.Utilities.Interfaces.SolarRad_in West annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={110,-84})));
    Modelica.Blocks.Interfaces.RealInput WindSpeedPort if (calcMethodOut == 1 or calcMethodOut == 2)
      annotation (Placement(transformation(extent={{-148,18},{-118,48}})));
    Modelica.Blocks.Interfaces.RealInput AirExchangePort[5] "1(6): Bedroom_UF, 2(7): Child1_UF, 3(8): Corridor_UF, 4(9): Bath_UF, 5(10): Child2_UF"
      annotation (Placement(transformation(extent={{-148,-26},{-118,4}}), iconTransformation(extent={{-130,-26},{-100,4}})));

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
    AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort heatStarToCombHeaters[5]
      annotation (Placement(transformation(
          extent={{10,-8},{-10,8}},
          rotation=90,
          origin={0,-28})));
    AixLib.Utilities.Interfaces.ConvRadComb portConvRadRooms[5]
      "1(6): Bedroom_UF, 2(7): Child1_UF, 3(8): Corridor_UF, 4(9): Bath_UF, 5(10): Child2_UF"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  equation
    for i in 1:dis loop
    connect(Bedroom.thermFloor[i], thermFloor_Bedroom[i]) annotation (Line(points={{-63.2,
              15.92},{-63.2,6},{-90,6},{-90,-92},{-56,-92},{-56,-112}},
                               color={191,0,0}));
    connect(Children1.thermFloor[i], thermFloor_Children1[i]) annotation (Line(points={
            {64.14,29.44},{64.14,20},{90,20},{90,-92},{-32,-92},{-32,-110}},
          color={191,0,0}));
    connect(Corridor.thermFloor[i], thermFloor_Corridor[i]) annotation (Line(points={{
            63.2,-26.86},{63.2,-32},{90,-32},{90,-92},{0,-92},{0,-110}}, color={
            191,0,0}));
    connect(Bath.thermFloor[i], thermFloor_Bath[i]) annotation (Line(points={{66.14,-37.44},
            {66.14,-32},{90,-32},{90,-92},{30,-92},{30,-110}}, color={191,0,0}));
    connect(Children2.thermFloor[i], thermFloor_Children2[i]) annotation (Line(points={
            {-65.2,-21.92},{-65.2,-14},{-90,-14},{-90,-92},{70,-92},{70,-110}},
          color={191,0,0}));
    end for;
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
            30},{-90,30},{-90,33},{-133,33}}, color={0,0,127}));
    connect(Children2.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-83.9,
            -36},{-90,-36},{-90,33},{-133,33}}, color={0,0,127}));
    connect(Bath.WindSpeedPort, WindSpeedPort) annotation (Line(points={{83.905,
            -50.4},{90,-50.4},{90,-92},{-90,-92},{-90,33},{-133,33}},
                                                               color={0,0,127}));
    connect(Corridor.WindSpeedPort, WindSpeedPort) annotation (Line(points={{81.9,
            -18.5},{90,-18.5},{90,-92},{-90,-92},{-90,33},{-133,33}}, color={0,0,
            127}));
    connect(Children1.WindSpeedPort, WindSpeedPort) annotation (Line(points={{81.905,
            42.4},{90,42.4},{90,-92},{-90,-92},{-90,33},{-133,33}},        color=
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
    connect(AirExchangePort[1], Bedroom.AirExchangePort) annotation (Line(points={{-133,
            -23},{-92,-23},{-92,68.24},{-84,68.24}},                                                                               color={0,0,127}));
    connect(AirExchangePort[2], Children1.AirExchangePort) annotation (Line(points={{-133,
            -17},{-92,-17},{-92,88},{92,88},{92,68.68},{83.9,68.68}},                                                                                 color={0,0,127}));
    connect(AirExchangePort[3], Corridor.AirExchangePort) annotation (Line(points={{-133,
            -11},{-92,-11},{-92,88},{92,88},{92,4.205},{84,4.205}},                                                                                color={0,0,127}));
    connect(AirExchangePort[4], Bath.AirExchangePort) annotation (Line(points={{-133,-5},
            {-92,-5},{-92,88},{92,88},{92,-76.68},{85.9,-76.68}},                                                                                color={0,0,127}));
    connect(AirExchangePort[5], Children2.AirExchangePort) annotation (Line(points={{-133,1},
            {-92,1},{-92,-74.24},{-86,-74.24}},                                                                                    color={0,0,127}));
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
</html>",   info="<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for the envelope of the upper floor.
</p>
</html>"));
  end UpperFloorBuildingEnvelope;

  model WholeHouseBuildingEnvelope

    extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoomParams(    redeclare replaceable parameter
        AixLib.DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes);
    parameter Integer dis = 2 "Discretisation layers for underfloor heating" annotation (Dialog(enable = use_UFH));
    parameter Real AirExchangeCorridor=2 "Air exchange corridors in 1/h "
      annotation (Dialog(group="Air Exchange Corridors", descriptionLabel=true));

    parameter Real solar_absorptance_RO=0.1 "Solar absoptance roof "
      annotation (Dialog(tab="Outer walls", group="Solar absorptance", descriptionLabel=true));

    parameter Modelica.SIunits.CoefficientOfHeatTransfer UValOutDoors=2.5 "U-value (thermal transmittance) of doors in outer walls" annotation (
       Dialog(
        tab="Outer walls",
        group="Doors"));
    parameter Modelica.SIunits.Emissivity epsOutDoors(min=0, max=1)=0.95 "Emissivity of inside surface of outer doors" annotation (
       Dialog(
        tab="Outer walls",
        group="Doors"));

    // Dynamic ventilation (individual temperatures)
    parameter Modelica.SIunits.Temperature TDynVentLivingroom_set = 295.15 "Livingroom set temperature for dyn. vent."
      annotation (Dialog(tab="Dynamic ventilation", enable=withDynamicVentilation));
    parameter Modelica.SIunits.Temperature TDynVentHobby_set = 295.15 "Hobby set temperature for dyn. vent."
      annotation (Dialog(tab="Dynamic ventilation", enable=withDynamicVentilation));
    parameter Modelica.SIunits.Temperature TDynVentCorridorGF_set = 291.15 "Corridor (GF) set temperature for dyn. vent."
      annotation (Dialog(tab="Dynamic ventilation", enable=withDynamicVentilation));
    parameter Modelica.SIunits.Temperature TDynVentWCStorage_set = 291.15 "WC / Storage room set temperature for dyn. vent."
      annotation (Dialog(tab="Dynamic ventilation", enable=withDynamicVentilation));
    parameter Modelica.SIunits.Temperature TDynVentKitchen_set = 295.15 "Kitchen set temperature for dyn. vent."
      annotation (Dialog(tab="Dynamic ventilation", enable=withDynamicVentilation));
    parameter Modelica.SIunits.Temperature TDynVentBedroom_set = 295.15 "Bedroom set temperature for dyn. vent."
      annotation (Dialog(tab="Dynamic ventilation", enable=withDynamicVentilation));
    parameter Modelica.SIunits.Temperature TDynVentChildren1_set = 295.15 "Children 1 room set temperature for dyn. vent."
      annotation (Dialog(tab="Dynamic ventilation", enable=withDynamicVentilation));
    parameter Modelica.SIunits.Temperature TDynVentCorridorUF_set = 291.15 "Corridor (UF) set temperature for dyn. vent."
      annotation (Dialog(tab="Dynamic ventilation", enable=withDynamicVentilation));
    parameter Modelica.SIunits.Temperature TDynVentBath_set = 297.15 "Bathroom set temperature for dyn. vent."
      annotation (Dialog(tab="Dynamic ventilation", enable=withDynamicVentilation));
    parameter Modelica.SIunits.Temperature TDynVentChildren2_set = 295.15 "Children 2 room set temperature for dyn. vent."
      annotation (Dialog(tab="Dynamic ventilation", enable=withDynamicVentilation));
    parameter Modelica.SIunits.Temperature TDynVentAttic_set = 288.15 "Attic set temperature for dyn. vent."
      annotation (Dialog(tab="Dynamic ventilation", enable=withDynamicVentilation));

    AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelopeDiscretized.GroundFloorBuildingEnvelope
      groundFloor_Building(
      final denAir=denAir,
      final cAir=cAir,
      final wallTypes=wallTypes,
      final energyDynamicsWalls=energyDynamicsWalls,
      final initDynamicsAir=initDynamicsAir,
      final T0_air=T0_air,
      final TWalls_start=TWalls_start,
      final calcMethodIn=calcMethodIn,
      final hConIn_const=hConIn_const,
      final Type_Win=Type_Win,
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
      dis=dis,
      final UValOutDoors=UValOutDoors,
      final epsOutDoors=epsOutDoors,
      final Tset_Livingroom=TDynVentLivingroom_set,
      final Tset_Hobby=TDynVentHobby_set,
      final Tset_Corridor=TDynVentCorridorGF_set,
      final Tset_WC=TDynVentWCStorage_set,
      final Tset_Kitchen=TDynVentKitchen_set,
      final use_UFH=use_UFH)
      annotation (Placement(transformation(extent={{-20,-74},{20,-26}})));
    AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelopeDiscretized.UpperFloorBuildingEnvelope
      upperFloor_Building(
      final denAir=denAir,
      final cAir=cAir,
      final wallTypes=wallTypes,
      final energyDynamicsWalls=energyDynamicsWalls,
      final initDynamicsAir=initDynamicsAir,
      final T0_air=T0_air,
      final TWalls_start=TWalls_start,
      final calcMethodIn=calcMethodIn,
      final hConIn_const=hConIn_const,
      final Type_Win=Type_Win,
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
      dis=dis,
      final solar_absorptance_RO=solar_absorptance_RO,
      final Tset_Bedroom=TDynVentBedroom_set,
      final Tset_Children1=TDynVentChildren1_set,
      final Tset_Corridor=TDynVentCorridorUF_set,
      final Tset_Bath=TDynVentBath_set,
      final Tset_Children2=TDynVentChildren2_set,
      final UValOutDoors=UValOutDoors,
      final epsOutDoors=epsOutDoors,
      final use_UFH=use_UFH)
      annotation (Placement(transformation(extent={{-24,-12},{22,34}})));
    AixLib.ThermalZones.HighOrder.Rooms.OFD.Attic_Ro2Lf5 attic_2Ro_5Rooms(
      final denAir=denAir,
      final cAir=cAir,
      final wallTypes=wallTypes,
      final energyDynamicsWalls=energyDynamicsWalls,
      final initDynamicsAir=initDynamicsAir,
      final T0_air=T0_air,
      final TWalls_start=TWalls_start,
      final calcMethodIn=calcMethodIn,
      final hConIn_const=hConIn_const,
      final Type_Win=Type_Win,
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
    AixLib.Utilities.Interfaces.SolarRad_in SolarRadiationPort_RoofS annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={106,58}), iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={106,60})));
    AixLib.Utilities.Interfaces.SolarRad_in SolarRadiationPort_RoofN annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={106,90}), iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={106,90})));
    AixLib.Utilities.Interfaces.SolarRad_in North annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={106,18}), iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={106,30})));
    AixLib.Utilities.Interfaces.SolarRad_in East annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={106,-18}), iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={106,0})));
    AixLib.Utilities.Interfaces.SolarRad_in South annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={106,-56}), iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={106,-30})));
    AixLib.Utilities.Interfaces.SolarRad_in West annotation (Placement(
          transformation(
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
    AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer groPlateLowPart[5](
      final A={groundFloor_Building.Livingroom.floor[1].Wall.A*dis,
          groundFloor_Building.Hobby.floor[1].Wall.A*dis,groundFloor_Building.Corridor.floor[
          1].Wall.A*dis,groundFloor_Building.WC_Storage.floor[1].Wall.A*dis,
          groundFloor_Building.Kitchen.floor[1].Wall.A*dis},
      each final T_start=fill(TWalls_start, wallTypes.groundPlate_low_half.n),
      each final wallRec=wallTypes.groundPlate_low_half,
      each final energyDynamics=energyDynamicsWalls) if not (use_UFH) annotation (
       Placement(transformation(
          extent={{-4,-18},{4,18}},
          rotation=-90,
          origin={0,-86})));
    AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort heatStarToCombAttic
      annotation (Placement(transformation(
          extent={{6,-5},{-6,5}},
          rotation=180,
          origin={-36,51})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a uppFloDown[5*dis]
      "Heat port floor of upper floor" annotation (Placement(transformation(
            extent={{-110,18},{-90,38}}), iconTransformation(extent={{-110,14},{-90,
              34}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a groFloUp[5*dis]
      "Heat port ceiling of ground floor" annotation (Placement(transformation(
            extent={{-110,-4},{-90,16}}), iconTransformation(extent={{-110,-10},{-90,
              10}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a groFloDown[5*dis]
      "Heat port floor of ground floor (towards ground plate)" annotation (
        Placement(transformation(extent={{-112,-78},{-92,-58}}),
          iconTransformation(extent={{-110,-66},{-90,-46}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a groPlateUp[5]
      "Heat port ground plate towards ground floor" annotation (Placement(
          transformation(extent={{-112,-100},{-92,-80}}), iconTransformation(
            extent={{-110,-90},{-90,-70}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollectorGroundPlate[5](each m=
         1) if
         use_UFH
      annotation (Placement(transformation(extent={{-32,-98},{-20,-86}})));
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
          points={{-31.59,18.59},{-74,18.59},{-74,80},{-114,80}},      color={0,0,
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
    connect(groundFloor_Building.AirExchangePort[1:5], AirExchangePort[1:5])
      annotation (Line(points={{-23,-47.84},{-74,-47.84},{-74,53.4545},{
            -114,53.4545}},
          color={0,0,127}));
    connect(upperFloor_Building.AirExchangePort[1:5], AirExchangePort[6:10])
      annotation (Line(points={{-27.45,11.23},{-74,11.23},{-74,66.1818},{
            -114,66.1818}},
          color={0,0,127}));
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
    connect(AirExchangeCorridor_Source.y, varAirExchange.InPort1) annotation (Line(points={{49.7,-13},{41.5,-13},{41.5,-15.5}}, color={0,0,127}));
    connect(heatingToRooms[1:5], groundFloor_Building.portConvRadRooms[1:5]) annotation (Line(points={{-102,
            -21.8182},{-90,-21.8182},{-90,-22},{-78,-22},{-78,-46},{0,-46},
            {0,-48.08}},                                                                                                                                 color={191,0,0}));
    connect(heatingToRooms[6:10], upperFloor_Building.portConvRadRooms[1:5]) annotation (Line(points={{-102,
            -12.7273},{-76,-12.7273},{-76,-6},{-1,-6},{-1,12.84}},                                                                                   color={191,0,0}));
    connect(heatStarToCombAttic.portConv, attic_2Ro_5Rooms.thermRoom) annotation (Line(points={{-30,54.125},{-20,54.125},{-20,54},{-3.08,54},{-3.08,63}}, color={191,0,0}));
    connect(attic_2Ro_5Rooms.starRoom, heatStarToCombAttic.portRad) annotation (Line(points={{3.52,63},{3.52,52},{-26,52},{-26,47.875},{-30,47.875}}, color={0,0,0}));
    connect(heatStarToCombAttic.portConvRadComb, heatingToRooms[11]) annotation (Line(points={{-42,51},{-46,51},{-46,50},{-72,50},{-72,-10.9091},{-102,-10.9091}}, color={191,0,0}));
    connect(AirExchangePort[11], attic_2Ro_5Rooms.AirExchangePort) annotation (Line(points={{-114,
            68.7273},{-76,68.7273},{-76,76.205},{-24.2,76.205}},                                                                                       color={0,0,127}));
    connect(groPlateLowPart.port_b, groundTemp) annotation (Line(points={{0,-90},{0,-100}}, color={191,0,0}));
    connect(groPlateLowPart.port_a, groPlateUp) annotation (Line(points={{6.66134e-16,
            -82},{-64,-82},{-64,-90},{-102,-90}},                                                                    color={191,0,0}));
     for i in 1:dis loop
    connect(upperFloor_Building.thermFloor_Bedroom[i], uppFloDown[i]) annotation (Line(points={{-13.88,
              -14.76},{-13.88,-18},{-40,-18},{-40,28},{-100,28}},                                                                                      color={191,0,0}));
    connect(upperFloor_Building.thermFloor_Children1[i], uppFloDown[dis+i]) annotation (Line(points={{-8.36,
            -14.3},{-8.36,-18},{-40,-18},{-40,28},{-100,28}},                                                                                          color={191,0,0}));
    connect(upperFloor_Building.thermFloor_Corridor[i], uppFloDown[2*dis+i]) annotation (Line(points={{-1,-14.3},{-1,-18},{-40,-18},{-40,28},{-100,28}}, color={191,0,0}));
    connect(upperFloor_Building.thermFloor_Bath[i], uppFloDown[3*dis+i]) annotation (Line(points={{5.9,
            -14.3},{5.9,-18},{-40,-18},{-40,28},{-100,28}},                                                                                   color={191,0,0}));
    connect(upperFloor_Building.thermFloor_Children2[i], uppFloDown[4*dis+i]) annotation (Line(points={{15.1,
            -14.3},{15.1,-18},{-40,-18},{-40,28},{-100,28}},                                                                                         color={191,0,0}));
    connect(groundFloor_Building.thermCeiling_Livingroom[i], groFloUp[i]) annotation (Line(points={{-18.4,
            -23.84},{-18.4,-20},{-44,-20},{-44,6},{-100,6}},                                                                                              color={191,0,0}));
    connect(groundFloor_Building.thermCeiling_Hobby[i], groFloUp[dis+i]) annotation (Line(points={{-9.8,
            -23.84},{-9.8,-20},{-44,-20},{-44,6},{-100,6}},                                                                                      color={191,0,0}));
    connect(groundFloor_Building.thermCeiling_Corridor[i], groFloUp[2*dis+i]) annotation (Line(points={{-2.2,-23.84},{-2.2,-20},{-44,-20},{-44,6},{-100,6}}, color={191,0,0}));
    connect(groundFloor_Building.thermCeiling_WCStorage[i], groFloUp[3*dis+i]) annotation (Line(points={{5.8,
            -23.84},{5.8,-20},{-44,-20},{-44,6},{-100,6}},                                                                                           color={191,0,0}));
    connect(groundFloor_Building.thermCeiling_Kitchen[i], groFloUp[4*dis+i]) annotation (Line(points={{14.2,
            -23.84},{14.2,-20},{-44,-20},{-44,6},{-100,6}},                                                                                          color={191,0,0}));
    connect(groFloDown[i], groundFloor_Building.groundTemp[i]) annotation (Line(points={{-102,-68},{-38,-68},{-38,-74},{0,-74}}, color={191,0,0}));
    connect(groFloDown[dis+i], groundFloor_Building.groundTemp[dis+i]) annotation (Line(points={{-102,-68},{-38,-68},{-38,-74},{0,-74}}, color={191,0,0}));
    connect(groFloDown[2*dis+i], groundFloor_Building.groundTemp[2*dis+i]) annotation (Line(points={{-102,-68},{-38,-68},{-38,-74},{0,-74}}, color={191,0,0}));
    connect(groFloDown[3*dis+i], groundFloor_Building.groundTemp[3*dis+i]) annotation (Line(points={{-102,-68},{-38,-68},{-38,-74},{0,-74}}, color={191,0,0}));
    connect(groFloDown[4*dis+i], groundFloor_Building.groundTemp[4*dis+i]) annotation (Line(points={{-102,-68},{-38,-68},{-38,-74},{0,-74}}, color={191,0,0}));
    end for;
    connect(thermalCollectorGroundPlate.port_b, groundTemp) annotation (Line(
          points={{-26,-98},{-14,-98},{-14,-100},{0,-100}}, color={191,0,0}));
    connect(thermalCollectorGroundPlate.port_a[1], groPlateUp) annotation (Line(
          points={{-26,-86},{-64,-86},{-64,-90},{-102,-90}}, color={191,0,0}));
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

  model OFDHeatLoad
    "Test environment to determine OFD's nominal heat load"
    extends Modelica.Icons.Example;

    parameter Integer nRooms = 11;
    parameter Integer nHeatedRooms = 10;

    parameter Integer TIR=1 "Thermal Insulation Regulation" annotation (Dialog(
        group="Construction parameters",
        compact=true,
        descriptionLabel=true), choices(
        choice=1 "EnEV_2009",
        choice=2 "EnEV_2002",
        choice=3 "WSchV_1995",
        choice=4 "WSchV_1984",
        radioButtons=true));
        parameter Integer dis = wholeHouseBuildingEnvelope.dis;
    Modelica.Blocks.Sources.Constant constRooms[nHeatedRooms](k={293.15,293.15,293.15,
          293.15,293.15,293.15,293.15,293.15,293.15,293.15})
      "1: LivingRoom_GF, 2: Hobby_GF, 3: Corridor_GF, 4: WC_Storage_GF, 5: Kitchen_GF, 6: Bedroom_UF, 7: Child1_UF, 8: Corridor_UF, 9: Bath_UF, 10: Child2_UF, 11: Attic"                                     annotation (Placement(transformation(extent={{-70,-62},{-50,-42}})));
    Modelica.Blocks.Sources.Constant constAirEx[nRooms](k={0.5,0.5,0,0.5,0.5,0.5,0.5,0,0.5,0.5,0})
      "1: LivingRoom_GF, 2: Hobby_GF, 3: Corridor_GF, 4: WC_Storage_GF, 5: Kitchen_GF, 6: Bedroom_UF, 7: Child1_UF, 8: Corridor_UF, 9: Bath_UF, 10: Child2_UF, 11: Attic"                                     annotation (Placement(transformation(extent={{-70,6},{-50,26}})));
    Modelica.Blocks.Sources.Constant constWind(k=0)
      annotation (Placement(transformation(extent={{-70,36},{-50,56}})));
    Modelica.Blocks.Sources.Constant constAmb(k=261.15)
      annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature groundTemp[5](T=fill(
          273.15 + 8.5, 5))
      annotation (Placement(transformation(extent={{-54,-96},{-42,-84}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature[nHeatedRooms] annotation (Placement(transformation(extent={{-36,-58},{-24,-46}})));
    AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort heatStarToComb[nRooms]
      annotation (Placement(transformation(
          extent={{8,-6},{-8,6}},
          rotation=0,
          origin={-36,-20})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedAmbTemperature
      annotation (Placement(transformation(extent={{-40,58},{-28,70}})));
    AixLib.Utilities.Sources.PrescribedSolarRad varRad(n=6)
      annotation (Placement(transformation(extent={{70,60},{50,80}})));
    Modelica.Blocks.Sources.Constant constSun[6](k=fill(0, 6))
      annotation (Placement(transformation(extent={{100,70},{80,90}})));
    Modelica.Blocks.Sources.RealExpression sumHeatLoads(y=-sum(prescribedTemperature[:].port.Q_flow))
      annotation (Placement(transformation(extent={{42,-72},{62,-52}})));
    Modelica.Blocks.Sources.RealExpression heatLoads[nHeatedRooms](y=-(prescribedTemperature[:].port.Q_flow))
      annotation (Placement(transformation(extent={{42,-92},{62,-72}})));
    Modelica.Blocks.Interfaces.RealOutput totalHeatLoad
      annotation (Placement(transformation(extent={{88,-72},{108,-52}})));
    Modelica.Blocks.Interfaces.RealOutput roomHeatLoads[nHeatedRooms]
      annotation (Placement(transformation(extent={{88,-92},{108,-72}})));
    WholeHouseBuildingEnvelope wholeHouseBuildingEnvelope(
      use_UFH=false,
      redeclare UnderfloorHeating.BaseClasses.FloorLayers.EnEV2009Heavy_UFH
                                                          wallTypes,
      energyDynamicsWalls=Modelica.Fluid.Types.Dynamics.FixedInitial,
      initDynamicsAir=Modelica.Fluid.Types.Dynamics.FixedInitial,
      T0_air=294.15,
      TWalls_start=292.15,
      calcMethodIn=1,
      redeclare AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009
        Type_Win,
      use_infiltEN12831=true,
      n50=if TIR == 1 or TIR == 2 then 3 else if TIR == 3 then 4 else 6,
      dis=1,
      AirExchangeCorridor=0,
      UValOutDoors=if TIR == 1 then 1.8 else 2.9)
      annotation (Placement(transformation(extent={{-14,-10},{42,46}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowRad[nRooms] annotation (Placement(transformation(extent={{-60,-24},{-48,-12}})));
    Modelica.Blocks.Sources.Constant adiabaticRadRooms[nRooms](k=fill(0, nRooms))
      "1: LivingRoom_GF, 2: Hobby_GF, 3: Corridor_GF, 4: WC_Storage_GF, 5: Kitchen_GF, 6: Bedroom_UF, 7: Child1_UF, 8: Corridor_UF, 9: Bath_UF, 10: Child2_UF, 11: Attic"                                     annotation (Placement(transformation(extent={{-90,-26},{-74,-10}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlowAttic[1](Q_flow=
         {0}) annotation (Placement(transformation(extent={{-62,-34},{-52,
              -24}})));
  equation
    connect(constRooms.y,prescribedTemperature. T) annotation (Line(
        points={{-49,-52},{-37.2,-52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(constAmb.y, prescribedAmbTemperature.T) annotation (Line(
        points={{-49,80},{-46,80},{-46,64},{-41.2,64}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(constSun.y,varRad. I) annotation (Line(
        points={{79,80},{74,80},{74,78.9},{68.9,78.9}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(constSun.y,varRad. I_dir) annotation (Line(
        points={{79,80},{74,80},{74,75},{69,75}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(constSun.y,varRad. I_diff) annotation (Line(
        points={{79,80},{74,80},{74,71},{69,71}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(constSun.y,varRad. I_gr) annotation (Line(
        points={{79,80},{74,80},{74,66.9},{68.9,66.9}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(constSun.y,varRad. AOI) annotation (Line(
        points={{79,80},{74,80},{74,63},{69,63}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sumHeatLoads.y,totalHeatLoad)
                                      annotation (Line(
        points={{63,-62},{98,-62}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(heatLoads.y,roomHeatLoads)  annotation (Line(
        points={{63,-82},{98,-82}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(constWind.y, wholeHouseBuildingEnvelope.WindSpeedPort) annotation (
        Line(points={{-49,46},{-38,46},{-38,37.6},{-16.8,37.6}},    color={0,0,
            127}));
    connect(prescribedAmbTemperature.port, wholeHouseBuildingEnvelope.thermOutside)
      annotation (Line(points={{-28,64},{-14,64},{-14,45.44}},    color={191,0,0}));
    connect(groundTemp.port, wholeHouseBuildingEnvelope.groundTemp)
      annotation (Line(points={{-42,-90},{14,-90},{14,-10}}, color={191,0,0}));
    connect(varRad.solarRad_out[1], wholeHouseBuildingEnvelope.North) annotation (
       Line(points={{51,69.1667},{48,69.1667},{48,26.4},{43.68,26.4}},  color={
            255,128,0}));
    connect(varRad.solarRad_out[2], wholeHouseBuildingEnvelope.East) annotation (
        Line(points={{51,69.5},{48,69.5},{48,18},{43.68,18}},      color={255,128,
            0}));
    connect(varRad.solarRad_out[3], wholeHouseBuildingEnvelope.South) annotation (
       Line(points={{51,69.8333},{48,69.8333},{48,9.6},{43.68,9.6}},  color={255,
            128,0}));
    connect(varRad.solarRad_out[4], wholeHouseBuildingEnvelope.West) annotation (
        Line(points={{51,70.1667},{48,70.1667},{48,1.2},{43.68,1.2}},  color={255,
            128,0}));
    connect(varRad.solarRad_out[5], wholeHouseBuildingEnvelope.SolarRadiationPort_RoofN)
      annotation (Line(points={{51,70.5},{48,70.5},{48,43.2},{43.68,43.2}},color=
            {255,128,0}));
    connect(varRad.solarRad_out[6], wholeHouseBuildingEnvelope.SolarRadiationPort_RoofS)
      annotation (Line(points={{51,70.8333},{48,70.8333},{48,34.8},{43.68,
            34.8}},
          color={255,128,0}));
    connect(heatStarToComb.portConvRadComb, wholeHouseBuildingEnvelope.heatingToRooms) annotation (Line(points={{-28,-20},{-26,-20},{-26,10},{-14,10},{-14,10.16}},        color={191,0,0}));
    connect(constAirEx.y, wholeHouseBuildingEnvelope.AirExchangePort) annotation (
       Line(points={{-49,16},{-44,16},{-44,32},{-16.8,32}},      color={0,0,127}));
    connect(prescribedHeatFlowRad.port, heatStarToComb.portRad) annotation (Line(points={{-48,-18},{-46,-18},{-46,-16.25},{-44,-16.25}}, color={191,0,0}));
    connect(adiabaticRadRooms.y, prescribedHeatFlowRad.Q_flow)
      annotation (Line(points={{-73.2,-18},{-60,-18}}, color={0,0,127}));
    connect(wholeHouseBuildingEnvelope.uppFloDown, wholeHouseBuildingEnvelope.groFloUp) annotation (Line(points={{-14,24.72},{-22,24.72},{-22,18},{-14,18}}, color={191,0,0}));
    for i in 1:dis loop
    connect(wholeHouseBuildingEnvelope.groFloDown[i], wholeHouseBuildingEnvelope.groPlateUp[1]) annotation (Line(points={{-14,
              2.32},{-22,2.32},{-22,-6.64},{-14,-6.64}},                                                                                                               color={191,0,0}));
    connect(wholeHouseBuildingEnvelope.groFloDown[dis+i], wholeHouseBuildingEnvelope.groPlateUp[2]) annotation (Line(points={{-14,
              2.32},{-22,2.32},{-22,-5.52},{-14,-5.52}},                                                                                                                   color={191,0,0}));
    connect(wholeHouseBuildingEnvelope.groFloDown[2*dis+i], wholeHouseBuildingEnvelope.groPlateUp[3]) annotation (Line(points={{-14,2.32},{-22,2.32},{-22,-4.4},{-14,-4.4}}, color={191,0,0}));
    connect(wholeHouseBuildingEnvelope.groFloDown[3*dis+i], wholeHouseBuildingEnvelope.groPlateUp[4]) annotation (Line(points={{-14,
              2.32},{-22,2.32},{-22,-3.28},{-14,-3.28}},                                                                                                                     color={191,0,0}));
    connect(wholeHouseBuildingEnvelope.groFloDown[4*dis+i], wholeHouseBuildingEnvelope.groPlateUp[5]) annotation (Line(points={{-14,
              2.32},{-22,2.32},{-22,-2.16},{-14,-2.16}},                                                                                                                     color={191,0,0}));
    end for;
    connect(prescribedTemperature[1:10].port, heatStarToComb[1:10].portConv) annotation (Line(points={{-24,-52},{-20,-52},{-20,-30},{-44,-30},{-44,-23.75}}, color={191,0,0}));
    connect(fixedHeatFlowAttic[1].port, heatStarToComb[1].portConv) annotation (Line(points={{-52,-29},{-50,-29},{-50,-23.75},{-44,-23.75}}, color={191,0,0}));
    annotation (experiment(StartTime = 0, StopTime = 25920000, Interval=3600, Tolerance=1e-6, Algorithm="dassl"),
      __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/ThermalZones/HighOrder/Examples/OFDHeatLoad.mos"
                        "Simulate and plot"),
      Diagram(graphics={
          Text(
            extent={{-112,-40},{-74,-62}},
            lineColor={28,108,200},
            textString="DIN EN 12831 Beiblatt 1
Table 4"),Text(
            extent={{-112,26},{-74,4}},
            lineColor={28,108,200},
            textString="DIN EN 12831 Beiblatt 1
Table 8"),Text(
            extent={{-94,-80},{-56,-102}},
            lineColor={28,108,200},
            textString="DIN EN 12831 Beiblatt 1
Table 1 \\theta'_m,e and see
Calculation example: Chapter 6.1.3.4"),
          Text(
            extent={{-112,90},{-74,68}},
            lineColor={28,108,200},
            textString="DIN EN 12831 Beiblatt 1
Table 1")}),   experiment(StopTime=25920000, Interval=3600),
      Documentation(revisions="<html><ul>
  <li>
    <i>August 1, 2017</i> by Philipp Mehrfeld:<br/>
    Implement example
  </li>
</ul>
</html>"));
  end OFDHeatLoad;

  package Rooms
    model Ow2IwL2IwS1Lf1At1Ro1
      "2 outer walls, 2 inner walls load, 1 inner wall simple, 1 floor towards lower floor, 1 ceiling towards attic, 1 roof towards outside"

      extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoom(    redeclare
          AixLib.DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes,
        final room_V=room_length*room_width_long*
          room_height_long - room_length*(room_width_long - room_width_short)*(
          room_height_long - room_height_short)*0.5);
       parameter Integer dis = 1 "Discretisation layers for underfloor heating" annotation (Dialog(enable = use_UFH));

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

      parameter Real solar_absorptance_RO=0.25 "Solar absoptance roof "
        annotation (Dialog(group="Outer wall properties", descriptionLabel=true));

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
      parameter Real eps_door_OD2=0.95 "eps" annotation (Dialog(
          group="Windows and Doors",
          descriptionLabel=true,
          enable=withDoor2));
      parameter Real U_door_OD2=2.5 "U-value" annotation (
         Dialog(
          group="Windows and Doors",
          joinNext=true,
          descriptionLabel=true,
          enable=withDoor2));

      AixLib.ThermalZones.HighOrder.Components.Walls.Wall outside_wall1(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.OW,
        wall_length=room_length,
        wall_height=room_height_short,
        withWindow=false,
        windowarea=0,
        withDoor=false,
        door_height=0,
        door_width=0,
        final use_condLayers=true)
                         annotation (Placement(transformation(extent={{-88,-24},{-78,32}})));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall outside_wall2(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.OW,
        windowarea=windowarea_OW2,
        door_height=door_height_OD2,
        door_width=door_width_OD2,
        withWindow=withWindow2,
        withDoor=withDoor2,
        wall_length=room_width_long,
        wall_height=0.5*(room_height_long + room_height_short + room_width_short/room_width_long*(room_height_long - room_height_short)),
        U_door=U_door_OD2,
        eps_door=eps_door_OD2,
        final use_condLayers=true)
                               annotation (Placement(transformation(
            origin={-25,58},
            extent={{-6,-33},{6,33}},
            rotation=270)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall1a(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW2_vert_half_a,
        outside=false,
        wall_length=room_length - room_lengthb,
        wall_height=room_height_long,
        withWindow=false,
        withDoor=false,
        final use_condLayers=true)
                        annotation (Placement(transformation(
            origin={60,19},
            extent={{-2,-15},{2,15}},
            rotation=180)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall2(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW_vert_half_a,
        outside=false,
        wall_length=room_width_long,
        wall_height=0.5*(room_height_long + room_height_short + room_width_short/room_width_long*(room_height_long - room_height_short)),
        withWindow=false,
        withDoor=false,
        final use_condLayers=true)
                        annotation (Placement(transformation(
            origin={28,-60},
            extent={{-4.00002,-26},{4.00001,26}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Ceiling(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW_hori_att_low_half,
        outside=false,
        wall_length=room_length,
        wall_height=room_width_short,
        withWindow=false,
        withDoor=false,
        ISOrientation=3,
        final use_condLayers=true)
                         annotation (Placement(transformation(
            origin={28,60},
            extent={{1.99999,-10},{-1.99998,10}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall floor[dis](
        each final energyDynamics=energyDynamicsWalls,
        each final solar_absorptance=solar_absorptance_OW,
        each final calcMethodOut=calcMethodOut,
        each final hConOut_const=hConOut_const,
        each final surfaceType=surfaceType,
        each final calcMethodIn=calcMethodIn,
        each final WindowType=Type_Win,
        each final T0=TWalls_start,
        each final withSunblind=use_sunblind,
        each final Blinding=1 - ratioSunblind,
        each final LimitSolIrr=solIrrThreshold,
        each final TOutAirLimit=TOutAirLimit,
        each wallPar=wallTypes.IW_hori_upp_half,
        each outside=false,
        each wall_length=room_length/dis,
        each wall_height=room_width_long,
        each withWindow=false,
        each withDoor=false,
        each ISOrientation=2,
        each final use_condLayers=not use_UFH) annotation (Placement(transformation(
            origin={-24,-60},
            extent={{-1.99999,-10},{1.99999,10}},
            rotation=90)));

      AixLib.ThermalZones.HighOrder.Components.Walls.Wall roof(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_RO,
        final wallPar=wallTypes.roofRoomUpFloor,
        wall_length=room_length,
        withDoor=false,
        door_height=0,
        door_width=0,
        wall_height=roof_width,
        withWindow=withWindow3,
        windowarea=windowarea_RO,
        final use_condLayers=true)
                             annotation (Placement(transformation(
            origin={59,59},
            extent={{-3.00001,-17},{3.00002,17}},
            rotation=270)));

      AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall1b(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW2_vert_half_a,
        outside=false,
        wall_length=room_lengthb,
        wall_height=room_height_long,
        withWindow=false,
        withDoor=false,
        final use_condLayers=true)
                        annotation (Placement(transformation(
            origin={60,-19},
            extent={{-2,-15},{2,15}},
            rotation=180)));

      AixLib.Utilities.Interfaces.SolarRad_in SolarRadiationPort_Roof annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={74,100})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2
        annotation (Placement(transformation(extent={{20,-100},{40,-80}}),
            iconTransformation(extent={{20,-100},{40,-80}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1a
        annotation (Placement(transformation(extent={{80,0},{100,20}})));
      AixLib.Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1 annotation (
          Placement(transformation(extent={{-119.5,20},{-99.5,40}}),
            iconTransformation(extent={{-109.5,20},{-89.5,40}})));
      AixLib.Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW2 annotation (
          Placement(transformation(
            origin={44.5,101},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
        annotation (Placement(transformation(extent={{80,40},{100,60}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1b
        annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor[dis]
        annotation (Placement(transformation(extent={{-16,-104},{4,-84}}),
            iconTransformation(extent={{-16,-104},{4,-84}})));
      Modelica.Blocks.Interfaces.RealInput WindSpeedPort if (calcMethodOut == 1 or calcMethodOut == 2)
        annotation (Placement(transformation(extent={{-126,-74},{-99.5,-48}}),
                                                                             iconTransformation(extent={{-109.5,-60},{-89.5,-40}})));

    equation
      connect(outside_wall1.SolarRadiationPort, SolarRadiationPort_OW1) annotation (
         Line(points={{-89.5,29.6667},{-86,29.6667},{-86,30},{-109.5,30}},color={0,0,
              0}));
      connect(inside_wall2.port_outside, thermInsideWall2)
        annotation (Line(points={{28,-64.2},{28,-90},{30,-90}}, color={191,0,0}));
      connect(thermInsideWall2, thermInsideWall2)
        annotation (Line(points={{30,-90},{30,-90}}, color={191,0,0}));
      connect(inside_wall1b.port_outside, thermInsideWall1b)
        annotation (Line(points={{62.1,-19},{90,-19},{90,-30}}, color={191,0,0}));
      connect(inside_wall1a.port_outside, thermInsideWall1a) annotation (Line(
            points={{62.1,19},{84,19},{84,20},{90,20},{90,10}}, color={191,0,0}));
      connect(roof.SolarRadiationPort, SolarRadiationPort_Roof) annotation (Line(
            points={{74.5833,62.9},{74.5833,92},{74,92},{74,100}}, color={255,128,0}));
      connect(Ceiling.port_outside, thermCeiling) annotation (Line(points={{28,62.1},
              {28,62.1},{28,74},{90,74},{90,50}}, color={191,0,0}));
      connect(outside_wall2.SolarRadiationPort, SolarRadiationPort_OW2) annotation (
         Line(points={{5.25,65.8},{5.25,74},{44.5,74},{44.5,101}}, color={255,128,0}));
      for i in 1:dis loop
      connect(thermFloor[i], floor[i].port_outside) annotation (Line(points={{-6,-94},
                {-8,-94},{-8,-70},{-24,-70},{-24,-62.1}},                                                                 color={191,0,0}));
      connect(floor[i].thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-24,-58},
                {-24,-48},{-7,-48},{-7,-8}},
                                           color={191,0,0}));
      end for;
      connect(outside_wall2.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-25,52},{-25,40},{40,40},{40,-40},{-7,-40},{-7,-8}},          color={191,0,0}));
      connect(roof.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{59,56},
              {59,40},{40,40},{40,-40},{-7,-40},{-7,-8}},                                                                                                       color={191,0,0}));
      connect(Ceiling.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{28,58},
              {28,40},{40,40},{40,-40},{-7,-40},{-7,-8}},                                                                                                          color={191,0,0}));
      connect(inside_wall1b.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{58,-19},{40,-19},{40,-40},{-7,-40},{-7,-8}},          color={191,0,0}));
      connect(inside_wall1a.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{58,19},{40,19},{40,-40},{-7,-40},{-7,-8}},          color={191,0,0}));
      connect(inside_wall2.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{28,-56},
              {28,-40},{-6,-40},{-6,-8},{-7,-8}},                                                                                                                    color={191,0,0}));
      connect(outside_wall1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-78,4},{-74,4},{-74,-40},{-7,-40},{-7,-8}},            color={191,0,0}));
      connect(WindSpeedPort, outside_wall1.WindSpeedPort) annotation (Line(points={{-112.75,
              -61},{-96,-61},{-96,24.5333},{-88.25,24.5333}},                                                                             color={0,0,127}));
      connect(WindSpeedPort, roof.WindSpeedPort) annotation (Line(points={{-112.75,
              -61},{-96,-61},{-96,70},{71.4667,70},{71.4667,62.15}},                                                                    color={0,0,127}));
      connect(WindSpeedPort, outside_wall2.WindSpeedPort) annotation (Line(points={{-112.75,-61},{-96,-61},{-96,70},{-0.8,70},{-0.8,64.3}},
                                                                                                                                          color={0,0,127}));
        connect(outside_wall1.port_outside, thermOutside) annotation (Line(points={{-88.25,4},{-94,4},{-94,100},{-100,100}}, color={191,0,0}));
      connect(outside_wall2.port_outside, thermOutside) annotation (Line(points={{-25,64.3},{-25,100},{-100,100}}, color={191,0,0}));
      connect(roof.port_outside, thermOutside) annotation (Line(points={{59,
              62.15},{59,76},{-25,76},{-25,100},{-100,100}},                                                               color={191,0,0}));
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
            revisions="<html><ul>
  <li>
    <i>April 23, 2020</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/752\">#752</a>:
    Propagate all parameters correctly. Extend from new partial room
    model. Delete TIR and TMC. Tidy up.
  </li>
  <li>
    <i>April 18, 2014</i> by Ana Constantin:<br/>
    Added documentation
  </li>
  <li>
    <i>July 8, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>",     info="<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for a room with
  2&#160;outer&#160;walls,&#160;2&#160;inner&#160;walls&#160;load
  towards two different rooms but with the same
  orientation,&#160;1&#160;inner&#160;wall&#160;simple,&#160;1&#160;floor&#160;towards&#160;lower&#160;floor,&#160;1&#160;ceiling&#160;towards&#160;attic,&#160;1&#160;roof&#160;towards&#160;outside.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The following figure presents the room's layout:
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/OW2_2IWl_1IWs_1Pa_1At1Ro.png\"
  alt=\"Room layout\">
</p>
</html>"));
    end Ow2IwL2IwS1Lf1At1Ro1;

    model Ow1IwL2IwS1Gr1Uf1
      "1 outer wall, 2 inner walls load, 1 inner wall simple, 1 floor towards ground, 1 ceiling towards upper floor"

      extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoom(    redeclare
          AixLib.DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes,
                                                                              final room_V=room_length*room_width*room_height);
    parameter Integer dis = 1 "Discretisation layers for underfloor heating" annotation (Dialog(enable = use_UFH));
      //////////room geometry
      parameter Modelica.SIunits.Length room_length=2 "length"
        annotation (Dialog(group="Dimensions", descriptionLabel=true));
      parameter Modelica.SIunits.Length room_lengthb=1 "length_b "
        annotation (Dialog(group="Dimensions", descriptionLabel=true));
      parameter Modelica.SIunits.Length room_width=2 "width "
        annotation (Dialog(group="Dimensions", descriptionLabel=true));
      parameter Modelica.SIunits.Height room_height=2 "height "
        annotation (Dialog(group="Dimensions", descriptionLabel=true));

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
      parameter Real U_door_OD1=2.5 "U-value" annotation (
         Dialog(
          group="Windows and Doors",
          joinNext=true,
          descriptionLabel=true,
          enable=withDoor1));
      parameter Real eps_door_OD1=0.95 "eps" annotation (Dialog(
          group="Windows and Doors",
          descriptionLabel=true,
          enable=withDoor1));

      AixLib.ThermalZones.HighOrder.Components.Walls.Wall outside_wall1(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.OW,
        windowarea=windowarea_OW1,
        door_height=door_height_OD1,
        door_width=door_width_OD1,
        wall_length=room_length,
        wall_height=room_height,
        withWindow=withWindow1,
        withDoor=withDoor1,
        U_door=U_door_OD1,
        eps_door=eps_door_OD1,
        final use_condLayers=true)             annotation (Placement(transformation(extent={{-60,-14},{-50,42}})));

      AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall1(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW_vert_half_a,
        outside=false,
        wall_length=room_width,
        wall_height=room_height,
        withWindow=false,
        withDoor=false,
        final use_condLayers=true)
                        annotation (Placement(transformation(
            origin={23,59},
            extent={{-5.00018,-29},{5.00003,29}},
            rotation=270)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall2a(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW2_vert_half_a,
        outside=false,
        wall_length=room_length - room_lengthb,
        wall_height=room_height,
        withWindow=false,
        withDoor=false,
        final use_condLayers=true)
                        annotation (Placement(transformation(
            origin={61,23},
            extent={{-3,-15},{3,15}},
            rotation=180)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall3(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW_vert_half_a,
        outside=false,
        wall_length=room_width,
        wall_height=room_height,
        withWindow=false,
        withDoor=false,
        final use_condLayers=true)
                        annotation (Placement(transformation(
            origin={25,-59},
            extent={{-5.00002,-29},{5.00001,29}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Ceiling[dis](
        each final energyDynamics=energyDynamicsWalls,
        each final calcMethodOut=calcMethodOut,
        each final hConOut_const=hConOut_const,
        each final surfaceType=surfaceType,
        each final calcMethodIn=calcMethodIn,
        each final hConIn_const=hConIn_const,
        each final WindowType=Type_Win,
        each final T0=TWalls_start,
        each final withSunblind=use_sunblind,
        each final Blinding=1 - ratioSunblind,
        each final LimitSolIrr=solIrrThreshold,
        each final TOutAirLimit=TOutAirLimit,
        each final solar_absorptance=solar_absorptance_OW,
        each final wallPar=wallTypes.IW_hori_low_half,
        each outside=false,
        each wall_length=room_length/dis,
        each wall_height=room_width,
        each withWindow=false,
        each withDoor=false,
        each ISOrientation=3,
        each final use_condLayers=not use_UFH)
                         annotation (Placement(transformation(
            origin={-31,60},
            extent={{2,-9},{-2,9}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall floor[dis](
        each final energyDynamics=energyDynamicsWalls,
        each final calcMethodOut=calcMethodOut,
        each final hConOut_const=hConOut_const,
        each final surfaceType=surfaceType,
        each final calcMethodIn=calcMethodIn,
        each final hConIn_const=hConIn_const,
        each final WindowType=Type_Win,
        each final T0=TWalls_start,
        each final withSunblind=use_sunblind,
        each final Blinding=1 - ratioSunblind,
        each final LimitSolIrr=solIrrThreshold,
        each final TOutAirLimit=TOutAirLimit,
        each final solar_absorptance=solar_absorptance_OW,
        each final wallPar=wallTypes.groundPlate_upp_half,
        each outside=false,
        each wall_length=room_length/dis,
        each wall_height=room_width,
        each withWindow=false,
        each withDoor=false,
        each ISOrientation=2,
        each final use_condLayers=not use_UFH) annotation (Placement(transformation(
            origin={-27,-60},
            extent={{-2.00002,-11},{2.00001,11}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall2b(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW2_vert_half_a,
        outside=false,
        wall_length=room_lengthb,
        wall_height=room_height,
        withWindow=false,
        withDoor=false,
        final use_condLayers=true)
                        annotation (Placement(transformation(
            origin={61,-17},
            extent={{-3,-15},{3,15}},
            rotation=180)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall3
        annotation (Placement(transformation(extent={{34,-104},{54,-84}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2a
        annotation (Placement(transformation(extent={{80,20},{100,40}})));
      Modelica.Blocks.Interfaces.RealInput WindSpeedPort if (calcMethodOut == 1 or calcMethodOut == 2)
                                                         annotation (Placement(
            transformation(extent={{-119.5,-70},{-99.5,-50}}), iconTransformation(
              extent={{-109.5,-70},{-89.5,-50}})));
      AixLib.Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1
        annotation (Placement(transformation(extent={{-109.5,50},{-89.5,70}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling[dis]
        annotation (Placement(transformation(extent={{80,60},{100,80}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ground[dis]
        annotation (Placement(transformation(extent={{-16,-104},{4,-84}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2b
        annotation (Placement(transformation(extent={{80,-20},{100,0}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1
        annotation (Placement(transformation(extent={{20,80},{40,100}})));

    equation
      connect(thermInsideWall3, thermInsideWall3)
        annotation (Line(points={{44,-94},{44,-94}}, color={191,0,0}));
      connect(inside_wall3.port_outside, thermInsideWall3) annotation (Line(points={{25,
              -64.25},{25,-77.375},{44,-77.375},{44,-94}},      color={191,0,0}));
      connect(inside_wall2b.port_outside, thermInsideWall2b) annotation (Line(
            points={{64.15,-17},{77.225,-17},{77.225,-10},{90,-10}}, color={191,0,0}));
      connect(inside_wall2a.port_outside, thermInsideWall2a) annotation (Line(
            points={{64.15,23},{78.225,23},{78.225,30},{90,30}}, color={191,0,0}));
      connect(inside_wall1.port_outside, thermInsideWall1) annotation (Line(points={{23,
              64.2502},{23,76.3751},{30,76.3751},{30,90}},      color={191,0,0}));
      connect(outside_wall1.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-60.25,
              34.5333},{-80,34.5333},{-80,-60},{-109.5,-60}},        color={0,0,127}));
      connect(SolarRadiationPort_OW1, outside_wall1.SolarRadiationPort) annotation (
         Line(points={{-99.5,60},{-80,60},{-80,39.6667},{-61.5,39.6667}}, color={
              255,128,0}));
      connect(thermCeiling, thermCeiling) annotation (Line(points={{90,70},{85,70},
              {85,70},{90,70}}, color={191,0,0}));
              for i in 1:dis loop
      connect(ground[i], floor[i].port_outside) annotation (Line(
          points={{-6,-94},{-6,-74},{-24,-74},{-24,-62.1},{-27,-62.1}},
          color={191,0,0},
          pattern=LinePattern.Dash));
      connect(floor[i].thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-27,-58},{-26,-58},{-26,-48},{-7,-48},{-7,-8}},              color={191,0,0}));
      connect(Ceiling[i].port_outside, thermCeiling[i])
        annotation (Line(points={{-31,62.1},{-31,70},{90,70}}, color={191,0,0}));
      connect(Ceiling[i].thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-31,58},{-30,58},{-30,44},{50,44},{50,-48},{-7,-48},{-7,-8}},              color={191,0,0}));
              end for;
      connect(inside_wall3.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{25,-54},{24,-54},{24,-48},{-7,-48},{-7,-8}},              color={191,0,0}));
      connect(inside_wall2b.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{58,-17},{56,-17},{56,-16},{50,-16},{50,-48},{-7,-48},{-7,-8}},              color={191,0,0}));
      connect(inside_wall2a.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{58,23},{56,23},{56,22},{50,22},{50,-48},{-7,-48},{-7,-8}},              color={191,0,0}));
      connect(inside_wall1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{23,54},
              {24,54},{24,44},{50,44},{50,-48},{-7,-48},{-7,-8}},                                                                                                                   color={191,0,0}));
      connect(outside_wall1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-50,14},{-44,14},{-44,44},{50,44},{50,-48},{-7,-48},{-7,-8}},              color={191,0,0}));
      connect(outside_wall1.port_outside, thermOutside) annotation (Line(points={{-60.25,14},{-78,14},{-78,100},{-100,100}}, color={191,0,0}));
      annotation (Icon(graphics={
            Rectangle(
              extent={{6,65},{-6,-65}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              origin={74,-3},
              rotation=180),
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
              extent={{-80,0},{-60,-50}},
              lineColor={0,0,0},
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid,
              visible=withWindow1),
            Rectangle(
              extent={{80,80},{-80,68}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{80,68},{68,26}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Line(points={{-46,68},{-46,38}}, color={255,255,255}),
            Line(points={{-60,54},{-30,54}}, color={255,255,255}),
            Text(
              extent={{-56,60},{62,48}},
              lineColor={255,255,255},
              fillColor={255,170,170},
              fillPattern=FillPattern.Solid,
              textString="width"),
            Line(points={{38,54},{68,54}}, color={255,255,255}),
            Text(
              extent={{-126,6},{0,-6}},
              lineColor={255,255,255},
              fillColor={255,170,170},
              fillPattern=FillPattern.Solid,
              origin={-46,64},
              rotation=90,
              textString="length"),
            Line(points={{-46,-38},{-46,-68}}, color={255,255,255}),
            Line(points={{68,26},{54,26}}, color={255,255,255}),
            Line(points={{58,-58},{58,-68}}, color={255,255,255}),
            Text(
              extent={{59,6},{-59,-6}},
              lineColor={255,255,255},
              fillColor={255,170,170},
              fillPattern=FillPattern.Solid,
              origin={58,-21},
              rotation=90,
              textString="length_b"),
            Rectangle(
              extent={{-80,40},{-60,20}},
              lineColor={0,0,0},
              fillColor={127,127,0},
              fillPattern=FillPattern.Solid,
              visible=withDoor1),
            Text(
              extent={{-10,4},{10,-4}},
              lineColor={255,255,255},
              fillColor={255,170,170},
              fillPattern=FillPattern.Solid,
              textString="D1",
              origin={-70,30},
              rotation=90,
              visible=withDoor1),
            Text(
              extent={{-25,6},{25,-6}},
              lineColor={255,255,255},
              fillColor={255,170,170},
              fillPattern=FillPattern.Solid,
              origin={-70,-25},
              rotation=90,
              textString="Win1",
              visible=withWindow1),
            Line(points={{58,26},{58,18}}, color={255,255,255})}), Documentation(
            revisions="<html><ul>
  <li>
    <i>April 23, 2020</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/752\">#752</a>:
    Propagate all parameters correctly. Extend from new partial room
    model. Delete TIR and TMC. Tidy up.
  </li>
  <li>
    <i>Mai 7, 2015</i> by Ana Constantin:<br/>
    Grount temperature depends on TRY
  </li>
  <li>
    <i>April 18, 2014</i> by Ana Constantin:<br/>
    Added documentation
  </li>
  <li>
    <i>July 7, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>",     info="<html>
<p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  Model for a room with
  1&#160;outer&#160;wall,&#160;2&#160;inner&#160;walls&#160;load,&#160;1&#160;inner&#160;wall&#160;simple,&#160;1&#160;floor&#160;towards&#160;ground,&#160;1&#160;ceiling&#160;towards&#160;upper&#160;floor.
</p>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
  The following figure presents the room's layout:
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/1OW_2IWl_2IWs_1Gr_Pa.png\"
  alt=\"Room layout\">
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
    end Ow1IwL2IwS1Gr1Uf1;

    model Ow1IwL2IwS1Lf1At1Ro1
      "1 outer wall, 2 inner walls load, 2 inner walls simple, 1 floor towards lower floor, 1 ceiling towards attic, 1 roof towards outside"

      extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoom(    redeclare
          AixLib.DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes,
        final room_V=room_length*room_width_long*
          room_height_long - room_length*(room_width_long - room_width_short)*(
          room_height_long - room_height_short)*0.5);
      parameter Integer dis = 1 "Discretisation layers for underfloor heating" annotation (Dialog(enable = use_UFH));

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

      parameter Real solar_absorptance_RO=0.25 "Solar absoptance roof "
        annotation (Dialog(group="Outer wall properties", descriptionLabel=true));

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

      AixLib.ThermalZones.HighOrder.Components.Walls.Wall outside_wall1(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.OW,
        wall_length=room_length,
        wall_height=room_height_short,
        withWindow=false,
        windowarea=0,
        withDoor=false,
        door_height=0,
        door_width=0,
        final use_condLayers=true)
                         annotation (Placement(transformation(extent={{-60,-12},{-50,46}})));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall inner_wall1(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW_vert_half_a,
        outside=false,
        wall_length=room_width_long,
        wall_height=0.5*(room_height_long + room_height_short + room_width_short/room_width_long*(room_height_long - room_height_short)),
        withWindow=false,
        withDoor=false,
        final use_condLayers=true)
                        annotation (Placement(transformation(
            origin={-14,58},
            extent={{-3.99997,-22},{3.99999,22}},
            rotation=270)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall2a(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW2_vert_half_a,
        outside=false,
        wall_length=room_length - room_lengthb,
        wall_height=room_height_long,
        withWindow=false,
        withDoor=false,
        final use_condLayers=true)
                        annotation (Placement(transformation(
            origin={61,19},
            extent={{-3,-15},{3,15}},
            rotation=180)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall3(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW_vert_half_a,
        outside=false,
        wall_length=room_width_long,
        wall_height=0.5*(room_height_long + room_height_short + room_width_short/room_width_long*(room_height_long - room_height_short)),
        withWindow=false,
        withDoor=false,
        final use_condLayers=true)
                        annotation (Placement(transformation(
            origin={20,-60},
            extent={{-4,-24},{4,24}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Ceiling(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW_hori_att_low_half,
        outside=false,
        wall_length=room_length,
        wall_height=room_width_short,
        withWindow=false,
        withDoor=false,
        ISOrientation=3,
        final use_condLayers=true)
                         annotation (Placement(transformation(
            origin={28,60},
            extent={{1.99999,-10},{-1.99998,10}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall floor[dis](
        each final energyDynamics=energyDynamicsWalls,
        each final calcMethodOut=calcMethodOut,
        each final hConOut_const=hConOut_const,
        each final surfaceType=surfaceType,
        each final calcMethodIn=calcMethodIn,
        each final hConIn_const=hConIn_const,
        each final WindowType=Type_Win,
        each final T0=TWalls_start,
        each final withSunblind=use_sunblind,
        each final Blinding=1 - ratioSunblind,
        each final LimitSolIrr=solIrrThreshold,
        each final TOutAirLimit=TOutAirLimit,
        each final solar_absorptance=solar_absorptance_OW,
        each final wallPar=wallTypes.IW_hori_upp_half,
        each outside=false,
        each wall_length=room_length/dis,
        each wall_height=room_width_long,
        each withWindow=false,
        each withDoor=false,
        each ISOrientation=2,
        each final use_condLayers=not use_UFH) annotation (Placement(transformation(
            origin={-24,-60},
            extent={{-1.99999,-10},{1.99999,10}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall2b(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW2_vert_half_a,
        outside=false,
        wall_length=room_lengthb,
        wall_height=room_height_long,
        withWindow=false,
        withDoor=false,
        final use_condLayers=true)
                        annotation (Placement(transformation(
            origin={61,-20},
            extent={{-2.99998,-16},{2.99998,16}},
            rotation=180)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall roof(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_RO,
        final wallPar=wallTypes.roofRoomUpFloor,
        wall_length=room_length,
        withDoor=false,
        door_height=0,
        door_width=0,
        wall_height=roof_width,
        withWindow=withWindow3,
        windowarea=windowarea_RO,
        ISOrientation=1,
        final use_condLayers=true)
                         annotation (Placement(transformation(
            origin={58,59},
            extent={{-2.99997,-16},{2.99999,16}},
            rotation=270)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall3
        annotation (Placement(transformation(extent={{20,-100},{40,-80}}),
            iconTransformation(extent={{20,-100},{40,-80}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2a
        annotation (Placement(transformation(extent={{80,0},{100,20}})));
      Modelica.Blocks.Interfaces.RealInput WindSpeedPort if (calcMethodOut == 1 or calcMethodOut == 2)
        annotation (Placement(transformation(extent={{-119.5,-70},{-99.5,-50}}), iconTransformation(extent={{-109.5,-60},{-89.5,-40}})));
      AixLib.Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1
        annotation (Placement(transformation(extent={{-109.5,20},{-89.5,40}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
        annotation (Placement(transformation(extent={{80,40},{100,60}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor[dis]
        annotation (Placement(transformation(extent={{-16,-104},{4,-84}}),
            iconTransformation(extent={{-16,-104},{4,-84}})));
      AixLib.Utilities.Interfaces.SolarRad_in SolarRadiationPort_Roof annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={74,100})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2b
        annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1
        annotation (Placement(transformation(extent={{-20,80},{0,100}}),
            iconTransformation(extent={{-20,80},{0,100}})));

    equation
      connect(outside_wall1.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-60.25,
              38.2667},{-80,38.2667},{-80,-60},{-109.5,-60}},        color={0,0,127}));
      connect(outside_wall1.SolarRadiationPort, SolarRadiationPort_OW1) annotation (
         Line(points={{-61.5,43.5833},{-80,43.5833},{-80,30},{-99.5,30}}, color={0,
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
      connect(roof.SolarRadiationPort, SolarRadiationPort_Roof) annotation (Line(
            points={{72.6667,62.9},{72.6667,72},{74,72},{74,100}}, color={255,128,0}));
      connect(roof.WindSpeedPort, WindSpeedPort) annotation (Line(points={{69.7333,
              62.15},{69.7333,72},{-80,72},{-80,-60},{-109.5,-60}},color={0,0,127}));
      connect(thermOutside, outside_wall1.port_outside) annotation (Line(points={{-100,100},{-78,100},{-78,17},{-60.25,17}}, color={191,0,0}));
      connect(roof.port_outside, thermOutside) annotation (Line(points={{58,
              62.15},{58,76},{-62,76},{-62,100},{-100,100}},                                                               color={191,0,0}));
              for i in 1:dis loop
      connect(thermFloor[i], floor[i].port_outside) annotation (Line(
          points={{-6,-94},{-8,-94},{-8,-66},{-22,-66},{-22,-62.1},{-24,-62.1}},
          color={191,0,0},
          pattern=LinePattern.Dash));
      connect(floor[i].thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-24,-58},
                {-24,-46},{-7,-46},{-7,-8}},                                                                                                            color={191,0,0}));
              end for;
      connect(inside_wall3.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{20,-56},{20,-46},{-7,-46},{-7,-8}},              color={191,0,0}));
      connect(inside_wall2b.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{58,-20},
              {48,-20},{48,-46},{-7,-46},{-7,-8}},                                                                                                                     color={191,0,0}));
      connect(inside_wall2a.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{58,19},{48,19},{48,-46},{-7,-46},{-7,-8}},              color={191,0,0}));
      connect(roof.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{58,56},
              {58,50},{48,50},{48,-46},{-7,-46},{-7,-8}},                                                                                                           color={191,0,0}));
      connect(Ceiling.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{28,58},
              {28,48},{48,48},{48,-46},{-7,-46},{-7,-8}},                                                                                                              color={191,0,0}));
      connect(inner_wall1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-14,54},{-14,48},{48,48},{48,-46},{-7,-46},{-7,-8}},              color={191,0,0}));
      connect(outside_wall1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-50,17},{-44,17},{-44,48},{48,48},{48,-46},{-7,-46},{-7,-8}},              color={191,0,0}));
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
            revisions="<html><ul>
  <li>
    <i>April 23, 2020</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/752\">#752</a>:
    Propagate all parameters correctly. Extend from new partial room
    model. Delete TIR and TMC. Tidy up.
  </li>
  <li>
    <i>April 18, 2014</i> by Ana Constantin:<br/>
    Added documentation
  </li>
  <li>
    <i>July 8, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>",     info="<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for a room with
  1&#160;outer&#160;wall,&#160;2&#160;inner&#160;walls&#160;load,&#160;2&#160;inner&#160;walls&#160;simple,&#160;1&#160;floor&#160;towards&#160;lower&#160;floor,&#160;1&#160;ceiling&#160;towards&#160;attic,&#160;1&#160;roof&#160;towards&#160;outside.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The following figure presents the room's layout:
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/OW1_2IWl_2IWs_1Pa_1At1Ro.png\"
  alt=\"Room layout\">
</p>
</html>"));
    end Ow1IwL2IwS1Lf1At1Ro1;

    model Ow2IwL1IwS1Gr1Uf1
      "2 outer walls, 1 inner wall load, 1 inner wall simple, 1 floor towards ground, 1 ceiling towards upper floor"

      extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoom(    redeclare
          AixLib.DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes,
                                                                              final room_V=room_length*room_width*room_height);
      parameter Integer dis = 1 "Discretisation layers for underfloor heating" annotation (Dialog(enable = use_UFH));

      //////////room geometry
      parameter Modelica.SIunits.Length room_length=2 "length "
        annotation (Dialog(group="Dimensions", descriptionLabel=true));
      parameter Modelica.SIunits.Length room_width=2 "width"
        annotation (Dialog(group="Dimensions", descriptionLabel=true));
      parameter Modelica.SIunits.Height room_height=2 "height"
        annotation (Dialog(group="Dimensions", descriptionLabel=true));

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
      parameter Real U_door_OD1=2.5 "U-value" annotation (
         Dialog(
          group="Windows and Doors",
          joinNext=true,
          descriptionLabel=true,
          enable=withDoor1));
      parameter Real eps_door_OD1=0.95 "eps" annotation (Dialog(
          group="Windows and Doors",
          descriptionLabel=true,
          enable=withDoor1));
      parameter Real U_door_OD2=2.5 "U-value" annotation (
         Dialog(
          group="Windows and Doors",
          joinNext=true,
          descriptionLabel=true,
          enable=withDoor2));
      parameter Real eps_door_OD2=0.95 "eps" annotation (Dialog(
          group="Windows and Doors",
          descriptionLabel=true,
          enable=withDoor2));

      AixLib.ThermalZones.HighOrder.Components.Walls.Wall outside_wall1(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.OW,
        windowarea=windowarea_OW1,
        door_height=door_height_OD1,
        door_width=door_width_OD1,
        wall_length=room_length,
        wall_height=room_height,
        withWindow=withWindow1,
        withDoor=withDoor1,
        eps_door=eps_door_OD1,
        use_condLayers=true)   annotation (Placement(transformation(extent={{-60,-22},{-50,42}})));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall outside_wall2(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.OW,
        windowarea=windowarea_OW2,
        door_height=door_height_OD2,
        door_width=door_width_OD2,
        wall_length=room_width,
        wall_height=room_height,
        withWindow=withWindow2,
        withDoor=withDoor2,
        U_door=U_door_OD2,
        eps_door=eps_door_OD2,
        use_condLayers=true)   annotation (Placement(transformation(
            origin={19,57},
            extent={{-5.00018,-29},{5.00003,29}},
            rotation=270)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall1(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW2_vert_half_a,
        outside=false,
        wall_length=room_length,
        wall_height=room_height,
        withWindow=false,
        withDoor=false,
        use_condLayers=true) annotation (Placement(transformation(
            origin={58,5},
            extent={{-6,-35},{6,35}},
            rotation=180)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall2(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW_vert_half_a,
        outside=false,
        wall_length=room_width,
        wall_height=room_height,
        withWindow=false,
        withDoor=false,
        use_condLayers=true)
                        annotation (Placement(transformation(
            origin={16,-60},
            extent={{-4,-24},{4,24}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Ceiling[dis](
        each final energyDynamics=energyDynamicsWalls,
        each final calcMethodOut=calcMethodOut,
        each final hConOut_const=hConOut_const,
        each final surfaceType=surfaceType,
        each final calcMethodIn=calcMethodIn,
        each final hConIn_const=hConIn_const,
        each final WindowType=Type_Win,
        each final T0=TWalls_start,
        each final withSunblind=use_sunblind,
        each final Blinding=1 - ratioSunblind,
        each final LimitSolIrr=solIrrThreshold,
        each final TOutAirLimit=TOutAirLimit,
        each final solar_absorptance=solar_absorptance_OW,
        each final wallPar=wallTypes.IW_hori_low_half,
        each outside=false,
        each wall_length=room_length/dis,
        each wall_height=room_width,
        each withWindow=false,
        each withDoor=false,
        each ISOrientation=3,
        each final use_condLayers=not use_UFH)
                         annotation (Placement(transformation(
            origin={-30,59},
            extent={{2.99997,-16},{-3.00002,16}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall floor[dis](
        each final energyDynamics=energyDynamicsWalls,
        each final calcMethodOut=calcMethodOut,
        each final hConOut_const=hConOut_const,
        each final surfaceType=surfaceType,
        each final calcMethodIn=calcMethodIn,
        each final hConIn_const=hConIn_const,
        each final WindowType=Type_Win,
        each final T0=TWalls_start,
        each final withSunblind=use_sunblind,
        each final Blinding=1 - ratioSunblind,
        each final LimitSolIrr=solIrrThreshold,
        each final TOutAirLimit=TOutAirLimit,
        each final solar_absorptance=solar_absorptance_OW,
        each final wallPar=wallTypes.groundPlate_upp_half,
        each wall_length=room_length/dis,
        each wall_height=room_width,
        each withWindow=false,
        each outside=false,
        each withDoor=false,
        each ISOrientation=2,
        each final use_condLayers=not use_UFH) annotation (Placement(transformation(
            origin={-29,-65},
            extent={{-3.00001,-15},{2.99998,15}},
            rotation=90)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2
        annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1
        annotation (Placement(transformation(extent={{80,0},{100,20}})));
      Modelica.Blocks.Interfaces.RealInput WindSpeedPort if (calcMethodOut == 1 or calcMethodOut == 2)
        annotation (Placement(transformation(extent={{-119.5,-70},{-99.5,-50}}), iconTransformation(extent={{-109.5,-50},{-89.5,-30}})));
      AixLib.Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1
        annotation (Placement(transformation(extent={{-109.5,20},{-89.5,40}})));
      AixLib.Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW2 annotation (
          Placement(transformation(
            origin={50.5,99},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling[dis]
        annotation (Placement(transformation(extent={{80,60},{100,80}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ground[dis]
        annotation (Placement(transformation(extent={{-16,-104},{4,-84}})));

    equation
      connect(outside_wall1.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-60.25,
              33.4667},{-80,33.4667},{-80,-60},{-109.5,-60}},       color={0,0,127}));
      connect(thermInsideWall2, thermInsideWall2)
        annotation (Line(points={{30,-90},{30,-90}}, color={191,0,0}));
      connect(inside_wall1.port_outside, thermInsideWall1)
        annotation (Line(points={{64.3,5},{90,5},{90,10}}, color={191,0,0}));
      connect(outside_wall2.WindSpeedPort, WindSpeedPort) annotation (Line(points={{40.2667,
              62.2502},{40.2667,70},{-80,70},{-80,-60},{-109.5,-60}},
            color={0,0,127}));
      connect(outside_wall2.SolarRadiationPort, SolarRadiationPort_OW2) annotation (
         Line(points={{45.5833,63.5002},{45.5833,80.7501},{50.5,80.7501},{
              50.5,99}},
            color={255,128,0}));
      connect(SolarRadiationPort_OW1, outside_wall1.SolarRadiationPort) annotation (
         Line(points={{-99.5,30},{-80,30},{-80,39.3333},{-61.5,39.3333}}, color={255,
              128,0}));
      connect(inside_wall2.port_outside, thermInsideWall2) annotation (Line(points={
              {16,-64.2},{16,-75.45},{30,-75.45},{30,-90}}, color={191,0,0}));
      for i in 1:dis loop
      connect(ground[i], floor[i].port_outside) annotation (Line(
          points={{-6,-94},{-6,-74},{-24,-74},{-24,-68.15},{-29,-68.15}},
          color={191,0,0},
          pattern=LinePattern.Dash));
      connect(floor[i].thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-29,-62},
                {-30,-62},{-30,-44},{-7,-44},{-7,-8}},                                                                                                            color={191,0,0}));
      connect(Ceiling[i].port_outside, thermCeiling[i])
        annotation (Line(points={{-30,62.15},{-30,70},{90,70}}, color={191,0,0}));
      connect(Ceiling[i].thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-30,56},
                {-30,38},{42,38},{42,-44},{-7,-44},{-7,-8}},                                                                                                             color={191,0,0}));
      end for;
      connect(outside_wall2.port_outside, thermOutside) annotation (Line(points={{19,
              62.2502},{19,76},{-56,76},{-56,100},{-100,100}},                                                                        color={191,0,0}));

      connect(thermOutside, outside_wall1.port_outside) annotation (Line(points={{-100,100},{-78,100},{-78,10},{-60.25,10}}, color={191,0,0}));
      connect(inside_wall2.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{16,-56},{16,-44},{-7,-44},{-7,-8}},              color={191,0,0}));
      connect(inside_wall1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{52,5},{42,5},{42,-44},{-7,-44},{-7,-8}},              color={191,0,0}));
      connect(outside_wall2.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{19,52},
              {18,52},{18,38},{42,38},{42,-44},{-7,-44},{-7,-8}},                                                                                                                    color={191,0,0}));
      connect(outside_wall1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-50,10},{-40,10},{-40,38},{42,38},{42,-44},{-7,-44},{-7,-8}},              color={191,0,0}));
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
            revisions="<html><ul>
  <li>
    <i>April 23, 2020</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/752\">#752</a>:
    Propagate all parameters correctly. Extend from new partial room
    model. Delete TIR and TMC. Tidy up.
  </li>
  <li>
    <i>Mai 7, 2015</i> by Ana Constantin:<br/>
    Grount temperature depends on TRY
  </li>
  <li>
    <i>April 18, 2014</i> by Ana Constantin:<br/>
    Added documentation
  </li>
  <li>
    <i>July 7, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>",     info="<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for a room with
  2&#160;outer&#160;walls,&#160;1&#160;inner&#160;wall&#160;load,&#160;1&#160;inner&#160;wall&#160;simple,&#160;1&#160;floor&#160;towards&#160;ground,&#160;1&#160;ceiling&#160;towards&#160;upper&#160;floor.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The following figure presents the room's layout:
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/2OW_1IWl_1IWs_1Gr_Pa.png\"
  alt=\"Room layout\">
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
    end Ow2IwL1IwS1Gr1Uf1;

    model Ow2IwL1IwS1Lf1At1Ro1
      "2 outer walls, 1 inner wall load, 1 inner wall simple, 1 floor towards lower floor, 1 ceiling towards attic, 1 roof towards outside"

      extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoom(    redeclare
          AixLib.DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes,
        final room_V=room_length*room_width_long*
          room_height_long - room_length*(room_width_long - room_width_short)*(
          room_height_long - room_height_short)*0.5);
      parameter Integer dis = 1 "Discretisation layers for underfloor heating" annotation (Dialog(enable = use_UFH));

      //////////room geometry
      parameter Modelica.SIunits.Length room_length=2 "length "
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
      parameter Real U_door_OD2=2.5 "U-value" annotation (
         Dialog(
          group="Windows and Doors",
          joinNext=true,
          descriptionLabel=true,
          enable=withDoor2));
      parameter Real eps_door_OD2=0.95 "eps" annotation (Dialog(
          group="Windows and Doors",
          descriptionLabel=true,
          enable=withDoor2));

      parameter Real solar_absorptance_RO=0.25 "Solar absoptance roof "
        annotation (Dialog(group="Outer wall properties", descriptionLabel=true));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall outside_wall1(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.OW,
        wall_length=room_length,
        wall_height=room_height_short,
        withWindow=false,
        windowarea=0,
        withDoor=false,
        door_height=0,
        door_width=0,
        final use_condLayers=true)
                         annotation (Placement(transformation(extent={{-62,-20},{-52,38}})));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall outside_wall2(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.OW,
        windowarea=windowarea_OW2,
        door_height=door_height_OD2,
        door_width=door_width_OD2,
        withWindow=withWindow2,
        withDoor=withDoor2,
        wall_length=room_width_long,
        wall_height=0.5*(room_height_long + room_height_short + room_width_short/room_width_long*(room_height_long - room_height_short)),
        ISOrientation=1,
        U_door=U_door_OD2,
        eps_door=eps_door_OD2,
        final use_condLayers=true)
                               annotation (Placement(transformation(
            origin={-29,59},
            extent={{-5.00001,-29},{5.00001,29}},
            rotation=270)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall1(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW2_vert_half_a,
        outside=false,
        wall_length=room_length,
        wall_height=room_height_long,
        withWindow=false,
        withDoor=false,
        final use_condLayers=true)
                        annotation (Placement(transformation(
            origin={61,4.00001},
            extent={{-4.99999,-30},{5,30}},
            rotation=180)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall2(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW_vert_half_a,
        outside=false,
        wall_length=room_width_long,
        wall_height=0.5*(room_height_long + room_height_short + room_width_short/room_width_long*(room_height_long - room_height_short)),
        withWindow=false,
        withDoor=false,
        final use_condLayers=true)
                        annotation (Placement(transformation(
            origin={32,-59},
            extent={{-4.99998,-28},{4.99998,28}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Ceiling(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW_hori_att_low_half,
        outside=false,
        wall_length=room_length,
        wall_height=room_width_short,
        withWindow=false,
        withDoor=false,
        ISOrientation=3,
        final use_condLayers=true)
                         annotation (Placement(transformation(
            origin={22,60},
            extent={{1.99999,-10},{-1.99998,10}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall floor[dis](
        each final energyDynamics=energyDynamicsWalls,
        each final calcMethodOut=calcMethodOut,
        each final hConOut_const=hConOut_const,
        each final surfaceType=surfaceType,
        each final calcMethodIn=calcMethodIn,
        each final hConIn_const=hConIn_const,
        each final WindowType=Type_Win,
        each final T0=TWalls_start,
        each final withSunblind=use_sunblind,
        each final Blinding=1 - ratioSunblind,
        each final LimitSolIrr=solIrrThreshold,
        each final TOutAirLimit=TOutAirLimit,
        each final solar_absorptance=solar_absorptance_OW,
        each final wallPar=wallTypes.IW_hori_upp_half,
        each outside=false,
        each wall_length=room_length/dis,
        each wall_height=room_width_long,
        each withWindow=false,
        each withDoor=false,
        each ISOrientation=2,
        each final use_condLayers=not use_UFH)             annotation (Placement(transformation(
            origin={-27,-60},
            extent={{-2.00002,-11},{2.00001,11}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall roof(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_RO,
        final wallPar=wallTypes.roofRoomUpFloor,
        wall_length=room_length,
        withDoor=false,
        door_height=0,
        door_width=0,
        wall_height=roof_width,
        withWindow=withWindow3,
        windowarea=windowarea_RO,
        final use_condLayers=true)
                             annotation (Placement(transformation(
            origin={55,59},
            extent={{-2.99995,-17},{2.99997,17}},
            rotation=270)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2
        annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1
        annotation (Placement(transformation(extent={{80,0},{100,20}})));
      Modelica.Blocks.Interfaces.RealInput WindSpeedPort if (calcMethodOut == 1 or calcMethodOut == 2)
        annotation (Placement(transformation(extent={{-119.5,-70},{-99.5,-50}}), iconTransformation(extent={{-109.5,-50},{-89.5,-30}})));
      AixLib.Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1
        annotation (Placement(transformation(extent={{-109.5,20},{-89.5,40}})));
      AixLib.Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW2 annotation (
          Placement(transformation(
            origin={44.5,101},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
        annotation (Placement(transformation(extent={{80,60},{100,80}})));
      AixLib.Utilities.Interfaces.SolarRad_in SolarRadiationPort_Roof annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={74,100})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor[dis] annotation (
          Placement(transformation(extent={{-16,-104},{4,-84}}), iconTransformation(
              extent={{-16,-104},{4,-84}})));

    equation
      connect(outside_wall1.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-62.25,
              30.2667},{-80,30.2667},{-80,-60},{-109.5,-60}},       color={0,0,127}));
      connect(inside_wall2.port_outside, thermInsideWall2) annotation (Line(points={{32,
              -64.25},{32,-72},{30,-72},{30,-90}},     color={191,0,0}));
      connect(thermInsideWall2, thermInsideWall2)
        annotation (Line(points={{30,-90},{30,-90}}, color={191,0,0}));
      connect(inside_wall1.port_outside, thermInsideWall1) annotation (Line(points={{66.25,
              4.00001},{90,4.00001},{90,10}},        color={191,0,0}));
      connect(Ceiling.port_outside, thermCeiling)
        annotation (Line(points={{22,62.1},{22,70},{90,70}}, color={191,0,0}));
      connect(outside_wall2.WindSpeedPort, WindSpeedPort) annotation (Line(points={{
              -7.73333,64.25},{-7.73333,70},{-80,70},{-80,-60},{-109.5,-60}},
                     color={0,0,127}));
      connect(SolarRadiationPort_OW1, outside_wall1.SolarRadiationPort) annotation (
         Line(points={{-99.5,30},{-63.5,30},{-63.5,35.5833}}, color={255,128,0}));
      connect(outside_wall2.SolarRadiationPort, SolarRadiationPort_OW2) annotation (
         Line(points={{-2.41667,65.5},{-2.41667,70},{44.5,70},{44.5,92},{44.5,
              101}},
            color={255,128,0}));
      connect(roof.SolarRadiationPort, SolarRadiationPort_Roof) annotation (Line(
            points={{70.5833,62.8999},{70.5833,70},{74,70},{74,100}}, color={255,128,
              0}));
      connect(roof.WindSpeedPort, WindSpeedPort) annotation (Line(points={{67.4667,
              62.1499},{67.4667,70},{-80,70},{-80,-60},{-109.5,-60}},
                                                            color={0,0,127}));
      connect(outside_wall2.port_outside, thermOutside) annotation (Line(points={{-29,
              64.25},{-29,100},{-100,100}},                                                                         color={191,0,0}));
      connect(roof.port_outside, thermOutside) annotation (Line(points={{55,
              62.1499},{55,72},{-29,72},{-29,100},{-100,100}},                                                               color={191,0,0}));
      connect(outside_wall1.port_outside, thermOutside) annotation (Line(points={{-62.25,9},{-76,9},{-76,100},{-100,100}}, color={191,0,0}));
      for i in 1:dis loop
      connect(thermFloor[i], floor[i].port_outside) annotation (Line(
          points={{-6,-94},{-8,-94},{-8,-66},{-22,-66},{-22,-62.1},{-27,-62.1}},
          color={191,0,0},
          pattern=LinePattern.Dash));
      connect(floor[i].thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-27,-58},{-28,-58},{-28,-48},{-7,-48},{-7,-8}},              color={191,0,0}));
      end for;
      connect(inside_wall2.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{32,-54},
              {32,-48},{-6,-48},{-6,-28},{-7,-28},{-7,-8}},                                                                                                                    color={191,0,0}));
      connect(inside_wall1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{56,4.00001},{54,4.00001},{54,4},{44,4},{44,-48},{-6,-48},{-6,-28},{-7,-28},{-7,-8}},              color={191,0,0}));
      connect(roof.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{55,56},
              {54,56},{54,50},{44,50},{44,-48},{-6,-48},{-6,-28},{-7,-28},{-7,
              -8}},                                                                                                                                                                           color={191,0,0}));
      connect(Ceiling.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{22,58},
              {22,50},{44,50},{44,-48},{-6,-48},{-6,-28},{-7,-28},{-7,-8}},                                                                                                              color={191,0,0}));
      connect(outside_wall2.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-29,54},
              {-30,54},{-30,50},{44,50},{44,-48},{-6,-48},{-6,-28},{-7,-28},{
              -7,-8}},                                                                                                                                                                                    color={191,0,0}));
      connect(outside_wall1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-52,9},{-40,9},{-40,50},{44,50},{44,-48},{-6,-48},{-6,-28},{-7,-28},{-7,-8}},              color={191,0,0}));
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
              extent={{6,64},{-6,-64}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              origin={74,-4}),
            Rectangle(
              extent={{-60,60},{68,-68}},
              lineColor={0,0,0},
              fillColor={47,102,173},
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
              extent={{20,80},{40,60}},
              lineColor={0,0,0},
              fillColor={127,127,0},
              fillPattern=FillPattern.Solid,
              visible=withDoor2),
            Text(
              extent={{20,74},{40,66}},
              lineColor={255,255,255},
              fillColor={255,170,170},
              fillPattern=FillPattern.Solid,
              textString="D2",
              visible=withDoor2),
            Text(
              extent={{-50,76},{0,64}},
              lineColor={255,255,255},
              fillColor={255,170,170},
              fillPattern=FillPattern.Solid,
              textString="Win2",
              visible=withWindow2),
            Text(
              extent={{-56,52},{64,40}},
              lineColor={255,255,255},
              fillColor={255,170,170},
              fillPattern=FillPattern.Solid,
              textString="width"),
            Line(points={{38,46},{68,46}}, color={255,255,255}),
            Line(points={{-60,46},{-30,46}}, color={255,255,255}),
            Text(
              extent={{-120,6},{0,-6}},
              lineColor={255,255,255},
              fillColor={255,170,170},
              fillPattern=FillPattern.Solid,
              origin={-46,56},
              rotation=90,
              textString="length"),
            Line(points={{-46,60},{-46,30}}, color={255,255,255}),
            Line(points={{-46,-42},{-46,-68}}, color={255,255,255}),
            Rectangle(
              extent={{-80,30},{-60,-20}},
              lineColor={0,0,0},
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid,
              visible=withWindow3),
            Text(
              extent={{-25,6},{25,-6}},
              lineColor={255,255,255},
              fillColor={255,170,170},
              fillPattern=FillPattern.Solid,
              textString="Win3",
              origin={-70,5},
              rotation=90,
              visible=withWindow3)}), Documentation(revisions="<html><ul>
  <li>
    <i>April 23, 2020</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/752\">#752</a>:
    Propagate all parameters correctly. Extend from new partial room
    model. Delete TIR and TMC. Tidy up.
  </li>
  <li>
    <i>April 18, 2014</i> by Ana Constantin:<br/>
    Added documentation
  </li>
  <li>
    <i>July 8, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>",     info="<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for a room with
  2&#160;outer&#160;walls,&#160;1&#160;inner&#160;wall&#160;load,&#160;1&#160;inner&#160;wall&#160;simple,&#160;1&#160;floor&#160;towards&#160;lower&#160;floor,&#160;1&#160;ceiling&#160;towards&#160;attic,&#160;1&#160;roof&#160;towards&#160;outside.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The following figure presents the room's layout:
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/OW2_1IWl_1IWs_1Pa_1At1Ro.png\"
  alt=\"Room layout\">
</p>
</html>"));
    end Ow2IwL1IwS1Lf1At1Ro1;

    model Ow2IwL2IwS1Gr1Uf1
      "2 outer walls, 2 inner walls load, 1 inner wall simple, 1 floor towards ground, 1 ceiling towards upper floor"

      extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoom(    redeclare
          AixLib.DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes,
                                                                              final room_V=room_length*room_width*room_height);

      parameter Integer dis = 1 "Discretisation layers for underfloor heating" annotation (Dialog(enable = use_UFH));

      //////////room geometry
      parameter Modelica.SIunits.Length room_length=2 "length "
        annotation (Dialog(group="Dimensions", descriptionLabel=true));
      parameter Modelica.SIunits.Length room_lengthb=1 "length_b "
        annotation (Dialog(group="Dimensions", descriptionLabel=true));
      parameter Modelica.SIunits.Length room_width=2 "width "
        annotation (Dialog(group="Dimensions", descriptionLabel=true));
      parameter Modelica.SIunits.Height room_height=2 "height"
        annotation (Dialog(group="Dimensions", descriptionLabel=true));

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
      parameter Real U_door_OD1=2.5 "U-value" annotation (
         Dialog(
          group="Windows and Doors",
          joinNext=true,
          descriptionLabel=true,
          enable=withDoor1));
      parameter Real eps_door_OD1=0.95 "eps" annotation (Dialog(
          group="Windows and Doors",
          descriptionLabel=true,
          enable=withDoor1));
      parameter Real U_door_OD2=2.5 "U-value" annotation (
         Dialog(
          group="Windows and Doors",
          joinNext=true,
          descriptionLabel=true,
          enable=withDoor2));
      parameter Real eps_door_OD2=0.95 "eps" annotation (Dialog(
          group="Windows and Doors",
          descriptionLabel=true,
          enable=withDoor2));

      AixLib.ThermalZones.HighOrder.Components.Walls.Wall outside_wall1(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.OW,
        windowarea=windowarea_OW1,
        door_height=door_height_OD1,
        door_width=door_width_OD1,
        wall_length=room_length,
        wall_height=room_height,
        withWindow=withWindow1,
        withDoor=withDoor1,
        U_door=U_door_OD1,
        eps_door=eps_door_OD1,
        final use_condLayers=true)
                               annotation (Placement(transformation(extent={{-58,-14},{-48,44}})));

      AixLib.ThermalZones.HighOrder.Components.Walls.Wall outside_wall2(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.OW,
        windowarea=windowarea_OW2,
        door_height=door_height_OD2,
        door_width=door_width_OD2,
        wall_length=room_width,
        wall_height=room_height,
        withWindow=withWindow2,
        withDoor=withDoor2,
        U_door=U_door_OD2,
        eps_door=eps_door_OD2,
        final use_condLayers=true)
                               annotation (Placement(transformation(
            origin={23,59},
            extent={{-4.99998,-27},{5.00001,27}},
            rotation=270)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall1a(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW2_vert_half_a,
        outside=false,
        wall_length=room_length - room_lengthb,
        wall_height=room_height,
        withWindow=false,
        withDoor=false,
        final use_condLayers=true)
                        annotation (Placement(transformation(
            origin={61,24},
            extent={{-2.99999,-16},{2.99999,16}},
            rotation=180)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall2(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW_vert_half_a,
        outside=false,
        wall_length=room_width,
        wall_height=room_height,
        withWindow=false,
        withDoor=false,
        final use_condLayers=true)
                        annotation (Placement(transformation(
            origin={22,-60},
            extent={{-4.00002,-26},{4.00001,26}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Ceiling[dis](
        each final energyDynamics=energyDynamicsWalls,
        each final calcMethodOut=calcMethodOut,
        each final hConOut_const=hConOut_const,
        each final surfaceType=surfaceType,
        each final calcMethodIn=calcMethodIn,
        each final hConIn_const=hConIn_const,
        each final WindowType=Type_Win,
        each final T0=TWalls_start,
        each final withSunblind=use_sunblind,
        each final Blinding=1 - ratioSunblind,
        each final LimitSolIrr=solIrrThreshold,
        each final TOutAirLimit=TOutAirLimit,
        each final solar_absorptance=solar_absorptance_OW,
        each final wallPar=wallTypes.IW_hori_low_half,
        each outside=false,
        each wall_length=room_length/dis,
        each wall_height=room_width,
        each withWindow=false,
        each withDoor=false,
        each ISOrientation=3,
        each final use_condLayers=not use_UFH)
                         annotation (Placement(transformation(
            origin={-30,61},
            extent={{2.99997,-16},{-3.00002,16}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall floor[dis](
        each final energyDynamics=energyDynamicsWalls,
        each final calcMethodOut=calcMethodOut,
        each final hConOut_const=hConOut_const,
        each final surfaceType=surfaceType,
        each final calcMethodIn=calcMethodIn,
        each final hConIn_const=hConIn_const,
        each final WindowType=Type_Win,
        each final T0=TWalls_start,
        each final withSunblind=use_sunblind,
        each final Blinding=1 - ratioSunblind,
        each final LimitSolIrr=solIrrThreshold,
        each final TOutAirLimit=TOutAirLimit,
        each final solar_absorptance=solar_absorptance_OW,
        each final wallPar=wallTypes.groundPlate_upp_half,
        each outside=false,
        each wall_length=room_length/dis,
        each wall_height=room_width,
        each withWindow=false,
        each withDoor=false,
        each ISOrientation=2,
        each final use_condLayers=not use_UFH)
                         annotation (Placement(transformation(
            origin={-27,-60},
            extent={{-2.00002,-11},{2.00001,11}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall1b(
        final energyDynamics=energyDynamicsWalls,
        final calcMethodOut=calcMethodOut,
        final hConOut_const=hConOut_const,
        final surfaceType=surfaceType,
        final calcMethodIn=calcMethodIn,
        final hConIn_const=hConIn_const,
        final WindowType=Type_Win,
        final T0=TWalls_start,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        final solar_absorptance=solar_absorptance_OW,
        final wallPar=wallTypes.IW2_vert_half_a,
        outside=false,
        wall_length=room_lengthb,
        wall_height=room_height,
        withWindow=false,
        withDoor=false,
        final use_condLayers=true)
                        annotation (Placement(transformation(
            origin={61,-15},
            extent={{-3,-15},{3,15}},
            rotation=180)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2
        annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1a
        annotation (Placement(transformation(extent={{80,20},{100,40}})));
      Modelica.Blocks.Interfaces.RealInput WindSpeedPort if (calcMethodOut == 1 or calcMethodOut == 2)
        annotation (Placement(transformation(extent={{-119.5,-70},{-99.5,-50}}), iconTransformation(extent={{-109.5,-50},{-89.5,-30}})));
      AixLib.Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1
        annotation (Placement(transformation(extent={{-109.5,20},{-89.5,40}})));
      AixLib.Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW2 annotation (
          Placement(transformation(
            origin={50.5,101},
            extent={{-10,-10},{10,10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={50.5,99})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling[dis]
        annotation (Placement(transformation(extent={{80,60},{100,80}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1b
        annotation (Placement(transformation(extent={{80,-20},{100,0}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ground[dis]
        annotation (Placement(transformation(extent={{-16,-104},{4,-84}})));

    equation
      connect(thermInsideWall2, thermInsideWall2)
        annotation (Line(points={{30,-90},{30,-90}}, color={191,0,0}));
      connect(WindSpeedPort, outside_wall2.WindSpeedPort) annotation (Line(points={{-109.5,
              -60},{-80,-60},{-80,74},{42.8,74},{42.8,64.25}},       color={0,0,127}));
      connect(outside_wall1.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-58.25,
              36.2667},{-80,36.2667},{-80,-60},{-109.5,-60}},       color={0,0,127}));
      connect(outside_wall2.SolarRadiationPort, SolarRadiationPort_OW2) annotation (
         Line(points={{47.75,65.5},{47.75,74},{50.5,74},{50.5,88},{50.5,101}},
            color={255,128,0}));
      connect(inside_wall2.port_outside, thermInsideWall2) annotation (Line(points={{22,
              -64.2},{22,-77.3},{30,-77.3},{30,-90}},     color={191,0,0}));
      connect(inside_wall1a.port_outside, thermInsideWall1a) annotation (Line(
            points={{64.15,24},{77.225,24},{77.225,30},{90,30}}, color={191,0,0}));
      connect(inside_wall1b.port_outside, thermInsideWall1b) annotation (Line(
            points={{64.15,-15},{79.225,-15},{79.225,-10},{90,-10}}, color={191,0,0}));
      connect(SolarRadiationPort_OW1, outside_wall1.SolarRadiationPort) annotation (
         Line(points={{-99.5,30},{-80,30},{-80,41.5833},{-59.5,41.5833}}, color={255,
              128,0}));
      connect(thermInsideWall1b, thermInsideWall1b) annotation (Line(points={{90,-10},
              {85,-10},{85,-10},{90,-10}}, color={191,0,0}));
              for i in 1:dis loop
      connect(ground[i], floor[i].port_outside) annotation (Line(
          points={{-6,-94},{-6,-74},{-24,-74},{-24,-62.1},{-27,-62.1}},
          color={191,0,0},
          pattern=LinePattern.Dash));
      connect(floor[i].thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-27,-58},{-26,-58},{-26,-48},{-7,-48},{-7,-8}},              color={191,0,0}));
      connect(Ceiling[i].port_outside, thermCeiling[i]) annotation (Line(points={{-30,
                64.15},{-30,64.15},{-30,74},{84,74},{84,70},{90,70}},
                                                             color={191,0,0}));
      connect(Ceiling[i].thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-30,58},
                {-30,46},{54,46},{54,-46},{-6,-46},{-6,-42},{-7,-42},{-7,-8}},                                                                                                             color={191,0,0}));
              end for;
      connect(outside_wall1.port_outside, thermOutside) annotation (Line(points={{-58.25,15},{-76,15},{-76,100},{-100,100}}, color={191,0,0}));
      connect(outside_wall2.port_outside, thermOutside) annotation (Line(points={{23,
              64.25},{23,76},{-52,76},{-52,100},{-100,100}},                                                                        color={191,0,0}));
      connect(inside_wall2.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{22,-56},{22,-46},{-6,-46},{-6,-42},{-7,-42},{-7,-8}},              color={191,0,0}));
      connect(inside_wall1b.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{58,-15},{54,-15},{54,-46},{-6,-46},{-6,-42},{-7,-42},{-7,-8}},              color={191,0,0}));
      connect(inside_wall1a.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{58,24},
              {54,24},{54,-46},{-6,-46},{-6,-42},{-7,-42},{-7,-8}},                                                                                                                    color={191,0,0}));
      connect(outside_wall2.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{23,54},{24,54},{24,46},{54,46},{54,-46},{-6,-46},{-6,-42},{-7,-42},{-7,-8}},              color={191,0,0}));
      connect(outside_wall1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-48,15},{-42,15},{-42,46},{54,46},{54,-46},{-6,-46},{-6,-42},{-7,-42},{-7,-8}},              color={191,0,0}));
      annotation (Icon(graphics={
            Rectangle(
              extent={{-6,-46},{6,46}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              origin={74,-22},
              radius=0),
            Rectangle(
              extent={{-80,80},{80,60}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{25,10},{-25,-10}},
              lineColor={0,0,0},
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid,
              origin={-25,70},
              rotation=180,
              visible=withWindow2),
            Rectangle(
              extent={{6,18},{-6,-18}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid,
              origin={74,42}),
            Rectangle(
              extent={{-80,60},{-60,-80}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-60,60},{68,-68}},
              lineColor={0,0,0},
              fillColor={47,102,173},
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
              visible=withWindow1),
            Rectangle(
              extent={{20,80},{40,60}},
              lineColor={0,0,0},
              fillColor={127,127,0},
              fillPattern=FillPattern.Solid,
              visible=withDoor2),
            Rectangle(
              extent={{-80,-20},{-60,-40}},
              lineColor={0,0,0},
              fillColor={127,127,0},
              fillPattern=FillPattern.Solid,
              visible=withDoor1),
            Line(points={{-46,-38},{-46,-68}}, color={255,255,255}),
            Line(points={{68,24},{56,24}}, color={255,255,255}),
            Text(
              extent={{-56,52},{64,40}},
              lineColor={255,255,255},
              fillColor={255,170,170},
              fillPattern=FillPattern.Solid,
              textString="width"),
            Text(
              extent={{-120,6},{0,-6}},
              lineColor={255,255,255},
              fillColor={255,170,170},
              fillPattern=FillPattern.Solid,
              origin={-46,56},
              rotation=90,
              textString="length"),
            Text(
              extent={{57,6},{-57,-6}},
              lineColor={255,255,255},
              fillColor={255,170,170},
              fillPattern=FillPattern.Solid,
              origin={58,-23},
              rotation=90,
              textString="length_b"),
            Text(
              extent={{20,74},{40,66}},
              lineColor={255,255,255},
              fillColor={255,170,170},
              fillPattern=FillPattern.Solid,
              textString="D2",
              visible=withDoor2),
            Text(
              extent={{-50,76},{0,64}},
              lineColor={255,255,255},
              fillColor={255,170,170},
              fillPattern=FillPattern.Solid,
              textString="Win2",
              visible=withWindow2),
            Text(
              extent={{50,-6},{0,6}},
              lineColor={255,255,255},
              fillColor={255,170,170},
              fillPattern=FillPattern.Solid,
              textString="Win1",
              origin={-70,0},
              rotation=90,
              visible=withWindow1),
            Text(
              extent={{2.85713,-4},{-17.1429,4}},
              lineColor={255,255,255},
              fillColor={255,170,170},
              fillPattern=FillPattern.Solid,
              textString="D1",
              origin={-70,-22.8571},
              rotation=90,
              visible=withDoor1),
            Line(points={{-46,60},{-46,30}}, color={255,255,255}),
            Line(points={{-60,46},{-30,46}}, color={255,255,255}),
            Line(points={{38,46},{68,46}}, color={255,255,255}),
            Line(points={{60,24},{60,16}}, color={255,255,255}),
            Line(points={{60,-64},{60,-68}}, color={255,255,255})}), Documentation(
            revisions="<html><ul>
  <li>
    <i>April 23, 2020</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/752\">#752</a>:
    Propagate all parameters correctly. Extend from new partial room
    model. Delete TIR and TMC. Tidy up.
  </li>
  <li>
    <i>Mai 7, 2015</i> by Ana Constantin:<br/>
    Grount temperature depends on TRY
  </li>
  <li>
    <i>April 18, 2014</i> by Ana Constantin:<br/>
    Added documentation
  </li>
  <li>
    <i>July 7, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>",     info="<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for a room with
  2&#160;outer&#160;walls,&#160;2&#160;inner&#160;walls&#160;load
  towards two different rooms but with the same
  orientation,&#160;1&#160;inner&#160;wall&#160;simple,&#160;1&#160;floor&#160;towards&#160;ground,&#160;1&#160;ceiling&#160;towards&#160;upper&#160;floor.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The following figure presents the room's layout:
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/2OW_2IWl_1IWs_1Gr_Pa.png\"
  alt=\"Room layout\">
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
    end Ow2IwL2IwS1Gr1Uf1;
  end Rooms;
  annotation(Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Package with models for the whole building envelope.
</p>
</html>"));
end BuildingEnvelopeDiscretized;
