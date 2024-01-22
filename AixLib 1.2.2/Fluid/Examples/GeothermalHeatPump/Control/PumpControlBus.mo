within AixLib.Fluid.Examples.GeothermalHeatPump.Control;
expandable connector PumpControlBus
  "Bus for all the pump set points in the geothermal heat pump"
  extends Modelica.Icons.SignalBus;

  Modelica.Units.SI.Pressure p_pumpGeothermalSource
    "Pressure set point of pump moving fluid from geothermal source into system";
  Modelica.Units.SI.Pressure p_pumpCondenser
    "Pressure set point of pump moving fluid from storage tank to condenser of heat pump";
  Modelica.Units.SI.Pressure p_pumpEvaporator
    "Pressure set point of pump moving fluid from storage tank to evaporator of heat pump";
  Modelica.Units.SI.Pressure p_pumpColdConsumer
    "Pressure set point of pump moving fluid from storage tank to cold consumers";
  Modelica.Units.SI.Pressure p_pumpHeatConsumer
    "Pressure set point of pump moving fluid from storage tank to heat consumers";

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  Definition of a control bus that includes all the pressure set points
  required for <a href=
  \"modelica://AixLib.Fluid.Examples.GeothermalHeatPump.Components.GeothermalHeatPump\">
  AixLib.Fluid.Examples.GeothermalHeatPump.Components.GeothermalHeatPump</a>.
</p>
<p>
  March 31, 2017, by Marc Baranski:
</p>
<p>
  First implementation.
</p>
</html>"));
end PumpControlBus;
