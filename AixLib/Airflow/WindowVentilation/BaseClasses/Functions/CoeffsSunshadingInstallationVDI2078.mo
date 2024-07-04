within AixLib.Airflow.WindowVentilation.BaseClasses.Functions;
function CoeffsSunshadingInstallationVDI2078
  "Calculate the sunshading coefficient based on its installation defined by VDI 2078"
  extends Modelica.Icons.Function;
  input AixLib.Airflow.WindowVentilation.BaseClasses.Types.SunshadingInstallationTypesVDI2078
    typ "Sunshading type defined in VDI 2078";
  output Real cof "Coefficient of sunshading";
algorithm
  cof := if typ == AixLib.Airflow.WindowVentilation.BaseClasses.Types.SunshadingInstallationTypesVDI2078.NoSunshading
     then 1.0 else if typ == AixLib.Airflow.WindowVentilation.BaseClasses.Types.SunshadingInstallationTypesVDI2078.ExternalBlindsFront
     then 0.9 else if typ == AixLib.Airflow.WindowVentilation.BaseClasses.Types.SunshadingInstallationTypesVDI2078.ExternalBlindsOn
     then 0.66 else if typ == AixLib.Airflow.WindowVentilation.BaseClasses.Types.SunshadingInstallationTypesVDI2078.Awning
     then 1 else if typ == AixLib.Airflow.WindowVentilation.BaseClasses.Types.SunshadingInstallationTypesVDI2078.Screen
     then 0.33 else 0;
  annotation (Documentation(revisions="<html><ul>
  <li>June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=
    \"//&quot;https://github.com/RWTH-EBC/AixLib/issues/1492//&quot;\">issue
    1492</a>)
  </li>
</ul>
</html>", info="<html><p>
  This function finds the sunshading coefficient according to the input
  sunshading type. Values are defined by VDI 2078.
</p>
</html>"));
end CoeffsSunshadingInstallationVDI2078;
