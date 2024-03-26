within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged;
function equivalentOpeningArea
  "Calculation of the equivalent opening area"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.Area A_clr(min=0) "Window clear opening area";
  input Modelica.Units.SI.Area A_geo(min=0) "Window geometric opening area";
  output Modelica.Units.SI.Area A(min=0) "Equivalent opening area";
algorithm
  if (A_clr<Modelica.Constants.eps) or (A_geo<Modelica.Constants.eps) then
    A := 0;
  else
    A := (A_clr^(-2) + A_geo^(-2))^(-0.5);
  end if;
end equivalentOpeningArea;
