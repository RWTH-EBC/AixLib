within AixLib.HVAC.HeatExchanger.Examples.Medium;


model SingleHX_room
  "heat recovery in simple ventilation system with internal room sources."
  import Anlagensimulation_WS1314 = AixLib.HVAC;
  extends Modelica.Icons.Example;
  inner Anlagensimulation_WS1314.BaseParameters baseParameters annotation(Placement(transformation(extent = {{60, 66}, {80, 86}})));
  Anlagensimulation_WS1314.HeatExchanger.Recuperator HX(flowType = 1) annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {-10, 0})));
  Sources.BoundaryMoistAir_phX Medium2out(use_p_in = false, X = 0, p = 101325) annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 180, origin = {-50, 20})));
  Modelica.Blocks.Sources.Ramp Toda(duration = 1, startTime = 1, height = 20e3, offset = 5.03e3)
    "outdoor air temperature"                                                                                              annotation(Placement(transformation(extent = {{-90, -30}, {-70, -10}})));
  Anlagensimulation_WS1314.Volume.VolumeMoistAir volumeMoistAir(V = 0.0001) annotation(Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 90, origin = {30, 0})));
  Anlagensimulation_WS1314.Sources.MassflowsourceMoistAir_mhX Medium2out1(X = 0, use_h_in = true, m = 0.07987) annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 180, origin = {-50, -20})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow = 500, T_ref = baseParameters.T_ref) annotation(Placement(transformation(extent = {{68, -10}, {48, 10}})));
equation
  connect(HX.port_1b, volumeMoistAir.portMoistAir_a) annotation(Line(points = {{2, -20}, {30, -20}, {30, -10}}, color = {0, 127, 255}));
  connect(volumeMoistAir.portMoistAir_b, HX.port_2a) annotation(Line(points = {{30, 10}, {30, 20}, {2, 20}}, color = {0, 127, 255}));
  connect(HX.port_2b, Medium2out.portMoistAir_a) annotation(Line(points = {{-22, 20}, {-40, 20}}, color = {0, 127, 255}));
  connect(Toda.y, Medium2out1.h_in) annotation(Line(points = {{-69, -20}, {-62, -20}}, color = {0, 0, 127}));
  connect(fixedHeatFlow.port, volumeMoistAir.heatPort) annotation(Line(points = {{48, 0}, {40, 0}}, color = {191, 0, 0}));
  connect(Medium2out1.portMoistAir_a, HX.port_1a) annotation(Line(points = {{-40, -20}, {-22, -20}}, color = {0, 127, 255}));
  annotation (Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>A small example of an heat exchanger in combination with a room model with a heat load (ventilation system with heat recovery). The outdoor air temperature will be varied.</p>
 </html>", revisions = "<html>
 <p>03.02.2014, Peter Matthes</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"), experiment(StopTime = 3));
end SingleHX_room;
