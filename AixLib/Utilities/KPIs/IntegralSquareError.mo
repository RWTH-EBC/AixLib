within AixLib.Utilities.KPIs;
model IntegralSquareError "Integral square error (ISE)"
  extends AixLib.Utilities.KPIs.BaseClasses.PartialIntegralError(
  final use_reset=false);
  Modelica.Blocks.Math.Product pro "Square of error"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
equation
  connect(dif.y, pro.u1) annotation (Line(points={{-71,60},{-60,60},{-60,0},{
          -40,0},{-40,6},{-22,6}}, color={0,0,127}));
  connect(dif.y, pro.u2) annotation (Line(points={{-71,60},{-60,60},{-60,0},{
          -40,0},{-40,-6},{-22,-6}}, color={0,0,127}));
  connect(pro.y, intErr.u)
    annotation (Line(points={{1,0},{58,0}}, color={0,0,127}));
  annotation (Icon(graphics={Text(
          extent={{-80,80},{80,-80}},
          textColor={28,108,200},
          textString="ISE")}));
end IntegralSquareError;
