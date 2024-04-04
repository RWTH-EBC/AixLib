within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSashWidth
  "Common sash opening, input port opening width"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningAreaSashCommon(
    final useInputPort=true,
    redeclare final Modelica.Blocks.Interfaces.RealInput u(
    quantity="Length", unit="m", min=0) "Window sash opening width");
equation
  opnWidth = u;
  /*Calculate the opening angle*/
  /*Hinged or pivot opening*/
  if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal then
    opnAngle = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.s_to_alpha(
      lenA, lenB, opnWidth);

  /*Sliding opening*/
  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingVertical or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingHorizontal then
    opnAngle = 0;

  /*Exceptions*/
  else
    opnAngle = 0;
  end if;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end OpeningAreaSashWidth;
