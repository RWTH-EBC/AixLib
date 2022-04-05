within AixLib.Systems.ModularEnergySystems.ControlUnity.flowTemperatureController.renturnAdmixture;
expandable connector AdmixtureBus
extends Modelica.Icons.SignalBus;

 Real valveSet(min=0, max=1) "Valve opening setpoint 0..1";
 Real valveMea(min=0, max=1) "Actual valve opening 0..1";
 Modelica.SIunits.VolumeFlowRate VFlowInMea "Volume flow into forward line";
 Modelica.SIunits.VolumeFlowRate VFlowOutMea "Volume flow out of forward line";
 Modelica.SIunits.Temperature Tsen_a1 "Flow temperature from the heat generator";
 Modelica.SIunits.Temperature Tsen_b1 "Flow temperature to the consumer";
 Modelica.SIunits.Temperature Tsen_a2 "Return stream temperature to the admixture";
 Modelica.SIunits.Temperature Tsen_b2 "Return stream temperature to the heat generator";
annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
        preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Bus connetor with all relevant interfaces for the <a href=\"AixLib.Systems.ModularEnergySystems.ControlUnity.flowTemperatureController.renturnAdmixture.Admixture\">Admxiture</a> model. </p>
</html>"));
end AdmixtureBus;
