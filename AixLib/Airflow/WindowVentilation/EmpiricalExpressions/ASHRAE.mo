within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model ASHRAE
  "Empirical expression according to ASHRAE handbook (2009)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStackWindIncidence(
      redeclare replaceable model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple);
  Modelica.Blocks.Interfaces.RealInput u(unit="m/s", min=0)
    "Local wind speed by window or facade"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
protected
  Real C_d "Discharge coefficient";
  Real interimRes1 "Interim result";
  Real C_w "Coefficient of wind speed";
  Modelica.Units.SI.Height dH_NPL
    "Height from midpoint of lower opening to the neutral pressure level";
  Modelica.Units.SI.VolumeFlowRate V_flow_th "Thermal induced volume flow";
  Modelica.Units.SI.VolumeFlowRate V_flow_w "Wind induced volume flow";
equation
  V_flow_w =C_w*openingArea.A*u;
  beta = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.SmallestAngleDifference(
    AixLib.Airflow.WindowVentilation.BaseClasses.Types.SmallestAngleDifferenceTypes.Range180,
    aziRef,
    phi);
  C_w = 0.55 - abs(beta_deg)/180*0.25;
  V_flow_th = C_d*openingArea.A*sqrt(interimRes1);
  interimRes1 = 2*Modelica.Constants.g_n*dH_NPL*abs(deltaT)/T_i;
  dH_NPL = openingArea.winClrH/2;
  // Value of 'dH_NPL' is difficult to estimate, if one window or door
  //represents a large fraction (approximately 90%) of the total opening area in
  //the envelope, then the NPL is at the mid-height of that aperture, and dH_NPL
  //equals one-half the height of the aperture.
  C_d = 0.4 + 0.0045*abs(deltaT);
  V_flow = sqrt(V_flow_th^2 + V_flow_w^2);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
    <i>April 5, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This model contains the empirical expression according to ASHRAE handbook.</p>
<p>It is also applied in EnergyPlus as the object <i>ZoneVentilation:WindandStackOpenArea</i>.</p>
<h4>References</h4>
<p>ASHRAE. (2009). 2009 ASHRAE handbook: Fundamentals (SI ed.). American Society of Heating, Refrigeration and Air-Conditioning Engineers.</p>
<p>U.S. Department of Energy. (2023). EnergyPlus Version 23.1.0 Documentation: Engineering Reference [Build: 87ed9199d4]. U.S. Department of Energy. </p>
</html>"));
end ASHRAE;
