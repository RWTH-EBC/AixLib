within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model VDI2078 "Empirical expression according to VDI 2078 (2015)"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStack(
    redeclare replaceable model OpeningArea =
      AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashVDI2078,
      varName="V_flow");
  parameter Boolean use_cofSunSha_in=false
    "Use input port for sunshading coefficient"
    annotation(choices(checkBox=true));
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
  Modelica.Blocks.Interfaces.RealOutput cofSunSha_internal(min=0, max=1)
    "Internal port to connect to cofSunSha_in or prescribed coefficient defined by type";
protected
  Real intRes "Interim result";
equation
  connect(cofSunSha_in, cofSunSha_internal);
  if not use_cofSunSha_in then
    cofSunSha_internal =
      AixLib.Airflow.WindowVentilation.BaseClasses.Functions.CoeffsSunshadingInstallationVDI2078(
      sunShaTyp);
  end if;
  intRes = Modelica.Constants.g_n*openingArea.effHeight*dTRoomAmb/(2*TAmb);
  V_flow =if noEvent(intRes > Modelica.Constants.eps) then cofSunSha_internal*
    openingArea.A*sqrt(intRes) else 0;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1492\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model contains the empirical expression according to VDI 2078:2015-06.</p>
<h4>References</h4>
<p>Verein Deutscher Ingenieure e.V. (2015.06). Berechnung der thermischen Lasten und Raumtemperaturen (Auslegung K&uuml;hllast und Jahressimulation) (VDI 2078). VDI Fachmedien GmbH &amp; Co. KG.</p>
</html>"));
end VDI2078;
