within AixLib.PlugNHarvest.Components.Rooms;
model Room
  "Room 1 vertical outer wall (facade) and the rest towards the building."
  ///////// construction parameters
  // Outer wall type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW=
   AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S()
    annotation (Dialog(tab="Types"), choicesAllMatching = true);
  //Inner wall Types
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW1=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() "wall type IW1"
    annotation (Dialog(tab="Types", descriptionLabel=true));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW2=AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() "wall type IW2"
    annotation (Dialog(tab="Types", descriptionLabel=true));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW3=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() "wall type IW3"
    annotation (Dialog(tab="Types", descriptionLabel=true));
  // Floor to ground type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=
  AixLib.DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML()
    annotation (Dialog(tab="Types"), choicesAllMatching = true);
  // Ceiling to upper floor type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE=
      AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf()
    annotation (Dialog(tab="Types"), choicesAllMatching = true);
  //Window type
  parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
    Type_Win=
      AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009()
      annotation (Dialog(tab="Types"));
  parameter Modelica.SIunits.Temperature T0_air=295.15 "Air"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_OW1=295.15 "OW1"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_IW1=295.15 "IW1"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_IW2a=295.15 "IW2a"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_IW2b=295.15 "IW2b"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_IW3=295.15 "IW3"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_CE=295.13 "Ceiling"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.SIunits.Temperature T0_FL=295.13 "Floor"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  //////////room geometry
  parameter Modelica.SIunits.Length room_length=2 "length"
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Length room_width=2 "width "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  parameter Modelica.SIunits.Height room_height=2 "height "
    annotation (Dialog(group="Dimensions", descriptionLabel=true));
  // Outer walls properties
  parameter Real solar_absorptance_OW=0.25 "Solar absoptance outer walls "
    annotation (Dialog(group="Outer wall properties", descriptionLabel=true));

  parameter Integer ModelConvOW=1 "Heat Convection Model" annotation (Dialog(
      group="Outer wall properties",
      compact=true,
      descriptionLabel=true), choices(
      choice=1 "DIN 6946",
      choice=2 "ASHRAE Fundamentals",
      choice=3 "Custom alpha",
      radioButtons=true));
  // Windows and Doors
  parameter Boolean withWindow1=true "Window 1" annotation (Dialog(
      group="Windows and Doors",
      joinNext=true,
      descriptionLabel=true), choices(checkBox=true));
  parameter Modelica.SIunits.Area windowarea_OW1=0 "Window area " annotation (
      Dialog(
      group="Windows and Doors",
      descriptionLabel=true,
      enable=withWindow1));
  // Sunblind
  parameter Boolean use_sunblind = false
    "Will sunblind become active automatically?"
    annotation(Dialog(group = "Sunblind"));
  parameter Real ratioSunblind(min=0.0, max=1.0) = 0.8
    "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
    annotation(Dialog(group = "Sunblind", enable=use_sunblind));
  parameter Modelica.SIunits.Irradiance solIrrThreshold(min=0.0) = 350
    "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
    annotation(Dialog(group = "Sunblind", enable=use_sunblind));
  parameter Modelica.SIunits.Temperature TOutAirLimit = 293.15
    "Temperature at which sunblind closes (see also solIrrThreshold)"
    annotation(Dialog(group = "Sunblind", enable=use_sunblind));

   // heat bridge parameters
  parameter Boolean withHeatBridge = false "Choose if heat bridges should be considered or not" annotation(Dialog(group = "Heat bridges", enable= outside, compact = false));
  parameter Modelica.SIunits.ThermalConductivity psiHor = 5 "Horizontal heat bridge coefficient" annotation(Dialog(group = "Heat bridges", enable = withHeatBridge));
  parameter Modelica.SIunits.ThermalConductivity psiVer = 5 "Horizontal heat bridge coefficient" annotation(Dialog(group = "Heat bridges", enable = withHeatBridge));
 replaceable package AirModel = AixLib.Media.Air "Air model" annotation (choicesAllMatching = true);

   // smart facade
  parameter Boolean withSmartFacade = false annotation (Dialog( tab = "Smart Facade", enable = outside), choices(checkBox=true));
  // Mechanical ventilation
  parameter Boolean withMechVent = false "with mechanical ventilation" annotation (Dialog( tab = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
  // PV
  parameter Boolean withPV = false "with photovoltaics" annotation (Dialog( tab = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
  //solar air heater
  parameter Boolean withSolAirHeat = false "with Solar Air Heater" annotation (Dialog( tab = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
  parameter Integer NrPVpanels=5 "Number of panels" annotation(Dialog(tab = "Smart Facade", enable = withPV));
  parameter AixLib.DataBase.SolarElectric.PVBaseRecord dataPV = AixLib.DataBase.SolarElectric.SymphonyEnergySE6M181()
                                                                 "PV data set" annotation(Dialog(tab = "Smart Facade", enable = withPV));
  parameter Modelica.SIunits.Power PelPV_max = 4000
    "Maximum output power for inverter" annotation(Dialog(tab = "Smart Facade", enable = withPV));

   // solar air heater
  parameter Modelica.SIunits.MassFlowRate MassFlowSetPoint=0.0306
    "Mass Flow Set Point for solar air heater" annotation(Dialog(tab = "Smart Facade", group = "Solar Air Heater", enable = withSolAirHeat));
  parameter Modelica.SIunits.Area CoverArea=1.2634
    "Cover Area for solar air heater" annotation(Dialog(tab = "Smart Facade", group = "Solar Air Heater", enable = withSolAirHeat));
  parameter Modelica.SIunits.Area InnerCrossSection=0.01181
    "Channel Cross Section for solar air heater" annotation(Dialog(tab = "Smart Facade", group = "Solar Air Heater", enable = withSolAirHeat));
  parameter Modelica.SIunits.Length Perimeter=1.348
    "Perimeter for solar air heater" annotation(Dialog(tab = "Smart Facade", group = "Solar Air Heater", enable = withSolAirHeat));
  parameter Modelica.SIunits.Length SAHLength1=1.8
    "Channel Length 1 for solar air heater" annotation(Dialog(tab = "Smart Facade", group = "Solar Air Heater", enable = withSolAirHeat));
  parameter Modelica.SIunits.Length SAHLength2=1.5
    "Channel Length 2 for solar air heater" annotation(Dialog(tab = "Smart Facade", group = "Solar Air Heater", enable = withSolAirHeat));
  parameter Modelica.SIunits.HeatCapacity AbsorberHeatCapacity=3950
    "Absorber Heat Capacityfor solar air heater" annotation(Dialog(tab = "Smart Facade", group = "Solar Air Heater", enable = withSolAirHeat));
  parameter Modelica.SIunits.TransmissionCoefficient CoverTransmitance=0.84
    "Cover Transmitance for solar air heater" annotation(Dialog(tab = "Smart Facade", group = "Solar Air Heater", enable = withSolAirHeat));
  parameter Modelica.SIunits.ThermalConductance CoverConductance=3.2
    "Cover Conductance for solar air heater" annotation(Dialog(tab = "Smart Facade", group = "Solar Air Heater", enable = withSolAirHeat));

  Walls.Wall                                          outside_wall1(
    solar_absorptance=solar_absorptance_OW,
    windowarea=windowarea_OW1,
    T0=T0_OW1,
    wall_length=room_length,
    wall_height=room_height,
    withWindow=withWindow1,
    WallType=Type_OW,
    WindowType=Type_Win,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    redeclare package AirModel = AirModel,
    withDoor=false,
    roomV=room_V,
    n50=n50,
    e=e,
    eps=eps,
    withPV=withPV,
    withSolAirHeat=withSolAirHeat,
    NrPVpanels=NrPVpanels,
    dataPV=dataPV,
    PelPV_max=PelPV_max,
    withHeatBridge=withHeatBridge,
    psiHor=psiHor,
    psiVer=psiVer,
    redeclare model HeatBridge = Walls.HeatBridgeLinear,
    withSmartFacade=withSmartFacade,
    withMechVent=withMechVent,
    redeclare model Window =
        ThermalZones.HighOrder.Components.WindowsDoors.WindowSimple,
    MassFlowSetPoint=MassFlowSetPoint,
    CoverArea=CoverArea,
    InnerCrossSection=InnerCrossSection,
    Perimeter=Perimeter,
    SAHLength1=SAHLength1,
    SAHLength2=SAHLength2,
    AbsorberHeatCapacity=AbsorberHeatCapacity,
    CoverTransmitance=CoverTransmitance,
    CoverConductance=CoverConductance)
    annotation (Placement(transformation(extent={{-64,-14},{-54,42}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall1(
    T0=T0_IW1,
    outside=false,
    wall_length=room_width,
    wall_height=room_height,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false,
    WallType=wallType_IW1)
                    annotation (Placement(transformation(
        origin={23,59},
        extent={{-5.00018,-29},{5.00003,29}},
        rotation=270)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall3(
    T0=T0_IW3,
    outside=false,
    wall_length=room_width,
    wall_height=room_height,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false,
    WallType=wallType_IW3)
                    annotation (Placement(transformation(
        origin={25,-59},
        extent={{-5.00002,-29},{5.00001,29}},
        rotation=90)));
  AixLib.Fluid.MixingVolumes.MixingVolumeMoistAir         airload(V=room_V,
    redeclare package Medium = AirModel,
    nPorts=4,
    m_flow_nominal=room_V*0.2*1.2/3600)
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Ceiling(
    T0=T0_CE,
    outside=false,
    WallType=Type_CE,
    wall_length=room_length,
    wall_height=room_width,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false,
    ISOrientation=3) annotation (Placement(transformation(
        origin={-31,60},
        extent={{2,-9},{-2,9}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall floor(
    T0=T0_FL,
    outside=false,
    WallType=Type_FL,
    wall_length=room_length,
    wall_height=room_width,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false,
    ISOrientation=2)  annotation (Placement(
        transformation(
        origin={-27,-60},
        extent={{-2.00002,-11},{2.00001,11}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall3
    annotation (Placement(transformation(extent={{34,-104},{54,-84}})));
  AixLib.Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1
    annotation (Placement(transformation(extent={{-109.5,50},{-89.5,70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
    annotation (Placement(transformation(extent={{80,60},{100,80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom
    annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  AixLib.Utilities.Interfaces.RadPort starRoom
    annotation (Placement(transformation(extent={{10,10},{30,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ground
    annotation (Placement(transformation(extent={{-16,-104},{4,-84}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall2(
    T0=T0_IW2b,
    outside=false,
    wall_height=room_height,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    withDoor=false,
    wall_length=room_length,
    WallType=wallType_IW2)   annotation (Placement(transformation(
        origin={64,6},
        extent={{-4,-24},{4,24}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2b
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tair
    annotation (Placement(transformation(extent={{24,-20},{38,-6}})));
  AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort thermStar_Demux
    annotation (Placement(transformation(
        extent={{-10,8},{10,-8}},
        rotation=90,
        origin={-20,-26})));

  // Infiltration rate
  parameter Real n50(unit="h-1") = 3 "Air exchange rate at 50 Pa pressure difference"
    annotation (Dialog(tab="Infiltration"));
  parameter Real e=0.02 "Coefficient of windshield"
    annotation (Dialog(tab="Infiltration"));
  parameter Real eps=1.0 "Coefficient of height"
    annotation (Dialog(tab="Infiltration"));
protected
  parameter Modelica.SIunits.Volume room_V=room_length*room_width*room_height;
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports[1](redeclare
      package Medium = AirModel) "Fluid inlets and outlets"
    annotation (Placement(transformation(extent={{-70,-104},{-12,-84}})));
public
  AixLib.BoundaryConditions.WeatherData.Bus weaBus "Bus with weather data"
    annotation (Placement(transformation(extent={{-108,-10},{-88,10}})));
  Modelica.Blocks.Interfaces.RealInput mWat_flow
    "Water flow rate added into the medium" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={86,-104}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={76,-94})));
  Modelica.Blocks.Interfaces.RealInput Schedule_mechVent if withMechVent
    "schedule mechanical ventilation" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-72}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,-70})));
equation
  connect(thermInsideWall3, thermInsideWall3)
    annotation (Line(points={{44,-94},{44,-94}}, color={191,0,0}));
  connect(starRoom, thermStar_Demux.portRad) annotation (Line(
      points={{20,20},{20,4},{-14.2,4},{-14.2,-15.6}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(inside_wall2.thermStarComb_inside, thermStar_Demux.portConvRadComb)
    annotation (Line(points={{60,6},{40,6},{40,-40},{-18.7,-40},{-18.7,-35.8}},
        color={191,0,0}));
  connect(inside_wall1.thermStarComb_inside, thermStar_Demux.portConvRadComb)
    annotation (Line(points={{23,54},{23,54},{23,40},{-40,40},{-40,-40},{-18.7,
          -40},{-18.7,-35.8}}, color={191,0,0}));
  connect(inside_wall3.port_outside, thermInsideWall3) annotation (Line(points={{25,
          -64.25},{25,-77.375},{44,-77.375},{44,-94}},      color={191,0,0}));
  connect(inside_wall2.port_outside, thermInsideWall2b) annotation (Line(points=
         {{68.2,6},{77.225,6},{77.225,-10},{90,-10}}, color={191,0,0}));
  connect(inside_wall1.port_outside, thermInsideWall1) annotation (Line(points={{23,
          64.2502},{23,76.3751},{30,76.3751},{30,90}},      color={191,0,0}));
  connect(Ceiling.port_outside, thermCeiling)
    annotation (Line(points={{-31,62.1},{-31,70},{90,70}}, color={191,0,0}));
  connect(thermStar_Demux.portConv, thermRoom) annotation (Line(points={{-25.1,
          -15.9},{-25.1,0.05},{-20,0.05},{-20,20}}, color={191,0,0}));
  connect(inside_wall3.thermStarComb_inside, thermStar_Demux.portConvRadComb)
    annotation (Line(points={{25,-54},{25,-40},{-18.7,-40},{-18.7,-35.8}},
        color={191,0,0}));
  connect(outside_wall1.thermStarComb_inside, thermStar_Demux.portConvRadComb)
    annotation (Line(points={{-54,14},{-40,14},{-40,-40},{-18.7,-40},{-18.7,
          -35.8}},
        color={191,0,0}));
  connect(Ceiling.thermStarComb_inside, thermStar_Demux.portConvRadComb)
    annotation (Line(points={{-31,58},{-31,40},{-40,40},{-40,-40},{-18.7,-40},{
          -18.7,-35.8}}, color={191,0,0}));
  connect(SolarRadiationPort_OW1, outside_wall1.SolarRadiationPort) annotation (
     Line(points={{-99.5,60},{-80,60},{-80,39.6667},{-65.5,39.6667}}, color={
          255,128,0}));
  connect(thermCeiling, thermCeiling) annotation (Line(points={{90,70},{85,70},
          {85,70},{90,70}}, color={191,0,0}));
  connect(ground, floor.port_outside) annotation (Line(
      points={{-6,-94},{-6,-74},{-24,-74},{-24,-62.1},{-27,-62.1}},
      color={191,0,0}));
  connect(floor.thermStarComb_inside, thermStar_Demux.portConvRadComb)
    annotation (Line(points={{-27,-58},{-27,-40},{-18.7,-40},{-18.7,-35.8}},
        color={191,0,0}));
  connect(airload.heatPort, Tair.port) annotation (Line(points={{0,-10},{-4,-10},
          {-4,-40},{40,-40},{40,-13},{24,-13}}, color={191,0,0}));
  connect(airload.heatPort, thermRoom) annotation (Line(points={{0,-10},{-4,-10},
          {-4,-40},{-40,-40},{-40,40},{-20,40},{-20,20}}, color={191,0,0}));
  connect(airload.ports[1:1], ports) annotation (Line(points={{7,-20},{7,-30},{8,
          -30},{8,-40},{-41,-40},{-41,-94}}, color={0,127,255}));
  connect(outside_wall1.weaBus, weaBus) annotation (Line(
      points={{-67,14},{-67,0},{-98,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(airload.mWat_flow, mWat_flow) annotation (Line(points={{-2,-2},{-14,-2},
          {-14,-40},{86,-40},{86,-104}}, color={0,0,127}));
  connect(outside_wall1.port_b, airload.ports[3]) annotation (Line(points={{-52.3125,
          -4.84167},{-40,-4.84167},{-40,-40},{12,-40},{12,-40},{12,-20},{11,-20}},
        color={0,127,255}));
  connect(outside_wall1.port_a, airload.ports[4]) annotation (Line(points={{-52.3125,
          -10.325},{-46,-10.325},{-46,-10},{-40,-10},{-40,-40},{12,-40},{12,-20},
          {13,-20}}, color={0,127,255}));
  if withMechVent then
    connect(Schedule_mechVent, outside_wall1.Schedule_mechVent) annotation (Line(
        points={{-100,-72},{-80,-72},{-80,-5.95},{-66.375,-5.95}}, color={0,0,127}));
  end if;
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
        Text(
          extent={{-25,6},{25,-6}},
          lineColor={255,255,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          origin={-70,-25},
          rotation=90,
          textString="Win1",
          visible=withWindow1)}),                              Documentation(
        revisions="<html>
 <ul>
 <li><i>Mai 7, 2015</i> by Ana Constantin:<br/>Grount temperature depends on TRY</li>
 <li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
 <li><i>July 7, 2011</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>", info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>Model for a room with 1&nbsp;outer&nbsp;wall,&nbsp;2&nbsp;inner&nbsp;walls&nbsp;load,&nbsp;1&nbsp;inner&nbsp;wall&nbsp;simple,&nbsp;1&nbsp;floor&nbsp;towards&nbsp;ground,&nbsp;1&nbsp;ceiling&nbsp;towards&nbsp;upper&nbsp;floor. </p>
<p><b><span style=\"color: #008000;\">Concept</span></b> </p>
<p>The following figure presents the room&apos;s layout: </p>
<p><img src=\"modelica://AixLib/Resources/Images/PnH/RoomEnvelope.png\" alt=\"Room layout\"/> </p>
<p><b><span style=\"color: #008000;\">Ground temperature</span></b> </p>
<p>The ground temperature can be coupled to any desired prescriped temperature. </p>
</html>"));
end Room;
