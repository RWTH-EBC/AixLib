within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.BaseClasses.ValidationDate;
record ValidationDataASHRAEBaseDataDefinition
   extends Modelica.Icons.Record;
    parameter Real[:, :] Results "First column case number";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
 <ul>
 <li><i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>Implemented</li>
 </ul>
 </html>"));
end ValidationDataASHRAEBaseDataDefinition;
