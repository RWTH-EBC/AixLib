within AixLib.Utilities.KPIs.BaseClasses;
partial model PartialIntegralErrorSingleReference
  "Partial model for integral error with single reference value"
  extends AixLib.Utilities.KPIs.BaseClasses.PartialIntegratorBase;
  Modelica.Blocks.Interfaces.RealInput u "Value input"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput ref "Reference value input"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Math.Feedback dif "Difference between u and ref"
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Logical.Switch swiErr "Switch for error"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Sources.Constant conZero(final k=0) "Constant 0"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Continuous.Integrator errItg(final use_reset=use_itgRes_in)
    "Error integrator"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
equation
  connect(u, dif.u1)
    annotation (Line(points={{-120,0},{-88,0}}, color={0,0,127}));
  connect(ref, dif.u2)
    annotation (Line(points={{-120,-60},{-80,-60},{-80,-8}}, color={0,0,127}));
  connect(dif.y, swiErr.u1) annotation (Line(points={{-71,0},{-40,0},{-40,8},{-22,
          8}}, color={0,0,127}));
  connect(conZero.y, swiErr.u3) annotation (Line(points={{-39,-30},{-30,-30},{-30,
          -8},{-22,-8}}, color={0,0,127}));
  connect(errItg.y, y)
    annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
  connect(itgRes_in, errItg.reset) annotation (Line(
      points={{60,-120},{60,-100},{76,-100},{76,-12}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgRes_in then LinePattern.Solid else LinePattern.Dash)));
  connect(booExpItgAct.y, swiErr.u2) annotation (Line(points={{-79,90},{-30,90},
          {-30,0},{-22,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
    December 17, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1534\">issue 1534</a>)
  </li>
</ul>
</html>", info="<html>
<p>This partial model is the base model of error integrators related to single reference.</p>
</html>"));
end PartialIntegralErrorSingleReference;
