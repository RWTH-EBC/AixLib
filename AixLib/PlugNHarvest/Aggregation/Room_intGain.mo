within AixLib.PlugNHarvest.Aggregation;
model Room_intGain "Room with internal gains"
      //  * * * * * * * * * * * * G  E  N  E  R  A  L * * * * * * * * * * * *
  replaceable package AirModel = AixLib.Media.Air "Air model" annotation (choicesAllMatching = true);
    //**************************E N V E L O P E ************************
    // room geometry
  parameter Modelica.SIunits.Length room_length=5 "room length"
    annotation (Dialog(group="Envelope", descriptionLabel=true));
  parameter Modelica.SIunits.Length room_width=3 "room width"
    annotation (Dialog(group="Envelope", descriptionLabel=true));
  parameter Modelica.SIunits.Height room_height=3 "room height"
    annotation (Dialog(group="Envelope", descriptionLabel=true));

  //wall types
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_OW1= AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() "wall type OW1"
    annotation (Dialog(group= "Envelope", descriptionLabel=true));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW1=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() "wall type IW1"
    annotation (Dialog(group= "Envelope", descriptionLabel=true));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW2=AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() "wall type IW2"
    annotation (Dialog(group= "Envelope", descriptionLabel=true));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW3=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() "wall type IW3"
    annotation (Dialog(group= "Envelope", descriptionLabel=true));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_CE=AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf() "wall type Ceiling"
    annotation (Dialog(group= "Envelope", descriptionLabel=true));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_FL=AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf() "wall type Floor"
    annotation (Dialog(group= "Envelope", descriptionLabel=true));

  // window
  parameter Modelica.SIunits.Area windowarea_OW1=0 "Window area " annotation (
      Dialog(
      group="Envelope",
      descriptionLabel=true,
      enable=withWindow1));
  parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
    Type_Win=
      AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() "window type"
      annotation (Dialog(group="Envelope"));

 //**************************S M A R T   F A C A D E ************************
  // smart facade
  parameter Boolean withSmartFacade = false annotation (Dialog( group = "Smart Facade", enable = outside), choices(checkBox=true));
  // Mechanical ventilation
  parameter Boolean withMechVent = false "with mechanical ventilation" annotation (Dialog( group = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
  // PV
  parameter Boolean withPV = false "with photovoltaics" annotation (Dialog( group = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
  //solar air heater
  parameter Boolean withSolAirHeat = false "with Solar Air Heater" annotation (Dialog( group = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
  parameter Integer NrPVpanels=5 "Number of panels" annotation(Dialog(group = "Smart Facade", enable = withPV));
  parameter AixLib.DataBase.SolarElectric.PVBaseRecord dataPV = AixLib.DataBase.SolarElectric.SymphonyEnergySE6M181()
                                                                 "PV data set" annotation(Dialog(group = "Smart Facade", enable = withPV));
  parameter Modelica.SIunits.Power PelPV_max = 4000
    "Maximum output power for inverter" annotation(Dialog(group = "Smart Facade", enable = withPV));

  //**************************I N T E R N A L  G A I N S ************************
  // persons
  parameter Modelica.SIunits.Power heatLoadForActivity = 80 "Sensible heat output occupants for activity at 20°C" annotation(Dialog(group = "Internal gains", descriptionLabel = true));
  parameter Real occupationDensity = 0.2 "Density of occupants in persons/m2" annotation(Dialog(group = "Internal gains", descriptionLabel = true));
  // lights
  parameter Real spPelSurface_lights(unit = "W/m2") =  22 "specific Pel/m2 for type of light source" annotation(Dialog(group = "Internal gains",descriptionLabel = true));
  //electrical appliances
  parameter Real spPelSurface_elApp(unit = "W/m2") =  22 "specific Pel/m2 for type of el. appliances" annotation(Dialog(group = "Internal gains",descriptionLabel = true));

  //  * * * * * * * * * * A  D  V  A  N  C  E  D * * * * * * * * * * * *
  //**************************E N V E L O P E ************************
  // Outer walls properties
  parameter Real solar_absorptance_OW=0.25 "Solar absoptance outer walls "
    annotation (Dialog(tab = "Advanced", group="Envelope", descriptionLabel=true));

  parameter Integer ModelConvOW=1 "Heat Convection Model" annotation (Dialog(
      tab = "Advanced", group="Envelope",
      compact=true,
      descriptionLabel=true), choices(
      choice=1 "DIN 6946",
      choice=2 "ASHRAE Fundamentals",
      choice=3 "Custom alpha",
      radioButtons=true));
    // Infiltration rate
  parameter Real n50(unit="h-1") = 3 "Air exchange rate at 50 Pa pressure differencefor infiltration "
    annotation (Dialog(tab = "Advanced", group="Envelope"));
  parameter Real e=0.02 "Coefficient of windshield for infiltration"
    annotation (Dialog(tab = "Advanced", group="Envelope"));
  parameter Real eps=1.0 "Coefficient of height for infiltration"
    annotation (Dialog(tab = "Advanced", group="Envelope"));
    // Sunblind
  parameter Boolean use_sunblind = false
    "Will sunblind become active automatically?"
    annotation(Dialog(tab = "Advanced", group="Envelope"));
  parameter Real ratioSunblind(min=0.0, max=1.0) = 0.8
    "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
    annotation(Dialog(tab = "Advanced", group="Envelope"));
  parameter Modelica.SIunits.Irradiance solIrrThreshold(min=0.0) = 350
    "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
    annotation(Dialog(tab = "Advanced", group="Envelope"));
  parameter Modelica.SIunits.Temperature TOutAirLimit = 293.15
    "Temperature at which sunblind closes (see also solIrrThreshold)"
    annotation(Dialog(tab = "Advanced", group="Envelope"));

   // Heat bridge
  parameter Boolean withHeatBridge = false "Choose if heat bridges should be considered or not" annotation(Dialog(tab = "Advanced", group = "Envelope", enable= outside, compact = false));
  parameter Modelica.SIunits.ThermalConductivity psiHor = 5 "Horizontal heat bridge coefficient" annotation(Dialog(tab = "Advanced", group = "Envelope", enable = withHeatBridge));
  parameter Modelica.SIunits.ThermalConductivity psiVer = 5 "Horizontal heat bridge coefficient" annotation(Dialog(tab = "Advanced", group = "Envelope", enable = withHeatBridge));

  //**************************I N T E R N A L  G A I N S ************************
  // persons
  parameter Real RatioConvectiveHeat_Persons = 0.5
  "Ratio of convective heat from overall heat output for persons"                                        annotation(Dialog(tab = "Advanced", group="Internal gains", descriptionLabel = true));
  //lights
  parameter Real coeffThermal_lights = 0.9 "coeff = Pth/Pel for lights" annotation(Dialog(tab = "Advanced", group="Internal gains",descriptionLabel = true));
  parameter Real coeffRadThermal_lights = 0.89 "coeff = Pth,rad/Pth for lights" annotation(Dialog(tab = "Advanced", group="Internal gains",descriptionLabel = true));
  //electrical appliances
  parameter Real coeffThermal_elApp = 0.5 "coeff = Pth/Pel for el. appliances" annotation(Dialog(tab = "Advanced", group="Internal gains",descriptionLabel = true));
  parameter Real coeffRadThermal_elApp = 0.75 "coeff = Pth,rad/Pth for el. appliances" annotation(Dialog(tab = "Advanced", group="Internal gains", descriptionLabel = true));
  Components.Rooms.Room room(
    room_length=room_length,
    room_width=room_width,
    room_height=room_height,
    solar_absorptance_OW=solar_absorptance_OW,
    ModelConvOW=ModelConvOW,
    redeclare package AirModel = AirModel,
    windowarea_OW1=windowarea_OW1,
    use_sunblind=use_sunblind,
    ratioSunblind=ratioSunblind,
    solIrrThreshold=solIrrThreshold,
    TOutAirLimit=TOutAirLimit,
    Type_OW=wallType_OW1,
    wallType_IW1=wallType_IW1,
    wallType_IW2=wallType_IW2,
    wallType_IW3=wallType_IW3,
    Type_FL=wallType_FL,
    Type_CE=wallType_CE,
    Type_Win=Type_Win,
    n50=n50,
    e=e,
    eps=eps,
    withHeatBridge=withHeatBridge,
    psiHor=psiHor,
    psiVer=psiVer,
    withSolAirHeat=withSolAirHeat,
    NrPVpanels=NrPVpanels,
    dataPV=dataPV,
    PelPV_max=PelPV_max,
    withPV=true,
    withSmartFacade=withSmartFacade,
    withMechVent=withMechVent)
    annotation (Placement(transformation(extent={{-24,16},{26,66}})));
  Components.InternalGains.Facilities.Facilities facilities(
    zoneArea=room_length*room_width,
    spPelSurface_elApp=spPelSurface_elApp,
    coeffThermal_elApp=coeffThermal_elApp,
    coeffRadThermal_elApp=coeffRadThermal_elApp,
    spPelSurface_lights=spPelSurface_lights,
    coeffThermal_lights=coeffThermal_lights,
    coeffRadThermal_lights=coeffRadThermal_lights)
    annotation (Placement(transformation(extent={{-60,-44},{-20,-8}})));
  Components.InternalGains.Occupants.Occupants occupants(ZoneArea=room.room_width
        *room.room_length,
    heatLoadForActivity=heatLoadForActivity,
    occupationDensity=occupationDensity,
    RatioConvectiveHeat=RatioConvectiveHeat_Persons)
    annotation (Placement(transformation(extent={{14,-42},{46,-10}})));
  AixLib.Utilities.Interfaces.SolarRad_in solRadPort_Facade
    annotation (Placement(transformation(extent={{-104,70},{-84,90}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow[5](
    Q_flow=fill(0, 5),
    T_ref=fill(20, 5),
    alpha=fill(0, 5))
    annotation (Placement(transformation(extent={{68,32},{46,54}})));
  Modelica.Blocks.Interfaces.RealInput Schedule_Occupants "from 0 to 1"
    annotation (Placement(transformation(extent={{-120,-112},{-80,-72}}),
        iconTransformation(extent={{-100,-68},{-78,-46}})));
  Modelica.Blocks.Interfaces.RealInput Schedule_lights "from 0 to 1"
    annotation (Placement(transformation(extent={{-120,-56},{-80,-16}}),
        iconTransformation(extent={{-100,-42},{-78,-20}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{62,-10},{82,10}})));
  Modelica.Blocks.Interfaces.RealOutput Troom
    "Absolute temperature as output signal"
    annotation (Placement(transformation(extent={{88,-10},{108,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom
    annotation (Placement(transformation(extent={{-14,-104},{6,-84}})));
  Modelica.Blocks.Interfaces.RealInput Schedule_elAppliances "from 0 to 1"
    annotation (Placement(transformation(extent={{-120,-84},{-80,-44}}),
        iconTransformation(extent={{-100,-96},{-78,-74}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus "Bus with weather data"
    annotation (Placement(transformation(extent={{-106,48},{-86,68}})));
  Modelica.Blocks.Sources.Constant source_personsHumidity(k=0)
    "temporary model for humidity output of persons"
    annotation (Placement(transformation(extent={{20,-66},{40,-46}})));
  Modelica.Blocks.Interfaces.RealInput Schedule_mechVent if withMechVent
    "schedule mechanical ventilation" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-4}),  iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={76,-94})));
equation
  connect(room.SolarRadiationPort_OW1, solRadPort_Facade) annotation (Line(
        points={{-23.875,56},{-24,56},{-24,54},{-40,54},{-40,80},{-94,80}},
        color={255,128,0}));
  connect(room.thermInsideWall1, fixedHeatFlow[1].port) annotation (Line(points=
         {{8.5,63.5},{8.5,80},{40,80},{40,43},{46,43}}, color={191,0,0}));
  connect(room.thermCeiling, fixedHeatFlow[2].port) annotation (Line(points={{
          23.5,58.5},{40,58.5},{40,43},{46,43}}, color={191,0,0}));
  connect(room.thermInsideWall2b, fixedHeatFlow[3].port) annotation (Line(
        points={{23.5,38.5},{40,38.5},{40,43},{46,43}}, color={191,0,0}));
  connect(room.thermInsideWall3, fixedHeatFlow[4].port) annotation (Line(points=
         {{12,17.5},{12,10},{40,10},{40,43},{46,43}}, color={191,0,0}));
  connect(room.ground, fixedHeatFlow[5].port) annotation (Line(points={{-0.5,
          17.5},{-0.5,10},{40,10},{40,43},{46,43}}, color={191,0,0}));
  connect(occupants.ConvHeat, room.thermRoom) annotation (Line(points={{44.4,
          -18},{50,-18},{50,0},{-4,0},{-4,46}}, color={191,0,0}));
  connect(occupants.RadHeat, room.starRoom) annotation (Line(points={{44.4,
          -27.6},{50,-27.6},{50,0},{-4,0},{-4,38},{6,38},{6,46}}, color={95,95,
          95}));
  connect(occupants.Schedule, Schedule_Occupants) annotation (Line(points={{
          15.44,-27.76},{0,-27.76},{0,-92},{-100,-92}}, color={0,0,127}));
  connect(facilities.Schedule_lights, Schedule_lights) annotation (Line(points=
          {{-58,-31.4},{-76,-31.4},{-76,-36},{-100,-36}}, color={0,0,127}));
  connect(facilities.ConvHeat[1], room.thermRoom) annotation (Line(points={{-22,
          -14.3},{-14,-14.3},{-14,-14},{-4,-14},{-4,46}}, color={191,0,0}));
  connect(facilities.ConvHeat[2], room.thermRoom) annotation (Line(points={{-22,
          -12.5},{-14,-12.5},{-14,-14},{-4,-14},{-4,46}}, color={191,0,0}));
  connect(facilities.RadHeat[1], room.starRoom) annotation (Line(points={{-22,
          -21.5},{-14,-21.5},{-14,-20},{-4,-20},{-4,38},{6,38},{6,46}}, color={
          95,95,95}));
  connect(facilities.RadHeat[2], room.starRoom) annotation (Line(points={{-22,
          -19.7},{-4,-19.7},{-4,38},{6,38},{6,46}}, color={95,95,95}));
  connect(room.thermRoom, temperatureSensor.port)
    annotation (Line(points={{-4,46},{-4,0},{62,0}}, color={191,0,0}));
  connect(temperatureSensor.T, Troom)
    annotation (Line(points={{82,0},{98,0}}, color={0,0,127}));
  connect(Troom, occupants.TAirZone) annotation (Line(points={{98,0},{100,0},{
          100,-100},{0,-100},{0,-28},{8,-28},{8,-14.8},{15.6,-14.8}}, color={0,
          0,127}));
  connect(room.thermRoom, thermRoom)
    annotation (Line(points={{-4,46},{-4,-94}}, color={191,0,0}));
  connect(facilities.Schedule_elAppliances, Schedule_elAppliances) annotation (
      Line(points={{-58,-24.2},{-76,-24.2},{-76,-64},{-100,-64},{-100,-64}},
        color={0,0,127}));
  connect(room.weaBus, weaBus) annotation (Line(
      points={{-23.5,41},{-40,41},{-40,80},{-72,80},{-72,58},{-96,58}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(source_personsHumidity.y, room.mWat_flow) annotation (Line(points={{
          41,-56},{50,-56},{50,0},{20,0},{20,17.5}}, color={0,0,127}));
  if withMechVent then
    connect(Schedule_mechVent, room.Schedule_mechVent) annotation (Line(points={{-100,
          -4},{-40,-4},{-40,23.5},{-21.5,23.5}}, color={0,0,127}));
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-80,82},{80,-78}},
          lineColor={12,176,191},
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-72,54},{70,-54}},
          lineColor={12,176,191},
          fillColor={170,255,255},
          fillPattern=FillPattern.None,
          textString="Room Envelope
+
Internal Gains")}),                                              Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li><i>April, 2019&nbsp;</i> by Ana Constantin:<br>First implementation</li>
</ul>
</html>"));
end Room_intGain;
