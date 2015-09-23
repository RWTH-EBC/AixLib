within AixLib.Building.Components.Walls.BaseClasses;
model ConvNLayerClearanceStar_old
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
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_custom = 2
    "Constant heat transfer coefficient"                                                                     annotation(Dialog(group = "Convection", enable = control_type == ct.custom));
  parameter Modelica.SIunits.Emissivity eps = if selectable then wallType.eps else 0.95
    "Longwave emission coefficient"                                                                                     annotation(Dialog(group = "Radiation"));
  parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(16)
    "Initial temperature"                                                                                      annotation(Dialog(group = "Thermal"));
  // 2n HeatConds
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatCondb[n](port_b(each T(start = T0)), port_a(each T(start = T0)), G = A * lambda ./ (d / 2)) annotation(Placement(transformation(extent = {{8, -8}, {28, 12}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatConda[n](port_b(each T(start = T0)), port_a(each T(start = T0)), G = A .* lambda ./ (d / 2)) annotation(Placement(transformation(extent = {{-50, -8}, {-30, 12}}, rotation = 0)));
  // n Loads
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Load[n](T(start = fill(T0, n)), C = c .* rho .* A .* d) annotation(Placement(transformation(extent = {{-8, -62}, {12, -42}}, rotation = 0)));
  Utilities.HeatTransfer.HeatConv_inside_old
                                         HeatConv1(port_b(T(start = T0)), alpha_custom = alpha_custom, A = A, surfaceOrientation = surfaceOrientation) annotation(Placement(transformation(origin={64,2},     extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Utilities.Interfaces.Star Star annotation(Placement(transformation(extent = {{80, 50}, {100, 70}}, rotation = 0)));
  Utilities.HeatTransfer.HeatToStar twoStar_RadEx(A = A, eps = eps, Therm(T(start = T0)), Star(T(start = T0))) annotation(Placement(transformation(extent = {{54, 30}, {74, 50}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation(Placement(transformation(extent = {{-104, -8}, {-84, 12}}), iconTransformation(extent = {{-100, -20}, {-80, 0}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(transformation(extent = {{76, -8}, {96, 12}}), iconTransformation(extent = {{80, -20}, {100, 0}})));
protected
  parameter Modelica.SIunits.Area A = h * l - clearance;
protected
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a dummyTherm
    "This really helps to solve initialisation problems in huge equation systems ..."
                                                                                                        annotation(Placement(transformation(extent = {{49, -41}, {54, -36}}, rotation = 0)));
equation
  // connecting inner elements HeatCondb[i]--Load[i]--HeatConda[i] to n groups
  for i in 1:n loop
    connect(HeatConda[i].port_b, Load[i].port) annotation(Line(points = {{-30, 2}, {-10, 2}, {-10, -62}, {2, -62}}, color = {200, 100, 0}));
    connect(Load[i].port, HeatCondb[i].port_a) annotation(Line(points = {{2, -62}, {-10, -62}, {-10, 2}, {8, 2}}, color = {200, 100, 0}));
  end for;
  // establishing n-1 connections of HeatCondb--Load--HeatConda groups
  for i in 1:n - 1 loop
    connect(HeatCondb[i].port_b, HeatConda[i + 1].port_a);
  end for;
  // connecting outmost elements to connectors: port_a--HeatCondb[1]...HeatConda[n]--HeatConv1--port_b
  connect(HeatConda[1].port_a, port_a) annotation(Line(points = {{-50, 2}, {-94, 2}}, color = {200, 100, 0}));
  connect(HeatConv1.port_a, port_b) annotation(Line(points={{74,2},{84.5,2},{86,
          2}},                                                                                           color = {200, 100, 0}));
  connect(HeatCondb[n].port_b, HeatConv1.port_b) annotation(Line(points={{28,2},{
          52,2},{54,2}},                                                                                          color = {200, 100, 0}));
  connect(HeatConv1.port_b, twoStar_RadEx.Therm) annotation(Line(points={{54,2},{
          50,2},{50,40},{54.8,40}},                                                                                   color = {200, 100, 0}));
  connect(twoStar_RadEx.Star, Star) annotation(Line(points = {{73.1, 40}, {90, 40}, {90, 60}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(HeatConv1.port_b, dummyTherm) annotation(Line(points={{54,2},{51.5,2},
          {51.5,-38.5}},                                                                                color = {200, 100, 0}));
  // computing approximated longwave radiation exchange
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent=  {{-80, 60}, {80, -100}}, lineColor=  {0, 0, 0})}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent=  {{-80, 60}, {80, -100}}, lineColor=  {0, 0, 0}), Rectangle(extent=  {{-80, 60}, {80, -100}}, lineColor=  {0, 0, 0}), Rectangle(extent=  {{-80, 60}, {80, -100}}, lineColor=  {0, 0, 0}), Rectangle(extent=  {{24, 100}, {80, -100}}, lineColor=  {0, 0, 0}, fillColor=  {211, 243, 255},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{-56, 100}, {0, -100}}, lineColor=  {166, 166, 166}, pattern=  LinePattern.Solid, fillColor=  {190, 190, 190},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{-64, 100}, {-56, -100}}, lineColor=  {0, 0, 255}, pattern=  LinePattern.Solid, fillColor=  {208, 208, 208},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{-72, 100}, {-64, -100}}, lineColor=  {0, 0, 255}, pattern=  LinePattern.Solid, fillColor=  {190, 190, 190},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{-80, 100}, {-72, -100}}, lineColor=  {0, 0, 255}, pattern=  LinePattern.Solid, fillColor=  {156, 156, 156},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{0, 100}, {8, -100}}, lineColor=  {0, 0, 255}, pattern=  LinePattern.Solid, fillColor=  {208, 208, 208},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{16, 100}, {24, -100}}, lineColor=  {0, 0, 255}, pattern=  LinePattern.Solid, fillColor=  {156, 156, 156},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{8, 100}, {16, -100}}, lineColor=  {0, 0, 255}, pattern=  LinePattern.Solid, fillColor=  {190, 190, 190},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{-80, -30}, {80, -42}}, lineColor=  {0, 0, 0}, pattern=  LinePattern.Dash, fillColor=  {255, 255, 255},
            fillPattern=                                                                                                    FillPattern.Solid), Text(extent=  {{-80, -32}, {80, -39}}, lineColor=  {0, 0, 0}, pattern=  LinePattern.Dash, fillColor=  {215, 215, 215},
            fillPattern=                                                                                                    FillPattern.Solid, textString=  "gap"), Text(extent=  {{-44, -40}, {52, -114}}, lineColor=  {0, 0, 0}, textString=  "n")}), Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>The <b>ConvNLayerClearanceStar</b> model represents a wall, consisting of n different layers with natural convection on one side and (window) clearance.</p>
 <h4><font color=\"#008000\">Level of Development</font></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
 <h4><font color=\"#008000\">Concept</font></h4>
 <p>There is one inner and one outer <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b>-connector to simulate one-dimensional heat transfer through the wall and heat storage within the wall.</p>
 <p>The <b>ConvNLayerClearanceStar</b> model extends the basic concept by adding the functionality of approximated longwave radiation exchange. Simply connect all radiation exchanging surfaces via their <b><a href=\"Modelica://AixLib.Utilities.Interfaces.Star\">Star</a></b>-connectors. </p>
 <p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>HeatPort_a</code>, the last element represents the layer connected to <code>HeatPort_b</code>. </p>
 <h4><font color=\"#008000\">Example Results</font></h4>
 <p>This model is part of <a href=\"AixLib.Building.Components.Walls.Wall\">Wall</a>  therefore also part of the corresponding examples <a href=\"AixLib.Building.Components.Examples.Walls.InsideWall\">InsideWall</a> and <a href=\"AixLib.Building.Components.Examples.Walls.OutsideWall\">OutsideWall</a>. </p>
 </html>", revisions="<html>
 <ul>
 <li><i>March 30, 2015&nbsp;</i> by Ana Constantin:<br/>Renamed to old and kept on as temporary component, for results of ASHRAE 140 validation</li>
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
end ConvNLayerClearanceStar_old;
