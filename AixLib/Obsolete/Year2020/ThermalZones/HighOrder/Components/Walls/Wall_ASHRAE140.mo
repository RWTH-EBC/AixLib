within AixLib.Obsolete.Year2020.ThermalZones.HighOrder.Components.Walls;
model Wall_ASHRAE140 "Wall modell for ASHRAE 140 with absorbtion of solar radiation"

  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;
  //Type parameter

   parameter Boolean outside = true
    "Choose if the wall is an outside or an inside wall"                                  annotation(Dialog(group="General Wall Type Parameter",compact = true),choices(choice=true
        "Outside Wall",choice=false "Inside Wall",        radioButtons = true));

  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab="Dynamics", group="Equations"));

  // general wall parameters

  replaceable parameter AixLib.DataBase.Walls.WallBaseDataDefinition
    WallType constrainedby AixLib.DataBase.Walls.WallBaseDataDefinition
    "Type of wall"
    annotation(Dialog(group = "Structure of wall layers"), choicesAllMatching = true, Placement(transformation(extent={{2,76},{22,96}})));

  parameter Modelica.Units.SI.Length wall_length=2 "Length of wall"
    annotation (Dialog(group="Room Geometry"));
  parameter Modelica.Units.SI.Height wall_height=2 "Height of wall"
    annotation (Dialog(group="Room Geometry"));

// Surface parameters
  parameter Real solar_absorptance=0.25
    "Solar absorptance coefficient of outside wall surface"  annotation(Dialog(tab="Surface Parameters", group = "Outside surface", enable = outside));

  parameter Integer calcMethodOut=1 "Calculation method for convectice heat transfer coeffient at outside surface"    annotation (Dialog(
      tab="Surface Parameters",
      group="Outside surface",
      enable=outside,
      compact=true), choices(
      choice=1 "DIN 6946",
      choice=2 "ASHRAE Fundamentals",
      choice=3 "Custom hCon (constant)",
      radioButtons=true));

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hCon_const=25
    "Custom convective heat transfer coefficient (just for manual selection, not recommended)"
    annotation (Dialog(
      tab="Surface Parameters",
      group="Outside surface",
      enable=calcMethodOut == 3 and outside));
    parameter
    AixLib.DataBase.Surfaces.RoughnessForHT.PolynomialCoefficients_ASHRAEHandbook
    surfaceType =    AixLib.DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster()
    "Surface type of outside wall"
    annotation(Dialog(tab="Surface Parameters",group = "Outside surface",  enable=calcMethodOut == 2 and outside),
                                                                                                            choicesAllMatching = true);

  parameter Integer ISOrientation = 1 "Inside surface orientation" annotation(Dialog(tab = "Surface Parameters",  group = "Inside surface", compact = true, descriptionLabel = true), choices(choice=1
        "vertical wall",                                                                                                    choice = 2 "floor",
                 choice = 3 "ceiling",radioButtons =  true));
  parameter Real solarDistribution(min=0.0, max=1.0) = 0.038 "Solar distribution fraction of the transmitted radiation through the window on the surface";
//  parameter Real solFractCoeff = 0.65 "solar fraction coefficient. Ex: floor = 0.65, ceiling = 0.15, vertical walls = 0.04" annotation(Dialog(tab = "Surface Parameters",  group = "Inside surface" ));

    // window parameters
   parameter Boolean withWindow = false
    "Choose if the wall has got a window (only outside walls)"                                     annotation(Dialog( tab="Window", enable = outside));
   replaceable model Window =
      AixLib.ThermalZones.HighOrder.Components.WindowsDoors.Window_ASHRAE140
   constrainedby
    AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow
    "Model for window"
                     annotation(Dialog( tab="Window",  enable = withWindow and outside), choicesAllMatching=true);

   parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
                                                          WindowType=
           AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009()
    "Choose a window type from the database"
                           annotation(Dialog( tab="Window", enable = withWindow and outside),choicesAllMatching= true);
  parameter Modelica.Units.SI.Area windowarea=2 "Area of window"
    annotation (Dialog(tab="Window", enable=withWindow and outside));

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
   parameter Boolean withDoor = false "Choose if the wall has got a door"  annotation(Dialog(tab="Door"));

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

  final parameter Modelica.Units.SI.Area clearance=if not (outside) and
      withDoor then door_height*door_width else if outside and withDoor and
      withWindow then (windowarea + door_height*door_width) else if outside
       and withWindow then windowarea else if outside and withDoor then
      door_height*door_width else 0 "Wall clearance";

// Initial temperature

  parameter Modelica.Units.SI.Temperature T0=
      Modelica.Units.Conversions.from_degC(20) "Initial temperature"
    annotation (Dialog(tab="Initialization"));

// COMPONENT PART

public
  AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.ConvNLayerClearanceStar Wall(
    final energyDynamics=energyDynamics,
    h=wall_height,
    l=wall_length,
    T0=T0,
    clearance=clearance,
    eps=WallType.eps,
    wallType=WallType,
    surfaceOrientation=ISOrientation,
    heatConv(calcMethod=2)) "Wall" annotation (Placement(transformation(extent={{-20,14},{2,34}})));

  Utilities.Interfaces.SolarRad_in
                                 SolarRadiationPort  if outside annotation (
      Placement(transformation(extent={{-116,79},{-96,99}}),
        iconTransformation(extent={{-36,100},{-16,120}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_outside
    annotation (Placement(transformation(extent={{-108,-6},{-88,14}}), iconTransformation(extent={{-31,-10},{-11,10}})));

  Modelica.Blocks.Interfaces.RealInput WindSpeedPort if outside and (calcMethodOut == 1 or calcMethodOut == 2)
    annotation (Placement(transformation(extent={{-113,54},{-93,74}}), iconTransformation(extent={{-31,78},{-11,98}})));

  AixLib.ThermalZones.HighOrder.Components.Sunblinds.Sunblind Sunblind(
    final n=1,
    final gsunblind={Blinding},
    final Imax=LimitSolIrr,
    final TOutAirLimit=TOutAirLimit) if outside and withWindow and withSunblind
    annotation (Placement(transformation(extent={{-44,-22},{-21,4}})));

  AixLib.ThermalZones.HighOrder.Components.WindowsDoors.Door Door(
    door_area=door_height*door_width,
    U=U_door*2,
    eps=eps_door) if withDoor annotation (Placement(transformation(extent={{-21,-102},{11,-70}})));
  Utilities.HeatTransfer.HeatConvOutside heatTransfer_Outside(
    A=wall_length*wall_height - clearance,
    calcMethod=calcMethodOut,
    surfaceType=surfaceType,
    hCon_const=hCon_const) if outside annotation (Placement(transformation(extent={{-47,48},{-27,68}})));

  Utilities.Interfaces.Adaptors.ConvRadToCombPort heatStarToComb annotation (Placement(transformation(
        extent={{-10,8},{10,-8}},
        rotation=180,
        origin={69,-1})));
  Utilities.Interfaces.ConvRadComb thermStarComb_inside annotation (Placement(transformation(extent={{92,-10},{112,10}}), iconTransformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Interfaces.RealInput solarRadWin
    "solar raditaion through window" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={101,80}),
                       iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={22,88})));
  Modelica.Blocks.Math.Gain solarDistrFraction(k=solarDistribution)
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
  Modelica.Blocks.Sources.RealExpression SolarRadTotal(y=SolarRadiationPort.H) if outside
    annotation (Placement(transformation(extent={{-80,86},{-60,106}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempOutAirSensor
    "Outdoor air (dry bulb) temperature sensor"
    annotation (Placement(transformation(extent={{-66,-18},{-58,-10}})));
  Window window(
    T0=T0,
    windowarea=windowarea,
    WindowType=WindowType)          if withWindow and outside
    annotation (Placement(transformation(extent={{-9,-42},{11,-22}})));
equation

//******************************************************************
// **********************standard connection************************
//******************************************************************
  connect(Wall.radPort, heatStarToComb.portRad) annotation (Line(
      points={{2,30.2},{48,30.2},{48,4},{59,4}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(Wall.port_b, heatStarToComb.portConv) annotation (Line(points={{2,24},{48,24},{48,-6},{59,-6}},       color={191,0,0}));
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
  connect(SolarRadTotal.y, AbscoeffA.u) annotation (Line(points={{-59,96},{-54,96},{-54,88},{-50.2,88}}, color={0,0,127}));
  connect(AbscoeffA.y, absSolarRadWall.Q_flow) annotation (Line(
      points={{-36.4,88},{-30,88}},
      color={0,0,127}));
  connect(Wall.port_a, absSolarRadWall.port) annotation (Line(
      points={{-20,24},{-24,24},{-24,66},{-5,66},{-5,88},{-10,88}},
      color={191,0,0}));

  //heat convection on the outside
    if calcMethodOut == 1 or calcMethodOut == 2 then
    connect(WindSpeedPort, heatTransfer_Outside.WindSpeedPort) annotation (Line(
      points={{-103,64},{-68,64},{-68,51},{-46,51}},
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
    connect(Door.port_b, heatStarToComb.portConv) annotation (Line(points={{9.4,-86},{48,-86},{48,-6},{59,-6}},       color={191,0,0}));
    connect(Door.radPort, heatStarToComb.portRad) annotation (Line(
        points={{9.4,-76.4},{48,-76.4},{48,4},{59,4}},
        color={95,95,95},
        pattern=LinePattern.Solid));

end if;

//******************************************************************
// **** connections for outside wall with window and sunblind****
//******************************************************************

if outside and withWindow and withSunblind then
    connect(SolarRadiationPort, Sunblind.Rad_In[1]) annotation (Line(
      points={{-106,89},{-56,89},{-56,-7.375},{-45.4375,-7.375}},
      color={255,128,0}));
end if;

//******************************************************************
// **** connections for outside wall with window without sunblind****
//******************************************************************
  if outside and withWindow and not withSunblind then
    connect(window.solarRad_in, SolarRadiationPort) annotation(Line(points={{-8,-26},{-80,-26},{-80,89},{-106,89}},                       color = {255, 128, 0}));
  end if;

//******************************************************************
// **** connections for absorbed solar radiation inside wall****
//******************************************************************
  connect(heatStarToComb.portConvRadComb, thermStarComb_inside) annotation (Line(points={{79,-1},{79,-1.05},{102,-1.05},{102,0}},       color={191,0,0}));
  connect(solarRadWin, solarDistrFraction.u) annotation (Line(
      points={{101,80},{69.2,80}},
      color={0,0,127}));
  connect(solarDistrFraction.y, absSolarRadWin.Q_flow) annotation (Line(
      points={{55.4,80},{49,80}},
      color={0,0,127}));

  connect(port_outside, tempOutAirSensor.port) annotation (Line(points={{-98,4},
          {-70,4},{-70,-14},{-66,-14}}, color={191,0,0}));
  connect(tempOutAirSensor.T, Sunblind.TOutAir) annotation (Line(points={{-58,-14},{-54,-14},{-54,-13.875},{-45.4375,-13.875}},
                                                      color={0,0,127}));
  connect(absSolarRadWin.port, Wall.port_b1) annotation (Line(points={{29,80},{7,
          80},{7,57},{-9.22,57},{-9.22,33.8}}, color={191,0,0}));
  connect(WindSpeedPort, window.WindSpeedPort) annotation (Line(points={{-103,64},{-68,64},{-68,51},{-56,51},{-56,-37},{-8,-37}},
                                                              color={0,0,127}));
  connect(port_outside, window.port_outside) annotation (Line(points={{-98,4},{-56,4},{-56,-33},{-8,-33}},
                                      color={191,0,0}));
  connect(Sunblind.Rad_Out[1], window.solarRad_in) annotation (Line(points={{-19.5625,-7.375},{-20,-7.375},{-20,-26},{-8,-26}},
                                                       color={255,128,0}));
  connect(window.radPort, heatStarToComb.portRad) annotation (Line(points={{10,-26},{48,-26},{48,4},{59,4}},
                                              color={95,95,95}));
  connect(window.port_inside, heatStarToComb.portConv) annotation (Line(points={{10,-33},{48,-33},{48,-6},{59,-6}},
                                                             color={191,0,0}));
  connect(window.solarRadWinTrans, solarRadWinTrans) annotation (Line(points={{10.2,-24},{48,-24},{48,-60},{110,-60}},
                                                  color={0,0,127}));
  annotation (
  obsolete = "Obsolete model - Please use AixLib.ThermalZones.HighOrder.Components.Walls.Wall instead.",
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1})),
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
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Flexible Model for Inside Walls and Outside Walls.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The <b>Wall</b> model models
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
  <b><span style=\"color: #008000\">Assumputions</span></b>
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
</html>",
revisions="<html><ul>
  <li>
    <i>July 25, 2014&#160;</i> by Ana Constantin:<br/>
    Corrected activation of door for an outside wall
  </li>
  <li>
    <i>Mai 19, 2014&#160;</i> by Ana Constantin:<br/>
    Uses components from MSL and respects the naming conventions
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
end Wall_ASHRAE140;
