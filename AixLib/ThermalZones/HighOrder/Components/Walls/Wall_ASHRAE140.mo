within AixLib.ThermalZones.HighOrder.Components.Walls;
model Wall_ASHRAE140
  "Wall modell for ASHRAE 140 with absorbtion of solar radiation"

  //Type parameter

   parameter Boolean outside = true
    "Choose if the wall is an outside or an inside wall"                                  annotation(Dialog(group="General Wall Type Parameter",compact = true),choices(choice=true
        "Outside Wall",choice=false "Inside Wall",        radioButtons = true));

  // general wall parameters

   parameter AixLib.DataBase.Walls.WallBaseDataDefinition WallType=
      AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S()
    "Choose an outside wall type from the database"
    annotation (Dialog(group="Room Geometry"), choicesAllMatching=true);

   parameter Modelica.SIunits.Length wall_length=2 "Length of wall"
                      annotation(Dialog(group="Room Geometry"));
   parameter Modelica.SIunits.Height wall_height=2 "Height of wall"
                      annotation(Dialog(group="Room Geometry"));

// Surface parameters
  parameter Real solar_absorptance=0.25
    "Solar absorptance coefficient of outside wall surface"  annotation(Dialog(tab="Surface Parameters", group = "Outside surface", enable = outside));

  parameter Integer Model =  1
    "Choose the model for calculation of heat convection at outside surface"
    annotation(Dialog(tab = "Surface Parameters",  group = "Outside surface", enable = outside, compact = true), choices(choice=1
        "DIN 6946",                                                                                                    choice = 2
        "ASHRAE Fundamentals", choice = 3 "Custom alpha",radioButtons =  true));

  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_custom=25
    "Custom alpha for convection (just for manual selection, not recommended)" annotation(Dialog(tab="Surface Parameters", group = "Outside surface", enable= Model == 3 and outside));
    parameter
    AixLib.DataBase.Surfaces.RoughnessForHT.PolynomialCoefficients_ASHRAEHandbook
    surfaceType =    AixLib.DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster()
    "Surface type of outside wall"
    annotation(Dialog(tab="Surface Parameters",group = "Outside surface",  enable= Model == 2 and outside), choicesAllMatching = true);

  parameter Integer ISOrientation = 1 "Inside surface orientation" annotation(Dialog(tab = "Surface Parameters",  group = "Inside surface", compact = true, descriptionLabel = true), choices(choice=1
        "vertical wall",                                                                                                    choice = 2 "floor",
                 choice = 3 "ceiling",radioButtons =  true));
//  parameter Real solFractCoeff = 0.65 "solar fraction coefficient. Ex: floor = 0.65, ceiling = 0.15, vertical walls = 0.04" annotation(Dialog(tab = "Surface Parameters",  group = "Inside surface" ));

    // window parameters
   parameter Boolean withWindow = false
    "Choose if the wall has got a window (only outside walls)"                                     annotation(Dialog( tab="Window", enable = outside));

   parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
                                                          WindowType=
           AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009()
    "Choose a window type from the database"
                           annotation(Dialog( tab="Window", enable = withWindow and outside),choicesAllMatching= true);
   parameter Modelica.SIunits.Area windowarea=2 "Area of window" annotation(Dialog( tab="Window",  enable = withWindow and outside));

  parameter Boolean withSunblind = false "enable support of sunblinding?" annotation(Dialog(tab = "Window", enable = outside and withWindow));
  parameter Real Blinding = 0 "blinding factor: 0 means total blocking of solar irradiation" annotation(Dialog(tab = "Window", enable = withWindow and outside and withSunblind));
  parameter Real LimitSolIrr
    "Minimum specific total solar radiation in W/m2 for blinding becoming active (see also TOutAirLimit)"
    annotation(Dialog(tab="Window",   enable=withWindow and outside and
          withSunblind));
  parameter Modelica.SIunits.Temperature TOutAirLimit
    "Temperature at which sunblind closes (see also LimitSolIrr)"
    annotation(Dialog(tab = "Window", enable = withWindow and outside and withSunblind));

   // door parameters
   parameter Boolean withDoor = false "Choose if the wall has got a door"  annotation(Dialog(tab="Door"));

  parameter Modelica.SIunits.CoefficientOfHeatTransfer U_door=1.8
    "Thermal transmission coefficient of door"
    annotation (Dialog(tab="Door", enable = withDoor));

  parameter Modelica.SIunits.Emissivity eps_door = 0.9
    "Solar emissivity of door material"                                                    annotation (Dialog(tab="Door", enable = withDoor));

   parameter Modelica.SIunits.Length door_height=2 annotation(Dialog(tab="Door", enable = withDoor));
   parameter Modelica.SIunits.Length door_width=1 annotation(Dialog( tab="Door", enable = withDoor));

// Calculation of clearance

 final parameter Modelica.SIunits.Area clearance=
 if not (outside) and withDoor then  door_height*door_width else
 if outside and withDoor and withWindow then (windowarea + door_height*door_width) else
 if outside and withWindow then  windowarea else
 if outside and withDoor then door_height*door_width else
      0 "Wall clearance";

// Initial temperature

 parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(20)
    "Initial temperature"                                                   annotation(Dialog(tab="Advanced Parameters"));

// COMPONENT PART

public
  BaseClasses.ConvNLayerClearanceStar                           Wall(
    h=wall_height,
    l=wall_length,
    T0=T0,
    clearance=clearance,
    selectable=true,
    eps=WallType.eps,
    wallType=WallType,
    surfaceOrientation=ISOrientation,
    HeatConv1(calcMethod=2)) "Wall"          annotation (Placement(
        transformation(extent={{-20,14},{2,34}})));

  Utilities.Interfaces.SolarRad_in
                                 SolarRadiationPort if  outside annotation (
      Placement(transformation(extent={{-116,79},{-96,99}}),
        iconTransformation(extent={{-36,100},{-16,120}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_outside
    annotation (Placement(transformation(extent={{-108,-6},{-88,14}}), iconTransformation(extent={{-31,-10},{-11,10}})));

  Modelica.Blocks.Interfaces.RealInput WindSpeedPort if outside and (Model ==1 or Model ==2)
    annotation (Placement(transformation(extent={{-113,54},{-93,74}}), iconTransformation(extent={{-31,78},{-11,98}})));

  AixLib.ThermalZones.HighOrder.Components.Sunblinds.Sunblind Sunblind(
    final n=1,
    final gsunblind={Blinding},
    final Imax=LimitSolIrr,
    final TOutAirLimit=TOutAirLimit) if outside and withWindow and withSunblind
    annotation (Placement(transformation(extent={{-44,-22},{-21,4}})));

  WindowsDoors.Door                     Door(
    T0=T0,
    door_area=door_height*door_width,
    U=U_door*2,
    eps=eps_door) if withDoor
    annotation (Placement(transformation(extent={{-21,-102},{11,-70}})));
  AixLib.ThermalZones.HighOrder.Components.WindowsDoors.Window_ASHRAE140
                                                windowSimple(
    T0=T0,
    windowarea=windowarea,
    WindowType=WindowType,
    eps_out=0.84) if          withWindow and outside
    annotation (Placement(transformation(extent={{-15,-48},{11,-22}})));
  Utilities.HeatTransfer.HeatConv_outside
                                        heatTransfer_Outside(
    A=wall_length*wall_height - clearance,
    Model=Model,
    surfaceType=surfaceType,
    alpha_custom=alpha_custom) if            outside
    annotation (Placement(transformation(extent={{-47,48},{-27,68}})));

  Utilities.Interfaces.Adaptors.HeatStarToComb
                                             heatStarToComb annotation (
      Placement(transformation(
        extent={{-10,8},{10,-8}},
        rotation=180,
        origin={69,-1})));
  Utilities.Interfaces.HeatStarComb
                                  thermStarComb_inside annotation (Placement(
        transformation(extent={{92,-10},{112,10}}), iconTransformation(extent=
           {{10,-10},{30,10}})));
  Modelica.Blocks.Interfaces.RealInput solarRadWin
    "solar raditaion through window" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={101,80}),
                       iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={22,88})));
  Modelica.Blocks.Math.Gain solarDistrFraction(k=if ISOrientation == 1 then
        0.038 else if ISOrientation == 2 then 0.642 else 0.168)
    "interior solar distribution factors" annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={62,80})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow absSolarRadWin
    "absorbed solar radiation through window" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={39,80})));
  Modelica.Blocks.Interfaces.RealOutput solarRadWinTrans if withWindow
    "Output signal connector"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}}),
        iconTransformation(extent={{15,-72},{35,-52}})));
  Modelica.Blocks.Math.Gain AbscoeffA(k=solar_absorptance*(wall_height*
        wall_length - clearance)) if outside
    "multiplication withabsorbtioncoefficient and area"
    annotation (Placement(transformation(extent={{-49,82},{-37,94}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow absSolarRadWall if outside
    "absorbed solar radiation on wall"        annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-20,88})));
  Modelica.Blocks.Sources.RealExpression SolarRadTotal(y=SolarRadiationPort.I) if outside
    annotation (Placement(transformation(extent={{-80,86},{-60,106}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempOutAirSensor
    "Outdoor air (dry bulb) temperature sensor"
    annotation (Placement(transformation(extent={{-66,-18},{-58,-10}})));
equation

//******************************************************************
// **********************standard connection************************
//******************************************************************
  connect(Wall.Star, heatStarToComb.star) annotation (Line(
      points={{2,30.2},{48,30.2},{48,4.8},{58.6,4.8}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(Wall.port_b, heatStarToComb.therm) annotation (Line(
      points={{2,24},{48,24},{48,-6.1},{58.9,-6.1}},
      color={191,0,0}));
//******************************************************************
// **********************standard connection for inside wall********
//******************************************************************
if not (outside) then
    connect(Wall.port_a, port_outside) annotation (Line(
        points={{-20,24},{-56.45,24},{-56.45,4},{-98,4}},
        color={191,0,0}));
end if;

//******************************************************************
// ********************standard connection for outside wall*********
//******************************************************************

if (outside) then
  //absorbtion of solar radition in wall
  connect(SolarRadTotal.y, AbscoeffA.u);
  connect(AbscoeffA.y, absSolarRadWall.Q_flow) annotation (Line(
      points={{-36.4,88},{-30,88}},
      color={0,0,127}));
  connect(Wall.port_a, absSolarRadWall.port) annotation (Line(
      points={{-20,24},{-24,24},{-24,66},{-3,66},{-3,88},{-10,88}},
      color={191,0,0}));

  //heat convection on the outside
  if Model == 1 or Model == 2 then
    connect(WindSpeedPort, heatTransfer_Outside.WindSpeedPort) annotation (Line(
      points={{-103,64},{-68,64},{-68,50.8},{-46.2,50.8}},
      color={0,0,127}));
  end if;
    connect(heatTransfer_Outside.port_a, port_outside) annotation (Line(
        points={{-47,58},{-56,58},{-56,4},{-98,4}},
        color={191,0,0}));
    connect(heatTransfer_Outside.port_b,Wall.port_a)  annotation (Line(
        points={{-27,58},{-24,58},{-24,24},{-20,24}},
        color={191,0,0}));

end if;

//******************************************************************
// *******standard connections for with door************
//******************************************************************

if withDoor then

    connect(Door.port_a, port_outside) annotation (Line(
        points={{-19.4,-86},{-56,-86},{-56,23},{-24,23},{-24,4},{-98,4}},
        color={191,0,0}));
    connect(Door.port_b, heatStarToComb.therm) annotation (Line(
        points={{9.4,-86},{48,-86},{48,-6.1},{58.9,-6.1}},
        color={191,0,0}));
    connect(Door.Star, heatStarToComb.star) annotation (Line(
        points={{9.4,-76.4},{48,-76.4},{48,4.8},{58.6,4.8}},
        color={95,95,95},
        pattern=LinePattern.Solid));

end if;

//******************************************************************
// ****standard connections for outside wall with window***********
//******************************************************************

if outside and withWindow then
    connect(windowSimple.port_inside, heatStarToComb.therm) annotation (Line(
      points={{9.7,-36.3},{48,-36.3},{48,-6.1},{58.9,-6.1}},
      color={191,0,0}));
    connect(windowSimple.Star, heatStarToComb.star) annotation (Line(
      points={{9.7,-27.2},{48,-27.2},{48,4.8},{58.6,4.8}},
      color={95,95,95},
      pattern=LinePattern.Solid));
    connect(windowSimple.port_outside, port_outside) annotation (Line(
        points={{-13.7,-36.3},{-56,-36.3},{-56,4},{-98,4}},
        color={191,0,0}));
    connect(windowSimple.solarRadWinTrans, solarRadWinTrans) annotation (Line(
      points={{9.96,-24.6},{48,-24.6},{48,-60},{110,-60}},
      color={0,0,127}));
    connect(windowSimple.WindSpeedPort, WindSpeedPort) annotation (Line(
      points={{-13.7,-41.5},{-56,-41.5},{-56,64},{-103,64}},
      color={0,0,127}));

end if;

//******************************************************************
// **** connections for outside wall with window without sunblind****
//******************************************************************

if outside and withWindow and not (withSunblind) then
   connect(SolarRadiationPort, windowSimple.solarRad_in) annotation (Line(
      points={{-106,89},{-56,89},{-56,-27.2},{-13.7,-27.2}},
      color={255,128,0}));

end if;

//******************************************************************
// **** connections for outside wall with window and sunblind****
//******************************************************************

if outside and withWindow and withSunblind then
    connect(Sunblind.Rad_Out[1], windowSimple.solarRad_in) annotation (Line(
      points={{-22.15,-7.7},{-19,-7.7},{-19,-27.2},{-13.7,-27.2}},
      color={255,128,0}));
    connect(SolarRadiationPort, Sunblind.Rad_In[1]) annotation (Line(
      points={{-106,89},{-56,89},{-56,-7.7},{-42.85,-7.7}},
      color={255,128,0}));
end if;

//******************************************************************
// **** connections for absorbed solar radiation inside wall****
//******************************************************************
 connect(absSolarRadWin.port, Wall.HeatConv1.port_b);
  connect(heatStarToComb.thermStarComb, thermStarComb_inside) annotation (
      Line(
      points={{78.4,-1.1},{78.4,-1.05},{102,-1.05},{102,0}},
      color={191,0,0}));
  connect(solarRadWin, solarDistrFraction.u) annotation (Line(
      points={{101,80},{69.2,80}},
      color={0,0,127}));
  connect(solarDistrFraction.y, absSolarRadWin.Q_flow) annotation (Line(
      points={{55.4,80},{49,80}},
      color={0,0,127}));

  connect(port_outside, tempOutAirSensor.port) annotation (Line(points={{-98,4},
          {-70,4},{-70,-14},{-66,-14}}, color={191,0,0}));
  connect(tempOutAirSensor.T, Sunblind.TOutAir) annotation (Line(points={{-58,
          -14},{-54,-14},{-54,-14.2},{-45.84,-14.2}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={Line(
          points={{27,80},{-3,80},{-3,38}},
          color={127,0,0})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-20,-120},{20,120}},
        grid={1,1}), graphics={
      Rectangle(
          extent={{-16,120},{15,-60}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Backward,
           pattern=LinePattern.None,
          lineColor={0,0,0}),
      Rectangle(
          extent={{-16,-90},{15,-120}},
           pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Backward),
      Rectangle(
          extent={{-16,-51},{15,-92}},
          lineColor={0,0,0},
           pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Backward,
          visible=not ((withDoor))),
      Rectangle(
          extent={{-16,80},{15,20}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible= outside and withWindow,
          lineColor={255,255,255}),
        Line(
          points={{-2,80},{-2,20}},
          visible=outside and withWindow),
        Line(
          points={{1,80},{1,20}},
          visible=outside and withWindow),
        Line(
          points={{1,77},{-2,77}},
          visible=outside and withWindow),
        Line(
          points={{1,23},{-2,23}},
          visible=outside and withWindow),
        Ellipse(
          extent={{-16,-60},{44,-120}},
          lineColor={0,0,0},
          startAngle=359,
          endAngle=450,
          visible= withDoor),
        Rectangle(
          extent={{-16,-60},{15,-90}},
          visible= withDoor,
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{1,50},{-2,50}},
          visible=outside and withWindow),
        Line(
          points={{15,80},{15,20}},
          visible=outside and withWindow),
        Line(
          points={{-16,80},{-16,20}},
          visible=outside and withWindow),
        Line(
          points={{-16,-60},{-16,-90}},
          visible=withDoor),
        Line(
          points={{15,-60},{15,-90}},
          visible=withDoor),
        Line(
          points={{-16,-90},{15,-60}},
          visible=withDoor),
        Line(
          points={{-16,-60},{15,-90}},
          visible=withDoor)}),
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Flexible Model for Inside Walls and Outside Walls. </p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The<b> Wall</b> model models </p>
<ul>
<li>Conduction and convection for a wall (different on the inside surface depending on the surface orientation: vertical wall, floor or ceiling)</li>
<li>Outside walls may have a window and/ or a door</li>
<li>Inside walls may have a door</li>
</ul>
<p>This model uses a <a href=\"AixLib.Utilities.Interfaces.HeatStarComb\">HeatStarComb</a> Connector for an easier connection of temperature and radiance inputs.</p>
<p><b><font style=\"color: #008000; \">Assumputions</font></b> </p>
<ul>
<li>Outside walls are represented as complete walls</li>
<li>Inside walls are modeled as a half of a wall, you need to connect a corresponding second half with the same values</li>
<li>Door and window got a constant U-value</li>
<li>No heat storage in doors or window </li>
</ul>
<p>Have a closer look at the used models to get more information about the assumptions. </p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
</html>",
revisions="<html>
<ul>
<li><i>July 25, 2014&nbsp;</i> by Ana Constantin:<br/>Corrected activation of door for an outside wall</li>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>June 22, 2012&nbsp;</i> by Lukas Mencher:<br/>Outside wall may have a door now, icon adjusted</li>
<li><i>Mai 24, 2012&nbsp;</i> by Ana Constantin:<br/>Added inside surface orientation</li>
<li><i>April, 2012&nbsp;</i> by Mark Wesseling:<br/>Implemented.</li>
</ul>
</html>"));
end Wall_ASHRAE140;
