within AixLib.Airflow.WindowVentilation.BaseClasses.Types;
type SmallestAngleDifferenceTypes = enumeration(
    Range180 "Result in the range of -180° to +180°",
    Range360 "Result in the range of 0 to 360°")
    "Enumeration to define smallest angle difference types for the function"
  annotation (Documentation(info="<html>
<p>This enum defines types of smallest angle difference, used in <a href=\"modelica://AixLib/Airflow/WindowVentilation/BaseClasses/Functions/SmallestAngleDifference.mo\">AixLib.Airflow.WindowVentilation.BaseClasses.Functions.SmallestAngleDifference</a>.</p>
</html>"));
