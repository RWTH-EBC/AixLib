within AixLib.Building.Benchmark.Rooms;
model OpenPlanOffice
  Components.Walls.Wall NorthWall(
    wall_length=40,
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    windowarea=60,
    withSunblind=false,
    withDoor=false,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    T0(displayUnit="degC") = 293.15)
               annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=-90,
        origin={-52,60})));
  Components.Walls.Wall SouthWall(
    wall_length=40,
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    windowarea=60,
    withSunblind=false,
    withDoor=false,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=90,
        origin={-52,-62})));
  Components.Walls.Wall WestWallToMultiPersonOffice(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    windowarea=60,
    withSunblind=false,
    outside=false,
    WallType=DataBase.Walls.EnEV2009.IW.IWneighbour_EnEV2009_S_half(),
    wall_length=20,
    withDoor=true,
    door_height=2.125,
    door_width=1,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=0,
        origin={-76,28})));
  Components.Walls.Wall EastWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    withSunblind=false,
    withDoor=false,
    wall_length=30,
    windowarea=45,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=180,
        origin={60,0})));
  Components.Walls.Wall WestWallToConferenceRoom(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    windowarea=60,
    withSunblind=false,
    outside=false,
    WallType=DataBase.Walls.EnEV2009.IW.IWneighbour_EnEV2009_S_half(),
    withDoor=true,
    door_height=2.125,
    door_width=1,
    wall_length=10,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=0,
        origin={-76,-28})));
  Components.Walls.Wall FloorToWorkshop(
    solar_absorptance=0.48,
    withWindow=true,
    redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    windowarea=60,
    withSunblind=false,
    withDoor=false,
    outside=false,
    WallType=DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf(),
    wall_length=30,
    wall_height=20,
    ISOrientation=2,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=90,
        origin={14,-62})));
  Components.Walls.Wall FloorToKitchen1(
    solar_absorptance=0.48,
    withWindow=true,
    redeclare model Window = Components.WindowsDoors.Window_ASHRAE140,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    windowarea=60,
    withSunblind=false,
    withDoor=false,
    outside=false,
    WallType=DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf(),
    wall_length=30,
    wall_height=20,
    ISOrientation=2,
    T0=293.15) annotation (Placement(transformation(
        extent={{-3.99999,-24},{4.00002,24}},
        rotation=90,
        origin={70,-62})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToKitchen
    annotation (Placement(transformation(extent={{60,-110},{80,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToWorkshop
    annotation (Placement(transformation(extent={{4,-110},{24,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToConferenceRoom
    annotation (Placement(transformation(extent={{-110,-38},{-90,-18}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    HeatPort_ToMultiPersonOffice
    annotation (Placement(transformation(extent={{-110,18},{-90,38}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_OutdoorTemp
    annotation (Placement(transformation(extent={{-62,90},{-42,110}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_EastWall annotation (
      Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=180,
        origin={104,-18})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_NorthWall annotation (
      Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={-20,104})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_SouthWall annotation (
      Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=-90,
        origin={-82,-106})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_NorthWall annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={10,110})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_EastWall annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-50})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_SouthWall annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-24,-110})));
  Components.DryAir.Airload                 airload(V=3600, T(start=293.15,
        displayUnit="degC"))                                                       annotation(Placement(transformation(extent={{2,-8},{
            22,12}})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation = 90, origin = {-20, -26})));
equation
  connect(FloorToKitchen1.port_outside, HeatPort_ToKitchen)
    annotation (Line(points={{70,-66.2},{70,-100}}, color={191,0,0}));
  connect(FloorToWorkshop.port_outside, HeatPort_ToWorkshop)
    annotation (Line(points={{14,-66.2},{14,-100}}, color={191,0,0}));
  connect(WestWallToConferenceRoom.port_outside, HeatPort_ToConferenceRoom)
    annotation (Line(points={{-80.2,-28},{-100,-28}}, color={191,0,0}));
  connect(WestWallToMultiPersonOffice.port_outside,
    HeatPort_ToMultiPersonOffice)
    annotation (Line(points={{-80.2,28},{-100,28}}, color={191,0,0}));
  connect(NorthWall.port_outside, HeatPort_OutdoorTemp)
    annotation (Line(points={{-52,64.2},{-52,100}}, color={191,0,0}));
  connect(SouthWall.WindSpeedPort, WindSpeedPort_SouthWall) annotation (Line(
        points={{-69.6,-66.2},{-69.6,-80},{-82,-80},{-82,-106}}, color={0,0,127}));
  connect(EastWall.WindSpeedPort, WindSpeedPort_EastWall) annotation (Line(
        points={{64.2,-17.6},{81.1,-17.6},{81.1,-18},{104,-18}}, color={0,0,127}));
  connect(NorthWall.SolarRadiationPort, SolarRadiationPort_NorthWall)
    annotation (Line(points={{-30,65.2},{-30,80},{10,80},{10,110}}, color={255,
          128,0}));
  connect(EastWall.SolarRadiationPort, SolarRadiationPort_EastWall) annotation (
     Line(points={{65.2,-22},{80,-22},{80,-50},{110,-50}}, color={255,128,0}));
  connect(SouthWall.SolarRadiationPort, SolarRadiationPort_SouthWall)
    annotation (Line(points={{-74,-67.2},{-74,-80},{-24,-80},{-24,-110}}, color=
         {255,128,0}));
  connect(SouthWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-52,-58},{-52,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(FloorToWorkshop.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{14,-58},{14,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(WestWallToConferenceRoom.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-72,-28},{-60,-28},{-60,-52},{-20.1,-52},{-20.1,
          -35.4}}, color={191,0,0}));
  connect(WestWallToMultiPersonOffice.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-72,28},{-60,28},{-60,-52},{-20.1,-52},{-20.1,
          -35.4}}, color={191,0,0}));
  connect(NorthWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{-52,56},{-52,48},{-60,48},{-60,-52},{-20.1,-52},{
          -20.1,-35.4}}, color={191,0,0}));
  connect(FloorToKitchen1.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{70,-58},{70,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(EastWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{56,0},{50,0},{50,-52},{-20.1,-52},{-20.1,-35.4}},
        color={191,0,0}));
  connect(thermStar_Demux.therm, airload.port)
    annotation (Line(points={{-25.1,-15.9},{-25.1,0},{3,0}}, color={191,0,0}));
  connect(SouthWall.port_outside, HeatPort_OutdoorTemp) annotation (Line(points=
         {{-52,-66.2},{-52,-80},{-90,-80},{-90,80},{-52,80},{-52,100}}, color={
          191,0,0}));
  connect(EastWall.port_outside, HeatPort_OutdoorTemp) annotation (Line(points=
          {{64.2,0},{80,0},{80,80},{-52,80},{-52,100}}, color={191,0,0}));
  connect(NorthWall.WindSpeedPort, WindSpeedPort_NorthWall) annotation (Line(
        points={{-34.4,64.2},{-34.4,80},{-20,80},{-20,104}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{48,78},{138,54}},
          lineColor={28,108,200},
          textString="Decke fehlt, Wenn TBA fertig dann einsetzen
Lüftung fehlt komplett")}));
end OpenPlanOffice;
