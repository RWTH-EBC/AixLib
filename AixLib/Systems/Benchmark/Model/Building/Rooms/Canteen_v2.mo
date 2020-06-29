within AixLib.Systems.Benchmark.Model.Building.Rooms;
model Canteen_v2
  extends AixLib.Systems.Benchmark.Model.Building.Rooms.BaseRoom(vol(V=1800),
      activeWallPipeBased(wall_height=30, solar_absorptance=0.24));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall EastWallToOpenplanoffice(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=false,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    withSunblind=false,
    withDoor=true,
    wall_length=30,
    windowarea=60,
    outside=false,
    WallType=DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=180,
        origin={70,-30})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToOpenplanoffice
    annotation (Placement(transformation(extent={{90,-40},{110,-20}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall FloorToGround(
    solar_absorptance=0.48,
    withWindow=false,
    redeclare model Window =
        AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140,
    WindowType=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    windowarea=60,
    withSunblind=false,
    withDoor=false,
    outside=false,
    wall_length=30,
    wall_height=20,
    ISOrientation=2,
    WallType=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=90,
        origin={50,-70})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToGround
    annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall SouthWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    WindowType=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    withSunblind=false,
    withDoor=false,
    wall_length=20,
    windowarea=40,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,24},{4.00002,-24}},
        rotation=90,
        origin={-50,-70})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=0,
        origin={-66,-88})));
  AixLib.Utilities.Interfaces.SolarRad_in SolarRadiationPort_SouthWall annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,-110})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_SouthWall annotation (
      Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=-90,
        origin={-40,-100})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall WestWallToWorkshop(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=false,
    redeclare model Window =
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.Window_ASHRAE140,
    WindowType=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
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
        origin={-70,0})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToWorkshop
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall NorthWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    withSunblind=false,
    withDoor=false,
    WindowType=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    T0(displayUnit="degC") = 293.15,
    wall_length=20,
    windowarea=40)
               annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=-90,
        origin={-50,60})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_NorthWall annotation (
      Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={-40,100})));
  AixLib.Utilities.Interfaces.SolarRad_in SolarRadiationPort_NorthWall annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-10,110})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature2
                          annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-66,90})));
equation
  connect(EastWallToOpenplanoffice.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{66,-30},{50,-30},{50,-52},{-10.125,-52},{-10.125,
          -39.22}},
        color={191,0,0}));
  connect(EastWallToOpenplanoffice.port_outside,HeatPort_ToOpenplanoffice)
    annotation (Line(points={{74.2,-30},{100,-30}},               color={191,0,
          0}));
  connect(FloorToGround.port_outside,HeatPort_ToGround)
    annotation (Line(points={{50,-74.2},{50,-100}}, color={191,0,0}));
  connect(FloorToGround.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{50,-66},{50,-52},{-10.125,-52},{-10.125,-39.22}},
        color={191,0,0}));
  connect(SouthWall.SolarRadiationPort,SolarRadiationPort_SouthWall)
    annotation (Line(points={{-28,-75.2},{-28,-80},{-10,-80},{-10,-110}}, color=
         {255,128,0}));
  connect(prescribedTemperature.port,SouthWall. port_outside)
    annotation (Line(points={{-60,-88},{-50,-88},{-50,-74.2}},
                                                     color={191,0,0}));
  connect(prescribedTemperature.T, measureBus.AirTemp) annotation (Line(points={{-73.2,
          -88},{-80,-88},{-80,-59.9},{-99.9,-59.9}},
                         color={0,0,127}));
  connect(SouthWall.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{-50,-66},{-50,-52},{-10.125,-52},{-10.125,-39.22}},
        color={191,0,0}));
  connect(SouthWall.WindSpeedPort,WindSpeedPort_SouthWall)  annotation (Line(
        points={{-32.4,-74.2},{-32.4,-80},{-40,-80},{-40,-100}}, color={0,0,127}));
  connect(WestWallToWorkshop.port_outside,HeatPort_ToWorkshop)
    annotation (Line(points={{-74.2,0},{-100,0}}, color={191,0,0}));
  connect(WestWallToWorkshop.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-66,0},{-50,0},{-50,-52},{-10.125,-52},{-10.125,
          -39.22}},
        color={191,0,0}));
  connect(NorthWall.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{-50,56},{-50,-52},{-10.125,-52},{-10.125,-39.22}},
                         color={191,0,0}));
  connect(NorthWall.WindSpeedPort,WindSpeedPort_NorthWall)  annotation (Line(
        points={{-32.4,64.2},{-32.4,80},{-40,80},{-40,100}}, color={0,0,127}));
  connect(prescribedTemperature2.port, NorthWall.port_outside)
    annotation (Line(points={{-60,90},{-50,90},{-50,64.2}}, color={191,0,0}));
  connect(prescribedTemperature2.T, measureBus.AirTemp) annotation (Line(points=
         {{-73.2,90},{-80,90},{-80,80},{-10,80},{-10,48},{-50,48},{-50,-59.9},{-99.9,
          -59.9}}, color={0,0,127}));
  connect(NorthWall.SolarRadiationPort,SolarRadiationPort_NorthWall)
    annotation (Line(points={{-28,65.2},{-28,80},{-10,80},{-10,110}},
                                                                    color={255,
          128,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Canteen_v2;
