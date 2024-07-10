within AixLib.Airflow.WindowVentilation.BaseClasses.Types;
type SunshadingInstallationTypesVDI2078 = enumeration(
    NoSunshading "Pivot-hung window without sunshading",
    ExternalBlindsFront "Pivot-hung window with external venetian blinds > 0.4 m in front of the window",
    ExternalBlindsOn "Pivot-hung window with external venetian blinds on the window",
    Awning "Pivot-hung window with an awning",
    Screen "Pivot-hung window with a screen on the window")
  "Common installation situations of sunshading according to VDI 2078"
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    June 13, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1492\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This enum defines types of sunshading coefficient, used in <a href=\"modelica://AixLib/Airflow/WindowVentilation/BaseClasses/Functions/CoeffsSunshadingInstallationVDI2078.mo\">AixLib.Airflow.WindowVentilation.BaseClasses.Functions.CoeffsSunshadingInstallationVDI2078</a>.</p>
</html>"));
