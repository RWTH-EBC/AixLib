within AixLib.Utilities.Sources;
model PrescribedSolarRad "Prescribed solar radiation conditions"
  parameter Integer n=1 "number of output vector length";
  AixLib.Utilities.Interfaces.SolarRad_out solRadOut[n]
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Modelica.Blocks.Interfaces.RealInput H[n](unit="W/m2")
    "Total radiation (W/m2)"
    annotation (Placement(transformation(extent={{-120,60},{-80,100}})));
  Modelica.Blocks.Interfaces.RealInput HDir[n](unit="W/m2")
    "Direct radiation (W/m2)"
    annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
  Modelica.Blocks.Interfaces.RealInput HDif[n](unit="W/m2")
    "Diffuse radiation(W/m2)"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealInput HGrd[n](unit="W/m2")
    "Ground reflected radiation (W/m2)"
    annotation (Placement(transformation(extent={{-120,-60},{-80,-20}})));
  Modelica.Blocks.Interfaces.RealInput incAng[n](unit="rad")
    "Incidence angle"
    annotation (Placement(transformation(extent={{-120,-100},{-80,-60}})));
equation
  solRadOut[:].H = H[:];
  solRadOut[:].HDir = HDir[:];
  solRadOut[:].HDif = HDif[:];
  solRadOut[:].HGrd = HGrd[:];
  solRadOut[:].incAng = incAng[:];
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),graphics={
       Line(
         points={{0,80},{0,-80}},
         color={255,170,85},
         pattern=LinePattern.Dot,
         thickness=0.5),
       Line(
         points={{80,0},{-80,0}},
         color={255,170,85},
         pattern=LinePattern.Dot,
         thickness=0.5),
       Line(
         points={{-68,42},{68,-42}},
         color={255,170,85},
         pattern=LinePattern.Dot,
         thickness=0.5),
       Line(
         points={{-38,70},{38,-70}},
         color={255,170,85},
         pattern=LinePattern.Dot,
         thickness=0.5),
       Line(
         points={{-68,-42},{68,42}},
         color={255,170,85},
         pattern=LinePattern.Dot,
         thickness=0.5),
       Line(
         points={{-40,-70},{40,70}},
         color={255,170,85},
         pattern=LinePattern.Dot,
         thickness=0.5),
       Ellipse(
         extent={{-60,60},{60,-60}},
         lineColor={0,0,0},
         pattern = LinePattern.None,
         fillPattern=FillPattern.Sphere,
         fillColor={255,255,0})}),     Documentation(revisions="<html><ul>
  <li>
    March 13, 2025, by Jun Jiang:<br/>
    Change variable names (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1525\">issue 1525</a>)
  </li>
  <li>
    <i>February 22, 2015&#160;</i> by Ana Constantin:<br/>
    Added the components of the total radiation
  </li>
  <li>
    <i>December 4, 2014&#160;</i> by Ana Constantin:<br/>
    removed cardinality equation
  </li>
  <li>
    <i>April 01, 2014</i> by Moritz Lauster:<br/>
    Renamed
  </li>
  <li>
    <i>April 11, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>October 23, 2006&#160;</i> by Peter Matthes:<br/>
    Implemented.
  </li>
</ul>
</html>",
    info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The <b>PrescribedSolarRad</b> Model is a source model to represent a
  varying radiation source.
</p>
<h4>
  <span style=\"color:#008000\">Assumption</span>
</h4>
<p>
  If nothing is specified through the input port solar radiation of 0
  W/m2 is assumed by default.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
</html>"));
end PrescribedSolarRad;
