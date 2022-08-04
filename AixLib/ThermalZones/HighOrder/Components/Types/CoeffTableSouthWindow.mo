within AixLib.ThermalZones.HighOrder.Components.Types;
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
