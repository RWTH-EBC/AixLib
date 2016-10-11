within AixLib.Building.Components.Walls.BaseClasses;
model SimpleNLayer "Wall consisting of n layers"
  parameter Modelica.SIunits.Height h = 3 "Height" annotation(Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Length l = 4 "Length" annotation(Dialog(group = "Geometry"));
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
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatCondb[n](G = h .* l .* lambda ./ (d / 2)) annotation(Placement(transformation(extent = {{30, -28}, {50, -8}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatConda[n](G = h .* l .* lambda ./ (d / 2)) annotation(Placement(transformation(extent = {{-52, -28}, {-32, -8}})));
  // n Loads
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Load[n](T(start = fill(T0, n)), C = c .* rho .* h .* l .* d) annotation(Placement(transformation(extent = {{-10, -60}, {10, -40}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation(Placement(transformation(extent = {{-100, -20}, {-80, 0}}), iconTransformation(extent = {{-100, -20}, {-80, 0}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(transformation(extent = {{80, -20}, {100, 0}}), iconTransformation(extent = {{80, -20}, {100, 0}})));
equation
  // connecting inner elements HeatCondb[i]--Load[i]--HeatConda[i] to n groups
  for i in 1:n loop
    connect(HeatConda[i].port_b, Load[i].port);
    connect(Load[i].port, HeatCondb[i].port_a);
  end for;
  // establishing n-1 connections of HeatCondb--Load--HeatConda groups
  for i in 1:n - 1 loop
    connect(HeatCondb[i].port_b, HeatConda[i + 1].port_a);
  end for;
  // connecting outmost elements to connectors: port_a--HeatCondb[1]...HeatConda[n]--port_b
  connect(HeatConda[1].port_a, port_a);
  connect(HeatCondb[n].port_b, port_b);
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent=  {{-80, 60}, {80, -100}}, lineColor=  {0, 0, 0})}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent=  {{-80, 60}, {80, -100}}, lineColor=  {0, 0, 0}), Rectangle(extent=  {{-32, 60}, {32, -100}}, lineColor=  {166, 166, 166}, pattern=  LinePattern.None, fillColor=  {190, 190, 190},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{-80, 60}, {80, -100}}, lineColor=  {135, 135, 135}), Rectangle(extent=  {{-48, 60}, {-32, -100}}, lineColor=  {0, 0, 255}, pattern=  LinePattern.None, fillColor=  {208, 208, 208},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{-64, 60}, {-48, -100}}, lineColor=  {0, 0, 255}, pattern=  LinePattern.None, fillColor=  {190, 190, 190},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{-80, 60}, {-64, -100}}, lineColor=  {0, 0, 255}, pattern=  LinePattern.None, fillColor=  {156, 156, 156},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{64, 60}, {80, -100}}, lineColor=  {0, 0, 255}, pattern=  LinePattern.None, fillColor=  {156, 156, 156},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{32, 60}, {48, -100}}, lineColor=  {0, 0, 255}, pattern=  LinePattern.None, fillColor=  {208, 208, 208},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{48, 60}, {64, -100}}, lineColor=  {0, 0, 255}, pattern=  LinePattern.None, fillColor=  {190, 190, 190},
            fillPattern=                                                                                                    FillPattern.Solid), Text(extent=  {{10, -36}, {106, -110}}, lineColor=  {0, 0, 0}, textString=  "n")}), Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>The <b>SimpleNLayer</b> model represents a simple wall, consisting of n different layers. </p>
 <h4><font color=\"#008000\">Level of Development</font></h4>
 <p><img src=\"modelica://AixLib/Resources/Images/Stars/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
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
