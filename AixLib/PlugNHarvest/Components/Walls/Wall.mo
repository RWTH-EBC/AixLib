within AixLib.PlugNHarvest.Components.Walls;
model Wall
  "Simple wall model for outside and inside walls with windows and doors"


  //Type parameter
  parameter Boolean outside = true "Choose if the wall is an outside or an inside wall" annotation(Dialog(group = "General Wall Type Parameter", compact = true), choices(choice = true "Outside Wall", choice = false "Inside Wall", radioButtons = true));

  // general wall parameters
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition WallType=
      AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S()
    "Choose an outside wall type from the database"
    annotation (Dialog(group="Room Geometry"), choicesAllMatching=true);
  parameter Modelica.SIunits.Length wall_length = 2 "Length of wall" annotation(Dialog(group = "Room Geometry"));
  parameter Modelica.SIunits.Height wall_height = 2 "Height of wall" annotation(Dialog(group = "Room Geometry"));
  parameter Modelica.SIunits.Angle compass = 0 "compass direction of wall (N=0deg, E=90deg, S=180deg, W=270deg)" annotation(Dialog(group = "Room Geometry", enable = outside));

  // Surface parameters
  parameter Real solar_absorptance = 0.25 "Solar absorptance coefficient of outside wall surface" annotation(Dialog(tab = "Surface Parameters", group = "Outside surface", enable = outside));
  parameter Integer Model = 1 "Choose the model for calculation of heat convection at outside surface" annotation(Dialog(tab = "Surface Parameters", group = "Outside surface", enable = outside, compact = true), choices(choice = 1 "DIN 6946", choice = 2 "ASHRAE Fundamentals", choice = 3 "Custom alpha", radioButtons = true));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_custom = 25 "Custom alpha for convection (just for manual selection, not recommended)" annotation(Dialog(tab = "Surface Parameters", group = "Outside surface", enable = Model == 3 and outside));
  parameter AixLib.DataBase.Surfaces.RoughnessForHT.PolynomialCoefficients_ASHRAEHandbook surfaceType = AixLib.DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster() "Surface type of outside wall" annotation(Dialog(tab = "Surface Parameters", group = "Outside surface", enable = Model == 2 and outside), choicesAllMatching = true);
  parameter Integer ISOrientation = 1 "Inside surface orientation" annotation(Dialog(tab = "Surface Parameters", group = "Inside surface", compact = true, descriptionLabel = true), choices(choice = 1 "vertical wall", choice = 2 "floor", choice = 3 "ceiling", radioButtons = true));
  parameter Integer calculationMethod = 1 "Choose the model for calculation of heat convection at inside surface" annotation(Dialog(tab = "Surface Parameters", group = "Inside surface", compact = true, descriptionLabel = true), choices(choice = 1 "EN ISO 6946 Appendix A >>Flat Surfaces<<", choice=2 "By Bernd Glueck", choice=3 "Constant alpha", radioButtons = true));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_constant = 2.5 "Constant alpha for convection (just for manual selection, not recommended)" annotation(Dialog(tab = "Surface Parameters", group = "Inside surface", enable = calculationMethod == 3));

  // window parameters
  parameter Boolean withWindow = false "Choose if the wall has got a window (only outside walls)" annotation(Dialog(tab = "Window", enable = outside));
  replaceable model Window =
      AixLib.ThermalZones.HighOrder.Components.WindowsDoors.WindowSimple
  constrainedby
    AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow
                                                                                  "Model for window" annotation(Dialog( tab="Window",  enable = withWindow and outside), choicesAllMatching=true);
  parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple WindowType = AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() "Choose a window type from the database" annotation(Dialog(tab = "Window", enable = withWindow and outside), choicesAllMatching = true);
  parameter Modelica.SIunits.Area windowarea = 2 "Area of window" annotation(Dialog(tab = "Window", enable = withWindow and outside));
  parameter Boolean withSunblind = false "enable support of sunblinding?" annotation(Dialog(tab = "Window", enable = outside and withWindow));
  parameter Real Blinding = 0 "blinding factor <=1" annotation(Dialog(tab = "Window", enable = withWindow and outside and withSunblind));
  parameter Real Limit = 180 "minimum specific total solar radiation in W/m2 for blinding becoming active" annotation(Dialog(tab = "Window", enable = withWindow and outside and withSunblind));

  // door parameters
  parameter Boolean withDoor = false "Choose if the wall has got a door" annotation(Dialog(tab = "Door"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer U_door = 1.8 "Thermal transmission coefficient of door" annotation(Dialog(tab = "Door", enable = withDoor));
  parameter Modelica.SIunits.Emissivity eps_door = 0.9 "Solar emissivity of door material" annotation(Dialog(tab = "Door", enable = withDoor));
  parameter Modelica.SIunits.Length door_height = 2 annotation(Dialog(tab = "Door", enable = withDoor));
  parameter Modelica.SIunits.Length door_width = 1 annotation(Dialog(tab = "Door", enable = withDoor));

  // Calculation of clearance
  final parameter Modelica.SIunits.Area clearance = if not outside and withDoor then door_height * door_width else if outside and withDoor and withWindow then windowarea + door_height * door_width else if outside and withWindow then windowarea else if outside and withDoor then door_height * door_width else 0 "Wall clearance";

  // heat bridge parameters
  parameter Boolean withHeatBridge = false "Choose if heat bridges should be considered or not" annotation(Dialog(tab = "Heat bridges", enable= outside, compact = false));
  parameter Modelica.SIunits.ThermalConductivity psiHor = 5 "Horizontal heat bridge coefficient" annotation(Dialog(tab = "Heat bridges", enable = withHeatBridge));
  parameter Modelica.SIunits.ThermalConductivity psiVer = 5 "Horizontal heat bridge coefficient" annotation(Dialog(tab = "Heat bridges", enable = withHeatBridge));

  // ventilation parameters
  parameter Modelica.SIunits.Volume roomV "room volume" annotation(Dialog(tab = "Infiltration", enable = outside));
  parameter Real n50(unit = "h-1") = 4
    "Air exchange rate at 50 Pa pressure difference" annotation(Dialog(tab = "Infiltration", enable = outside));
  parameter Real e = 0.03 "Coefficient of windshield" annotation(Dialog(tab = "Infiltration", enable = outside));
  parameter Real eps = 1.0 "Coefficient of height" annotation(Dialog(tab = "Infiltration", enable = outside));
  replaceable package AirModel = AixLib.Media.Air "Air model" annotation (choicesAllMatching = true);

  // Initial temperature
  parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(20) "Initial temperature" annotation(Dialog(tab = "Advanced Parameters"));

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

  // COMPONENT PART
    // Connectoren
  AixLib.Utilities.Interfaces.SolarRad_in
                                   SolarRadiationPort if outside annotation(Placement(transformation(extent={{-116,79},
            {-96,99}}),                                                                                                                              iconTransformation(extent = {{-36, 100}, {-16, 120}})));
  AixLib.Utilities.Interfaces.ConvRadComb thermStarComb_inside annotation (
      Placement(transformation(extent={{92,2},{110,20}}), iconTransformation(
          extent={{10,-10},{30,10}})));

  AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.ConvNLayerClearanceStar
    Wall(
    h=wall_height,
    l=wall_length,
    T0=T0,
    clearance=clearance,
    selectable=true,
    eps=WallType.eps,
    wallType=WallType,
    surfaceOrientation=ISOrientation,
    calcMethod=calculationMethod,
    alpha_constant=alpha_constant) "Wall"
    annotation (Placement(transformation(extent={{-14,20},{8,40}})));
  AixLib.Utilities.HeatTransfer.SolarRadToHeat
                                        SolarAbsorption(coeff = solar_absorptance, A = wall_height * wall_length - clearance) if outside  annotation(Placement(transformation(origin={-42,90},    extent={{-10,-10},
            {10,10}})));
  AixLib.ThermalZones.HighOrder.Components.Sunblinds.Sunblind Sunblind(
    final n=1,
    final gsunblind={Blinding},
    final Imax=LimitSolIrr,
    final TOutAirLimit=TOutAirLimit) if
                         outside and withWindow and withSunblind
    annotation (Placement(transformation(extent={{-44,-21},{-21,5}})));
  AixLib.ThermalZones.HighOrder.Components.WindowsDoors.Door
                                        Door(
    T0=T0,
    door_area=door_height*door_width,
    eps=eps_door,
    U=if outside then U_door else U_door*2) if withDoor
    annotation (Placement(transformation(extent={{-15,-56},{17,-24}})));
  Window windowSimple(T0 = T0, windowarea = windowarea, WindowType = WindowType) if outside and withWindow  annotation(Placement(transformation(extent={{-13,-22},
            {13,4}})));
  AixLib.Utilities.HeatTransfer.HeatConv_outside
                                          heatTransfer_Outside(A = wall_length * wall_height - clearance, Model = Model, surfaceType = surfaceType, alpha_custom = alpha_custom) if outside  annotation(Placement(transformation(extent = {{-47, 48}, {-27, 68}})));
  AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort heatStarToComb
    annotation (Placement(transformation(
        extent={{-10,8},{10,-8}},
        rotation=180,
        origin={69,11})));
    replaceable model HeatBridge =
      PlugNHarvest.Components.Walls.HeatBridgeLinear constrainedby
    PlugNHarvest.Components.Walls.BaseClasses.PartialHeatBridgeWalls
    "Heat Bridge Model" annotation (choicesAllMatching=
        true,Dialog(tab = "Heat bridges", enable = withHeatBridge));

      HeatBridge heatBridge(wallHeight=wall_height, wallLength=wall_length) if
                               withHeatBridge  "Heat bridge model" annotation (Placement(transformation(extent={{0,48},{
            20,68}},   rotation=0)));

  AixLib.BoundaryConditions.WeatherData.Bus weaBus if outside "Bus with weather data"
    annotation (Placement(transformation(extent={{-109,-19},{-89,1}}),
        iconTransformation(extent={{14,12},{-14,-12}},
        rotation=180,
        origin={-32,0})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature if outside
    annotation (Placement(transformation(extent={{-84,-48},{-68,-32}})));
  Ventilation.InfiltrationNew infiltrationNew(redeclare package AirModel =
        AirModel,
    room_V=roomV,
    n50=n50,
    e=e,
    eps=eps) if (outside and not withMechVent)
    annotation (Placement(transformation(extent={{-14,-84},{12,-60}})));

  SmartFacade.SmartFacade smartFacade(
    redeclare package AirModel = AirModel,
    withMechVent=withMechVent,
    withPV=withPV,
    withSolAirHeat=withSolAirHeat,
    room_V=roomV,
    MassFlowSetPoint=MassFlowSetPoint,
    CoverArea=CoverArea,
    InnerCrossSection=InnerCrossSection,
    Perimeter=Perimeter,
    SAHLength1=SAHLength1,
    SAHLength2=SAHLength2,
    AbsorberHeatCapacity=AbsorberHeatCapacity,
    CoverTransmitance=CoverTransmitance,
    CoverConductance=CoverTransmitance) if
                                         withSmartFacade
    annotation (Placement(transformation(extent={{-22,-130},{18,-92}})));

  Modelica.Blocks.Interfaces.RealInput Schedule_mechVent if (withSmartFacade and withMechVent)
    "schedule for mechanical ventilation. NEEDS to include infiltration as well (0.2 1/h)"
    annotation (Placement(transformation(extent={{-121,-125},{-81,-85}}),
        iconTransformation(extent={{13.5,13.5},{-13.5,-13.5}},
        rotation=180,
        origin={-29.5,-85.5})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        AirModel) if outside
    annotation (Placement(transformation(extent={{85,-104},{105,-84}}),
        iconTransformation(extent={{15.5,-93.5},{38,-115}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        AirModel) if outside
    annotation (Placement(transformation(extent={{85,-87},{105,-67}}),
        iconTransformation(extent={{14.5,-69.5},{39,-92}})));
equation
  //******************************************************************
  // **********************standard connection************************
  //******************************************************************
  connect(Wall.Star, heatStarToComb.portRad) annotation (Line(
      points={{8,36.2},{48,36.2},{48,16.8},{58.6,16.8}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(Wall.port_b, heatStarToComb.portConv) annotation (Line(points={{8,30},
          {48,30},{48,5.9},{58.9,5.9}}, color={191,0,0}));
  connect(heatStarToComb.portConvRadComb, thermStarComb_inside)
    annotation (Line(points={{78.4,10.9},{101,11}}, color={191,0,0}));

  //******************************************************************
  // **********************standard connection for inside wall********
  //******************************************************************
  if not outside then
    connect(Wall.port_a, prescribedTemperature.port) annotation(Line(points={{-14,30},
              {-56.45,30},{-56.45,-40},{-68,-40}},                                                                  color = {191, 0, 0}));
  end if;
  //******************************************************************
  // ********************standard connection for outside wall*********
  //******************************************************************
  if outside then
    connect(infiltrationNew.weaBus, weaBus) annotation (Line(
      points={{-13.48,-64.08},{-56,-64.08},{-56,-9},{-99,-9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
    connect(SolarRadiationPort, SolarAbsorption.solarRad_in) annotation(Line(points={{-106,89},
              {-77,89},{-77,88},{-52.1,88}},                                                                                           color = {255, 128, 0}));
    if (not withMechVent) then
      connect(infiltrationNew.port_b, port_b) annotation (Line(points={{11.48,-68.88},
            {48,-68.88},{48,-77},{95,-77}},
                                          color={0,127,255}));
      connect(infiltrationNew.port_a, port_a) annotation (Line(points={{11.48,-73.68},
            {48,-73.68},{48,-94},{95,-94}}, color={0,127,255}));
    end if;
    if Model == 1 or Model == 2 then
    end if;
    connect(heatTransfer_Outside.port_b, Wall.port_a) annotation(Line(points={{-27,58},
              {-22,58},{-22,30},{-14,30}},                                                                                     color = {191, 0, 0}));
    connect(SolarAbsorption.heatPort, Wall.port_a) annotation(Line(points={{-33,88},
              {-22,88},{-22,30},{-14,30}},                                                                                               color = {191, 0, 0}));
  end if;
  //******************************************************************
  // *******standard connections for wall with door************
  //******************************************************************
  if withDoor then
    connect(Door.port_a, prescribedTemperature.port) annotation(Line(points={{-13.4,
              -40},{-68,-40}},                                                                                                        color = {191, 0, 0}));
    connect(Door.port_b, heatStarToComb.portConv) annotation (Line(points={{
            15.4,-40},{48,-40},{48,5.9},{58.9,5.9}}, color={191,0,0}));
    connect(Door.Star, heatStarToComb.portRad) annotation (Line(
        points={{15.4,-30.4},{48,-30.4},{48,16.8},{58.6,16.8}},
        color={95,95,95},
        pattern=LinePattern.Solid));
  end if;
  //******************************************************************
  // ****standard connections for outside wall with window***********
  //******************************************************************
  if outside and withWindow then
    connect(windowSimple.Star, heatStarToComb.portRad) annotation (Line(
        points={{11.7,-1.2},{48,-1.2},{48,16.8},{58.6,16.8}},
        color={95,95,95},
        pattern=LinePattern.Solid));
    connect(windowSimple.port_inside, heatStarToComb.portConv) annotation (Line(
          points={{11.7,-10.3},{48,-10.3},{48,5.9},{58.9,5.9}}, color={191,0,0}));
    connect(windowSimple.port_outside, prescribedTemperature.port) annotation(Line(points={{-11.7,
              -10.3},{-56,-10.3},{-56,-40},{-68,-40}},                                                                            color = {191, 0, 0}));
  end if;
  //******************************************************************
  // **** connections for outside wall with window without sunblind****
  //******************************************************************
  if outside and withWindow and not withSunblind then
    connect(windowSimple.solarRad_in, SolarRadiationPort) annotation(Line(points={{-11.7,
              -1.2},{-81,-1.2},{-81,89},{-106,89}},                                                                                       color = {255, 128, 0}));
  end if;
  //******************************************************************
  // **** connections for outside wall with window and sunblind****
  //******************************************************************
  if outside and withWindow and withSunblind then
    connect(Sunblind.Rad_Out[1], windowSimple.solarRad_in) annotation(Line(points={{-22.15,
              -6.7},{-18,-6.7},{-18,-1.2},{-11.7,-1.2}},                                                                                 color = {255, 128, 0}));
    connect(Sunblind.Rad_In[1], SolarRadiationPort) annotation(Line(points={{-42.85,
              -6.7},{-81,-6.7},{-81,89},{-106,89}},                                                                        color = {255, 128, 0}));
  end if;

  if withHeatBridge then
    connect(heatBridge.port_b, heatStarToComb.portConv) annotation (Line(points
          ={{19.4,58.6},{48,58.6},{48,5.9},{58.9,5.9}}, color={191,0,0}));
    connect(heatBridge.port_b, heatStarToComb.portConv) annotation (Line(points
          ={{19.4,58.6},{48,58.6},{48,5.9},{58.9,5.9}}, color={191,0,0}));
  connect(heatBridge.port_a, prescribedTemperature.port) annotation (Line(points={{0.4,
              58.6},{-18,58.6},{-18,30},{-56,30},{-56,-40},{-68,-40}},
                                                           color={191,0,0}));
  end if;

  connect(weaBus.winSpe, heatTransfer_Outside.WindSpeedPort) annotation (Line(
      points={{-99,-9},{-56,-9},{-56,50.8},{-46.2,50.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul, Sunblind.TOutAir) annotation (Line(
      points={{-99,-9},{-56,-9},{-56,-14},{-50,-14},{-50,-13.2},{-45.84,-13.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));

  connect(weaBus.TDryBul, prescribedTemperature.T) annotation (Line(
      points={{-99,-9},{-99,-40},{-85.6,-40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(prescribedTemperature.port, heatTransfer_Outside.port_a) annotation (
      Line(points={{-68,-40},{-56,-40},{-56,58},{-47,58}}, color={191,0,0}));

  //******************************************************************
  // ******* connections for smart facade ****************************
  //******************************************************************

  if withSmartFacade then
    connect(smartFacade.solRadPort, SolarRadiationPort) annotation (Line(points={{
          -20,-101.5},{-32,-101.5},{-32,-102},{-56,-102},{-56,40},{-80,40},{-80,
          89},{-106,89}}, color={255,128,0}));
    connect(smartFacade.weaBus, weaBus) annotation (Line(
      points={{-20,-111},{-56,-111},{-56,-9},{-99,-9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
      if withMechVent then
        connect(smartFacade.Schedule_mechVent, Schedule_mechVent) annotation (Line(
        points={{-20,-120.5},{-56,-120.5},{-56,-105},{-101,-105}}, color={0,0,127}));
        connect(smartFacade.port_b, port_b) annotation (Line(points={{17.2,-113.28},{48,
          -113.28},{48,-77},{95,-77}}, color={0,127,255}));
        connect(smartFacade.port_a, port_a) annotation (Line(points={{17.2,-120.88},{48,
          -120.88},{48,-94},{95,-94}}, color={0,127,255}));
      end if;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-20, -120}, {20, 120}}, grid = {1, 1}), graphics={  Rectangle(extent = {{-16, 120}, {15, -60}}, fillColor = {215, 215, 215},
            fillPattern = FillPattern.Backward,  pattern=LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{-16, -90}, {15, -120}},  pattern=LinePattern.None, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
            fillPattern = FillPattern.Backward), Rectangle(extent = {{-16, -51}, {15, -92}}, lineColor = {0, 0, 0},  pattern=LinePattern.None, fillColor = {215, 215, 215},
            fillPattern = FillPattern.Backward, visible = not withDoor), Rectangle(extent = {{-16, 80}, {15, 20}}, fillColor = {255, 255, 255},
            fillPattern = FillPattern.Solid, visible = outside and withWindow, lineColor = {255, 255, 255}), Line(points = {{-2, 80}, {-2, 20}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{1, 80}, {1, 20}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{1, 77}, {-2, 77}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{1, 23}, {-2, 23}}, color = {0, 0, 0}, visible = outside and withWindow), Ellipse(extent = {{-16, -60}, {44, -120}}, lineColor = {0, 0, 0}, startAngle = 359, endAngle = 450, visible = withDoor), Rectangle(extent = {{-16, -60}, {15, -90}}, visible = withDoor, lineColor = {255, 255, 255}, fillColor = {255, 255, 255},
            fillPattern = FillPattern.Solid), Line(points = {{1, 50}, {-2, 50}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{15, 80}, {15, 20}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{-16, 80}, {-16, 20}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{-16, -60}, {-16, -90}}, color = {0, 0, 0}, visible = withDoor), Line(points = {{15, -60}, {15, -90}}, color = {0, 0, 0}, visible = withDoor), Line(points = {{-16, -90}, {15, -60}}, color = {0, 0, 0}, visible = withDoor), Line(points = {{-16, -60}, {15, -90}}, color = {0, 0, 0}, visible = withDoor)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Flexible Model for Inside Walls and Outside Walls. </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The<b> WallSimple</b> model models </p>
 <ul>
 <li>Conduction and convection for a wall (different on the inside surface depending on the surface orientation: vertical wall, floor or ceiling)</li>
 <li>Outside walls may have a window and/ or a door</li>
 <li>Inside walls may have a door</li>
 </ul>
 <p>This model uses a <a href=\"AixLib.Utilities.Interfaces.HeatStarComb\">HeatStarComb</a> Connector for an easier connection of temperature and radiance inputs.</p>
 <p><b><font style=\"color: #008000; \">Assumptions</font></b> </p>
 <ul>
 <li>Outside walls are represented as complete walls</li>
 <li>Inside walls are modeled as a half of a wall, you need to connect a corresponding second half with the same values</li>
 <li>Door and window got a constant U-value</li>
 <li>No heat storage in doors or window </li>
 </ul>
 <p>Have a closer look at the used models to get more information about the assumptions. </p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.Building.Components.Examples.Walls.InsideWall\">AixLib.Building.Components.Examples.Walls.InsideWall</a> </p>
 </html>", revisions="<html>
 <ul>
 <li><i>April 17, 2019&nbsp;</i> by Ana Constantin:<br/>Added smart facade and infiltration and heat bridge</li>
 <li><i>October 12, 2016&nbsp;</i> by Tobias Blacha:<br/>Algorithm for HeatConv_inside is now selectable via parameters on upper model level. This closes ticket <a href=\"https://github.com/RWTH-EBC/AixLib/issues/215\">issue 215</a></li>
 <li><i>August 22, 2014&nbsp;</i> by Ana Constantin:<br/>Corrected implementation of door also for outside walls. This closes ticket <a href=\"https://github.com/RWTH-EBC/AixLib/issues/13\">issue 13</a></li>
 <li><i>May 19, 2014&nbsp;</i> by Ana Constantin:<br/>Formatted documentation appropriately</li>
 <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
 <li><i>June 22, 2012&nbsp;</i> by Lukas Mencher:<br/>Outside wall may have a door now, icon adjusted</li>
 <li><i>Mai 24, 2012&nbsp;</i> by Ana Constantin:<br/>Added inside surface orientation</li>
 <li><i>April, 2012&nbsp;</i> by Mark Wesseling:<br/>Implemented.</li>
 </ul>
 </html>"),
    Diagram(coordinateSystem(extent={{-100,-140},{100,100}})));
end Wall;
