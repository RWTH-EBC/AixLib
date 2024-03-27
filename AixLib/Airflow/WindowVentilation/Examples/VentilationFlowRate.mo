within AixLib.Airflow.WindowVentilation.Examples;
model VentilationFlowRate
  "Use different empirical expressions to determine the window ventilation flow rate"
  extends Modelica.Icons.Example;
  extends Modelica.Icons.UnderConstruction;
  parameter Modelica.Units.SI.Length winClrW = 1.0;
  parameter Modelica.Units.SI.Height winClrH = 1.8;
  OpeningAreas.OpeningAreaSimple openingAreaSimple(winClrW=winClrW, winClrH=
        winClrH)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.Ramp T_i_ramp(
    height=15,
    duration=120,
    offset=15,
    startTime=50)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Modelica.Blocks.Sources.Ramp T_a_ramp(
    height=-40,
    duration=160,
    offset=40,
    startTime=10)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC1
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Sources.CombiTimeTable windSpeed_ctt(table=[0,0; 20,0; 30,5;
        40,0; 50,10; 60,0; 70,20; 80,0; 100,0; 110,20; 120,0; 130,10; 140,0;
        150,5; 160,0; 180,0], columns=2:2)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  OpeningAreas.OpeningAreaSashWidth openingAreaSash(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective)
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));

  Modelica.Blocks.Sources.SawTooth winOpn_sawTooth(amplitude=0.3, period=10)
    "Window opening width"
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  EmpiricalExpressions.WarrenParkins warrenParkins(winClrW=winClrW, winClrH=
        winClrH)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  EmpiricalExpressions.GidsPhaff gidsPhaff(winClrW=winClrW, winClrH=winClrH)
    annotation (Placement(transformation(extent={{80,60},{100,80}})));
  EmpiricalExpressions.Maas maas(winClrW=winClrW, winClrH=winClrH)
    annotation (Placement(transformation(extent={{80,40},{100,60}})));
  EmpiricalExpressions.Hall hall(
    winClrW=winClrW,
    winClrH=winClrH,
    winSashD=0.05)
    annotation (Placement(transformation(extent={{80,20},{100,40}})));
  EmpiricalExpressions.LarsenHeiselberg larsenHeiselberg(
    winClrW=winClrW,
    winClrH=winClrH,
    aziRef=1.5707963267949)
    annotation (Placement(transformation(extent={{80,0},{100,20}})));
  Modelica.Blocks.Sources.Sine windDirection_sine(amplitude=2*Modelica.Constants.pi,
      f=0.05) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  EmpiricalExpressions.Caciolo caciolo(
    winClrW=winClrW,
    winClrH=winClrH,
    aziRef=-1.5707963267949)
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));
equation
  connect(T_i_ramp.y, from_degC.u)
    annotation (Line(points={{-79,90},{-62,90}}, color={0,0,127}));
  connect(T_a_ramp.y, from_degC1.u)
    annotation (Line(points={{-79,50},{-62,50}},   color={0,0,127}));
  connect(winOpn_sawTooth.y, openingAreaSash.s)
    annotation (Line(points={{-79,-70},{-42,-70}}, color={0,0,127}));
  connect(from_degC.y, warrenParkins.T_i) annotation (Line(points={{-39,90},{10,
          90},{10,98},{78,98}}, color={0,0,127}));
  connect(from_degC1.y, warrenParkins.T_a) annotation (Line(points={{-39,50},{0,
          50},{0,94},{78,94}}, color={0,0,127}));
  connect(windSpeed_ctt.y[1], warrenParkins.u_10) annotation (Line(points={{-79,
          10},{-10,10},{-10,88},{78,88}}, color={0,0,127}));
  connect(openingAreaSimple.A, warrenParkins.A) annotation (Line(points={{-79,
          -30},{20,-30},{20,102},{90,102}}, color={0,0,127}));
  connect(gidsPhaff.A, warrenParkins.A) annotation (Line(points={{90,82},{20,82},
          {20,102},{90,102}}, color={0,0,127}));
  connect(gidsPhaff.T_i, warrenParkins.T_i) annotation (Line(points={{78,78},{
          10,78},{10,98},{78,98}}, color={0,0,127}));
  connect(gidsPhaff.T_a, warrenParkins.T_a)
    annotation (Line(points={{78,74},{0,74},{0,94},{78,94}}, color={0,0,127}));
  connect(gidsPhaff.u_10, warrenParkins.u_10) annotation (Line(points={{78,68},
          {-10,68},{-10,88},{78,88}}, color={0,0,127}));
  connect(openingAreaSash.A, maas.A_eff) annotation (Line(points={{-19,-70},{30,
          -70},{30,62},{90,62}}, color={0,0,127}));
  connect(maas.T_i, warrenParkins.T_i) annotation (Line(points={{78,58},{10,58},
          {10,98},{78,98}}, color={0,0,127}));
  connect(maas.T_a, warrenParkins.T_a)
    annotation (Line(points={{78,54},{0,54},{0,94},{78,94}}, color={0,0,127}));
  connect(maas.u_13, warrenParkins.u_10) annotation (Line(points={{78,48},{-10,
          48},{-10,88},{78,88}}, color={0,0,127}));
  connect(winOpn_sawTooth.y, hall.s) annotation (Line(points={{-79,-70},{-60,
          -70},{-60,-40},{40,-40},{40,42},{86,42}}, color={0,0,127}));
  connect(hall.T_i, warrenParkins.T_i) annotation (Line(points={{78,38},{10,38},
          {10,98},{78,98}}, color={0,0,127}));
  connect(hall.T_a, warrenParkins.T_a)
    annotation (Line(points={{78,34},{0,34},{0,94},{78,94}}, color={0,0,127}));
  connect(larsenHeiselberg.A, warrenParkins.A) annotation (Line(points={{90,22},
          {20,22},{20,102},{90,102}}, color={0,0,127}));
  connect(larsenHeiselberg.T_i, warrenParkins.T_i) annotation (Line(points={{78,
          18},{10,18},{10,98},{78,98}}, color={0,0,127}));
  connect(larsenHeiselberg.T_a, warrenParkins.T_a)
    annotation (Line(points={{78,14},{0,14},{0,94},{78,94}}, color={0,0,127}));
  connect(larsenHeiselberg.u_10, warrenParkins.u_10) annotation (Line(points={{
          78,8},{-10,8},{-10,88},{78,88}}, color={0,0,127}));
  connect(windDirection_sine.y, larsenHeiselberg.phi) annotation (Line(points={
          {-59,30},{-20,30},{-20,4},{78,4}}, color={0,0,127}));
  connect(caciolo.A, warrenParkins.A) annotation (Line(points={{90,2},{20,2},{
          20,102},{90,102}}, color={0,0,127}));
  connect(caciolo.T_i, warrenParkins.T_i) annotation (Line(points={{78,-2},{10,
          -2},{10,98},{78,98}}, color={0,0,127}));
  connect(caciolo.T_a, warrenParkins.T_a)
    annotation (Line(points={{78,-6},{0,-6},{0,94},{78,94}}, color={0,0,127}));
  connect(caciolo.u, warrenParkins.u_10) annotation (Line(points={{78,-12},{-10,
          -12},{-10,88},{78,88}}, color={0,0,127}));
  connect(caciolo.phi, larsenHeiselberg.phi) annotation (Line(points={{78,-16},
          {-20,-16},{-20,4},{78,4}}, color={0,0,127}));
  annotation (experiment(
      StopTime=180,
      Interval=0.1,
      __Dymola_Algorithm="Dassl"));
end VentilationFlowRate;
