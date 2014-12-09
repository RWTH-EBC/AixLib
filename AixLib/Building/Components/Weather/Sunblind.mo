within AixLib.Building.Components.Weather;
model Sunblind "Reduces beam at Imax"
  parameter Integer n = 4 "Number of orientations";
  parameter Modelica.SIunits.TransmissionCoefficient gsunblind[n] = {1, 1, 1, 1}
    "Total energy transmittances if sunblind is closed";
  parameter Modelica.SIunits.RadiantEnergyFluenceRate Imax = 100
    "Intensity at which the sunblind closes";
  Utilities.Interfaces.SolarRad_in Rad_In[n] annotation(Placement(transformation(extent = {{-100, 0}, {-80, 20}})));
  Utilities.Interfaces.SolarRad_out Rad_Out[n] annotation(Placement(transformation(extent = {{80, 0}, {100, 20}})));
  Modelica.Blocks.Interfaces.RealOutput sunblindonoff[n] annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {8, -100}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {0, -90})));
  /*if OutputSunblind*/
initial equation
  assert(n == size(gsunblind, 1), "gsunblind has to have n elements");
equation
  for i in 1:n loop
    if Rad_In[i].I > Imax then
      Rad_Out[i].I = Rad_In[i].I * gsunblind[i];
      sunblindonoff[i] = 1 - gsunblind[i];
    else
      Rad_Out[i].I = Rad_In[i].I;
      sunblindonoff[i] = 0;
    end if;
  end for;
  annotation(Diagram(graphics), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}),
                                     graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor=
              {0,0,0},                                                                                             fillColor=
              {170,213,255},
            fillPattern=FillPattern.HorizontalCylinder),                                                                                                    Rectangle(extent = {{-80, 80}, {80, 66}}, lineColor = {0, 0, 0}, fillColor = {135, 135, 135},
            fillPattern =                                                                                                    FillPattern.HorizontalCylinder), Ellipse(extent = {{-36, 44}, {36, -22}}, lineColor=
              {255,221,0},                                                                                                    fillColor=
              {255,221,0},
            fillPattern=FillPattern.Solid),                                                                                                    Rectangle(extent = {{-80, 16}, {80, 2}}, lineColor = {0, 0, 0}, fillColor = {135, 135, 135},
            fillPattern =                                                                                                    FillPattern.HorizontalCylinder), Rectangle(extent = {{-80, 32}, {80, 18}}, lineColor = {0, 0, 0}, fillColor = {135, 135, 135},
            fillPattern =                                                                                                    FillPattern.HorizontalCylinder), Rectangle(extent = {{-80, 48}, {80, 34}}, lineColor = {0, 0, 0}, fillColor = {135, 135, 135},
            fillPattern =                                                                                                    FillPattern.HorizontalCylinder), Rectangle(extent = {{-80, 64}, {80, 50}}, lineColor = {0, 0, 0}, fillColor = {135, 135, 135},
            fillPattern =                                                                                                    FillPattern.HorizontalCylinder), Rectangle(extent = {{-80, 80}, {-76, 2}}, lineColor = {0, 0, 0},
            fillPattern =                                                                                                    FillPattern.Solid, fillColor = {0, 0, 0}), Rectangle(extent = {{76, 80}, {80, 2}}, lineColor = {0, 0, 0},
            fillPattern =                                                                                                    FillPattern.Solid, fillColor = {0, 0, 0}),                                                                                                    Rectangle(extent = {{-76, -64}, {76, -76}}, lineColor=
              {0,127,0},                                                                                                    fillColor=
              {0,127,0},
            fillPattern=FillPattern.HorizontalCylinder),                                                                                                    Rectangle(extent = {{-2, 80}, {2, -80}}, lineColor = {0, 0, 0},
            fillPattern =                                                                                                    FillPattern.Solid, fillColor = {0, 0, 0}, origin = {0, 78}, rotation = -90), Rectangle(extent = {{46, -52}, {52, -64}}, lineColor=
              {180,90,0},                                                                                                    fillColor=
              {180,90,0},
            fillPattern=FillPattern.VerticalCylinder),                                                                                                    Ellipse(extent={{
              38,-32},{60,-54}},                                                                                                    lineColor=
              {0,158,0},                                                                                                    fillColor=
              {0,158,0},
            fillPattern=FillPattern.Sphere),                                                                                                    Rectangle(extent={{
              -76,-70},{76,-76}},                                                                                                    lineColor=
              {0,127,0},                                                                                                    fillColor=
              {0,127,0},
            fillPattern=FillPattern.Solid),                                                                                                    Rectangle(extent = {{76, 2}, {80, -76}}, lineColor = {0, 0, 0},
            fillPattern =                                                                                                    FillPattern.Solid, fillColor = {0, 0, 0}),
                                                                                                    Rectangle(extent = {{-80, 2}, {-76, -76}}, lineColor = {0, 0, 0},
            fillPattern =                                                                                                    FillPattern.Solid, fillColor = {0, 0, 0}),
                                                                                                    Rectangle(extent = {{-2, 80}, {2, -80}}, lineColor = {0, 0, 0},
            fillPattern =                                                                                                    FillPattern.Solid, fillColor = {0, 0, 0}, origin = {0, -78}, rotation = -90),
        Text(
          extent={{-72,112},{74,76}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={236,99,92},
          fillPattern=FillPattern.Solid,
          textString="%name")}),                                                                                                    Documentation(info = "<html>
 <p><h4><font color=\"#008000\">Overview</font></h4></p>
 <p>This model represents a sunblind to reduce the vectorial radiance on facades, windows. etc. </p>
 <p><h4><font color=\"#008000\">Level of Development</font></h4></p>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <p><h4><font color=\"#008000\">Concept</font></h4></p>
 <p><ul>
 <li>You can define the amount of radiance hitting the facade with gsunblind, which states how much radiance goes through the closed sunblind</li>
 <li>At which amount of radiance the sunblind will be closed is defined by Imax. Each directon is independent from all other directions and closes/opens seperately due to the radiance hitting the direction.</li>
 <li>The output sunblindonoff can be used to transfer the state of the shading to another model component. It contains 1-gsunblind, which is the amount of radiances, detained by the shading.</li>
 </ul></p>
 <p><h4><font color=\"#008000\">Assumptions</font></h4></p>
 <p>Each direction closes seperatly, which means that in reality each direction has to have his own sensor. It seems, that if a building uses automatic shading, the sensor is on the roof and computes the radiance on each facade. This is quite similar to the concept of different sensors for different directions, as both systems close the sunblinds seperately for each direction.</p>
 <p>There is no possibilty to disable the sunblind in a specific direction. This isn&apos;t necessary, as you can set gsunblind in this direction to 1, which means, that the whole radiance is passing through the closed sunblind.</p>
 <p><h4><font color=\"#008000\">Example Results</font></h4></p>
 <p>This model is part of <a href=\"AixLib.Building.Components.Walls.Wall\">Wall</a> and checked in the Examples <a href=\"AixLib.Building.Components.Examples.Walls.InsideWall\">InsideWall</a> and <a href=\"AixLib.Building.Components.Examples.Walls.OutsideWall\">OutsideWall</a>. </p>
 </html>", revisions = "<html>
 <p><ul>
 <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
 <li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
 </ul></p>
 </html>"));
end Sunblind;

