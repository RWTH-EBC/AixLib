within AixLib.Utilities.KPIs.BaseClasses;
partial model PartialAssessmentBase
  "Base model for value assessment with conditional inputs for activation, reset, and timer"
  parameter Boolean use_itgAct_in=false
    "= true, enable activation connector; = false, disable connector, integrator continuously activated"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean resItgInBou=false
    "= true, integrators will be reset if the input value within bounds"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean use_itgTim=false
    "= true, activate integral timers"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean resItgTimInBou=false
    "= true, integral timers will be reset if the input value within bounds"
    annotation(Dialog(enable=use_itgTim), Evaluate=true, HideResult=true,
      choices(checkBox=true));
  parameter Integer nItgTim = 1 "Number of integral timers";
  Modelica.Blocks.Interfaces.BooleanInput itgAct_in if use_itgAct_in
    "Conditional connector to activate integrator"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Logical.Not notRes if (resItgInBou or resItgTimInBou)
    "Conditional not logic for reset"
    annotation (Placement(transformation(extent={{40,-40},{20,-20}})));
  AixLib.Utilities.KPIs.IntegralErrorSingleReference.IntegralTimer itgTim[nItgTim](
    each final use_itgRes_in=resItgTimInBou) if use_itgTim
    "Conditional integral timers"
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This partial model is the base model for KPI assessments.</p>
<p>If the port <i>itgAct_in</i> is enabled, the input will be integrated only when this port&apos;s input is set to <i>true</i>.</p>
<p>If the parameter <i>resItgInBou</i> is <i>true</i>, integrators will be reset if the input value is within the boundaries or below the limit.</p>
<p>If the parameter <i>use_itgTim</i> is <i>true</i>, integral timers are activated and incorporated into the model with the number of <i>nItgTim</i>.</p>
<p>If the paramter <i>resItgTimInBou</i> is <i>true</i>, integral timers will be reset if the input value is within the boundaries or below the limit.</p>
</html>", revisions="<html>
<ul>
  <li>
    January 9, 2025, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1534\">issue 1534</a>)
  </li>
</ul>
</html>"));
end PartialAssessmentBase;
