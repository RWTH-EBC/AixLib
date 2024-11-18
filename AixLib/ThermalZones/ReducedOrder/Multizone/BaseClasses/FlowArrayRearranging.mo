within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model FlowArrayRearranging "A model to rearrange heat flows between a range of ports"
  parameter Integer nCon=1 "Number of connections";
  parameter Integer conPaiArr[nCon, 2] "Array of port numbers to connect";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a splPor[nCon * 2] "Thermal in-/output" annotation (
    Placement(transformation(extent = {{-120, -20}, {-80, 20}})));
equation
  for i in 1:nCon loop
    connect(splPor[conPaiArr[i, 1]], splPor[conPaiArr[i, 2]]);
  end for;

  annotation (
    defaultComponentName = "flowRea",
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Text(origin = {-12, 14}, textColor = {255, 0, 0}, extent = {{-2, 4}, {26, -30}}, textString = "0 / 1", textStyle = {TextStyle.Bold}), Line(points = {{-80, 0}, {14, 80}, {14, 80}}, color = {191, 0, 0}), Line(points = {{-80, 0}, {18, 48}, {18, 48}}, color = {191, 0, 0}), Line(points = {{-80, 0}, {16, 18}, {16, 18}}, color = {191, 0, 0}), Line(points = {{-80, 0}, {12, -78}, {12, -78}}, color = {191, 0, 0}), Line(points = {{-80, 0}, {12, -46}, {12, -46}}, color = {191, 0, 0}), Line(points = {{-80, 0}, {12, -18}, {12, -18}}, color = {191, 0, 0}), Text(textColor = {0, 0, 255}, extent = {{-48, -82}, {52, -100}}, textString = "ZoneSplitter")}),
    Documentation(info = "<html>
  <p>This model is used to rearrange heat flows between thermal zones.</p>
  <p>The model needs the number of connections and the array of how to connect the port indices of splPor.</p>
  </html>", revisions = "<html>
  <ul>
  <li>
  November, 2024, by Philip Groesdonk:<br/>
  Implemented as a workaround for OpenModelica's inability to evaluate arrays before translation.
  </li>
  </ul>
  </html>"));
end FlowArrayRearranging;
