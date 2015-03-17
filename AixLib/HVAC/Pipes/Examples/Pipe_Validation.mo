within AixLib.HVAC.Pipes.Examples;


model Pipe_Validation
  extends Modelica.Icons.Example;
  Pipe pipe(l = 10, D = 0.02412, e = 0.03135) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  inner BaseParameters baseParameters annotation(Placement(transformation(extent = {{-10, 50}, {10, 70}})));
  Sources.Boundary_ph boundary_ph(use_p_in = false, h = 1e6) annotation(Placement(transformation(extent = {{-60, -10}, {-40, 10}})));
  Sources.Boundary_ph boundary_ph1(use_p_in = false) annotation(Placement(transformation(extent = {{60, -10}, {40, 10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation(Placement(transformation(extent = {{-38, 20}, {-18, 40}})));
  Modelica.Blocks.Sources.Ramp ramp(height = 1000, duration = 1000, startTime = 200) annotation(Placement(transformation(extent = {{-80, 20}, {-60, 40}})));
equation
  connect(boundary_ph.port_a, pipe.port_a) annotation(Line(points = {{-40, 0}, {-10, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(boundary_ph1.port_a, pipe.port_b) annotation(Line(points = {{40, 0}, {10, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(prescribedHeatFlow.port, pipe.heatport) annotation(Line(points = {{-18, 30}, {0, 30}, {0, 5}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(ramp.y, prescribedHeatFlow.Q_flow) annotation(Line(points = {{-59, 30}, {-38, 30}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), experiment(StopTime = 1500, Interval = 1), __Dymola_experimentSetupOutput(events = false), Documentation(revisions = "<html>
 <p>01.10.2013, by <i>Pooyan Jahangiri</i>: implemented</p>
 </html>", info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>Simple example of the pipe connected to two boundaries and a heat source.</p>
 <p><br/><b><font style=\"color: #008000; \">Concept</font></b></p>
 <p>The boundaries have different pressures resulting in a mass flow in the pipe. The pipe is connected to a heat source with variable heat flow. The change in internal energy and the temperature of the pipe can be observed.</p>
 </html>"));
end Pipe_Validation;
