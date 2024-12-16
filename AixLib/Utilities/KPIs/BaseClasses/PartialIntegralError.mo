within AixLib.Utilities.KPIs.BaseClasses;
partial model PartialIntegralError "Partial model for integral error"
  extends Modelica.Blocks.Icons.Block;

  parameter Boolean use_reset = false "If true, reset port enabled"
    annotation(choices(checkBox=true));
  Modelica.Blocks.Interfaces.RealInput u "Real input signal"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput ref "Real reference signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput y "Output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.BooleanInput reset if use_reset
    "Conditional connector of reset signal" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Math.Feedback dif "Difference between u and ref"
    annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
  Modelica.Blocks.Continuous.Integrator intErr(use_reset=use_reset)
    "Error integrator"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
equation
  connect(u, dif.u1)
    annotation (Line(points={{-120,60},{-88,60}}, color={0,0,127}));
  connect(ref, dif.u2)
    annotation (Line(points={{-120,-60},{-80,-60},{-80,52}}, color={0,0,127}));
  connect(intErr.y, y)
    annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
  connect(intErr.reset, reset) annotation (Line(points={{76,-12},{76,-100},{0,-100},
          {0,-120}}, color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash, if use_reset then
          LinePattern.Solid else LinePattern.Dash)));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialIntegralError;
