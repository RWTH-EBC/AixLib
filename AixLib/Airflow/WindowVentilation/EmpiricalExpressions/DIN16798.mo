within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model DIN16798 "Empirical expression according to DIN EN 16798-7 (2017)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStack(
      redeclare replaceable model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashDIN16798
      constrainedby
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple);
  parameter Modelica.Units.SI.Height heiAbvSeaLvl=0 "Height above sea level";
  Modelica.Blocks.Interfaces.RealInput u_10(unit="m/s", min=0)
    "Local wind speed at a height of 10 m"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
protected
  Real C_e "Coefficient depending on external conditions";
  Real C_th = 0.0035 "Coefficient of thermal buoyancy";
  Real C_w = 0.001 "Coefficient of wind speed";
  Modelica.Units.SI.Temperature T_0 = 273.15 "Temperature at 0 °C";
  Modelica.Units.SI.Temperature T_ref = 293 "Temperature at 0 °C";
  Modelica.Units.SI.Density rho_ref_H0 = 1.204
    "Reference dry air density, 293 K, 0 m above see level";
  Modelica.Units.SI.Density rho_ref_ASL
    "Air density, 293 K, by height above sea level";
  Modelica.Units.SI.Density rho_a_ASL
    "Air density, by ambient temperature, by height above sea level";
equation
  rho_ref_ASL = rho_ref_H0*(1 - 0.00651*heiAbvSeaLvl/293)^4.255;
  rho_a_ASL = T_ref/T_a*rho_ref_ASL;
  C_e = min(1, max(0, (1 - 0.1*u_10)*((T_a - T_0)/25 + 0.2)));
  V_flow =rho_ref_H0/rho_a_ASL*C_e*openingArea_1.A/2*sqrt(max(C_w*(u_10^2),
    C_th*winClrH*abs(deltaT)));
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
<p>This model contains the empirical expression according to DIN CEN/TR 16798-8 (DIN SPEC 32739-8):2018-03.</p>
<h4>References</h4>
<p>DIN Deutsches Institut f&uuml;r Normung e. V. (2018.03). Energieeffizienz von Geb&auml;uden &ndash; L&uuml;ftung von Geb&auml;uden &ndash; Teil 8: Interpretation der Anforderungen der EN 16798-7 &ndash; Berechnungsmethoden zur Bestimmung der Luftvolumenstr&ouml;me in Geb&auml;uden einschlie&szlig;lich Infiltration (Modul M5-5): Englische Fassung CEN/TR 16798-8:2017 (DIN CEN/TR 16798-8). Beuth Verlag GmbH.</p>
</html>"));
end DIN16798;
