within AixLib.Utilities.KPIs.Examples;
model EnergyKpis "Test of different energy KPIs"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Pulse pulQ_flow(
    amplitude=-2,
    period=2,
    offset=1,
    startTime=2) "Pulse value for heat flow"
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  AixLib.Utilities.KPIs.Energy.ThermalEnergyMeterDual thmMtr(final use_itgTim=false)
    "Thermal energy meter normal"
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  AixLib.Utilities.KPIs.Energy.ThermalEnergyMeterDual thmMtrTim(final
      use_itgTim=true) "Thermal energy meter with timers"
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Modelica.Blocks.Sources.Pulse pulP(
    amplitude=2,
    period=2,
    startTime=2) "Pulse value for electric power"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  AixLib.Utilities.KPIs.Energy.ElectricityMeter eleMtr(final use_itgTim=false)
    "Electricity meter normal"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  AixLib.Utilities.KPIs.Energy.ElectricityMeter eleMtrTim(final use_itgTim=true)
    "Electricity meter with timer"
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
equation
  connect(pulQ_flow.y, thmMtr.Q_flow) annotation (Line(points={{-79,50},{-40,50},
          {-40,70},{-2,70}}, color={0,0,127}));
  connect(pulQ_flow.y, thmMtrTim.Q_flow) annotation (Line(points={{-79,50},{-40,
          50},{-40,30},{-2,30}}, color={0,0,127}));
  connect(pulP.y, eleMtr.P) annotation (Line(points={{-79,-50},{-40,-50},{-40,-30},
          {-2,-30}}, color={0,0,127}));
  connect(pulP.y, eleMtrTim.P) annotation (Line(points={{-79,-50},{-40,-50},{-40,
          -70},{-2,-70}}, color={0,0,127}));
  annotation (experiment(
      StartTime=0,
      StopTime=10,
      Interval=1,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    Documentation(revisions="<html>
<ul>
  <li>
    January 9, 2025, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1534\">issue 1534</a>)
  </li>
</ul>
</html>", info="<html>
<p>This example checks the models of energy KPIs.</p>
<p>The results represent the differences of thermal meters and electricity meters, with or without timer functions.</p>
</html>"),
    __Dymola_Commands(file="Resources/Scripts/Dymola/Utilities/KPIs/Examples/EnergyKpis.mos"
        "Simulate and plot"));
end EnergyKpis;
