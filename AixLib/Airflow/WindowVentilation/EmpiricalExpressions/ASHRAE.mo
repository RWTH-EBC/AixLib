within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model ASHRAE
  "Empirical expression according to ASHRAE handbook (2009)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStackWindIncidence(
      redeclare replaceable AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple openingArea);
  Modelica.Blocks.Interfaces.RealInput winSpe(unit="m/s", min=0)
    "Local wind speed by window or facade"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
protected
  Real cofDcg "Discharge coefficient";
  Real interimRes1 "Interim result";
  Real cofWin "Coefficient of wind speed";
  Modelica.Units.SI.Height dHeightNPL
    "Height from midpoint of lower opening to the neutral pressure level";
  Modelica.Units.SI.VolumeFlowRate V_flow_th "Thermal induced volume flow";
  Modelica.Units.SI.VolumeFlowRate V_flow_win "Wind induced volume flow";
equation
  V_flow_win =cofWin*openingArea.A*winSpe;
  incAng = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.SmallestAngleDifference(
    AixLib.Airflow.WindowVentilation.BaseClasses.Types.SmallestAngleDifferenceTypes.Range180,
    aziRef, winDir);
  cofWin = 0.55 - abs(incAngDeg)/180*0.25;
  V_flow_th = cofDcg*openingArea.A*sqrt(interimRes1);
  interimRes1 = 2*Modelica.Constants.g_n*dHeightNPL*abs(dT_RoomAmb)/TRoom;
  dHeightNPL = openingArea.winClrHeight/2;
  // Value of 'dHeightNPL' is difficult to estimate, if one window or door
  //represents a large fraction (approximately 90%) of the total opening area in
  //the envelope, then the NPL is at the mid-height of that aperture, and
  //dHeightNPL equals one-half the height of the aperture.
  cofDcg = 0.4 + 0.0045*abs(dT_RoomAmb);
  V_flow = sqrt(V_flow_th^2 + V_flow_win^2);
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
