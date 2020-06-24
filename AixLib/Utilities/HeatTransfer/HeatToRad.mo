within AixLib.Utilities.HeatTransfer;
model HeatToRad "Adaptor for approximative longwave radiation exchange with variable surface Area"
  parameter Modelica.SIunits.Emissivity eps = 0.95 "Emissivity";
  parameter Boolean use_A_in = false
    "Get the area from the input connector"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Modelica.SIunits.Area A=-1 "Fixed value of prescribed area"
                                   annotation (Dialog(enable=not use_A_in));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a conv "Heat port for convective or conductive heat flow" annotation (Placement(transformation(extent={{-102,-10},{-82,10}})));
  Modelica.Blocks.Interfaces.RealInput A_in(final unit="m2") if use_A_in
    "Area of radiation exchange connector" annotation (Placement(transformation(
        origin={0,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  AixLib.Utilities.Interfaces.RadPort rad "Heat port for longwave radiative heat flow" annotation (Placement(transformation(extent={{81,-10},{101,10}})));
protected
  Modelica.Blocks.Interfaces.RealInput A_in_internal(final unit="m2")
    "Needed to connect to conditional connector";
initial equation
  if not use_A_in then
    assert(A > 0, "The area for heattransfer must be positive");
  end if;
equation
  conv.Q_flow + rad.Q_flow = 0;
  // To prevent negative solutions for T, the max() expression is used.
  // Negative solutions also occur when using max(T,0), therefore, 1 K is used.
  conv.Q_flow = Modelica.Constants.sigma*eps*A_in_internal*(max(conv.T, 1)*max(conv.T, 1)*max(conv.T, 1)*max(conv.T, 1) - max(rad.T, 1)*max(rad.T, 1)*max(rad.T, 1)*max(rad.T, 1));
  if not use_A_in then
    A_in_internal =A;
  end if;
  connect(A_in, A_in_internal);
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {135, 150, 177},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 0},  pattern = LinePattern.None, fillColor = {135, 150, 177},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "2*")}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {135, 150, 177},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 0},  pattern = LinePattern.None, fillColor = {135, 150, 177},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "2*")}), Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>The model cobines the <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b> and the <b><a href=\"AixLib.Utilities.Interfaces.RadPort\">RadPort</a></b> connector. To model longwave radiation exchange of surfaces, just connect the <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b> connector to the heat port of a surface and connect the <b><a href=\"AixLib.Utilities.Interfaces.RadPort\">RadPort</a></b> connector to the <b><a href=\"AixLib.Utilities.Interfaces.RadPort\">RadPort</a></b> connectors of an unlimited number of corresponding surfaces. </p>
<p><b><span style=\"color: #008000;\">Concept</span></b> </p>
<p>Since exact calculation of longwave radiation exchange inside a room demands for the computation of view factors, it may be very complex to achieve for non-rectangular room layouts. Therefore, an approximated calculation of radiation exchange basing on the proportions of the affected surfaces is an alternative. The underlying concept of this approach is known as the &quot;two star&quot; room model. </p>
<p><b><span style=\"color: #008000;\">Limitations / Assumptions</span></b> </p>
<p>According to [1]:</p>
<ul>
<li>Index 1 is the component at port <span style=\"font-family: Courier;\">conv</span></li>
<li>Heat flow exchange between two grey bodies</li>
<li>Body 2 encloses body 1 (A<sub>2</sub> > A<sub>1</sub>)</li>
<li>Body 1 is convex (view factor &#934;<sub>11</sub> = 0)</li>
</ul>
<p><span style=\"font-size: 16pt;\">Q&#775;<sub>1&#8652;2</sub> = A<sub>1</sub> &sdot; &sigma; &sdot; ( T<sub>1</sub><sup>4</sup> - T<sub>2</sub><sup>4</sup>) / ( 1/&epsilon;<sub>1</sub> + A<sub>1</sub> / A<sub>2</sub> &sdot; ( 1/&epsilon;<sub>2</sub> - 1 ) )</span> </p>
<ul>
<li>The closer &epsilon; is to 1, the smaller is the loss of information due to the simplification that only one surface area and no view factors are known.</li>
<li>The greater A<sub>2</sub> compared to A<sub>1</sub> the smaller the simplification.</li>
</ul>
<p><b><span style=\"color: #008000;\">References</span></b> </p>
<p>[1] Reinhold Kneer. Formelsammlung W&auml;rme- Und Stoff&uuml;bertragung WS&Uuml;. RWTH Aachen University, Institut f&uuml;r W&auml;rme- und Stoff&uuml;bertragung (WSA) September 15, 2014. </p>
</html>",  revisions="<html>
 <ul>
  <li><i>March 30, 2020</i> by Philipp Mehrfeld:<br/><a href=\"https://github.com/RWTH-EBC/AixLib/issues/886\">#886</a>: Add equation, limitations and assumptions to documentation</li>
  <li><i>November 5, 2019&nbsp;</i> by David Jansen:<br/>Make area a conditional paramter <a href=\"https://github.com/RWTH-EBC/AixLib/issues/689\">#issue689</a></li>
  <li><i>February 16, 2018&nbsp;</i> by Philipp Mehrfeld:<br/><a href=\"https://github.com/RWTH-EBC/AixLib/issues/535\">#535</a>: Add max functions to prevent negative solutions.</li>
  <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
  <li><i>April 01, 2014 </i> by Moritz Lauster:<br/>Moved and Renamed</li>
  <li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately </li>
  <li><i>June 21, 2007&nbsp;</i> by Peter Mattes:<br/>Extended model based on TwoStar_RadEx.</li>
 </ul>
</html>"));
end HeatToRad;
