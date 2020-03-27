within AixLib.Utilities.HeatTransfer;
model HeatToLongRad
  "Adaptor for approximative longwave radiation exchange with variable surface area and selectable calculation method"
  parameter Modelica.SIunits.Emissivity eps = 0.95 "Emissivity";
  parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(16) "Initial temperature";
  parameter Boolean use_A_in = false
    "Get the area from the input connector"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Modelica.SIunits.Area A=-1 "Fixed value of prescribed area"
                                   annotation (Dialog(enable=not use_A_in));
  parameter Integer radCalcMethod=1 "Calculation method for radiation heat transfer" annotation (
    Evaluate=true,
    Dialog(group = "Radiation exchange equation", compact=true),
    choices(
      choice=1 "No approx",
      choice=2 "Linear approx wall temp",
      choice=3 "Linear approx rad temp",
      choice=4 "Linear approx T0",
      radioButtons=true));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-102,-10},{-82,10}})));
  Modelica.Blocks.Interfaces.RealInput A_in(final unit="m2") if use_A_in
    "Area of radiation exchange connector" annotation (Placement(transformation(
        origin={0,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  AixLib.Utilities.Interfaces.RadPort radPort
    annotation (Placement(transformation(extent={{81,-10},{101,10}})));
protected
  Modelica.Blocks.Interfaces.RealInput A_in_internal(final unit="m2")
    "Needed to connect to conditional connector";
initial equation
  if not use_A_in then
    assert(A > 0, "The area for heattransfer must be positive");
  end if;
equation
  port_a.Q_flow + radPort.Q_flow = 0;
  // To prevent negative solutions for T, the max() expression is used.
  // Negative solutions also occur when using max(T,0), therefore, 1 K is used.
  if radCalcMethod == 1 then
    port_a.Q_flow = Modelica.Constants.sigma*eps*A_in_internal*(max(port_a.T, 1)*max(port_a.T, 1)*max(port_a.T, 1)*max(port_a.T, 1) - max(radPort.T, 1)*max(radPort.T, 1)*max(radPort.T, 1)*max(radPort.T, 1));
  elseif radCalcMethod == 2 then
    port_a.Q_flow = Modelica.Constants.sigma*eps*A_in_internal*4*port_a.T*port_a.T*port_a.T*(port_a.T - radPort.T);
  elseif radCalcMethod == 3 then
    port_a.Q_flow = Modelica.Constants.sigma*eps*A_in_internal*4*radPort.T*radPort.T*radPort.T*(port_a.T - radPort.T);
  else
    port_a.Q_flow = Modelica.Constants.sigma*eps*A_in_internal*4*T0*T0*T0*(port_a.T - radPort.T);
  end if;

  if not use_A_in then
    A_in_internal =A;
  end if;
  connect(A_in, A_in_internal);
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {135, 150, 177},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 0},  pattern = LinePattern.None, fillColor = {135, 150, 177},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "2*")}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {135, 150, 177},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 0},  pattern = LinePattern.None, fillColor = {135, 150, 177},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "2*")}), Documentation(info="<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>The <b>TwoStar_RadEx</b> model cobines the <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b> and the <b><a href=\"AixLib.Utilities.Interfaces.RadPort\">Star</a></b> connector. To model longwave radiation exchange of surfaces, just connect the <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b> connector to the outmost layer of the surface and connect the <b><a href=\"AixLib.Utilities.Interfaces.RadPort\">Star</a></b> connector to the <b><a href=\"AixLib.Utilities.Interfaces.RadPort\">Star</a></b> connectors of an unlimited number of corresponding surfaces. </p>
 <h4><font color=\"#008000\">Concept</font></h4>
 <p>Since exact calculation of longwave radiation exchange inside a room demands for the computation of view factors, it may be very complex to achieve for non-rectangular room layouts. Therefore, an approximated calculation of radiation exchange basing on the proportions of the affected surfaces is an alternative. The underlying concept of this approach is known as the &quot;two star&quot; room model. </p>
 </html>", revisions="<html>
 <ul>
 <li><i>November 5, 2019&nbsp;</i> by David Jansen:<br/>Make area a conditional paramter <a href=\"https://github.com/RWTH-EBC/AixLib/issues/689\">#issue689</a></li>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>April 01, 2014 </i> by Moritz Lauster:<br/>Moved and Renamed</li>
 <li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately </li>
 <li><i>June 21, 2007&nbsp;</i> by Peter Mattes:<br/>Extended model based on TwoStar_RadEx.</li>
 </ul>
 </html>"));
end HeatToLongRad;
