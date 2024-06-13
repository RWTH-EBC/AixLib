within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model WarrenParkins
  "Empirical expression developed by Warren and Parkins (1984)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStack(
      redeclare replaceable model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple);
  Modelica.Blocks.Interfaces.RealInput u_10(unit="m/s", min=0)
    "Local wind speed at a height of 10 m"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
protected
  Real C_d = 0.61 "Discharge coefficient";
  Real interimRes1 "Interim result";
  Modelica.Units.SI.VolumeFlowRate V_flow_th "Thermal induced volume flow";
  Modelica.Units.SI.VolumeFlowRate V_flow_w "Wind induced volume flow";
equation
  interimRes1 = Modelica.Constants.g_n*winClrH*deltaT/avgT;
  assert(interimRes1 > Modelica.Constants.eps,
    "The polynomial under the square root to calculate V_flow_th is less than 0, the V_flow_th will be set to 0",
    AssertionLevel.warning);
  V_flow_th =if noEvent(interimRes1 > Modelica.Constants.eps) then 1/3*C_d*
    openingArea_1.A*sqrt(interimRes1) else 0;
  V_flow_w =0.025*openingArea_1.A*u_10;
  V_flow = max(V_flow_th, V_flow_w);
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This model contains the empirical expression developed by Warren and Parkins.</p>
<h4>References</h4>
<p>Warren, P. R., &amp; Parkins, L. M. (1984). Single-sided ventilation through open windows. In Air infiltration and Ventilation Centre (Chair), Windows in building design and maintenance, Goteborg. </p>
</html>"));
end WarrenParkins;
