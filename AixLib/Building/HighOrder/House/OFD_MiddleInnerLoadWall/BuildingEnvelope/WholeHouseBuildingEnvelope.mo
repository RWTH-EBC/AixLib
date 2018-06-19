within AixLib.Building.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope;
model WholeHouseBuildingEnvelope
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
  parameter Boolean withFloorHeating=false
    "If true, that floor has different connectors" annotation (Dialog(group=
          "Construction parameters"), choices(checkBox=true));
  parameter Real AirExchangeCorridor=2 "Air exchange corridors in 1/h "
    annotation (Dialog(group="Air Exchange Corridors", descriptionLabel=true));
  parameter Real AirExchangeAttic=0 "Air exchange attic in 1/h "
    annotation (Dialog(group="Air Exchange Attic", descriptionLabel=true));
  ///////// Sunblind
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
  ///////// Dynamic Ventilation
  parameter Boolean withDynamicVentilation=false "Dynamic ventilation"
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
  AixLib.Building.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope.GroundFloorBuildingEnvelope groundFloor_Building(
    TMC=TMC,
    TIR=TIR,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDynamicVentilation=withDynamicVentilation,
    HeatingLimit=HeatingLimit,
    Max_VR=Max_VR,
    Diff_toTempset=Diff_toTempset,
    withFloorHeating=withFloorHeating)
    annotation (Placement(transformation(extent={{-26,-94},{22,-42}})));
  AixLib.Building.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope.UpperFloorBuildingEnvelope
    upperFloor_Building(
    TMC=TMC,
    TIR=TIR,
    final use_sunblind=use_sunblind,
    final ratioSunblind=ratioSunblind,
    final solIrrThreshold=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    HeatingLimit=HeatingLimit,
    Max_VR=Max_VR,
    Diff_toTempset=Diff_toTempset,
    withDynamicVentilation=withDynamicVentilation,
    withFloorHeating=withFloorHeating)
    annotation (Placement(transformation(extent={{-26,-22},{20,30}})));
  AixLib.Building.HighOrder.Rooms.OFD.Attic_Ro2Lf5 attic_2Ro_5Rooms(
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
    annotation (Placement(transformation(extent={{-26,46},{20,86}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
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
  AixLib.Building.Components.DryAir.VarAirExchange varAirExchange(V=
        upperFloor_Building.Corridor.airload.V) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={36,-32})));
  Modelica.Blocks.Sources.Constant AirExchangeCorridor_Source(k=
        AirExchangeCorridor)
    annotation (Placement(transformation(extent={{22,-34},{26,-30}})));
  Modelica.Blocks.Sources.Constant AirExchangeAttic_Source(k=AirExchangeAttic)
    annotation (Placement(transformation(extent={{-60,70},{-52,78}})));
  AixLib.Utilities.Interfaces.Adaptors.HeatStarToComb heatStarToCombHeaters[9]
    annotation (Placement(transformation(extent={{-68,-26},{-48,-10}})));
  AixLib.Utilities.Interfaces.HeatStarComb heatingToRooms[9]
    "1: LivingRoom_GF, 2: Hobby_GF, 3: Corridor_GF, 4: WC_Storage_GF, 5: Kitchen_GF, 6: Bedroom_UF, 7: Child1_UF, 8: Bath_UF, 9: Child2_UF"
    annotation (Placement(transformation(extent={{-100,-46},{-80,-26}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    thermFloorHeatingDownHeatFlow[9] if withFloorHeating
    "Thermal connector for heat flow of floor heating going downwards through the floors/ceilings; 1: LivingRoom_GF, 2: Hobby_GF, 3: Corridor_GF, 4: WC_Storage_GF, 5: Kitchen_GF, 6: Bedroom_UF, 7: Child1_UF, 8: Bath_UF, 9: Child2_UF"
    annotation (Placement(transformation(extent={{-104,-104},{-88,-88}}),
        iconTransformation(extent={{-76,-70},{-62,-60}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a groundTemp[5]
    "HeatPorts to force ground temperature(s) for the ground floor."
    annotation (Placement(transformation(extent={{16,-108},{36,-88}}),
        iconTransformation(extent={{-10,-70},{10,-50}})));
equation
  connect(groundFloor_Building.thermCeiling_Livingroom, upperFloor_Building.thermFloor_Bedroom)
    annotation (Line(points={{-24.08,-39.66},{-24.08,-32.83},{-15.88,-32.83},{-15.88,
          -24.6}}, color={191,0,0}));
  connect(groundFloor_Building.thermCeiling_Hobby, upperFloor_Building.thermFloor_Children1)
    annotation (Line(points={{-13.76,-39.66},{-13.76,-32.83},{-10.36,-32.83},{-10.36,
          -24.6}}, color={191,0,0}));
  connect(groundFloor_Building.thermCeiling_Corridor, upperFloor_Building.thermFloor_Corridor)
    annotation (Line(points={{-4.64,-39.66},{-4.64,-32.83},{-3,-32.83},{-3,-24.6}},
        color={191,0,0}));
  connect(groundFloor_Building.thermCeiling_WCStorage, upperFloor_Building.thermFloor_Bath)
    annotation (Line(points={{4.96,-39.66},{4.96,-32.83},{3.9,-32.83},{3.9,-24.6}},
        color={191,0,0}));
  connect(groundFloor_Building.thermCeiling_Kitchen, upperFloor_Building.thermFloor_Children2)
    annotation (Line(points={{15.04,-39.66},{15.04,-32.83},{13.1,-32.83},{13.1,
          -24.6}}, color={191,0,0}));
  connect(upperFloor_Building.thermOutside, thermOutside) annotation (Line(
        points={{-27.84,23.24},{-74,23.24},{-74,90},{-90,90}}, color={191,0,0}));
  connect(attic_2Ro_5Rooms.thermOutside, thermOutside) annotation (Line(points=
          {{-23.7,84},{-74,84},{-74,90},{-90,90}}, color={191,0,0}));
  connect(groundFloor_Building.thermOutside, thermOutside) annotation (Line(
        points={{-27.92,-48.76},{-74,-48.76},{-74,90},{-90,90}}, color={191,0,0}));
  connect(upperFloor_Building.thermCeiling_Bedroom, attic_2Ro_5Rooms.thermRoom1)
    annotation (Line(points={{-23.7,32.34},{-23.7,48}}, color={191,0,0}));
  connect(upperFloor_Building.thermCeiling_Children1, attic_2Ro_5Rooms.thermRoom2)
    annotation (Line(points={{-14.27,32.34},{-14.27,40.17},{-14.5,40.17},{-14.5,
          48}}, color={191,0,0}));
  connect(upperFloor_Building.thermCeiling_Corridor, attic_2Ro_5Rooms.thermRoom3)
    annotation (Line(points={{-5.53,32.34},{-5.53,40.17},{-5.3,40.17},{-5.3,48}},
        color={191,0,0}));
  connect(upperFloor_Building.thermCeiling_Bath, attic_2Ro_5Rooms.thermRoom4)
    annotation (Line(points={{3.67,32.34},{3.67,40.17},{3.9,40.17},{3.9,48}},
        color={191,0,0}));
  connect(upperFloor_Building.thermCeiling_Children2, attic_2Ro_5Rooms.thermRoom5)
    annotation (Line(points={{12.87,32.34},{12.87,39.17},{13.1,39.17},{13.1,48}},
        color={191,0,0}));
  connect(attic_2Ro_5Rooms.WindSpeedPort, WindSpeedPort) annotation (Line(
        points={{-25.885,66},{-74,66},{-74,46},{-100,46}}, color={0,0,127}));
  connect(upperFloor_Building.WindSpeedPort, WindSpeedPort) annotation (Line(
        points={{-29.45,10.5},{-32,12},{-74,12},{-74,46},{-100,46}}, color={0,0,
          127}));
  connect(groundFloor_Building.WindSpeedPort, WindSpeedPort) annotation (Line(
        points={{-29.6,-60.98},{-74,-60.98},{-74,46},{-100,46}}, color={0,0,127}));
  connect(upperFloor_Building.North, North) annotation (Line(points={{22.3,5.56},
          {60,5.56},{60,18},{90,18}}, color={255,128,0}));
  connect(groundFloor_Building.North, North) annotation (Line(points={{24.4,-45.12},
          {60,-45.12},{60,18},{90,18}}, color={255,128,0}));
  connect(upperFloor_Building.East, East) annotation (Line(points={{22.3,-2.24},
          {60,-2.24},{60,-18},{90,-18}}, color={255,128,0}));
  connect(groundFloor_Building.East, East) annotation (Line(points={{24.4,-52.4},
          {60,-52.4},{60,-18},{90,-18}}, color={255,128,0}));
  connect(upperFloor_Building.South, South) annotation (Line(points={{22.3,-10.04},
          {60,-10.04},{60,-56},{90,-56}}, color={255,128,0}));
  connect(groundFloor_Building.South, South) annotation (Line(points={{24.4,-61.24},
          {60,-61.24},{60,-56},{90,-56}}, color={255,128,0}));
  connect(upperFloor_Building.West, West) annotation (Line(points={{22.3,-17.84},
          {60,-17.84},{60,-90},{90,-90}}, color={255,128,0}));
  connect(groundFloor_Building.West, West) annotation (Line(points={{24.4,-72.16},
          {60,-72.16},{60,-90},{90,-90}}, color={255,128,0}));
  connect(upperFloor_Building.RoofS, SolarRadiationPort_RoofS) annotation (Line(
        points={{22.3,15.44},{60,15.44},{60,58},{90,58}}, color={255,128,0}));
  connect(upperFloor_Building.RoofN, SolarRadiationPort_RoofN) annotation (Line(
        points={{22.3,23.76},{60,23.76},{60,90},{90,90}}, color={255,128,0}));
  connect(groundFloor_Building.thermCorridor, varAirExchange.port_b)
    annotation (Line(points={{24.4,-39.4},{36,-39.4},{36,-38}}, color={191,0,0}));
  connect(upperFloor_Building.thermCorridor, varAirExchange.port_a) annotation (
     Line(points={{22.3,-24.6},{36,-24.6},{36,-26}}, color={191,0,0}));
  connect(AirExchangeCorridor_Source.y, varAirExchange.InPort1) annotation (
      Line(points={{26.2,-32},{28,-32},{28,-24},{32.16,-24},{32.16,-26.6}},
        color={0,0,127}));
  connect(groundFloor_Building.AirExchangePort[1:4], AirExchangePort[1:4])
    annotation (Line(points={{-29.6,-65.855},{-74,-65.855},{-74,1.5},{-100,1.5}},
        color={0,0,127}));
  connect(upperFloor_Building.AirExchangePort[1:4], AirExchangePort[5:8])
    annotation (Line(points={{-29.45,4.065},{-74,4.065},{-74,21.5},{-100,21.5}},
        color={0,0,127}));
  connect(AirExchangeAttic_Source.y, attic_2Ro_5Rooms.AirExchangePort)
    annotation (Line(points={{-51.6,74},{-26,74}}, color={0,0,127}));
  connect(attic_2Ro_5Rooms.SolarRadiationPort_RO1, SolarRadiationPort_RoofS)
    annotation (Line(points={{-14.5,84},{-14.5,90},{60,90},{60,58},{90,58}},
                color={255,128,0}));
  connect(attic_2Ro_5Rooms.SolarRadiationPort_RO2, SolarRadiationPort_RoofN)
    annotation (Line(points={{8.5,84},{10,84},{10,90},{90,90}}, color={255,128,
          0}));
  connect(heatStarToCombHeaters.thermStarComb, heatingToRooms) annotation (Line(
        points={{-67.4,-18.1},{-90,-18.1},{-90,-36}}, color={191,0,0}));
  connect(heatStarToCombHeaters[1].therm, groundFloor_Building.ThermLivingroom)
    annotation (Line(points={{-47.9,-23.1},{-44,-23.1},{-44,-52.14},{-7.04,-52.14}},
        color={191,0,0}));
  connect(heatStarToCombHeaters[1].star, groundFloor_Building.StarLivingroom)
    annotation (Line(points={{-47.6,-12.2},{-38,-12.2},{-38,-57.6},{-6.8,-57.6}},
        color={95,95,95}));
  connect(heatStarToCombHeaters[2].therm, groundFloor_Building.ThermHobby)
    annotation (Line(points={{-47.9,-23.1},{-44,-23.1},{-44,-52},{2,-52},{2,-52},
          {2,-52.4},{2.8,-52.4}}, color={191,0,0}));
  connect(heatStarToCombHeaters[2].star, groundFloor_Building.StarHobby)
    annotation (Line(points={{-47.6,-12.2},{-38,-12.2},{-38,-57.6},{2.8,-57.6}},
        color={95,95,95}));
  connect(heatStarToCombHeaters[3].therm, groundFloor_Building.ThermCorridor)
    annotation (Line(points={{-47.9,-23.1},{-44,-23.1},{-44,-66.96},{1.36,-66.96}},
        color={191,0,0}));
  connect(heatStarToCombHeaters[3].star, groundFloor_Building.StarCorridor)
    annotation (Line(points={{-47.6,-12.2},{-38,-12.2},{-38,-72.16},{1.36,-72.16}},
        color={95,95,95}));
  connect(heatStarToCombHeaters[4].therm, groundFloor_Building.ThermWC_Storage)
    annotation (Line(points={{-47.9,-23.1},{-44,-23.1},{-44,-81},{3.28,-81}},
        color={191,0,0}));
  connect(heatStarToCombHeaters[4].star, groundFloor_Building.StarWC_Storage)
    annotation (Line(points={{-47.6,-12.2},{-38,-12.2},{-38,-86.2},{3.28,-86.2}},
        color={95,95,95}));
  connect(heatStarToCombHeaters[5].therm, groundFloor_Building.ThermKitchen)
    annotation (Line(points={{-47.9,-23.1},{-44,-23.1},{-44,-81},{-6.32,-81}},
        color={191,0,0}));
  connect(heatStarToCombHeaters[5].star, groundFloor_Building.StarKitchen)
    annotation (Line(points={{-47.6,-12.2},{-38,-12.2},{-38,-86.2},{-6.32,-86.2}},
        color={95,95,95}));
  connect(heatStarToCombHeaters[6].therm, upperFloor_Building.ThermBedroom)
    annotation (Line(points={{-47.9,-23.1},{-44,-23.1},{-44,19.6},{-7.6,19.6}},
        color={191,0,0}));
  connect(heatStarToCombHeaters[6].star, upperFloor_Building.StarBedroom)
    annotation (Line(points={{-47.6,-12.2},{-38,-12.2},{-38,14.4},{-7.6,14.4}},
        color={95,95,95}));
  connect(heatStarToCombHeaters[7].therm, upperFloor_Building.ThermChildren1)
    annotation (Line(points={{-47.9,-23.1},{-44,-23.1},{-44,19.6},{1.6,19.6}},
        color={191,0,0}));
  connect(heatStarToCombHeaters[7].star, upperFloor_Building.StarChildren1)
    annotation (Line(points={{-47.6,-12.2},{-38,-12.2},{-38,14.4},{1.6,14.4}},
        color={95,95,95}));
  connect(heatStarToCombHeaters[8].therm, upperFloor_Building.ThermBath)
    annotation (Line(points={{-47.9,-23.1},{-44,-23.1},{-44,-6.4},{1.6,-6.4}},
        color={191,0,0}));
  connect(heatStarToCombHeaters[8].star, upperFloor_Building.StarBath)
    annotation (Line(points={{-47.6,-12.2},{1.6,-12.2},{1.6,-11.6}}, color={95,
          95,95}));
  connect(heatStarToCombHeaters[9].therm, upperFloor_Building.ThermChildren2)
    annotation (Line(points={{-47.9,-23.1},{-44,-23.1},{-44,-6.4},{-7.6,-6.4}},
        color={191,0,0}));
  connect(heatStarToCombHeaters[9].star, upperFloor_Building.StarChildren2)
    annotation (Line(points={{-47.6,-12.2},{-8,-12.2},{-8,-12},{-8,-12},{-8,-12},
          {-8,-12},{-8,-11.6},{-7.6,-11.6}}, color={95,95,95}));

  connect(thermFloorHeatingDownHeatFlow[1:5], groundFloor_Building.thermFloorHeatingDownHeatFlow[
    1:5]) annotation (Line(
      points={{-96,-96},{-22.976,-96},{-22.976,-92.7}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(thermFloorHeatingDownHeatFlow[6:9], upperFloor_Building.thermFloorHeatingDownHeatFlow[
    1:4]) annotation (Line(
      points={{-96,-88.8889},{-36,-88.8889},{-36,-20.7},{-23.1825,-20.7}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(groundFloor_Building.groundTemp, groundTemp) annotation (Line(points=
          {{-2,-94},{-2,-99},{26,-99},{26,-98}}, color={191,0,0}));
  connect(East, attic_2Ro_5Rooms.SolarRadiationPort_OW1) annotation (Line(
        points={{90,-18},{60,-18},{60,90},{-74,90},{-74,62},{-27.38,62}}, color=
         {255,128,0}));
  connect(West, attic_2Ro_5Rooms.SolarRadiationPort_OW2) annotation (Line(
        points={{90,-90},{60,-90},{60,62.4},{22.3,62.4}}, color={255,128,0}));
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
