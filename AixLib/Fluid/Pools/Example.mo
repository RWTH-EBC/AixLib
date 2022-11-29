within AixLib.Fluid.Pools;
package Example
      extends Modelica.Icons.ExamplesPackage;

  model IndoorSwimmingPool
      extends Modelica.Icons.Example;
    Modelica.Blocks.Interfaces.RealOutput MFlowFreshWater
      "Flow rate of added fresh water to the pool and water treatment system"
      annotation (Placement(transformation(extent={{98,-96},{126,-68}}),
          iconTransformation(extent={{98,-96},{126,-68}})));
    .AixLib.Fluid.Pools.IndoorSwimmingPool indoorSwimming(poolParam=
          AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools.SportPool(),
        redeclare package WaterMedium = WaterMedium)
      annotation (Placement(transformation(extent={{-38,-36},{30,38}})));

      replaceable package WaterMedium = AixLib.Media.Water annotation (choicesAllMatching=true);

    Modelica.Blocks.Sources.RealExpression TSoil(y=273.15 + 8)
      annotation (Placement(transformation(extent={{96,44},{80,60}})));
    Modelica.Blocks.Sources.RealExpression X_W(y=14.3)
      annotation (Placement(transformation(extent={{-86,54},{-70,70}})));
    Modelica.Blocks.Sources.RealExpression T_Air(y=273.15 + 30)
      annotation (Placement(transformation(extent={{-86,72},{-70,88}})));
    Modelica.Blocks.Sources.Pulse pulse(
      amplitude=1,
      width=13/15,
      period=(24 - 7)*3600,
      offset=0,
      startTime=3600*7)
      annotation (Placement(transformation(extent={{-94,-50},{-80,-36}})));
    Modelica.Blocks.Sources.Trapezoid Person(
      amplitude=0.5,
      rising=7*3600,
      width=1*3600,
      falling=7*3600,
      period=17*3600,
      offset=0.3,
      startTime=7*3600)
      annotation (Placement(transformation(extent={{-96,-16},{-80,0}})));
    Modelica.Blocks.Interfaces.RealOutput QEvap annotation (Placement(
          transformation(extent={{-86,16},{-118,48}}), iconTransformation(extent={
              {-86,16},{-118,48}})));
    Modelica.Blocks.Interfaces.RealOutput PPool
      "Output eletric energy needed for pool operation" annotation (Placement(
          transformation(extent={{98,-62},{124,-36}}),iconTransformation(extent={{98,-62},
              {124,-36}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
      prescribedTemperature
      annotation (Placement(transformation(extent={{-16,74},{-4,86}})));
    Modelica.Blocks.Interfaces.RealOutput T_Pool "Value of Real output"
      annotation (Placement(transformation(extent={{98,8},{118,28}})));
    Modelica.Blocks.Interfaces.RealOutput QPool
      "Heat flow rate to maintain the pool at the set temperature" annotation (
        Placement(transformation(extent={{98,-20},{122,4}}), iconTransformation(
            extent={{98,-20},{122,4}})));
  equation
    connect(TSoil.y, indoorSwimming.TSoil) annotation (Line(points={{79.2,52},{
            40,52},{40,18.39},{31.02,18.39}},
                                           color={0,0,127}));
    connect(indoorSwimming.X_w, X_W.y) annotation (Line(points={{-13.86,39.11},{-12,
            39.11},{-12,62},{-69.2,62}}, color={0,0,127}));
    connect(indoorSwimming.TAir, T_Air.y) annotation (Line(points={{-26.78,39.11},
            {-26.78,80},{-69.2,80}}, color={0,0,127}));
    connect(pulse.y, indoorSwimming.openingHours) annotation (Line(points={{-79.3,
            -43},{-50,-43},{-50,-20.46},{-40.04,-20.46}}, color={0,0,127}));
    connect(Person.y, indoorSwimming.persons) annotation (Line(points={{-79.2,-8},
            {-48,-8},{-48,-8.25},{-39.7,-8.25}}, color={0,0,127}));
    connect(indoorSwimming.QEvap, QEvap) annotation (Line(points={{-39.36,21.72},{
            -39.36,22},{-66,22},{-66,32},{-102,32}}, color={0,0,127}));
    connect(indoorSwimming.PPool, PPool) annotation (Line(points={{32.72,-27.12},
            {32.72,-26},{96,-26},{96,-49},{111,-49}},            color={0,0,127}));
    connect(indoorSwimming.MFlowFreshWater, MFlowFreshWater) annotation (Line(
          points={{32.72,-33.04},{32.72,-82},{112,-82}}, color={0,0,127}));
    connect(prescribedTemperature.T, T_Air.y)
      annotation (Line(points={{-17.2,80},{-69.2,80}}, color={0,0,127}));
    connect(prescribedTemperature.port, indoorSwimming.convPoolSurface)
      annotation (Line(points={{-4,80},{21.16,80},{21.16,39.48}}, color={191,0,0}));
    connect(indoorSwimming.T_Pool, T_Pool) annotation (Line(points={{32.72,6.92},
            {92,6.92},{92,18},{108,18}}, color={0,0,127}));
    connect(MFlowFreshWater, MFlowFreshWater)
      annotation (Line(points={{112,-82},{112,-82}}, color={0,0,127}));
    connect(indoorSwimming.QPool, QPool) annotation (Line(points={{32.72,-1.22},
            {32.72,0},{92,0},{92,-8},{110,-8}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=1080000, __Dymola_Algorithm="Dassl"));
  end IndoorSwimmingPool;
end Example;
