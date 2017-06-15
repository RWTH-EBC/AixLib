within AixLib.Fluid.Examples.GeothermalHeatPump.Control;
expandable connector PumpControlBus
  "Bus for all the pump set points in the geothermal heat pump"
  extends Modelica.Icons.SignalBus;

  Modelica.SIunits.Pressure p_pumpGeothermalSource "Pressure set point of pump moving fluid from geothermal source into system";
  Modelica.SIunits.Pressure p_pumpCondenser "Pressure set point of pump moving fluid from storage tank to condenser of heat pump";
  Modelica.SIunits.Pressure p_pumpEvaporator "Pressure set point of pump moving fluid from storage tank to evaporator of heat pump";
  Modelica.SIunits.Pressure p_pumpColdConsumer "Pressure set point of pump moving fluid from storage tank to cold consumers";
  Modelica.SIunits.Pressure p_pumpHeatConsumer "Pressure set point of pump moving fluid from storage tank to heat consumers";

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Definition of a standard heat pump bus that contains basic data points that appear in every heat pump.</p>
</html>", revisions="<html>
<p>March 31, 2017, by Marc Baranski:</p>
<p>First implementation. </p>
</html>"));
end PumpControlBus;
