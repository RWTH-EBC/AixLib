within AixLib.Systems.ModularEnergySystems.Interfaces;
expandable connector BoilerControlBus
  "Standard data bus with boiler information"
  extends Modelica.Icons.SignalBus;

Boolean isOn "Switches Controller on and off";
Modelica.Units.SI.Temperature TAmbient "Ambient air temperature";
Boolean switchToNightMode "Switches the boiler to night mode";
Modelica.Units.SI.Power chemicalEnergyFlowRate "Flow of primary (chemical) energy into boiler";

// BoilerNotManufacturer
Real PLR "Part load ratio";
Modelica.Units.SI.TemperatureDifference DeltaTWater "Setpoint temperature difference heat circuit";
  Modelica.Units.SI.Temperature TFlowMea "Measured flow temperature of boiler";
  Modelica.Units.SI.Temperature TRetMea
    "Measured return temperature of boiler";
Modelica.Units.SI.Power EnergyDemand "Energy Demand";
Modelica.Units.SI.Temperature TFlowSet "Set value for flow temperature";
Real PLRMea "Measured part load ratio";

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  Definition of a standard boiler control bus that contains basic data
  points that appear in every boiler.
</p>
</html>", revisions="<html>
<ul>
  <li>March 31, 2017, by Marc Baranski:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/371\">issue 371</a>).
  </li>
</ul>
</html>"));
end BoilerControlBus;
