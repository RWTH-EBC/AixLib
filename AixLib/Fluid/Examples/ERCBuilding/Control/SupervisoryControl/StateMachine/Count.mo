within AixLib.Fluid.Examples.ERCBuilding.Control.SupervisoryControl.StateMachine;
model Count
  Modelica.Blocks.Interfaces.BooleanInput u annotation (Placement(
        transformation(extent={{-120,50},{-80,90}})));
  Modelica_Synchronous.ClockSignals.Interfaces.ClockInput u1
    annotation (Placement(transformation(extent={{-120,10},{-80,50}})));
  Modelica_Synchronous.BooleanSignals.Sampler.Hold hold1 annotation (
      Placement(transformation(extent={{14,64},{26,76}})));
  Modelica.Blocks.Logical.Timer timer annotation (Placement(
        transformation(extent={{36,60},{56,80}})));
  Modelica_Synchronous.RealSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{64,64},{76,76}})));
  Modelica.Blocks.Interfaces.RealOutput Time
    annotation (Placement(transformation(extent={{90,60},{110,80}})));
equation
  connect(hold1.y, timer.u) annotation (Line(
      points={{26.6,70},{34,70}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(timer.y, sample1.u) annotation (Line(
      points={{57,70},{62.8,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(u1, sample1.clock) annotation (Line(
      points={{-100,30},{70,30},{70,62.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5,
      smooth=Smooth.None));
  connect(sample1.y, Time) annotation (Line(
      points={{76.6,70},{100,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(u, hold1.u) annotation (Line(points={{-100,70},{12.8,70},{12.8,70}},
        color={255,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})));
end Count;
