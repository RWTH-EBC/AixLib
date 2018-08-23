within AixLib.Fluid.HeatPumps.BaseClasses.HeatPumpControl;
block HPControl
  "Control block which makes sure the desired temperature is supplied by the HP"
  AntiLegionella antiLegionella if useAntilegionella
    annotation (Placement(transformation(extent={{-22,-40},{18,0}})));
  Controls.Interfaces.HeatPumpControlBus sigBusHP
    annotation (Placement(transformation(extent={{-116,-72},{-88,-44}})));
  Modelica.Blocks.Interfaces.RealOutput nOut
    annotation (Placement(transformation(extent={{100,-14},{128,14}})));
  Modelica.Blocks.Interfaces.RealInput T_oda "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-142,0},{-102,40}})));
  parameter Boolean useAntilegionella
    "True if Legionella Control is of relevance";
  Modelica.Blocks.Sources.BooleanPulse modePulse(width=50, period=2000)
    "Just to check how bus systems work"
    annotation (Placement(transformation(extent={{-10,-94},{-30,-74}})));
  Controls.HeatPump.HeatingCurve heatCurve(
    use_dynTRoom=false,
    use_tableData=true,
    heatingCurveRecord=
        DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day25_Night10(),
    declination=1.2,
    TRoom_nominal=293.15,
    zerTim=AixLib.Utilities.Time.Types.ZeroTime.NY2017,
    day_hour=6,
    night_hour=22)
    annotation (Placement(transformation(extent={{-66,4},{-46,24}})));
  TSetToNSet tSetToNSet
    annotation (Placement(transformation(extent={{44,-24},{74,6}})));
equation

  connect(antiLegionella.sigBusHP, sigBusHP) annotation (Line(
      points={{-25,-20},{-36,-20},{-36,-58},{-102,-58}},
      color={255,204,51},
      thickness=0.5));
  connect(modePulse.y, sigBusHP.mode) annotation (Line(points={{-31,-84},{-80,
          -84},{-80,-57.93},{-101.93,-57.93}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(T_oda, sigBusHP.T_oda) annotation (Line(points={{-122,20},{-90,20},{
          -90,-57.93},{-101.93,-57.93}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(T_oda, heatCurve.T_oda) annotation (Line(points={{-122,20},{-80,20},{
          -80,14},{-68,14}}, color={0,0,127}));
  connect(heatCurve.TSet, antiLegionella.TSet_in) annotation (Line(points={{-45,
          14},{-34,14},{-34,-4},{-26.4,-4}}, color={0,0,127}));
  connect(tSetToNSet.nOut, nOut) annotation (Line(points={{75.5,-9},{85.75,-9},
          {85.75,1.77636e-15},{114,1.77636e-15}}, color={0,0,127}));
  connect(tSetToNSet.TSet, antiLegionella.TSet_out) annotation (Line(points={{
          41.75,-2.85},{41.75,-3.425},{20.8,-3.425},{20.8,-4}}, color={0,0,127}));
  connect(sigBusHP, tSetToNSet.sigBusHP) annotation (Line(
      points={{-102,-58},{34,-58},{34,-12.75},{42.35,-12.75}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HPControl;
