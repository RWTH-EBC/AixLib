within AixLib.Fluid.Movers.Compressors.BaseClasses;
partial model PartialCompressor
  "Partial model for compressors that contains basic definitions used in 
  various compressor models"

  annotation (Icon(coordinateSystem(preserveAspectRatio=false),
              graphics={
                Ellipse(
                  extent={{80,80},{-80,-80}},
                  lineColor={0,0,0},
                  startAngle=0,
                  endAngle=360,
                  fillPattern=FillPattern.Sphere,
                  fillColor={214,214,214}),
                Line(
                  points={{74,-30},{-60,-52}},
                  color={0,0,0},
                  thickness=0.5),
                Line(
                  points={{74,30},{-58,54}},
                  color={0,0,0},
                  thickness=0.5)}),
                Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
  October 19, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end PartialCompressor;
