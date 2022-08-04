within AixLib.ThermalZones.HighOrder.Rooms.OFD;
model Attic_Ro2Lf5
  "Attic with 2 saddle roofs and a floor toward 5 rooms on the lower floor, with all other walls towards the outside"

  extends AixLib.ThermalZones.HighOrder.Rooms.BaseClasses.PartialRoom(    redeclare DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes,
    final room_V=roof_width1*roof_width2*sin(alfa)*0.5*length);

  //////////room geometry
  parameter Modelica.Units.SI.Length length=2 "length " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Length room1_length=2 "l1 " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Length room2_length=2 "l2 " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Length room3_length=2 "l3 " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Length room4_length=2 "l4 " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Length room5_length=2 "l5 " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true));
  parameter Modelica.Units.SI.Length width=2 "width " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Length room1_width=2 "w1 " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Length room2_width=2 "w2 " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Length room3_width=2 "w3 " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Length room4_width=2 "w4 " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Length room5_width=2 "w5 " annotation (Dialog(
      group="Dimensions",
      absoluteWidth=6,
      descriptionLabel=true));
  parameter Modelica.Units.SI.Length roof_width1=2 "wRO1" annotation (Dialog(
      group="Dimensions",
      absoluteWidth=28,
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Length roof_width2=2 "wRO2" annotation (Dialog(
      group="Dimensions",
      absoluteWidth=28,
      descriptionLabel=true));
  parameter Modelica.Units.SI.Angle alfa=Modelica.Units.Conversions.from_deg(90)
    "alfa" annotation (Dialog(group="Dimensions", descriptionLabel=true));
  // Outer walls properties
  parameter Real solar_absorptance_RO=0.25 "Solar absoptance roof "
    annotation (Dialog(tab="Outer walls", group="Solar absorptance", descriptionLabel=true));

  // Windows and Doors
  parameter Boolean withWindow1=false "Window 1 " annotation (
      Dialog(
      tab="Outer walls",
      group="Windows",
      joinNext=true,
      descriptionLabel=true), choices(checkBox=true));
  parameter Modelica.Units.SI.Area windowarea_RO1=0 "Window area" annotation (
      Dialog(
      tab="Outer walls",
      group="Windows",
      naturalWidth=10,
      descriptionLabel=true,
      enable=withWindow1));
  parameter Boolean withWindow2=false "Window 2 " annotation (
      Dialog(
      tab="Outer walls",
      group="Windows",
      joinNext=true,
      descriptionLabel=true), choices(checkBox=true));
  parameter Modelica.Units.SI.Area windowarea_RO2=0 "Window area" annotation (
      Dialog(
      tab="Outer walls",
      group="Windows",
      naturalWidth=10,
      descriptionLabel=true,
      enable=withWindow2));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall roof1(
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
    final solar_absorptance=solar_absorptance_RO,
    final wallPar=wallTypes.roof,
    withDoor=false,
    door_height=0,
    door_width=0,
    withWindow=withWindow1,
    windowarea=windowarea_RO1,
    wall_length=length,
    wall_height=roof_width1,
    ISOrientation=1,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
                     annotation (Placement(transformation(
        extent={{-5.00001,-29},{5.00001,29}},
        rotation=270,
        origin={-41,59})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall roof2(
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
    final solar_absorptance=solar_absorptance_RO,
    final wallPar=wallTypes.roof,
    withDoor=false,
    door_height=0,
    door_width=0,
    wall_height=roof_width2,
    withWindow=withWindow2,
    windowarea=windowarea_RO2,
    wall_length=length,
    ISOrientation=1,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
                     annotation (Placement(transformation(
        origin={47,59},
        extent={{-5,-27},{5,27}},
        rotation=270)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall floorRoom2(
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
    final wallPar=wallTypes.IW_hori_att_upp_half,
    wall_length=room2_length,
    wall_height=room2_width,
    withWindow=false,
    ISOrientation=2,
    outside=false,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
                    annotation (Placement(transformation(
        origin={-29,-44},
        extent={{-1.99999,-13},{1.99999,13}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall floorRoom1(
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
    final wallPar=wallTypes.IW_hori_att_upp_half,
    wall_length=room1_length,
    wall_height=room1_width,
    withWindow=false,
    ISOrientation=2,
    outside=false,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
                    annotation (Placement(transformation(
        origin={-60,-44},
        extent={{-2,-12},{2,12}},
        rotation=90)));

  AixLib.ThermalZones.HighOrder.Components.Walls.Wall floorRoom3(
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
    final wallPar=wallTypes.IW_hori_att_upp_half,
    wall_length=room3_length,
    wall_height=room3_width,
    withWindow=false,
    ISOrientation=2,
    outside=false,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
                    annotation (Placement(transformation(
        origin={3,-44},
        extent={{-1.99999,-13},{1.99999,13}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall floorRoom4(
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
    final wallPar=wallTypes.IW_hori_att_upp_half,
    wall_length=room4_length,
    wall_height=room4_width,
    withWindow=false,
    ISOrientation=2,
    outside=false,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
                    annotation (Placement(transformation(
        origin={35,-44},
        extent={{-1.99998,-13},{1.99999,13}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall floorRoom5(
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
    final wallPar=wallTypes.IW_hori_att_upp_half,
    wall_length=room5_length,
    wall_height=room5_width,
    withWindow=false,
    ISOrientation=2,
    outside=false,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
                    annotation (Placement(transformation(
        origin={69,-44},
        extent={{-1.99998,-13},{1.99998,13}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall OW1(
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
    withDoor=false,
    door_height=0,
    door_width=0,
    windowarea=windowarea_RO1,
    ISOrientation=1,
    wall_length=sqrt(VerticalWall_Area),
    wall_height=sqrt(VerticalWall_Area),
    withWindow=false,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
               annotation (Placement(transformation(extent={{-4,-21},{4,21}}, origin={-77,-22})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall OW2(
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
    withDoor=false,
    door_height=0,
    door_width=0,
    windowarea=windowarea_RO1,
    ISOrientation=1,
    wall_length=sqrt(VerticalWall_Area),
    wall_height=sqrt(VerticalWall_Area),
    withWindow=false,
    redeclare final model WindowModel = WindowModel,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin)
               annotation (Placement(transformation(
        extent={{-4,21},{4,-21}},
        rotation=180,
        origin={85,-16})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom1
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}}), iconTransformation(extent={{-90,-100},{-70,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom2
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}}), iconTransformation(extent={{-50,-100},{-30,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom3
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}}), iconTransformation(extent={{-10,-100},{10,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom4
    annotation (Placement(transformation(extent={{20,-100},{40,-80}}), iconTransformation(extent={{30,-100},{50,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom5
    annotation (Placement(transformation(extent={{60,-100},{80,-80}}), iconTransformation(extent={{70,-100},{90,-80}})));

  Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1
    annotation (Placement(transformation(extent={{-116,-30},{-96,-10}}), iconTransformation(extent={{-120,-30},{-100,-10}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-18}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-20})));

  Utilities.Interfaces.SolarRad_in SolarRadiationPort_RO2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={48,100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,90})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_RO1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-45.5,100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,90})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort if (calcMethodOut == 1 or calcMethodOut == 2)
                                                     annotation (Placement(
        transformation(extent={{-119.5,-10},{-99.5,10}}), iconTransformation(
          extent={{-119.5,10},{-99.5,30}})));
protected
  parameter Modelica.Units.SI.Length p=(width + roof_width2 + roof_width1)*0.5;
  // semi perimeter
  parameter Modelica.Units.SI.Area VerticalWall_Area=sqrt(p*(p - width)*(p -
      roof_width2)*(p - roof_width1));
  // Heron's formula

equation
  connect(SolarRadiationPort_RO1, roof1.SolarRadiationPort) annotation (Line(
        points={{-45.5,100},{-45.5,80},{-14.4167,80},{-14.4167,65.5}}, color={
          255,128,0}));
  connect(SolarRadiationPort_RO2, roof2.SolarRadiationPort) annotation (Line(
        points={{48,100},{48,80},{71.75,80},{71.75,65.5}}, color={255,128,0}));
  connect(roof1.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-19.7333,64.25},{-19.7333,80},{-80,80},{-80,0},{-109.5,0}},
                                                                     color={0,0,
          127}));
  connect(roof2.WindSpeedPort, WindSpeedPort) annotation (Line(points={{66.8,64.25},{66.8,80},{-80,80},{-80,0},{-109.5,0}},
                                                        color={0,0,127}));
  connect(floorRoom1.port_outside, thermRoom1) annotation (Line(points={{-60,-46.1},{-60,-90},{-90,-90}},
                                color={191,0,0}));
  connect(floorRoom2.port_outside, thermRoom2) annotation (Line(points={{-29,-46.1},{-29,-90},{-50,-90}},
                                       color={191,0,0}));
  connect(thermRoom3, floorRoom3.port_outside)
    annotation (Line(points={{-10,-90},{3,-90},{3,-46.1}}, color={191,0,0}));
  connect(thermRoom4, floorRoom4.port_outside) annotation (Line(points={{30,-90},{38,-90},{38,-70},{35,-70},{35,-46.1}},
                                                  color={191,0,0}));
  connect(floorRoom5.port_outside, thermRoom5) annotation (Line(points={{69,-46.1},{69,-84},{72,-84},{72,-88},{70,-88},{70,-90}},
                                                                color={191,0,0}));
  connect(OW1.WindSpeedPort, WindSpeedPort) annotation (Line(points={{-81.2,-6.6},{-86,-6.6},{-86,0},{-109.5,0}},
                                         color={0,0,127}));
  connect(OW1.SolarRadiationPort, SolarRadiationPort_OW1) annotation (Line(
        points={{-82.2,-2.75},{-86,-2.75},{-86,-20},{-106,-20}}, color={255,128,
          0}));
  connect(OW2.WindSpeedPort, WindSpeedPort) annotation (Line(points={{89.2,-0.6},{96,-0.6},{96,-48},{-88,-48},{-88,0},{-109.5,0}},
                                                           color={0,0,127}));
  connect(OW2.SolarRadiationPort, SolarRadiationPort_OW2) annotation (Line(
        points={{90.2,3.25},{100,3.25},{100,-18},{110,-18}}, color={255,128,0}));
  connect(thermOutside, roof2.port_outside) annotation (Line(points={{-100,100},{-98,100},{-98,98},{-88,98},{-88,74},{47,74},{47,64.25}}, color={191,0,0}));
  connect(thermOutside, roof1.port_outside) annotation (Line(points={{-100,100},{-88,100},{-88,74},{-41,74},{-41,64.25}}, color={191,0,0}));

  connect(thermOutside, OW1.port_outside) annotation (Line(points={{-100,100},{-84,100},{-84,-22},{-81.2,-22}}, color={191,0,0}));
  connect(floorRoom1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-60,-42},{-60,-40},{-7,-40},{-7,-8}},              color={191,0,0}));
  connect(floorRoom2.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-29,-42},{-7,-42},{-7,-8}},              color={191,0,0}));
  connect(floorRoom3.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{3,-42},{4,-42},{4,-38},{-7,-38},{-7,-8}},              color={191,0,0}));
  connect(floorRoom4.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{35,-42},{36,-42},{36,-38},{-7,-38},{-7,-8}},              color={191,0,0}));
  connect(floorRoom5.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{69,-42},{68,-42},{68,-38},{-7,-38},{-7,-8}},              color={191,0,0}));
  connect(OW1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-73,-22},{-56,-22},{-56,-40},{-7,-40},{-7,-8}},              color={191,0,0}));
  connect(roof1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-41,54},{-41,48},{-58,48},{-58,-22},{-56,-22},{-56,-40},{-7,-40},{-7,-8}},              color={191,0,0}));
  connect(roof2.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{47,54},{48,54},{48,46},{-58,46},{-58,-22},{-56,-22},{-56,-40},{-7,-40},{-7,-8}},              color={191,0,0}));
  connect(OW2.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{81,-16},{76,-16},{76,-38},{-7,-38},{-7,-8}}, color={191,0,0}));
  connect(OW2.port_outside, thermOutside) annotation (Line(points={{89.2,-16},{94,-16},{94,100},{-100,100},{-100,100}}, color={191,0,0}));
  annotation (Icon(graphics={
        Polygon(
          points={{-96,-60},{0,80},{96,-60},{82,-60},{0,60},{-82,-60},{-96,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175}),
        Polygon(
          points={{-24,0},{6,30},{-8,30},{-38,0},{-24,0}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          visible=withWindow1),
        Text(
          extent={{-36,10},{12,22}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          textString="Win1",
          visible=withWindow1),
        Polygon(
          points={{26,30},{56,0},{70,0},{40,30},{26,30}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          visible=withWindow2),
        Text(
          extent={{22,10},{70,22}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          textString="Win2",
          visible=withWindow2),
        Text(
          extent={{-28,-54},{30,-66}},
          lineColor={0,0,0},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString="width"),
        Line(points={{30,-60},{82,-60}}, color={0,0,0}),
        Line(points={{-82,-60},{-30,-60}}, color={0,0,0}),
        Line(points={{-100,-56},{-4,84}},color={0,0,0}),
        Line(points={{0,80},{-6,86}},  color={0,0,0}),
        Line(points={{-96,-60},{-102,-54}},color={0,0,0}),
        Text(
          extent={{-82,46},{-26,36}},
          lineColor={0,0,0},
          textString="wRO1"),
        Line(
          points={{3,-3},{-3,3}},
          color={0,0,0},
          origin={99,-57},
          rotation=90),
        Line(
          points={{-103,-59},{37,37}},
          color={0,0,0},
          origin={41,47},
          rotation=90),
        Line(
          points={{3,-3},{-3,3}},
          color={0,0,0},
          origin={3,83},
          rotation=90),
        Text(
          extent={{-28,5},{28,-5}},
          lineColor={0,0,0},
          origin={52,41},
          textString="wRO2"),
        Line(points={{-82,-60},{-82,-68}}, color={0,0,0}),
        Line(points={{82,-60},{82,-68}}, color={0,0,0})}), Documentation(
        revisions="<html><ul>
  <li>
    <i>April 23, 2020</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/752\">#752</a>:
    Propagate all parameters correctly. Extend from new partial room
    model. Delete TIR and TMC. Tidy up.
  </li>
  <li>
    <i>April 18, 2014</i> by Ana Constantin:<br/>
    Added documentation
  </li>
  <li>
    <i>July 8, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for an
  attic&#160;with&#160;2&#160;saddle&#160;roofs&#160;and&#160;a&#160;floor&#160;toward&#160;5&#160;rooms&#160;on&#160;the&#160;lower&#160;floor,&#160;with&#160;all&#160;other&#160;walls&#160;towards&#160;the&#160;outside.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The following figure presents the room's layout:
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/Attic_2Ro_5Rooms.png\"
  alt=\"Room layout\">
</p>
<p>
  We also tested a model where the attic has just one floor, over the
  whole building and each room connects to this component through the
  ceiling. However the model didn't lead to the expected lower
  simulation times, on the contrary. This model is also more correct,
  as it is not realistic to think that every layer of the attic's floor
  has a single temperature.
</p>
</html>"),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})));
end Attic_Ro2Lf5;
