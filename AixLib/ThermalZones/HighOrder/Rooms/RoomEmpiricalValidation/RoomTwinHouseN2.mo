within AixLib.ThermalZones.HighOrder.Rooms.RoomEmpiricalValidation;
model RoomTwinHouseN2 "N2"
  extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoomFourWalls(
    redeclare Components.Types.CoeffTableEastWestWindow
      coeffTableSolDistrFractions,
    absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs06,
    use_dynamicShortWaveRadMethod=true,
    redeclare DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes(
      OW=AixLib.DataBase.Walls.EmpiricalValidation.OW_S_N_TwinHouses(),
      IW_vert_half_a=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
      IW_vert_half_b=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
      IW_hori_upp_half=
          AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
      IW_hori_low_half=
          AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
      IW_hori_att_upp_half=
          AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
      IW_hori_att_low_half=
          AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
      groundPlate_upp_half=DataBase.Walls.EmpiricalValidation.FL_TwinHouses(),
      groundPlate_low_half=
          AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
      roof=DataBase.Walls.EmpiricalValidation.CE_TwinHouses(),
      IW2_vert_half_a=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
      IW2_vert_half_b=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
      roofRoomUpFloor=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition()),
    room_height=2.6,
    room_width=10,
    room_length=10,
    solar_absorptance_OW=0.4,
    final use_shortWaveRadIn=true,
    final use_shortWaveRadOut=true,
    wallEast(
      final withDoor=false,
      redeclare final DataBase.Walls.EmpiricalValidation.OW_E_TwinHouses
        wallPar,
      final solar_absorptance=0.23,
      final calcMethodOut=1,
      final calcMethodIn=1,
      final withWindow=true,
      final windowarea=1.89),
    wallWest(
      redeclare final DataBase.Walls.EmpiricalValidation.OW_W_TwinHouses
        wallPar,
      final solar_absorptance=0.23,
      final calcMethodOut=1,
      final calcMethodIn=1,
      final withWindow=true,
      final windowarea=3.78),
    wallSouth(
      redeclare final DataBase.Walls.EmpiricalValidation.OW_S_N_TwinHouses
        wallPar,
      final solar_absorptance=0.23,
      final calcMethodOut=1,
      final calcMethodIn=1,
      final withWindow=true,
      final windowarea=9.66,
      final withSunblind=true,
      final Blinding=0,
      final LimitSolIrr=0,
      final TOutAirLimit=173.15),
    wallNorth(
      redeclare final DataBase.Walls.EmpiricalValidation.OW_S_N_TwinHouses
        wallPar,
      final solar_absorptance=0.23,
      final calcMethodOut=1,
      final calcMethodIn=1,
      final withWindow=true,
      final windowarea=1.89,
      final withDoor=true,
      final U_door=0.3),
    floor(
      final outside=false,
      redeclare DataBase.Walls.EmpiricalValidation.FL_TwinHouses wallPar,
      final ISOrientation=2,
      final withWindow=false,
      final withDoor=false),
    ceiling(
      outside=false,
      redeclare DataBase.Walls.EmpiricalValidation.CE_TwinHouses wallPar,
      final ISOrientation=3,
      final withWindow=false,
      final withDoor=false,
      final calcMethodOut=1,
      final calcMethodIn=1));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_ground
    annotation (Placement(transformation(extent={{-36,-102},{-28,-94}}),
        iconTransformation(extent={{-36,-100},{-28,-92}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_Ceiling1
    annotation (Placement(transformation(extent={{-40,94},{-32,102}}),
        iconTransformation(extent={{-40,94},{-32,102}})));
  Components.DryAir.VarAirExchange Ventilation(final V=room_V)
    "Air exchange with specified temperature"
    annotation (Placement(transformation(extent={{-30,4},{-18,16}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangeSUA annotation (Placement(
        transformation(
        extent={{-13,-13},{13,13}},
        rotation=0,
        origin={-114,-18}), iconTransformation(
        extent={{-10,-9.5},{10,9.5}},
        rotation=0,
        origin={-110,-32.5})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermSUA annotation (
      Placement(transformation(extent={{-114,-88},{-94,-68}}),
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
    annotation (Placement(transformation(extent={{26,16},{30,40}})));
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
    annotation (Placement(transformation(extent={{40,-2},{44,22}})));
equation

  connect(thermOutside, wallWest.port_outside) annotation (Line(points={{-100,100},
          {-68,100},{-68,13},{-88.25,13}},     color={191,0,0}));
  connect(thermOutside, wallSouth.port_outside) annotation (Line(points={{-100,100},
          {-68,100},{-68,-86},{18,-86},{18,-73.25}},   color={191,0,0}));
  connect(floor.port_outside, Therm_ground) annotation (Line(points={{-42,
          -70.1003},{-42,-92},{-32,-92},{-32,-98}},  color={191,0,0}));

  connect(Therm_Ceiling1, ceiling.port_outside) annotation (Line(points={{-36,98},
          {-42,98},{-42,82},{-42,82},{-42,82.1}},      color={191,0,0}));
  connect(AirExchangeSUA, Ventilation.ventRate) annotation (Line(points={{-114,-18},
          {-70,-18},{-70,6.16},{-29.4,6.16}},
                                        color={0,0,127}));
  connect(thermSUA, Ventilation.port_a) annotation (Line(points={{-104,-78},{-68,
          -78},{-68,8},{-50,8},{-50,10},{-30,10}}, color={191,0,0}));
  connect(Ventilation.port_b, airload.heatPort) annotation (Line(points={{-18,10},
          {-14,10},{-14,-12},{18,-12}},color={191,0,0}));
  connect(thermOutside, wallEast.port_outside) annotation (Line(points={{-100,100},
          {-68,100},{-68,-86},{88,-86},{88,13},{74.25,13}},     color={191,0,0}));
  connect(thermOutside, wallNorth.port_outside) annotation (Line(points={{-100,
          100},{-68,100},{-68,-86},{88,-86},{88,72},{10,72},{10,68},{18,68},{18,
          74.25}},color={191,0,0}));

  connect(IW.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (
     Line(points={{30,28},{40,28},{40,-46},{-7,-46},{-7,-8}}, color={191,0,0}));
  connect(IW.port_outside, airload.heatPort) annotation (Line(points={{25.9,28},
          {22,28},{22,-12},{18,-12}},
                                  color={191,0,0}));
  connect(IW1.port_outside, airload.heatPort) annotation (Line(points={{39.9,10},
          {22,10},{22,-12},{18,-12}},
                                 color={191,0,0}));
  connect(IW1.thermStarComb_inside, thermStar_Demux.portConvRadComb)
    annotation (Line(points={{44,10},{40,10},{40,-46},{-7,-46},{-7,-8}},
                                                                       color={
          191,0,0}));
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
