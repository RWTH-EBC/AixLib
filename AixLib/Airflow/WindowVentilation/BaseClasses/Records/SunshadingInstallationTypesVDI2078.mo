within AixLib.Airflow.WindowVentilation.BaseClasses.Records;
type SunshadingInstallationTypesVDI2078 = enumeration(
    NoSunshading "Pivot-hung window withou sunshading",
    ExternalBlindsFront "Pivot-hung window with external venetian blinds > 0.4 m in front of the window",
    ExternalBlindsOn "Pivot-hung window with external venetian blinds on the window",
    Awning "Pivot-hung window with an awning",
    Screen "Pivot-hung window with a screen on the window")
  "Common installation situations of sunshading according to VDI 2078"
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 3, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>"));
