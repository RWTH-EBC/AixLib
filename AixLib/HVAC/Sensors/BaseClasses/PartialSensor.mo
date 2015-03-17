within AixLib.HVAC.Sensors.BaseClasses;


partial model PartialSensor "Base class for sensors"
  extends Interfaces.TwoPort;
  Modelica.Blocks.Interfaces.RealOutput signal "Output signal from sensor" annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {0, 100})));
equation
  port_a.p = port_b.p;
  inStream(port_a.h_outflow) = port_b.h_outflow;
  inStream(port_b.h_outflow) = port_a.h_outflow;
  annotation(Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p><br/>This sensor base class defines a fluid model which does not affect the fluid properties. The signal output can be used to generate a signal of the measured value.</p>
 </html>", revisions = "<html>
 <p>10.12.2013, Mark Wesseling</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
end PartialSensor;
