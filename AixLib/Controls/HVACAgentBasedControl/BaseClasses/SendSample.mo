within AixLib.Controls.HVACAgentBasedControl.BaseClasses;
model SendSample

  Modelica.Blocks.MathBoolean.Or or1(nu=4)
    annotation (Placement(transformation(extent={{52,-6},{64,6}})));
  Modelica.Blocks.MathBoolean.OnDelay onDelay4(delayTime=0.1)
    annotation (Placement(transformation(extent={{-64,-4},{-56,4}})));
  Modelica.Blocks.MathBoolean.OnDelay onDelay5(delayTime=0.2)
    annotation (Placement(transformation(extent={{-38,-4},{-30,4}})));
  Modelica.Blocks.MathBoolean.OnDelay onDelay6(delayTime=0.5)
    annotation (Placement(transformation(extent={{-16,-4},{-8,4}})));
  Modelica.Blocks.MathBoolean.OnDelay onDelay7(delayTime=1)
    annotation (Placement(transformation(extent={{10,-4},{18,4}})));
  Modelica.Blocks.Interfaces.BooleanInput u
    "Input connected to boolean output of UDPSend_adapted"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    "Output connected to sendOut of PartialAgent"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Logical.Edge edge1
    annotation (Placement(transformation(extent={{-54,-40},{-46,-32}})));
  Modelica.Blocks.Logical.Edge edge2
    annotation (Placement(transformation(extent={{-26,-40},{-18,-32}})));
  Modelica.Blocks.Logical.Edge edge3
    annotation (Placement(transformation(extent={{-2,-40},{6,-32}})));
  Modelica.Blocks.Logical.Edge edge4
    annotation (Placement(transformation(extent={{24,-40},{32,-32}})));
equation
  connect(onDelay4.u, u)
    annotation (Line(points={{-65.6,0},{-100,0}}, color={255,0,255}));
  connect(or1.y, y) annotation (Line(points={{64.9,0},{100,0},{100,0}},
        color={255,0,255}));
  connect(edge1.u, onDelay4.y) annotation (Line(points={{-54.8,-36},{-55.2,
          -36},{-55.2,0}}, color={255,0,255}));
  connect(onDelay5.y, edge2.u) annotation (Line(points={{-29.2,0},{-28,0},{
          -28,-34},{-28,-36},{-26.8,-36}}, color={255,0,255}));
  connect(onDelay6.y, edge3.u) annotation (Line(points={{-7.2,0},{-2.8,0},{
          -2.8,-36}}, color={255,0,255}));
  connect(onDelay7.y, edge4.u) annotation (Line(points={{18.8,0},{20,0},{20,
          -36},{23.2,-36}}, color={255,0,255}));
  connect(onDelay5.u, u) annotation (Line(points={{-39.6,0},{-40,0},{-40,10},
          {-76,10},{-76,0},{-100,0}}, color={255,0,255}));
  connect(onDelay6.u, u) annotation (Line(points={{-17.6,0},{-18,0},{-18,10},
          {-76,10},{-76,0},{-100,0}}, color={255,0,255}));
  connect(onDelay7.u, u) annotation (Line(points={{8.4,0},{8,0},{8,10},{-76,
          10},{-76,0},{-100,0}}, color={255,0,255}));
  connect(edge1.y, or1.u[1]) annotation (Line(points={{-45.6,-36},{-42,-36},
          {-42,-54},{52,-54},{52,3.15}}, color={255,0,255}));
  connect(edge2.y, or1.u[2]) annotation (Line(points={{-17.6,-36},{-14,-36},
          {-14,-54},{52,-54},{52,1.05}}, color={255,0,255}));
  connect(edge3.y, or1.u[3]) annotation (Line(points={{6.4,-36},{12,-36},{
          12,-54},{52,-54},{52,-1.05}}, color={255,0,255}));
  connect(edge4.y, or1.u[4]) annotation (Line(points={{32.4,-36},{38,-36},{
          38,-54},{52,-54},{52,-3.15}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-54,36},{54,-36}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
        Line(
          points={{54,-36},{10,4}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-54,-36},{-10,4}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{54,36},{0,-4}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-54,36},{0,-4}},
          color={0,0,0},
          thickness=0.5)}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><h4>
  <span style=\"color: #008000;\">Overview</span>
</h4>
<ul>
  <li>This model creates a burst of Boolean singals (on-off-on-off) at
  a rising edge on the input
  </li>
  <li>It is used by the PartialAgent when \"usePoke=true\" is selected
  </li>
</ul>
<h4>
  <span style=\"color: #008000;\">Concept</span>
</h4>
<p>
  The model simulates a trigger, which is only active for a certain
  period of time, thus not creating events throughout the whole
  simulation time.
</p>
</html>",
    revisions="<html><ul>
  <li>November 2016: Developed and implemented by Felix Bünning
  </li>
</ul>
</html>"));
end SendSample;
