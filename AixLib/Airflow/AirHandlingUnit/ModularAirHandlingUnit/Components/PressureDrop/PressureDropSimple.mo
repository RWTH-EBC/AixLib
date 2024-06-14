within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PressureDrop;
model PressureDropSimple
  extends BaseClasses.partialPressureDrop;

  parameter Real b = 2;

equation

  dp = a * (m_flow/rho)^b;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PressureDropSimple;
