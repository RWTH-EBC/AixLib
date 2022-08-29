within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Control.HierarchicalControl_ModularBoiler.InternalControl_ModularBoiler.flowTemperatureController.returnAdmixture.BaseClasses;
expandable connector AdmixtureBus
  extends Modelica.Icons.SignalBus;

  Real valveSet(min=0, max=1) "Valve opening setpoint 0..1";
  Real valveMea(min=0, max=1) "Actual valve opening 0..1";
  Modelica.Units.SI.VolumeFlowRate VFlowInMea "Volume flow into forward line";
  Modelica.Units.SI.VolumeFlowRate VFlowOutMea "Volume flow out of forward line";
  Modelica.Units.SI.Temperature Tsen_a1 "Flow temperature from the heat generator";
  Modelica.Units.SI.Temperature Tsen_b1 "Flow temperature to the consumer";
  Modelica.Units.SI.Temperature Tsen_a2 "Return stream temperature to the admixture";
  Modelica.Units.SI.Temperature Tsen_b2 "Return stream temperature to the heat generator";
annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
        preserveAspectRatio=false)));
end AdmixtureBus;
