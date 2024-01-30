within AixLib.ThermalZones.HighOrder.Rooms.OFD;
model Ow1IwL2IwS1Gr1Uf1
  "1 outer wall, 2 inner walls load, 1 inner wall simple, 1 floor towards ground, 1 ceiling towards upper floor"

  extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoom(    redeclare DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes,
                                                                          final room_V=room_length*room_width*room_height);

  //////////room geometry
  parameter Modelica.Units.SI.Length room_length=2 "length"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Length room_lengthb=1 "length_b "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Length room_width=2 "width "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.Units.SI.Height room_height=2 "height "
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
    U_door=U_door_OD1,
    eps_door=eps_door_OD1,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
                                           annotation (Placement(transformation(extent={{-60,-14},{-50,42}})));

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
    final wallPar=wallTypes.IW_vert_half_a,
    outside=false,
    wall_length=room_width,
    wall_height=room_height,
    withWindow=false,
    withDoor=false,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
                    annotation (Placement(transformation(
        origin={23,59},
        extent={{-5.00018,-29},{5.00003,29}},
        rotation=270)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall2a(
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
    wall_length=room_length - room_lengthb,
    wall_height=room_height,
    withWindow=false,
    withDoor=false,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
                    annotation (Placement(transformation(
        origin={61,23},
        extent={{-3,-15},{3,15}},
        rotation=180)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall3(
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
        origin={25,-59},
        extent={{-5.00002,-29},{5.00001,29}},
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
        origin={-31,60},
        extent={{2,-9},{-2,9}},
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
    outside=false,
    wall_length=room_length,
    wall_height=room_width,
    withWindow=false,
    withDoor=false,
    ISOrientation=2,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)      annotation (Placement(transformation(
        origin={-27,-60},
        extent={{-2.00002,-11},{2.00001,11}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall2b(
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
    wall_length=room_lengthb,
    wall_height=room_height,
    withWindow=false,
    withDoor=false,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
                    annotation (Placement(transformation(
        origin={61,-17},
        extent={{-3,-15},{3,15}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall3
    annotation (Placement(transformation(extent={{34,-104},{54,-84}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2a
    annotation (Placement(transformation(extent={{80,20},{100,40}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort if (calcMethodOut == 1 or calcMethodOut == 2)
                                                     annotation (Placement(
        transformation(extent={{-119.5,-70},{-99.5,-50}}), iconTransformation(
          extent={{-109.5,-70},{-89.5,-50}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1
    annotation (Placement(transformation(extent={{-109.5,50},{-89.5,70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
    annotation (Placement(transformation(extent={{80,60},{100,80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ground
    annotation (Placement(transformation(extent={{-16,-104},{4,-84}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2b
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1
    annotation (Placement(transformation(extent={{20,80},{40,100}})));

equation
  connect(thermInsideWall3, thermInsideWall3)
    annotation (Line(points={{44,-94},{44,-94}}, color={191,0,0}));
  connect(inside_wall3.port_outside, thermInsideWall3) annotation (Line(points={{25,-64.25},{25,-77.375},{44,-77.375},{44,-94}},
                                                            color={191,0,0}));
  connect(inside_wall2b.port_outside, thermInsideWall2b) annotation (Line(
        points={{64.15,-17},{77.225,-17},{77.225,-10},{90,-10}}, color={191,0,0}));
  connect(inside_wall2a.port_outside, thermInsideWall2a) annotation (Line(
        points={{64.15,23},{78.225,23},{78.225,30},{90,30}}, color={191,0,0}));
  connect(inside_wall1.port_outside, thermInsideWall1) annotation (Line(points={{23,64.2502},{23,76.3751},{30,76.3751},{30,90}},
                                                            color={191,0,0}));
  connect(Ceiling.port_outside, thermCeiling)
    annotation (Line(points={{-31,62.1},{-31,70},{90,70}}, color={191,0,0}));
  connect(outside_wall1.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-60.25,34.5333},{-80,34.5333},{-80,-60},{-109.5,-60}},
                                                                 color={0,0,127}));
  connect(SolarRadiationPort_OW1, outside_wall1.SolarRadiationPort) annotation (
     Line(points={{-99.5,60},{-80,60},{-80,39.6667},{-61.5,39.6667}}, color={
          255,128,0}));
  connect(thermCeiling, thermCeiling) annotation (Line(points={{90,70},{85,70},
          {85,70},{90,70}}, color={191,0,0}));
  connect(ground, floor.port_outside) annotation (Line(
      points={{-6,-94},{-6,-74},{-24,-74},{-24,-62.1},{-27,-62.1}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(floor.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-27,-58},{-26,-58},{-26,-48},{-7,-48},{-7,-8}},              color={191,0,0}));
  connect(inside_wall3.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{25,-54},{24,-54},{24,-48},{-7,-48},{-7,-8}},              color={191,0,0}));
  connect(inside_wall2b.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{58,-17},{56,-17},{56,-16},{50,-16},{50,-48},{-7,-48},{-7,-8}},              color={191,0,0}));
  connect(inside_wall2a.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{58,23},{56,23},{56,22},{50,22},{50,-48},{-7,-48},{-7,-8}},              color={191,0,0}));
  connect(inside_wall1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{23,54},{24,54},{24,44},{50,44},{50,-48},{-7,-48},{-7,-8}},              color={191,0,0}));
  connect(Ceiling.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-31,58},{-30,58},{-30,44},{50,44},{50,-48},{-7,-48},{-7,-8}},              color={191,0,0}));
  connect(outside_wall1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-50,14},{-44,14},{-44,44},{50,44},{50,-48},{-7,-48},{-7,-8}},              color={191,0,0}));
  connect(outside_wall1.port_outside, thermOutside) annotation (Line(points={{-60.25,14},{-78,14},{-78,100},{-100,100}}, color={191,0,0}));
  annotation (Icon(graphics={
        Rectangle(
          extent={{6,65},{-6,-65}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={74,-3},
          rotation=180),
        Rectangle(
          extent={{-60,68},{68,-68}},
          lineColor={0,0,0},
          fillColor={47,102,173},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,68},{-60,-80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,-68},{80,-80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,0},{-60,-50}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          visible=withWindow1),
        Rectangle(
          extent={{80,80},{-80,68}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,68},{68,26}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Line(points={{-46,68},{-46,38}}, color={255,255,255}),
        Line(points={{-60,54},{-30,54}}, color={255,255,255}),
        Text(
          extent={{-56,60},{62,48}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString="width"),
        Line(points={{38,54},{68,54}}, color={255,255,255}),
        Text(
          extent={{-126,6},{0,-6}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          origin={-46,64},
          rotation=90,
          textString="length"),
        Line(points={{-46,-38},{-46,-68}}, color={255,255,255}),
        Line(points={{68,26},{54,26}}, color={255,255,255}),
        Line(points={{58,-58},{58,-68}}, color={255,255,255}),
        Text(
          extent={{59,6},{-59,-6}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          origin={58,-21},
          rotation=90,
          textString="length_b"),
        Rectangle(
          extent={{-80,40},{-60,20}},
          lineColor={0,0,0},
          fillColor={127,127,0},
          fillPattern=FillPattern.Solid,
          visible=withDoor1),
        Text(
          extent={{-10,4},{10,-4}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString="D1",
          origin={-70,30},
          rotation=90,
          visible=withDoor1),
        Text(
          extent={{-25,6},{25,-6}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          origin={-70,-25},
          rotation=90,
          textString="Win1",
          visible=withWindow1),
        Line(points={{58,26},{58,18}}, color={255,255,255})}), Documentation(
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
<p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  Model for a room with
  1&#160;outer&#160;wall,&#160;2&#160;inner&#160;walls&#160;load,&#160;1&#160;inner&#160;wall&#160;simple,&#160;1&#160;floor&#160;towards&#160;ground,&#160;1&#160;ceiling&#160;towards&#160;upper&#160;floor.
</p>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
  The following figure presents the room's layout:
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/1OW_2IWl_2IWs_1Gr_Pa.png\"
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
end Ow1IwL2IwS1Gr1Uf1;
