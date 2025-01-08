within AixLib.Utilities.KPIs.IntegralErrorSingleReference;
model IntegralErrorBySign
  "Integral error by sign (either only positive or only negative errors)"
  extends AixLib.Utilities.KPIs.BaseClasses.PartialIntegralErrorSingleReference;
  extends Modelica.Blocks.Icons.Block;
  parameter Boolean posItg=true
    "= true, integrate positive errors, = false integrate negative errors"
    annotation(choices(checkBox=true));
  Modelica.Blocks.Nonlinear.Limiter lim(
    final uMax=if posItg then Modelica.Constants.inf else 0,
    final uMin=if posItg then 0 else -Modelica.Constants.inf)
    "Limiter for error"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.BooleanExpression booExpIsAct(
    final y=(posItg and dif.y > 0) or (not posItg and dif.y < 0))
    "Boolean expression if integrator is activated"
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Interfaces.BooleanOutput isItgAct
    "If the integrator is activated"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Logical.And and1 "And logic"
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
equation
  connect(swiErr.y, lim.u)
    annotation (Line(points={{1,0},{18,0}}, color={0,0,127}));
  connect(lim.y, errItg.u)
    annotation (Line(points={{41,0},{58,0}}, color={0,0,127}));
  connect(booExpItgAct.y, and1.u1) annotation (Line(points={{-79,90},{50,90},{50,
          60},{58,60}}, color={255,0,255}));
  connect(booExpIsAct.y, and1.u2) annotation (Line(points={{41,50},{50,50},{50,52},
          {58,52}}, color={255,0,255}));
  connect(and1.y, isItgAct)
    annotation (Line(points={{81,60},{110,60}}, color={255,0,255}));
  annotation (Icon(graphics={Text(
          extent={{-80,80},{80,0}},
          textColor={28,108,200},
          textString="IE"), Text(
          extent={{-80,0},{80,-80}},
          textColor={28,108,200},
          textString=DynamicSelect("+", if posItg then "+" else "-"))}),
      Documentation(revisions="<html>
<ul>
  <li>
    December 17, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1534\">issue 1534</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model is a sign-based integrator, which allows for the integration of errors only when they are greater than or less than zero.</p>
</html>"));
end IntegralErrorBySign;
