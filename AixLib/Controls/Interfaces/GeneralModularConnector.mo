within AixLib.Controls.Interfaces;
expandable connector GeneralModularConnector
  "Connector for modular models without manufacturer data"

  extends Modelica.Icons.SignalBus;

  Real PLR "Part load Ration; depends on the System";

  Modelica.SIunits.ThermodynamicTemperature TSource "temperautre of Heat Source for a Heat Pump";

  Real DeltaTWater "Water temperature difference as a result of controlling";





  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end GeneralModularConnector;
