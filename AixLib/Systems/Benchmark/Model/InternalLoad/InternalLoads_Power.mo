within AixLib.Systems.Benchmark.Model.InternalLoad;
model InternalLoads_Power
  Modelica.Blocks.Math.Gain Met_OpenPlanOffice(k=1.2*1.8*58)
    annotation (Placement(transformation(extent={{-14,84},{-2,96}})));
  Modelica.Blocks.Math.Gain Met_Workshop(k=2*1.8*58)
    annotation (Placement(transformation(extent={{-14,8},{-2,20}})));
  Modelica.Blocks.Math.Gain PowerEquiment_OpenPlanOffice(k=50)
    annotation (Placement(transformation(extent={{-42,74},{-30,86}})));
  Modelica.Blocks.Math.Gain PowerEquiment_Workshop(k=200)
    annotation (Placement(transformation(extent={{-42,-2},{-30,10}})));
  Modelica.Blocks.Math.Add3 add3_1
    annotation (Placement(transformation(extent={{28,30},{40,42}})));
  Modelica.Blocks.Math.Gain PowerEquiment_Cooking(k=213)
    annotation (Placement(transformation(extent={{-42,18},{-30,30}})));
  Modelica.Blocks.Interfaces.RealInput u1[10] "Input signal connector"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Math.Gain Met_MultiPersonOffice(k=1.2*1.8*58)
    annotation (Placement(transformation(extent={{-14,66},{-2,78}})));
  Modelica.Blocks.Math.Gain Met_Conferenceroom(k=1.2*1.8*58)
    annotation (Placement(transformation(extent={{-14,48},{-2,60}})));
  Modelica.Blocks.Math.Gain Met_Canteen(k=1.2*1.8*58)
    annotation (Placement(transformation(extent={{-14,28},{-2,40}})));
  Modelica.Blocks.Math.Add3 add3_2
    annotation (Placement(transformation(extent={{28,12},{40,24}})));
  Modelica.Blocks.Math.Add3 add3_3
    annotation (Placement(transformation(extent={{28,-6},{40,6}})));
  Modelica.Blocks.Math.Add3 add3_4
    annotation (Placement(transformation(extent={{28,-26},{40,-14}})));
  Modelica.Blocks.Math.Add3 add3_5
    annotation (Placement(transformation(extent={{28,-46},{40,-34}})));
  Modelica.Blocks.Math.Gain PowerEquiment_MultiPersonOffice(k=50)
    annotation (Placement(transformation(extent={{-42,56},{-30,68}})));
  Modelica.Blocks.Math.Gain PowerEquiment_Conferenceroom(k=20)
    annotation (Placement(transformation(extent={{-42,38},{-30,50}})));
  Modelica.Blocks.Math.Gain Light_OpenPlanOffice(k=4737)
    annotation (Placement(transformation(extent={{-42,-22},{-30,-10}})));
  Modelica.Blocks.Math.Gain Light_MultipersonOffice(k=421)
    annotation (Placement(transformation(extent={{-42,-40},{-30,-28}})));
  Modelica.Blocks.Math.Gain Light_Conferenceroom(k=210)
    annotation (Placement(transformation(extent={{-42,-58},{-30,-46}})));
  Modelica.Blocks.Math.Gain Light_Canteen(k=5684)
    annotation (Placement(transformation(extent={{-42,-76},{-30,-64}})));
  Modelica.Blocks.Math.Gain Light_Workshop(k=2210)
    annotation (Placement(transformation(extent={{-42,-94},{-30,-82}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow[5]
    annotation (Placement(transformation(extent={{54,-10},{74,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b AddPower[5]
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Math.MultiSum multiSum(               nu=10, k={1,1,1,1,1,1,1,
        1,1,1})
    annotation (Placement(transformation(extent={{54,-68},{66,-56}})));
  Modelica.Blocks.Interfaces.RealOutput Power_Sum
    annotation (Placement(transformation(extent={{90,-72},{110,-52}})));
equation
  connect(Met_OpenPlanOffice.y, add3_1.u1) annotation (Line(points={{-1.4,90},{
          20,90},{20,40.8},{26.8,40.8}}, color={0,0,127}));
  connect(Met_MultiPersonOffice.y, add3_2.u1) annotation (Line(points={{-1.4,72},
          {20,72},{20,22.8},{26.8,22.8}}, color={0,0,127}));
  connect(Met_Conferenceroom.y, add3_3.u1) annotation (Line(points={{-1.4,54},{
          20,54},{20,4.8},{26.8,4.8}}, color={0,0,127}));
  connect(Met_Canteen.y, add3_4.u1) annotation (Line(points={{-1.4,34},{20,34},
          {20,-15.2},{26.8,-15.2}}, color={0,0,127}));
  connect(Met_Workshop.y, add3_5.u1) annotation (Line(points={{-1.4,14},{20,14},
          {20,-35.2},{26.8,-35.2}}, color={0,0,127}));
  connect(PowerEquiment_OpenPlanOffice.u, u1[1]) annotation (Line(points={{
          -43.2,80},{-60,80},{-60,-18},{-100,-18}}, color={0,0,127}));
  connect(Met_OpenPlanOffice.u, u1[1]) annotation (Line(points={{-15.2,90},{-60,
          90},{-60,-18},{-100,-18}}, color={0,0,127}));
  connect(Met_MultiPersonOffice.u, u1[3]) annotation (Line(points={{-15.2,72},{
          -60,72},{-60,-10},{-100,-10}}, color={0,0,127}));
  connect(PowerEquiment_MultiPersonOffice.u, u1[3]) annotation (Line(points={{
          -43.2,62},{-60,62},{-60,-10},{-100,-10}}, color={0,0,127}));
  connect(Met_Conferenceroom.u, u1[2]) annotation (Line(points={{-15.2,54},{-60,
          54},{-60,-14},{-100,-14}}, color={0,0,127}));
  connect(PowerEquiment_Conferenceroom.u, u1[2]) annotation (Line(points={{
          -43.2,44},{-60,44},{-60,-14},{-100,-14}}, color={0,0,127}));
  connect(Met_Canteen.u, u1[4]) annotation (Line(points={{-15.2,34},{-60,34},{
          -60,-6},{-100,-6}}, color={0,0,127}));
  connect(PowerEquiment_Cooking.u, u1[4]) annotation (Line(points={{-43.2,24},{
          -60,24},{-60,-6},{-100,-6}}, color={0,0,127}));
  connect(Met_Workshop.u, u1[5]) annotation (Line(points={{-15.2,14},{-60,14},{
          -60,-2},{-100,-2}}, color={0,0,127}));
  connect(PowerEquiment_Workshop.u, u1[5]) annotation (Line(points={{-43.2,4},{
          -60,4},{-60,-2},{-100,-2}}, color={0,0,127}));
  connect(PowerEquiment_OpenPlanOffice.y, add3_1.u3) annotation (Line(points={{
          -29.4,80},{20,80},{20,32},{26,32},{26,32},{26,31.2},{26.8,31.2}},
        color={0,0,127}));
  connect(PowerEquiment_MultiPersonOffice.y, add3_2.u3) annotation (Line(points=
         {{-29.4,62},{20,62},{20,14},{24,14},{24,13.2},{26.8,13.2}}, color={0,0,
          127}));
  connect(PowerEquiment_Conferenceroom.y, add3_3.u3) annotation (Line(points={{
          -29.4,44},{20,44},{20,-4},{24,-4},{24,-4.8},{26.8,-4.8}}, color={0,0,
          127}));
  connect(PowerEquiment_Cooking.y, add3_4.u3) annotation (Line(points={{-29.4,
          24},{20,24},{20,-24},{24,-24},{24,-24.8},{26.8,-24.8}}, color={0,0,
          127}));
  connect(PowerEquiment_Workshop.y, add3_5.u3) annotation (Line(points={{-29.4,4},
          {20,4},{20,-44},{24,-44},{24,-44.8},{26.8,-44.8}},    color={0,0,127}));
  connect(Light_OpenPlanOffice.u, u1[6]) annotation (Line(points={{-43.2,-16},{
          -60,-16},{-60,2},{-100,2}}, color={0,0,127}));
  connect(Light_MultipersonOffice.u, u1[8]) annotation (Line(points={{-43.2,-34},
          {-52,-34},{-52,-34},{-60,-34},{-60,10},{-100,10}}, color={0,0,127}));
  connect(Light_Conferenceroom.u, u1[7]) annotation (Line(points={{-43.2,-52},{
          -60,-52},{-60,6},{-100,6}}, color={0,0,127}));
  connect(Light_Canteen.u, u1[9]) annotation (Line(points={{-43.2,-70},{-60,-70},
          {-60,14},{-100,14}}, color={0,0,127}));
  connect(Light_Workshop.u, u1[10]) annotation (Line(points={{-43.2,-88},{-60,
          -88},{-60,18},{-100,18}}, color={0,0,127}));
  connect(add3_1.y, prescribedHeatFlow[1].Q_flow) annotation (Line(points={{
          40.6,36},{46,36},{46,0},{54,0}}, color={0,0,127}));
  connect(add3_2.y, prescribedHeatFlow[3].Q_flow) annotation (Line(points={{
          40.6,18},{46,18},{46,0},{54,0}}, color={0,0,127}));
  connect(add3_3.y, prescribedHeatFlow[2].Q_flow)
    annotation (Line(points={{40.6,0},{54,0}}, color={0,0,127}));
  connect(add3_4.y, prescribedHeatFlow[4].Q_flow) annotation (Line(points={{
          40.6,-20},{46,-20},{46,0},{54,0}}, color={0,0,127}));
  connect(add3_5.y, prescribedHeatFlow[5].Q_flow) annotation (Line(points={{
          40.6,-40},{46,-40},{46,0},{54,0}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, AddPower)
    annotation (Line(points={{74,0},{100,0}}, color={191,0,0}));
  connect(multiSum.y, Power_Sum)
    annotation (Line(points={{67.02,-62},{100,-62}}, color={0,0,127}));
  connect(PowerEquiment_Workshop.y, multiSum.u[1]) annotation (Line(points={{-29.4,4},
          {-14,4},{-14,4},{20,4},{20,-58.22},{54,-58.22}},          color={0,0,
          127}));
  connect(PowerEquiment_Cooking.y, multiSum.u[2]) annotation (Line(points={{-29.4,
          24},{-10,24},{-10,24},{20,24},{20,-59.06},{54,-59.06}},       color={
          0,0,127}));
  connect(PowerEquiment_Conferenceroom.y, multiSum.u[3]) annotation (Line(
        points={{-29.4,44},{-10,44},{-10,44},{20,44},{20,-59.9},{54,-59.9}},
        color={0,0,127}));
  connect(PowerEquiment_MultiPersonOffice.y, multiSum.u[4]) annotation (Line(
        points={{-29.4,62},{-10,62},{-10,62},{20,62},{20,-60.74},{54,-60.74}},
        color={0,0,127}));
  connect(PowerEquiment_OpenPlanOffice.y, multiSum.u[5])  annotation (Line(
        points={{-29.4,80},{-10,80},{-10,80},{20,80},{20,-61.58},{54,-61.58}},
        color={0,0,127}));
  connect(Light_OpenPlanOffice.y, add3_1.u2) annotation (Line(points={{-29.4,
          -16},{8,-16},{8,36},{26.8,36}}, color={0,0,127}));
  connect(Light_MultipersonOffice.y, add3_2.u2) annotation (Line(points={{-29.4,
          -34},{8,-34},{8,18},{26.8,18}}, color={0,0,127}));
  connect(Light_Conferenceroom.y, add3_3.u2) annotation (Line(points={{-29.4,
          -52},{-12,-52},{-12,-52},{8,-52},{8,0},{26.8,0}}, color={0,0,127}));
  connect(Light_Canteen.y, add3_4.u2) annotation (Line(points={{-29.4,-70},{-10,
          -70},{-10,-70},{8,-70},{8,-20},{26.8,-20}}, color={0,0,127}));
  connect(Light_Workshop.y, add3_5.u2) annotation (Line(points={{-29.4,-88},{8,
          -88},{8,-40},{26.8,-40}}, color={0,0,127}));
  connect(Light_OpenPlanOffice.y, multiSum.u[6]) annotation (Line(points={{
          -29.4,-16},{8,-16},{8,-62},{32,-62},{32,-62.42},{54,-62.42}}, color={
          0,0,127}));
  connect(Light_MultipersonOffice.y, multiSum.u[7]) annotation (Line(points={{
          -29.4,-34},{8,-34},{8,-64},{32,-64},{32,-63.26},{54,-63.26}}, color={
          0,0,127}));
  connect(Light_Conferenceroom.y, multiSum.u[8]) annotation (Line(points={{
          -29.4,-52},{8,-52},{8,-64},{32,-64},{32,-64.1},{54,-64.1}}, color={0,
          0,127}));
  connect(Light_Canteen.y, multiSum.u[9]) annotation (Line(points={{-29.4,-70},
          {20,-70},{20,-64.94},{54,-64.94}}, color={0,0,127}));
  connect(Light_Workshop.y, multiSum.u[10]) annotation (Line(points={{-29.4,-88},
          {22,-88},{22,-65.78},{54,-65.78}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end InternalLoads_Power;
