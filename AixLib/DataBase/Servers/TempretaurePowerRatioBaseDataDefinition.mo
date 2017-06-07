within AixLib.DataBase.Servers;
record TempretaurePowerRatioBaseDataDefinition
    extends Modelica.Icons.Record;

  parameter Real powerRatio[:,:] "Radio of the power consumption based on temperature and CPU utilization";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TempretaurePowerRatioBaseDataDefinition;
