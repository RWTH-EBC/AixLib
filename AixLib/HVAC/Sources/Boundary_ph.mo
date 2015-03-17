within AixLib.HVAC.Sources;
model Boundary_ph
  outer BaseParameters baseParameters "System properties";
  parameter Boolean use_p_in = false
    "Get the pressure from the input connector"                                  annotation(Evaluate = true, HideResult = true, choices(__Dymola_checkBox = true));
  parameter Boolean use_h_in = false
    "Get the specific enthalpy from the input connector"                                  annotation(Evaluate = true, HideResult = true, choices(__Dymola_checkBox = true));
  parameter Modelica.SIunits.Pressure p = 1e5 "Fixed value of pressure" annotation(Evaluate = true, Dialog(enable = not use_p_in));
  parameter Modelica.SIunits.SpecificEnthalpy h = 1e5
    "Fixed value of specific enthalpy"                                                   annotation(Evaluate = true, Dialog(enable = not use_h_in));
  Interfaces.Port_a port_a annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
  Modelica.Blocks.Interfaces.RealInput p_in if use_p_in annotation(Placement(transformation(extent = {{-140, 40}, {-100, 80}})));
  Modelica.Blocks.Interfaces.RealInput h_in if use_h_in annotation(Placement(transformation(extent = {{-140, -60}, {-100, -20}})));
protected
  Modelica.Blocks.Interfaces.RealInput p_in_internal
    "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.RealInput h_in_internal
    "Needed to connect to conditional connector";
equation
  connect(p_in, p_in_internal);
  connect(h_in, h_in_internal);
  if not use_p_in then
    p_in_internal = p;
  end if;
  if not use_h_in then
    h_in_internal = h;
  end if;
  port_a.p = p_in_internal;
  port_a.h_outflow = h_in_internal;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(graphics = {Ellipse(extent=  {{-100, 100}, {100, -100}}, lineColor=  {0, 0, 255}, fillColor=  {0, 0, 255}, fillPattern=  FillPattern.Sphere)}), Documentation(revisions = "<html>
 <p>01.10.2013, by <i>Pooyan Jahangiri</i>: implemented</p>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Defines prescribed values for boundary conditions: </p>
 <ul>
 <li>Prescribed boundary pressure.</li>
 <li>Prescribed boundary temperature.</li>
 </ul>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>If <code>use_p_in</code> is false (default option), the <code>p</code> parameter is used as boundary pressure, and the <code>p_in</code> input connector is disabled; if <code>use_p_in</code> is true, then the <code>p</code> parameter is ignored, and the value provided by the input connector is used instead.</p>
 <p>The same thing goes for the specific enthalpy</p>
 <p>Note, that boundary temperature has only an effect if the mass flow is from the boundary into the port. If mass is flowing from the port into the boundary, the boundary definitions, with exception of boundary pressure, do not have an effect. </p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.HeatGeneration.Examples.HeatPumpSystem\">AixLib.HVAC.HeatGeneration.Examples.HeatPumpSystem</a></p>
 </html>"));
end Boundary_ph;
