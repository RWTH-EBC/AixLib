within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PressureDrop;
model PressureDrop
  extends BaseClasses.partialPressureDrop
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));

  input Real b annotation(Dialog);

equation

  dp = a * (m_flow/rho)^b;

end PressureDrop;
