within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PressureDrop;
model PressureDropSimple
  extends BaseClasses.partialPressureDrop;

  parameter Real b = 2;

equation

  dp = dp_nominal * (m_flow/m_flow_nominal)^b;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PressureDropSimple;
