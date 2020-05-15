within AixLib.Systems.Benchmark_fb;
model testCCCS
  Modelica.Blocks.Math.Product product1 annotation (
    Placement(visible = true, transformation(origin={40,30},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  CCCS.BaseClasses.RBF                             RBF(i=0.05, t=1)     annotation (
    Placement(visible = true, transformation(origin={0,90},      extent = {{-10, -10}, {10, 10}}, rotation=0)));
  Modelica.Blocks.Math.MultiSum OperationalCosts(k={1,1,1,1}, nu=4)        annotation (
    Placement(visible = true, transformation(extent={{8,18},{20,30}},         rotation = 0)));
  Modelica.Blocks.Math.Add OverallCost annotation (
    Placement(visible = true, transformation(extent={{70,-10},{90,10}},      rotation = 0)));
  Modelica.Blocks.Math.Add InvestmentCosts annotation (
    Placement(visible = true, transformation(origin={40,-30},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  CCCS.Components.InvestmentCostsStrategy
    investmentCostsStrategy1 annotation (Placement(visible=true,
        transformation(
        origin={-50,-30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput OverallCosts_Output annotation (
    Placement(transformation(extent = {{98, -10}, {118, 10}})));
  Benchmark.BaseClasses.MainBus mainBus annotation (
    Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
  CCCS.Components.InvestmentCostsComponents
                                       investmentCostsComponents(k_Investment=0)
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  CCCS.Components.EnergyCosts                             energyCosts1
    annotation (Placement(visible=true, transformation(
        origin={-52,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  CCCS.Components.EmissionsCosts                             emissionsCosts1
    annotation (Placement(visible=true, transformation(
        origin={-50,60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  CCCS.Components.PerformanceReductionCosts performanceReductionCosts
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  CCCS.Components.LifespanReductionCosts lifespanReductionCosts
    annotation (Placement(transformation(extent={{-64,-14},{-40,16}})));
equation
  connect(energyCosts1.EnergyCost,OperationalCosts. u[1]) annotation (
    Line(points={{-41,90},{-20,90},{-20,28},{4,28},{4,27.15},{8,27.15}},                    color = {0, 0, 127}));
  connect(emissionsCosts1.Emission_Cost,OperationalCosts. u[2]) annotation (
    Line(points={{-39,60},{-20,60},{-20,25.05},{8,25.05}},            color = {0, 0, 127}));
  connect(OperationalCosts.y,product1. u2) annotation (
    Line(points={{21.02,24},{28,24}},      color = {0, 0, 127}));
  connect(RBF.RBF,product1. u1) annotation (
    Line(points={{11,90},{20,90},{20,36.5},{28,36.5},{28,36}},                        color = {0, 0, 127}));
  connect(product1.y,OverallCost. u1) annotation (
    Line(points={{51,30},{60,30},{60,6},{68,6}},                                         color = {0, 0, 127}));
  connect(InvestmentCosts.y,OverallCost. u2) annotation (
    Line(points={{51,-30},{60,-30},{60,-6},{68,-6}},          color = {0, 0, 127}));
  connect(investmentCostsComponents.y,InvestmentCosts. u2) annotation (
    Line(points={{-39.4,-60},{20,-60},{20,-36},{28,-36}},           color = {0, 0, 127}));
  connect(investmentCostsStrategy1.kStrat,InvestmentCosts. u1) annotation (
    Line(points={{-39.8,-30},{20,-30},{20,-24},{28,-24}},           color = {0, 0, 127}));
  connect(OverallCost.y,OverallCosts_Output)  annotation (
    Line(points={{91,0},{108,0}},      color = {0, 0, 127}));
  connect(mainBus.evaBus.WelTotalMea,energyCosts1. WelTotal) annotation (Line(
      points={{-99.95,0.05},{-100,0.05},{-100,90},{-64,90}},
      color={255,204,51},
      thickness=0.5));
  connect(mainBus.evaBus.QbrTotalMea,energyCosts1. FuelTotal) annotation (
      Line(
      points={{-99.95,0.05},{-102,0.05},{-102,2},{-100,2},{-100,82},{-64,82},
          {-64,81}},
      color={255,204,51},
      thickness=0.5));
  connect(mainBus.evaBus.WelTotalMea,emissionsCosts1. WelTotal) annotation (
      Line(
      points={{-99.95,0.05},{-102,0.05},{-102,2},{-100,2},{-100,60},{-82,60},
          {-82,61},{-62,61}},
      color={255,204,51},
      thickness=0.5));
  connect(mainBus.evaBus.QbrTotalMea,emissionsCosts1. FuelTotal) annotation (
      Line(
      points={{-99.95,0.05},{-100,0.05},{-100,54},{-62,54},{-62,53}},
      color={255,204,51},
      thickness=0.5));
  connect(mainBus, performanceReductionCosts.mainBus) annotation (Line(
      points={{-100,0},{-100,30},{-60.2,30}},
      color={255,204,51},
      thickness=0.5));
  connect(performanceReductionCosts.PRC, OperationalCosts.u[3]) annotation (
      Line(points={{-39,22},{-30,22},{-30,20},{8,20},{8,22.95}}, color={0,0,127}));
  connect(mainBus, lifespanReductionCosts.mainBus) annotation (Line(
      points={{-100,0},{-90,0},{-90,0.6},{-64,0.6}},
      color={255,204,51},
      thickness=0.5));
  connect(lifespanReductionCosts.y, OperationalCosts.u[4]) annotation (Line(
        points={{-39.4462,0},{-20,0},{-20,20.85},{8,20.85}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testCCCS;
