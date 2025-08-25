within AixLib.Utilities.KPIs.IntegralErrorSingleReference;
model IntegralAbsoluteError "Integral absolute error (IAE)"
  extends AixLib.Utilities.KPIs.BaseClasses.PartialIntegralErrorSingleReference;
  extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Math.Abs abs "Abs value"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(swiErr.y, abs.u)
    annotation (Line(points={{1,0},{18,0}}, color={0,0,127}));
  connect(abs.y, errItg.u)
    annotation (Line(points={{41,0},{58,0}}, color={0,0,127}));
  annotation (Icon(graphics={Text(
          extent={{-80,80},{80,-80}},
          textColor={28,108,200},
          textString="IAE")}), Documentation(revisions="<html>
<ul>
  <li>
    December 17, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1534\">issue 1534</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model is an integrator for absolute error (IAE).</p>
</html>"));
end IntegralAbsoluteError;
