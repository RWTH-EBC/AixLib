within AixLib.Airflow.WindowVentilation.Examples;
model VentilationFlowRateSashOpening
  "Use different empirical expressions to determine the window ventilation flow rate by sash opening"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialExampleVentilationFlowRate;
  extends Modelica.Icons.UnderConstruction;

  EmpiricalExpressions.WarrenParkins warrenParkins(
    winClrW=winClrW,
    winClrH=winClrH,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashWidth (
          opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
          opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric))
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Sources.SawTooth sawTooth_winOpnW(amplitude=0.3, period=10)
    "Window opening width"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  EmpiricalExpressions.Maas maas(winClrW=winClrW, winClrH=winClrH)
    annotation (Placement(transformation(extent={{80,40},{100,60}})));
  Utilities.WindProfilePowerLaw windProfilePowerLaw(hei=13, heiRef=10)
    annotation (Placement(transformation(extent={{60,40},{70,50}})));
  EmpiricalExpressions.Hall hall(
    winClrW=winClrW,
    winClrH=winClrH,
    winSashD=0.001)
    annotation (Placement(transformation(extent={{80,0},{100,20}})));
  EmpiricalExpressions.Jiang jiang(winClrW=winClrW, winClrH=winClrH)
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
  Modelica.Blocks.Sources.Ramp ramp_dp(
    height=20,
    duration=160,
    offset=-10,
    startTime=10)
    annotation (Placement(transformation(extent={{40,-100},{60,-80}})));
equation
  connect(from_degC_i.y, warrenParkins.T_i) annotation (Line(points={{-39,90},{
          -30,90},{-30,98},{78,98}}, color={0,0,127}));
  connect(from_degC_a.y, warrenParkins.T_a) annotation (Line(points={{-39,60},{
          -20,60},{-20,94},{78,94}}, color={0,0,127}));
  connect(windSpeed_ctt.y[1], warrenParkins.u_10) annotation (Line(points={{-79,
          30},{-10,30},{-10,88},{78,88}}, color={0,0,127}));
  connect(sawTooth_winOpnW.y, warrenParkins.u) annotation (Line(points={{-79,
          -90},{20,-90},{20,102},{90,102}}, color={0,0,127}));
  connect(from_degC_i.y, maas.T_i) annotation (Line(points={{-39,90},{-30,90},{
          -30,58},{78,58}}, color={0,0,127}));
  connect(from_degC_a.y, maas.T_a) annotation (Line(points={{-39,60},{-20,60},{
          -20,54},{78,54}}, color={0,0,127}));
  connect(windSpeed_ctt.y[1], windProfilePowerLaw.u_r) annotation (Line(points=
          {{-79,30},{-10,30},{-10,45},{59,45}}, color={0,0,127}));
  connect(windProfilePowerLaw.u, maas.u_13)
    annotation (Line(points={{70.5,45},{78,45},{78,48}}, color={0,0,127}));
  connect(sawTooth_winOpnW.y, maas.u) annotation (Line(points={{-79,-90},{20,
          -90},{20,62},{90,62}}, color={0,0,127}));
  connect(from_degC_i.y, hall.T_i) annotation (Line(points={{-39,90},{-30,90},{
          -30,18},{78,18}}, color={0,0,127}));
  connect(from_degC_a.y, hall.T_a) annotation (Line(points={{-39,60},{-20,60},{
          -20,14},{78,14}}, color={0,0,127}));
  connect(sawTooth_winOpnW.y, hall.u) annotation (Line(points={{-79,-90},{20,
          -90},{20,22},{90,22}}, color={0,0,127}));
  connect(ramp_dp.y, jiang.dp)
    annotation (Line(points={{61,-90},{78,-90}}, color={0,0,127}));
  connect(sawTooth_winOpnW.y, jiang.u) annotation (Line(points={{-79,-90},{20,
          -90},{20,-78},{90,-78}}, color={0,0,127}));
end VentilationFlowRateSashOpening;
