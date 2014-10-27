within AixLib.HVAC.Sources;

model Boundary_p "Pressure boundary, no enthapy, no massflow"
  outer BaseParameters baseParameters "System properties";
  parameter Boolean use_p_in = false "Get the pressure from the input connector" annotation(Evaluate = true, HideResult = true, choices(__Dymola_checkBox = true));
  parameter Modelica.SIunits.Pressure p = 1e5 "Fixed value of pressure" annotation(Evaluate = true, Dialog(enable = not use_p_in));
  Interfaces.Port_a port_a annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
  Modelica.Blocks.Interfaces.RealInput p_in if use_p_in annotation(Placement(transformation(extent = {{-140, 40}, {-100, 80}})));
protected
  Modelica.Blocks.Interfaces.RealInput p_in_internal;
equation
  connect(p_in, p_in_internal);
  if not use_p_in then
    p_in_internal = p;
  end if;
  port_a.p = p_in_internal;
  port_a.h_outflow = 0;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Sphere)}), Documentation(revisions = "<html>
 <p>01.11.2013, by <i>Ana Constantin</i>: implemented</p>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p><br>Boundary of fixed pressure. To be used in a loop before a pump.</p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.Pumps.Examples.PumpHydraulicResistance_closedLoop\">AixLib.HVAC.Pumps.Examples.PumpHydraulicResistance_closedLoop</a></p>
 </html>"));
end Boundary_p;