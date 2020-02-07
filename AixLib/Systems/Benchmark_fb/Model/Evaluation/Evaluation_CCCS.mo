within AixLib.Systems.Benchmark_fb.Model.Evaluation;
model Evaluation_CCCS

  Modelica.Blocks.Math.Product product1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={38,36})));
  CCCS.EmissionsCosts EmissionsCosts
    annotation (Placement(transformation(extent={{-80,38},{-54,62}})));
  AixLib.Systems.Benchmark_fb.Model.Evaluation.CCCS.RBF RBF(i=0.05, t=1)
    annotation (Placement(visible=true, transformation(
        origin={8,70},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  AixLib.Systems.Benchmark_fb.Model.BusSystems.Bus_measure bus_measure
    annotation (Placement(
      visible=true,
      transformation(
        origin={-103,-1},
        extent={{-17,-17},{17,17}},
        rotation=0),
      iconTransformation(
        origin={-103,-1},
        extent={{-17,-17},{17,17}},
        rotation=0)));
  Modelica.Blocks.Math.MultiSum OperationalCosts(k={1,1,1,1},
                                                 nu=4)
    annotation (Placement(visible = true, transformation(extent={{-20,26},{-8,
            38}},                                                                       rotation = 0)));
  Modelica.Blocks.Math.Add OverallCost
    annotation (Placement(transformation(extent={{58,-10},{78,10}})));
  AixLib.Systems.Benchmark_fb.Model.Evaluation.CCCS.PerformanceReductionCosts performanceReductionCosts1
    annotation (Placement(visible=true, transformation(
        origin={-70,18},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Math.Add InvestmentCosts annotation (
    Placement(visible = true, transformation(origin={-8,-66},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant InvestmentCostsComponents(k = 0) "it is assumed that the control strategy only utilizes components which are already installed - if new components are required, respective costs have to be added" annotation (
    Placement(visible = true, transformation(extent={{-78,-100},{-58,-80}},     rotation = 0)));
  CCCS.InvestmentCostsStrategy investmentCostsStrategy1 annotation (
    Placement(visible = true, transformation(origin={-68,-50},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  CCCS.EnergyCosts energyCosts
    annotation (Placement(transformation(extent={{-80,70},{-54,90}})));
  Modelica.Blocks.Interfaces.RealOutput OverallCosts_Output
    annotation (Placement(transformation(extent={{98,-10},{118,10}})));
  CCCS.LifespanReductionCosts lifespanReductionCosts
    annotation (Placement(transformation(extent={{-74,-26},{-54,-6}})));
  BusSystems.Bus_Control bus_Control
    annotation (Placement(transformation(extent={{-120,-42},{-80,-2}})));
equation
  connect(bus_measure, EmissionsCosts.bus_measure) annotation (
    Line(points={{-103,-1},{-100,-1},{-100,50},{-80,50}},                   color = {255, 204, 51}, thickness = 0.5));
  connect(investmentCostsStrategy1.kStrat, InvestmentCosts.u1) annotation (
    Line(points={{-57.8,-50},{-20,-50},{-20,-60}},            color = {0, 0, 127}));
  connect(RBF.RBF, product1.u1) annotation (
    Line(points={{19,64.4},{19,38.5},{26,38.5},{26,42}},        color = {0, 0, 127}));
  connect(InvestmentCosts.y, OverallCost.u2) annotation (
    Line(points={{3,-66},{42,-66},{42,-6},{56,-6}},                               color = {0, 0, 127}));
  connect(InvestmentCostsComponents.y, InvestmentCosts.u2) annotation (
    Line(points={{-57,-90},{-20,-90},{-20,-72}},                                      color = {0, 0, 127}));
  connect(OperationalCosts.y, product1.u2) annotation (
    Line(points={{-6.98,32},{18,32},{18,30},{26,30}},       color = {0, 0, 127}));
  connect(EmissionsCosts.Emission_Cost, OperationalCosts.u[1]) annotation (
    Line(points={{-52.7,50},{-34,50},{-34,36},{-24,36},{-24,35.15},{-20,35.15}},
                                                               color = {0, 0, 127}));
  connect(performanceReductionCosts1.PRC, OperationalCosts.u[2]) annotation (
    Line(points={{-59.2,11},{-46,11},{-46,12},{-34,12},{-34,33.05},{-20,33.05}},
                                                             color = {0, 0, 127}));
  connect(product1.y, OverallCost.u1) annotation (
    Line(points={{49,36},{56,36},{56,6}},        color = {0, 0, 127}));
  connect(bus_measure, energyCosts.bus_measure) annotation (Line(
      points={{-103,-1},{-103,80},{-81.04,80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(energyCosts.EnergyCost, OperationalCosts.u[3]) annotation (Line(
        points={{-52.96,80},{-20,80},{-20,30.95}},
                                                 color={0,0,127}));
  connect(OverallCost.y, OverallCosts_Output)
    annotation (Line(points={{79,0},{108,0}}, color={0,0,127}));
  connect(bus_measure, performanceReductionCosts1.bus_measure) annotation (Line(
      points={{-103,-1},{-86,-1},{-86,17.8},{-80,17.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(lifespanReductionCosts.y, OperationalCosts.u[4]) annotation (Line(
        points={{-54.4,-16},{-20,-16},{-20,28.85}}, color={0,0,127}));

  connect(bus_Control, lifespanReductionCosts.bus_Control1) annotation (Line(
      points={{-100,-22},{-78,-22},{-78,-16.2},{-74,-16.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Evaluation_CCCS;
