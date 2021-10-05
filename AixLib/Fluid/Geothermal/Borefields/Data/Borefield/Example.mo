within AixLib.Fluid.Geothermal.Borefields.Data.Borefield;
record Example
  "Example definition of a borefield data record"
  extends
    AixLib.Fluid.Geothermal.Borefields.Data.Borefield.Template(
      filDat=AixLib.Fluid.Geothermal.Borefields.Data.Filling.Bentonite(),
      soiDat=AixLib.Fluid.Geothermal.Borefields.Data.Soil.SandStone(),
      conDat=AixLib.Fluid.Geothermal.Borefields.Data.Configuration.Example());
  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="borFieDat",
Documentation(
info="<html>
<p>This record presents an example on how to define borefield records
using the template in
<a href=\"modelica://AixLib.Fluid.Geothermal.Borefields.Data.Borefield.Template\">
AixLib.Fluid.Geothermal.Borefields.Data.Borefield.Template</a>.</p>
</html>",
revisions="<html>
<ul>
<li>
July 15, 2018, by Michael Wetter:<br/>
Revised implementation, added <code>defaultComponentPrefixes</code> and
<code>defaultComponentName</code>.
</li>
<li>
June 28, 2018, by Damien Picard:<br/>
First implementation.
</li>
</ul>
</html>"));
end Example;
