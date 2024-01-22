within AixLib.ThermalZones.HighOrder.Rooms.OFD;
model Ow2IwL1IwS1Gr1Uf1
  "2 outer walls, 1 inner wall load, 1 inner wall simple, 1 floor towards ground, 1 ceiling towards upper floor"

  extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoom(    redeclare DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes,
                                                                          final room_V=room_length*room_width*room_height);


  //////////room geometry
  parameter Modelica.Units.SI.Length room_length=2 "length "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Length room_width=2 "width"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Height room_height=2 "height"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));

  // Windows and Doors
  parameter Boolean withWindow1=true "Window 1" annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true), choices(checkBox=true));
  parameter Modelica.Units.SI.Area windowarea_OW1=0 "Window area " annotation (
      Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      enable=withWindow1));
  parameter Boolean withWindow2=true "Window 2 " annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true), choices(checkBox=true));
  parameter Modelica.Units.SI.Area windowarea_OW2=0 "Window area" annotation (
      Dialog(
      group="Windows and Doors",
      naturalWidth=10,
      descriptionLabel=true,
      enable=withWindow2));
  parameter Boolean withDoor1=true "Door 1" annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true), choices(checkBox=true));
  parameter Modelica.Units.SI.Length door_width_OD1=0 "width " annotation (
      Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true,
      enable=withDoor1));
  parameter Modelica.Units.SI.Length door_height_OD1=0 "height " annotation (
      Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      enable=withDoor1));
  parameter Boolean withDoor2=true "Door 2" annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true), choices(checkBox=true));
  parameter Modelica.Units.SI.Length door_width_OD2=0 "width " annotation (
      Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true,
      enable=withDoor2));
  parameter Modelica.Units.SI.Length door_height_OD2=0 "height " annotation (
      Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      enable=withDoor2));
  parameter Real U_door_OD1=2.5 "U-value" annotation (
     Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true,
      enable=withDoor1));
  parameter Real eps_door_OD1=0.95 "eps" annotation (Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      enable=withDoor1));
  parameter Real U_door_OD2=2.5 "U-value" annotation (
     Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true,
      enable=withDoor2));
  parameter Real eps_door_OD2=0.95 "eps" annotation (Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      enable=withDoor2));



  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outside_wall1(
    final energyDynamics=energyDynamicsWalls,
    final calcMethodOut=calcMethodOut,
    final hConOut_const=hConOut_const,
    final surfaceType=surfaceType,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    final calcMethodIn=calcMethodIn,
    final hConIn_const=hConIn_const,
    final WindowType=Type_Win,
    final T0=TWalls_start,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    final solar_absorptance=solar_absorptance_OW,
    final wallPar=wallTypes.OW,
    windowarea=windowarea_OW1,
    door_height=door_height_OD1,
    door_width=door_width_OD1,
    wall_length=room_length,
    wall_height=room_height,
    withWindow=withWindow1,
    withDoor=withDoor1,
    eps_door=eps_door_OD1,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
                           annotation (Placement(transformation(extent={{-60,-22},{-50,42}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outside_wall2(
    final energyDynamics=energyDynamicsWalls,
    final calcMethodOut=calcMethodOut,
    final hConOut_const=hConOut_const,
    final surfaceType=surfaceType,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    final calcMethodIn=calcMethodIn,
    final hConIn_const=hConIn_const,
    final WindowType=Type_Win,
    final T0=TWalls_start,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    final solar_absorptance=solar_absorptance_OW,
    final wallPar=wallTypes.OW,
    windowarea=windowarea_OW2,
    door_height=door_height_OD2,
    door_width=door_width_OD2,
    wall_length=room_width,
    wall_height=room_height,
    withWindow=withWindow2,
    withDoor=withDoor2,
    U_door=U_door_OD2,
    eps_door=eps_door_OD2,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
                           annotation (Placement(transformation(
        origin={19,57},
        extent={{-5.00018,-29},{5.00003,29}},
        rotation=270)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall1(
    final energyDynamics=energyDynamicsWalls,
    final calcMethodOut=calcMethodOut,
    final hConOut_const=hConOut_const,
    final surfaceType=surfaceType,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    final calcMethodIn=calcMethodIn,
    final hConIn_const=hConIn_const,
    final WindowType=Type_Win,
    final T0=TWalls_start,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    final solar_absorptance=solar_absorptance_OW,
    final wallPar=wallTypes.IW2_vert_half_a,
    outside=false,
    wall_length=room_length,
    wall_height=room_height,
    withWindow=false,
    withDoor=false,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
                         annotation (Placement(transformation(
        origin={58,5},
        extent={{-6,-35},{6,35}},
        rotation=180)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall2(
    final energyDynamics=energyDynamicsWalls,
    final calcMethodOut=calcMethodOut,
    final hConOut_const=hConOut_const,
    final surfaceType=surfaceType,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    final calcMethodIn=calcMethodIn,
    final hConIn_const=hConIn_const,
    final WindowType=Type_Win,
    final T0=TWalls_start,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    final solar_absorptance=solar_absorptance_OW,
    final wallPar=wallTypes.IW_vert_half_a,
    outside=false,
    wall_length=room_width,
    wall_height=room_height,
    withWindow=false,
    withDoor=false,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
                    annotation (Placement(transformation(
        origin={16,-60},
        extent={{-4,-24},{4,24}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Ceiling(
    final energyDynamics=energyDynamicsWalls,
    final calcMethodOut=calcMethodOut,
    final hConOut_const=hConOut_const,
    final surfaceType=surfaceType,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    final calcMethodIn=calcMethodIn,
    final hConIn_const=hConIn_const,
    final WindowType=Type_Win,
    final T0=TWalls_start,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    final solar_absorptance=solar_absorptance_OW,
    final wallPar=wallTypes.IW_hori_low_half,
    outside=false,
    wall_length=room_length,
    wall_height=room_width,
    withWindow=false,
    withDoor=false,
    ISOrientation=3,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
                     annotation (Placement(transformation(
        origin={-30,59},
        extent={{2.99997,-16},{-3.00002,16}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall floor(
    final energyDynamics=energyDynamicsWalls,
    final calcMethodOut=calcMethodOut,
    final hConOut_const=hConOut_const,
    final surfaceType=surfaceType,
    final radLongCalcMethod=radLongCalcMethod,
    final T_ref=T_ref,
    final calcMethodIn=calcMethodIn,
    final hConIn_const=hConIn_const,
    final WindowType=Type_Win,
    final T0=TWalls_start,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    final solar_absorptance=solar_absorptance_OW,
    final wallPar=wallTypes.groundPlate_upp_half,
    wall_length=room_length,
    wall_height=room_width,
    withWindow=false,
    outside=false,
    withDoor=false,
    ISOrientation=2,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)      annotation (Placement(transformation(
        origin={-29,-65},
        extent={{-3.00001,-15},{2.99998,15}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1
    annotation (Placement(transformation(extent={{80,0},{100,20}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort if (calcMethodOut == 1 or calcMethodOut == 2)
    annotation (Placement(transformation(extent={{-119.5,-70},{-99.5,-50}}), iconTransformation(extent={{-109.5,-50},{-89.5,-30}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1
    annotation (Placement(transformation(extent={{-109.5,20},{-89.5,40}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW2 annotation (Placement(
        transformation(
        origin={50.5,99},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
    annotation (Placement(transformation(extent={{80,60},{100,80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ground
    annotation (Placement(transformation(extent={{-16,-104},{4,-84}})));

equation
  connect(outside_wall1.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-60.25,33.4667},{-80,33.4667},{-80,-60},{-109.5,-60}},
                                                                color={0,0,127}));
  connect(thermInsideWall2, thermInsideWall2)
    annotation (Line(points={{30,-90},{30,-90}}, color={191,0,0}));
  connect(inside_wall1.port_outside, thermInsideWall1)
    annotation (Line(points={{64.3,5},{90,5},{90,10}}, color={191,0,0}));
  connect(outside_wall2.WindSpeedPort, WindSpeedPort) annotation (Line(points={{40.2667,62.2502},{40.2667,70},{-80,70},{-80,-60},{-109.5,-60}},
        color={0,0,127}));
  connect(outside_wall2.SolarRadiationPort, SolarRadiationPort_OW2) annotation (
     Line(points={{45.5833,63.5002},{45.5833,80.7501},{50.5,80.7501},{50.5,99}},
        color={255,128,0}));
  connect(SolarRadiationPort_OW1, outside_wall1.SolarRadiationPort) annotation (
     Line(points={{-99.5,30},{-80,30},{-80,39.3333},{-61.5,39.3333}}, color={255,
          128,0}));
  connect(inside_wall2.port_outside, thermInsideWall2) annotation (Line(points={
          {16,-64.2},{16,-75.45},{30,-75.45},{30,-90}}, color={191,0,0}));
  connect(Ceiling.port_outside, thermCeiling)
    annotation (Line(points={{-30,62.15},{-30,70},{90,70}}, color={191,0,0}));
  connect(ground, floor.port_outside) annotation (Line(
      points={{-6,-94},{-6,-74},{-24,-74},{-24,-68.15},{-29,-68.15}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(outside_wall2.port_outside, thermOutside) annotation (Line(points={{19,62.2502},{19,76},{-56,76},{-56,100},{-100,100}}, color={191,0,0}));

  connect(thermOutside, outside_wall1.port_outside) annotation (Line(points={{-100,100},{-78,100},{-78,10},{-60.25,10}}, color={191,0,0}));
  connect(floor.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-29,-62},{-30,-62},{-30,-44},{-7,-44},{-7,-8}},              color={191,0,0}));
  connect(inside_wall2.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{16,-56},{16,-44},{-7,-44},{-7,-8}},              color={191,0,0}));
  connect(inside_wall1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{52,5},{42,5},{42,-44},{-7,-44},{-7,-8}},              color={191,0,0}));
  connect(outside_wall2.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{19,52},{18,52},{18,38},{42,38},{42,-44},{-7,-44},{-7,-8}},              color={191,0,0}));
  connect(Ceiling.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-30,56},{-30,38},{42,38},{42,-44},{-7,-44},{-7,-8}},              color={191,0,0}));
  connect(outside_wall1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-50,10},{-40,10},{-40,38},{42,38},{42,-44},{-7,-44},{-7,-8}},              color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-80,80},{80,60}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,80},{-50,60}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          visible=withWindow2),
        Rectangle(
          extent={{6,64},{-6,-64}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={74,-4},
          rotation=360),
        Rectangle(
          extent={{-60,-68},{80,-80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,60},{-60,-80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,50},{-60,0}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          visible=withWindow1),
        Rectangle(
          extent={{-60,60},{68,-68}},
          lineColor={0,0,0},
          fillColor={47,102,173},
          fillPattern=FillPattern.Solid),
        Line(points={{38,46},{68,46}}, color={255,255,255}),
        Text(
          extent={{64,52},{-56,40}},
          lineColor={255,255,255},
          textString="width"),
        Line(points={{-46,-38},{-46,-68}}, color={255,255,255}),
        Text(
          extent={{3,-6},{-117,6}},
          lineColor={255,255,255},
          origin={-46,53},
          rotation=90,
          textString="length"),
        Rectangle(
          extent={{-80,-20},{-60,-40}},
          fillColor={127,127,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          visible=withDoor1),
        Rectangle(
          extent={{20,80},{40,60}},
          lineColor={0,0,0},
          fillColor={127,127,0},
          fillPattern=FillPattern.Solid,
          visible=withDoor2),
        Text(
          extent={{-50,76},{0,64}},
          lineColor={255,255,255},
          fillColor={255,85,85},
          fillPattern=FillPattern.Solid,
          visible=withWindow2,
          textString="Win2",
          lineThickness=0.5),
        Text(
          extent={{-25,6},{25,-6}},
          lineColor={255,255,255},
          fillColor={255,85,85},
          fillPattern=FillPattern.Solid,
          origin={-70,25},
          rotation=90,
          visible=withWindow1,
          textString="Win1"),
        Text(
          extent={{20,74},{40,66}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          visible=withDoor2,
          textString="D2"),
        Text(
          extent={{-10,4},{10,-4}},
          lineColor={255,255,255},
          fillColor={255,85,85},
          fillPattern=FillPattern.Solid,
          origin={-70,-30},
          rotation=90,
          visible=withDoor1,
          textString="D1"),
        Line(points={{-60,46},{-30,46}}, color={255,255,255}),
        Line(points={{-46,60},{-46,30}}, color={255,255,255})}), Documentation(
        revisions="<html><ul>
  <li>
    <i>April 23, 2020</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/752\">#752</a>:
    Propagate all parameters correctly. Extend from new partial room
    model. Delete TIR and TMC. Tidy up.
  </li>
  <li>
    <i>Mai 7, 2015</i> by Ana Constantin:<br/>
    Grount temperature depends on TRY
  </li>
  <li>
    <i>April 18, 2014</i> by Ana Constantin:<br/>
    Added documentation
  </li>
  <li>
    <i>July 7, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for a room with
  2&#160;outer&#160;walls,&#160;1&#160;inner&#160;wall&#160;load,&#160;1&#160;inner&#160;wall&#160;simple,&#160;1&#160;floor&#160;towards&#160;ground,&#160;1&#160;ceiling&#160;towards&#160;upper&#160;floor.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The following figure presents the room's layout:
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/2OW_1IWl_1IWs_1Gr_Pa.png\"
  alt=\"Room layout\">
</p>
<p>
  <b><span style=\"color: #008000;\">Ground temperature</span></b>
</p>
<p>
  The ground temperature can be coupled to any desired prescriped
  temperature. Anyway, suitable ground temperatures depending on
  locations in Germany are listed as Θ'_m,e in the comprehensive table
  1 in \"Beiblatt 1\" in the norm DIN EN 12831.
</p>
<p>
  Or a ground temperature can be chosen according to a TRY region,
  which is listed below: if ...
</p>
<p>
  TRY_Region == 1 then 282.15 K
</p>
<p>
  TRY_Region == 2 then 281.55 K
</p>
<p>
  TRY_Region == 3 then 281.65 K
</p>
<p>
  TRY_Region == 4 then 282.65 K
</p>
<p>
  TRY_Region == 5 then 281.25 K
</p>
<p>
  TRY_Region == 6 then 279.95 K
</p>
<p>
  TRY_Region == 7 then 281.95 K
</p>
<p>
  TRY_Region == 8 then 279.95 K
</p>
<p>
  TRY_Region == 9 then 281.05 K
</p>
<p>
  TRY_Region == 10 then 276.15 K
</p>
<p>
  TRY_Region == 11 then 279.45 K
</p>
<p>
  TRY_Region == 12 then 283.35 K
</p>
<p>
  TRY_Region == 13 then 281.05 K
</p>
<p>
  TRY_Region == 14 then 281.05 K
</p>
<p>
  TRY_Region == 15 then 279.95 K
</p>
</html>"));
end Ow2IwL1IwS1Gr1Uf1;
