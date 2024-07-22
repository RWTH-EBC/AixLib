within AixLib.Electrical.AC.ThreePhasesBalanced.Sensors.Examples;
model Probe "This example illustrates how to use the probe model"
  extends Modelica.Icons.Example;
  AixLib.Electrical.AC.ThreePhasesBalanced.Loads.Capacitive loaRC(
    mode=AixLib.Electrical.Types.Load.FixedZ_steady_state,
    P_nominal=-10000,
    V_nominal=480) "Constant load"
    annotation (Placement(transformation(extent={{10,0},{30,20}})));
  AixLib.Electrical.AC.ThreePhasesBalanced.Sources.FixedVoltage sou(f=60, V=
        480) "Voltage source"
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  AixLib.Electrical.AC.ThreePhasesBalanced.Lines.TwoPortResistance res1(R=0.1)
    "First line resistance"
    annotation (Placement(transformation(extent={{-26,0},{-6,20}})));
  AixLib.Electrical.AC.ThreePhasesBalanced.Sensors.Probe probe_source(V_nominal=
       480) "Probe that measures at the voltage source"
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  AixLib.Electrical.AC.ThreePhasesBalanced.Sensors.Probe probe_loadRC(V_nominal=
       480) "Probe that measures at the RC load"
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  AixLib.Electrical.AC.ThreePhasesBalanced.Lines.TwoPortResistance res2(R=0.1)
    "Second line resistance"
    annotation (Placement(transformation(extent={{-26,-70},{-6,-50}})));
  AixLib.Electrical.AC.ThreePhasesBalanced.Loads.Inductive loaRL(
    mode=AixLib.Electrical.Types.Load.FixedZ_steady_state,
    P_nominal=-10000,
    V_nominal=480) "Constant load"
    annotation (Placement(transformation(extent={{10,-70},{30,-50}})));
  AixLib.Electrical.AC.ThreePhasesBalanced.Sensors.Probe probe_loadRL(V_nominal=
       480) "Probe that measures at the RL load"
    annotation (Placement(transformation(extent={{-10,-28},{10,-8}})));
equation
  connect(sou.terminal, res1.terminal_n) annotation (Line(
      points={{-40,-20},{-40,10},{-26,10}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(res1.terminal_p, loaRC.terminal) annotation (Line(
      points={{-6,10},{10,10}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(sou.terminal, probe_source.term) annotation (Line(
      points={{-40,-20},{-40,31}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(loaRC.terminal, probe_loadRC.term) annotation (Line(
      points={{10,10},{6.66134e-16,10},{6.66134e-16,31}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(sou.terminal, res2.terminal_n) annotation (Line(
      points={{-40,-20},{-40,-60},{-26,-60}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(res2.terminal_p, loaRL.terminal) annotation (Line(
      points={{-6,-60},{10,-60}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(loaRL.terminal, probe_loadRL.term) annotation (Line(
      points={{10,-60},{6.66134e-16,-60},{6.66134e-16,-27}},
      color={0,120,120},
      smooth=Smooth.None));
  annotation (experiment(StopTime=1.0, Tolerance=1e-6),
  Documentation(
  info="<html>
<p>
This example illustrates the use of the probe model.
</p>
</html>",
revisions="<html>
<ul>
<li>
August 5, 2014, by Marco Bonvini:<br/>
Revised model and documentation.
</li>
<li>
June 6, 2014, by Marco Bonvini:<br/>
First implementation.
</li>
</ul>
</html>"),
__Dymola_Commands(file=
          "modelica://AixLib/Resources/Scripts/Dymola/Electrical/AC/ThreePhasesBalanced/Sensors/Examples/Probe.mos"
        "Simulate and plot"));
end Probe;
