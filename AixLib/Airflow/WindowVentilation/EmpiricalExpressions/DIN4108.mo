within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model DIN4108
  "Empirical expression according to DIN/TS 4108-8 (2022)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStack(
      redeclare replaceable model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashDIN4108
      constrainedby
      AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple);
  Modelica.Blocks.Interfaces.RealInput u(unit="m/s", min=0)
    "Local wind speed by window or facade"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
protected
  Real C_d = 0.61 "Discharge coefficient";
  Real interimRes1 "Interim result";
  Real C_w = 0.05 "Coefficient of wind speed";
  Modelica.Units.SI.VolumeFlowRate V_flow_th "Thermal induced volume flow";
  Modelica.Units.SI.VolumeFlowRate V_flow_w "Wind induced volume flow";
equation
  interimRes1 = Modelica.Constants.g_n*winClrH*deltaT/T_a;
  assert(interimRes1 > Modelica.Constants.eps,
    "The polynomial under the square root to calculate V_flow_th is less than 0, the V_flow_th will be set to 0",
    AssertionLevel.warning);
  V_flow_th = if noEvent(interimRes1 > Modelica.Constants.eps)
    then 1/3*C_d*openingArea.A*sqrt(interimRes1) else 0;
  V_flow_w =C_w*openingArea.A*u;
  V_flow = sqrt(V_flow_th^2 + V_flow_w^2);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
    <i>April 4, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This model contains the empirical expression according to DIN/TS 4108-8:2022-09.</p>
<h4>References</h4>
<p>DIN Deutsches Institut f&uuml;r Normung e. V. (2022.09). W&auml;rmeschutz und Energie-Einsparung in Geb&auml;uden &ndash; Teil 8: Vermeidung von Schimmelwachstum in Wohngeb&auml;uden: Vornorm (DIN/TS 4108-8). Beuth Verlag GmbH.</p>
</html>"));
end DIN4108;
