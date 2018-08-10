within AixLib.Fluid.HeatPumps.BaseClasses.HeatPumpControl;
block AntiLegionella "Control to avoid Legionella in the DHW"
  Controls.Interfaces.HeatPumpControlBus sigBusHP
    annotation (Placement(transformation(extent={{-134,-18},{-96,18}})));
  Modelica.Blocks.Interfaces.RealOutput TSet_out
    "Set value for the condenser outlet temperature"
    annotation (Placement(transformation(extent={{100,66},{128,94}})));

  Modelica.Blocks.Sources.Constant constTLegMin(final k=TLegMin)
    "Temperature at which the legionella in DWH dies"
    annotation (Placement(transformation(extent={{-96,-12},{-88,-4}})));
  parameter Modelica.SIunits.Temp_K TLegMin=333.15
    "Temperature at which the legionella in DWH dies";
  Modelica.Blocks.Logical.GreaterEqual
                               TConLessTLegMin
    "Compare if current TCon is smaller than the minimal TLeg"
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{70,72},{84,86}})));
  Modelica.Blocks.Logical.Less lessMaxTimeNoAntLeg
    annotation (Placement(transformation(extent={{76,-8},{90,8}})));
  Modelica.Blocks.Sources.Constant constTimeNoAntLeg(final k=timeNoAntLeg)
    "Maximal time without antilegionella control"
    annotation (Placement(transformation(extent={{48,-30},{62,-16}})));
  parameter Modelica.SIunits.Time timeNoAntLeg
    "Maximal time without antilegionella control";
  Modelica.Blocks.Sources.Constant constMinTimeAntLeg(final k=minTimeAntLeg)
    "Minimal time of legionella controll"
    annotation (Placement(transformation(extent={{-16,-30},{-2,-16}})));
  parameter Modelica.SIunits.Time minTimeAntLeg
    "Minimal duration of antilegionella control";
  Modelica.Blocks.Logical.Timer timeAntiLeg "time in which legionella will die"
    annotation (Placement(transformation(extent={{-24,-10},{-4,10}})));
  Modelica.Blocks.Logical.Less lessMinAntLegTime
    annotation (Placement(transformation(extent={{12,-8},{26,8}})));
  Modelica.Blocks.Interfaces.RealInput TSet_in "Input of TSet"
    annotation (Placement(transformation(extent={{-142,60},{-102,100}})));
  Modelica.Blocks.Logical.Timer timeSinceAntiLeg
    "time since last Antilegionella cycle"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Logical.Pre pre1
    annotation (Placement(transformation(extent={{-44,-6},{-32,6}})));
equation
  connect(constTLegMin.y, TConLessTLegMin.u2) annotation (Line(points={{-87.6,
          -8},{-72,-8}},                    color={0,0,127}));
  connect(switch1.y, TSet_out)
    annotation (Line(points={{84.7,79},{84.7,80},{114,80}}, color={0,0,127}));
  connect(timeAntiLeg.y, lessMinAntLegTime.u1)
    annotation (Line(points={{-3,0},{10.6,0}}, color={0,0,127}));
  connect(constMinTimeAntLeg.y, lessMinAntLegTime.u2) annotation (Line(points={
          {-1.3,-23},{-1.3,-6},{10.6,-6},{10.6,-6.4}}, color={0,0,127}));
  connect(TSet_in, switch1.u1) annotation (Line(points={{-122,80},{-28,80},{-28,
          84.6},{68.6,84.6}}, color={0,0,127}));
  connect(switch1.u3, constTLegMin.y) annotation (Line(points={{68.6,73.4},{-78,
          73.4},{-78,-8},{-87.6,-8}},   color={0,0,127}));
  connect(timeSinceAntiLeg.y, lessMaxTimeNoAntLeg.u1)
    annotation (Line(points={{61,0},{74.6,0}}, color={0,0,127}));
  connect(lessMaxTimeNoAntLeg.y, switch1.u2) annotation (Line(points={{90.7,0},
          {94,0},{94,52},{52,52},{52,79},{68.6,79}}, color={255,0,255}));
  connect(lessMinAntLegTime.y, timeSinceAntiLeg.u)
    annotation (Line(points={{26.7,0},{38,0}}, color={255,0,255}));
  connect(constTimeNoAntLeg.y, lessMaxTimeNoAntLeg.u2) annotation (Line(points=
          {{62.7,-23},{62.7,-14.5},{74.6,-14.5},{74.6,-6.4}}, color={0,0,127}));
  connect(timeAntiLeg.u, pre1.y)
    annotation (Line(points={{-26,0},{-31.4,0}}, color={255,0,255}));
  connect(TConLessTLegMin.y, pre1.u)
    annotation (Line(points={{-49,0},{-45.2,0}}, color={255,0,255}));
  connect(TConLessTLegMin.u1, sigBusHP.T_ret_co) annotation (Line(points={{-72,
          0},{-94,0},{-94,0.09},{-114.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This control Block checks if the current condenser outlet Temperature(TCon) is below a minimal Temperature(TLegMin) at which Legionella die (Typically 60 &deg;C).</p><p>To asure that all Legionella in the DHW-System die, a certain amount of time is needed, in which TCon does not fall below TLegMin.</p><p>As the HP has to kill all Legionella every few days/weeks, the control will only start(set new TSet), when the time since the last complete AntiLegionella-Cycle surpasses the given amount of days/weeks.</p>
</html>"));
end AntiLegionella;
