within AixLib.Fluid.Examples.ERCBuilding.Control.SupervisoryControl.StateMachine;
model LeaveOperationMode
  "Detects if the heat pump has been switched off for more that 10 minutes"

 Modelica_Synchronous.RealSignals.Sampler.SampleClocked sample_time
    annotation (Placement(transformation(extent={{58,-6},{70,6}})));
public
  Modelica.Blocks.Logical.Not         fallingEdge
    annotation (Placement(transformation(extent={{-58,-7},{-44,7}})));
  Modelica.Blocks.Logical.Timer timer
    annotation (Placement(transformation(extent={{22,-7},{36,7}})));
  Modelica_Synchronous.ClockSignals.Interfaces.ClockInput clock1
    "Output signal y is associated with this clock input"
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}})));
  Modelica.Blocks.Interfaces.BooleanInput HPComand
    "Command to heat pump, 'true' = 'on'" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,70})));
  Modelica.Blocks.Interfaces.BooleanOutput goBackToStart
    "Connector of continuous-time, Boolean output signal"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.BooleanInput measuring annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-70})));
  Modelica_Synchronous.BooleanSignals.Sampler.Hold hold1
    annotation (Placement(transformation(extent={{-70,-76},{-58,-64}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-16,-10},{4,10}})));
equation
  //Leaving an operation mode as soon as the heat pump has been switched off for
  //more than 10 minutes

  if pre(sample_time.y) > 600 then

   goBackToStart = true;

  else

    goBackToStart = false;

  end if;

  connect(timer.y,sample_time. u) annotation (Line(
      points={{36.7,0},{56.8,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sample_time.clock, clock1) annotation (Line(
      points={{64,-7.2},{64,-20},{-100,-20}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5,
      smooth=Smooth.None));
  connect(HPComand, fallingEdge.u) annotation (Line(
      points={{100,70},{-80,70},{-80,0},{-59.4,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(measuring, hold1.u)
    annotation (Line(points={{-100,-70},{-71.2,-70}}, color={255,0,255}));
  connect(and1.y, timer.u) annotation (Line(points={{5,0},{14,0},{14,
          8.88178e-016},{20.6,8.88178e-016}}, color={255,0,255}));
  connect(fallingEdge.y, and1.u1) annotation (Line(points={{-43.3,0},{
          -30.65,0},{-18,0}}, color={255,0,255}));
  connect(hold1.y, and1.u2) annotation (Line(points={{-57.4,-70},{-34,-70},
          {-34,-8},{-18,-8}}, color={255,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end LeaveOperationMode;
