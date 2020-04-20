within AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope;
model WholeHouseBuildingEnvelope

  extends AixLib.ThermalZones.HighOrder.Rooms.OFD.BaseClasses.PartialRoomParams(redeclare replaceable parameter DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes);

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
      groupImage = "modelica://AixLib/Resources/Images/Building/HighOrder/Grundriss.png",
      group="Construction parameters",
      compact=true,
      descriptionLabel=true), choices(
      choice=1 "EnEV_2009",
      choice=2 "EnEV_2002",
      choice=3 "WSchV_1995",
      choice=4 "WSchV_1984",
      radioButtons=true));

  parameter Real AirExchangeCorridor=2 "Air exchange corridors in 1/h "
    annotation (Dialog(group="Air Exchange Corridors", descriptionLabel=true));
  parameter Real AirExchangeAttic=0 "Air exchange attic in 1/h "
    annotation (Dialog(group="Air Exchange Attic", descriptionLabel=true));



  AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope.GroundFloorBuildingEnvelope
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
    final solar_absorptance_OW=solar_absorptance_OW,
    final calcMethod=calcMethod,
    final surfaceType=surfaceType,
    final hConOut_const=hConOut_const,
    final use_infiltEN12831=use_infiltEN12831,
    final n50=n50,
    final e=e,
    final eps=eps,
    TMC=TMC,
    TIR=TIR,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDynamicVentilation=withDynamicVentilation,
    HeatingLimit=HeatingLimit,
    Max_VR=Max_VR,
    Diff_toTempset=Diff_toTempset)
    annotation (Placement(transformation(extent={{-24,-94},{24,-42}})));
  AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope.UpperFloorBuildingEnvelope
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
    final solar_absorptance_OW=solar_absorptance_OW,
    final calcMethod=calcMethod,
    final surfaceType=surfaceType,
    final hConOut_const=hConOut_const,
    final use_infiltEN12831=use_infiltEN12831,
    final n50=n50,
    final e=e,
    final eps=eps,
    TMC=TMC,
    TIR=TIR,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    HeatingLimit=HeatingLimit,
    Max_VR=Max_VR,
    Diff_toTempset=Diff_toTempset,
    withDynamicVentilation=withDynamicVentilation)
    annotation (Placement(transformation(extent={{-24,-18},{24,34}})));
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
    final solar_absorptance_OW=solar_absorptance_OW,
    final calcMethod=calcMethod,
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
    final Tset=Tset,
    length=10.64,
    room1_length=5.875,
    room2_length=3.215,
    room3_length=3.92,
    room4_length=3.215,
    room5_length=4.62,
    roof_width1=3.36,
    roof_width2=3.36,
    solar_absorptance_RO=0.1,
    width=4.75,
    TMC=TMC,
    TIR=TIR,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    room1_width=2.28,
    room2_width=2.28,
    room3_width=2.28,
    room4_width=2.28,
    room5_width=2.28,
    alfa=1.5707963267949)
    annotation (Placement(transformation(extent={{-22,44},{22,82}})));

  Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation (Placement(
        transformation(extent={{-120,26},{-80,66}}), iconTransformation(extent=
            {{-108,38},{-80,66}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort[8]
    "1: LivingRoom_GF, 2: Hobby_GF, 3: WC_Storage_GF, 4: Kitchen_GF, 5: Bedroom_UF, 6: Child1_UF, 7: Bath_UF, 8: Child2_UF"
    annotation (Placement(transformation(extent={{-120,-16},{-80,24}}),
        iconTransformation(extent={{-108,-4},{-80,24}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_RoofS annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,58})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_RoofN annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,90})));
  Utilities.Interfaces.SolarRad_in North annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,18})));
  Utilities.Interfaces.SolarRad_in East annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-18})));
  Utilities.Interfaces.SolarRad_in South annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-56})));
  Utilities.Interfaces.SolarRad_in West annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-90})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange varAirExchange(
      V=upperFloor_Building.Corridor.airload.V) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={36,-32})));
  Modelica.Blocks.Sources.Constant AirExchangeCorridor_Source(k=
        AirExchangeCorridor)
    annotation (Placement(transformation(extent={{22,-34},{26,-30}})));
  Modelica.Blocks.Sources.Constant AirExchangeAttic_Source(k=AirExchangeAttic)
    annotation (Placement(transformation(extent={{-60,70},{-52,78}})));
  AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort heatStarToCombHeaters[9] annotation (Placement(transformation(extent={{-68,-26},{-48,-10}})));
  AixLib.Utilities.Interfaces.ConvRadComb heatingToRooms[9] "1: LivingRoom_GF, 2: Hobby_GF, 3: Corridor_GF, 4: WC_Storage_GF, 5: Kitchen_GF, 6: Bedroom_UF, 7: Child1_UF, 8: Bath_UF, 9: Child2_UF" annotation (Placement(transformation(extent={{-100,-46},{-80,-26}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a groundTemp[5]
    "HeatPorts to force ground temperature(s) for the ground floor."
    annotation (Placement(transformation(extent={{16,-108},{36,-88}}),
        iconTransformation(extent={{-10,-70},{10,-50}})));
equation
  connect(groundFloor_Building.thermCeiling_Livingroom, upperFloor_Building.thermFloor_Bedroom)
    annotation (Line(points={{-22.08,-39.66},{-22.08,-32.83},{-13.44,-32.83},{-13.44,-20.6}},
                   color={191,0,0}));
  connect(groundFloor_Building.thermCeiling_Hobby, upperFloor_Building.thermFloor_Children1)
    annotation (Line(points={{-11.76,-39.66},{-11.76,-32.83},{-7.68,-32.83},{-7.68,-20.6}},
                   color={191,0,0}));
  connect(groundFloor_Building.thermCeiling_Corridor, upperFloor_Building.thermFloor_Corridor)
    annotation (Line(points={{-2.64,-39.66},{-2.64,-32.83},{0,-32.83},{0,-20.6}},
        color={191,0,0}));
  connect(groundFloor_Building.thermCeiling_WCStorage, upperFloor_Building.thermFloor_Bath)
    annotation (Line(points={{6.96,-39.66},{6.96,-32.83},{7.2,-32.83},{7.2,-20.6}},
        color={191,0,0}));
  connect(groundFloor_Building.thermCeiling_Kitchen, upperFloor_Building.thermFloor_Children2)
    annotation (Line(points={{17.04,-39.66},{17.04,-32.83},{16.8,-32.83},{16.8,-20.6}},
                   color={191,0,0}));
  connect(upperFloor_Building.thermOutside, thermOutside) annotation (Line(
        points={{-24,33.48},{-74,33.48},{-74,100},{-100,100}}, color={191,0,0}));
  connect(attic_2Ro_5Rooms.thermOutside, thermOutside) annotation (Line(points={{-22,81.62},{-74,81.62},{-74,100},{-100,100}},
                                                   color={191,0,0}));
  connect(groundFloor_Building.thermOutside, thermOutside) annotation (Line(
        points={{-24,-42.52},{-74,-42.52},{-74,100},{-100,100}}, color={191,0,0}));
  connect(attic_2Ro_5Rooms.WindSpeedPort, WindSpeedPort) annotation (Line(
        points={{-24.09,66.8},{-74,66.8},{-74,46},{-100,46}},
                                                           color={0,0,127}));
  connect(upperFloor_Building.WindSpeedPort, WindSpeedPort) annotation (Line(
        points={{-27.6,14.5},{-74,14.5},{-74,46},{-100,46}},         color={0,0,
          127}));
  connect(groundFloor_Building.WindSpeedPort, WindSpeedPort) annotation (Line(
        points={{-27.6,-60.98},{-74,-60.98},{-74,46},{-100,46}}, color={0,0,127}));
  connect(upperFloor_Building.North, North) annotation (Line(points={{26.4,9.56},{60,9.56},{60,18},{90,18}},
                                      color={255,128,0}));
  connect(groundFloor_Building.North, North) annotation (Line(points={{26.4,-45.12},{60,-45.12},{60,18},{90,18}},
                                        color={255,128,0}));
  connect(upperFloor_Building.East, East) annotation (Line(points={{26.4,1.76},{60,1.76},{60,-18},{90,-18}},
                                         color={255,128,0}));
  connect(groundFloor_Building.East, East) annotation (Line(points={{26.4,-52.4},{60,-52.4},{60,-18},{90,-18}},
                                         color={255,128,0}));
  connect(upperFloor_Building.South, South) annotation (Line(points={{26.4,-6.04},{60,-6.04},{60,-56},{90,-56}},
                                          color={255,128,0}));
  connect(groundFloor_Building.South, South) annotation (Line(points={{26.4,-61.24},{60,-61.24},{60,-56},{90,-56}},
                                          color={255,128,0}));
  connect(upperFloor_Building.West, West) annotation (Line(points={{26.4,-13.84},{60,-13.84},{60,-90},{90,-90}},
                                          color={255,128,0}));
  connect(groundFloor_Building.West, West) annotation (Line(points={{26.4,-72.16},{60,-72.16},{60,-90},{90,-90}},
                                          color={255,128,0}));
  connect(upperFloor_Building.RoofS, SolarRadiationPort_RoofS) annotation (Line(
        points={{26.4,19.44},{60,19.44},{60,58},{90,58}}, color={255,128,0}));
  connect(upperFloor_Building.RoofN, SolarRadiationPort_RoofN) annotation (Line(
        points={{26.4,27.76},{60,27.76},{60,90},{90,90}}, color={255,128,0}));
  connect(groundFloor_Building.thermCorridor, varAirExchange.port_b)
    annotation (Line(points={{26.4,-39.4},{36,-39.4},{36,-38}}, color={191,0,0}));
  connect(upperFloor_Building.thermCorridor, varAirExchange.port_a) annotation (
     Line(points={{26.4,-20.6},{36,-20.6},{36,-26}}, color={191,0,0}));
  connect(AirExchangeCorridor_Source.y, varAirExchange.InPort1) annotation (
      Line(points={{26.2,-32},{28,-32},{28,-24},{33,-24},{33,-25.4}},
        color={0,0,127}));
  connect(groundFloor_Building.AirExchangePort[1:4], AirExchangePort[1:4])
    annotation (Line(points={{-27.6,-65.855},{-74,-65.855},{-74,1.5},{-100,1.5}},
        color={0,0,127}));
  connect(upperFloor_Building.AirExchangePort[1:4], AirExchangePort[5:8])
    annotation (Line(points={{-27.6,8.065},{-74,8.065},{-74,21.5},{-100,21.5}},
        color={0,0,127}));
  connect(AirExchangeAttic_Source.y, attic_2Ro_5Rooms.AirExchangePort)
    annotation (Line(points={{-51.6,74},{-40,74},{-40,76.205},{-24.2,76.205}},
                                                   color={0,0,127}));
  connect(attic_2Ro_5Rooms.SolarRadiationPort_RO1, SolarRadiationPort_RoofS)
    annotation (Line(points={{-11,80.1},{-11,90},{62,90},{62,58},{90,58}},
                color={255,128,0}));
  connect(attic_2Ro_5Rooms.SolarRadiationPort_RO2, SolarRadiationPort_RoofN)
    annotation (Line(points={{11,80.1},{16,80.1},{16,90},{90,90}},
                                                                color={255,128,
          0}));
  connect(heatStarToCombHeaters.portConvRadComb, heatingToRooms) annotation (Line(points={{-67.8,-16.7},{-90,-16.7},{-90,-36}}, color={191,0,0}));
  connect(heatStarToCombHeaters[1].portConv, groundFloor_Building.ThermLivingroom) annotation (Line(points={{-47.9,-23.1},{-42,-23.1},{-42,-52.14},{-5.04,-52.14}}, color={191,0,0}));
  connect(heatStarToCombHeaters[1].portRad, groundFloor_Building.StarLivingroom) annotation (Line(points={{-47.6,-12.2},{-36,-12.2},{-36,-57.6},{-4.8,-57.6}}, color={95,95,95}));
  connect(heatStarToCombHeaters[2].portConv, groundFloor_Building.ThermHobby) annotation (Line(points={{-47.9,-23.1},{-42,-23.1},{-42,-52},{4,-52},{4,-52.4},{4.8,-52.4}},         color={191,0,0}));
  connect(heatStarToCombHeaters[2].portRad, groundFloor_Building.StarHobby) annotation (Line(points={{-47.6,-12.2},{-36,-12.2},{-36,-57.6},{4.8,-57.6}}, color={95,95,95}));
  connect(heatStarToCombHeaters[3].portConv, groundFloor_Building.ThermCorridor) annotation (Line(points={{-47.9,-23.1},{-42,-23.1},{-42,-66.96},{3.36,-66.96}}, color={191,0,0}));
  connect(heatStarToCombHeaters[3].portRad, groundFloor_Building.StarCorridor) annotation (Line(points={{-47.6,-12.2},{-36,-12.2},{-36,-72.16},{3.36,-72.16}}, color={95,95,95}));
  connect(heatStarToCombHeaters[4].portConv, groundFloor_Building.ThermWC_Storage) annotation (Line(points={{-47.9,-23.1},{-42,-23.1},{-42,-81},{5.28,-81}}, color={191,0,0}));
  connect(heatStarToCombHeaters[4].portRad, groundFloor_Building.StarWC_Storage) annotation (Line(points={{-47.6,-12.2},{-36,-12.2},{-36,-86.2},{5.28,-86.2}}, color={95,95,95}));
  connect(heatStarToCombHeaters[5].portConv, groundFloor_Building.ThermKitchen) annotation (Line(points={{-47.9,-23.1},{-42,-23.1},{-42,-81},{-4.32,-81}}, color={191,0,0}));
  connect(heatStarToCombHeaters[5].portRad, groundFloor_Building.StarKitchen) annotation (Line(points={{-47.6,-12.2},{-36,-12.2},{-36,-86.2},{-4.32,-86.2}}, color={95,95,95}));
  connect(heatStarToCombHeaters[6].portConv, upperFloor_Building.ThermBedroom) annotation (Line(points={{-47.9,-23.1},{-42,-23.1},{-42,23.6},{-4.8,23.6}}, color={191,0,0}));
  connect(heatStarToCombHeaters[6].portRad, upperFloor_Building.StarBedroom) annotation (Line(points={{-47.6,-12.2},{-36,-12.2},{-36,18.4},{-4.8,18.4}}, color={95,95,95}));
  connect(heatStarToCombHeaters[7].portConv, upperFloor_Building.ThermChildren1) annotation (Line(points={{-47.9,-23.1},{-42,-23.1},{-42,23.6},{4.8,23.6}}, color={191,0,0}));
  connect(heatStarToCombHeaters[7].portRad, upperFloor_Building.StarChildren1) annotation (Line(points={{-47.6,-12.2},{-36,-12.2},{-36,18.4},{4.8,18.4}}, color={95,95,95}));
  connect(heatStarToCombHeaters[8].portConv, upperFloor_Building.ThermBath) annotation (Line(points={{-47.9,-23.1},{-42,-23.1},{-42,-2.4},{4.8,-2.4}}, color={191,0,0}));
  connect(heatStarToCombHeaters[8].portRad, upperFloor_Building.StarBath) annotation (Line(points={{-47.6,-12.2},{4.8,-12.2},{4.8,-7.6}},  color={95,95,95}));
  connect(heatStarToCombHeaters[9].portConv, upperFloor_Building.ThermChildren2) annotation (Line(points={{-47.9,-23.1},{-42,-23.1},{-42,-2.4},{-4.8,-2.4}}, color={191,0,0}));
  connect(heatStarToCombHeaters[9].portRad, upperFloor_Building.StarChildren2) annotation (Line(points={{-47.6,-12.2},{-6,-12.2},{-6,-7.6},{-4.8,-7.6}},                                       color={95,95,95}));

  connect(groundFloor_Building.groundTemp, groundTemp) annotation (Line(points={{0,-94},{0,-99},{26,-99},{26,-98}},
                                                 color={191,0,0}));
  connect(East, attic_2Ro_5Rooms.SolarRadiationPort_OW1) annotation (Line(
        points={{90,-18},{60,-18},{60,90},{-74,90},{-74,59.2},{-24.2,59.2}},
                                                                          color=
         {255,128,0}));
  connect(West, attic_2Ro_5Rooms.SolarRadiationPort_OW2) annotation (Line(
        points={{90,-90},{60,-90},{60,59.2},{24.2,59.2}}, color={255,128,0}));
  connect(attic_2Ro_5Rooms.thermRoom1, upperFloor_Building.thermCeiling_Bedroom) annotation (Line(points={{-17.6,45.9},{-21.6,45.9},{-21.6,36.34}},
                                                                                                                                                color={191,0,0}));
  connect(attic_2Ro_5Rooms.thermRoom2, upperFloor_Building.thermCeiling_Children1) annotation (Line(points={{-8.8,45.9},{-11.76,45.9},{-11.76,36.34}},
                                                                                                                                                    color={191,0,0}));
  connect(attic_2Ro_5Rooms.thermRoom3, upperFloor_Building.thermCeiling_Corridor) annotation (Line(points={{0,45.9},{-2.64,45.9},{-2.64,36.34}},
                                                                                                                                              color={191,0,0}));
  connect(attic_2Ro_5Rooms.thermRoom4, upperFloor_Building.thermCeiling_Bath) annotation (Line(points={{8.8,45.9},{8.8,43},{6.96,43},{6.96,36.34}},
                                                                                                                                                  color={191,0,0}));
  connect(attic_2Ro_5Rooms.thermRoom5, upperFloor_Building.thermCeiling_Children2) annotation (Line(points={{17.6,45.9},{16.56,45.9},{16.56,36.34}},
                                                                                                                                                 color={191,0,0}));
  annotation (Icon(graphics={Bitmap(extent={{-78,74},{72,-68}}, fileName=
              "modelica://AixLib/Resources/Images/Building/HighOrder/Grundriss.PNG")}),
      Documentation(info="<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for the envelope of the whole one family dwelling.</p>
<p><b><span style=\"color: #008000;\">Ground temperature</span></b> </p>
<p>The ground temperature can be coupled to any desired prescriped temperature. Anyway, suitable ground temperatures depending on locations in Germany are listed as &Theta;'_m,e in the comprehensive table 1 in &quot;Beiblatt 1&quot; in the norm DIN EN 12831.</p>
<p>Or a ground temperature can be chosen according to a TRY region, which is listed below: if ...</p><p>TRY_Region == 1 then 282.15 K</p><p>TRY_Region == 2 then 281.55 K</p><p>TRY_Region == 3 then 281.65 K</p><p>TRY_Region == 4 then 282.65 K</p><p>TRY_Region == 5 then 281.25 K</p><p>TRY_Region == 6 then 279.95 K</p><p>TRY_Region == 7 then 281.95 K</p><p>TRY_Region == 8 then 279.95 K</p><p>TRY_Region == 9 then 281.05 K</p><p>TRY_Region == 10 then 276.15 K</p><p>TRY_Region == 11 then 279.45 K</p><p>TRY_Region == 12 then 283.35 K</p><p>TRY_Region == 13 then 281.05 K</p><p>TRY_Region == 14 then 281.05 K</p><p>TRY_Region == 15 then 279.95 K </p>
</html>",  revisions="<html>

 <ul>
 <li><i>August 1, 2017</i> by Philipp Mehrfeld:<br/>Add heat-star-combi to connect heaters in a more clever way</li>
 <li><i>Mai 7, 2015</i> by Ana Constantin:<br/>Corrected connection of gabled vertical walls with solar radiation (E and W)</li>
 <li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
 <li><i>July 10, 2011</i> by Ana Constantin:<br/>Implemented</li>
 </ul>

 </html>"));
end WholeHouseBuildingEnvelope;
