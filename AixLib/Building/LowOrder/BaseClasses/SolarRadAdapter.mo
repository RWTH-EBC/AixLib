within AixLib.Building.LowOrder.BaseClasses;
model SolarRadAdapter "scalar radiant input * factor x"
  parameter Real x = 1;
  Utilities.Interfaces.SolarRad_in solarRad_in annotation(Placement(transformation(extent = {{-100, -10}, {-80, 10}})));
  Modelica.Blocks.Interfaces.RealOutput
                                    solarRad_out annotation(Placement(transformation(extent={{90,-10},
            {110,10}})));
  //Real dummy[4];
equation
  solarRad_out = solarRad_in.I * x;

  //Nothing happens to other components

//   dummy[1] = sum(solarRad_in.I_dir);
//   dummy[2] = sum(solarRad_in.I_diff);
//   dummy[3] = sum(solarRad_in.I_gr);
//   dummy[4] = sum(solarRad_in.AOI);

  annotation(Documentation(info="<html>
<p>This component multiplies the scalar radiance input with a factor x </p>
<p>The partial class contains following components:</p>
<ul>
<li>2 solar radiation ports</li>
</ul>
<h4>Typical use and important parameters</h4>
<p>This component can be used to in- or decrease a scalar radiance, e.g. if you would like to split the radiance, use two blocks, one with x, one with 1-x. </p>
</html>",  revisions = "<html>
 <ul>
 <li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
 </ul>
 </html>"), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 40}, {80, -40}}, lineColor = {215, 215, 215}, fillColor = {239, 239, 159},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-80, 20}, {-40, -20}}, lineColor = {0, 0, 0}, textString = "I", fontName = "Times New Roman"), Text(extent = {{-60, 12}, {-20, -28}}, lineColor = {0, 0, 0}, fontName = "Times New Roman", textString = "in"), Text(extent = {{-50, 20}, {62, -20}}, lineColor = {0, 0, 0}, fontName = "Times New Roman", textString = " * fac"), Line(points = {{54, 0}, {72, 0}, {62, 6}}, color = {0, 0, 255}), Line(points = {{72, 0}, {62, -6}}, color = {0, 0, 255})}));
end SolarRadAdapter;
