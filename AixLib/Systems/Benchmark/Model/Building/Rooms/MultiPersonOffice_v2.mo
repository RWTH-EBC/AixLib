within AixLib.Systems.Benchmark.Model.Building.Rooms;
model MultiPersonOffice_v2
  extends AixLib.Systems.Benchmark.Model.Building.Rooms.BaseRoom
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
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
    withDoor=true,
    wall_length=30,
    T0=293.15) annotation (Placement(transformation(
        extent={{3.99999,-24},{-4.00002,24}},
        rotation=0,
        origin={80,-30})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToOpenPlanOffice
    annotation (Placement(transformation(extent={{90,-40},{110,-20}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 SouthWall(
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
        extent={{3.99999,-24},{-4.00002,24}},
        rotation=-90,
        origin={50,-70})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 FloorToGround(
    solar_absorptance=0.48,
    withWindow=false,
    windowarea=60,
    withSunblind=false,
    withDoor=false,
    outside=false,
    ISOrientation=2,
    wall_length=20,
    wall_height=5,
    WallType=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=90,
        origin={-50,-70})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={14,-80})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToGround
    annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_SouthWall annotation (
      Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=-90,
        origin={60,-100})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_SouthWall annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={90,-110})));
equation
  connect(WallsToOpenPlanOffice.port_outside,HeatPort_ToOpenPlanOffice)
    annotation (Line(points={{84.2,-30},{100,-30}},
                                                  color={191,0,0}));
  connect(WallsToOpenPlanOffice.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{76,-30},{50,-30},{50,-52},{-10.125,-52},{-10.125,
          -39.22}},            color={191,0,0}));
  connect(FloorToGround.port_outside,HeatPort_ToGround)
    annotation (Line(points={{-50,-74.2},{-50,-100}}, color={191,0,0}));
  connect(SouthWall.SolarRadiationPort,SolarRadiationPort_SouthWall)
    annotation (Line(points={{72,-75.2},{72,-80},{90,-80},{90,-110}},
                                                                    color={255,
          128,0}));
  connect(SouthWall.WindSpeedPort,WindSpeedPort_SouthWall)  annotation (Line(
        points={{67.6,-74.2},{67.6,-80},{60,-80},{60,-100}}, color={0,0,127}));
  connect(prescribedTemperature.port,SouthWall. port_outside)
    annotation (Line(points={{20,-80},{50,-80},{50,-74.2}},
                                                   color={191,0,0}));
  connect(prescribedTemperature.T, measureBus.AirTemp) annotation (Line(points={{6.8,-80},
          {0,-80},{0,-52},{-50,-52},{-50,-59.9},{-99.9,-59.9}},
                   color={0,0,127}));
  connect(FloorToGround.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-50,-66},{-50,-52},{-10.125,-52},{-10.125,-39.22}},
        color={191,0,0}));
  connect(SouthWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{50,-66},{50,-52},{-10.125,-52},{-10.125,-39.22}},
        color={191,0,0}));
end MultiPersonOffice_v2;
