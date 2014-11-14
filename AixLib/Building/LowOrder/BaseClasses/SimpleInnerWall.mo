within AixLib.Building.LowOrder.BaseClasses;
model SimpleInnerWall "1 capacitance, 1 resistance"
  import SI = Modelica.SIunits;
  parameter SI.ThermalResistance R1 = 1 "Resistance 1";
  parameter SI.HeatCapacity C1 = 1 "Capacity 1";
  parameter Modelica.SIunits.Temp_K T0 = 295.15
    "Initial temperature for all components";
  //parameter SI.Area A=16 "Wall Area";
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Res1(R = R1) annotation(Placement(transformation(extent = {{-18, 18}, {2, 38}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0), iconTransformation(extent = {{-110, -10}, {-90, 10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor load1(C = C1, T(start = T0)) annotation(Placement(transformation(extent = {{32, 4}, {52, 24}})));
equation
  connect(port_a, Res1.port_a) annotation(Line(points = {{-100, 0}, {-60, 0}, {-60, 28}, {-18, 28}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(Res1.port_b, load1.port) annotation(Line(points = {{2, 28}, {20, 28}, {20, 0}, {42, 0}, {42, 4}}, color = {191, 0, 0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 120}}), graphics), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <ul>
 <li>This thermal model represents the one dimensional heat transfer into a simple wall with dynamic characteristics (heat storage, 1 capacitance). Therefore, this (inner) wall is only used as a heat storage with a heat resistance.</li>
 <li>It is based on the VDI 6007, in which the heat transfer through inner walls is described by a comparison with an electric circuit.</li>
 <li>Normally, it should be used together with the other parts of the VDI 6007 model library. It represents all walls with a heat transfer in only one zone. Make sure, you got the right R&apos;s and C&apos;s (e.g. like they are computed in VDI 6007).</li>
 </ul>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars4.png\"/></p>
 <h4><span style=\"color:#008000\">Assumptions</span></h4>
 <p>The model underlies all assumptions which are made in VDI 6007, especially that all heat transfer parts are combined in one part. It can be used in combination with various other models.</p>
 <h4><span style=\"color:#008000\">Known Limitations</span></h4>
 <p>There are no known limitaions.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The model works like an electric circuit as the equations of heat transfer are similar to them. All elements used in the model are taken from the EBC standard library.</p>
 <p><br><b><font style=\"color: #008000; \">References</font></b></p>
 <ul>
 <li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
 </ul>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p>The wall model is tested and validated in the context of the <a href=\"AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel\">ReducedOrderModel</a>. See <a href=\"AixLib.Building.LowOrder.Validation\">Validation</a> for some results.</p>
 </html>", revisions = "<html>
 <p><ul>
 <li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
 </ul></p>
 </html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 120}}), graphics={  Rectangle(extent = {{-86, 60}, {-34, 26}}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-28, 60}, {26, 26}}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{32, 60}, {86, 26}}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{0, 20}, {54, -14}}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-60, 20}, {-6, -14}}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-86, -20}, {-34, -54}}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-28, -20}, {26, -54}}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{32, -20}, {86, -54}}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-60, -60}, {-6, -94}}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{0, -60}, {54, -94}}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-60, 100}, {-6, 66}}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{0, 100}, {54, 66}}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{60, -60}, {114, -94}}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{60, 20}, {116, -14}}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{60, 100}, {116, 66}}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-120, -60}, {-66, -94}}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-120, 20}, {-66, -14}}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-120, 100}, {-66, 66}}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-88, 120}, {-120, -100}}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                    FillPattern.Solid, pattern = LinePattern.None), Rectangle(extent = {{120, 120}, {89, -100}}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                    FillPattern.Solid, pattern = LinePattern.None), Line(points = {{-90, 0}, {-2, 0}}, color = {0, 0, 0}, thickness = 0.5, smooth = Smooth.None), Rectangle(extent = {{-74, 12}, {-26, -10}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                    0.5, fillColor = {255, 255, 255},
            fillPattern =                                                                                                    FillPattern.Solid), Line(points = {{-2, 0}, {-2, -32}}, color = {0, 0, 0}, thickness = 0.5, smooth = Smooth.None), Rectangle(extent = {{15, -32}, {-19, -44}},
            lineThickness =                                                                                                    0.5, fillColor = {255, 255, 255},
            fillPattern =                                                                                                    FillPattern.Solid, pattern = LinePattern.None), Line(points = {{-19, -32}, {15, -32}}, pattern = LinePattern.None, thickness = 0.5, smooth = Smooth.None), Line(points = {{-19, -44}, {15, -44}}, pattern = LinePattern.None, thickness = 0.5, smooth = Smooth.None), Text(extent = {{-90, 142}, {90, 104}}, lineColor = {0, 0, 255}, textString = "%name")}));
end SimpleInnerWall;

