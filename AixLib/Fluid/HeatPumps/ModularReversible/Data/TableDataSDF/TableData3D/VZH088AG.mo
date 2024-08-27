within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D;
record VZH088AG
  "Data for Danfoss VZH088AG scroll compressor machine"
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D.Generic(
    outOrd={2,1,3},
    facGai={1,1,100},
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    scaleUnitsQCon_flow={"degC","degC",""},
    dataUnitQCon_flow="W",
    datasetQCon_flow="/QCon",
    scaleUnitsPEle={"degC","degC",""},
    dataUnitPEle="W",
    datasetPEle="/Pel",
    filename="modelica://AixLib/Resources/Data/Fluid/HeatPumps/ModularReversible/Data/LookUpTable3D/VZH088AG.sdf",
    devIde="VZH088AG");

end VZH088AG;
