within AixLib.Systems.Benchmark.Model.Building.Rooms;
model Workshop_v2
  extends AixLib.Systems.Benchmark.Model.Building.Rooms.BaseRoom(
      activeWallPipeBased(
      wall_length=30,
      wall_height=30,
      solar_absorptance=0.24,
      T0=288.15), vol(V=2700, T_start=288.15))
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall EastWallToCanteen(
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
    wall_length=30,
    withDoor=true,
    T0=288.15) annotation (Placement(transformation(
        extent={{3.99999,-24},{-4.00002,24}},
        rotation=0,
        origin={70,-30})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToCanteen
    annotation (Placement(transformation(extent={{90,-40},{110,-20}})));
 AixLib.ThermalZones.HighOrder.Components.Walls.Wall SouthWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    windowarea=60,
    withSunblind=false,
    withDoor=false,
    wall_length=30,
    T0=288.15) annotation (Placement(transformation(
        extent={{-3.99999,24},{4.00002,-24}},
        rotation=90,
        origin={-50,-70})));
 AixLib.ThermalZones.HighOrder.Components.Walls.Wall FloorToGround(
    solar_absorptance=0.48,
    withWindow=false,
    redeclare model Window =
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.Window_ASHRAE140,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    windowarea=60,
    withSunblind=false,
    withDoor=false,
    outside=false,
    wall_length=30,
    ISOrientation=2,
    WallType=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    wall_height=30,
    T0=288.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=90,
        origin={50,-70})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-66,-88})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToGround
    annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_SouthWall annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,-110})));
 AixLib.ThermalZones.HighOrder.Components.Walls.Wall NorthWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    windowarea=60,
    withSunblind=false,
    withDoor=false,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    wall_length=30,
    T0(displayUnit="degC") = 288.15)
               annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=-90,
        origin={-50,60})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_NorthWall annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-10,110})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_NorthWall annotation (
      Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={-40,100})));
 AixLib.ThermalZones.HighOrder.Components.Walls.Wall WestWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    withSunblind=false,
    withDoor=false,
    wall_length=30,
    windowarea=60,
    T0=288.15) annotation (Placement(transformation(
        extent={{3.99999,-24},{-4.00002,24}},
        rotation=180,
        origin={-70,0})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature2
                          annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-90,30})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_WestWall annotation (
      Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=180,
        origin={-100,0})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_WestWall annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,-30})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature3
                          annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-66,90})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_SouthWall annotation (
      Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=-90,
        origin={-40,-100})));
equation
  connect(EastWallToCanteen.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{66,-30},{50,-30},{50,-52},{-10.125,-52},{-10.125,
          -39.22}},color={191,0,0}));
  connect(HeatPort_ToCanteen,EastWallToCanteen. port_outside) annotation (Line(
        points={{100,-30},{74.2,-30}},                   color={191,0,0}));
  connect(FloorToGround.port_outside,HeatPort_ToGround)
    annotation (Line(points={{50,-74.2},{50,-100}}, color={191,0,0}));
  connect(SouthWall.SolarRadiationPort,SolarRadiationPort_SouthWall)
    annotation (Line(points={{-28,-75.2},{-28,-80},{-10,-80},{-10,-110}}, color=
         {255,128,0}));
  connect(SouthWall.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{-50,-66},{-50,-52},{-10.125,-52},{-10.125,-39.22}},
        color={191,0,0}));
  connect(FloorToGround.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{50,-66},{50,-52},{-10.125,-52},{-10.125,-39.22}},
        color={191,0,0}));
  connect(prescribedTemperature.port,SouthWall. port_outside)
    annotation (Line(points={{-60,-88},{-50,-88},{-50,-74.2}},
                                                     color={191,0,0}));
  connect(prescribedTemperature.T, measureBus.AirTemp) annotation (Line(points={{-73.2,
          -88},{-80,-88},{-80,-59.9},{-99.9,-59.9}},
                                           color={0,0,127}));
  connect(NorthWall.SolarRadiationPort,SolarRadiationPort_NorthWall)
    annotation (Line(points={{-28,65.2},{-28,80},{-10,80},{-10,110}},
                                                                    color={255,
          128,0}));
  connect(NorthWall.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{-50,56},{-50,-52},{-10.125,-52},{-10.125,-39.22}},
                         color={191,0,0}));
  connect(NorthWall.WindSpeedPort,WindSpeedPort_NorthWall)  annotation (Line(
        points={{-32.4,64.2},{-32.4,80},{-40,80},{-40,100}}, color={0,0,127}));
  connect(WestWall.WindSpeedPort,WindSpeedPort_WestWall)  annotation (Line(
        points={{-74.2,-17.6},{-88,-17.6},{-88,4.44089e-16},{-100,4.44089e-16}},
                                                                 color={0,0,127}));
  connect(WestWall.SolarRadiationPort,SolarRadiationPort_WestWall)  annotation (
     Line(points={{-75.2,-22},{-90,-22},{-90,-30},{-110,-30}},
                                                           color={255,128,0}));
  connect(WestWall.thermStarComb_inside,thermStar_Demux. thermStarComb)
    annotation (Line(points={{-66,-4.44089e-16},{-50,-4.44089e-16},{-50,-52},{
          -10.125,-52},{-10.125,-39.22}},
        color={191,0,0}));
  connect(prescribedTemperature2.port,WestWall. port_outside) annotation (Line(
        points={{-84,30},{-80,30},{-80,0},{-78,0},{-78,4.44089e-16},{-74.2,4.44089e-16}},
                                                      color={191,0,0}));
  connect(prescribedTemperature2.T, measureBus.AirTemp) annotation (Line(points={{-97.2,
          30},{-100,30},{-100,48},{-50,48},{-50,-59.9},{-99.9,-59.9}},
        color={0,0,127}));
  connect(prescribedTemperature3.T, measureBus.AirTemp) annotation (Line(points={{-73.2,
          90},{-80,90},{-80,48},{-50,48},{-50,-60},{-80,-60},{-80,-59.9},{-99.9,
          -59.9}}, color={0,0,127}));
  connect(NorthWall.port_outside, prescribedTemperature3.port)
    annotation (Line(points={{-50,64.2},{-50,90},{-60,90}}, color={191,0,0}));
  connect(SouthWall.WindSpeedPort,WindSpeedPort_SouthWall)  annotation (Line(
        points={{-32.4,-74.2},{-32.4,-74},{-32,-74},{-32,-80},{-40,-80},{-40,-100}},
                                                                 color={0,0,127}));
end Workshop_v2;
