within AixLib.ThermalZones.HighOrder.Rooms.RoomEmpiricalValidation;
model RoomWarehouse "Room model of Warehouse for Empirical validation"
  extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoom(
    redeclare DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes(
      OW=AixLib.DataBase.Walls.EmpiricalValidation.OW_Warehouse(),
    IW_vert_half_a=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_vert_half_b=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_hori_upp_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_hori_low_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_hori_att_upp_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_hori_att_low_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    groundPlate_upp_half=AixLib.DataBase.Walls.EmpiricalValidation.FL_Warehouse(),
    groundPlate_low_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    roof=AixLib.DataBase.Walls.EmpiricalValidation.RO_Warehouse(),
    IW2_vert_half_a=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW2_vert_half_b=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    roofRoomUpFloor=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition()),
      final room_V=0.7*room_length*room_width*room_height);

  parameter Modelica.Units.SI.Length room_length=72 "length"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Height room_height=22 "height"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Length room_width=22 "width"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  Components.Walls.Wall wallWest(
    final energyDynamics=energyDynamicsWalls,
    redeclare DataBase.Walls.EmpiricalValidation.OW_Warehouse wallPar,
    wall_length=room_width,
    wall_height=room_height,
    solar_absorptance=0.4,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    withWindow=false,
    withDoor=true,
    U_door=1.7,
    door_height=15,
    T0=TWalls_start,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
    annotation (Placement(transformation(extent={{-62,-42},{-48,44}})));
  Components.Walls.Wall wallSouth(
    final energyDynamics=energyDynamicsWalls,
    redeclare DataBase.Walls.EmpiricalValidation.OW_Warehouse wallPar,
    wall_length=room_length,
    wall_height=room_height,
    solar_absorptance=0.4,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    withWindow=false,
    withDoor=false,
    T0=TWalls_start,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
                    annotation (Placement(transformation(
        extent={{-6,-39},{6,39}},
        rotation=90,
        origin={24,-59})));
  Components.Walls.Wall wallNorth(
    final energyDynamics=energyDynamicsWalls,
    redeclare DataBase.Walls.EmpiricalValidation.OW_Warehouse wallPar,
    wall_length=room_length,
    wall_height=room_height,
    solar_absorptance=0.4,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    withWindow=false,
    withDoor=false,
    T0=TWalls_start,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
                    annotation (Placement(transformation(
        extent={{-6,-39},{6,39}},
        rotation=270,
        origin={26,61})));
  Components.Walls.Wall wallEast(
    final energyDynamics=energyDynamicsWalls,
    redeclare DataBase.Walls.EmpiricalValidation.OW_Warehouse wallPar,
    wall_length=room_width,
    wall_height=room_height,
    solar_absorptance=0.4,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    withWindow=false,
    withDoor=false,
    T0=TWalls_start,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
    annotation (Placement(transformation(extent={{80,-40},{66,44}})));
  Components.Walls.Wall roof(
    final energyDynamics=energyDynamicsWalls,
    redeclare DataBase.Walls.EmpiricalValidation.RO_Warehouse wallPar,
    wall_length=room_length,
    wall_height=room_width,
    solar_absorptance=0.4,
    ISOrientation=3,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    withWindow=true,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final WindowType=Type_Win,
    windowarea=60,
    withDoor=false,
    T0=TWalls_start)
                    annotation (Placement(transformation(
        extent={{-2.5,-15.5},{2.5,15.5}},
        rotation=270,
        origin={-26.5,73.5})));
  Components.Walls.Wall floor(
    outside=false,
    final energyDynamics=energyDynamicsWalls,
    redeclare DataBase.Walls.EmpiricalValidation.FL_Warehouse wallPar,
    wall_length=room_length,
    wall_height=room_width,
    solar_absorptance=0.3,
    ISOrientation=2,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    withWindow=false,
    withDoor=false,
    T0=TWalls_start,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
                    annotation (Placement(transformation(
        extent={{-2.50001,-15.5},{2.5,15.5}},
        rotation=90,
        origin={-32.5,-72.5})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation (Placement(
        transformation(extent={{-120,10},{-104,26}}), iconTransformation(extent=
           {{-120,20},{-100,40}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort[5] "N,E,S,W,Hor"
    annotation (Placement(transformation(extent={{-120,48},{-100,68}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_ground
    annotation (Placement(transformation(extent={{-36,-102},{-28,-94}})));
  Components.DryAir.VarAirExchange Ventilation(final V=room_V)
    "Air exchange with specified temperature"
    annotation (Placement(transformation(extent={{-30,4},{-18,16}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePortRoom
    "Air Exchange with Room " annotation (Placement(transformation(
        extent={{-13,-13},{13,13}},
        rotation=0,
        origin={-112,-50}), iconTransformation(
        extent={{-10,-9.5},{10,9.5}},
        rotation=0,
        origin={-110,-68.5})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoomNextDoor
    annotation (Placement(transformation(extent={{-114,-106},{-94,-86}}),
        iconTransformation(extent={{-114,-106},{-94,-86}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor interiorThermCap(
    C=2100000*2000,
    final T(
      stateSelect=StateSelect.always,
      fixed=(initDynamicsAir == Modelica.Fluid.Types.Dynamics.FixedInitial),
      start=T0_air),
    final der_T(fixed=(initDynamicsAir == Modelica.Fluid.Types.Dynamics.SteadyStateInitial), start=0)) "Thermal capacity inside the room" annotation (Placement(transformation(extent={{30,16},{46,32}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor(R=1/
        35000) annotation (Placement(transformation(extent={{34,-4},{48,10}})));
equation
  connect(WindSpeedPort, wallWest.WindSpeedPort) annotation (Line(points={{-112,18},{-92,18},{-92,32},{-88,32},{-88,32.5333},{-62.35,32.5333}},
                                                                          color=
         {0,0,127}));
  connect(WindSpeedPort, roof.WindSpeedPort) annotation (Line(points={{-112,18},{-92,18},{-92,86},{-15.1333,86},{-15.1333,76.125}},
                                                              color={0,0,127}));
  connect(WindSpeedPort, wallNorth.WindSpeedPort) annotation (Line(points={{-112,
          18},{-92,18},{-92,86},{54.6,86},{54.6,67.3}}, color={0,0,127}));
  connect(WindSpeedPort, wallSouth.WindSpeedPort) annotation (Line(points={{-112,
          18},{-92,18},{-92,-82},{-12,-82},{-12,-66},{-4.6,-66},{-4.6,-65.3}},
        color={0,0,127}));
  connect(WindSpeedPort, wallEast.WindSpeedPort) annotation (Line(points={{-112,
          18},{-92,18},{-92,-82},{92,-82},{92,32.8},{80.35,32.8}}, color={0,0,127}));
  connect(thermOutside, thermOutside)
    annotation (Line(points={{-100,100},{-100,100}}, color={191,0,0}));
  connect(thermOutside, wallSouth.port_outside) annotation (Line(points={{-100,100},
          {-92,100},{-92,-82},{24,-82},{24,-65.3}}, color={191,0,0}));
  connect(thermOutside, wallWest.port_outside) annotation (Line(points={{-100,100},
          {-92,100},{-92,1},{-62.35,1}}, color={191,0,0}));
  connect(floor.port_outside, Therm_ground) annotation (Line(points={{-32.5,-75.125},{-32.5,-86.5625},{-32,-86.5625},{-32,-98}},
                                                      color={191,0,0}));
  connect(thermOutside, roof.port_outside) annotation (Line(points={{-100,100},
          {-92,100},{-92,86},{-26.5,86},{-26.5,76.125}}, color={191,0,0}));
  connect(thermOutside, wallNorth.port_outside) annotation (Line(points={{-100,100},
          {-92,100},{-92,86},{26,86},{26,67.3}}, color={191,0,0}));
  connect(thermOutside, wallEast.port_outside) annotation (Line(points={{-100,100},
          {-92,100},{-92,-82},{92,-82},{92,2},{80.35,2}}, color={191,0,0}));
  connect(SolarRadiationPort[1], wallNorth.SolarRadiationPort) annotation (Line(
        points={{-110,50},{-92,50},{-92,86},{62,86},{62,78},{61.75,78},{61.75,68.8}},
        color={255,128,0}));
  connect(SolarRadiationPort[2], wallEast.SolarRadiationPort) annotation (Line(
        points={{-110,54},{-92,54},{-92,86},{92,86},{92,40},{88,40},{88,40.5},{82.1,
          40.5}}, color={255,128,0}));
  connect(SolarRadiationPort[3], wallSouth.SolarRadiationPort) annotation (Line(
        points={{-110,58},{-92,58},{-92,86},{92,86},{92,-82},{-11.75,-82},{-11.75,
          -66.8}}, color={255,128,0}));
  connect(SolarRadiationPort[4], wallWest.SolarRadiationPort) annotation (Line(
        points={{-110,62},{-92,62},{-92,40.4167},{-64.1,40.4167}}, color={255,128,
          0}));
  connect(SolarRadiationPort[5], roof.SolarRadiationPort) annotation (Line(
        points={{-110,66},{-92,66},{-92,86},{-12.2917,86},{-12.2917,76.75}},
        color={255,128,0}));
  connect(thermStar_Demux.portConvRadComb, wallSouth.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-7,-50},{24,-50},{24,-53}}, color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, wallWest.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-8,-8},{-8,-50},{-42,-50},{-42,1},{-48,1}},
        color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, wallEast.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-7,-50},{56,-50},{56,2},{66,2}}, color={191,
          0,0}));
  connect(thermStar_Demux.portConvRadComb, wallNorth.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-8,-8},{-8,-50},{56,-50},{56,40},{26,40},{
          26,55}}, color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, roof.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-7,-10},{-8,-10},{-8,-50},{-42,-50},{-42,
          52},{-26.5,52},{-26.5,71}}, color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb,floor. thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-8,-8},{-8,-50},{-42,-50},{-42,-62},{-32.5,
          -62},{-32.5,-70}}, color={191,0,0}));
  connect(Ventilation.port_b, airload.port) annotation (Line(points={{-18,10},{
          -16,10},{-16,-18},{10,-18}}, color={191,0,0}));
  connect(AirExchangePortRoom, Ventilation.ventRate) annotation (Line(points={{-112,-50},{-70,-50},{-70,6.16},{-29.4,6.16}},
                                             color={0,0,127}));
  connect(thermRoomNextDoor, Ventilation.port_a) annotation (Line(points={{-104,
          -96},{-70,-96},{-70,10},{-30,10}}, color={191,0,0}));
  connect(thermalResistor.port_a, interiorThermCap.port) annotation (Line(points={{34,3},{34,16},{38,16}}, color={191,0,0}));
  connect(thermalResistor.port_b, airload.port) annotation (Line(points={{48,3},
          {48,-36},{10,-36},{10,-18}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,94},{94,-90}},
          lineColor={215,215,215},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-84,76},{82,-80}},
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,26},{-86,-34}},
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
          origin={-94,-2},
          rotation=90),
        Text(
          extent={{-54,-54},{54,-76}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="Length"),
        Text(
          extent={{-22,11},{22,-11}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="width",
          origin={65,0},
          rotation=90)}), Documentation(revisions="<html><ul>
  <li>
    <i>March 9, 2015</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>

</html>"));
end RoomWarehouse;
