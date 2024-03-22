within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSimple "Simple window opening, without window sash"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningArea;
equation
  A = clrOpnArea;
end OpeningAreaSimple;
