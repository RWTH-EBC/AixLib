within AixLib.Airflow.WindowVentilation.Examples;
model Test
  extends Modelica.Icons.Example;
  extends Modelica.Icons.UnderConstruction;
  parameter Modelica.Units.SI.Length winClrW = 1.0;
  parameter Modelica.Units.SI.Height winClrH = 1.5;
  EmpiricalExpressions.WarrenParkins warrenParkins(winClrW=winClrW, winClrH=
        winClrH)
    annotation (Placement(transformation(extent={{0,-20},{40,20}})));
  OpeningAreas.OpeningAreaSimple openingAreaSimple(winClrW=winClrW, winClrH=
        winClrH)
    annotation (Placement(transformation(extent={{-40,40},{0,80}})));
  Modelica.Blocks.Sources.Ramp T_i_ramp(
    height=20,
    duration=100,
    offset=15,
    startTime=10)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Ramp T_a_ramp(
    height=-40,
    duration=100,
    offset=40,
    startTime=10)
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC1
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=[0.0,0.0; 10,5; 20,
        0; 30,10; 40,0; 60,0; 70,10; 80,0; 90,5; 100,0; 110,20; 120,0], columns=
       2:2)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  EmpiricalExpressions.Maas maas(winClrW=winClrW, winClrH=winClrH)
    annotation (Placement(transformation(extent={{80,-60},{120,-20}})));
  OpeningAreas.OpeningAreaSash openingAreaSash(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective)
    annotation (Placement(transformation(extent={{40,80},{80,120}})));

  Modelica.Blocks.Sources.SawTooth sawTooth(amplitude=0.5, period=10)
    annotation (Placement(transformation(extent={{-80,100},{-60,120}})));
equation
  connect(openingAreaSimple.A, warrenParkins.A)
    annotation (Line(points={{2,60},{20,60},{20,24}}, color={0,0,127}));
  connect(T_i_ramp.y, from_degC.u)
    annotation (Line(points={{-79,30},{-62,30}}, color={0,0,127}));
  connect(from_degC.y, warrenParkins.T_i) annotation (Line(points={{-39,30},{-20,
          30},{-20,16},{-4,16}}, color={0,0,127}));
  connect(T_a_ramp.y, from_degC1.u)
    annotation (Line(points={{-79,-10},{-62,-10}}, color={0,0,127}));
  connect(from_degC1.y, warrenParkins.T_a) annotation (Line(points={{-39,-10},{-20,
          -10},{-20,8},{-4,8}}, color={0,0,127}));
  connect(combiTimeTable.y[1], warrenParkins.u_10)
    annotation (Line(points={{-79,-50},{-4,-50},{-4,-4}}, color={0,0,127}));
  connect(openingAreaSash.A, maas.A_eff)
    annotation (Line(points={{82,100},{100,100},{100,-16}}, color={0,0,127}));
  connect(from_degC.y, maas.T_i)
    annotation (Line(points={{-39,30},{76,30},{76,-24}}, color={0,0,127}));
  connect(from_degC1.y, maas.T_a) annotation (Line(points={{-39,-10},{-20,-10},
          {-20,-32},{76,-32}}, color={0,0,127}));
  connect(combiTimeTable.y[1], maas.u_13)
    annotation (Line(points={{-79,-50},{76,-50},{76,-44}}, color={0,0,127}));
  connect(sawTooth.y, openingAreaSash.s) annotation (Line(points={{-59,110},{
          -50,110},{-50,100},{36,100}}, color={0,0,127}));
  annotation (experiment(
      StopTime=120,
      Interval=1,
      __Dymola_Algorithm="Dassl"));
end Test;
