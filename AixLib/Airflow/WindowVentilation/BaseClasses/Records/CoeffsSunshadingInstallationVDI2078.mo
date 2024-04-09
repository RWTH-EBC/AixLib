within AixLib.Airflow.WindowVentilation.BaseClasses.Records;
record CoeffsSunshadingInstallationVDI2078
  "Coefficients of the volume flow decresed by window ventilation caused by closing different sunshadings"
  extends Modelica.Icons.Record;
  parameter AixLib.Airflow.WindowVentilation.BaseClasses.Records.SunshadingInstallationTypesVDI2078 typ;
  final Real coeff(min=0, max=1)=
    if typ == AixLib.Airflow.WindowVentilation.BaseClasses.Records.SunshadingInstallationTypesVDI2078.NoSunshading
      then 1.0 else
    if typ == AixLib.Airflow.WindowVentilation.BaseClasses.Records.SunshadingInstallationTypesVDI2078.ExternalBlindsFront
      then 0.9 else
    if typ == AixLib.Airflow.WindowVentilation.BaseClasses.Records.SunshadingInstallationTypesVDI2078.ExternalBlindsOn
      then 0.66 else
    if typ == AixLib.Airflow.WindowVentilation.BaseClasses.Records.SunshadingInstallationTypesVDI2078.Awning
      then 1 else
    if typ == AixLib.Airflow.WindowVentilation.BaseClasses.Records.SunshadingInstallationTypesVDI2078.Screen
      then 0.33 else 0;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 3, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This record shows the sunshading coefficient as defined in VDI 2078:2015-06.</p>
<p>This record is not integrated into any model, but can be used as a reference.</p>
</html>"));
end CoeffsSunshadingInstallationVDI2078;
