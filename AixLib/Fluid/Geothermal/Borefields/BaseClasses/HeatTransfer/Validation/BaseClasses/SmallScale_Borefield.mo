within AixLib.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.Validation.BaseClasses;
record SmallScale_Borefield
  "Borefield data record for the Cimmino and Bernier (2015) experiment"
  extends AixLib.Fluid.Geothermal.Borefields.Data.Borefield.Template(
      filDat=AixLib.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.Validation.BaseClasses.SmallScale_Filling(),
      soiDat=AixLib.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.Validation.BaseClasses.SmallScale_Soil(),
      conDat=AixLib.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.Validation.BaseClasses.SmallScale_Configuration());

  annotation (
  defaultComponentPrefixes="parameter",
  defaultComponentName="borFieDat",
Documentation(
info="<html>
<p>
This record contains the borefield data of the Cimmino and
Bernier (2015) experiment.
</p>
<h4>References</h4>
<p>
Cimmino, M. and Bernier, M. 2015. <i>Experimental determination of the
g-functions of a small-scale geothermal borehole</i>. Geothermics 56: 60-71.
</p>
</html>",
revisions="<html>
<ul>
<li>
July 15, 2018, by Michael Wetter:<br/>
Revised implementation, added <code>defaultComponentPrefixes</code> and
<code>defaultComponentName</code>.
</li>
<li>
June 28, 2018, by Massimo Cimmino:<br/>
First implementation.
</li>
</ul>
</html>"));
end SmallScale_Borefield;
