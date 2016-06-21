within AixLib.HVAC.Sources;


model MassflowsourceMoistAir_mhX
  "boundary for Moist Air, massflow, enthalpy, water fraction"
  outer BaseParameters baseParameters "System properties";
  parameter Boolean use_m_in = false
    "Get the massflow of dry air from the input connector"                                  annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
  parameter Boolean use_h_in = false
    "Get the specific enthalpy per mass dry air from the input connector"                                  annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
  parameter Boolean use_X_in = false
    "Get the water mass fraction per mass dry air from the input connector"                                  annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
  parameter Modelica.SIunits.MassFlowRate m = 0.01
    "Fixed value of mass flow of dry air "                                                annotation(Evaluate = true, Dialog(enable = not use_p_in));
  parameter Modelica.SIunits.SpecificEnthalpy h = 1e4
    "Fixed value of specific enthalpy per mass dry air"                                                   annotation(Evaluate = true, Dialog(enable = not use_h_in));
  parameter Real X(min = 0, max = 1) = 2e-3
    "Fixed value of water mass fraction per mass dry air "                                         annotation(Evaluate = true, Dialog(enable = not use_X_in));
  Interfaces.PortMoistAir_a portMoistAir_a annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
  Modelica.Blocks.Interfaces.RealInput m_in if use_m_in annotation(Placement(transformation(extent = {{-140, 60}, {-100, 100}})));
  Modelica.Blocks.Interfaces.RealInput h_in if use_h_in annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
  Modelica.Blocks.Interfaces.RealInput X_in if use_X_in annotation(Placement(transformation(extent = {{-140, -100}, {-100, -60}})));
protected
  Modelica.Blocks.Interfaces.RealInput m_in_internal
    "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.RealInput h_in_internal
    "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.RealInput X_in_internal
    "Needed to connect to conditional connector";
equation
  connect(m_in, m_in_internal);
  connect(h_in, h_in_internal);
  connect(X_in, X_in_internal);
  if not use_m_in then
    m_in_internal = m;
  end if;
  if not use_h_in then
    h_in_internal = h;
  end if;
  if not use_X_in then
    X_in_internal = X;
  end if;
  portMoistAir_a.m_flow = -m_in_internal;
  portMoistAir_a.h_outflow = h_in_internal;
  portMoistAir_a.X_outflow = X_in_internal;
  annotation (Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Ellipse(extent=  {{-100, 100}, {100, -100}}, lineColor=  {170, 255, 255},
            fillPattern=                                                                                                    FillPattern.Sphere, fillColor=  {170, 213, 255}), Text(extent=  {{-68, 12}, {74, -12}}, lineColor=  {0, 0, 255}, textString=  "m_flow boundary")}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Boundary Model for Moist Air. Defines mass flow of dry air, specific enthalpy per mass dry air and water fraction per mass dry air.</p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.Volume.Examples.MoistAirWithHeatTransfer\">AixLib.HVAC.Volume.Examples.MoistAirWithHeatTransfer</a></p>
 </html>", revisions = "<html>
 <p>10.12.2013, Mark Wesseling</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"));
end MassflowsourceMoistAir_mhX;
