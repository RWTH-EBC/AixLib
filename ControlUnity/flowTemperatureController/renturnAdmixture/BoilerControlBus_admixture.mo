within ControlUnity.flowTemperatureController.renturnAdmixture;
expandable connector BoilerControlBus_admixture
  "Standard data bus with boiler information"
  extends Modelica.Icons.SignalBus;
  parameter Integer n=1 "Number of heat curcuits";
Boolean isOn "Switches Controller on and off";
Modelica.SIunits.Temperature TAmbient "Ambient air temperature";
Boolean switchToNightMode "Switches the boiler to night mode";
Modelica.SIunits.Power chemicalEnergyFlowRate "Flow of primary (chemical) energy into boiler";

// BoilerNotManufacturer
Real PLR "Part load ratio";
Modelica.SIunits.TemperatureDifference DeltaTWater "Setpoint temperature difference heat circuit";
Modelica.SIunits.Temperature TCold "Sensor output TCold";
Modelica.SIunits.Temperature THot "Sensor output THot";
Modelica.SIunits.Power EnergyDemand "Energy Demand";
Boolean internControl;
Real PLREx;

//Control

//Admixture
 import SI = Modelica.SIunits;
  AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.PumpBus
    pumpBus;
  Real valveSet(min=0, max=1) "Valve opening setpoint 0..1";
  Real valveMea(min=0, max=1) "Actual valve opening 0..1";
  SI.Temperature TFwrdInMea "Flow Temperature into forward line";
  SI.Temperature TFwrdOutMea "Flow Temperature out of forward line";
  SI.Temperature TRtrnInMea "Temperature into return line";
  SI.Temperature TRtrnOutMea "Temperature out of return line";
  SI.VolumeFlowRate VFlowInMea "Volume flow into forward line";
  SI.VolumeFlowRate VFlowOutMea "Volume flow out of forward line";

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Definition of a standard boiler control bus that contains basic data points
  that appear in every boiler.</p>
</html>", revisions="<html>
<ul>
  <li>
  March 31, 2017, by Marc Baranski:<br/>
  First implementation (see
  <a href=\"https://github.com/RWTH-EBC/AixLib/issues/371\">issue 371</a>).
  </li>
</ul>

</html>"));
end BoilerControlBus_admixture;
