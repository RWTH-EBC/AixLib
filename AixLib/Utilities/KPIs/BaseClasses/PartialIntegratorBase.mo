within AixLib.Utilities.KPIs.BaseClasses;
partial model PartialIntegratorBase
  "Base model of integrator with conditional inputs for activation and reset"
  parameter Boolean use_itgAct_in=false
    "= true, enable activation connector; = false, disable connector, integrator continuously activated"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean use_itgRes_in=false "= true, enable reset connector"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  Modelica.Blocks.Interfaces.RealOutput y "Integral error output"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.BooleanInput itgAct_in if use_itgAct_in
    "Conditional connector to activate integrator"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Interfaces.BooleanInput itgRes_in if use_itgRes_in
    "Conditional connector to reset integrator"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
  Modelica.Blocks.Sources.BooleanExpression booExpItgAct(
    final y=itgAct_internal)
    "Output for itgAct_internal"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
protected
  Modelica.Blocks.Interfaces.BooleanInput itgAct_internal
  "Internal connector of integrator activation";
equation
  connect(itgAct_in, itgAct_internal);
  if not use_itgAct_in then
    // Set true if conditional connector disabled
    itgAct_internal = true;
  end if;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    December 17, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1534\">issue 1534</a>)
  </li>
</ul>
</html>", info="<html>
<p>This partial model is the base model of error integrators.</p>
<p>If the port <i>itgAct_in</i> is enabled, the input will be integrated only when this port&apos;s input is set to <i>true</i>.</p>
<p>If the port <i>itgRes_in</i> is enabled, the integrated value will be reset to 0 whenever this port experiences a rising edge (similar to <i>Modelica.Blocks.Continuous.Integrator</i>).</p>
</html>"));
end PartialIntegratorBase;
