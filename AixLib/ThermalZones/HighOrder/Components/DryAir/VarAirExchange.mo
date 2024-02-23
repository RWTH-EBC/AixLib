within AixLib.ThermalZones.HighOrder.Components.DryAir;
model VarAirExchange "Heat flow caused by air exchange"
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
  parameter Modelica.Units.SI.Volume V=50 "Volume of the room";
  parameter Modelica.Units.SI.SpecificHeatCapacity c=1000
    "Specific heat capacity of air";
  parameter Modelica.Units.SI.Density rho=1.25 "Air density";
  Modelica.Blocks.Interfaces.RealInput ventRate(unit="1/h")
                                               annotation (Placement(
        transformation(extent={{-100,-54},{-80,-74}})));
protected
  constant Real hToS(unit="s/h")=3600 "conversion factor from hours to seconds";
equation
  port_a.Q_flow =ventRate*V*c*rho*(port_a.T - port_b.T)/hToS;
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={  Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}, fillColor = {211, 243, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{60, -58}, {30, -72}, {-22, -68}, {-16, -60}, {-68, -52}, {-30, -80}, {-24, -74}, {46, -74}, {60, -58}}, lineColor = {0, 0, 0}, smooth = Smooth.Bezier, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-30, 16}, {30, -50}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Air"), Polygon(points = {{-58, 22}, {-28, 36}, {24, 32}, {18, 24}, {70, 16}, {32, 44}, {26, 38}, {-44, 38}, {-58, 22}}, lineColor = {0, 0, 0}, smooth = Smooth.Bezier, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid)}), Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The <b>VarAirExchange</b> model describes heat transfer by air
  exchange (e.g. due to opening a window). It needs the air exchange
  rate (in <img src=
  \"modelica://AixLib/Resources/Images/Building/Components/DryAir/VarAirExchange/equation-fHlz87wz.png\"
  alt=\"h^(-1)\">) as input value.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  <a href=
  \"AixLib.ThermalZones.HighOrder.Components.Examples.DryAir.DryAir_test\">
  AixLib.ThermalZones.HighOrder.Components.Examples.DryAir.DryAir_test</a>
</p>
<ul>
  <li>
    <i>Mai 19, 2014&#160;</i> by Ana Constantin:<br/>
    Uses components from MSL and respects the naming conventions
  </li>
  <li>
    <i>May 02, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
</ul>
</html>"), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2})));
end VarAirExchange;
