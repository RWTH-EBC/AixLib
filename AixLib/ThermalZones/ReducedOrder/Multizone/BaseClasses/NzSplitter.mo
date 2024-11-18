within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;

model NzSplitter "A model to split heat flows between a range of ports"
  //parameter Integer nPorts=2 "Number of splitter ports";
  //parameter Real splitFactor[nPorts, nPorts] = fill(1/nPorts, nPorts, nPorts) "Matrix of factors to distribute heat flow between ports";
  parameter Integer nConnections=1 "Number of connections";
  parameter Integer connectionPairs[nConnections, 2] "Port numbers to connect";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a splitterPort[nConnections * 2] "Thermal in-/output" annotation(
    Placement(transformation(extent = {{-120, -20}, {-80, 20}})));
equation
  for i in 1:nConnections loop
    connect(splitterPort[connectionPairs[i, 1]], splitterPort[connectionPairs[i, 2]]);
  end for;
//  splitterPort[:].Q_flow = -splitFactor*splitterPort[:].Q_flow;
//  splitterPort[:].T = splitFactor*splitterPort[:].T;
  annotation(
    defaultComponentName = "nzSpl",
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Text(origin = {-12, 14}, textColor = {255, 0, 0}, extent = {{-2, 4}, {26, -30}}, textString = "0 / 1", textStyle = {TextStyle.Bold}), Line(points = {{-80, 0}, {14, 80}, {14, 80}}, color = {191, 0, 0}), Line(points = {{-80, 0}, {18, 48}, {18, 48}}, color = {191, 0, 0}), Line(points = {{-80, 0}, {16, 18}, {16, 18}}, color = {191, 0, 0}), Line(points = {{-80, 0}, {12, -78}, {12, -78}}, color = {191, 0, 0}), Line(points = {{-80, 0}, {12, -46}, {12, -46}}, color = {191, 0, 0}), Line(points = {{-80, 0}, {12, -18}, {12, -18}}, color = {191, 0, 0}), Text(textColor = {0, 0, 255}, extent = {{-48, -82}, {52, -100}}, textString = "ZoneSplitter")}),
    Documentation(info = "<html>
  <p>This model is used to split heat flows between thermal zones.</p>
  <p>The model needs the number of ports and the split factors, which are between 0 and 1. Each row
  of the split factor matrix gives the split factors for one output
  port. Usually, the factor will be 1 for one single other port and 0 for all others.</p>
  </html>", revisions = "<html>
  <ul>
  <li>
  November, 2024, by Philip Groesdonk:<br/>
  Implemented as a workaround for OpenModelica's inability to evaluate arrays before translation.
  </li>
  </ul>
  </html>"));
end NzSplitter;
