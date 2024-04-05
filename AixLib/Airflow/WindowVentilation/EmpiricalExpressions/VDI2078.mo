within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model VDI2078 "Empirical expression according to VDI 2078 (2015)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStack(
      redeclare replaceable model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimpleVDI2078);
  Modelica.Units.SI.Area A_eff(min=0)
    "Effective aperture area for the air flow";
  Modelica.Units.SI.Height H_eff(min=0)
    "Effective height for the thermal updraft";
  Modelica.Blocks.Interfaces.RealInput C_ss(min=0, max=1)
    "Coefficient of the sunshading"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
protected
  Real interimRes1 "Interim result";
equation
  A_eff = openingArea.A;
  H_eff = openingArea.H_eff;
  interimRes1 = Modelica.Constants.g_n*H_eff*deltaT/(2*T_a);
  assert(interimRes1 > Modelica.Constants.eps,
    "The polynomial under the square root to calculate V_flow is less than 0, the V_flow will be set to 0",
    AssertionLevel.warning);
  V_flow = if noEvent(interimRes1 > Modelica.Constants.eps)
    then C_ss*A_eff*sqrt(interimRes1) else 0;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 4, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This model contains the empirical expression according to VDI 2078:2015-06.</p>
<h4>References</h4>
<p>Verein Deutscher Ingenieure e.V. (2015.06). Berechnung der thermischen Lasten und Raumtemperaturen (Auslegung K&uuml;hllast und Jahressimulation) (VDI 2078). VDI Fachmedien GmbH &amp; Co. KG.</p>
</html>"));
end VDI2078;
