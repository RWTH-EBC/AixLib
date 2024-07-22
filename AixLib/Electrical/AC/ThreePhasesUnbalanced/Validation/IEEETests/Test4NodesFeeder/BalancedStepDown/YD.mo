within AixLib.Electrical.AC.ThreePhasesUnbalanced.Validation.IEEETests.Test4NodesFeeder.BalancedStepDown;
model YD
  "IEEE 4 node test feeder model with balanced load and Y - D connection (step down)"
  extends
    AixLib.Electrical.AC.ThreePhasesUnbalanced.Validation.IEEETests.Test4NodesFeeder.BaseClasses.IEEE4(
    final line1_use_Z_y=true,
    final line2_use_Z_y=false,
    redeclare AixLib.Electrical.AC.ThreePhasesUnbalanced.Sensors.ProbeWye
      node1,
    redeclare AixLib.Electrical.AC.ThreePhasesUnbalanced.Sensors.ProbeWye
      node2,
    redeclare AixLib.Electrical.AC.ThreePhasesUnbalanced.Sensors.ProbeDelta
      node3,
    redeclare AixLib.Electrical.AC.ThreePhasesUnbalanced.Sensors.ProbeDelta
      node4,
    final VLL_side1=12.47e3,
    final VLL_side2=4.16e3,
    final VARbase=6000e3,
    final V2_ref={7113,7132,7123},
    final V3_ref={3906,3915,3909},
    final V4_ref={3437,3497,3388},
    final Theta2_ref=Modelica.Constants.pi/180.0*{-0.3,-120.3,119.6},
    final Theta3_ref=Modelica.Constants.pi/180.0*{-3.5,-123.6,116.3},
    final Theta4_ref=Modelica.Constants.pi/180.0*{-7.8,-129.3,110.6},
    loadRL(use_pf_in=false, loadConn=AixLib.Electrical.Types.LoadConnection.wye_to_delta));
  Modelica.Blocks.Sources.Constant load(k=-1800e3)
    annotation (Placement(transformation(extent={{54,62},{74,82}})));
  AixLib.Electrical.AC.ThreePhasesUnbalanced.Conversion.ACACTransformerStepDownYD
    transformer(
    VHigh=VLL_side1,
    VLow=VLL_side2,
    XoverR=6,
    Zperc=sqrt(0.01^2 + 0.06^2),
    VABase=VARbase,
    conv1(
      terminal_p(i(start={-477, 327})),
      V1(start={7000, -400})))
    annotation (Placement(transformation(extent={{-26,0},{-6,20}})));
equation
  connect(load.y, loadRL.Pow1) annotation (Line(
      points={{75,72},{90,72},{90,18},{76,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(load.y, loadRL.Pow2) annotation (Line(
      points={{75,72},{90,72},{90,10},{76,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(load.y, loadRL.Pow3) annotation (Line(
      points={{75,72},{90,72},{90,2},{76,2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(line1.terminal_p, transformer.terminal_n) annotation (Line(
      points={{-48,10},{-26,10}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(transformer.terminal_p, line2.terminal_n) annotation (Line(
      points={{-6,10},{12,10}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(node1.term, line1.terminal_n) annotation (Line(
      points={{-74,29},{-74,10},{-68,10}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(node2.term, transformer.terminal_n) annotation (Line(
      points={{-42,29},{-42,10},{-40,10},{-40,10},{-26,10}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(node3.term, line2.terminal_n) annotation (Line(
      points={{6,29},{6,10},{12,10}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(node4.term, loadRL.terminal) annotation (Line(
      points={{38,29},{38,10},{54,10}},
      color={0,120,120},
      smooth=Smooth.None));
  annotation (experiment(StopTime=1.0, Tolerance=1e-6),
  __Dymola_Commands(file=
          "modelica://AixLib/Resources/Scripts/Dymola/Electrical/AC/ThreePhasesUnbalanced/Validation/IEEETests/Test4NodesFeeder/BalancedStepDown/YD.mos"
        "Simulate and plot"),
 Documentation(revisions="<html>
<ul>
<li>
December 22, 2016, by Michael Wetter:<br/>
Set start values for Dymola 2017FD01.
</li>
<li>
October 9, 2014, by Marco Bonvini:<br/>
Added documentation.
</li>
<li>
June 17, 2014, by Marco Bonvini:<br/>
Moved to Examples IEEE package.
</li>
<li>
June 6, 2014, by Marco Bonvini:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
IEEE 4 nodes validation test case with the following characteristics
</p>
<ul>
<li>balanced load,
  <ul>
  <li>power consumption on each phase <i>P<sub>1,2,3</sub> = 1800 kW</i></li>
  <li>power factor on each phase <i>cos&phi;<sub>1,2,3</sub> = 0.9</i></li>
  </ul>
</li>
<li>voltage step-down transformer (<i>V<sub>Pri</sub>=12.47 kV</i>,
<i>V<sub>Sec</sub> = 4.16kV</i>),</li>
<li>Y-D transformer</li>
</ul>
</html>"));
end YD;
