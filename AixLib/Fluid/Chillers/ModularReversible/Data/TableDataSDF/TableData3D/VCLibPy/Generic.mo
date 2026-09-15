within AixLib.Fluid.Chillers.ModularReversible.Data.TableDataSDF.TableData3D.VCLibPy;
partial record Generic
  "Partial record for 3D VCLibPy data for chillers"
  extends GenericVCLibPy(
    final nDim=3,
    final scaleUnitsQEva_flow={"","K","K"},
    final outOrd={3,1,2},
    final scaleUnitsPEle={"","K","K"});
end Generic;
