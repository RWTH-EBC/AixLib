within AixLib.Systems.Benchmark.Model.Evaluation;
model Evaluation_CCS
  Modelica.Blocks.Sources.Constant InvestmentCosts(k=190)
    annotation (Placement(transformation(extent={{-78,-90},{-58,-70}})));
  Modelica.Blocks.Math.Product product1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={66,28})));
  Modelica.Blocks.Sources.Constant PerformanceReductionCostsTemperatureHumidity(k=1)
    annotation (Placement(transformation(extent={{-78,-2},{-58,18}})));
  Modelica.Blocks.Sources.Constant OperationalLifetimeReductionCosts(k=1)
    annotation (Placement(transformation(extent={{-78,-44},{-58,-24}})));
  CCCS.EmissionsCosts EmissionsCosts
    annotation (Placement(transformation(extent={{-76,44},{-56,64}})));
  CCCS.EnergyCosts energyCosts
    annotation (Placement(transformation(extent={{-66,74},{-46,94}})));
  CCCS.RBF RBF annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,58})));
  Modelica.Blocks.Sources.Constant Duration(k=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,90})));
  Modelica.Blocks.Sources.Constant Rate(k=0.05) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={32,90})));
  BusSystems.Bus_measure bus_measure
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=4)
    annotation (Placement(transformation(extent={{12,20},{24,32}})));
  Modelica.Blocks.Math.Add OverallCost
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
equation
  connect(Rate.y, RBF.Rate)
    annotation (Line(points={{32,79},{32,70},{47.4,70}}, color={0,0,127}));
  connect(Duration.y, RBF.Duration_Years)
    annotation (Line(points={{70,79},{70,70},{54,70}}, color={0,0,127}));
  connect(RBF.RBF, product1.u1) annotation (Line(points={{42.4,47},{42.4,38.5},
          {54,38.5},{54,34}}, color={0,0,127}));
  connect(energyCosts.EnergyCost, multiSum.u[1]) annotation (Line(points={{-45,
          84},{-45,56.4},{12,56.4},{12,29.15}}, color={0,0,127}));
  connect(EmissionsCosts.Emission_Cost, multiSum.u[2]) annotation (Line(points=
          {{-55,54},{-22,54},{-22,27.05},{12,27.05}}, color={0,0,127}));
  connect(PerformanceReductionCostsTemperatureHumidity.y, multiSum.u[3])
    annotation (Line(points={{-57,8},{-22,8},{-22,24.95},{12,24.95}}, color={0,
          0,127}));
  connect(OperationalLifetimeReductionCosts.y, multiSum.u[4]) annotation (Line(
        points={{-57,-34},{-22,-34},{-22,22.85},{12,22.85}}, color={0,0,127}));
  connect(multiSum.y, product1.u2) annotation (Line(points={{25.02,26},{40,26},
          {40,22},{54,22}}, color={0,0,127}));
  connect(product1.y, OverallCost.u1)
    annotation (Line(points={{77,28},{78,28},{78,6}}, color={0,0,127}));
  connect(InvestmentCosts.y, OverallCost.u2) annotation (Line(points={{-57,-80},
          {10,-80},{10,-6},{78,-6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
                           Text(
            extent={{98,228},{196,148}},
            lineColor={0,0,0},
            textString="CCCS")}));
end Evaluation_CCS;
