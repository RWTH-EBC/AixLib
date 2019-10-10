within AixLib.Systems.Benchmark.Model.InternalLoad;
model InternalLoadsPower_new
  Modelica.Blocks.Math.Gain Met_OpenPlanOffice(k=1.2*1.8*58)
    annotation (Placement(transformation(extent={{-14,84},{-2,96}})));
  Modelica.Blocks.Math.Gain Met_Workshop(k=2*1.8*58)
    annotation (Placement(transformation(extent={{-14,8},{-2,20}})));
  Modelica.Blocks.Math.Gain PowerEquiment_OpenPlanOffice(k=50)
    annotation (Placement(transformation(extent={{-42,74},{-30,86}})));
  Modelica.Blocks.Math.Gain PowerEquiment_Workshop(k=200)
    annotation (Placement(transformation(extent={{-42,-2},{-30,10}})));
  Modelica.Blocks.Math.Gain PowerEquiment_Cooking(k=213)
    annotation (Placement(transformation(extent={{-42,18},{-30,30}})));
  Modelica.Blocks.Math.Gain Met_MultiPersonOffice(k=1.2*1.8*58)
    annotation (Placement(transformation(extent={{-14,66},{-2,78}})));
  Modelica.Blocks.Math.Gain Met_Conferenceroom(k=1.2*1.8*58)
    annotation (Placement(transformation(extent={{-14,48},{-2,60}})));
  Modelica.Blocks.Math.Gain Met_Canteen(k=1.2*1.8*58)
    annotation (Placement(transformation(extent={{-14,28},{-2,40}})));
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
  Modelica.Blocks.Math.MultiSum multiSum(nu=10, k={1,1,1,1,1,1,1,1,1,1})
    annotation (Placement(transformation(extent={{60,6},{72,18}})));
  Modelica.Blocks.Interfaces.RealInput u1[10] "Input signal connector"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput Power_Sum
    annotation (Placement(transformation(extent={{90,2},{110,22}})));
equation
  connect(PowerEquiment_OpenPlanOffice.u,u1 [1]) annotation (Line(points={{
          -43.2,80},{-60,80},{-60,-18},{-100,-18}}, color={0,0,127}));
  connect(Met_OpenPlanOffice.u,u1 [1]) annotation (Line(points={{-15.2,90},{-60,
          90},{-60,-18},{-100,-18}}, color={0,0,127}));
  connect(Met_MultiPersonOffice.u,u1 [3]) annotation (Line(points={{-15.2,72},{
          -60,72},{-60,-10},{-100,-10}}, color={0,0,127}));
  connect(PowerEquiment_MultiPersonOffice.u,u1 [3]) annotation (Line(points={{
          -43.2,62},{-60,62},{-60,-10},{-100,-10}}, color={0,0,127}));
  connect(Met_Conferenceroom.u,u1 [2]) annotation (Line(points={{-15.2,54},{-60,
          54},{-60,-14},{-100,-14}}, color={0,0,127}));
  connect(PowerEquiment_Conferenceroom.u,u1 [2]) annotation (Line(points={{
          -43.2,44},{-60,44},{-60,-14},{-100,-14}}, color={0,0,127}));
  connect(Met_Canteen.u,u1 [4]) annotation (Line(points={{-15.2,34},{-60,34},{
          -60,-6},{-100,-6}}, color={0,0,127}));
  connect(PowerEquiment_Cooking.u,u1 [4]) annotation (Line(points={{-43.2,24},{
          -60,24},{-60,-6},{-100,-6}}, color={0,0,127}));
  connect(Met_Workshop.u,u1 [5]) annotation (Line(points={{-15.2,14},{-60,14},{
          -60,-2},{-100,-2}}, color={0,0,127}));
  connect(PowerEquiment_Workshop.u,u1 [5]) annotation (Line(points={{-43.2,4},{
          -60,4},{-60,-2},{-100,-2}}, color={0,0,127}));
  connect(Light_OpenPlanOffice.u,u1 [6]) annotation (Line(points={{-43.2,-16},{
          -60,-16},{-60,2},{-100,2}}, color={0,0,127}));
  connect(Light_MultipersonOffice.u,u1 [8]) annotation (Line(points={{-43.2,-34},
          {-52,-34},{-52,-34},{-60,-34},{-60,10},{-100,10}}, color={0,0,127}));
  connect(Light_Conferenceroom.u,u1 [7]) annotation (Line(points={{-43.2,-52},{
          -60,-52},{-60,6},{-100,6}}, color={0,0,127}));
  connect(Light_Canteen.u,u1 [9]) annotation (Line(points={{-43.2,-70},{-60,-70},
          {-60,14},{-100,14}}, color={0,0,127}));
  connect(Light_Workshop.u,u1 [10]) annotation (Line(points={{-43.2,-88},{-60,
          -88},{-60,18},{-100,18}}, color={0,0,127}));
  connect(multiSum.y,Power_Sum)
    annotation (Line(points={{73.02,12},{100,12}},   color={0,0,127}));
  connect(PowerEquiment_Workshop.y,multiSum. u[1]) annotation (Line(points={{-29.4,4},
          {20,4},{20,15.78},{60,15.78}},                            color={0,0,
          127}));
  connect(PowerEquiment_Cooking.y,multiSum. u[2]) annotation (Line(points={{-29.4,
          24},{20,24},{20,14.94},{60,14.94}},                           color={
          0,0,127}));
  connect(PowerEquiment_Conferenceroom.y,multiSum. u[3]) annotation (Line(
        points={{-29.4,44},{20,44},{20,14.1},{60,14.1}},
        color={0,0,127}));
  connect(PowerEquiment_MultiPersonOffice.y,multiSum. u[4]) annotation (Line(
        points={{-29.4,62},{20,62},{20,13.26},{60,13.26}},
        color={0,0,127}));
  connect(PowerEquiment_OpenPlanOffice.y,multiSum. u[5])  annotation (Line(
        points={{-29.4,80},{20,80},{20,12.42},{60,12.42}},
        color={0,0,127}));
  connect(Light_OpenPlanOffice.y,multiSum. u[6]) annotation (Line(points={{-29.4,
          -16},{8,-16},{8,-62},{32,-62},{32,11.58},{60,11.58}},         color={
          0,0,127}));
  connect(Light_MultipersonOffice.y,multiSum. u[7]) annotation (Line(points={{-29.4,
          -34},{8,-34},{8,-64},{32,-64},{32,10.74},{60,10.74}},         color={
          0,0,127}));
  connect(Light_Conferenceroom.y,multiSum. u[8]) annotation (Line(points={{-29.4,
          -52},{8,-52},{8,-64},{32,-64},{32,9.9},{60,9.9}},           color={0,
          0,127}));
  connect(Light_Canteen.y,multiSum. u[9]) annotation (Line(points={{-29.4,-70},
          {20,-70},{20,9.06},{60,9.06}},     color={0,0,127}));
  connect(Light_Workshop.y,multiSum. u[10]) annotation (Line(points={{-29.4,-88},
          {22,-88},{22,8.22},{60,8.22}},     color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end InternalLoadsPower_new;
