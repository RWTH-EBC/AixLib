within AixLib.Fluid.HeatPumps.BaseClasses.HeatPumpControl;
block HPControl
  "Control block which makes sure the desired temperature is supplied by the HP"
  AntiLegionella antiLegionella if useAntilegionella
    annotation (Placement(transformation(extent={{-22,-14},{18,26}})));
  Controls.Interfaces.HeatPumpControlBus sigBusHP
    annotation (Placement(transformation(extent={{-116,-72},{-88,-44}})));
  Modelica.Blocks.Interfaces.RealOutput nOut
    annotation (Placement(transformation(extent={{100,-14},{128,14}})));
  Modelica.Blocks.Interfaces.RealInput T_oda "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  parameter Boolean useAntilegionella
    "True if Legionella Control is of relevance";
  Controls.HeatPump.HeatingCurve heatCurve(
    use_dynTRoom=false,
    use_tableData=true,
    heatingCurveRecord=DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day25_Night10(),
    zerTim=AixLib.Utilities.Time.Types.ZeroTime.NY2017,
    day_hour=6,
    night_hour=22,
    declination=1.2,
    redeclare function HeatingCurveFunction =
        Controls.HeatPump.BaseClasses.HeatingCurveFunction,
    n=0,
    m=0,
    TRoom_nominal=293.15) annotation (Placement(transformation(extent={{-74,10},
            {-54,30}})));

  replaceable model TSetToNSet =
      AixLib.Fluid.HeatPumps.BaseClasses.HeatPumpControl.OnOffHP                            constrainedby
    AixLib.Fluid.HeatPumps.BaseClasses.HeatPumpControl.BaseClasses.partialTSetToNSet
                                                                                                                                                                               annotation(choicesAllMatching=true);

  TSetToNSet ConvTSetNSet(
    use_secHeaGen=false,
    hys=5,
    use_bivPar=true)      annotation (Placement(transformation(extent={{44,-10},
            {76,24}})));
  Modelica.Blocks.Routing.RealPassThrough realPasThrAntiLeg if not
    useAntilegionella "No Anti Legionella" annotation (Placement(transformation(
          extent={{-8,44},{8,60}})), choicesAllMatching=true);
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{-148,-66},{-128,-46}})));
equation

  connect(T_oda, sigBusHP.T_oda) annotation (Line(points={{-120,20},{-90,20},{-90,-57.93},{-101.93,-57.93}},
                                         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(T_oda, heatCurve.T_oda) annotation (Line(points={{-120,20},{-76,20}}, color={0,0,127}));
  connect(heatCurve.TSet, antiLegionella.TSet_in) annotation (Line(points={{-53,20},
          {-38,20},{-38,22.8},{-26,22.8}},                                                       color={0,0,127},

      pattern=LinePattern.Dash));
  connect(antiLegionella.TSet_out, ConvTSetNSet.TSet) annotation (Line(
      points={{20.8,22},{26,22},{26,17.2},{41.44,17.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(ConvTSetNSet.nOut, nOut) annotation (Line(points={{77.6,7},{88.8,7},{
          88.8,1.77636e-15},{114,1.77636e-15}}, color={0,0,127}));
  connect(sigBusHP, ConvTSetNSet.sigBusHP) annotation (Line(
      points={{-102,-58},{24,-58},{24,2.41},{42.88,2.41}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.T_ret_co, ConvTSetNSet.TAct) annotation (Line(
      points={{-101.93,-57.93},{24,-57.93},{24,-6.6},{41.44,-6.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatCurve.TSet, realPasThrAntiLeg.u) annotation (Line(
      points={{-53,20},{-46,20},{-46,52},{-9.6,52}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(realPasThrAntiLeg.y, ConvTSetNSet.TSet) annotation (Line(
      points={{8.8,52},{26,52},{26,17.2},{41.44,17.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(booleanConstant.y, sigBusHP.mode) annotation (Line(points={{-127,-56},
          {-116,-56},{-116,-57.93},{-101.93,-57.93}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sigBusHP.T_ret_co, antiLegionella.TSupAct) annotation (Line(
      points={{-101.93,-57.93},{-66,-57.93},{-66,6},{-26,6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                            Rectangle(
          extent={{-84,85.5},{91.5,-82.5}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillPattern=FillPattern.Solid,
          fillColor={255,255,170})}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HPControl;
