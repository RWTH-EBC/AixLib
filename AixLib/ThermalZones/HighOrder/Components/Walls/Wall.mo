within AixLib.ThermalZones.HighOrder.Components.Walls;
model Wall
  "Simple wall model for outside and inside walls with windows and doors"
  //New parameter and module
  parameter Boolean withShield = false;
  parameter Modelica.Units.SI.Length L_Win_Shield = 0.05;
  parameter Modelica.Units.SI.Length H_Win_Shadow_min = 0.05 "Distance from shield to upper border of window";
  parameter Modelica.Units.SI.Length H_Win_Shadow_max = 1.10 "Distance from shield to lower border of window";
  parameter Integer shadowMode = 1 "Shadow mode";
  Shadow.ShadowEff shadowEff(
    Mode=shadowMode,
    L_Shield=L_Win_Shield,
    H_Window_min=H_Win_Shadow_min,
    H_Window_max=H_Win_Shadow_max) if withWindow and outside and withShield
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  BoundaryConditions.WeatherData.Bus weaBus if withWindow and outside and withShield "Weather bus"
    annotation (Placement(transformation(extent={{-29,-90},{-9,-70}}),
        iconTransformation(extent={{-29,-90},{-9,-70}})));

  //Type parameter
  parameter Boolean outside = true
    "Choose if the wall is an outside or an inside wall"                                annotation(Dialog(group = "General Wall Type Parameter", compact = true), choices(choice = true
        "Outside Wall",                                                                                                    choice = false
        "Inside Wall",                                                                                                    radioButtons = true));

  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab="Dynamics", group="Equations"));

  // general wall parameters
  replaceable parameter DataBase.Walls.WallBaseDataDefinition wallPar "Wall parameters / type of wall"
    annotation(Dialog(group="Structure of wall layers"),   choicesAllMatching = true,
    Placement(transformation(extent={{2,76},{22,96}})));


  parameter Modelica.Units.SI.Length wall_length "Length of wall"
    annotation (Dialog(group="Room Geometry"));
  parameter Modelica.Units.SI.Height wall_height "Height of wall"
    annotation (Dialog(group="Room Geometry"));
  // Surface parameters
  parameter Real solar_absorptance = 0.25
    "Solar absorptance coefficient of outside wall surface"                                       annotation(Dialog(tab = "Surface Parameters", group = "Outside surface", enable = outside));
  parameter Integer calcMethodOut=1 "Calculation method for convective heat transfer coefficient at outside surface" annotation (Dialog(
      tab="Surface Parameters",
      group="Outside surface",
      enable=outside,
      compact=true), choices(
      choice=1 "DIN 6946",
      choice=2 "ASHRAE Fundamentals",
      choice=3 "Custom hCon (constant)",
      radioButtons=true));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConOut_const=25
    "Custom convective heat transfer coefficient (just for manual selection, not recommended)"
    annotation (Dialog(
      tab="Surface Parameters",
      group="Outside surface",
      enable=calcMethodOut == 3 and outside));
parameter DataBase.Surfaces.RoughnessForHT.PolynomialCoefficients_ASHRAEHandbook         surfaceType = DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster()
    "Surface type of outside wall"                                                                                                     annotation(Dialog(tab = "Surface Parameters", group = "Outside surface", enable=
          calcMethodOut == 2 and outside),                                                                                                                                                                                                        choicesAllMatching = true);
  parameter Integer ISOrientation = 1 "Inside surface orientation" annotation(Dialog(tab = "Surface Parameters", group = "Inside surface", compact = true, descriptionLabel = true), choices(choice = 1
        "vertical wall",                                                                                                    choice = 2 "floor", choice = 3 "ceiling", radioButtons = true));


  parameter Boolean use_shortWaveRadIn=false "Use bus connector for incoming shortwave radiation" annotation (Evaluate=true, Dialog(tab="Surface Parameters", group="Inside surface"));
  parameter Boolean use_shortWaveRadOut=false "Use bus connector for outgoing shortwave radiation" annotation (Evaluate=true, Dialog(tab="Surface Parameters", group="Inside surface"));
  parameter Integer radLongCalcMethod=1 "Calculation method for longwave radiation heat transfer"
    annotation (
    Evaluate=true,
    Dialog(tab="Surface Parameters", group="Inside surface",   compact=true),
    choices(
      choice=1 "No approx",
      choice=2 "Linear approx at wall temp",
      choice=3 "Linear approx at rad temp",
      choice=4 "Linear approx at constant T_ref",
      radioButtons=true));
  parameter Modelica.Units.SI.Temperature T_ref=
      Modelica.Units.Conversions.from_degC(16)
    "Reference temperature for optional linearization of longwave radiation"
    annotation (Dialog(
      tab="Surface Parameters",
      group="Inside surface",
      enable=radLongCalcMethod == 4));

  parameter Integer calcMethodIn=1
    "Calculation method of convective heat transfer coefficient at inside surface"
    annotation (Dialog(
      tab="Surface Parameters",
      group="Inside surface",
      compact=true,
      descriptionLabel=true), choices(
      choice=1 "EN ISO 6946 Appendix A >>Flat Surfaces<<",
      choice=2 "By Bernd Glueck",
      choice=3 "Custom hCon (constant)",
      choice=4 "ASHRAE140-2017",
      radioButtons=true));

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConIn_const=2.5
    "Custom convective heat transfer coefficient (just for manual selection, not recommended)"
    annotation (Dialog(
      tab="Surface Parameters",
      group="Inside surface",
      enable=calcMethodIn == 3));
  // window parameters
  parameter Boolean withWindow=false
    "Choose if the wall has got a window (only outside walls)"                                    annotation(Dialog(tab = "Window", enable = outside));
  replaceable model WindowModel =
      AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow
   constrainedby
    AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow(
     redeclare final model CorrSolGain=CorrSolarGainWin,
     final T0=T0,
     final windowarea=windowarea,
     final WindowType=WindowType)
       "Model for window"
                     annotation (Dialog(tab="Window",  enable=withWindow and outside),   choicesAllMatching=true);

  WindowModel windowModel if withWindow and outside annotation(Placement(transformation(extent={{-15,-48},{11,-22}})));

  replaceable parameter DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple WindowType = DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009()
    "Choose a window type from the database"                                                                                                     annotation(Dialog(tab = "Window", enable = withWindow and outside), choicesAllMatching = true);
  parameter Modelica.Units.SI.Area windowarea=2 "Area of window"
    annotation (Dialog(tab="Window", enable=withWindow and outside));
  replaceable model CorrSolarGainWin =
      WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG
    constrainedby WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG "Correction model for solar irradiance as transmitted radiation" annotation (choicesAllMatching=true, Dialog(tab = "Window", enable = withWindow and outside));

  parameter Boolean withSunblind = false "enable support of sunblinding?" annotation(Dialog(tab = "Window", enable = outside and withWindow));
  parameter Real Blinding = 0 "blinding factor: 0 means total blocking of solar irradiation" annotation(Dialog(tab = "Window", enable = withWindow and outside and withSunblind));
  parameter Real LimitSolIrr if withWindow and outside and withSunblind
    "Minimum specific total solar radiation in W/m2 for blinding becoming active (see also TOutAirLimit)"
    annotation(Dialog(tab="Window",   enable=withWindow and outside and
          withSunblind));
  parameter Modelica.Units.SI.Temperature TOutAirLimit
    if withWindow and outside and withSunblind
    "Temperature at which sunblind closes (see also LimitSolIrr)" annotation (
      Dialog(tab="Window", enable=withWindow and outside and withSunblind));
  // door parameters
  parameter Boolean withDoor=false   "Choose if the wall has got a door" annotation(Dialog(tab = "Door"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_door=1.8
    "Thermal transmission coefficient of door"
    annotation (Dialog(tab="Door", enable=withDoor));
  parameter Modelica.Units.SI.Emissivity eps_door=0.9
    "Solar emissivity of door material"
    annotation (Dialog(tab="Door", enable=withDoor));
  parameter Modelica.Units.SI.Length door_height=2
    annotation (Dialog(tab="Door", enable=withDoor));
  parameter Modelica.Units.SI.Length door_width=1
    annotation (Dialog(tab="Door", enable=withDoor));
  // Calculation of clearance
  final parameter Modelica.Units.SI.Area clearance=if not outside and withDoor
       then door_height*door_width else if outside and withDoor and withWindow
       then windowarea + door_height*door_width else if outside and withWindow
       then windowarea else if outside and withDoor then door_height*door_width
       else 0 "Wall clearance";
  // Initial temperature
  parameter Modelica.Units.SI.Temperature T0=
      Modelica.Units.Conversions.from_degC(20) "Initial temperature"
    annotation (Dialog(tab="Initialization"));

  // COMPONENT PART
  BaseClasses.ConvNLayerClearanceStar Wall(
    final energyDynamics=energyDynamics,
    final h=wall_height,
    final l=wall_length,
    final T0=T0,
    final clearance=clearance,
    final wallType=wallPar,
    final surfaceOrientation=ISOrientation,
    final calcMethod=calcMethodIn,
    final hCon_const=hConIn_const,
    final radCalcMethod=radLongCalcMethod,
    final T_ref=T_ref) "Wall" annotation (Placement(transformation(extent={{4,14},{30,36}})));
  Utilities.HeatTransfer.SolarRadToHeat SolarAbsorption(coeff = solar_absorptance, A=ANet)                                    if outside annotation(Placement(transformation(origin={-37.5,90.5},extent={{-10.5,-10.5},{10.5,10.5}})));
  AixLib.Utilities.Interfaces.SolarRad_in   SolarRadiationPort if outside annotation(Placement(transformation(extent = {{-116, 79}, {-96, 99}}), iconTransformation(extent = {{-36, 100}, {-16, 120}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_outside annotation(Placement(transformation(extent = {{-108, -6}, {-88, 14}}), iconTransformation(extent = {{-31, -10}, {-11, 10}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort if outside and (calcMethodOut == 1 or calcMethodOut == 2)
                                                                                               annotation(Placement(transformation(extent = {{-113, 54}, {-93, 74}}), iconTransformation(extent = {{-31, 78}, {-11, 98}})));
  Sunblinds.Sunblind Sunblind(
    final n=1,
    final gsunblind={Blinding},
    final Imax=LimitSolIrr,
    final TOutAirLimit=TOutAirLimit)
                      if outside and withWindow and withSunblind
    annotation (Placement(transformation(extent={{-46,-47},{-23,-21}})));
  WindowsDoors.Door Door(
    final door_area=door_height*door_width,
    final eps=eps_door,
    U=if outside then U_door else U_door*2,
    final radCalcMethod=radLongCalcMethod,
    final T_ref=T_ref) if withDoor annotation (Placement(transformation(extent={{-21,-102},{11,-70}})));

  AixLib.Utilities.HeatTransfer.HeatConvOutside heatTransfer_Outside(
    A=wall_length*wall_height - clearance,
    calcMethod=calcMethodOut,
    surfaceType=surfaceType,
    hCon_const=hConOut_const) if outside annotation (Placement(transformation(extent={{-47,48},{-27,68}})));
  AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort heatStarToComb annotation (Placement(transformation(
        extent={{-10,8},{10,-8}},
        rotation=180,
        origin={69,-1})));
  AixLib.Utilities.Interfaces.ConvRadComb thermStarComb_inside annotation (Placement(transformation(extent={{92,-10},{112,10}}), iconTransformation(extent={{10,-10},{30,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempOutAirSensor if outside and withWindow and withSunblind
    "Outdoor air (dry bulb) temperature sensor"
    annotation (Placement(transformation(extent={{-70,-44},{-62,-36}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow absSolarRadWin if use_shortWaveRadIn
    "absorbed solar radiation through window" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={45,80})));
  final parameter Modelica.Units.SI.Area ANet=wall_height*wall_length -
      clearance "Net area of wall (without windows and doors)";

  Utilities.Interfaces.ShortRadSurf shortRadWall if use_shortWaveRadIn
    annotation (Placement(transformation(extent={{92,66},{118,92}}),
        iconTransformation(extent={{7,66},{33,92}})));
  Utilities.Interfaces.ShortRadSurf shortRadWin if withWindow and
    use_shortWaveRadOut annotation (Placement(transformation(extent={{91,-72},{
            117,-46}}),iconTransformation(extent={{6,-72},{32,-46}})));
  Modelica.Blocks.Sources.Constant constFixShoRadPar[6](k={0,wallPar.eps,1 -
        wallPar.eps,wall_length,wall_height,0})
 if use_shortWaveRadIn
    "Parameteres used for the short radiaton models. See connections to check which array corresponds to which parameter"
    annotation (Placement(transformation(extent={{80,88},{90,98}})));

equation
  //   if outside and cardinality(WindSpeedPort) < 2 then
  //     WindSpeedPort = 3;
  //   end if;
  //******************************************************************
  // **********************standard connection************************
  //******************************************************************
  connect(Wall.radPort, heatStarToComb.portRad) annotation (Line(
      points={{30,31.82},{48,31.82},{48,4},{59,4}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(Wall.port_b, heatStarToComb.portConv) annotation (Line(points={{30,25},{48,25},{48,-6},{59,-6}},      color={191,0,0}));
  //******************************************************************
  // **********************standard connection for inside wall********
  //******************************************************************
  if not outside then
    connect(Wall.port_a, port_outside) annotation(Line(points={{4,25},{-56.45,25},{-56.45,4},{-98,4}},              color = {191, 0, 0}));
  end if;
  //******************************************************************
  // ********************standard connection for outside wall*********
  //******************************************************************
  if outside then
    connect(SolarRadiationPort, SolarAbsorption.solarRad_in) annotation(Line(points={{-106,89},{-48,89},{-48,88.4},{-48.105,88.4}},    color = {255, 128, 0}));
    if calcMethodOut == 1 or calcMethodOut == 2 then
      connect(WindSpeedPort, heatTransfer_Outside.WindSpeedPort) annotation(Line(points={{-103,64},{-68,64},{-68,51},{-46,51}},                color = {0, 0, 127}));
    end if;
    connect(heatTransfer_Outside.port_a, port_outside) annotation(Line(points = {{-47, 58}, {-56, 58}, {-56, 4}, {-98, 4}}, color = {191, 0, 0}));
    connect(heatTransfer_Outside.port_b, Wall.port_a) annotation(Line(points={{-27,58},{-24,58},{-24,25},{4,25}},              color = {191, 0, 0}));
    connect(SolarAbsorption.heatPort, Wall.port_a) annotation(Line(points={{-28.05,88.4},{-28,88.4},{-28,88},{-16,88},{-16,26},{4,26},{4,25}},
                                                                                                                                         color = {191, 0, 0}));
  end if;
  //******************************************************************
  // *******standard connections for wall with door************
  //******************************************************************
  if withDoor then
    connect(Door.port_a, port_outside) annotation(Line(points = {{-19.4, -86}, {-56, -86}, {-56, 24}, {-24, 24}, {-24, 4}, {-98, 4}}, color = {191, 0, 0}));
    connect(Door.port_b, heatStarToComb.portConv) annotation (Line(points={{9.4,-86},{48,-86},{48,-6},{59,-6}},       color={191,0,0}));
    connect(Door.radPort, heatStarToComb.portRad) annotation (Line(
        points={{9.4,-76.4},{48,-76.4},{48,4},{59,4}},
        color={95,95,95},
        pattern=LinePattern.Solid));
  end if;
  //******************************************************************
  // ****standard connections for outside wall with window***********
  //******************************************************************
  if outside and withWindow then
    connect(windowModel.radPort, heatStarToComb.portRad) annotation (Line(
        points={{9.7,-27.2},{48,-27.2},{48,4},{59,4}},
        color={95,95,95},
        pattern=LinePattern.Solid));
    connect(windowModel.port_inside, heatStarToComb.portConv) annotation (Line(points={{9.7,-36.3},{48,-36.3},{48,-6},{59,-6}}, color={191,0,0}));
    connect(windowModel.port_outside, port_outside) annotation (Line(points={{-13.7,-36.3},{-16,-36.3},{-16,-54},{-92,-54},{-92,4},{-98,4}}, color={191,0,0}));
  end if;
  //******************************************************************
  // **** connections for outside wall with window without sunblind****
  //******************************************************************
  if outside and withWindow and not withSunblind then
    connect(windowModel.solarRad_in, SolarRadiationPort) annotation (Line(points={{-13.7,-27.2},{-16,-27.2},{-16,-16},{-80,-16},{-80,89},{-106,89}}, color={255,128,0}));
  end if;
  //******************************************************************
  // **** connections for outside wall with window and sunblind****
  //******************************************************************
  if outside and withWindow and withSunblind then
    if withShield then
      connect(weaBus, shadowEff.weaBus) annotation (Line(
      points={{-19,-80},{-40,-80},{-40,-2},{-20,-2}},
      color={255,204,51},
      thickness=0.5,
          pattern=LinePattern.Dash),
                      Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
      connect(windowModel.solarRad_in, shadowEff.solarRad_out) annotation (Line(
        points={{-13.7,-27.2},{-16,-27.2},{-16,-20},{4,-20},{4,-10},{1,-10}},
        color={255,128,0},
          pattern=LinePattern.Dash));
      connect(Sunblind.Rad_Out[1], shadowEff.solarRad_in) annotation (Line(points={{
          -21.5625,-32.375},{-21,-32.375},{-21,-10}}, color={255,128,0},
          pattern=LinePattern.Dash));
    else
      connect(Sunblind.Rad_Out[1], windowModel.solarRad_in) annotation (Line(points={{-21.5625,-32.375},{-20,-32.375},{-20,-27.2},{-13.7,-27.2}}, color={255,128,
              0},
          pattern=LinePattern.Dash));
    end if;
    connect(Sunblind.Rad_In[1], SolarRadiationPort) annotation(Line(points={{-47.4375,-32.375},{-50,-32.375},{-50,-16},{-80,-16},{-80,89},{-106,89}},
                                                                                                                                   color = {255, 128, 0}));
  end if;
  connect(heatStarToComb.portConvRadComb, thermStarComb_inside) annotation (Line(points={{79,-1},{79,-1.05},{102,-1.05},{102,0}},       color={191,0,0}));
  connect(tempOutAirSensor.T, Sunblind.TOutAir) annotation (Line(points={{-61.6,
          -40},{-54,-40},{-54,-38.875},{-47.4375,-38.875}},
                                                      color={0,0,127}));
  connect(port_outside, tempOutAirSensor.port) annotation (Line(points={{-98,4},{-90,4},{-90,-40},{-70,-40}},
                                        color={191,0,0}));
  connect(absSolarRadWin.port, Wall.port_b1) annotation (Line(points={{35,80},{30,80},{30,48},{16.74,48},{16.74,35.78}}, color={191,0,0}));
  connect(WindSpeedPort, windowModel.WindSpeedPort) annotation (Line(points={{-103,64},{-72,64},{-72,-62},{-20,-62},{-20,-41.5},{-13.7,-41.5}}, color={0,0,127}));
  connect(shortRadWin, windowModel.shortRadWin) annotation (Line(points={{104,-59},
          {60,-59},{60,-23.56},{9.7,-23.56}},      color={0,0,0}), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(shortRadWall.Q_flow_ShoRadOnSur, absSolarRadWin.Q_flow) annotation (
      Line(points={{105.065,79.065},{79.5,79.065},{79.5,80},{55,80}}, color={0,
          0,0}), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(constFixShoRadPar[1].y, shortRadWall.g) annotation (Line(points={{
          90.5,93},{105.065,93},{105.065,79.065}}, color={0,0,127}));
  connect(constFixShoRadPar[2].y, shortRadWall.solar_absorptance) annotation (
      Line(points={{90.5,93},{104,93},{104,88},{105.065,88},{105.065,79.065}},
        color={0,0,127}));
  connect(constFixShoRadPar[3].y, shortRadWall.solar_reflectance) annotation (
      Line(points={{90.5,93},{104,93},{104,86},{105.065,86},{105.065,79.065}},
        color={0,0,127}));
  connect(constFixShoRadPar[4].y, shortRadWall.length) annotation (Line(points=
          {{90.5,93},{105.065,93},{105.065,79.065}}, color={0,0,127}));
  connect(constFixShoRadPar[5].y, shortRadWall.height) annotation (Line(points=
          {{90.5,93},{104,93},{104,79.065},{105.065,79.065}}, color={0,0,127}));
  connect(constFixShoRadPar[6].y, shortRadWall.Q_flow_ShoRadFroSur) annotation (
     Line(points={{90.5,93},{105.065,93},{105.065,79.065}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-20,-120},{20,120}},
        grid={1,1}), graphics={
        Rectangle(
          extent={{-20,120},{20,-120}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-20,-50},{20,-110}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=outside and withWindow,
          lineColor={255,255,255}),
        Line(
          points={{-1,-50},{-1,-110}},
          color={0,0,0},
          visible=outside and withWindow),
        Line(
          points={{2,-50},{2,-110}},
          color={0,0,0},
          visible=outside and withWindow),
        Line(
          points={{2,-53},{-1,-53}},
          color={0,0,0},
          visible=outside and withWindow),
        Line(
          points={{2,-107},{-1,-107}},
          color={0,0,0},
          visible=outside and withWindow),
        Ellipse(
          extent={{-20,86},{40,26}},
          lineColor={0,0,0},
          startAngle=360,
          endAngle=450,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=withDoor),
        Rectangle(
          extent={{-21,56},{10,26}},
          visible=withDoor,
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{2,-80},{-1,-80}},
          color={0,0,0},
          visible=outside and withWindow),
        Line(
          points={{20,-50},{20,-110}},
          color={0,0,0},
          visible=outside and withWindow),
        Line(
          points={{-20,-50},{-20,-110}},
          color={0,0,0},
          visible=outside and withWindow),
        Line(
          points={{-21,56},{-21,26}},
          color={0,0,0},
          visible=withDoor),
        Line(
          points={{10,56},{10,26}},
          color={0,0,0},
          visible=withDoor),
        Line(
          points={{-21,26},{10,56}},
          color={0,0,0},
          visible=withDoor),
        Line(
          points={{-21,56},{10,26}},
          color={0,0,0},
          visible=withDoor)}),
  Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Flexible Model for Inside Walls and Outside Walls.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The <b>WallSimple</b> model models
</p>
<ul>
  <li>Conduction and convection for a wall (different on the inside
  surface depending on the surface orientation: vertical wall, floor or
  ceiling)
  </li>
  <li>Outside walls may have a window and/ or a door
  </li>
  <li>Inside walls may have a door
  </li>
</ul>
<p>
  This model uses a <a href=
  \"AixLib.Utilities.Interfaces.HeatStarComb\">HeatStarComb</a> Connector
  for an easier connection of temperature and radiance inputs.
</p>
<p>
  <b><span style=\"color: #008000\">Assumptions</span></b>
</p>
<ul>
  <li>Outside walls are represented as complete walls
  </li>
  <li>Inside walls are modeled as a half of a wall, you need to connect
  a corresponding second half with the same values
  </li>
  <li>Door and window got a constant U-value
  </li>
  <li>No heat storage in doors or window
  </li>
</ul>
<p>
  Have a closer look at the used models to get more information about
  the assumptions.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  <a href=
  \"AixLib.Building.Components.Examples.Walls.InsideWall\">AixLib.Building.Components.Examples.Walls.InsideWall</a>
</p>
<ul>
  <li>
    <i>June, 18, 2020</i> by Fabian Wuellhorst:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/918\">#918</a>:
    Add short wave connector to pass wall and window parameters.
  </li>
  <li>
    <i>June, 18, 2020</i> by Fabian Wuellhorst:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/918\">#918</a>:
    Add short wave connector to pass wall and window parameters.
  </li>
  <li>
    <i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>
    <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/898\">#898</a>:Added
    HeatPort to connect absSolarRadWin properly,<br/>
    <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/882\">#882</a>:Rearranged
    components to only use one wall model.
  </li>
  <li>
    <i>April 23, 2020</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/752\">#752</a>:
    Mainly add wallType, rearrange components.
  </li>
  <li>
    <i>October 12, 2016&#160;</i> by Tobias Blacha:<br/>
    Algorithm for HeatConv_inside is now selectable via parameters on
    upper model level. This closes ticket <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/215\">issue 215</a>
  </li>
  <li>
    <i>August 22, 2014&#160;</i> by Ana Constantin:<br/>
    Corrected implementation of door also for outside walls. This
    closes ticket <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/13\">issue 13</a>
  </li>
  <li>
    <i>May 19, 2014&#160;</i> by Ana Constantin:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>May 02, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>June 22, 2012&#160;</i> by Lukas Mencher:<br/>
    Outside wall may have a door now, icon adjusted
  </li>
  <li>
    <i>Mai 24, 2012&#160;</i> by Ana Constantin:<br/>
    Added inside surface orientation
  </li>
  <li>
    <i>April, 2012&#160;</i> by Mark Wesseling:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end Wall;
