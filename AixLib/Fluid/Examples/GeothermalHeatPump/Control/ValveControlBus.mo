within AixLib.Fluid.Examples.GeothermalHeatPump.Control;
expandable connector ValveControlBus
  "Bus for all the valve positions in the geothermal heat pump"
  extends Modelica.Icons.SignalBus;

  Real opening_valveHeatSource
    "Rated value of the valve connecting the geothermal field to evaporator (0: closed, 1: open)";
  Real opening_valveColdStorage
    "Rated value of the valve connecting the cold storage to evaporator (0: closed, 1: open)";

  Real opening_valveHeatSink
    "Rated value of the valve connecting the geothermal field to condenser (0: closed, 1: open)";
  Real opening_valveHeatStorage
    "Rated value of the valve connecting the heat storage to condenser (0: closed, 1: open)";

  Real feedback_valveHeatSource
    "Feedback of the valve connecting the geothermal field to evaporator (0: closed, 1: open)";
  Real feedback_valveColdStorage
    "Feedback of the valve connecting the cold storage to evaporator (0: closed, 1: open)";

  Real feedback_valveHeatSink
    "Feedback of the valve connecting the geothermal field to condenser (0: closed, 1: open)";
  Real feedback_valveHeatStorage
    "Feedback of the valve connecting the heat storage to condenser (0: closed, 1: open)";


  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  Definition of a standard control bus that includes all the pressure
  set points required for <a href=
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
end ValveControlBus;
