within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities;
package WallCells "Package that contains different wall cells"
  extends Modelica.Icons.VariantsPackage;

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  December 07, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This package contains different wall cells used by
moving boundary heat exchangers.<br/><br/>
Currently, just one simple wall cell is implemented 
in the package. This wall cell can be used for either 
direct-current or counter-currrent heat exchangers. 
</p>
</html>"));
end WallCells;
