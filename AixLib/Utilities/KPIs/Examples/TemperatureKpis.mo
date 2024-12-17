within AixLib.Utilities.KPIs.Examples;
model TemperatureKpis "Test of different temperature KPIs"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Trapezoid traT(
    amplitude=15,
    rising=15,
    width=15,
    falling=15,
    period=60,
    offset=15)
    "Temperature to be assessed"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC "Convert degC to K"
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Modelica.Blocks.Sources.BooleanPulse booPulAct(period=60)
    "Integrator activation set"
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  AixLib.Utilities.KPIs.Temperature.FixedBounds fixBou "Fixed bounds simple"
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  AixLib.Utilities.KPIs.Temperature.FixedBounds fixBouAct(use_itgAct_in=true)
    "Fixed bounds with activation connector"
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  AixLib.Utilities.KPIs.Temperature.FixedBounds fixBouRes(resItgInBou=true)
    "Fixed bounds with reset"
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Temperature.FixedBounds fixBouTim(use_itgTim=true) "Fixed bounds with timers"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Temperature.FixedBounds fixBouTimRes(
    resItgInBou=true,
    use_itgTim=true,
    resItgTimInBou=true) "Fixed bounds with timers, reset when within bounds"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
equation
  connect(traT.y, from_degC.u)
    annotation (Line(points={{-79,90},{-62,90}}, color={0,0,127}));
  connect(from_degC.y, fixBou.T)
    annotation (Line(points={{-39,90},{-22,90}},color={0,0,127}));
  connect(from_degC.y, fixBouAct.T) annotation (Line(points={{-39,90},{-30,90},{
          -30,50},{-22,50}},                color={0,0,127}));
  connect(from_degC.y, fixBouRes.T) annotation (Line(points={{-39,90},{-30,90},{
          -30,10},{-22,10}}, color={0,0,127}));
  connect(booPulAct.y, fixBouAct.itgAct_in) annotation (Line(points={{-79,10},{-40,
          10},{-40,30},{-10,30},{-10,38}}, color={255,0,255}));
  connect(from_degC.y, fixBouTim.T) annotation (Line(points={{-39,90},{-30,90},{
          -30,-30},{-22,-30}}, color={0,0,127}));
  connect(from_degC.y, fixBouTimRes.T) annotation (Line(points={{-39,90},{-30,90},
          {-30,-70},{-22,-70}}, color={0,0,127}));
  annotation (experiment(
      StopTime=120,
      Interval=0.1,
      __Dymola_Algorithm="Dassl"));
end TemperatureKpis;
