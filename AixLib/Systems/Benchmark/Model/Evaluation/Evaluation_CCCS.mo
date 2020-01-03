within AixLib.Systems.Benchmark.Model.Evaluation;
model Evaluation_CCCS
parameter Real duration=1;
parameter Real rate=0.05;
  Modelica.Blocks.Math.Product product1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={66,28})));
  CCCS.EmissionsCosts EmissionsCosts
    annotation (Placement(transformation(extent={{-76,44},{-56,64}})));
  CCCS.EnergyCosts energyCosts
    annotation (Placement(transformation(extent={{-66,74},{-46,94}})));
  AixLib.Systems.Benchmark.Model.Evaluation.CCCS.RBF RBF(i = 0.05, t = 1)  annotation (Placement(visible = true, transformation(origin = {42, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  AixLib.Systems.Benchmark.Model.BusSystems.Bus_measure bus_measure
    annotation (Placement(visible = true, transformation(origin = {-103, -1}, extent = {{-17, -17}, {17, 17}}, rotation = 0), iconTransformation(origin = {-103, -1}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  Modelica.Blocks.Math.MultiSum OperationalCosts(nu = 4)
    annotation (Placement(visible = true, transformation(extent = {{12, 20}, {24, 32}}, rotation = 0)));
  Modelica.Blocks.Math.Add OverallCost
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  AixLib.Systems.Benchmark.Model.Evaluation.CCCS.PerformanceReductionCosts performanceReductionCosts1 annotation(
    Placement(visible = true, transformation(origin = {-62, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AixLib.Systems.Benchmark.Model.BusSystems.Bus_Control bus_Control1 annotation(
    Placement(visible = true, transformation(origin = {-100, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AixLib.Systems.Benchmark.Model.Evaluation.CCCS.LifespanReductionCosts lifespanReductionCosts2 annotation(
    Placement(visible = true, transformation(origin = {-40, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add InvestmentCosts annotation(
    Placement(visible = true, transformation(origin = {12, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant InvestmentCostsComponents(k = 0) "it is assumed that the control strategy only utilizes components which are already installed - if new components are required, respective costs have to be added" annotation(
    Placement(visible = true, transformation(extent = {{-56, -96}, {-36, -76}}, rotation = 0)));
  CCCS.InvestmentCostsStrategy investmentCostsStrategy1 annotation(
    Placement(visible = true, transformation(origin = {-46, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(bus_Control1, bus_Control1) annotation(
    Line(points = {{-100, -30}, {-50, -30}, {-50, -24}, {-50, -24}}, color = {255, 204, 51}, thickness = 0.5));
  connect(lifespanReductionCosts2.y, OperationalCosts.u[4]) annotation(
    Line(points = {{-30, -24}, {-4, -24}, {-4, 26}, {12, 26}}, color = {0, 0, 127}));
  connect(bus_measure, bus_measure1) annotation(
    Line(points = {{-102, 0}, {-72, 0}, {-72, 10}, {-72, 10}}, color = {255, 204, 51}, thickness = 0.5));
  connect(bus_measure, EmissionsCosts.bus_measure1) annotation(
    Line(points = {{-102, 0}, {-100, 0}, {-100, 54}, {-76, 54}, {-76, 54}}, color = {255, 204, 51}, thickness = 0.5));
  connect(bus_measure, bus_measure1) annotation(
    Line(points = {{-102, 0}, {-100, 0}, {-100, 84}, {-72, 84}, {-72, 84}}, color = {255, 204, 51}, thickness = 0.5));
  connect(investmentCostsStrategy1.kStrat, InvestmentCosts.u1) annotation(
    Line(points = {{-36, -58}, {0, -58}, {0, -66}, {0, -66}}, color = {0, 0, 127}));
  connect(RBF.RBF, product1.u1) annotation(
    Line(points = {{36, 63}, {36, 38.5}, {54, 38.5}, {54, 34}}, color = {0, 0, 127}));
  connect(Duration.y, RBF.Duration_Years) annotation(
    Line(points = {{70, 79}, {70, 70}, {54, 70}}, color = {0, 0, 127}));
  connect(InvestmentCosts.y, OverallCost.u2) annotation(
    Line(points = {{24, -72}, {46, -72}, {46, -8}, {78, -8}, {78, -6}, {78, -6}}, color = {0, 0, 127}));
  connect(InvestmentCostsComponents.y, InvestmentCosts.u2) annotation(
    Line(points = {{-34, -86}, {-20, -86}, {-20, -78}, {0, -78}, {0, -78}, {0, -78}}, color = {0, 0, 127}));
  connect(OperationalCosts.y, product1.u2) annotation(
    Line(points = {{25, 26}, {40, 26}, {40, 22}, {54, 22}}, color = {0, 0, 127}));
  connect(EmissionsCosts.Emission_Cost, OperationalCosts.u[2]) annotation(
    Line(points = {{-55, 54}, {-22, 54}, {-22, 26}, {12, 26}}, color = {0, 0, 127}));
  connect(energyCosts.EnergyCost, OperationalCosts.u[1]) annotation(
    Line(points = {{-45, 84}, {-45, 84.2}, {-21, 84.2}, {-21, 54.4}, {-22, 54.4}, {-22, 26.4625}, {12, 26.4625}, {12, 26}}, color = {0, 0, 127}));
  connect(performanceReductionCosts1.PRC, OperationalCosts.u[3]) annotation(
    Line(points = {{-52, 2}, {-22, 2}, {-22, 26}, {12, 26}}, color = {0, 0, 127}));
  connect(product1.y, OverallCost.u1) annotation(
    Line(points = {{77, 28}, {78, 28}, {78, 6}}, color = {0, 0, 127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
                           Text(
            extent={{98,228},{196,148}},
            lineColor={0,0,0},
            textString="CCCS")}));
end Evaluation_CCCS;
