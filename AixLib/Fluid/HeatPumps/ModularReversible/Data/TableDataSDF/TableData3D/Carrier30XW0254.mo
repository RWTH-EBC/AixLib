within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D;
record Carrier30XW0254 "Data for Carrier 30XW-0254 machine"
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D.Generic(
    facGai={1,1,100},
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    scaleUnitsQCon_flow={"K","K",""},
    dataUnitQCon_flow="W",
    datasetQCon_flow="/QCon",
    scaleUnitsPEle={"K","K",""},
    dataUnitPEle="W",
    datasetPEle="/Pel",
    filename="modelica://AixLib/Resources/Data/Fluid/HeatPumps/ModularReversible/Data/LookUpTable3D/30XW-0254.sdf",
    devIde="30XW-0254");

end Carrier30XW0254;
