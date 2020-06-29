within AixLib.Systems.Benchmark.Model.Building.Rooms;
model ConferenceRoom_v2
  extends AixLib.Systems.Benchmark.Model.Building.Rooms.BaseRoom(vol(V=150),
      activeWallPipeBased(wall_length=5, wall_height=10));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 FloorToWorkshop(
    solar_absorptance=0.48,
    withWindow=false,
    windowarea=60,
    withSunblind=false,
    withDoor=false,
    outside=false,
    ISOrientation=2,
    wall_length=10,
    wall_height=5,
    WallType=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=90,
        origin={-50,-70})));
 AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 WallsToOpenPlanOffice(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=false,
    windowarea=60,
    withSunblind=false,
    outside=false,
    door_height=2.125,
    door_width=1,
    WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
    wall_length=20,
    withDoor=true,
    T0=293.15) annotation (Placement(transformation(
        extent={{3.99999,-24},{-4.00002,24}},
        rotation=-90,
        origin={50,-70})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToGround
    annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToOpenPlanOffice
    annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 NorthWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    WindowType=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    withSunblind=false,
    withDoor=false,
    wall_length=10,
    windowarea=20,
    T0=293.15) annotation (Placement(transformation(
        extent={{3.99999,24},{-4.00002,-24}},
        rotation=90,
        origin={-50,60})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_NorthWall annotation (
      Placement(transformation(
        extent={{12,12},{-12,-12}},
        rotation=90,
        origin={-32,100})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_NorthWall annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,110})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature2
                          annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-50,90})));
equation
  connect(FloorToWorkshop.port_outside,HeatPort_ToGround)  annotation (Line(
        points={{-50,-74.2},{-50,-100}},
        color={191,0,0}));
  connect(FloorToWorkshop.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{-50,-66},{-50,-52},{-10.125,-52},{-10.125,-39.22}},
        color={191,0,0}));
  connect(WallsToOpenPlanOffice.port_outside,HeatPort_ToOpenPlanOffice)
    annotation (Line(points={{50,-74.2},{50,-100}}, color={191,0,0}));
  connect(WallsToOpenPlanOffice.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{50,-66},{50,-52},{-10.125,-52},{-10.125,-39.22}},
                   color={191,0,0}));
  connect(NorthWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-50,56},{-50,-40},{-10.125,-40},{-10.125,-39.22}},
        color={191,0,0}));
  connect(prescribedTemperature2.port,NorthWall. port_outside)
    annotation (Line(points={{-50,84},{-50,64.2}}, color={191,0,0}));
  connect(NorthWall.WindSpeedPort, WindSpeedPort_NorthWall) annotation (Line(
        points={{-32.4,64.2},{-32.4,80},{-32,80},{-32,100}}, color={0,0,127}));
  connect(prescribedTemperature2.T, measureBus.AirTemp) annotation (Line(points={{-50,
          97.2},{-50,98},{-60,98},{-60,80},{-10,80},{-10,48},{-50,48},{-50,
          -59.9},{-99.9,-59.9}},
        color={0,0,127}));
  connect(NorthWall.SolarRadiationPort, SolarRadiationPort_NorthWall)
    annotation (Line(points={{-28,65.2},{-28,80},{-10,80},{-10,110}},
                                  color={255,128,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ConferenceRoom_v2;
