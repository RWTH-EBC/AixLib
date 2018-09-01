within AixLib.Controls.HeatPump;
block HPControl
  "Control block which makes sure the desired temperature is supplied by the HP"
  AixLib.Controls.HeatPump.AntiLegionella antiLegionella(
    trigWeekDay=5,
    trigHour=3,
    TLegMin=373.15) if use_antLeg
    annotation (Placement(transformation(extent={{-26,-14},{14,26}})));
  Controls.Interfaces.HeatPumpControlBus sigBusHP
    annotation (Placement(transformation(extent={{-116,-72},{-88,-44}})));
  Modelica.Blocks.Interfaces.RealOutput nOut
    annotation (Placement(transformation(extent={{100,6},{128,34}})));
  Modelica.Blocks.Interfaces.RealInput T_oda "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-128,-14},{-100,14}}),
        iconTransformation(extent={{-140,-26},{-100,14}})));
  parameter Boolean use_antLeg "True if Legionella Control is of relevance";
  Controls.HeatPump.HeatingCurve heatCurve(
    use_dynTRoom=false,
    heatingCurveRecord=DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day25_Night10(),
    zerTim=AixLib.Utilities.Time.Types.ZeroTime.NY2017,
    day_hour=6,
    night_hour=22,
    redeclare function HeatingCurveFunction =
        Controls.HeatPump.BaseClasses.Functions.HeatingCurveFunction,
    n=0,
    m=0,
    use_tableData=true,
    declination=2,
    TRoom_nominal=293.15) annotation (Placement(transformation(extent={{-74,10},
            {-54,30}})));

  replaceable model TSetToNSet =
      AixLib.Controls.HeatPump.BaseClasses.OnOffHP constrainedby
    AixLib.Controls.HeatPump.BaseClasses.partialTSetToNSet                                                                                                                     annotation(choicesAllMatching=true);

  TSetToNSet ConvTSetNSet(
    use_secHeaGen=use_secHeaGen,
    use_bivPar=use_bivPar,
    hys=hys)              annotation (Placement(transformation(extent={{44,-10},
            {76,24}})));
  Modelica.Blocks.Routing.RealPassThrough realPasThrAntLeg "No Anti Legionella"
                                           annotation (
                                     choicesAllMatching=true, Placement(
        transformation(extent={{-10,38},{6,54}})));
  Modelica.Blocks.Sources.BooleanConstant constHeating(final k=true)
    "If you want to include chilling, please insert control blocks first"
    annotation (Placement(transformation(extent={{58,-44},{78,-24}})));
  Modelica.Blocks.Interfaces.BooleanOutput modeOut
    annotation (Placement(transformation(extent={{100,-34},{128,-6}})));
  Modelica.Blocks.Interfaces.RealInput TSup "Supply temperature" annotation (
      Placement(transformation(extent={{-128,46},{-100,74}}),
        iconTransformation(extent={{-140,34},{-100,74}})));
  parameter Boolean use_secHeaGen=false "True to choose a bivalent system" annotation(choices(checkBox=true));
  parameter Boolean use_bivPar=true
    "Switch between bivalent parallel and bivalent alternative control" annotation(choices(choice=true "Parallel",
      choice=false "Alternativ",
      radioButtons=true));
  parameter Real hys=5 "Hysteresis of controller";
  Modelica.Blocks.Interfaces.RealOutput ySecHeaGen if use_secHeaGen
                                                   "Relative power of second heat generator, from 0 to 1"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,110})));
equation

  connect(T_oda, sigBusHP.T_oda) annotation (Line(points={{-114,1.77636e-15},{-90,
          1.77636e-15},{-90,-57.93},{-101.93,-57.93}},
                                         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(T_oda, heatCurve.T_oda) annotation (Line(points={{-114,1.77636e-15},{-98,
          1.77636e-15},{-98,20},{-76,20}},                                      color={0,0,127}));
  connect(heatCurve.TSet, antiLegionella.TSet_in) annotation (Line(points={{-53,20},
          {-38,20},{-38,22.8},{-30,22.8}},                                                       color={0,0,127},
      pattern=LinePattern.Dash));

  connect(antiLegionella.TSet_out, ConvTSetNSet.TSet) annotation (Line(
      points={{16.8,22},{26,22},{26,17.2},{41.44,17.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(ConvTSetNSet.nOut, nOut) annotation (Line(points={{77.6,7},{88.8,7},{
          88.8,20},{114,20}}, color={0,0,127}));
  connect(sigBusHP, ConvTSetNSet.sigBusHP) annotation (Line(
      points={{-102,-58},{24,-58},{24,2.41},{42.88,2.41}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatCurve.TSet, realPasThrAntLeg.u) annotation (Line(
      points={{-53,20},{-46,20},{-46,46},{-11.6,46}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(realPasThrAntLeg.y, ConvTSetNSet.TSet) annotation (Line(
      points={{6.8,46},{26,46},{26,17.2},{41.44,17.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(modeOut, constHeating.y) annotation (Line(points={{114,-20},{96,-20},
          {96,-34},{79,-34}}, color={255,0,255}));
  connect(TSup, antiLegionella.TSupAct) annotation (Line(points={{-114,60},{-82,
          60},{-82,6},{-30,6}}, color={0,0,127}));
  connect(TSup, ConvTSetNSet.TAct) annotation (Line(points={{-114,60},{-82,60},{
          -82,-22},{30,-22},{30,-6.6},{41.44,-6.6}}, color={0,0,127}));
  connect(ConvTSetNSet.ySecHeaGen, ySecHeaGen) annotation (Line(
      points={{60,25.7},{60,90},{0,90},{0,110},{0,110}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                            Rectangle(
          extent={{-84,85.5},{91.5,-82.5}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillPattern=FillPattern.Solid,
          fillColor={255,255,170}),
        Text(
          extent={{-104,86},{106,62}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HPControl;
