within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData4DDeltaTCon.VCLibPy;
partial record GenericVCLibPy4D
  "Partial record for 4D VCLibPy data for heat pumps"
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.GenericVCLibPy(
    final nDim=4,
    final scaleUnitsQCon_flow={"","K","K","K"},
    final outOrd={3,1,2,4},
    final scaleUnitsPEle={"","K","K","K"});
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>December 22, 2025</i> by Fabian Roemer:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1520\">AixLib #1623</a>)
  </li>
</ul>
</html>"));
end GenericVCLibPy4D;
