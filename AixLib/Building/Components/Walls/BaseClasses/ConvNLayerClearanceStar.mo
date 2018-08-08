within AixLib.Building.Components.Walls.BaseClasses;
model ConvNLayerClearanceStar
  "Wall consisting of n layers, with convection on one surface and (window) clearance"
  parameter Modelica.SIunits.Height h = 3 "Height" annotation(Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Length l = 4 "Length" annotation(Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Area clearance = 0 "Area of clearance" annotation(Dialog(group = "Geometry"));
  parameter Boolean selectable = false
    "Determines if wall type is set manually (false) or by definitions (true)"                                    annotation(Dialog(group = "Structure of wall layers"));
  parameter DataBase.Walls.WallBaseDataDefinition wallType = DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S()
    "Type of wall"                                                                                                     annotation(Dialog(group = "Structure of wall layers", enable = selectable), choicesAllMatching = true);
  parameter Integer n(min = 1) = if selectable then wallType.n else 8
    "Number of layers"                                                                   annotation(Dialog(group = "Structure of wall layers", enable = not selectable));
  parameter Modelica.SIunits.Thickness d[n] = if selectable then wallType.d else fill(0.1, n)
    "Thickness"                                                                                           annotation(Dialog(group = "Structure of wall layers", enable = not selectable));
  parameter Modelica.SIunits.Density rho[n] = if selectable then wallType.rho else fill(1600, n)
    "Density"                                                                                              annotation(Dialog(group = "Structure of wall layers", enable = not selectable));
  parameter Modelica.SIunits.ThermalConductivity lambda[n] = if selectable then wallType.lambda else fill(2.4, n)
    "Thermal conductivity"                                                                                                     annotation(Dialog(group = "Structure of wall layers", enable = not selectable));
  parameter Modelica.SIunits.SpecificHeatCapacity c[n] = if selectable then wallType.c else fill(1000, n)
    "Specific heat capacity"                                                                                                     annotation(Dialog(group = "Structure of wall layers", enable = not selectable));
  // which orientation of surface?
  parameter Integer surfaceOrientation = 1 "Surface orientation" annotation(Dialog(descriptionLabel = true, enable = if IsAlphaConstant == true then false else true), choices(choice = 1
        "vertical",                                                                                                    choice = 2
        "horizontal facing up",                                                                                                    choice = 3
        "horizontal facing down",                                                                                                    radioButtons = true));
  parameter Integer calcMethod = 1
    "Choose the model for calculation of heat convection at inside surface" annotation (Dialog(descriptionLabel = true), choices(
      choice = 1 "EN ISO 6946 Appendix A >>Flat Surfaces<<",
      choice=2 "By Bernd Glueck",
      choice=3 "Constant alpha",radioButtons = true));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_constant = 2
    "Constant heat transfer coefficient"                                                                     annotation(Dialog(group = "Convection", enable = calcMethod == 1));
  parameter Modelica.SIunits.Emissivity eps = if selectable then wallType.eps else 0.95
    "Longwave emission coefficient"                                                                                     annotation(Dialog(group = "Radiation"));
  parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(16)
    "Initial temperature"                                                                                      annotation(Dialog(group = "Thermal"));
  // 2n HeatConds
  // n Loads
  Utilities.HeatTransfer.HeatConv_inside HeatConv1(port_b(T(start = T0)), alpha_custom = alpha_constant, A = A, surfaceOrientation = surfaceOrientation, calcMethod = calcMethod) annotation(Placement(transformation(origin={62,0},     extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Utilities.Interfaces.Star Star annotation(Placement(transformation(extent={{90,52},
            {110,72}})));
  Utilities.HeatTransfer.HeatToStar twoStar_RadEx(A = A, eps = eps, Therm(T(start = T0)), Star(T(start = T0))) annotation(Placement(transformation(extent={{54,28},
            {74,48}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation(Placement(transformation(extent={{-110,
            -10},{-90,10}}),                                                                                                        iconTransformation(extent={{-110,
            -10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(transformation(extent={{90,-10},
            {110,10}}),                                                                                                          iconTransformation(extent={{90,-10},
            {110,10}})));
  AixLib.Building.Components.Walls.BaseClasses.SimpleNLayer simpleNLayer(
    final A=A,
    final n=n,
    final d=d,
    final rho=rho,
    final lambda=lambda,
    final c=c,
    final T0=T0)
    annotation (Placement(transformation(extent={{-14,-12},{12,12}})));

protected
  parameter Modelica.SIunits.Area A = h * l - clearance;

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a dummyTherm
    "This really helps to solve initialisation problems in huge equation systems ..."                   annotation(Placement(transformation(extent = {{49, -41}, {54, -36}})));

equation
  connect(port_a, simpleNLayer.port_a) annotation (Line(points={{-100,0},{-14,0}},
                                    color={191,0,0}));
  connect(simpleNLayer.port_b, HeatConv1.port_b) annotation (Line(points={{12,0},{
          52,0}},                               color={191,0,0}));
  // connecting outmost elements to connectors: port_a--HeatCondb[1]...HeatConda[n]--HeatConv1--port_b
  connect(HeatConv1.port_a, port_b) annotation(Line(points={{72,0},{100,0}},                             color = {200, 100, 0}));
  connect(HeatConv1.port_b, twoStar_RadEx.Therm) annotation(Line(points={{52,0},{
          50,0},{50,38},{54.8,38}},                                                                                   color = {200, 100, 0}));
  connect(twoStar_RadEx.Star, Star) annotation(Line(points={{73.1,38},{100,38},
          {100,62}},                                                                           color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(HeatConv1.port_b, dummyTherm) annotation(Line(points={{52,0},{51.5,0},
          {51.5,-38.5}},                                                                                color = {200, 100, 0}));
  // computing approximated longwave radiation exchange

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
            fillPattern =                                                                                                   FillPattern.Solid, textString = "gap"), Text(extent = {{-44, -40}, {52, -114}}, lineColor = {0, 0, 0}, textString = "n")}), Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>The <b>ConvNLayerClearanceStar</b> model represents a wall, consisting of n different layers with natural convection on one side and (window) clearance.</p>
 <h4><font color=\"#008000\">Concept</font></h4>
 <p>There is one inner and one outer <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b>-connector to simulate one-dimensional heat transfer through the wall and heat storage within the wall.</p>
 <p>The <b>ConvNLayerClearanceStar</b> model extends the basic concept by adding the functionality of approximated longwave radiation exchange. Simply connect all radiation exchanging surfaces via their <b><a href=\"Modelica://AixLib.Utilities.Interfaces.Star\">Star</a></b>-connectors. </p>
 <p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>HeatPort_a</code>, the last element represents the layer connected to <code>HeatPort_b</code>. </p>
 <h4><font color=\"#008000\">Example Results</font></h4>
 <p>This model is part of <a href=\"AixLib.Building.Components.Walls.Wall\">Wall</a>  therefore also part of the corresponding examples <a href=\"AixLib.Building.Components.Examples.Walls.InsideWall\">InsideWall</a> and <a href=\"AixLib.Building.Components.Examples.Walls.OutsideWall\">OutsideWall</a>. </p>
 </html>", revisions="<html>
 <ul>
<li><i>October 12, 2016&nbsp;</i> by Tobias Blacha:<br/>Algorithm for HeatConv_inside is now selectable via parameters</li>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>Aug. 08, 2006&nbsp;</i>
          by Peter Matthes:<br/>
          Fixed wrong connection with heatConv-Module and added connection graphics.</li>

<li><i>June 19, 2006&nbsp;</i>
          by Timo Haase:<br/>
          Implemented.</li>
 </ul>
 </html>"));
end ConvNLayerClearanceStar;
