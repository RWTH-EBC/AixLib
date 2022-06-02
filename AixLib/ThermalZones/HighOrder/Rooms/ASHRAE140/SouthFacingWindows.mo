within AixLib.ThermalZones.HighOrder.Rooms.ASHRAE140;
model SouthFacingWindows "windows facing south"
  extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoomFourWalls(
    use_shortWaveRadOut=true,
    use_shortWaveRadIn=true,
    redeclare Components.Types.CoeffTableSouthWindow
      coeffTableSolDistrFractions,
    absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs06,
    redeclare replaceable model WindowModel =
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.Window_ASHRAE140,
    redeclare DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140 Type_Win,
      redeclare DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls
      wallTypes(
      roof=DataBase.Walls.ASHRAE140.RO_Case600(),
      OW=DataBase.Walls.ASHRAE140.OW_Case600(),
      IW_vert_half_a=DataBase.Walls.ASHRAE140.DummyDefinition(),
      IW_vert_half_b=DataBase.Walls.ASHRAE140.DummyDefinition(),
      IW_hori_upp_half=DataBase.Walls.ASHRAE140.DummyDefinition(),
      IW_hori_low_half=DataBase.Walls.ASHRAE140.DummyDefinition(),
      IW_hori_att_upp_half=DataBase.Walls.ASHRAE140.DummyDefinition(),
      IW_hori_att_low_half=DataBase.Walls.ASHRAE140.DummyDefinition(),
      groundPlate_upp_half=DataBase.Walls.ASHRAE140.FL_Case600(),
      groundPlate_low_half=DataBase.Walls.ASHRAE140.DummyDefinition(),
      IW2_vert_half_a=DataBase.Walls.ASHRAE140.DummyDefinition(),
      IW2_vert_half_b=DataBase.Walls.ASHRAE140.DummyDefinition(),
      roofRoomUpFloor=DataBase.Walls.ASHRAE140.DummyDefinition()),
      room_height=2.7,
      room_width=8,
      room_length=6,
      wallEast(
        withWindow=false,
        outside=true,
        wallPar=wallTypes.OW,
        surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster()),
      wallWest(
        withWindow=false,
        withDoor=false,
        outside=true,
        wallPar=wallTypes.OW,
        surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster()),
      wallSouth(
        withDoor=false,
        wallPar=wallTypes.OW,
        outside=true,
        withWindow=true,
        windowarea=Win_Area,
        surfaceType=AixLib.DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster()),
      wallNorth(
        withWindow=false,
        U_door=5.25,
        door_height=1,
        door_width=2,
        withDoor=false,
        outside=true,
        wallPar=wallTypes.OW,
        surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster()),
      floor(
        withWindow=false,
        withDoor=false,
        wallPar=wallTypes.groundPlate_upp_half,
        outside=false),
      ceiling(
        withWindow=false,
        withDoor=false,
        wallPar=wallTypes.roof,
        outside=true,
        surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster()));

  parameter Modelica.SIunits.Area Win_Area=12 "Window area " annotation (Dialog(
      group="Windows",
      descriptionLabel=true,
      enable=withWindow1));


  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_ground
    annotation (Placement(transformation(extent={{-104,-104},{-96,-96}}), iconTransformation(extent={{-108,-108},{-92,-92}})));
equation
  connect(floor.port_outside, Therm_ground)
                                           annotation (Line(points={{-42,
          -70.1003},{-42,-100},{-100,-100}},            color={191,0,0}));
  connect(thermOutside, ceiling.port_outside) annotation (Line(points={{-100,100},
          {-66,100},{-66,88},{-42,88},{-42,82.1}}, color={191,0,0}));
  connect(thermOutside, wallWest.port_outside) annotation (Line(points={{-100,100},
          {-68,100},{-68,88},{-96,88},{-96,0},{-88.25,0},{-88.25,13}},
                                                      color={191,0,0}));
  connect(thermOutside, wallNorth.port_outside) annotation (Line(points={{-100,
          100},{-68,100},{-68,88},{22,88},{22,74.25},{18,74.25}}, color={191,0,0}));
  connect(thermOutside, wallEast.port_outside) annotation (Line(points={{-100,100},
          {-68,100},{-68,88},{80,88},{80,-2},{74.25,-2},{74.25,13}},     color={
          191,0,0}));
  connect(thermOutside, wallSouth.port_outside) annotation (Line(points={{-100,100},
          {-66,100},{-66,88},{-96,88},{-96,-86},{22,-86},{22,-73.25},{18,-73.25}},
                                                                     color={191,
          0,0}));

  annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={215,215,215},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-85,85},{85,-85}},
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-24,11},{24,-11}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          origin={75,0},
          rotation=90,
          fontSize=47,
          textString="Width"),
        Text(
          extent={{-24,11},{24,-11}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          origin={0,-75},
          rotation=0,
          fontSize=47,
          textString="Length"),
        Rectangle(
          extent={{-7,30},{7,-30}},
          lineColor={170,213,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          origin={0,-92.5},
          rotation=-90),
        Text(
          extent={{-30,7},{30,-7}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="Window",
          textStyle={TextStyle.Bold},
          origin={0,-93},
          rotation=180)}),Documentation(revisions="<html><ul>
  <li>
    <i>July 1, 2020</i> by Konstantina Xanhtopoulou:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/896\">#896</a>:
    Mainly added solar distribution fractions, extended from
    PartialRoom.
  </li>
</ul>
<ul>
  <li>
    <i>March 9, 2015</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>


",         info="<html>
</html>"));
end SouthFacingWindows;
