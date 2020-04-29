within AixLib.Utilities.Sources;
model PrescribedSolarRad "variable radiation condition"
  parameter Integer n=1 "number of output vector length";
  AixLib.Utilities.Interfaces.SolarRad_out solarRad_out[n] annotation (Placement(
        transformation(extent={{80,-10},{100,10}})));
  Modelica.Blocks.Interfaces.RealInput I[n] "radiation on surface (W/m2)"
    annotation (Placement(transformation(extent={{-120,62},{-80,102}}), iconTransformation(extent={{-100,78},{-78,100}})));

  Modelica.Blocks.Interfaces.RealInput I_dir[n] "radiation on surface (W/m2)"
    annotation (Placement(transformation(extent={{-120,30},{-80,70}}), iconTransformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Interfaces.RealInput I_diff[n] "radiation on surface (W/m2)"
    annotation (Placement(transformation(extent={{-120,-4},{-80,36}}), iconTransformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Interfaces.RealInput I_gr[n] "radiation on surface (W/m2)"
    annotation (Placement(transformation(extent={{-120,-38},{-80,2}}), iconTransformation(extent={{-100,-42},{-78,-20}})));
  Modelica.Blocks.Interfaces.RealInput AOI[n] "radiation on surface (W/m2)"
    annotation (Placement(transformation(extent={{-120,-76},{-80,-36}}), iconTransformation(extent={{-100,-80},{-80,-60}})));
equation
  solarRad_out[:].I = I[:] "Radiant energy fluence rate";
  solarRad_out[:].I_dir = I_dir[:] "Radiant energy fluence rate";
  solarRad_out[:].I_diff = I_diff[:] "Radiant energy fluence rate";
  solarRad_out[:].I_gr = I_gr[:] "Radiant energy fluence rate";
  solarRad_out[:].AOI = AOI[:] "Radiant energy fluence rate";

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
