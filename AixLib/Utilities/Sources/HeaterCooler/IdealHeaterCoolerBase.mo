within AixLib.Utilities.Sources.HeaterCooler;


partial model IdealHeaterCoolerBase
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolRoom annotation(Placement(transformation(extent = {{80, -10}, {100, 10}})));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                     graphics), Icon(graphics={  Rectangle(extent = {{-94, 6}, {80, -28}}, lineColor = {135, 135, 135}, fillColor = {135, 135, 135},
            fillPattern =                                                                                                    FillPattern.Solid), Polygon(points = {{-82, 6}, {-82, 40}, {-48, 6}, {-82, 6}}, lineColor = {135, 135, 135},
            lineThickness =                                                                                                    1, smooth = Smooth.None, fillColor = {135, 135, 135},
            fillPattern =                                                                                                    FillPattern.Solid), Polygon(points = {{-46, 6}, {-8, 6}, {-8, 40}, {-46, 6}}, lineColor = {135, 135, 135},
            lineThickness =                                                                                                    1, smooth = Smooth.None, fillColor = {135, 135, 135},
            fillPattern =                                                                                                    FillPattern.Solid), Polygon(points = {{30, 6}, {-8, 6}, {-8, 40}, {30, 6}}, lineColor = {135, 135, 135},
            lineThickness =                                                                                                    1, smooth = Smooth.None, fillColor = {135, 135, 135},
            fillPattern =                                                                                                    FillPattern.Solid), Polygon(points = {{64, 6}, {64, 40}, {30, 6}, {64, 6}}, lineColor = {135, 135, 135},
            lineThickness =                                                                                                    1, smooth = Smooth.None, fillColor = {135, 135, 135},
            fillPattern =                                                                                                    FillPattern.Solid), Text(extent = {{64, -18}, {-80, -4}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                    1, fillColor = {135, 135, 135},
            fillPattern =                                                                                                    FillPattern.Solid, textString = "T_set_room<->T_air_room"), Line(points = {{-62, 24}, {-62, 50}}, color = {0, 128, 255}, thickness = 1, smooth = Smooth.None), Line(points = {{-46, 10}, {-46, 50}}, color = {0, 128, 255}, thickness = 1, smooth = Smooth.None), Line(points = {{-30, 24}, {-30, 50}}, color = {0, 128, 255}, thickness = 1, smooth = Smooth.None), Line(points = {{-66, 48}, {-62, 54}, {-58, 48}}, color = {0, 128, 255}, thickness = 1, smooth = Smooth.None), Line(points = {{-50, 48}, {-46, 54}, {-42, 48}}, color = {0, 128, 255}, thickness = 1, smooth = Smooth.None), Line(points = {{-34, 48}, {-30, 54}, {-26, 48}}, color = {0, 128, 255}, thickness = 1, smooth = Smooth.None), Line(points = {{16, 24}, {16, 50}}, color = {255, 0, 0}, thickness = 1, smooth = Smooth.None), Line(points = {{12, 48}, {16, 54}, {20, 48}}, color = {255, 0, 0}, thickness = 1, smooth = Smooth.None), Line(points = {{44, 24}, {44, 50}}, color = {255, 0, 0}, thickness = 1, smooth = Smooth.None), Line(points = {{40, 48}, {44, 54}, {48, 48}}, color = {255, 0, 0}, thickness = 1, smooth = Smooth.None), Line(points = {{30, 10}, {30, 50}}, color = {255, 0, 0}, thickness = 1, smooth = Smooth.None), Line(points = {{26, 48}, {30, 54}, {34, 48}}, color = {255, 0, 0}, thickness = 1, smooth = Smooth.None)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This is the base class of an ideal heater and/or cooler. It is used in full ideal heater/cooler models as an extension.</p>
 </html>", revisions = "<html>
 <p><ul>
 <li><i>June, 2014&nbsp;</i> by Moritz Lauster:<br/>Added some basic documentation</li>
 </ul></p>
 </html>"));
end IdealHeaterCoolerBase;
