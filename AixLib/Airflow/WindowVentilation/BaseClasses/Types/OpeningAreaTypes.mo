within AixLib.Airflow.WindowVentilation.BaseClasses.Types;
type OpeningAreaTypes = enumeration(
    Geometric "Geometric opening area",
    Projective "Projective opening area",
    Equivalent "Equivalent opening area",
    Effective "Effective opening area")
    "Enumeration to define window opening area types" annotation (Documentation(
      info="<html>
<p>This enum defines window sash opening area types.</p>
</html>"));
