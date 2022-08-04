within AixLib.Fluid.Movers.Compressors.SimpleCompressors;
package CompressionProcesses "Package that contains different compression models"
  extends Modelica.Icons.InternalPackage;

annotation (Documentation(revisions="<html><ul>
  <li>October 29, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This package contains models describing compression processes. These
  models inherit from <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompression\">
  AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompression</a>
  and add the missing definitions for completition.
</p>
</html>"));
end CompressionProcesses;
