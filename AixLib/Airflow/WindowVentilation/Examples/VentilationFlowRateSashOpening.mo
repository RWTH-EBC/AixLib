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
    annotation (Placement(transformation(extent={{80,50},{100,70}})));
  Utilities.WindProfilePowerLaw windProfilePowerLaw(hei=13)
    annotation (Placement(transformation(extent={{60,50},{70,60}})));
  EmpiricalExpressions.Hall hall(
    winClrW=winClrW,
    winClrH=winClrH,
    winSashD=0.001)
    annotation (Placement(transformation(extent={{80,20},{100,40}})));
  EmpiricalExpressions.Jiang jiang(winClrW=winClrW, winClrH=winClrH)
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
  Modelica.Blocks.Sources.Ramp ramp_dp(
    height=20,
    duration=160,
    offset=-10,
    startTime=10)
    annotation (Placement(transformation(extent={{40,-100},{60,-80}})));
  EmpiricalExpressions.VDI2078 vDI2078_1(
    winClrW=winClrW,
    winClrH=winClrH,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashVDI2078 (
          winSashD=0.001))
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{70,-20},{80,-10}})));
  EmpiricalExpressions.DIN16798 dIN16798_1(winClrW=winClrW, winClrH=winClrH)
    annotation (Placement(transformation(extent={{80,-50},{100,-30}})));
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
          -30,68},{78,68}}, color={0,0,127}));
  connect(from_degC_a.y, maas.T_a) annotation (Line(points={{-39,60},{-20,60},{
          -20,64},{78,64}}, color={0,0,127}));
  connect(windSpeed_ctt.y[1], windProfilePowerLaw.u_r) annotation (Line(points={{-79,30},
          {-10,30},{-10,55},{59,55}},           color={0,0,127}));
  connect(windProfilePowerLaw.u, maas.u_13)
    annotation (Line(points={{70.5,55},{78,55},{78,58}}, color={0,0,127}));
  connect(sawTooth_winOpnW.y, maas.u) annotation (Line(points={{-79,-90},{20,
          -90},{20,72},{90,72}}, color={0,0,127}));
  connect(from_degC_i.y, hall.T_i) annotation (Line(points={{-39,90},{-30,90},{
          -30,38},{78,38}}, color={0,0,127}));
  connect(from_degC_a.y, hall.T_a) annotation (Line(points={{-39,60},{-20,60},{
          -20,34},{78,34}}, color={0,0,127}));
  connect(sawTooth_winOpnW.y, hall.u) annotation (Line(points={{-79,-90},{20,
          -90},{20,42},{90,42}}, color={0,0,127}));
  connect(ramp_dp.y, jiang.dp)
    annotation (Line(points={{61,-90},{78,-90}}, color={0,0,127}));
  connect(sawTooth_winOpnW.y, jiang.u) annotation (Line(points={{-79,-90},{20,
          -90},{20,-78},{90,-78}}, color={0,0,127}));
  connect(sawTooth_winOpnW.y, vDI2078_1.u) annotation (Line(points={{-79,-90},{
          20,-90},{20,12},{90,12}}, color={0,0,127}));
  connect(from_degC_i.y, vDI2078_1.T_i) annotation (Line(points={{-39,90},{-30,
          90},{-30,8},{78,8}}, color={0,0,127}));
  connect(from_degC_a.y, vDI2078_1.T_a) annotation (Line(points={{-39,60},{-20,
          60},{-20,4},{78,4}}, color={0,0,127}));
  connect(const.y, vDI2078_1.C_ss)
    annotation (Line(points={{80.5,-15},{90,-15},{90,-12}}, color={0,0,127}));
  connect(from_degC_i.y, dIN16798_1.T_i) annotation (Line(points={{-39,90},{-30,
          90},{-30,-32},{78,-32}}, color={0,0,127}));
  connect(from_degC_a.y, dIN16798_1.T_a) annotation (Line(points={{-39,60},{-20,
          60},{-20,-36},{78,-36}}, color={0,0,127}));
  connect(windSpeed_ctt.y[1], dIN16798_1.u_10) annotation (Line(points={{-79,30},
          {-10,30},{-10,-42},{78,-42}}, color={0,0,127}));
  connect(sawTooth_winOpnW.y, dIN16798_1.u) annotation (Line(points={{-79,-90},
          {20,-90},{20,-28},{90,-28}}, color={0,0,127}));
end VentilationFlowRateSashOpening;
