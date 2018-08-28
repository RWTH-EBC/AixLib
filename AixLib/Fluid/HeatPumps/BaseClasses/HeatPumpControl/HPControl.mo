within AixLib.Fluid.HeatPumps.BaseClasses.HeatPumpControl;
block HPControl
  "Control block which makes sure the desired temperature is supplied by the HP"
  AntiLegionella antiLegionella if useAntilegionella
    annotation (Placement(transformation(extent={{-26,-16},{14,24}})));
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
    declination=1.8,
    TRoom_nominal=293.15) annotation (Placement(transformation(extent={{-66,10},
            {-46,30}})));

  replaceable model TSetToNSet =
      AixLib.Fluid.HeatPumps.BaseClasses.HeatPumpControl.OnOffHP                            constrainedby
    AixLib.Fluid.HeatPumps.BaseClasses.HeatPumpControl.BaseClasses.partialTSetToNSet
                                                                                                                                                                               annotation(choicesAllMatching=true);

  TSetToNSet ConvTSetNSet(use_secHeaGen=true)
                          annotation (Placement(transformation(extent={{40,-4},{72,30}})));
equation

  connect(antiLegionella.sigBusHP, sigBusHP) annotation (Line(
      points={{-29,4},{-36,4},{-36,-58},{-102,-58}},
      color={255,204,51},
      thickness=0.5));
  connect(T_oda, sigBusHP.T_oda) annotation (Line(points={{-120,20},{-90,20},{-90,-57.93},{-101.93,-57.93}},
                                         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(T_oda, heatCurve.T_oda) annotation (Line(points={{-120,20},{-68,20}}, color={0,0,127}));
  connect(heatCurve.TSet, antiLegionella.TSet_in) annotation (Line(points={{-45,20},
          {-38,20},{-38,20.8},{-30,20.8}},                                                       color={0,0,127}));
  connect(tSetToNSet.nOut, nOut) annotation (Line(points={{73.6,13},{85.75,13},{85.75,1.77636e-15},{114,1.77636e-15}}, color={0,0,127}));
  connect(tSetToNSet.TSet, antiLegionella.TSet_out) annotation (Line(points={{37.6,19.97},{37.6,20.575},{16.8,20.575},{16.8,20}}, color={0,0,127}));
  connect(sigBusHP, tSetToNSet.sigBusHP) annotation (Line(
      points={{-102,-58},{34,-58},{34,8.75},{38.56,8.75}},
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
