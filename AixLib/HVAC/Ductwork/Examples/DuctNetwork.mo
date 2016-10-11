within AixLib.HVAC.Ductwork.Examples;


model DuctNetwork "Duct Network Example"
  import Anlagensimulation_WS1314 = AixLib.HVAC;
  extends Modelica.Icons.Example;
  Sources.BoundaryMoistAir_phX boundaryMoistAir_phX1(use_p_in = false, p = 98000) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {88, 0})));
  inner Anlagensimulation_WS1314.BaseParameters baseParameters annotation(Placement(transformation(extent = {{60, 66}, {80, 86}})));
  Sources.BoundaryMoistAir_phX boundaryMoistAir_phX2(use_p_in = false, h = 2e4, p = 100000) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, origin = {-90, 0})));
  Anlagensimulation_WS1314.Ductwork.Duct duct(D = 0.1, l = 10) annotation(Placement(transformation(extent = {{-60, -6}, {-40, 6}})));
  Anlagensimulation_WS1314.Ductwork.Duct duct1(D = 0.1, l = 50) annotation(Placement(transformation(extent = {{-26, 26}, {8, 40}})));
  Anlagensimulation_WS1314.Ductwork.Duct duct2(D = 0.1, l = 100) annotation(Placement(transformation(extent = {{-2, -6}, {62, 8}})));
  Anlagensimulation_WS1314.Ductwork.PressureLoss pressureLoss(D = 0.1) annotation(Placement(transformation(extent = {{14, 26}, {34, 40}})));
  Anlagensimulation_WS1314.Ductwork.Duct duct3(D = 0.1, l = 50) annotation(Placement(transformation(extent = {{42, 26}, {76, 40}})));
  Anlagensimulation_WS1314.Ductwork.PressureLoss pressureLoss1(D = 0.1, zeta = 5) annotation(Placement(transformation(extent = {{-58, -42}, {-38, -28}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow = 500) annotation(Placement(transformation(extent = {{-62, 54}, {-42, 74}})));
equation
  connect(duct.portMoistAir_b, duct1.portMoistAir_a) annotation(Line(points = {{-40, 0}, {-32, 0}, {-32, 33}, {-26, 33}}, color = {0, 127, 255}));
  connect(duct.portMoistAir_b, duct2.portMoistAir_a) annotation(Line(points = {{-40, 0}, {-2, 0}, {-2, 1}}, color = {0, 127, 255}));
  connect(duct1.portMoistAir_b, pressureLoss.portMoistAir_a) annotation(Line(points = {{8, 33}, {14, 33}}, color = {0, 127, 255}));
  connect(pressureLoss.portMoistAir_b, duct3.portMoistAir_a) annotation(Line(points = {{34, 33}, {42, 33}}, color = {0, 127, 255}));
  connect(duct3.portMoistAir_b, boundaryMoistAir_phX1.portMoistAir_a) annotation(Line(points = {{76, 33}, {78, 33}, {78, 0}}, color = {0, 127, 255}));
  connect(duct2.portMoistAir_b, boundaryMoistAir_phX1.portMoistAir_a) annotation(Line(points = {{62, 1}, {62, 0}, {78, 0}}, color = {0, 127, 255}));
  connect(boundaryMoistAir_phX2.portMoistAir_a, pressureLoss1.portMoistAir_a) annotation(Line(points = {{-80, 0}, {-78, 0}, {-78, -2}, {-72, -2}, {-72, -35}, {-58, -35}}, color = {0, 127, 255}));
  connect(pressureLoss1.portMoistAir_b, duct2.portMoistAir_a) annotation(Line(points = {{-38, -35}, {-10, -35}, {-10, 0}, {0, 0}, {0, 2}, {-2, 2}, {-2, 1}}, color = {0, 127, 255}));
  connect(duct.portMoistAir_a, boundaryMoistAir_phX2.portMoistAir_a) annotation(Line(points = {{-60, 0}, {-80, 0}}, color = {0, 127, 255}));
  connect(fixedHeatFlow.port, duct1.heatport) annotation(Line(points = {{-42, 64}, {-9, 64}, {-9, 39.475}}, color = {191, 0, 0}));
  annotation (Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>A small example which shows how to build a network of ducts</p>
 </html>", revisions = "<html>
 <p>10.12.2013, Mark Wesseling</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"));
end DuctNetwork;
