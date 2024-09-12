within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Examples.OFD;
model OFD_UFH_WODis "Test environment for OFD with underfloor heating system"
  extends Modelica.Icons.Example;

  parameter Integer nZones = 11;
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
  parameter Integer dis=1;
  parameter Modelica.Units.SI.Distance Spacing[nHeatedRooms] = fill(0.2, 10);
  parameter Modelica.Units.SI.Diameter dOut[nHeatedRooms] = fill(0.017, 10);
  parameter Modelica.Units.SI.Diameter d[nHeatedRooms] = fill(0.018, 10);
  Modelica.Blocks.Sources.Constant constAirEx[nZones](k={0.5,0.5,0,0.5,0.5,0.5,0.5,0,0.5,0.5,0}) "1: LivingRoom_GF, 2: Hobby_GF, 3: Corridor_GF, 4: WC_Storage_GF, 5: Kitchen_GF, 6: Bedroom_UF, 7: Child1_UF, 8: Corridor_UF, 9: Bath_UF, 10: Child2_UF, 11: Attic" annotation (Placement(transformation(extent={{-70,6},{-50,26}})));
  Modelica.Blocks.Sources.Constant constWind(k=0)
    annotation (Placement(transformation(extent={{-70,36},{-50,56}})));
  Modelica.Blocks.Sources.Constant constAmb(k=261.15)
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow    groundTemp[5](Q_flow=
        fill(0, 5))
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=180,
        origin={64,-70})));
  AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort heatStarToComb[nZones]
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
  ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope.WholeHouseBuildingEnvelope
    wholeHouseBuildingEnvelope(
    use_UFH=true,
    redeclare BaseClasses.FloorLayers.EnEV2009Heavy_UFH wallTypes,
    energyDynamicsWalls=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T0_air=294.15,
    TWalls_start=292.15,
    calcMethodIn=1,
    redeclare model WindowModel =
        ThermalZones.HighOrder.Components.WindowsDoors.WindowSimple,
    redeclare AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009
      Type_Win,
    redeclare model CorrSolarGainWin =
        ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorGSimple,
    use_infiltEN12831=true,
    n50=if TIR == 1 or TIR == 2 then 3 else if TIR == 3 then 4 else 6,
    AirExchangeCorridor=0,
    UValOutDoors=if TIR == 1 then 1.8 else 2.9)
    annotation (Placement(transformation(extent={{-14,-10},{42,46}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowRad[nZones] annotation (Placement(transformation(extent={{-60,-16},
            {-48,-4}})));
  Modelica.Blocks.Sources.Constant adiabaticRadRooms[nZones](k=fill(0, nZones)) "1: LivingRoom_GF, 2: Hobby_GF, 3: Corridor_GF, 4: WC_Storage_GF, 5: Kitchen_GF, 6: Bedroom_UF, 7: Child1_UF, 8: Corridor_UF, 9: Bath_UF, 10: Child2_UF, 11: Attic" annotation (Placement(transformation(extent={{-90,-18},
            {-74,-2}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlowAttic[1](Q_flow={0}) annotation (Placement(transformation(extent={{-62,-26},
            {-52,-16}})));
  UnderfloorHeating.UnderfloorHeatingSystem underfloorHeatingSystem(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=0.1,
    thicknessSheathing=0.005,
    sheathingMaterial(lambda=0.15),
    nZones=10,
    dis=dis,
    Q_flow_nominal={638,1078,502,341,783,766,506,196,443,658},
    A={
    wholeHouseBuildingEnvelope.groundFloor_Building.WC_Storage.room_length*wholeHouseBuildingEnvelope.groundFloor_Building.WC_Storage.room_width,
    wholeHouseBuildingEnvelope.groundFloor_Building.Livingroom.room_length*wholeHouseBuildingEnvelope.groundFloor_Building.Livingroom.room_width,
    wholeHouseBuildingEnvelope.groundFloor_Building.Hobby.room_length*wholeHouseBuildingEnvelope.groundFloor_Building.Hobby.room_width,
    wholeHouseBuildingEnvelope.groundFloor_Building.Corridor.room_length*wholeHouseBuildingEnvelope.groundFloor_Building.Corridor.room_width,
    wholeHouseBuildingEnvelope.groundFloor_Building.Kitchen.room_length*wholeHouseBuildingEnvelope.groundFloor_Building.Kitchen.room_width,
    wholeHouseBuildingEnvelope.upperFloor_Building.Bedroom.room_length*wholeHouseBuildingEnvelope.upperFloor_Building.Bedroom.room_width_long,
    wholeHouseBuildingEnvelope.upperFloor_Building.Children1.room_length*wholeHouseBuildingEnvelope.upperFloor_Building.Children1.room_width_long,
    wholeHouseBuildingEnvelope.upperFloor_Building.Corridor.room_length*wholeHouseBuildingEnvelope.upperFloor_Building.Corridor.room_width_long,
    wholeHouseBuildingEnvelope.upperFloor_Building.Bath.room_length*wholeHouseBuildingEnvelope.upperFloor_Building.Bath.room_width_long,
    wholeHouseBuildingEnvelope.upperFloor_Building.Children2.room_length*wholeHouseBuildingEnvelope.upperFloor_Building.Children2.room_width_long},
    calculateVol=2,
    use_vmax=1,
    wallTypeFloor=fill(
        BaseClasses.FloorLayers.FLpartition_EnEV2009_SM_upHalf_UFH(), 10),
    Ceiling={false,false,false,false,false,true,true,true,true,true},
    wallTypeCeiling={
        UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy(),
        UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy(),
        UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy(),
        UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy(),
        UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy(),
        wholeHouseBuildingEnvelope.groundFloor_Building.Livingroom.wallTypes.IW_hori_low_half,
        wholeHouseBuildingEnvelope.groundFloor_Building.Hobby.wallTypes.IW_hori_low_half,
        wholeHouseBuildingEnvelope.groundFloor_Building.Corridor.wallTypes.IW_hori_low_half,
        wholeHouseBuildingEnvelope.groundFloor_Building.WC_Storage.wallTypes.IW_hori_low_half,
        wholeHouseBuildingEnvelope.groundFloor_Building.Kitchen.wallTypes.IW_hori_low_half},
    TZoneBel_nominal={293.15,293.15,293.15,293.15,293.15,293.15,293.15,293.15,
        293.15,293.15},
    Spacing=fill(0.2, 10),
    pipeMaterial=BaseClasses.PipeMaterials.PERTpipe(),
    thicknessPipe=fill(0.002, 10),
    dOut=fill(0.017, 10),
    withSheathing=true,
    ufhRoom(
      thicknessSheathing=0.005,
            TSup_nominal(displayUnit="K") = 308.15, TRet_nominal(
            displayUnit="K") = 303.15,
      circuits(thicknessSheathing=0.005, length=80),
      EN_1264(sheathingMaterial={
            AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Sheathing_Materials.SheathingMaterialDefinition(
            lambda=0.15),
            AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Sheathing_Materials.SheathingMaterialDefinition(
            lambda=0.15),
            AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Sheathing_Materials.SheathingMaterialDefinition(
            lambda=0.15),
            AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Sheathing_Materials.SheathingMaterialDefinition(
            lambda=0.15),
            AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Sheathing_Materials.SheathingMaterialDefinition(
            lambda=0.15),
            AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Sheathing_Materials.SheathingMaterialDefinition(
            lambda=0.15),
            AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Sheathing_Materials.SheathingMaterialDefinition(
            lambda=0.15),
            AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Sheathing_Materials.SheathingMaterialDefinition(
            lambda=0.15),
            AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Sheathing_Materials.SheathingMaterialDefinition(
            lambda=0.15),
            AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Sheathing_Materials.SheathingMaterialDefinition(
            lambda=0.15)}, pipeMaterial={
            AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PipeMaterials.PipeMaterialDefinition(
            lambda=0.22),
            AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PipeMaterials.PipeMaterialDefinition(
            lambda=0.22),
            AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PipeMaterials.PipeMaterialDefinition(
            lambda=0.22),
            AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PipeMaterials.PipeMaterialDefinition(
            lambda=0.22),
            AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PipeMaterials.PipeMaterialDefinition(
            lambda=0.22),
            AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PipeMaterials.PipeMaterialDefinition(
            lambda=0.22),
            AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PipeMaterials.PipeMaterialDefinition(
            lambda=0.22),
            AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PipeMaterials.PipeMaterialDefinition(
            lambda=0.22),
            AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PipeMaterials.PipeMaterialDefinition(
            lambda=0.22),
            AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PipeMaterials.PipeMaterialDefinition(
            lambda=0.22)})))
    annotation (Placement(transformation(extent={{-68,-66},{-50,-50}})));

  AixLib.Fluid.Sources.MassFlowSource_T m_flow_specification1(
    redeclare package Medium = AixLib.Media.Water,
    m_flow=underfloorHeatingSystem.m_flow_nominal,
    T=underfloorHeatingSystem.T_Vdes,
    nPorts=1)
    annotation (Placement(transformation(extent={{-98,-66},{-82,-50}})));
  AixLib.Fluid.Sources.Boundary_pT boundary(redeclare package Medium =
        AixLib.Media.Water, nPorts=1)
    annotation (Placement(transformation(extent={{-12,-64},{-24,-52}})));
  Modelica.Blocks.Sources.Constant const[underfloorHeatingSystem.nZones](each k
      =1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-86,-36})));
  RadConvToSingle radConvToSingleCeiling[5]
    annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
  RadConvToSingle radConvToSingleFloor[10]
    annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
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
    annotation (Line(points={{-28,64},{-14.56,64},{-14.56,46}}, color={191,0,0}));
  connect(varRad.solarRad_out[1], wholeHouseBuildingEnvelope.North) annotation (
     Line(points={{51,69.5833},{48,69.5833},{48,28.64},{43.68,28.64}},color={
          255,128,0}));
  connect(varRad.solarRad_out[2], wholeHouseBuildingEnvelope.East) annotation (
      Line(points={{51,69.75},{48,69.75},{48,21.36},{43.68,21.36}},
                                                                 color={255,128,
          0}));
  connect(varRad.solarRad_out[3], wholeHouseBuildingEnvelope.South) annotation (
     Line(points={{51,69.9167},{48,69.9167},{48,14.08},{43.68,14.08}},
                                                                    color={255,
          128,0}));
  connect(varRad.solarRad_out[4], wholeHouseBuildingEnvelope.West) annotation (
      Line(points={{51,70.0833},{48,70.0833},{48,7.36},{43.68,7.36}},color={255,
          128,0}));
  connect(varRad.solarRad_out[5], wholeHouseBuildingEnvelope.SolarRadiationPort_RoofN)
    annotation (Line(points={{51,70.25},{48,70.25},{48,43.2},{43.68,43.2}},
                                                                         color=
          {255,128,0}));
  connect(varRad.solarRad_out[6], wholeHouseBuildingEnvelope.SolarRadiationPort_RoofS)
    annotation (Line(points={{51,70.4167},{48,70.4167},{48,35.92},{43.68,35.92}},
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
    annotation (Line(points={{-82,-58},{-76,-58},{-76,-58.8889},{-68,-58.8889}},
                                                                       color={0,
          127,255}));
  connect(underfloorHeatingSystem.port_b, boundary.ports[1]) annotation (Line(
        points={{-50,-58.8889},{-50,-58},{-24,-58}},
                                                color={0,127,255}));
  connect(const.y, underfloorHeatingSystem.uVal) annotation (Line(points={{-79.4,
          -36},{-69.8,-36},{-69.8,-53.5556}},       color={0,0,127}));

  for i in 1:5 loop
  connect(groundTemp[i].port, underfloorHeatingSystem.portConCei[i]) annotation (Line(
        points={{58,-70},{48,-70},{48,-68},{-52,-68},{-52,-67.7778},{-55.4,
            -67.7778}},                                                   color
        ={191,0,0}));
  connect(groundTemp[i].port, underfloorHeatingSystem.portRadCei[i]) annotation (Line(
        points={{58,-70},{48,-70},{48,-74},{-62.6,-74},{-62.6,-67.7778}},
                                                                        color={191,
          0,0}));
    connect(radConvToSingleCeiling[i].heatFloor, wholeHouseBuildingEnvelope.heatingToRooms[5+i]) annotation (Line(points={{30,-90},
            {32,-90},{32,-46},{-4,-46},{-4,-22},{-22,-22},{-22,9.90545},{-14,
            9.90545}},            color={191,0,0}));
  connect(radConvToSingleCeiling[i].portCon, underfloorHeatingSystem.portConCei[
    5+i]) annotation (Line(points={{10,-84},{-55.4,-84},{-55.4,-67.8222}}, color={
          191,0,0}));
  connect(radConvToSingleCeiling[i].portRad, underfloorHeatingSystem.portRadCei[
    5+i]) annotation (Line(points={{10,-96.2},{-62.6,-96.2},{-62.6,-67.8222}},
                      color={191,0,0}));

  end for;


  connect(underfloorHeatingSystem.portConFloor, radConvToSingleFloor.portCon)
    annotation (Line(points={{-55.4,-50},{-52,-50},{-52,-24},{10,-24}}, color={191,
          0,0}));
  connect(radConvToSingleFloor.portRad, underfloorHeatingSystem.portRadFloor)
    annotation (Line(points={{10,-36.2},{-62.6,-36.2},{-62.6,-50}}, color={191,0,
          0}));
  for i in 1:nZones-1 loop
    connect(radConvToSingleFloor[i].heatFloor, wholeHouseBuildingEnvelope.heatingToRooms[
    i]) annotation (Line(points={{30,-30},{52,-30},{52,-16.08},{-20,-16.08},{
            -20,10.16},{-14,10.16}},
                          color={191,0,0}));
  end for;
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
end OFD_UFH_WODis;
