within AixLib.HVAC.Office.Examples;

model ExternalC
  extends Modelica.Icons.Example;
  parameter Real Rate = 1;
  Room.ExternalCInterfaceModelica_NoChange externalC(Stringer = "Hello External C, I am Modelica", Rate = Rate, LENGTH = 3, Initials = {0, 1, -2}) annotation(Placement(transformation(extent = {{0, -20}, {40, 20}})));
  Modelica.Blocks.Sources.Sine sine(amplitude = 3, freqHz = 0.01) annotation(Placement(transformation(extent = {{-80, 30}, {-60, 50}})));
  Modelica.Blocks.Sources.Clock clock annotation(Placement(transformation(extent = {{20, 60}, {40, 80}})));
  Modelica.Blocks.Sources.Ramp ramp(height = 4, duration = 30, startTime = 40, offset = 1) annotation(Placement(transformation(extent = {{-80, -10}, {-60, 10}})));
  Modelica.Blocks.Sources.Step step(height = 2, startTime = 50, offset = -2) annotation(Placement(transformation(extent = {{-80, -50}, {-60, -30}})));
equation
  connect(sine.y, externalC.u[1]) annotation(Line(points = {{-59, 40}, {-30, 40}, {-30, 2.66667}, {0, 2.66667}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(ramp.y, externalC.u[2]) annotation(Line(points = {{-59, 0}, {-30.5, 0}, {-30.5, -2.22045e-016}, {0, -2.22045e-016}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(step.y, externalC.u[3]) annotation(Line(points = {{-59, -40}, {-30, -40}, {-30, -2}, {0, -2}, {0, -2.66667}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(extent = {{-120, -100}, {100, 100}}, preserveAspectRatio = false), graphics = {Text(extent = {{-38, -36}, {76, -66}}, lineColor = {0, 0, 255}, textString = "Send 3 different signals to external function/program"), Text(extent = {{-120, -68}, {100, -108}}, lineColor = {0, 0, 255}, textString = "Header.h and ExternalC.lib from library directory Office\\Libs\\ 
 must be present in the current working directory!
 Alternatively the PATH and INCLUDE variables can be adjusted according to the specified location.
 ")}), Icon(coordinateSystem(extent = {{-120, -100}, {100, 100}})), experiment(StopTime = 100, Interval = 0.1, __Dymola_Algorithm = "Lsodar"), __Dymola_experimentSetupOutput(events = false), Documentation(revisions = "<html>
 <p>24.01.14, Bjoern Flieger</p>
 <p><ul>
 <li>Implemented full example</li>
 </ul></p>
 <p>23.01.14, Bjoern Flieger</p>
 <p><ul>
 <li>Implemented first draft</li>
 </ul></p>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This example illustrates the usage of external C functions.</p>
 </html>"));
end ExternalC;