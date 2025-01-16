within AixLib.Utilities.Sources.HeaterCooler.SimplyfiedTransferSystems;
record BaseTransferSystem
  extends Modelica.Icons.Record;
  parameter Real k(unit="1")=1 "Gain";
  parameter SI.Time T(start=1) "Time Constant";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BaseTransferSystem;
