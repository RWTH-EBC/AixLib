within AixLib.PlugNHarvest.Aggregation;
model Room_EnergySyst "Room and energy system"
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

    //**************************E N E R G Y   S Y S T E M ************************
  parameter Modelica.SIunits.Power Pmax_heater = 1000 "maximal power output heater" annotation(Dialog(group = "Energy system", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature Tset_heater = 293.12 "set temperature for heating" annotation(Dialog(group = "Energy system", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature Tout_isHeatOn = 288.12 "Touside under which heating is on" annotation(Dialog(group = "Energy system", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature Tset_chiller = 296.12 "set temperature for cooling" annotation(Dialog(group = "Energy system", descriptionLabel = true));
  parameter Modelica.SIunits.Power Pmax_chiller = 1000 "maximal power output chiller" annotation(Dialog(group = "Energy system", descriptionLabel = true));


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
  parameter Real RatioConvectiveHeat_persons = 0.5
  "Ratio of convective heat from overall heat output for persons"                                        annotation(Dialog(tab = "Advanced", group="Internal gains", descriptionLabel = true));
  //lights
  parameter Real coeffThermal_lights = 0.9 "coeff = Pth/Pel for lights" annotation(Dialog(tab = "Advanced", group="Internal gains",descriptionLabel = true));
  parameter Real coeffRadThermal_lights = 0.89 "coeff = Pth,rad/Pth for lights" annotation(Dialog(tab = "Advanced", group="Internal gains",descriptionLabel = true));
  //electrical appliances
  parameter Real coeffThermal_elApp = 0.5 "coeff = Pth/Pel for el. appliances" annotation(Dialog(tab = "Advanced", group="Internal gains",descriptionLabel = true));
  parameter Real coeffRadThermal_elApp = 0.75 "coeff = Pth,rad/Pth for el. appliances" annotation(Dialog(tab = "Advanced", group="Internal gains", descriptionLabel = true));

    //**************************E N E R G Y   S Y S T E M ************************
  parameter Boolean isEl_heater = true "is heater electrical? (heat pump)" annotation(Dialog(tab = "Advanced", group = "Energy system", descriptionLabel = true));
  parameter Boolean isEl_cooler = true "is chiller electrical (chiller)"  annotation(Dialog(tab = "Advanced", group = "Energy system", descriptionLabel = true));
  parameter Real etaEl_heater = 2.5 "electrical efficiency of heater" annotation(Dialog(tab = "Advanced", group = "Energy system", descriptionLabel = true, enable = isEl_heater));
  parameter Real etaEl_cooler = 3.0 "electrical efficiency of chiller" annotation(Dialog(tab = "Advanced", group = "Energy system", descriptionLabel = true, enable = isEl_heater));
  Room_intGain room_intGain(
    redeclare package AirModel = AirModel,
    room_length=room_length,
    room_width=room_width,
    room_height=room_height,
    wallType_OW1=wallType_OW1,
    wallType_IW1=wallType_IW1,
    wallType_IW2=wallType_IW2,
    wallType_IW3=wallType_IW3,
    wallType_CE=wallType_CE,
    wallType_FL=wallType_FL,
    windowarea_OW1=windowarea_OW1,
    Type_Win=Type_Win,
    withSmartFacade=withSmartFacade,
    withMechVent=withMechVent,
    withPV=withPV,
    withSolAirHeat=withSolAirHeat,
    NrPVpanels=NrPVpanels,
    dataPV=dataPV,
    PelPV_max=PelPV_max,
    heatLoadForActivity=heatLoadForActivity,
    occupationDensity=occupationDensity,
    spPelSurface_lights=spPelSurface_lights,
    spPelSurface_elApp=spPelSurface_elApp,
    solar_absorptance_OW=solar_absorptance_OW,
    ModelConvOW=ModelConvOW,
    n50=n50,
    e=e,
    eps=eps,
    use_sunblind=use_sunblind,
    ratioSunblind=ratioSunblind,
    solIrrThreshold=solIrrThreshold,
    TOutAirLimit=TOutAirLimit,
    withHeatBridge=withHeatBridge,
    psiHor=psiHor,
    psiVer=psiVer,
    RatioConvectiveHeat_Persons=RatioConvectiveHeat_persons,
    coeffThermal_lights=coeffThermal_lights,
    coeffRadThermal_lights=coeffRadThermal_lights,
    coeffThermal_elApp=coeffThermal_elApp,
    coeffRadThermal_elApp=coeffRadThermal_elApp)
    annotation (Placement(transformation(extent={{-30,14},{32,72}})));
  Components.EnergySystem.IdealHeaterCooler.HeaterCoolerPI_withPel
    heaterCoolerPI_withPel(
    h_heater=Pmax_heater,
    h_cooler=Pmax_chiller,
    isEl_heater=isEl_heater,
    isEl_cooler=isEl_cooler,
    etaEl_heater=etaEl_heater,
    etaEl_cooler=etaEl_cooler)
    annotation (Placement(transformation(extent={{-36,-42},{10,2}})));
  Components.Controls.Cooler cooler(T_room_Threshold=Tset_chiller)
    annotation (Placement(transformation(extent={{-52,-88},{-24,-62}})));
  Components.Controls.Heater heater(Toutside_Threshold=Tset_heater,
      Troom_Threshold=Tout_isHeatOn)
    annotation (Placement(transformation(extent={{-6,-90},{22,-62}})));
  AixLib.Utilities.Interfaces.SolarRad_in solRadPort_Facade1
    annotation (Placement(transformation(extent={{-104,78},{-84,98}})));
  Modelica.Blocks.Interfaces.RealInput Schedule_lights "from 0 to 1"
    annotation (Placement(transformation(extent={{-120,-66},{-80,-26}}),
        iconTransformation(extent={{-100,-24},{-80,-4}})));
  Modelica.Blocks.Interfaces.RealInput Schedule_Occupants "from 0 to 1"
    annotation (Placement(transformation(extent={{-120,-108},{-80,-68}}),
        iconTransformation(extent={{-100,-50},{-80,-30}})));
  Modelica.Blocks.Interfaces.BooleanInput isChillerOn
    "On/Off switch for the chiller" annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-45,-101}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-96})));
  Modelica.Blocks.Interfaces.BooleanInput isHeaterOn
    "On/Off switch for the heater" annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={3,-99}),    iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-6,-94})));
  Modelica.Blocks.Interfaces.RealOutput Troom
    "Absolute temperature as output signal" annotation (Placement(
        transformation(extent={{78,-2},{98,18}}), iconTransformation(extent={{
            78,-2},{98,18}})));
  Modelica.Blocks.Interfaces.RealInput Schedule_elAppliances "from 0 to 1"
    annotation (Placement(transformation(extent={{-120,-86},{-80,-46}}),
        iconTransformation(extent={{-100,-66},{-80,-46}})));
  BoundaryConditions.WeatherData.Bus weaBus "Bus with weather data"
    annotation (Placement(transformation(extent={{-104,50},{-84,70}})));
  Modelica.Blocks.Interfaces.RealInput Schedule_mechVent if withMechVent
    "schedule mechanical ventilation"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
        iconTransformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.BooleanExpression switchToNight
    annotation (Placement(transformation(extent={{-54,-62},{-34,-42}})));
equation
  connect(heaterCoolerPI_withPel.heatCoolRoom, room_intGain.thermRoom)
    annotation (Line(points={{7.7,-28.8},{16,-28.8},{16,-36},{22,-36},{22,10},{
          -0.24,10},{-0.24,15.74}}, color={191,0,0}));
  connect(cooler.ControlBus, heaterCoolerPI_withPel.ControlBus_idealHeater)
    annotation (Line(
      points={{-24.035,-72.075},{-24.035,-56},{-31.35,-56},{-31.35,-40.24},{
          -23.35,-40.24}},
      color={255,204,51},
      thickness=0.5));
  connect(heater.ControlBus, heaterCoolerPI_withPel.ControlBus_idealCooler)
    annotation (Line(
      points={{21.965,-72.85},{26,-72.85},{26,-74},{32,-74},{32,-56},{-7.71,-56},
          {-7.71,-39.8}},
      color={255,204,51},
      thickness=0.5));
  connect(room_intGain.solRadPort_Facade, solRadPort_Facade1) annotation (Line(
        points={{-28.14,66.2},{-60,66.2},{-60,88},{-94,88}}, color={255,128,0}));
  connect(room_intGain.Schedule_lights, Schedule_lights) annotation (Line(
        points={{-26.59,34.01},{-60,34.01},{-60,-46},{-100,-46}}, color={0,0,
          127}));
  connect(room_intGain.Schedule_Occupants, Schedule_Occupants) annotation (Line(
        points={{-26.59,26.47},{-60,26.47},{-60,-88},{-100,-88}}, color={0,0,
          127}));
  connect(cooler.isOn, isChillerOn) annotation (Line(points={{-51.44,-63.69},{
          -60,-63.69},{-60,-101},{-45,-101}}, color={255,0,255}));
  connect(heater.isOn, isHeaterOn) annotation (Line(points={{-5.44,-63.82},{-10,
          -63.82},{-10,-99},{3,-99}},     color={255,0,255}));
  connect(room_intGain.Troom, Troom) annotation (Line(points={{31.38,43},{38,43},
          {38,8},{88,8}}, color={0,0,127}));
  connect(room_intGain.Schedule_elAppliances, Schedule_elAppliances)
    annotation (Line(points={{-26.59,18.35},{-60,18.35},{-60,-66},{-100,-66}},
        color={0,0,127}));
  connect(room_intGain.weaBus, weaBus) annotation (Line(
      points={{-28.76,59.82},{-86,59.82},{-86,60},{-94,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(cooler.Toutside, weaBus.TDryBul) annotation (Line(points={{-51.615,-75.585},
          {-60,-75.585},{-60,60},{-94,60}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(heater.Toutside, weaBus.TDryBul) annotation (Line(points={{-5.615,-76.63},
          {-10,-76.63},{-10,-100},{-60,-100},{-60,60},{-94,60}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  if withMechVent then
    connect(room_intGain.Schedule_mechVent, Schedule_mechVent) annotation (Line(
        points={{-26.9,42.42},{-60,42.42},{-60,0},{-100,0}},     color={0,0,127}));
  end if;
  connect(switchToNight.y, heater.switchToNightMode) annotation (Line(points={{
          -33,-52},{-24,-52},{-24,-68.125},{-5.93,-68.125}}, color={255,0,255}));
  connect(switchToNight.y, cooler.switchToNightMode) annotation (Line(points={{
          -33,-52},{-24,-52},{-24,-67.6875},{-51.93,-67.6875}}, color={255,0,
          255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-76,-86},{82,84}}, fileName=
              "modelica://AixLib/Resources/Images/PnH/PnH_Logo.png")}),    Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li><i>April, 2019&nbsp;</i> by Ana Constantin:<br>First implementation</li>
</ul>
</html>"));
end Room_EnergySyst;
