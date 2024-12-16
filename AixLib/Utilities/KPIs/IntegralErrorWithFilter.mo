within AixLib.Utilities.KPIs;
model IntegralErrorWithFilter
  "Integral error with filter for only positive or negative errors"
  extends AixLib.Utilities.KPIs.BaseClasses.PartialIntegralError;

  parameter Boolean posFil=true
    "If true, integrate positive errors, else integrate negative errors"
    annotation(choices(checkBox=true));
  Modelica.Blocks.Nonlinear.Limiter lim(uMax=if posFil then Modelica.Constants.inf
         else 0, uMin=if posFil then 0 else -Modelica.Constants.inf)
    "Limiter for error"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Sources.BooleanExpression booExpFil(y=(posFil and dif.y > 0)
         or (not posFil and dif.y < 0))
    "Boolean expression if integration activated"
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput yFil
    "Boolean output signal, if the integration activated"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
equation
  connect(lim.y, intErr.u)
    annotation (Line(points={{1,0},{58,0}}, color={0,0,127}));
  connect(dif.y, lim.u) annotation (Line(points={{-71,60},{-60,60},{-60,0},{-22,
          0}}, color={0,0,127}));
  connect(booExpFil.y, yFil)
    annotation (Line(points={{1,60},{110,60}}, color={255,0,255}));
  annotation (Icon(graphics={Text(
          extent={{-80,80},{80,0}},
          textColor={28,108,200},
          textString="IE"), Text(
          extent={{-80,0},{80,-80}},
          textColor={28,108,200},
          textString=DynamicSelect("+", if posFil then "+" else "-"))}));
end IntegralErrorWithFilter;
