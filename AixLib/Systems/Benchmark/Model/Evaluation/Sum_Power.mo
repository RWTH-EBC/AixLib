within AixLib.Systems.Benchmark.Model.Evaluation;
model Sum_Power
  BusSystems.Bus_measure measureBus
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Math.Add3 add3_1
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Modelica.Blocks.Math.Add3 add3_2
    annotation (Placement(transformation(extent={{-60,54},{-40,74}})));
  Modelica.Blocks.Math.Add3 add3_3
    annotation (Placement(transformation(extent={{-60,28},{-40,48}})));
  Modelica.Blocks.Math.Add3 add3_5
    annotation (Placement(transformation(extent={{-60,2},{-40,22}})));
  Modelica.Blocks.Math.Add3 add3_6
    annotation (Placement(transformation(extent={{-60,-26},{-40,-6}})));
  Modelica.Blocks.Math.Add3 add3_7
    annotation (Placement(transformation(extent={{-60,-52},{-40,-32}})));
  Modelica.Blocks.Math.Add3 add3_8
    annotation (Placement(transformation(extent={{-60,-78},{-40,-58}})));
  Modelica.Blocks.Math.Add3 add3_9
    annotation (Placement(transformation(extent={{-18,30},{2,50}})));
  Modelica.Blocks.Math.Add3 add3_10
    annotation (Placement(transformation(extent={{-60,-104},{-40,-84}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=11, k={1,1,1,1,1,1,1,1,1,1,1})
    annotation (Placement(transformation(extent={{38,-18},{74,18}})));
  Modelica.Blocks.Interfaces.RealOutput Sum_Power
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-16,-40},{4,-20}})));
  Modelica.Blocks.Math.Add3 add3_4
    annotation (Placement(transformation(extent={{-16,-12},{4,8}})));
equation
  connect(add3_2.u1, measureBus.Pump_generation_hot_power) annotation (Line(
        points={{-62,72},{-80,72},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_2.u2, measureBus.Pump_Coldwater_heatpump_power) annotation (Line(
        points={{-62,64},{-80,64},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_2.u3, measureBus.Pump_Coldwater_power) annotation (Line(points={
          {-62,56},{-80,56},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_3.u2, measureBus.Pump_Hotwater_power) annotation (Line(points={{
          -62,38},{-80,38},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_3.u3, measureBus.Electrical_power_CHP) annotation (Line(points={
          {-62,30},{-80,30},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_5.u1, measureBus.Pump_RLT_central_warm) annotation (Line(points=
          {{-62,20},{-80,20},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_5.u2, measureBus.Pump_RLT_central_cold) annotation (Line(points=
          {{-62,12},{-80,12},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_5.u3, measureBus.Pump_RLT_openplanoffice_warm) annotation (Line(
        points={{-62,4},{-80,4},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_6.u1, measureBus.Pump_RLT_openplanoffice_cold) annotation (Line(
        points={{-62,-8},{-80,-8},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_6.u2, measureBus.Pump_RLT_conferenceroom_warm) annotation (Line(
        points={{-62,-16},{-80,-16},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_6.u3, measureBus.Pump_RLT_conferenceroom_cold) annotation (Line(
        points={{-62,-24},{-80,-24},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_7.u1, measureBus.Pump_RLT_multipersonoffice_warm) annotation (
      Line(points={{-62,-34},{-80,-34},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_7.u2, measureBus.Pump_RLT_multipersonoffice_cold) annotation (
      Line(points={{-62,-42},{-80,-42},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_7.u3, measureBus.Pump_RLT_canteen_warm) annotation (Line(points=
          {{-62,-50},{-80,-50},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_8.u1, measureBus.Pump_RLT_canteen_cold) annotation (Line(points=
          {{-62,-60},{-80,-60},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_8.u2, measureBus.Pump_RLT_workshop_warm) annotation (Line(points=
         {{-62,-68},{-80,-68},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_8.u3, measureBus.Pump_RLT_workshop_cold) annotation (Line(points=
         {{-62,-76},{-80,-76},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_9.u3, measureBus.Pump_TBA_openplanoffice) annotation (Line(
        points={{-20,32},{-30,32},{-30,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_9.u2, measureBus.Pump_TBA_conferenceroom) annotation (Line(
        points={{-20,40},{-30,40},{-30,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_9.u1, measureBus.Pump_TBA_multipersonoffice) annotation (Line(
        points={{-20,48},{-30,48},{-30,48},{-30,48},{-30,0.1},{-99.9,0.1}},
        color={0,0,127}));
  connect(add3_10.u1, measureBus.Pump_TBA_canteen) annotation (Line(points={{
          -62,-86},{-80,-86},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_10.u2, measureBus.Pump_TBA_workshop) annotation (Line(points={{
          -62,-94},{-80,-94},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(multiSum.u[1], add3_1.y) annotation (Line(points={{38,11.4545},{18,
          11.4545},{18,90},{-39,90}},
                                    color={0,0,127}));
  connect(multiSum.u[2], add3_9.y) annotation (Line(points={{38,9.16364},{18,
          9.16364},{18,8},{18,8},{18,40},{3,40}},
                                         color={0,0,127}));
  connect(multiSum.u[3], add3_2.y) annotation (Line(points={{38,6.87273},{18,
          6.87273},{18,6},{18,6},{18,64},{-39,64}},
                                          color={0,0,127}));
  connect(multiSum.u[4], add3_3.y) annotation (Line(points={{38,4.58182},{18,
          4.58182},{18,2},{18,2},{18,38},{-39,38}},
                                           color={0,0,127}));
  connect(multiSum.u[5], add3_5.y) annotation (Line(points={{38,2.29091},{18,
          2.29091},{18,0},{18,0},{18,12},{-39,12}},
                                           color={0,0,127}));
  connect(multiSum.u[6], add3_6.y) annotation (Line(points={{38,6.66134e-016},{
          18,6.66134e-016},{18,-16},{-39,-16}},
                                      color={0,0,127}));
  connect(multiSum.u[7], add3_7.y) annotation (Line(points={{38,-2.29091},{18,
          -2.29091},{18,-42},{-39,-42}},
                                      color={0,0,127}));
  connect(multiSum.u[8], add3_8.y) annotation (Line(points={{38,-4.58182},{18,
          -4.58182},{18,-68},{-39,-68}},
                               color={0,0,127}));
  connect(multiSum.u[9], add3_10.y) annotation (Line(points={{38,-6.87273},{18,
          -6.87273},{18,-94},{-39,-94}},
                                      color={0,0,127}));
  connect(add3_10.u3, measureBus.InternalLoad_Power) annotation (Line(points={{
          -62,-102},{-80,-102},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(multiSum.y, Sum_Power)
    annotation (Line(points={{77.06,0},{100,0}}, color={0,0,127}));
  connect(multiSum.y, measureBus.Sum_Power) annotation (Line(points={{77.06,0},
          {88,0},{88,108},{-99.9,108},{-99.9,0.1}}, color={0,0,127}));
  connect(add1.u1, measureBus.Fan_RLT) annotation (Line(points={{-18,-24},{-30,
          -24},{-30,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add1.u2, measureBus.Fan_Aircooler) annotation (Line(points={{-18,-36},
          {-30,-36},{-30,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add1.y, multiSum.u[10]) annotation (Line(points={{5,-30},{12,-30},{12,
          -30},{18,-30},{18,-9.16364},{38,-9.16364}}, color={0,0,127}));
  connect(add3_1.u2, measureBus.Heatpump_1_power) annotation (Line(points={{-62,
          90},{-80,90},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_1.u3, measureBus.Heatpump_2_power) annotation (Line(points={{-62,
          82},{-80,82},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_4.y, multiSum.u[11]) annotation (Line(points={{5,-2},{18,-2},{18,
          -12},{18,-12},{18,-12},{18,-11.4545},{38,-11.4545},{38,-11.4545}},
        color={0,0,127}));
  connect(add3_3.u1, measureBus.Pump_generation_hot_power_Boiler) annotation (
      Line(points={{-62,46},{-80,46},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_4.u3, measureBus.PV_Power) annotation (Line(points={{-18,-10},{
          -30,-10},{-30,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_1.u1, measureBus.Pump_Warmwater_power) annotation (Line(points={
          {-62,98},{-80,98},{-80,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_4.u1, measureBus.Pump_Warmwater_heatpump_1_power) annotation (
      Line(points={{-18,6},{-30,6},{-30,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(add3_4.u2, measureBus.Pump_Warmwater_heatpump_2_power) annotation (
      Line(points={{-18,-2},{-30,-2},{-30,0.1},{-99.9,0.1}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Sum_Power;
