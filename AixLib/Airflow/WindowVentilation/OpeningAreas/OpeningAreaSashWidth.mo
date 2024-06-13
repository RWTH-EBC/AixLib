within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSashWidth
  "Common sash opening, input port opening width"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningAreaSashCommon(
      final useInputPort=true,
      redeclare final Modelica.Blocks.Interfaces.RealInput u_win(
        quantity="Length", unit="m", min=0));
equation
  opnWidth = u_win;
  /*Calculate the opening angle*/
  /*Hinged or pivot opening*/
  if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal then
    opnAngle =
      AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.WidthToAngle(
      lenA,
      lenB,
      opnWidth);

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
</html>", info="<html>
<p>This model determines the window opening area of several common <a href=\"modelica://AixLib/Airflow/WindowVentilation/BaseClasses/Types/WindowOpeningTypes.mo\">window opening types</a>. For each opening type, four different <a href=\"modelica://AixLib/Airflow/WindowVentilation/BaseClasses/Types/OpeningAreaTypes.mo\">opening area types</a> are defined.</p>
<p>Input port of this model is the opening width.</p>
</html>"));
end OpeningAreaSashWidth;
