within AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses;
model ConvNLayerClearanceStar
  "Wall consisting of n layers, with convection on one surface and (window) clearance"

  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab="Dynamics", group="Equations"));

  parameter Modelica.Units.SI.Height h "Height"
    annotation (Dialog(group="Geometry"));
  parameter Modelica.Units.SI.Length l "Length"
    annotation (Dialog(group="Geometry"));
  parameter Modelica.Units.SI.Area clearance=0 "Area of clearance"
    annotation (Dialog(group="Geometry"));
    replaceable parameter AixLib.DataBase.Walls.WallBaseDataDefinition
    wallType constrainedby AixLib.DataBase.Walls.WallBaseDataDefinition
    "Type of wall" annotation(Dialog(group = "Structure of wall layers"), choicesAllMatching = true, Placement(transformation(extent={{48,-98},{68,-78}})));
  final parameter Integer n(min = 1) = wallType.n
    "Number of layers" annotation(Dialog(group = "Structure of wall layers"));
  final parameter Modelica.Units.SI.Thickness d[n]=wallType.d "Thickness"
    annotation (Dialog(group="Structure of wall layers"));
  final parameter Modelica.Units.SI.Density rho[n]=wallType.rho "Density"
    annotation (Dialog(group="Structure of wall layers"));
  final parameter Modelica.Units.SI.ThermalConductivity lambda[n]=wallType.lambda
    "Thermal conductivity" annotation (Dialog(group="Structure of wall layers"));
  final parameter Modelica.Units.SI.SpecificHeatCapacity c[n]=wallType.c
    "Specific heat capacity"
    annotation (Dialog(group="Structure of wall layers"));
  // which orientation of surface?
  parameter Integer surfaceOrientation "Surface orientation" annotation(Dialog(descriptionLabel = true, enable = if IsHConvConstant == true then false else true), choices(choice = 1
        "vertical",                                                                                                    choice = 2
        "horizontal facing up",                                                                                                    choice = 3
        "horizontal facing down",                                                                                                    radioButtons = true));
  parameter Integer calcMethod=2 "Calculation method for convective heat transfer coefficient at inside surface" annotation (Dialog(
        group="Convection", descriptionLabel=true), choices(
      choice=1 "EN ISO 6946 Appendix A >>Flat Surfaces<<",
      choice=2 "By Bernd Glueck",
      choice=3 "Custom hCon (constant)",
      choice=4 "ASHRAE140-2017",
      radioButtons=true));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hCon_const=2
    "Constant convective heat transfer coefficient"
    annotation (Dialog(group="Convection", enable=calcMethod == 1));

  parameter Integer radCalcMethod=1 "Calculation method for radiation heat transfer" annotation (
    Evaluate=true,
    Dialog(group = "Radiation", compact=true),
    choices(
      choice=1 "No approx",
      choice=2 "Linear approx at wall temp",
      choice=3 "Linear approx at rad temp",
      choice=4 "Linear approx at constant T_ref",
      radioButtons=true));
  parameter Modelica.Units.SI.Temperature T_ref=
      Modelica.Units.Conversions.from_degC(16)
    "Reference temperature for optional linearization"
    annotation (Dialog(group="Radiation", enable=radCalcMethod == 4));

  parameter Modelica.Units.SI.Temperature T0=
      Modelica.Units.Conversions.from_degC(16) "Initial temperature"
    annotation (Dialog(group="Thermal"));
  // 2n HeatConds
  // n Loads
  AixLib.Utilities.HeatTransfer.HeatConvInside heatConv(
    hCon_const=hCon_const,
    A=A,
    surfaceOrientation=surfaceOrientation,
    calcMethod=calcMethod) annotation (Placement(transformation(
        origin={62,0},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  AixLib.Utilities.Interfaces.RadPort radPort
    annotation (Placement(transformation(extent={{90,52},{110,72}})));
  AixLib.Utilities.HeatTransfer.HeatToRad twoStar_RadEx(
    final A=A,
    final eps=wallType.eps,
    final radCalcMethod=radCalcMethod,
    final T_ref=T_ref)
    annotation (Placement(transformation(extent={{54,30},{74,50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation (
      Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation (
      Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(
          extent={{90,-10},{110,10}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer simpleNLayer(
    final A=A,
    each final T_start=fill(T0, n),
    final wallRec=wallType,
    final energyDynamics=energyDynamics)
    annotation (Placement(transformation(extent={{-14,-12},{12,12}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b1
                                                             annotation (
      Placement(transformation(extent={{-10,88},{10,108}}), iconTransformation(
          extent={{-12,88},{8,108}})));
protected
  parameter Modelica.Units.SI.Area A=h*l - clearance;

equation
  connect(port_a, simpleNLayer.port_a)
    annotation (Line(points={{-100,0},{-14,0}}, color={191,0,0}));
  connect(simpleNLayer.port_b, heatConv.port_b)
    annotation (Line(points={{12,0},{52,0}}, color={191,0,0}));
  // connecting outmost elements to connectors: port_a--HeatCondb[1]...HeatConda[n]--HeatConv1--port_b
  connect(heatConv.port_a, port_b) annotation(Line(points={{72,0},{100,0}},                             color = {200, 100, 0}));
  connect(twoStar_RadEx.radPort, radPort) annotation (Line(
      points={{74.1,40},{100,40},{100,62}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  // computing approximated longwave radiation exchange

  connect(simpleNLayer.port_b, port_b1) annotation (Line(points={{12,0},{16,0},{16,40},{0,40},{0,98}}, color={191,0,0}));
  connect(simpleNLayer.port_b, twoStar_RadEx.convPort) annotation (Line(points={{12,0},{20,0},{20,40},{54,40}}, color={191,0,0}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),                                                                                  Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{24, 100}, {80, -100}}, lineColor = {0, 0, 0}, fillColor = {211, 243, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-56, 100}, {0, -100}}, lineColor = {166, 166, 166}, pattern = LinePattern.None, fillColor = {190, 190, 190},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-64, 100}, {-56, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {208, 208, 208},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-72, 100}, {-64, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {190, 190, 190},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-80, 100}, {-72, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {156, 156, 156},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{0, 100}, {8, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {208, 208, 208},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{16, 100}, {24, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {156, 156, 156},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{8, 100}, {16, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {190, 190, 190},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-80, -30}, {80, -42}}, lineColor = {0, 0, 0}, pattern = LinePattern.Dash, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-80, -32}, {80, -39}}, lineColor = {0, 0, 0}, pattern = LinePattern.Dash, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "gap"), Text(extent={{-78,-60},{22,-100}},      lineColor={0,0,0},
          textString="(a) 1 .. n (b)")}),                                                                                                                                                                                                        Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The <b>ConvNLayerClearanceStar</b> model represents a wall,
  consisting of n different layers with natural convection on one side
  and (window) clearance.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  There is one inner and one outer <b><a href=
  \"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b>-connector
  to simulate one-dimensional heat transfer through the wall and heat
  storage within the wall.
</p>
<p>
  The <b>ConvNLayerClearanceStar</b> model extends the basic concept by
  adding the functionality of approximated longwave radiation exchange.
  Simply connect all radiation exchanging surfaces via their
  <b><a href=\"Modelica://AixLib.Utilities.Interfaces.RadPort\">RadPort</a></b>-connectors.
</p>
<p>
  <b><span style=\"color: #ff0000\">Attention:</span></b> The first
  element in each vector represents the layer connected to
  <code>HeatPort_a</code>, the last element represents the layer
  connected to <code>HeatPort_b</code>.
</p>
<p>
  <code>HeatPort_b1</code> is the connection for
  <code>absSolarRadWin</code> the transmitted radiation through a
  window, that is absorbed by a wall.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  This model is part of <a href=
  \"AixLib.Building.Components.Walls.Wall\">Wall</a> therefore also part
  of the corresponding examples <a href=
  \"AixLib.Building.Components.Examples.Walls.InsideWall\">InsideWall</a>
  and <a href=
  \"AixLib.Building.Components.Examples.Walls.OutsideWall\">OutsideWall</a>.
</p>
<ul>
  <li>
    <i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>
    <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/898\">#898</a>:Added
    HeatPort to connect absSolarRadWin in Wall.
  </li>
  <li>
    <i>April 23, 2020</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/752\">#752</a>:
    Mainly add wallType, propagate energyDynamics, change icon.
  </li>
  <li>
    <i>October 12, 2016&#160;</i> by Tobias Blacha:<br/>
    Algorithm for HeatConv_inside is now selectable via parameters
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
    <i>Aug. 08, 2006&#160;</i> by Peter Matthes:<br/>
    Fixed wrong connection with heatConv-Module and added connection
    graphics.
  </li>
  <li>
    <i>June 19, 2006&#160;</i> by Timo Haase:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end ConvNLayerClearanceStar;
