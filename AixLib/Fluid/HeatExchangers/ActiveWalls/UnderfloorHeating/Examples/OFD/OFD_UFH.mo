within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Examples.OFD;
model OFD_UFH
  "Test environment for OFD with underfloor heating system"
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
  parameter Integer dis=10;
  parameter Modelica.SIunits.Distance Spacing[nHeatedRooms] = fill(0.2, 10);
  parameter Modelica.SIunits.Diameter d_a[nHeatedRooms] = fill(0.017, 10);
  parameter Modelica.SIunits.Diameter d[nHeatedRooms] = fill(0.018, 10);
  Modelica.Blocks.Sources.Constant constAirEx[nRooms](k={0.5,0.5,0,0.5,0.5,0.5,0.5,0,0.5,0.5,0}) "1: LivingRoom_GF, 2: Hobby_GF, 3: Corridor_GF, 4: WC_Storage_GF, 5: Kitchen_GF, 6: Bedroom_UF, 7: Child1_UF, 8: Corridor_UF, 9: Bath_UF, 10: Child2_UF, 11: Attic" annotation (Placement(transformation(extent={{-70,6},{-50,26}})));
  Modelica.Blocks.Sources.Constant constWind(k=0)
    annotation (Placement(transformation(extent={{-70,36},{-50,56}})));
  Modelica.Blocks.Sources.Constant constAmb(k=261.15)
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow    groundTemp[5](Q_flow=
        fill(0, 5))
    annotation (Placement(transformation(extent={{-54,-96},{-42,-84}})));
  AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort heatStarToComb[nRooms]
    annotation (Placement(transformation(
        extent={{8,-6},{-8,6}},
        rotation=0,
        origin={-36,-12})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedAmbTemperature
    annotation (Placement(transformation(extent={{-40,58},{-28,70}})));
  AixLib.Utilities.Sources.PrescribedSolarRad varRad(n=6)
    annotation (Placement(transformation(extent={{70,60},{50,80}})));
  Modelica.Blocks.Sources.Constant constSun[6](k=fill(0, 6))
    annotation (Placement(transformation(extent={{100,70},{80,90}})));
  AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelopeDiscretized.WholeHouseBuildingEnvelope
    wholeHouseBuildingEnvelope(
    use_UFH=true,
    redeclare BaseClasses.FloorLayers.EnEV2009Heavy_UFH wallTypes,
    energyDynamicsWalls=Modelica.Fluid.Types.Dynamics.FixedInitial,
    initDynamicsAir=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T0_air=294.15,
    TWalls_start=292.15,
    calcMethodIn=1,
    redeclare AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009
      Type_Win,
    use_infiltEN12831=true,
    n50=if TIR == 1 or TIR == 2 then 3 else if TIR == 3 then 4 else 6,
    dis=dis,
    AirExchangeCorridor=0,
    UValOutDoors=if TIR == 1 then 1.8 else 2.9)
    annotation (Placement(transformation(extent={{-14,-10},{42,46}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowRad[nRooms] annotation (Placement(transformation(extent={{-60,-16},
            {-48,-4}})));
  Modelica.Blocks.Sources.Constant adiabaticRadRooms[nRooms](k=fill(0, nRooms)) "1: LivingRoom_GF, 2: Hobby_GF, 3: Corridor_GF, 4: WC_Storage_GF, 5: Kitchen_GF, 6: Bedroom_UF, 7: Child1_UF, 8: Corridor_UF, 9: Bath_UF, 10: Child2_UF, 11: Attic" annotation (Placement(transformation(extent={{-90,-18},
            {-74,-2}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlowAttic[1](Q_flow={0}) annotation (Placement(transformation(extent={{-62,-26},
            {-52,-16}})));
  UnderfloorHeating.UnderfloorHeatingSystem underfloorHeatingSystem(
    redeclare package Medium = AixLib.Media.Water,
    RoomNo=10,
    dis=dis,
    Q_Nf={638,1078,502,341,783,766,506,196,443,658},
    A={wholeHouseBuildingEnvelope.groundFloor_Building.WC_Storage.floor[1].Wall.A
        *dis,wholeHouseBuildingEnvelope.groundFloor_Building.Livingroom.floor[
        1].Wall.A*dis,wholeHouseBuildingEnvelope.groundFloor_Building.Hobby.floor[
        1].Wall.A*dis,wholeHouseBuildingEnvelope.groundFloor_Building.Corridor.floor[
        1].Wall.A*dis,wholeHouseBuildingEnvelope.groundFloor_Building.Kitchen.floor[
        1].Wall.A*dis,wholeHouseBuildingEnvelope.upperFloor_Building.Bedroom.floor[
        1].Wall.A*dis,wholeHouseBuildingEnvelope.upperFloor_Building.Children1.floor[
        1].Wall.A*dis,wholeHouseBuildingEnvelope.upperFloor_Building.Corridor.floor[
        1].Wall.A*dis,wholeHouseBuildingEnvelope.upperFloor_Building.Bath.floor[
        1].Wall.A*dis,wholeHouseBuildingEnvelope.upperFloor_Building.Children2.floor[
        1].Wall.A*dis},
    calculateVol=2,
    wallTypeFloor=fill(
        BaseClasses.FloorLayers.FLpartition_EnEV2009_SM_upHalf_UFH(), 10),
    Ceiling={false,false,false,false,false,true,true,true,true,true},
    wallTypeCeiling={
        UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy(),
        UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy(),
        UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy(),
        UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy(),
        UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy(),
        wholeHouseBuildingEnvelope.groundFloor_Building.Livingroom.Ceiling[
        1].Wall.wallType,wholeHouseBuildingEnvelope.groundFloor_Building.Hobby.Ceiling[
        1].Wall.wallType,wholeHouseBuildingEnvelope.groundFloor_Building.Corridor.Ceiling[
        1].Wall.wallType,wholeHouseBuildingEnvelope.groundFloor_Building.WC_Storage.Ceiling[
        1].Wall.wallType,wholeHouseBuildingEnvelope.groundFloor_Building.Kitchen.Ceiling[
        1].Wall.wallType},
    T_U={293.15,293.15,293.15,293.15,293.15,293.15,293.15,293.15,293.15,
        293.15},
    Spacing=fill(0.2, 10),
    PipeMaterial=BaseClasses.PipeMaterials.PERTpipe(),
    PipeThickness=fill(0.002, 10),
    d_a=fill(0.017, 10),
    withSheathing=false)
    annotation (Placement(transformation(extent={{-68,-66},{-44,-52}})));

  AixLib.Fluid.Sources.MassFlowSource_T m_flow_specification1(
    redeclare package Medium = AixLib.Media.Water,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-98,-66},{-82,-50}})));
  AixLib.Fluid.Sources.Boundary_pT boundary(redeclare package Medium =
        AixLib.Media.Water, nPorts=1)
    annotation (Placement(transformation(extent={{-12,-64},{-24,-52}})));
  Modelica.Blocks.Sources.Constant const[sum(underfloorHeatingSystem.CircuitNo)](each k=
        1)
          annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-86,-36})));
equation
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
    annotation (Line(points={{51,70.8333},{48,70.8333},{48,34.8},{43.68,34.8}},
        color={255,128,0}));
  connect(heatStarToComb.portConvRadComb, wholeHouseBuildingEnvelope.heatingToRooms) annotation (Line(points={{-28,-12},
          {-26,-12},{-26,10},{-14,10},{-14,10.16}},                                                                                                                      color={191,0,0}));
  connect(constAirEx.y, wholeHouseBuildingEnvelope.AirExchangePort) annotation (
     Line(points={{-49,16},{-44,16},{-44,32},{-16.8,32}},      color={0,0,127}));
  connect(prescribedHeatFlowRad.port, heatStarToComb.portRad) annotation (Line(points={{-48,-10},
          {-46,-10},{-46,-8.25},{-44,-8.25}},                                                                                          color={191,0,0}));
  connect(adiabaticRadRooms.y, prescribedHeatFlowRad.Q_flow)
    annotation (Line(points={{-73.2,-10},{-60,-10}}, color={0,0,127}));
  connect(fixedHeatFlowAttic[1].port, heatStarToComb[1].portConv) annotation (Line(points={{-52,-21},
          {-50,-21},{-50,-15.75},{-44,-15.75}},                                                                                            color={191,0,0}));
  connect(m_flow_specification1.ports[1], underfloorHeatingSystem.port_a)
    annotation (Line(points={{-82,-58},{-76,-58},{-76,-59},{-68,-59}}, color={0,
          127,255}));
  connect(underfloorHeatingSystem.T_FlowNominal, m_flow_specification1.T_in)
    annotation (Line(points={{-68,-65.3},{-78,-65.3},{-78,-66},{-110,-66},{-110,
          -54.8},{-99.6,-54.8}}, color={0,0,127}));
  connect(underfloorHeatingSystem.port_b, boundary.ports[1]) annotation (Line(
        points={{-44,-59},{-44,-58},{-24,-58}}, color={0,127,255}));
  connect(const.y, underfloorHeatingSystem.valveInput) annotation (Line(points={{-79.4,
          -36},{-63.68,-36},{-63.68,-51.0667}},        color={0,0,127}));
          for i in 1:dis loop
  connect(underfloorHeatingSystem.heatFloor[i], wholeHouseBuildingEnvelope.groFloDown[3*dis+i])
    annotation (Line(points={{-56,-52},{-54,-52},{-54,-44},{-22,-44},{-22,2.32},
          {-14,2.32}}, color={191,0,0}));
  connect(underfloorHeatingSystem.heatCeiling[i], wholeHouseBuildingEnvelope.groPlateUp[4])
    annotation (Line(points={{-56,-66},{-56,-70},{-4,-70},{-4,-30},{-14,-30},{-14,
            -3.28}},
                  color={191,0,0}));
  connect(underfloorHeatingSystem.heatFloor[dis+i], wholeHouseBuildingEnvelope.groFloDown[i])
    annotation (Line(points={{-56,-52},{-54,-52},{-54,-44},{-22,-44},{-22,2.32},
          {-14,2.32}}, color={191,0,0}));
  connect(underfloorHeatingSystem.heatCeiling[dis+i], wholeHouseBuildingEnvelope.groPlateUp[1])
    annotation (Line(points={{-56,-66},{-56,-70},{-4,-70},{-4,-30},{-14,-30},{-14,
            -6.64}},
                  color={191,0,0}));
  connect(underfloorHeatingSystem.heatFloor[2*dis+i], wholeHouseBuildingEnvelope.groFloDown[dis+i])
    annotation (Line(points={{-56,-52},{-54,-52},{-54,-44},{-22,-44},{-22,2.32},
          {-14,2.32}}, color={191,0,0}));
  connect(underfloorHeatingSystem.heatCeiling[2*dis+i], wholeHouseBuildingEnvelope.groPlateUp[2])
    annotation (Line(points={{-56,-66},{-56,-70},{-4,-70},{-4,-30},{-14,-30},{-14,
            -5.52}},
                  color={191,0,0}));
  connect(underfloorHeatingSystem.heatFloor[3*dis+i], wholeHouseBuildingEnvelope.groFloDown[2*dis+i])
    annotation (Line(points={{-56,-52},{-54,-52},{-54,-44},{-22,-44},{-22,2.32},
          {-14,2.32}}, color={191,0,0}));
  connect(underfloorHeatingSystem.heatCeiling[3*dis+i], wholeHouseBuildingEnvelope.groPlateUp[3])
    annotation (Line(points={{-56,-66},{-56,-70},{-4,-70},{-4,-30},{-14,-30},{-14,
          -4.4}}, color={191,0,0}));
  connect(underfloorHeatingSystem.heatFloor[4*dis+i], wholeHouseBuildingEnvelope.groFloDown[4*dis+i])
    annotation (Line(points={{-56,-52},{-54,-52},{-54,-44},{-22,-44},{-22,2.32},
          {-14,2.32}}, color={191,0,0}));
  connect(underfloorHeatingSystem.heatCeiling[4*dis+i], wholeHouseBuildingEnvelope.groPlateUp[5])
    annotation (Line(points={{-56,-66},{-56,-70},{-4,-70},{-4,-30},{-14,-30},{-14,
            -2.16}},
                  color={191,0,0}));
  connect(underfloorHeatingSystem.heatFloor[5*dis+i], wholeHouseBuildingEnvelope.uppFloDown[i])
    annotation (Line(points={{-56,-52},{-54,-52},{-54,-44},{-22,-44},{-22,24.72},
          {-14,24.72}}, color={191,0,0}));
  connect(wholeHouseBuildingEnvelope.groFloUp[i], underfloorHeatingSystem.heatCeiling[5*dis+i])
    annotation (Line(points={{-14,18},{-18,18},{-18,-30},{-4,-30},{-4,-70},{-44,
          -70},{-44,-66},{-56,-66}}, color={191,0,0}));
  connect(underfloorHeatingSystem.heatFloor[6*dis+i], wholeHouseBuildingEnvelope.uppFloDown[dis+i])
    annotation (Line(points={{-56,-52},{-54,-52},{-54,-44},{-22,-44},{-22,24.72},
          {-14,24.72}}, color={191,0,0}));
  connect(wholeHouseBuildingEnvelope.groFloUp[dis+i], underfloorHeatingSystem.heatCeiling[6*dis+i])
    annotation (Line(points={{-14,18},{-18,18},{-18,-30},{-4,-30},{-4,-70},{-44,
          -70},{-44,-66},{-56,-66}}, color={191,0,0}));
  connect(underfloorHeatingSystem.heatFloor[7*dis+i], wholeHouseBuildingEnvelope.uppFloDown[2*dis+i])
    annotation (Line(points={{-56,-52},{-54,-52},{-54,-44},{-22,-44},{-22,24.72},
          {-14,24.72}}, color={191,0,0}));
  connect(wholeHouseBuildingEnvelope.groFloUp[2*dis+i], underfloorHeatingSystem.heatCeiling[7*dis+i])
    annotation (Line(points={{-14,18},{-18,18},{-18,-30},{-4,-30},{-4,-70},{-44,
          -70},{-44,-66},{-56,-66}}, color={191,0,0}));
  connect(underfloorHeatingSystem.heatFloor[8*dis+i], wholeHouseBuildingEnvelope.uppFloDown[3*dis+i])
    annotation (Line(points={{-56,-52},{-54,-52},{-54,-44},{-22,-44},{-22,24.72},
          {-14,24.72}}, color={191,0,0}));
  connect(wholeHouseBuildingEnvelope.groFloUp[3*dis+i], underfloorHeatingSystem.heatCeiling[8*dis+i])
    annotation (Line(points={{-14,18},{-18,18},{-18,-30},{-4,-30},{-4,-70},{-44,
          -70},{-44,-66},{-56,-66}}, color={191,0,0}));
  connect(underfloorHeatingSystem.heatFloor[9*dis+i], wholeHouseBuildingEnvelope.uppFloDown[4*dis+i])
    annotation (Line(points={{-56,-52},{-54,-52},{-54,-44},{-22,-44},{-22,24.72},
          {-14,24.72}}, color={191,0,0}));
  connect(wholeHouseBuildingEnvelope.groFloUp[4*dis+i], underfloorHeatingSystem.heatCeiling[9*dis+i])
    annotation (Line(points={{-14,18},{-18,18},{-18,-30},{-4,-30},{-4,-70},{-44,
          -70},{-44,-66},{-56,-66}}, color={191,0,0}));
          end for;
  connect(underfloorHeatingSystem.m_flowNominal, m_flow_specification1.m_flow_in)
    annotation (Line(points={{-68,-63.2},{-74,-63.2},{-74,-64},{-118,-64},{-118,
          -51.6},{-99.6,-51.6}}, color={0,0,127}));
  annotation (experiment(StartTime = 0, StopTime = 25920000, Interval=3600, Tolerance=1e-6, Algorithm="dassl"),
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/ThermalZones/HighOrder/Examples/OFDHeatLoad.mos"
                      "Simulate and plot"),
    Diagram(graphics={
        Text(
          extent={{-112,26},{-74,4}},
          lineColor={28,108,200},
          textString="DIN EN 12831 Beiblatt 1
Table 8"),
        Text(
          extent={{-94,-80},{-56,-102}},
          lineColor={28,108,200},
          textString="DIN EN 12831 Beiblatt 1
Table 1 \\theta'_m,e and see
Calculation example: Chapter 6.1.3.4"),
        Text(
          extent={{-112,90},{-74,68}},
          lineColor={28,108,200},
          textString="DIN EN 12831 Beiblatt 1
Table 1")}), experiment(StopTime=25920000, Interval=3600),
    Documentation(revisions="<html><ul>
  <li>
    <i>August 1, 2017</i> by Philipp Mehrfeld:<br/>
    Implement example
  </li>
</ul>
</html>"));
end OFD_UFH;
