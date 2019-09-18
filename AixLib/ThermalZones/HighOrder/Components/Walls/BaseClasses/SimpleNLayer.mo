within AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses;
model SimpleNLayer "Wall consisting of n layers"
  parameter Modelica.SIunits.Area A = 12 "Area" annotation(Dialog(group = "Geometry"));
  parameter Integer n(min = 1) = 8 "Number of layers" annotation(Dialog(group = "Structure of wall layers"));
  parameter Modelica.SIunits.Thickness d[n] = fill(0.1, n) "Thickness" annotation(Dialog(group = "Structure of wall layers"));
  parameter Modelica.SIunits.Density rho[n] = fill(1600, n) "Density" annotation(Dialog(group = "Structure of wall layers"));
  parameter Modelica.SIunits.ThermalConductivity lambda[n] = fill(2.4, n)
    "Thermal conductivity"                                                                       annotation(Dialog(group = "Structure of wall layers"));
  parameter Modelica.SIunits.SpecificHeatCapacity c[n] = fill(1000, n)
    "Specific heat capacity"                                                                    annotation(Dialog(group = "Structure of wall layers"));
  parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(16)
    "Initial temperature"                                                                                      annotation(Dialog(group = "Thermal"));
  // 2n HeatConds
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatCondb[n](G = A .* lambda ./ (d / 2)) annotation(Placement(transformation(extent={{30,-10},
            {50,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatConda[n](G = A .* lambda ./ (d / 2)) annotation(Placement(transformation(extent={{-52,-10},
            {-32,10}})));
  // n Loads
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Load[n](T(start = fill(T0, n)), C = c .* rho .* A .* d) annotation(Placement(transformation(extent={{-10,-42},
            {10,-22}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation(Placement(transformation(extent={{-110,
            -10},{-90,10}}),                                                                                                        iconTransformation(extent={{-110,
            -10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(transformation(extent={{90,-10},
            {110,10}}),                                                                                                           iconTransformation(extent={{90,-10},
            {110,10}})));
equation
  // connecting inner elements HeatCondb[i]--Load[i]--HeatConda[i] to n groups
  for i in 1:n loop
    connect(HeatConda[i].port_b, Load[i].port) annotation (Line(
      points={{-32,0},{-18,0},{-18,-42},{0,-42}},
      color={191,0,0},
      pattern=LinePattern.DashDotDot));
    connect(Load[i].port, HeatCondb[i].port_a) annotation (Line(
      points={{0,-42},{18,-42},{18,0},{30,0}},
      color={191,0,0},
      pattern=LinePattern.DashDotDot));
  end for;
  // establishing n-1 connections of HeatCondb--Load--HeatConda groups
  for i in 1:n - 1 loop
    connect(HeatCondb[i].port_b, HeatConda[i + 1].port_a) annotation (Line(
      points={{50,0},{58,0},{58,24},{-58,24},{-58,0},{-52,0}},
      color={191,0,0},
      pattern=LinePattern.DashDotDot));
  end for;
  // connecting outmost elements to connectors: port_a--HeatCondb[1]...HeatConda[n]--port_b
  connect(HeatConda[1].port_a, port_a) annotation (Line(
      points={{-52,0},{-100,0}},
      color={191,0,0},
      pattern=LinePattern.DashDotDot));
  connect(HeatCondb[n].port_b, port_b)
                                      annotation (Line(
      points={{50,0},{100,0}},
      color={191,0,0},
      pattern=LinePattern.DashDotDot));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),                                                                                  Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{-32, 60}, {32, -100}}, lineColor = {166, 166, 166}, pattern = LinePattern.None, fillColor = {190, 190, 190},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {135, 135, 135}), Rectangle(extent = {{-48, 60}, {-32, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {208, 208, 208},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-64, 60}, {-48, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {190, 190, 190},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-80, 60}, {-64, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {156, 156, 156},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{64, 60}, {80, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {156, 156, 156},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{32, 60}, {48, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {208, 208, 208},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{48, 60}, {64, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {190, 190, 190},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{10, -36}, {106, -110}}, lineColor = {0, 0, 0}, textString = "n")}), Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>The <b>SimpleNLayer</b> model represents a simple wall, consisting of n different layers. </p>
 <h4><font color=\"#008000\">Concept</font></h4>
 <p>There is one inner and one outer <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b>-connector to simulate one-dimensional heat transfer through the wall and heat storage within the wall.</p>
 <p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>HeatPort_a</code>, the last element represents the layer connected to <code>HeatPort_b</code>. </p>
 </html>
 ", revisions = "<html>
 <ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
   <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
   <li><i>March 14, 2005&nbsp;</i>
          by Timo Haase:<br/>
          Implemented.</li>
 </ul>
 </html>"));
end SimpleNLayer;
