within AixLib.ThermalZones.HighOrder.Rooms.RoomEmpiricalValidation;
model RoomTwinHouseN2 "N2"
  extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoom(room_V=
        room_height*room_length*room_width,
    redeclare DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes(
    OW=AixLib.DataBase.Walls.EmpiricalValidation.OW_S_N_TwinHouses(),
    IW_vert_half_a=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_vert_half_b=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_hori_upp_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_hori_low_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_hori_att_upp_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_hori_att_low_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    groundPlate_upp_half=DataBase.Walls.EmpiricalValidation.FL_TwinHouses(),
    groundPlate_low_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    roof=DataBase.Walls.EmpiricalValidation.CE_TwinHouses(),
    IW2_vert_half_a=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW2_vert_half_b=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    roofRoomUpFloor=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition()));

  parameter Modelica.Units.SI.Length room_length=10 "length"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Height room_height=2.6 "height"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Length room_width=10 "width"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  Components.Walls.Wall wallEast(
    final energyDynamics=energyDynamicsWalls,
    use_shortWaveRadIn=true,
    use_shortWaveRadOut=true,    redeclare
      DataBase.Walls.EmpiricalValidation.OW_E_TwinHouses wallPar,
    wall_length=10,
    wall_height=2.6,
    solar_absorptance=0.23,
    calcMethodOut=1,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    calcMethodIn=1,
    withWindow=true,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final WindowType=Type_Win,
    windowarea=1.89,
    T0=TWalls_start)
    annotation (Placement(transformation(extent={{60,-42},{48,30}})));
  Components.Walls.Wall wallSouth(
    final energyDynamics=energyDynamicsWalls,
    use_shortWaveRadIn=true,
    use_shortWaveRadOut=true,
    redeclare DataBase.Walls.EmpiricalValidation.OW_S_N_TwinHouses wallPar,
    wall_length=10,
    wall_height=2.6,
    solar_absorptance=0.23,
    calcMethodOut=1,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    calcMethodIn=1,
    withWindow=true,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final WindowType=Type_Win,
    windowarea=9.66,
    withSunblind=true,
    Blinding=0,
    LimitSolIrr=0,
    TOutAirLimit=173.15,
    T0=TWalls_start)                                                annotation (
     Placement(transformation(
        extent={{-6,-35},{6,35}},
        rotation=90,
        origin={4,-59})));

  Components.Walls.Wall wallWest(
    final energyDynamics=energyDynamicsWalls,
    use_shortWaveRadIn=true,
    use_shortWaveRadOut=true,    redeclare
      DataBase.Walls.EmpiricalValidation.OW_W_TwinHouses wallPar,
    wall_length=10,
    wall_height=2.6,
    solar_absorptance=0.23,
    calcMethodOut=1,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    calcMethodIn=1,
    withWindow=true,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final WindowType=Type_Win,
    windowarea=3.78,
    T0=TWalls_start)
    annotation (Placement(transformation(extent={{-64,-42},{-52,30}})));
  Components.Walls.Wall wallNorth(
    final energyDynamics=energyDynamicsWalls,
    use_shortWaveRadIn=true,
    use_shortWaveRadOut=true,     redeclare
      DataBase.Walls.EmpiricalValidation.OW_S_N_TwinHouses wallPar,
    wall_length=10,
    wall_height=2.6,
    solar_absorptance=0.23,
    calcMethodOut=1,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    calcMethodIn=1,
    withWindow=true,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final WindowType=Type_Win,
    windowarea=1.89,
    withDoor=true,
    U_door=0.3,
    T0=TWalls_start)                                                annotation (
     Placement(transformation(
        extent={{6.00001,-35},{-6.00001,35}},
        rotation=90,
        origin={11,56})));
  Components.Walls.Wall Ceiling(outside=false,
    final energyDynamics=energyDynamicsWalls,
    use_shortWaveRadIn=true,
    redeclare DataBase.Walls.EmpiricalValidation.CE_TwinHouses wallPar,
    wall_length=10,
    wall_height=10,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final WindowType=Type_Win,
    calcMethodOut=1,                           ISOrientation=3,
    calcMethodIn=1,
    T0=TWalls_start)                           annotation (Placement(
        transformation(
        extent={{3.00003,-16},{-3.00003,16}},
        rotation=90,
        origin={-46,71})));
  Components.Walls.Wall Floor(outside=false,
    final energyDynamics=energyDynamicsWalls,
    use_shortWaveRadIn=true,
    redeclare DataBase.Walls.EmpiricalValidation.FL_TwinHouses wallPar,
    wall_length=10,
    wall_height=10,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final WindowType=Type_Win,
    calcMethodOut=1,                         ISOrientation=2,
    calcMethodIn=1,
    T0=TWalls_start)                         annotation (Placement(
        transformation(
        extent={{-2.5,-14.5},{2.5,14.5}},
        rotation=90,
        origin={-44.5,-77.5})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_ground
    annotation (Placement(transformation(extent={{-36,-102},{-28,-94}}),
        iconTransformation(extent={{-36,-100},{-28,-92}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation (Placement(
        transformation(extent={{-122,12},{-106,28}}), iconTransformation(extent={{-120,22},
            {-100,42}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_Ceiling1
    annotation (Placement(transformation(extent={{-40,94},{-32,102}}),
        iconTransformation(extent={{-40,94},{-32,102}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort[5] "N,E,S,W,Hor"
    annotation (Placement(transformation(extent={{-120,46},{-100,66}})));
  Components.DryAir.VarAirExchange Ventilation(final V=room_V)
    "Air exchange with specified temperature"
    annotation (Placement(transformation(extent={{-30,4},{-18,16}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangeSUA annotation (Placement(
        transformation(
        extent={{-13,-13},{13,13}},
        rotation=0,
        origin={-114,-32}), iconTransformation(
        extent={{-10,-9.5},{10,9.5}},
        rotation=0,
        origin={-110,-32.5})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermSUA annotation (
      Placement(transformation(extent={{-116,-62},{-96,-42}}),
        iconTransformation(extent={{-120,-66},{-100,-46}})));

  Components.Walls.Wall IW(
    outside=false,
    final energyDynamics=energyDynamicsWalls,
    redeclare DataBase.Walls.EmpiricalValidation.IW_TwinHouses wallPar,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final WindowType=Type_Win,
    wall_length=2.6,
    wall_height=12.4,
    calcMethodOut=1,
    calcMethodIn=1,
    T0=TWalls_start)
    annotation (Placement(transformation(extent={{30,12},{34,36}})));
  Components.Walls.Wall IW1(
    outside=false,
    final energyDynamics=energyDynamicsWalls,
    redeclare DataBase.Walls.EmpiricalValidation.IW_LightMass_TwinHouses wallPar,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final WindowType=Type_Win,
    wall_length=2.6,
    wall_height=11.6,
    calcMethodOut=1,
    calcMethodIn=1,
    T0=TWalls_start)
    annotation (Placement(transformation(extent={{34,-4},{38,20}})));
  Utilities.HeatTransfer.SolarRadInRoom solarRadInRoom(
    final use_dynamicMethod=true,
    final nWin=4,
    final nWalls=4,
    final nFloors=1,
    final nCei=1,
    final floor_length=Floor.wall_length,
    final floor_width=Floor.wall_height,
    redeclare final Components.Types.CoeffTableEastWestWindow staticCoeffTable(abs=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs06))
                                                        annotation (Placement(transformation(extent={{-44,26},{-24,46}})));
equation
  connect(WindSpeedPort, wallWest.WindSpeedPort) annotation (Line(points={{-114,20},{-68,20},{-68,20.4},{-64.3,20.4}},
                                                       color={0,0,127}));
  connect(WindSpeedPort, wallSouth.WindSpeedPort) annotation (Line(points={{-114,20},{-68,20},{-68,-86},{-14,-86},{-14,-65.3},{-21.6667,-65.3}},
        color={0,0,127}));
  connect(WindSpeedPort, wallEast.WindSpeedPort) annotation (Line(points={{-114,20},
          {-68,20},{-68,-86},{88,-86},{88,20},{60.3,20},{60.3,20.4}},     color=
         {0,0,127}));
  connect(WindSpeedPort, wallNorth.WindSpeedPort) annotation (Line(points={{-114,20},{-68,20},{-68,-86},{88,-86},{88,72},{-14.6667,72},{-14.6667,62.3}},
                  color={0,0,127}));
  connect(thermOutside, wallWest.port_outside) annotation (Line(points={{-100,100},{-68,100},{-68,-6},{-64.3,-6}},
                                               color={191,0,0}));
  connect(thermOutside, wallSouth.port_outside) annotation (Line(points={{-100,
          100},{-68,100},{-68,-86},{4,-86},{4,-65.3}}, color={191,0,0}));
  connect(Floor.port_outside, Therm_ground) annotation (Line(points={{-44.5,
          -80.125},{-44.5,-92},{-32,-92},{-32,-98}}, color={191,0,0}));
  connect(wallWest.thermStarComb_inside, thermStar_Demux.portConvRadComb)
    annotation (Line(points={{-52,-6},{-52,-10},{-46,-10},{-46,-46},{-7,-46},{-7,-8}},
                         color={191,0,0}));
  connect(wallSouth.thermStarComb_inside, thermStar_Demux.portConvRadComb)
    annotation (Line(points={{4,-53},{4,-46},{-7,-46},{-7,-8}}, color={191,0,0}));
  connect(wallEast.thermStarComb_inside, thermStar_Demux.portConvRadComb)
    annotation (Line(points={{48,-6},{40,-6},{40,-46},{-7,-46},{-7,-8}}, color=
          {191,0,0}));
  connect(wallNorth.thermStarComb_inside, thermStar_Demux.portConvRadComb)
    annotation (Line(points={{11,50},{8,50},{8,44},{40,44},{40,-46},{-7,-46},{-7,-8}},
                color={191,0,0}));
  connect(Ceiling.thermStarComb_inside, thermStar_Demux.portConvRadComb)
    annotation (Line(points={{-46,68},{-46,-46},{-7,-46},{-7,-8}}, color={191,0,
          0}));
  connect(Therm_Ceiling1, Ceiling.port_outside) annotation (Line(points={{-36,98},{-42,98},{-42,82},{-46,82},{-46,74.15}},
                                                       color={191,0,0}));
  connect(SolarRadiationPort[1], wallNorth.SolarRadiationPort) annotation (Line(
        points={{-110,48},{-68,48},{-68,-86},{88,-86},{88,72},{-22,72},{-22,63.8},{-21.0833,63.8}},
                                  color={255,128,0}));
  connect(SolarRadiationPort[2], wallEast.SolarRadiationPort) annotation (Line(
        points={{-110,52},{-68,52},{-68,-86},{88,-86},{88,27},{61.8,27}}, color=
         {255,128,0}));
  connect(SolarRadiationPort[3], wallSouth.SolarRadiationPort) annotation (Line(
        points={{-110,56},{-68,56},{-68,-86},{-28.0833,-86},{-28.0833,-66.8}},
        color={255,128,0}));
  connect(SolarRadiationPort[4], wallWest.SolarRadiationPort) annotation (Line(
        points={{-110,60},{-68,60},{-68,26},{-66,26},{-66,27},{-65.8,27}},
                     color={255,128,0}));
  connect(AirExchangeSUA, Ventilation.ventRate) annotation (Line(points={{-114,-32},{-70,-32},{-70,6.16},{-29.4,6.16}},
                                        color={0,0,127}));
  connect(thermSUA, Ventilation.port_a) annotation (Line(points={{-106,-52},{-68,
          -52},{-68,8},{-50,8},{-50,10},{-30,10}}, color={191,0,0}));
  connect(Ventilation.port_b, airload.port) annotation (Line(points={{-18,10},{
          -14,10},{-14,-18},{10,-18}}, color={191,0,0}));
  connect(thermOutside, wallEast.port_outside) annotation (Line(points={{-100,
          100},{-68,100},{-68,-86},{88,-86},{88,-6},{60.3,-6}}, color={191,0,0}));
  connect(thermOutside, wallNorth.port_outside) annotation (Line(points={{-100,100},{-68,100},{-68,-86},{88,-86},{88,72},{10,72},{10,68},{11,68},{11,62.3}},
                  color={191,0,0}));
  connect(Floor.thermStarComb_inside, thermStar_Demux.portConvRadComb)
    annotation (Line(points={{-44.5,-75},{-44.5,-60},{-44,-60},{-44,-46},{-7,
          -46},{-7,-8}}, color={191,0,0}));
  connect(IW.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (
     Line(points={{34,24},{40,24},{40,-46},{-7,-46},{-7,-8}}, color={191,0,0}));
  connect(IW.port_outside, airload.port) annotation (Line(points={{29.9,24},{22,
          24},{22,-18},{10,-18}}, color={191,0,0}));
  connect(IW1.port_outside, airload.port) annotation (Line(points={{33.9,8},{22,
          8},{22,-18},{10,-18}}, color={191,0,0}));
  connect(IW1.thermStarComb_inside, thermStar_Demux.portConvRadComb)
    annotation (Line(points={{38,8},{40,8},{40,-46},{-7,-46},{-7,-8}}, color={
          191,0,0}));
  connect(wallEast.shortRadWin, solarRadInRoom.win_in[1]) annotation (Line(points={{48.3,-23.7},{44,-23.7},{44,-48},{-48,-48},{-48,35.25},{-45,35.25}}, color={0,0,0}));
  connect(wallSouth.shortRadWin, solarRadInRoom.win_in[2]) annotation (Line(points={{21.2083,-53.3},{21.2083,-48},{-48,-48},{-48,36},{-46,36},{-46,35.75},{-45,35.75}}, color={0,0,0}));
  connect(wallWest.shortRadWin, solarRadInRoom.win_in[3]) annotation (Line(points={{-52.3,-23.7},{-50,-23.7},{-50,-24},{-48,-24},{-48,36},{-46,36},{-46,36.25},{-45,36.25}}, color={0,0,0}));
  connect(wallNorth.shortRadWin, solarRadInRoom.win_in[4]) annotation (Line(points={{28.2083,50.3},{28.2083,46},{-48,46},{-48,36.75},{-45,36.75}}, color={0,0,0}));
  connect(solarRadInRoom.walls[1], wallEast.shortRadWall) annotation (Line(points={{-23,41.25},{44,41.25},{44,17.7},{48,17.7}}, color={0,0,0}));
  connect(solarRadInRoom.walls[2], wallSouth.shortRadWall) annotation (Line(points={{-23,41.75},{44,41.75},{44,-50},{-19.0417,-50},{-19.0417,-53}}, color={0,0,0}));
  connect(solarRadInRoom.walls[3], wallWest.shortRadWall) annotation (Line(points={{-23,42.25},{-20,42.25},{-20,17.7},{-52,17.7}}, color={0,0,0}));
  connect(solarRadInRoom.walls[4], wallNorth.shortRadWall) annotation (Line(points={{-23,42.75},{-12.0417,42.75},{-12.0417,50}}, color={0,0,0}));
  connect(solarRadInRoom.floors[1], Floor.shortRadWall) annotation (Line(points={{-23,38},{-18,38},{-18,16},{-42,16},{-42,-70},{-54.0458,-70},{-54.0458,-75}}, color={0,0,0}));
  connect(solarRadInRoom.ceilings[1], Ceiling.shortRadWall) annotation (Line(points={{-23,34},{-22,34},{-22,48},{-56.5333,48},{-56.5333,68}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,94},{94,-90}},
          lineColor={215,215,215},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-84,80},{82,-76}},
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-22,11},{22,-11}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="width",
          origin={71,4},
          rotation=90),
        Text(
          extent={{-52,-52},{56,-74}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="Length"),
        Rectangle(
          extent={{-100,28},{-86,-32}},
          lineColor={170,213,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-22,12},{22,-12}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="Window",
          textStyle={TextStyle.Bold},
          origin={-92,-2},
          rotation=90),
        Rectangle(
          extent={{-7,30},{7,-30}},
          lineColor={170,213,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          origin={87,0},
          rotation=180),
        Text(
          extent={{-22,12},{22,-12}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="Window",
          textStyle={TextStyle.Bold},
          origin={90,0},
          rotation=270),
        Rectangle(
          extent={{-7,30},{7,-30}},
          lineColor={170,213,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          origin={-1,-84},
          rotation=270),
        Text(
          extent={{-22,12},{22,-12}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="Window",
          textStyle={TextStyle.Bold},
          origin={0,-84},
          rotation=180),
        Rectangle(
          extent={{-7,30},{7,-30}},
          lineColor={170,213,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          origin={-5,86},
          rotation=90),
        Text(
          extent={{-22,12},{22,-12}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="Window",
          textStyle={TextStyle.Bold},
          origin={-4,86},
          rotation=180)}),                                       Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RoomTwinHouseN2;
