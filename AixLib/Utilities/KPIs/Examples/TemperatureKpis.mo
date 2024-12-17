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
  AixLib.Utilities.KPIs.Temperature.FixedBounds fixBouTim(use_itgTim=true)
    "Fixed bounds with timers"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  AixLib.Utilities.KPIs.Temperature.FixedBounds fixBouTimRes(
    resItgInBou=true,
    use_itgTim=true,
    resItgTimInBou=true) "Fixed bounds with timers, reset when within bounds"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  AixLib.Utilities.KPIs.Temperature.FlexibleBounds flxBou "Flexible bounds simple"
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Modelica.Blocks.Sources.Constant conLowBou(k=293.15) "Constant lower bound"
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Sources.Constant conUppBou(k=297.15) "Constant upper bound"
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
  AixLib.Utilities.KPIs.Temperature.DIN16798 din16798_1(use_itgTim=true)
                                                        "DIN EN 16798-1"
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  Modelica.Blocks.Sources.Trapezoid traTAmb(
    amplitude=50,
    rising=50,
    width=0,
    falling=50,
    period=110,
    offset=-10,
    startTime=10) "Ambient temperature"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC1
    "Convert degC to K"
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
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
  connect(from_degC.y, flxBou.T) annotation (Line(points={{-39,90},{-30,90},{-30,
          70},{58,70}}, color={0,0,127}));
  connect(conLowBou.y, flxBou.lowBou) annotation (Line(points={{41,50},{50,50},{
          50,64},{58,64}}, color={0,0,127}));
  connect(conUppBou.y, flxBou.uppBou) annotation (Line(points={{41,90},{50,90},{
          50,76},{58,76}}, color={0,0,127}));
  connect(from_degC1.y, din16798_1.TAmb) annotation (Line(points={{-39,-90},{40,
          -90},{40,-24},{58,-24}}, color={0,0,127}));
  connect(from_degC.y, din16798_1.T) annotation (Line(points={{-39,90},{-30,90},
          {-30,-50},{50,-50},{50,-30},{58,-30}}, color={0,0,127}));
  connect(traTAmb.y, from_degC1.u)
    annotation (Line(points={{-79,-90},{-62,-90}}, color={0,0,127}));
  annotation (experiment(
      StopTime=120,
      Interval=0.1,
      __Dymola_Algorithm="Dassl"));
end TemperatureKpis;
