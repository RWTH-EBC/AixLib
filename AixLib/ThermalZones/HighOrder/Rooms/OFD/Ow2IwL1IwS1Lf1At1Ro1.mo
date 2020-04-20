within AixLib.ThermalZones.HighOrder.Rooms.OFD;
model Ow2IwL1IwS1Lf1At1Ro1
  "2 outer walls, 1 inner wall load, 1 inner wall simple, 1 floor towards lower floor, 1 ceiling towards attic, 1 roof towards outside"

  extends AixLib.ThermalZones.HighOrder.Rooms.OFD.BaseClasses.PartialRoom(redeclare DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes,
    final room_V=room_length*room_width_long*
      room_height_long - room_length*(room_width_long - room_width_short)*(
      room_height_long - room_height_short)*0.5);

  ///////// construction parameters
  parameter Integer TMC=1 "Thermal Mass Class" annotation (Dialog(
      group="Construction parameters",
      compact=true,
      descriptionLabel=true), choices(
      choice=1 "Heavy",
      choice=2 "Medium",
      choice=3 "Light",
      radioButtons=true));
  parameter Integer TIR=1 "Thermal Insulation Regulation" annotation (Dialog(
      groupImage="modelica://AixLib/Resources/Images/Building/HighOrder/OW2_1IWl_1IWs_1Pa_1At1Ro.png",
      group="Construction parameters",
      compact=true,
      descriptionLabel=true), choices(
      choice=1 "EnEV_2009",
      choice=2 "EnEV_2002",
      choice=3 "WSchV_1995",
      choice=4 "WSchV_1984",
      radioButtons=true));


  parameter Modelica.SIunits.Temperature T0_OW1=295.15 "OW1"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_OW2=295.15 "OW2"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_IW1=295.15 "IW1"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_IW2=295.15 "IW2"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_CE=295.1  "Ceiling"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_RO=295.15 "Roof"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_FL=295.12 "Floor"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  //////////room geometry
  parameter Modelica.SIunits.Length room_length=2 "length "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length room_width_long=2 "w1 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length room_width_short=2 "w2 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Height room_height_long=2 "h1 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Height room_height_short=2 "h2 "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length roof_width=2 "wRO"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  // Windows and Doors
  parameter Boolean withWindow2=true "Window 2" annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true), choices(checkBox=true));
  parameter Modelica.SIunits.Area windowarea_OW2=0 "Window area " annotation (
      Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      enable=withWindow2));
  parameter Boolean withWindow3=true "Window 3 " annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true), choices(checkBox=true));
  parameter Modelica.SIunits.Area windowarea_RO=0 "Window area" annotation (
      Dialog(
      group="Windows and Doors",
      naturalWidth=10,
      descriptionLabel=true,
      enable=withWindow3));
  parameter Boolean withDoor2=true "Door 2" annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true), choices(checkBox=true));
  parameter Modelica.SIunits.Length door_width_OD2=0 "width " annotation (
      Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true,
      enable=withDoor2));
  parameter Modelica.SIunits.Length door_height_OD2=0 "height " annotation (
      Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      enable=withDoor2));

  parameter Real solar_absorptance_RO=0.25 "Solar absoptance roof "
    annotation (Dialog(group="Outer wall properties", descriptionLabel=true));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outside_wall1(
    solar_absorptance=solar_absorptance_OW,
    T0=T0_OW1,
    wall_length=room_length,
    wall_height=room_height_short,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    windowarea=0,
    withDoor=false,
    door_height=0,
    door_width=0,
    wallPar=wallTypes.OW)
                     annotation (Placement(transformation(extent={{-62,-20},{-52,38}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outside_wall2(
    solar_absorptance=solar_absorptance_OW,
    windowarea=windowarea_OW2,
    T0=T0_OW2,
    door_height=door_height_OD2,
    door_width=door_width_OD2,
    withWindow=withWindow2,
    withDoor=withDoor2,
    wall_length=room_width_long,
    wall_height=0.5*(room_height_long + room_height_short + room_width_short/room_width_long*(room_height_long - room_height_short)),
    WindowType=Type_Win,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    wallPar=wallTypes.OW,
    ISOrientation=1,
    U_door=U_door_OD2,
    eps_door=eps_door_OD2) annotation (Placement(transformation(
        origin={-29,59},
        extent={{-5.00001,-29},{5.00001,29}},
        rotation=270)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall1(
    T0=T0_IW1,
    outside=false,
    wallPar=wallTypes.IW2_vert_half_a,
    wall_length=room_length,
    wall_height=room_height_long,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false) annotation (Placement(transformation(
        origin={61,4.00001},
        extent={{-4.99999,-30},{5,30}},
        rotation=180)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall2(
    T0=T0_IW2,
    outside=false,
    wallPar=wallTypes.IW_vert_half_a,
    wall_length=room_width_long,
    wall_height=0.5*(room_height_long + room_height_short + room_width_short/room_width_long*(room_height_long - room_height_short)),
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false) annotation (Placement(transformation(
        origin={32,-59},
        extent={{-4.99998,-28},{4.99998,28}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Ceiling(
    T0=T0_CE,
    outside=false,
    wallPar=wallTypes.IW_hori_att_low_half,
    wall_length=room_length,
    wall_height=room_width_short,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false,
    ISOrientation=3) annotation (Placement(transformation(
        origin={22,60},
        extent={{1.99999,-10},{-1.99998,10}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall floor(
    T0=T0_FL,
    outside=false,
    wallPar=wallTypes.IW_hori_upp_half,
    wall_length=room_length,
    wall_height=room_width_long,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false,
    ISOrientation=2)                              annotation (Placement(transformation(
        origin={-27,-60},
        extent={{-2.00002,-11},{2.00001,11}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1
    annotation (Placement(transformation(extent={{80,0},{100,20}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort
    annotation (Placement(transformation(extent={{-109.5,-50},{-89.5,-30}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1
    annotation (Placement(transformation(extent={{-109.5,20},{-89.5,40}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW2 annotation (Placement(
        transformation(
        origin={44.5,101},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
    annotation (Placement(transformation(extent={{80,60},{100,80}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall roof(
    T0=T0_RO,
    solar_absorptance=solar_absorptance_RO,
    wall_length=room_length,
    withDoor=false,
    door_height=0,
    door_width=0,
    wall_height=roof_width,
    withWindow=withWindow3,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    windowarea=windowarea_RO,
    wallPar=wallTypes.roof,
    WindowType=Type_Win) annotation (Placement(transformation(
        origin={55,59},
        extent={{-2.99995,-17},{2.99997,17}},
        rotation=270)));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_Roof annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={74,100})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor annotation (
      Placement(transformation(extent={{-16,-104},{4,-84}}), iconTransformation(
          extent={{-16,-104},{4,-84}})));
protected
  parameter Real U_door_OD2=if TIR == 1 then 1.8 else 2.9 "U-value" annotation (
     Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true,
      enable=withDoor2));
  parameter Real eps_door_OD2=0.95 "eps" annotation (Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      enable=withDoor2));

  // Outer wall type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW=if TIR == 1
       then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S()
       else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M()
       else AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR == 2
       then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S()
       else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M()
       else AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR == 3
       then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S()
       else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M()
       else AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else if TMC == 1
       then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if TMC == 2
       then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M() else
      AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L()
    annotation (Dialog(tab="Types"));
  //Inner wall Types
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWsimple=if TIR ==
      1 then if TMC == 1 then
      AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half() else if TMC ==
      2 then AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() else
      AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_L_half() else if TIR ==
      2 then if TMC == 1 then
      AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_S_half() else if TMC ==
      2 then AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_M_half() else
      AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_L_half() else if TIR ==
      3 then if TMC == 1 then
      AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_S_half() else if
      TMC == 2 then
      AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_M_half() else
      AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_L_half() else if
      TMC == 1 then
      AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_S_half() else if
      TMC == 2 then
      AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_M_half() else
      AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_L_half()
    annotation (Dialog(tab="Types"));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload=if TIR == 1
       then if TMC == 1 then
      AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else if TMC ==
      2 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else
      AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else if TIR ==
      2 then if TMC == 1 then
      AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else if TMC ==
      2 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else
      AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else if TIR ==
      3 then if TMC == 1 then
      AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half() else if TMC ==
      2 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half() else
      AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half() else if TMC ==
      1 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half() else
      if TMC == 2 then
      AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half() else
      AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half()
    annotation (Dialog(tab="Types"));
  // Floor to lower floor type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=
  if TIR == 1
       then if TMC == 1 or TMC == 2 then
      AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf()
       else AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_L_upHalf()
       else if TIR == 2 then if TMC == 1 or TMC == 2 then
      AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_SM_upHalf()
       else AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf()
       else if TIR == 3 then if TMC == 1 or TMC == 2 then
      AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf()
       else
      AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_L_upHalf()
       else if TMC == 1 or TMC == 2 then
      AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf()
       else
      AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_L_upHalf()
    annotation (Dialog(tab="Types"));
  // Ceiling to attic type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE=if TIR == 1
       then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf()
       else if TIR == 2 then
      AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf()
       else if TIR == 3 then
      AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf()
       else
      AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf()
    annotation (Dialog(tab="Types"));
  // Saddle roof type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_RO=if TIR == 1
       then AixLib.DataBase.Walls.EnEV2009.Ceiling.ROsaddleRoom_EnEV2009_SML()
       else if TIR == 2 then
      AixLib.DataBase.Walls.EnEV2002.Ceiling.ROsaddleRoom_EnEV2002_SML() else
      if TIR == 3 then
      AixLib.DataBase.Walls.WSchV1995.Ceiling.ROsaddleRoom_WSchV1995_SML()
       else AixLib.DataBase.Walls.WSchV1984.Ceiling.ROsaddleRoom_WSchV1984_SML()
    annotation (Dialog(tab="Types"));
  //Window type
  parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
    Type_Win=if TIR == 1 then
      AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else if TIR ==
      2 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else
      if TIR == 3 then
      AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995() else
      AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984()
    annotation (Dialog(tab="Types"));

equation
  connect(outside_wall1.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-62.25,30.2667},{-80,30.2667},{-80,-40},{-99.5,-40}},
                                                                color={0,0,127}));
  connect(inside_wall2.port_outside, thermInsideWall2) annotation (Line(points={{32,-64.25},{32,-72},{30,-72},{30,-90}},
                                                   color={191,0,0}));
  connect(thermInsideWall2, thermInsideWall2)
    annotation (Line(points={{30,-90},{30,-90}}, color={191,0,0}));
  connect(inside_wall1.port_outside, thermInsideWall1) annotation (Line(points={{66.25,4.00001},{90,4.00001},{90,10}},
                                                 color={191,0,0}));
  connect(Ceiling.port_outside, thermCeiling)
    annotation (Line(points={{22,62.1},{22,70},{90,70}}, color={191,0,0}));
  connect(outside_wall2.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-7.73333,64.25},{-7.73333,64.25},{-7.73333,70},{-80,70},{-80,-40},{-99.5,-40}},
                 color={0,0,127}));
  connect(SolarRadiationPort_OW1, outside_wall1.SolarRadiationPort) annotation (
     Line(points={{-99.5,30},{-63.5,30},{-63.5,35.5833}}, color={255,128,0}));
  connect(outside_wall2.SolarRadiationPort, SolarRadiationPort_OW2) annotation (
     Line(points={{-2.41667,65.5},{-2.41667,70},{44.5,70},{44.5,92},{44.5,101}},
        color={255,128,0}));
  connect(roof.SolarRadiationPort, SolarRadiationPort_Roof) annotation (Line(
        points={{70.5833,62.8999},{70.5833,70},{74,70},{74,100}}, color={255,128,
          0}));
  connect(roof.WindSpeedPort, WindSpeedPort) annotation (Line(points={{67.4667,62.1499},{67.4667,70},{-80,70},{-80,-40},{-99.5,-40}},
                                                        color={0,0,127}));
  connect(thermFloor, floor.port_outside) annotation (Line(
      points={{-6,-94},{-8,-94},{-8,-66},{-22,-66},{-22,-62.1},{-27,-62.1}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(outside_wall2.port_outside, thermOutside) annotation (Line(points={{-29,64.25},{-29,100},{-100,100}}, color={191,0,0}));
  connect(roof.port_outside, thermOutside) annotation (Line(points={{55,62.1499},{55,72},{-29,72},{-29,100},{-100,100}}, color={191,0,0}));
  connect(outside_wall1.port_outside, thermOutside) annotation (Line(points={{-62.25,9},{-76,9},{-76,100},{-100,100}}, color={191,0,0}));
  connect(floor.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-27,-58},{-28,-58},{-28,-48},{-6.1875,-48},{-6.1875,-7.88}}, color={191,0,0}));
  connect(inside_wall2.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{32,-54},{32,-48},{-6,-48},{-6,-28},{-6.1875,-28},{-6.1875,-7.88}}, color={191,0,0}));
  connect(inside_wall1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{56,4.00001},{54,4.00001},{54,4},{44,4},{44,-48},{-6,-48},{-6,-28},{-6.1875,-28},{-6.1875,-7.88}}, color={191,0,0}));
  connect(roof.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{55,56},{54,56},{54,50},{44,50},{44,-48},{-6,-48},{-6,-28},{-6.1875,-28},{-6.1875,-7.88}}, color={191,0,0}));
  connect(Ceiling.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{22,58},{22,50},{44,50},{44,-48},{-6,-48},{-6,-28},{-6.1875,-28},{-6.1875,-7.88}}, color={191,0,0}));
  connect(outside_wall2.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-29,54},{-30,54},{-30,50},{44,50},{44,-48},{-6,-48},{-6,-28},{-6.1875,-28},{-6.1875,-7.88}}, color={191,0,0}));
  connect(outside_wall1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-52,9},{-40,9},{-40,50},{44,50},{44,-48},{-6,-48},{-6,-28},{-6.1875,-28},{-6.1875,-7.88}}, color={191,0,0}));
  annotation (Icon(graphics={
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
          origin={74,-4}),
        Rectangle(
          extent={{-60,60},{68,-68}},
          lineColor={0,0,0},
          fillColor={47,102,173},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,60},{-60,-80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,-68},{80,-80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,80},{40,60}},
          lineColor={0,0,0},
          fillColor={127,127,0},
          fillPattern=FillPattern.Solid,
          visible=withDoor2),
        Text(
          extent={{20,74},{40,66}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString="D2",
          visible=withDoor2),
        Text(
          extent={{-50,76},{0,64}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString="Win2",
          visible=withWindow2),
        Text(
          extent={{-56,52},{64,40}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString="width"),
        Line(points={{38,46},{68,46}}, color={255,255,255}),
        Line(points={{-60,46},{-30,46}}, color={255,255,255}),
        Text(
          extent={{-120,6},{0,-6}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          origin={-46,56},
          rotation=90,
          textString="length"),
        Line(points={{-46,60},{-46,30}}, color={255,255,255}),
        Line(points={{-46,-42},{-46,-68}}, color={255,255,255}),
        Rectangle(
          extent={{-80,30},{-60,-20}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          visible=withWindow3),
        Text(
          extent={{-25,6},{25,-6}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString="Win3",
          origin={-70,5},
          rotation=90,
          visible=withWindow3)}), Documentation(revisions="<html>
 <ul>
 <li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
 <li><i>July 8, 2011</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>", info="<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for a room with 2&nbsp;outer&nbsp;walls,&nbsp;1&nbsp;inner&nbsp;wall&nbsp;load,&nbsp;1&nbsp;inner&nbsp;wall&nbsp;simple,&nbsp;1&nbsp;floor&nbsp;towards&nbsp;lower&nbsp;floor,&nbsp;1&nbsp;ceiling&nbsp;towards&nbsp;attic,&nbsp;1&nbsp;roof&nbsp;towards&nbsp;outside.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The following figure presents the room&apos;s layout:</p>
 <p><img src=\"modelica://AixLib/Resources/Images/Building/HighOrder/OW2_1IWl_1IWs_1Pa_1At1Ro.png\"
    alt=\"Room layout\"/></p>
 </html>"));
end Ow2IwL1IwS1Lf1At1Ro1;
