within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model DIN16798 "Empirical expression according to DIN EN 16798-7 (2017)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStack(
      redeclare replaceable model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashDIN16798);
  parameter Modelica.Units.SI.Height heightASL=0 "Height above sea level";
  Modelica.Blocks.Interfaces.RealInput winSpe10(unit="m/s", min=0)
    "Local wind speed at a height of 10 m"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
protected
  Real cofExt = min(1, max(0, (1 - 0.1*winSpe10)*((TAmb - T0)/25 + 0.2)))
    "Coefficient depending on external conditions";
  Real cofTh = 0.0035 "Coefficient of thermal buoyancy";
  Real cofWin = 0.001 "Coefficient of wind speed";
  Modelica.Units.SI.Temperature T0 = 273.15 "Temperature at 0 °C";
  Modelica.Units.SI.Temperature TRef = 293 "Reference temperature";
  Modelica.Units.SI.Density rhoRefASL0 = 1.204
    "Reference dry air density, 293 K, 0 m above see level";
  Modelica.Units.SI.Density rhoRefASL=
    rhoRefASL0*(1 - 0.00651*heightASL/293)^4.255
    "Air density, 293 K, by height above sea level";
  Modelica.Units.SI.Density rhoAmbASL = TRef/TAmb*rhoRefASL
    "Air density, by ambient temperature, by height above sea level";
equation
  intRes = 1;
  V_flow = rhoRefASL0/rhoAmbASL*cofExt*openingArea.A/2*sqrt(
    max(cofWin*(winSpe10^2), cofTh*winClrHeight*abs(dTRoomAmb)));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
    June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1492\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model contains the empirical expression according to DIN CEN/TR 16798-8 (DIN SPEC 32739-8):2018-03.</p>
<h4>References</h4>
<p>DIN Deutsches Institut f&uuml;r Normung e. V. (2018.03). Energieeffizienz von Geb&auml;uden &ndash; L&uuml;ftung von Geb&auml;uden &ndash; Teil 8: Interpretation der Anforderungen der EN 16798-7 &ndash; Berechnungsmethoden zur Bestimmung der Luftvolumenstr&ouml;me in Geb&auml;uden einschlie&szlig;lich Infiltration (Modul M5-5): Englische Fassung CEN/TR 16798-8:2017 (DIN CEN/TR 16798-8). Beuth Verlag GmbH.</p>
</html>"));
end DIN16798;
