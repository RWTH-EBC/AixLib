within AixLib.ThermalZones.HighOrder.Components;
package Types "Types"
   extends Modelica.Icons.Package;
  type selectorCoefficients = enumeration(
      abs01
          "0.1 solar absorption coefficient",
      abs06
          "0.6 solar absorption coefficient",
      abs09
          "0.9 solar absorption coefficient")
     "Interior solar absorptance of wall surface";
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
</html>", revisions=""));

  end PartialCoeffTable;

  record CoeffTableSouthWindow
    "Table of coefficients of solar Distribution fractions in SouthFacingWindows"

    extends PartialCoeffTable(
      final coeffFloor(min=0, max=1)=
    if abs==selectorCoefficients.abs06 then 0.642
    else if abs==selectorCoefficients.abs09 then 0.903
    else 0.244,
      final coeffCeiling(min=0, max=1)=
    if abs==selectorCoefficients.abs06 then 0.168
    else if abs==selectorCoefficients.abs09 then 0.039
    else 0.191,
      final coeffOWEast(min=0, max=1)=
    if abs==selectorCoefficients.abs06 then 0.038
    else if abs==selectorCoefficients.abs09 then 0.013
    else 0.057,
        final  coeffOWWest(min=0, max=1)=
    if abs==selectorCoefficients.abs06 then 0.038
    else if abs==selectorCoefficients.abs09 then 0.013
    else 0.057,
      final  coeffOWNorth(min=0, max=1)=
    if abs==selectorCoefficients.abs06 then 0.053
    else if abs==selectorCoefficients.abs09 then 0.018
    else 0.082,
      final coeffOWSouth(min=0, max=1)=
    if abs==selectorCoefficients.abs06 then 0.026
    else if abs==selectorCoefficients.abs09 then 0.008
    else 0.065,
    final coeffWinLost(min=0, max=1)=
    if abs==selectorCoefficients.abs06 then 0.035
    else if abs==selectorCoefficients.abs09 then 0.006
    else 0.304,
    final coeffWinAbs(min=0, max=1)=
    if abs==selectorCoefficients.abs06 then 0
    else if abs==selectorCoefficients.abs09 then 0
    else 0)
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));

    annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  .Table of coefficients of solar distribution fractions on
  SouthFacingWindows, depending on:
</p>
<ul>
  <li>Orientation of the window and interior surfaces
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
</html>"));
  end CoeffTableSouthWindow;

  record CoeffTableEastWestWindow
    "Table of coefficients of solar Distribution fractions in EastWestFacingWindows"
    extends PartialCoeffTable(
      final coeffFloor(min=0, max=1)=
    if abs==selectorCoefficients.abs06 then 0.642
    else if abs==selectorCoefficients.abs09 then 0.903
    else 0.244,
      final coeffCeiling(min=0, max=1)=
    if abs==selectorCoefficients.abs06 then 0.168
    else if abs==selectorCoefficients.abs09 then 0.039
    else 0.191,
      final coeffOWEast(min=0, max=1)=
    if abs==selectorCoefficients.abs06 then 0.025
    else if abs==selectorCoefficients.abs09 then 0.008
    else 0.057,
        final  coeffOWWest(min=0, max=1)=
    if abs==selectorCoefficients.abs06 then 0.025
    else if abs==selectorCoefficients.abs09 then 0.008
    else 0.057,
      final  coeffOWNorth(min=0, max=1)=
    if abs==selectorCoefficients.abs06 then 0.0525
    else if abs==selectorCoefficients.abs09 then 0.018
    else 0.082,
      final coeffOWSouth(min=0, max=1)=
    if abs==selectorCoefficients.abs06 then 0.0525
    else if abs==selectorCoefficients.abs09 then 0.018
    else 0.065,
    final coeffWinLost(min=0, max=1)=
    if abs==selectorCoefficients.abs06 then 0.035
    else if abs==selectorCoefficients.abs09 then 0.006
    else 0.304,
    final coeffWinAbs(min=0, max=1)=
    if abs==selectorCoefficients.abs06 then 0
    else if abs==selectorCoefficients.abs09 then 0
    else 0)
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));

    annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  .Table of coefficients of solar distribution fractions on
  EastWestFacingWindows, depending on:
</p>
<ul>
  <li>Orientation of the window and interior surfaces
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
<h4>
  Known Limitations
</h4>
<ul>
  <li>For alpha=0.1, no values are listed in the ASHREA. The values
  based on the SouthWindow case are used instead.
  </li>
</ul>
</html>"));
  end CoeffTableEastWestWindow;
end Types;
