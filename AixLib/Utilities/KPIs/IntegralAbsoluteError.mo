within AixLib.Utilities.KPIs;
model IntegralAbsoluteError "Integral absolute error (IAE)"
  extends AixLib.Utilities.KPIs.BaseClasses.PartialIntegralError(
  final use_reset=false);
  Modelica.Blocks.Math.Abs abs "Abs value"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
equation
  connect(dif.y, abs.u) annotation (Line(points={{-71,60},{-60,60},{-60,0},{-22,
          0}}, color={0,0,127}));
  connect(abs.y, intErr.u)
    annotation (Line(points={{1,0},{58,0}}, color={0,0,127}));
  annotation (Icon(graphics={Text(
          extent={{-80,80},{80,-80}},
          textColor={28,108,200},
          textString="IAE")}));
end IntegralAbsoluteError;
