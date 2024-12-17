within AixLib.Utilities.KPIs.Examples;
model EnergyKpis "Test of different energy KPIs"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Pulse Q_flow_pul(
    amplitude=-2,
    period=2,
    offset=1,
    startTime=2) "Pulse value for heat flow"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  AixLib.Utilities.KPIs.Energy.ThermalEnergyMeterDual mtr "Energy meter normal"
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  AixLib.Utilities.KPIs.Energy.ThermalEnergyMeterDual mtrTim(use_itgTim=true)
    "Energy meter with timers"
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
equation
  connect(Q_flow_pul.y, mtr.Q_flow) annotation (Line(points={{-79,0},{-40,0},{-40,
          70},{-2,70}}, color={0,0,127}));
  connect(Q_flow_pul.y, mtrTim.Q_flow) annotation (Line(points={{-79,0},{-40,0},
          {-40,-70},{-2,-70}}, color={0,0,127}));
  annotation (experiment(
      StopTime=10,
      Interval=0.1,
      __Dymola_Algorithm="Dassl"));
end EnergyKpis;
