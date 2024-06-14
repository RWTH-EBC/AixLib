within AixLib.Airflow.WindowVentilation.Examples;
model VentilationFlowRateSimpleOpening
  "Use different empirical expressions to determine the window ventilation flow rate by simple opening"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialExampleVentilationFlowRate;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 9, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This example checks the models that simulate the window ventilation flow rate with the simple opening.</p>
<p>The result shows that the estimated volume flow can be quite different when using different models.</p>
</html>"));
end VentilationFlowRateSimpleOpening;
