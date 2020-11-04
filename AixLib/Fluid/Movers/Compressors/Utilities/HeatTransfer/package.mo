within AixLib.Fluid.Movers.Compressors.Utilities;
package HeatTransfer "Package that contains models to compute heat transfers"
  extends Modelica.Icons.Package;

  annotation (Icon(graphics={
      Polygon(
        origin = {13.758,27.517},
        lineColor = {128,128,128},
        fillColor = {192,192,192},
        fillPattern = FillPattern.Solid,
        points = {{-54,-6},{-61,-7},{-75,-15},{-79,-24},{-80,-34},{-78,-42},
                  {-73,-49},{-64,-51},{-57,-51},{-47,-50},{-41,-43},{-38,-35},
                  {-40,-27},{-40,-20},{-42,-13},{-47,-7},{-54,-5},{-54,-6}}),
      Polygon(
        origin = {13.758,27.517},
        lineColor = {191,0,0},
        fillColor = {191,0,0},
        fillPattern = FillPattern.Solid,
        points = {{-9,-23},{-9,-10},{18,-17},{-9,-23}}),
      Polygon(
        origin = {13.758,27.517},
        lineColor = {160,160,164},
        fillColor = {192,192,192},
        fillPattern = FillPattern.Solid,
        points = {{39,-6},{32,-7},{18,-15},{14,-24},{13,-34},{15,-42},
                  {20,-49},{29,-51},{36,-51},{46,-50},{52,-43},{55,-35},
                  {53,-27},{53,-20},{51,-13},{46,-7},{39,-5},{39,-6}}),
      Line(
        origin = {13.758,27.517},
        points = {{-17,-40},{15,-40}},
        color = {191,0,0},
        thickness = 0.5),
      Polygon(
        origin = {13.758,27.517},
        lineColor = {191,0,0},
        fillColor = {191,0,0},
        fillPattern = FillPattern.Solid,
        points = {{-17,-46},{-17,-34},{-40,-40},{-17,-46}}),
      Line(
        origin = {13.758,27.517},
        points = {{-41,-17},{-9,-17}},
        color = {191,0,0},
        thickness = 0.5)}), Documentation(revisions="<html><ul>
  <li>October 28, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This package contains models to compute heat transfers such as at the
  inlet and outlet of a compressor.
</p>
</html>"));
end HeatTransfer;
