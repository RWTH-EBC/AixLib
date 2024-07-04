within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model VDI2078 "Empirical expression according to VDI 2078 (2015)"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStack(
    redeclare replaceable AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashVDI2078 openingArea);
  parameter Boolean use_cofSunSha_in=false
    "Use input port for sunshading coefficient";
  parameter
    AixLib.Airflow.WindowVentilation.BaseClasses.Types.SunshadingInstallationTypesVDI2078
    sunShaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.SunshadingInstallationTypesVDI2078.NoSunshading
    "Sunshading type"
    annotation (Dialog(enable=not use_cofSunSha_in));
  Modelica.Blocks.Interfaces.RealInput cofSunSha_in(min=0, max=1) if use_cofSunSha_in
    "Conditional input port for sunshading coefficient"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Interfaces.RealOutput cofSunSha(min=0, max=1)
    "Internal port to connect to cofSunSha_in or prescribed coefficient defined by type";
protected
  Real intRes "Interim result";
equation
  connect(cofSunSha_in, cofSunSha);
  if not use_cofSunSha_in then
    cofSunSha = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.CoeffsSunshadingInstallationVDI2078(
      sunShaTyp);
  end if;
  intRes = Modelica.Constants.g_n*openingArea.effHeight*dT_RoomAmb/(2*TAmb);
  assert(intRes > Modelica.Constants.eps,
    "The polynomial under the square root to calculate V_flow is less than 0, the V_flow will be set to 0",
    AssertionLevel.warning);
  V_flow = if noEvent(intRes > Modelica.Constants.eps)
    then cofSunSha*openingArea.A*sqrt(intRes) else 0;
  annotation (Documentation(revisions="<html><ul>
  <li>June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=
    \"//&quot;https://github.com/RWTH-EBC/AixLib/issues/1492//&quot;\">issue
    1492</a>)
  </li>
</ul>
</html>", info="<html><p>
  This model contains the empirical expression according to VDI
  2078:2015-06.
</p>
<h4>
  References
</h4>
<p>
  Verein Deutscher Ingenieure e.V. (2015.06). Berechnung der
  thermischen Lasten und Raumtemperaturen (Auslegung Kühllast und
  Jahressimulation) (VDI 2078). VDI Fachmedien GmbH & Co. KG.
</p>
</html>"));
end VDI2078;
