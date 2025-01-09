within AixLib.Utilities.KPIs.Examples;
model Co2Kpis "Test of different CO2 concentration KPIs"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Trapezoid traCo2Con(
    amplitude=1600,
    rising=15,
    width=15,
    falling=15,
    period=60,
    offset=400) "CO2 concentration to be assessed"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.BooleanPulse booPulAct(period=60)
    "Integrator activation set"
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  IndoorAirQuality.Co2FixedLimit fixBou(
    final use_itgAct_in=false,
    final resItgInBou=false,
    final use_itgTim=false) "Fixed bounds simple"
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  IndoorAirQuality.Co2FixedLimit fixBouAct(
    final use_itgAct_in=true,
    final resItgInBou=false,
    final use_itgTim=false) "Fixed bounds with activation connector"
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  IndoorAirQuality.Co2FixedLimit fixBouRes(
    final use_itgAct_in=false,
    final resItgInBou=true,
    final use_itgTim=false) "Fixed bounds with reset"
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  IndoorAirQuality.Co2FixedLimit fixBouTim(
    final use_itgAct_in=false,
    final resItgInBou=false,
    final use_itgTim=true) "Fixed bounds with timer"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  IndoorAirQuality.Co2FixedLimit fixBouTimRes(
    final use_itgAct_in=false,
    final resItgInBou=true,
    final use_itgTim=true,
    resItgTimInBou=true) "Fixed bounds with timer, reset when within bounds"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  IndoorAirQuality.Co2DIN16798 din16798Tim(use_itgTim=true)
    "DIN EN 16798-1 with timers"
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  IndoorAirQuality.Co2DIN16798 din16798ActTim(use_itgAct_in=true, use_itgTim=
        true) "DIN EN 16798-1 with activation connector and timers"
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
equation
  connect(traCo2Con.y, fixBou.co2Con)
    annotation (Line(points={{-79,90},{-22,90}}, color={0,0,127}));
  connect(traCo2Con.y, fixBouAct.co2Con) annotation (Line(points={{-79,90},{-30,
          90},{-30,50},{-22,50}}, color={0,0,127}));
  connect(booPulAct.y, fixBouAct.itgAct_in) annotation (Line(points={{-79,10},{
          -40,10},{-40,30},{-10,30},{-10,38}}, color={255,0,255}));
  connect(traCo2Con.y, fixBouRes.co2Con) annotation (Line(points={{-79,90},{-30,
          90},{-30,10},{-22,10}}, color={0,0,127}));
  connect(traCo2Con.y, fixBouTim.co2Con) annotation (Line(points={{-79,90},{-30,
          90},{-30,-30},{-22,-30}}, color={0,0,127}));
  connect(traCo2Con.y, fixBouTimRes.co2Con) annotation (Line(points={{-79,90},{
          -30,90},{-30,-70},{-22,-70}}, color={0,0,127}));
  connect(traCo2Con.y, din16798Tim.co2Con) annotation (Line(points={{-79,90},{
          -30,90},{-30,70},{38,70}}, color={0,0,127}));
  connect(booPulAct.y, din16798ActTim.itgAct_in) annotation (Line(points={{-79,
          10},{-40,10},{-40,-10},{50,-10},{50,18}}, color={255,0,255}));
  connect(traCo2Con.y, din16798ActTim.co2Con) annotation (Line(points={{-79,90},
          {-30,90},{-30,70},{30,70},{30,30},{38,30}}, color={0,0,127}));
  annotation (experiment(
      StopTime=120,
      Interval=0.1,
      __Dymola_Algorithm="Dassl"));
end Co2Kpis;
