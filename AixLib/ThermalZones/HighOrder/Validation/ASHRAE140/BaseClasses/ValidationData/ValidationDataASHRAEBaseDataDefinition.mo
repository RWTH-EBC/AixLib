within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.BaseClasses.ValidationData;
record ValidationDataASHRAEBaseDataDefinition
   extends Modelica.Icons.Record;
    parameter Real[:, :] Results "in kWh";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>
    <i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>
    Implemented
  </li>
</ul>
</html>"));
end ValidationDataASHRAEBaseDataDefinition;
