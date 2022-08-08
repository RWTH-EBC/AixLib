within AixLib.Utilities.HeatTransfer;
model HeatToRad "Adaptor for approximative longwave radiation exchange with variable surface Area"
  parameter Modelica.Units.SI.Emissivity eps=0.95 "Emissivity";
  parameter Modelica.Units.SI.Temperature T_ref=
      Modelica.Units.Conversions.from_degC(16)
    "Reference temperature for optional linearization"
    annotation (Dialog(enable=radCalcMethod == 4));
  parameter Boolean use_A_in = false
    "Get the area from the input connector"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Modelica.Units.SI.Area A=-1 "Fixed value of prescribed area"
    annotation (Dialog(enable=not use_A_in));
  parameter Integer radCalcMethod=1 "Calculation method for radiation heat transfer" annotation (
    Evaluate=true,
    Dialog(group = "Radiation exchange equation", compact=true),
    choices(
      choice=1 "No approx",
      choice=2 "Linear approx at wall temp",
      choice=3 "Linear approx at rad temp",
      choice=4 "Linear approx at constant T_ref",
      radioButtons=true));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a convPort
    "Heat port for convective or conductive heat flow"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealInput A_in(final unit="m2") if use_A_in
    "Area of radiation exchange connector" annotation (Placement(transformation(
        origin={0,110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  AixLib.Utilities.Interfaces.RadPort radPort
    "Heat port for longwave radiative heat flow"
    annotation (Placement(transformation(extent={{91,-10},{111,10}}), iconTransformation(extent={{91,-10},{111,10}})));
protected
  Modelica.Blocks.Interfaces.RealInput A_in_internal(final unit="m2")
    "Needed to connect to conditional connector";
initial equation
  if not use_A_in then
    assert(A > 0, "The area for heattransfer must be positive");
  end if;
equation
 convPort.Q_flow + radPort.Q_flow = 0;
  // To prevent negative solutions for T, the max() expression is used.
  // Negative solutions also occur when using max(T,0), therefore, 1 K is used.
  if radCalcMethod == 1 then
    convPort.Q_flow = Modelica.Constants.sigma*eps*A_in_internal*(max(convPort.T, 1)*max(convPort.T, 1)*max(convPort.T, 1)*max(convPort.T, 1) - max(radPort.T, 1)*max(radPort.T, 1)*max(radPort.T, 1)*max(radPort.T, 1));
  elseif radCalcMethod == 2 then
    convPort.Q_flow = Modelica.Constants.sigma*eps*A_in_internal*4*convPort.T*convPort.T*convPort.T*(convPort.T - radPort.T);
  elseif radCalcMethod == 3 then
    convPort.Q_flow = Modelica.Constants.sigma*eps*A_in_internal*4*radPort.T*radPort.T*radPort.T*(convPort.T - radPort.T);
  else
    convPort.Q_flow =Modelica.Constants.sigma*eps*A_in_internal*4*T_ref*T_ref*T_ref*(convPort.T - radPort.T);
  end if;
  if not use_A_in then
    A_in_internal =A;
  end if;


  connect(A_in, A_in_internal);
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),                                                            Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent={{-100,100},{100,-100}},  lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {135, 150, 177},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{-78,80},{82,-80}},      lineColor = {0, 0, 0},  pattern = LinePattern.None, fillColor = {135, 150, 177},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "2*")}), Documentation(info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  The model cobines the <b><a href=
  \"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b>
  and the <b><a href=
  \"AixLib.Utilities.Interfaces.RadPort\">RadPort</a></b> connector. To
  model longwave radiation exchange of surfaces, just connect the
  <b><a href=
  \"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b>
  connector to the heat port of a surface and connect the <b><a href=
  \"AixLib.Utilities.Interfaces.RadPort\">RadPort</a></b> connector to
  the <b><a href=\"AixLib.Utilities.Interfaces.RadPort\">RadPort</a></b>
  connectors of an unlimited number of corresponding surfaces.
</p>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
  Since exact calculation of longwave radiation exchange inside a room
  demands for the computation of view factors, it may be very complex
  to achieve for non-rectangular room layouts. Therefore, an
  approximated calculation of radiation exchange basing on the
  proportions of the affected surfaces is an alternative. The
  underlying concept of this approach is known as the \"two star\" room
  model.
</p>
<p>
  <b><span style=\"color: #008000;\">Limitations / Assumptions</span></b>
</p>
<p>
  According to [1]:
</p>
<ul>
  <li>Index 1 is the component at port <span style=
  \"font-family: Courier;\">conv</span>
  </li>
  <li>Heat flow exchange between two grey bodies
  </li>
  <li>Body 2 encloses body 1 (A<sub>2</sub> &gt; A<sub>1</sub>)
  </li>
  <li>Body 1 is convex (view factor Φ<sub>11</sub> = 0)
  </li>
</ul>
<p>
  <span style=\"font-size: 16pt;\">Q̇<sub>1⇌2</sub> = A<sub>1</sub> ⋅ σ ⋅
  ( T<sub>1</sub><sup>4</sup> - T<sub>2</sub><sup>4</sup>) / (
  1/ε<sub>1</sub> + A<sub>1</sub> / A<sub>2</sub> ⋅ ( 1/ε<sub>2</sub> -
  1 ) )</span>
</p>
<ul>
  <li>The closer ε is to 1, the smaller is the loss of information due
  to the simplification that only one surface area and no view factors
  are known.
  </li>
  <li>The greater A<sub>2</sub> compared to A<sub>1</sub> the smaller
  the simplification.
  </li>
</ul>
<p>
  <b><span style=\"color: #008000;\">References</span></b>
</p>
<p>
  [1] Reinhold Kneer. Formelsammlung Wärme- Und Stoffübertragung WSÜ.
  RWTH Aachen University, Institut für Wärme- und Stoffübertragung
  (WSA) September 15, 2014.
</p>
<ul>
  <li>
    <i>March 30, 2020</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/886\">#886</a>:
    Add equation, limitations and assumptions to documentation
  </li>
  <li>
    <i>November 5, 2019&#160;</i> by David Jansen:<br/>
    Make area a conditional paramter <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/689\">#issue689</a>
  </li>
  <li>
    <i>February 16, 2018&#160;</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/535\">#535</a>:
    Add max functions to prevent negative solutions.
  </li>
  <li>
    <i>Mai 19, 2014&#160;</i> by Ana Constantin:<br/>
    Uses components from MSL and respects the naming conventions
  </li>
  <li>
    <i>April 01, 2014</i> by Moritz Lauster:<br/>
    Moved and Renamed
  </li>
  <li>
    <i>April 10, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>June 21, 2007&#160;</i> by Peter Mattes:<br/>
    Extended model based on TwoStar_RadEx.
  </li>
</ul>
</html>"));
end HeatToRad;
