within AixLib.Building.Components.Walls;
model Wall
  "Simple wall model for outside and inside walls with windows and doors"
  import BaseLib = AixLib.Utilities;
  //Type parameter
  parameter Boolean outside = true
    "Choose if the wall is an outside or an inside wall"                                annotation(Dialog(group = "General Wall Type Parameter", compact = true), choices(choice = true
        "Outside Wall",                                                                                                    choice = false
        "Inside Wall",                                                                                                    radioButtons = true));
  // general wall parameters
  parameter DataBase.Walls.WallBaseDataDefinition WallType = DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S()
    "Choose an outside wall type from the database"                                                                                                     annotation(Dialog(group = "Room Geometry"), choicesAllMatching = true);
  parameter Modelica.SIunits.Length wall_length = 2 "Length of wall" annotation(Dialog(group = "Room Geometry"));
  parameter Modelica.SIunits.Height wall_height = 2 "Height of wall" annotation(Dialog(group = "Room Geometry"));
  // Surface parameters
  parameter Real solar_absorptance = 0.25
    "Solar absorptance coefficient of outside wall surface"                                       annotation(Dialog(tab = "Surface Parameters", group = "Outside surface", enable = outside));
  parameter Integer Model = 1
    "Choose the model for calculation of heat convection at outside surface"                           annotation(Dialog(tab = "Surface Parameters", group = "Outside surface", enable = outside, compact = true), choices(choice = 1
        "DIN 6946",                                                                                                    choice = 2
        "ASHRAE Fundamentals",                                                                                                    choice = 3
        "Custom alpha",                                                                                                    radioButtons = true));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_custom = 25
    "Custom alpha for convection (just for manual selection, not recommended)"                                                                      annotation(Dialog(tab = "Surface Parameters", group = "Outside surface", enable = Model == 3 and outside));
 DataBase.Surfaces.RoughnessForHT.PolynomialCoefficients_ASHRAEHandbook         surfaceType = DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster()
    "Surface type of outside wall"                                                                                                     annotation(Dialog(tab = "Surface Parameters", group = "Outside surface", enable = Model == 2 and outside), choicesAllMatching = true);
  parameter Integer ISOrientation = 1 "Inside surface orientation" annotation(Dialog(tab = "Surface Parameters", group = "Inside surface", compact = true, descriptionLabel = true), choices(choice = 1
        "vertical wall",                                                                                                    choice = 2 "floor", choice = 3 "ceiling", radioButtons = true));
  parameter Integer calculationMethod = 1
    "Choose the model for calculation of heat convection at inside surface" annotation(Dialog(tab = "Surface Parameters", group = "Inside surface", compact = true, descriptionLabel = true), choices(choice = 1 "EN ISO 6946 Appendix A >>Flat Surfaces<<",
      choice=2 "By Bernd Glueck",
      choice=3 "Constant alpha",radioButtons = true));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_constant = 2.5
    "Constant alpha for convection (just for manual selection, not recommended)" annotation(Dialog(tab = "Surface Parameters", group = "Inside surface", enable = calculationMethod == 3));
  // window parameters
  parameter Boolean withWindow = false
    "Choose if the wall has got a window (only outside walls)"                                    annotation(Dialog(tab = "Window", enable = outside));
  replaceable model Window =
      AixLib.Building.Components.WindowsDoors.WindowSimple
  constrainedby
    AixLib.Building.Components.WindowsDoors.BaseClasses.PartialWindow
    "Model for window"
                     annotation(Dialog( tab="Window",  enable = withWindow and outside), choicesAllMatching=true);
  parameter DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple WindowType = DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009()
    "Choose a window type from the database"                                                                                                     annotation(Dialog(tab = "Window", enable = withWindow and outside), choicesAllMatching = true);
  parameter Modelica.SIunits.Area windowarea = 2 "Area of window" annotation(Dialog(tab = "Window", enable = withWindow and outside));
  parameter Boolean withSunblind = false "enable support of sunblinding?" annotation(Dialog(tab = "Window", enable = outside and withWindow));
  parameter Real Blinding = 0 "blinding factor <=1" annotation(Dialog(tab = "Window", enable = withWindow and outside and withSunblind));
  parameter Real LimitSolIrr=180
    "Minimum specific total solar radiation in W/m2 for blinding becoming active (see also TOutAirLimit)"
    annotation(Dialog(tab="Window",   enable=withWindow and outside and
          withSunblind));
  parameter Modelica.SIunits.Temperature TOutAirLimit = 293.15
    "Temperature at which sunblind closes (see also LimitSolIrr)"
    annotation(Dialog(tab = "Window", enable = withWindow and outside and withSunblind));
  // door parameters
  parameter Boolean withDoor = false "Choose if the wall has got a door" annotation(Dialog(tab = "Door"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer U_door = 1.8
    "Thermal transmission coefficient of door"                                                                 annotation(Dialog(tab = "Door", enable = withDoor));
  parameter Modelica.SIunits.Emissivity eps_door = 0.9
    "Solar emissivity of door material"                                                    annotation(Dialog(tab = "Door", enable = withDoor));
  parameter Modelica.SIunits.Length door_height = 2 annotation(Dialog(tab = "Door", enable = withDoor));
  parameter Modelica.SIunits.Length door_width = 1 annotation(Dialog(tab = "Door", enable = withDoor));
  // Calculation of clearance
  final parameter Modelica.SIunits.Area clearance = if not outside and withDoor then door_height * door_width else if outside and withDoor and withWindow then windowarea + door_height * door_width else if outside and withWindow then windowarea else if outside and withDoor then door_height * door_width else 0
    "Wall clearance";
  // Initial temperature
  parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(20)
    "Initial temperature"                                                                                      annotation(Dialog(tab = "Advanced Parameters"));
  // COMPONENT PART
  BaseClasses.ConvNLayerClearanceStar Wall(h = wall_height, l = wall_length, T0 = T0, clearance = clearance, selectable = true, eps = WallType.eps, wallType = WallType, surfaceOrientation = ISOrientation, calcMethod = calculationMethod, alpha_constant = alpha_constant) "Wall" annotation(Placement(transformation(extent = {{-20, 14}, {2, 34}})));
  Utilities.HeatTransfer.SolarRadToHeat SolarAbsorption(coeff = solar_absorptance, A = wall_height * wall_length - clearance) if outside annotation(Placement(transformation(origin = {-39, 89}, extent = {{-10, -10}, {10, 10}})));
  BaseLib.Interfaces.SolarRad_in   SolarRadiationPort if outside annotation(Placement(transformation(extent = {{-116, 79}, {-96, 99}}), iconTransformation(extent = {{-36, 100}, {-16, 120}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_outside annotation(Placement(transformation(extent = {{-108, -6}, {-88, 14}}), iconTransformation(extent = {{-31, -10}, {-11, 10}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort if outside and (Model ==1 or Model == 2)  annotation(Placement(transformation(extent = {{-113, 54}, {-93, 74}}), iconTransformation(extent = {{-31, 78}, {-11, 98}})));
  Weather.Sunblinds.Sunblind Sunblind(
    n=1,
    gsunblind={Blinding},
    Imax=LimitSolIrr) if outside and withWindow and withSunblind
    annotation (Placement(transformation(extent={{-44,-21},{-21,5}})));
  WindowsDoors.Door Door(T0 = T0, door_area = door_height * door_width, eps = eps_door, U = if outside then U_door else U_door * 2) if withDoor annotation(Placement(transformation(extent = {{-21, -102}, {11, -70}})));
  Window windowSimple(T0 = T0, windowarea = windowarea, WindowType = WindowType) if outside and withWindow annotation(Placement(transformation(extent = {{-15, -48}, {11, -22}})));
  Utilities.HeatTransfer.HeatConv_outside heatTransfer_Outside(A = wall_length * wall_height - clearance, Model = Model, surfaceType = surfaceType, alpha_custom = alpha_custom) if outside annotation(Placement(transformation(extent = {{-47, 48}, {-27, 68}})));
  Utilities.Interfaces.Adaptors.HeatStarToComb heatStarToComb annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation = 180, origin = {69, -1})));
  Utilities.Interfaces.HeatStarComb thermStarComb_inside annotation(Placement(transformation(extent = {{92, -10}, {112, 10}}), iconTransformation(extent = {{10, -10}, {30, 10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempOutAirSensor
    "Outdoor air (dry bulb) temperature sensor"
    annotation (Placement(transformation(extent={{-66,-18},{-58,-10}})));
equation
  //   if outside and cardinality(WindSpeedPort) < 2 then
  //     WindSpeedPort = 3;
  //   end if;
  //******************************************************************
  // **********************standard connection************************
  //******************************************************************
  connect(Wall.Star, heatStarToComb.star) annotation(Line(points={{2,30.2},{48,30.2},
          {48,4.8},{58.6,4.8}},                                                                                   color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(Wall.port_b, heatStarToComb.therm) annotation(Line(points={{2,24},{48,
          24},{48,-6.1},{58.9,-6.1}},                                                                                  color = {191, 0, 0}));
  //******************************************************************
  // **********************standard connection for inside wall********
  //******************************************************************
  if not outside then
    connect(Wall.port_a, port_outside) annotation(Line(points={{-20,24},{-56.45,
            24},{-56.45,4},{-98,4}},                                                                                color = {191, 0, 0}));
  end if;
  //******************************************************************
  // ********************standard connection for outside wall*********
  //******************************************************************
  if outside then
    connect(SolarRadiationPort, SolarAbsorption.solarRad_in) annotation(Line(points = {{-106, 89}, {-77, 89}, {-77, 87}, {-49.1, 87}}, color = {255, 128, 0}));
    if Model == 1 or Model == 2 then
      connect(WindSpeedPort, heatTransfer_Outside.WindSpeedPort) annotation(Line(points = {{-103, 64}, {-68, 64}, {-68, 50.8}, {-46.2, 50.8}}, color = {0, 0, 127}));
    end if;
    connect(heatTransfer_Outside.port_a, port_outside) annotation(Line(points = {{-47, 58}, {-56, 58}, {-56, 4}, {-98, 4}}, color = {191, 0, 0}));
    connect(heatTransfer_Outside.port_b, Wall.port_a) annotation(Line(points={{-27,58},
            {-24,58},{-24,24},{-20,24}},                                                                                       color = {191, 0, 0}));
    connect(SolarAbsorption.heatPort, Wall.port_a) annotation(Line(points={{-30,87},
            {-26,87},{-26,84},{-20,84},{-20,24}},                                                                                        color = {191, 0, 0}));
  end if;
  //******************************************************************
  // *******standard connections for wall with door************
  //******************************************************************
  if withDoor then
    connect(Door.port_a, port_outside) annotation(Line(points = {{-19.4, -86}, {-56, -86}, {-56, 24}, {-24, 24}, {-24, 4}, {-98, 4}}, color = {191, 0, 0}));
    connect(Door.port_b, heatStarToComb.therm) annotation(Line(points = {{9.4, -86}, {48, -86}, {48, -6.1}, {58.9, -6.1}}, color = {191, 0, 0}));
    connect(Door.Star, heatStarToComb.star) annotation(Line(points = {{9.4, -76.4}, {48, -76.4}, {48, 4.8}, {58.6, 4.8}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  end if;
  //******************************************************************
  // ****standard connections for outside wall with window***********
  //******************************************************************
  if outside and withWindow then
    connect(windowSimple.Star, heatStarToComb.star) annotation(Line(points = {{9.7, -27.2}, {48, -27.2}, {48, 4.8}, {58.6, 4.8}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
    connect(windowSimple.port_inside, heatStarToComb.therm) annotation(Line(points = {{9.7, -36.3}, {48, -36.3}, {48, -6.1}, {58.9, -6.1}}, color = {191, 0, 0}));
    connect(windowSimple.port_outside, port_outside) annotation(Line(points = {{-13.7, -36.3}, {-56, -36.3}, {-56, 4}, {-98, 4}}, color = {191, 0, 0}));
  end if;
  //******************************************************************
  // **** connections for outside wall with window without sunblind****
  //******************************************************************
  if outside and withWindow and not withSunblind then
    connect(windowSimple.solarRad_in, SolarRadiationPort) annotation(Line(points = {{-13.7, -27.2}, {-81, -27.2}, {-81, 89}, {-106, 89}}, color = {255, 128, 0}));
  end if;
  //******************************************************************
  // **** connections for outside wall with window and sunblind****
  //******************************************************************
  if outside and withWindow and withSunblind then
    connect(Sunblind.Rad_Out[1], windowSimple.solarRad_in) annotation(Line(points={{-22.15,
            -6.7},{-18,-6.7},{-18,-27.2},{-13.7,-27.2}},                                                                                         color = {255, 128, 0}));
    connect(Sunblind.Rad_In[1], SolarRadiationPort) annotation(Line(points={{-42.85,
            -6.7},{-81,-6.7},{-81,89},{-106,89}},                                                                                  color = {255, 128, 0}));
  end if;
  connect(heatStarToComb.thermStarComb, thermStarComb_inside) annotation(Line(points = {{78.4, -1.1}, {78.4, -1.05}, {102, -1.05}, {102, 0}}, color = {191, 0, 0}));
  connect(port_outside, port_outside) annotation(Line(points = {{-98, 4}, {-98, 4}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(tempOutAirSensor.T, Sunblind.TOutAir) annotation (Line(points={{-58,
          -14},{-54,-14},{-54,-13.2},{-45.84,-13.2}}, color={0,0,127}));
  connect(port_outside, tempOutAirSensor.port) annotation (Line(points={{-98,4},
          {-70,4},{-70,-14},{-66,-14}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-20, -120}, {20, 120}}, grid = {1, 1}), graphics={  Rectangle(extent = {{-16, 120}, {15, -60}}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Backward,  pattern=LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{-16, -90}, {15, -120}},  pattern=LinePattern.None, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Backward), Rectangle(extent = {{-16, -51}, {15, -92}}, lineColor = {0, 0, 0},  pattern=LinePattern.None, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Backward, visible = not withDoor), Rectangle(extent = {{-16, 80}, {15, 20}}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, visible = outside and withWindow, lineColor = {255, 255, 255}), Line(points = {{-2, 80}, {-2, 20}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{1, 80}, {1, 20}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{1, 77}, {-2, 77}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{1, 23}, {-2, 23}}, color = {0, 0, 0}, visible = outside and withWindow), Ellipse(extent = {{-16, -60}, {44, -120}}, lineColor = {0, 0, 0}, startAngle = 359, endAngle = 450, visible = withDoor), Rectangle(extent = {{-16, -60}, {15, -90}}, visible = withDoor, lineColor = {255, 255, 255}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Line(points = {{1, 50}, {-2, 50}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{15, 80}, {15, 20}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{-16, 80}, {-16, 20}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{-16, -60}, {-16, -90}}, color = {0, 0, 0}, visible = withDoor), Line(points = {{15, -60}, {15, -90}}, color = {0, 0, 0}, visible = withDoor), Line(points = {{-16, -90}, {15, -60}}, color = {0, 0, 0}, visible = withDoor), Line(points = {{-16, -60}, {15, -90}}, color = {0, 0, 0}, visible = withDoor)}), Documentation(info = "<html>
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
 <li><i>October 12, 2016&nbsp;</i> by Tobias Blacha:<br/>Algorithm for HeatConv_inside is now selectable via parameters on upper model level. This closes ticket <a href=\"https://github.com/RWTH-EBC/AixLib/issues/215\">issue 215</a></li>
 <li><i>August 22, 2014&nbsp;</i> by Ana Constantin:<br/>Corrected implementation of door also for outside walls. This closes ticket <a href=\"https://github.com/RWTH-EBC/AixLib/issues/13\">issue 13</a></li>
 <li><i>May 19, 2014&nbsp;</i> by Ana Constantin:<br/>Formatted documentation appropriately</li>
 <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
 <li><i>June 22, 2012&nbsp;</i> by Lukas Mencher:<br/>Outside wall may have a door now, icon adjusted</li>
 <li><i>Mai 24, 2012&nbsp;</i> by Ana Constantin:<br/>Added inside surface orientation</li>
 <li><i>April, 2012&nbsp;</i> by Mark Wesseling:<br/>Implemented.</li>
 </ul>
 </html>"));
end Wall;
