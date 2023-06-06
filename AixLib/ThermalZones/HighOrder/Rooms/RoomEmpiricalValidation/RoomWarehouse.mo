within AixLib.ThermalZones.HighOrder.Rooms.RoomEmpiricalValidation;
model RoomWarehouse "Room model of Warehouse for Empirical validation"
  extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoomFourWalls(
    use_shortWaveRadIn=false,
    wallWest(
      redeclare DataBase.Walls.EmpiricalValidation.OW_Warehouse wallPar,
      final wall_length=room_width,
      final withWindow=false,
      final withDoor=true,
      final U_door=1.7,
      final door_height=15),
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
    final room_V=0.7*room_length*room_width*room_height,
    room_height=22,
    room_width=22,
    room_length=72,
    solar_absorptance_OW=0.4,
    wallEast(
      redeclare DataBase.Walls.EmpiricalValidation.OW_Warehouse wallPar,
      final wall_length=room_width,
      final withWindow=false,
      final withDoor=false),
    wallSouth(
      redeclare DataBase.Walls.EmpiricalValidation.OW_Warehouse wallPar,
      final wall_length=room_length,
      final withWindow=false,
      final withDoor=false),
    wallNorth(
      redeclare DataBase.Walls.EmpiricalValidation.OW_Warehouse wallPar,
      final wall_length=room_length,
      final withWindow=false,
      final withDoor=false),
    floor(
      final outside=false,
      redeclare DataBase.Walls.EmpiricalValidation.FL_Warehouse wallPar,
      final solar_absorptance=0.3,
      final ISOrientation=2,
      final withWindow=false,
      final withDoor=false),
    ceiling(
      redeclare DataBase.Walls.EmpiricalValidation.RO_Warehouse wallPar,
      final ISOrientation=3,
      final withWindow=true,
      final windowarea=60,
      final withDoor=false));

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
      fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial),
      start=T0_air),
    final der_T(fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial), start=0)) "Thermal capacity inside the room" annotation (Placement(transformation(extent={{30,16},{46,32}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor(R=1/
        35000) annotation (Placement(transformation(extent={{34,-4},{48,10}})));

equation
  connect(thermOutside, wallSouth.port_outside) annotation (Line(points={{-100,100},
          {-92,100},{-92,-82},{18,-82},{18,-73.25}},color={191,0,0}));
  connect(thermOutside, wallWest.port_outside) annotation (Line(points={{-100,100},
          {-92,100},{-92,13},{-88.25,13}},
                                         color={191,0,0}));
  connect(floor.port_outside, Therm_ground) annotation (Line(points={{-42,
          -70.1003},{-42,-86.5625},{-32,-86.5625},{-32,-98}},
                                                      color={191,0,0}));
  connect(thermOutside, ceiling.port_outside) annotation (Line(points={{-100,100},
          {-92,100},{-92,86},{-42,86},{-42,82.1}},       color={191,0,0}));
  connect(thermOutside, wallNorth.port_outside) annotation (Line(points={{-100,
          100},{-92,100},{-92,86},{18,86},{18,74.25}},
                                                 color={191,0,0}));
  connect(thermOutside, wallEast.port_outside) annotation (Line(points={{-100,100},
          {-92,100},{-92,-82},{92,-82},{92,13},{74.25,13}},
                                                          color={191,0,0}));

  connect(thermStar_Demux.portConvRadComb, wallSouth.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-7,-50},{18,-50},{18,-63}}, color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, wallWest.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-8,-8},{-8,-50},{-42,-50},{-42,13},{-78,13}},
        color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, wallEast.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-7,-50},{56,-50},{56,13},{64,13}},
                                                                       color={191,
          0,0}));
  connect(thermStar_Demux.portConvRadComb, wallNorth.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-8,-8},{-8,-50},{56,-50},{56,40},{18,40},
          {18,64}},color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, ceiling.thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-7,-10},{-8,-10},{-8,-50},{-42,-50},{-42,52},
          {-42,52},{-42,78}},         color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb,floor. thermStarComb_inside)
    annotation (Line(points={{-7,-8},{-8,-8},{-8,-50},{-42,-50},{-42,-62},{-42,
          -66},{-42,-66}},   color={191,0,0}));
  connect(Ventilation.port_b, airload.heatPort) annotation (Line(points={{-18,10},
          {-16,10},{-16,-12},{18,-12}},color={191,0,0}));
  connect(AirExchangePortRoom, Ventilation.ventRate) annotation (Line(points={{-112,-50},{-70,-50},{-70,6.16},{-29.4,6.16}},
                                             color={0,0,127}));
  connect(thermRoomNextDoor, Ventilation.port_a) annotation (Line(points={{-104,
          -96},{-68,-96},{-68,10},{-30,10}}, color={191,0,0}));
  connect(thermalResistor.port_a, interiorThermCap.port) annotation (Line(points={{34,3},{34,16},{38,16}}, color={191,0,0}));
  connect(thermalResistor.port_b, airload.heatPort) annotation (Line(points={{48,3},{
          48,-36},{18,-36},{18,-12}},  color={191,0,0}));
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
