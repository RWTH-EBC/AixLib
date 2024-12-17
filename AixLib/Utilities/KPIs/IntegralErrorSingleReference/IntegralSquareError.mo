within AixLib.Utilities.KPIs.IntegralErrorSingleReference;
model IntegralSquareError "Integral square error (ISE)"
  extends AixLib.Utilities.KPIs.BaseClasses.PartialIntegralErrorSingleReference;
  extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Math.Product pro "Square of error"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(swiErr.y, pro.u1)
    annotation (Line(points={{1,0},{10,0},{10,6},{18,6}}, color={0,0,127}));
  connect(swiErr.y, pro.u2)
    annotation (Line(points={{1,0},{10,0},{10,-6},{18,-6}}, color={0,0,127}));
  connect(pro.y, errItg.u)
    annotation (Line(points={{41,0},{58,0}}, color={0,0,127}));
  annotation (Icon(graphics={Text(
          extent={{-80,80},{80,-80}},
          textColor={28,108,200},
          textString="ISE")}), Documentation(revisions="<html>
<ul>
  <li>
    December 17, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1534\">issue 1534</a>)
  </li>
</ul>
</html>"));
end IntegralSquareError;
