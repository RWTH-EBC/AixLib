within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData3D;
record VZH088AG
  extends AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData3D.GenericHeatPump(
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    scaleUnitsQUse_flow={"K","K",""},
    dataUnitQUse_flow="W",
    datasetQUse_flow="/QCon",
    scaleUnitsPEle={"K","K",""},
    dataUnitPEle="W",
    datasetPEle="/Pel",
    nConv=100,
    filename="modelica://Resources/Data/Fluid/BaseClasses/PerformanceData/LookUpTableND/VZH088AG.sdf",
    nDim=3,
    devIde="VZH088AG");

end VZH088AG;
