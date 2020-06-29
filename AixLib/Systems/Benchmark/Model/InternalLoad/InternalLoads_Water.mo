within AixLib.Systems.Benchmark.Model.InternalLoad;
model InternalLoads_Water
  Modelica.Blocks.Math.Gain WaterPerson_OpenPlanOffice(k=0.05/3600)
    annotation (Placement(transformation(extent={{-60,74},{-48,86}})));
  Modelica.Blocks.Math.Gain WaterPerson_MultipersonOffice(k=0.05/3600)
    annotation (Placement(transformation(extent={{-60,34},{-48,46}})));
  Modelica.Blocks.Math.Gain WaterPerson_Conferenceroom(k=0.05/3600)
    annotation (Placement(transformation(extent={{-60,-6},{-48,6}})));
  Modelica.Blocks.Math.Gain WaterPerson_Canteen(k=0.1/3600)
    annotation (Placement(transformation(extent={{-60,-46},{-48,-34}})));
  Modelica.Blocks.Math.Gain WaterPerson_Workshop(k=0.113/3600)
    annotation (Placement(transformation(extent={{-60,-86},{-48,-74}})));
  Modelica.Blocks.Interfaces.RealInput u1[10] "Input signal connector"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Sources.RealExpression FixWater_OpenPlanOffice(y=1.125/3600)
    annotation (Placement(transformation(extent={{-64,48},{-44,68}})));
  Modelica.Blocks.Sources.RealExpression FixWater_MultiPersonOffice(y=0.075/
        3600)
    annotation (Placement(transformation(extent={{-64,10},{-44,30}})));
  Modelica.Blocks.Sources.RealExpression FixWater_Canteen(y=1.25/3600)
    annotation (Placement(transformation(extent={{-64,-70},{-44,-50}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{20,64},{32,76}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{20,24},{32,36}})));
  Modelica.Blocks.Math.Add add3
    annotation (Placement(transformation(extent={{20,-56},{32,-44}})));
  Modelica.Blocks.Interfaces.RealOutput WaterPerRoom[5]
    "Output signal connector"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(WaterPerson_Conferenceroom.u, u1[2]) annotation (Line(points={{-61.2,
          0},{-80,0},{-80,-14},{-100,-14}}, color={0,0,127}));
  connect(WaterPerson_MultipersonOffice.u, u1[3]) annotation (Line(points={{
          -61.2,40},{-80,40},{-80,-10},{-100,-10},{-100,-10}}, color={0,0,127}));
  connect(WaterPerson_OpenPlanOffice.u, u1[1]) annotation (Line(points={{-61.2,
          80},{-80,80},{-80,-18},{-100,-18},{-100,-18}}, color={0,0,127}));
  connect(WaterPerson_Canteen.u, u1[4]) annotation (Line(points={{-61.2,-40},{
          -80,-40},{-80,-6},{-100,-6},{-100,-6}}, color={0,0,127}));
  connect(WaterPerson_Workshop.u, u1[5]) annotation (Line(points={{-61.2,-80},{
          -72,-80},{-72,-80},{-80,-80},{-80,-2},{-100,-2},{-100,-2}}, color={0,
          0,127}));
  connect(WaterPerson_OpenPlanOffice.y, add.u1) annotation (Line(points={{-47.4,
          80},{8,80},{8,73.6},{18.8,73.6}}, color={0,0,127}));
  connect(FixWater_OpenPlanOffice.y, add.u2) annotation (Line(points={{-43,58},
          {8,58},{8,66.4},{18.8,66.4}}, color={0,0,127}));
  connect(WaterPerson_MultipersonOffice.y, add1.u1) annotation (Line(points={{
          -47.4,40},{8,40},{8,33.6},{18.8,33.6}}, color={0,0,127}));
  connect(FixWater_MultiPersonOffice.y, add1.u2) annotation (Line(points={{-43,
          20},{8,20},{8,26.4},{18.8,26.4}}, color={0,0,127}));
  connect(WaterPerson_Canteen.y, add3.u1) annotation (Line(points={{-47.4,-40},
          {8,-40},{8,-46.4},{18.8,-46.4}}, color={0,0,127}));
  connect(FixWater_Canteen.y, add3.u2) annotation (Line(points={{-43,-60},{8,
          -60},{8,-53.6},{18.8,-53.6}}, color={0,0,127}));
  connect(add.y, WaterPerRoom[1]) annotation (Line(points={{32.6,70},{80,70},{
          80,-8},{100,-8}}, color={0,0,127}));
  connect(add1.y, WaterPerRoom[3]) annotation (Line(points={{32.6,30},{80,30},{
          80,0},{100,0}}, color={0,0,127}));
  connect(WaterPerson_Conferenceroom.y, WaterPerRoom[2]) annotation (Line(
        points={{-47.4,0},{80,0},{80,-4},{100,-4}}, color={0,0,127}));
  connect(add3.y, WaterPerRoom[4]) annotation (Line(points={{32.6,-50},{80,-50},
          {80,4},{100,4}}, color={0,0,127}));
  connect(WaterPerson_Workshop.y, WaterPerRoom[5]) annotation (Line(points={{-47.4,
          -80},{80,-80},{80,8},{100,8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{34,98},{96,78}},
          lineColor={28,108,200},
          textString="Parameter nachgucken")}));
end InternalLoads_Water;
