within AixLib.Utilities.KPIs;
model IntegralAbsoluteError "Integral absolute error (IAE)"
  extends AixLib.Utilities.KPIs.BaseClasses.PartialIntegralError;
  Modelica.Blocks.Math.Feedback dif "Difference between u and ref"
    annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
  Modelica.Blocks.Math.Abs abs "Abs value"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Continuous.Integrator intErr "Error integrator"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
equation
  connect(u, dif.u1)
    annotation (Line(points={{-120,60},{-68,60}}, color={0,0,127}));
  connect(ref, dif.u2)
    annotation (Line(points={{-120,-60},{-60,-60},{-60,52}}, color={0,0,127}));
  connect(dif.y, abs.u) annotation (Line(points={{-51,60},{-40,60},{-40,0},{-22,
          0}}, color={0,0,127}));
  connect(abs.y, intErr.u)
    annotation (Line(points={{1,0},{58,0}}, color={0,0,127}));
  connect(intErr.y, y)
    annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
  annotation (Icon(graphics={Text(
          extent={{-80,80},{80,-80}},
          textColor={28,108,200},
          textString="IAE")}));
end IntegralAbsoluteError;
