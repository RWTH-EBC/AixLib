within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D.VCLibPy;
partial record Generic "Partial record for 3D VCLibPy data for heat pumps"
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.GenericVCLibPy(
    final nDim=3,
    final scaleUnitsQCon_flow={"","K","K"},
    final outOrd={3,1,2},
    final scaleUnitsPEle={"","K","K"});
end Generic;
