within AixLib.Fluid.HeatPumps.BaseClasses.Controls;
partial model HPControllerBaseClass
  "Base class of a heat pump controller with bus interface"
  Interfaces.HeatPumpControlBus heatPumpControlBus annotation (Placement(
        transformation(
        extent={{-19,-18},{19,18}},
        rotation=270,
        origin={99,0})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HPControllerBaseClass;
