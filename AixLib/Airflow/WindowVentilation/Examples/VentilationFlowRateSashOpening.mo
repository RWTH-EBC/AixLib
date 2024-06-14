within AixLib.Airflow.WindowVentilation.Examples;
model VentilationFlowRateSashOpening
  "Use different empirical expressions to determine the window ventilation flow rate by sash opening"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialExampleVentilationFlowRate;
  Modelica.Blocks.Sources.SawTooth winOpnWidthSet(amplitude=0.3, period=10)
    "Set window opening width"
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.Ramp dpSet(
    height=20,
    duration=160,
    offset=-10,
    startTime=10) "Set pressure difference"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 9, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This example checks the models that simulate the window ventilation flow rate with the sash opening.</p>
<p>The result shows that the estimated volume flow can be quite different when using different models.</p>
</html>"));
end VentilationFlowRateSashOpening;
