within AixLib.Systems.Benchmark.Model.Building.Rooms;
model OpenPlanOffice_v2
  extends AixLib.Systems.Benchmark.Model.Building.Rooms.BaseRoom(vol(V=4050),
      activeWallPipeBased(wall_length=45, wall_height=30));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 FloorToGround(
    solar_absorptance=0.48,
    withWindow=false,
    windowarea=60,
    withSunblind=false,
    withDoor=false,
    outside=false,
    wall_length=30,
    ISOrientation=2,
    wall_height=45,
    WallType=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=90,
        origin={14,-80})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 WallToMultiPersonOffice(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=false,
    windowarea=60,
    withSunblind=false,
    outside=false,
    door_height=2.125,
    door_width=1,
    WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
    withDoor=true,
    wall_length=30,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=90,
        origin={70,-80})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToGround
    annotation (Placement(transformation(extent={{4,-110},{24,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    HeatPort_ToMultiPersonOffice
    annotation (Placement(transformation(extent={{60,-110},{80,-90}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 EastWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    withSunblind=false,
    withDoor=false,
    wall_length=30,
    windowarea=60,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=180,
        origin={70,-40})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature3
                          annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={82,-20})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_EastWall annotation (
      Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=180,
        origin={100,-40})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_EastWall annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-70})));
 AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 WallToConferenceRoom(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=false,
    windowarea=60,
    withSunblind=false,
    outside=false,
    door_height=2.125,
    door_width=1,
    WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
    withDoor=true,
    wall_length=20,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=0,
        origin={-70,20})));
 AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 WestWallToCanteen(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=false,
    windowarea=60,
    withSunblind=false,
    outside=false,
    door_height=2.125,
    door_width=1,
    WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
    withDoor=true,
    wall_length=30,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=0,
        origin={-70,-30})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToConferenceRoom
    annotation (Placement(transformation(extent={{-110,10},{-90,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToCanteen
    annotation (Placement(transformation(extent={{-110,-40},{-90,-20}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 SouthWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    withSunblind=false,
    withDoor=false,
    wall_length=30,
    windowarea=60,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,24},{4.00002,-24}},
        rotation=90,
        origin={-50,-70})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature2
                          annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=0,
        origin={-66,-88})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_SouthWall annotation (
      Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=-90,
        origin={-40,-100})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_SouthWall annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,-110})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 NorthWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    withSunblind=false,
    withDoor=false,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    T0(displayUnit="degC") = 293.15,
    wall_length=40,
    windowarea=80,
    Model=1)   annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=-90,
        origin={-50,60})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_NorthWall annotation (
      Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={-40,100})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_NorthWall annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-10,110})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=0,
        origin={-66,90})));
equation
  connect(FloorToGround.port_outside,HeatPort_ToGround)
    annotation (Line(points={{14,-84.2},{14,-100}}, color={191,0,0}));
  connect(FloorToGround.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{14,-76},{14,-52},{-10.125,-52},{-10.125,-39.22}},
        color={191,0,0}));
  connect(WallToMultiPersonOffice.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{70,-76},{60,-76},{60,-60},{50,-60},{50,-52},{-10,
          -52},{-10,-44},{-10.125,-44},{-10.125,-39.22}},
                          color={191,0,0}));
  connect(WallToMultiPersonOffice.port_outside,HeatPort_ToMultiPersonOffice)
    annotation (Line(points={{70,-84.2},{70,-100}}, color={191,0,0}));
  connect(EastWall.WindSpeedPort, WindSpeedPort_EastWall) annotation (Line(
        points={{74.2,-57.6},{76,-57.6},{76,-58},{100,-58},{100,-40}},
                                                                 color={0,0,127}));
  connect(EastWall.SolarRadiationPort, SolarRadiationPort_EastWall) annotation (
     Line(points={{75.2,-62},{90,-62},{90,-70},{110,-70}}, color={255,128,0}));
  connect(EastWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{66,-40},{50,-40},{50,-52},{-10,-52},{-10,-46},{
          -10.125,-46},{-10.125,-39.22}},
        color={191,0,0}));
  connect(prescribedTemperature3.port,EastWall. port_outside)
    annotation (Line(points={{82,-26},{82,-40},{74.2,-40}},
                                               color={191,0,0}));
  connect(prescribedTemperature3.T, measureBus.AirTemp) annotation (Line(points={{82,
          -12.8},{82,0},{50,0},{50,-52},{-50,-52},{-50,-59.9},{-99.9,-59.9}},
                                                                         color=
          {0,0,127}));
  connect(WallToConferenceRoom.port_outside,HeatPort_ToConferenceRoom)
    annotation (Line(points={{-74.2,20},{-100,20}},   color={191,0,0}));
  connect(WallToConferenceRoom.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-66,20},{-50,20},{-50,-52},{-10.125,-52},{-10.125,
          -39.22}},color={191,0,0}));
  connect(WestWallToCanteen.port_outside,HeatPort_ToCanteen)
    annotation (Line(points={{-74.2,-30},{-100,-30}},
                       color={191,0,0}));
  connect(WestWallToCanteen.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-66,-30},{-50,-30},{-50,-52},{-10.125,-52},{
          -10.125,-39.22}},
                   color={191,0,0}));
  connect(SouthWall.WindSpeedPort,WindSpeedPort_SouthWall)  annotation (Line(
        points={{-32.4,-74.2},{-32.4,-80},{-40,-80},{-40,-100}}, color={0,0,127}));
  connect(SouthWall.SolarRadiationPort,SolarRadiationPort_SouthWall)
    annotation (Line(points={{-28,-75.2},{-28,-92},{-10,-92},{-10,-110}}, color=
         {255,128,0}));
  connect(prescribedTemperature2.port,SouthWall. port_outside)
    annotation (Line(points={{-60,-88},{-50,-88},{-50,-74.2}},
                                                     color={191,0,0}));
  connect(prescribedTemperature2.T, measureBus.AirTemp) annotation (Line(points={{-73.2,
          -88},{-80,-88},{-80,-59.9},{-99.9,-59.9}},
                         color={0,0,127}));
  connect(SouthWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-50,-66},{-50,-52},{-10,-52},{-10,-40},{-10.125,
          -40},{-10.125,-39.22}},
                             color={191,0,0}));
  connect(NorthWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-50,56},{-50,-52},{-10.125,-52},{-10.125,-39.22}},
                         color={191,0,0}));
  connect(NorthWall.WindSpeedPort, WindSpeedPort_NorthWall) annotation (Line(
        points={{-32.4,64.2},{-32.4,80},{-40,80},{-40,100}}, color={0,0,127}));
  connect(prescribedTemperature.port,NorthWall. port_outside)
    annotation (Line(points={{-60,90},{-50,90},{-50,64.2}},
                                                   color={191,0,0}));
  connect(prescribedTemperature.T, measureBus.AirTemp) annotation (Line(points={
          {-73.2,90},{-80,90},{-80,80},{-10,80},{-10,48},{-50,48},{-50,-59.9},{-99.9,
          -59.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(NorthWall.SolarRadiationPort, SolarRadiationPort_NorthWall)
    annotation (Line(points={{-28,65.2},{-28,80},{-10,80},{-10,110}},
                                                                    color={255,
          128,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end OpenPlanOffice_v2;
