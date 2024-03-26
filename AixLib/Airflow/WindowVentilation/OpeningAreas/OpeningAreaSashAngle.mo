within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSashAngle
  "Window opening with different types of sash, input port with opening angle"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningAreaSash;
  Modelica.Blocks.Interfaces.RealInput alpha(
    quantity="Angle", unit="rad", min=0, max=Modelica.Constants.pi/2)
    "Window sash opening angle"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

equation
  assert(
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal,
    "With opening angle input, the model can only used for hinged or pivot opening",
    AssertionLevel.error);

  opnAngle = alpha;
  /*Calculate the opening width*/
  /*Hinged or pivot opening*/
  if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal then
    opnWidth = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.alpha_to_s(
      lenA, lenB, alpha);

  /*Exceptions*/
  else
    opnAngle = 0;
  end if;

end OpeningAreaSashAngle;
