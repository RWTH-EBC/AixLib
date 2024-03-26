within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSashWidth
  "Window opening with different types of sash, input port with opening width"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningAreaSash;
  Modelica.Blocks.Interfaces.RealInput s(quantity="Length", unit="m", min=0)
    "Window sash opening width"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

equation
  opnWidth = s;
  /*Calculate the opening angle*/
  /*Hinged or pivot opening*/
  if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal then
    opnAngle = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.s_to_alpha(
      lenA, lenB, s);

  /*Sliding opening*/
  elseif opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingVertical or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingHorizontal then
    opnAngle = 0;

  /*Exceptions*/
  else
    opnAngle = 0;
  end if;

end OpeningAreaSashWidth;
