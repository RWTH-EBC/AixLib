within AixLib.Systems.ModularEnergySystems.Interfaces;
expandable connector ConsumerControlBus
  "Standard data bus with consumerinformation"
  extends Modelica.Icons.SignalBus;

parameter Integer nConsumers "Number of consumers";

// Set Values
Modelica.Units.SI.HeatFlowRate Q_flowSet[nConsumers] "";
Modelica.Units.SI.Temperature TPrescribedSet[nConsumers] "";
Modelica.Units.SI.Temperature TInSet[nConsumers] "";
Modelica.Units.SI.Temperature TOutSet[nConsumers] "";

// Measured Values
Modelica.Units.SI.HeatFlowRate Q_flowMea[nConsumers] "";
Modelica.Units.SI.Temperature TOutMea[nConsumers] "";
Modelica.Units.SI.Temperature TInMea[nConsumers] "";
Modelica.Units.SI.Temperature TInDisMea "";
Modelica.Units.SI.Temperature TOutDisMea "";

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
end ConsumerControlBus;
