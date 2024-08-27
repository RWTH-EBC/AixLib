within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D;
record Carrier30XWH0254 "Data for Carrier 30XWH-0254 machine"
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D.Generic(
    outOrd={2,1,3},
    facGai={1,1,100},
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    scaleUnitsQCon_flow={"K","K",""},
    dataUnitQCon_flow="W",
    datasetQCon_flow="/QCon",
    scaleUnitsPEle={"K","K",""},
    dataUnitPEle="W",
    datasetPEle="/Pel",
    filename="modelica://AixLib/Resources/Data/Fluid/HeatPumps/ModularReversible/Data/LookUpTable3D/30XWH-0254.sdf",
    devIde="30XWH-0254");

end Carrier30XWH0254;
