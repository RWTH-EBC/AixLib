within AixLib.Building.Components.Examples.Sources.InternalGains;


model Lights "Simulation to check the light models"
  extends Modelica.Icons.Example;
  Components.Sources.InternalGains.Lights.Lights_relative lights annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table = [0, 0; 28740, 0; 28800, 1; 64800, 1; 64860, 0; 86400, 0]) annotation(Placement(transformation(extent = {{-76, -10}, {-56, 10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemp(T = 293.15) annotation(Placement(transformation(extent = {{78, -8}, {58, 12}})));
equation
  connect(combiTimeTable.y[1], lights.Schedule) annotation(Line(points = {{-55, 0}, {-9, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(lights.ConvHeat, fixedTemp.port) annotation(Line(points = {{9, 6}, {34, 6}, {34, 2}, {58, 2}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(lights.RadHeat, fixedTemp.port) annotation(Line(points = {{9, -5.8}, {46, -5.8}, {46, 2}, {58, 2}}, color = {95, 95, 95}, pattern = LinePattern.None, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), experiment(StopTime = 86400, Interval = 60, __Dymola_Algorithm = "Lsodar"), __Dymola_experimentSetupOutput, Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This simulation is to check the functionality of the light models described by the internal gains. </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>Heat flow values can be displayed via the provided output. </p>
 </html>", revisions = "<html>
 <p><ul>
 <li><i>May 31, 2013&nbsp;</i> by Ole Odendahl:<br/>Implemented, added documentation and formatted appropriately</li>
 </ul></p>
 </html>"));
end Lights;
