within AixLib.Systems.Benchmark.Model.Evaluation;
model Evaluation
  CostsFuelPower costs
    annotation (Placement(transformation(extent={{26,-10},{46,10}})));
  BusSystems.Bus_measure measureBus
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Sum_Power sum_Power
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Math.Gain gain2(k=1000)
                                        annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-24,30})));
equation

  connect(measureBus, sum_Power.measureBus) annotation (Line(
      points={{-100,0},{-80,0},{-80,-30},{-60,-30}},
      color={255,204,51},
      thickness=0.5));
  connect(sum_Power.Sum_Power, costs.power_in) annotation (Line(points={{-40,-30},
          {-6,-30},{-6,-5},{26,-5}},        color={0,0,127}));
  connect(add.u2, measureBus.Fuel_CHP) annotation (Line(points={{-62,24},{-80,
          24},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add.u1, measureBus.Fuel_Boiler) annotation (Line(points={{-62,36},{
          -80,36},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(costs.Total_Cost, measureBus.Total_Cost) annotation (Line(points={{46,
          0},{60,0},{60,60},{-99.9,60},{-99.9,0.1}}, color={0,0,127}));
  connect(costs.minute, measureBus.Minute) annotation (Line(points={{46,7},{60,
          7},{60,6},{60,6},{60,60},{-99.9,60},{-99.9,0.1}}, color={0,0,127}));
  connect(costs.hour, measureBus.Hour) annotation (Line(points={{46,5},{54,5},{
          60,5},{60,6},{60,6},{60,6},{60,60},{-99.9,60},{-99.9,0.1}}, color={
          255,127,0}));
  connect(costs.weekDay, measureBus.WeekDay) annotation (Line(points={{46,3.2},
          {60,3.2},{60,4},{60,4},{60,60},{-99.9,60},{-99.9,0.1}}, color={255,
          127,0}));
  connect(add.y, gain2.u)
    annotation (Line(points={{-39,30},{-31.2,30}}, color={0,0,127}));
  connect(gain2.y, costs.fuel_in) annotation (Line(points={{-17.4,30},{-6,30},{
          -6,5},{26,5}}, color={0,0,127}));
  connect(costs.Total_Power, measureBus.Total_Power) annotation (Line(points={{
          46,-4},{60,-4},{60,60},{-99.9,60},{-99.9,0.1}}, color={0,0,127}));
  connect(costs.Total_Fuel, measureBus.Total_Fuel) annotation (Line(points={{46,
          -8},{60,-8},{60,60},{-99.9,60},{-99.9,0.1}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Evaluation;
