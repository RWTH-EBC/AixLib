within AixLib.ThermalZones.HighOrder.Components.Types;
record PartialCoeffTable "Partial model to choose solar distribution fractions "

  extends Modelica.Icons.Record;

  parameter selectorCoefficients abs "Coefficients for interior solar absorptance of wall surface abs={0.6, 0.9, 0.1}";

  parameter Real coeffFloor(min=0, max=1)
                                         "Solar distribution fraction of the transmitted solar radiantion through the window on the Floor";
  parameter Real coeffCeiling(min=0, max=1)
                                           "Solar distribution fraction of the transmitted solar radiantion through the window on the Ceiling";
  parameter Real coeffOWEast(min=0, max=1)
                                          "Solar distribution fraction of the transmitted solar radiantion through the window on the OWEast";
  parameter Real coeffOWWest(min=0, max=1)
                                          "Solar distribution fraction of the transmitted solar radiantion through the window on the OWWest";
  parameter Real coeffOWNorth(min=0, max=1)
                                           "Solar distribution fraction of the transmitted solar radiantion through the window on the OWNorth";
  parameter Real coeffOWSouth(min=0, max=1)
                                           "Solar distribution fraction of the transmitted solar radiantion through the window on the OWSouth";
  parameter Real coeffWinLost(min=0, max=1)
                                           "Solar distribution fraction of the transmitted solar radiantion through the window on the window and transmitted (lost)";
  parameter Real coeffWinAbs(min=0, max=1) "Solar distribution fraction of the transmitted solar radiantion through the window on the window and absorped";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  .Partial model to select solar distribution fractions depending on:
</p>
<ul>
  <li>Orientation of the window and interior surfaces
  </li>
  <li>The interior shortwave absorptance of the surface
  </li>
  <li style=\"list-style: none; display: inline\">
    <h4>
      <span style=\"color: #008000\">References</span>
    </h4>
    <ul>
      <li>ASHRAE140-2017 Informative Annex B7
      </li>
    </ul>
  </li>
</ul>
</html>",
        revisions=""));

end PartialCoeffTable;
