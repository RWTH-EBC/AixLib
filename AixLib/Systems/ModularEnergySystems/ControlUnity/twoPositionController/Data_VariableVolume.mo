within AixLib.Systems.ModularEnergySystems.ControlUnity.twoPositionController;
model Data_VariableVolume
  extends AixLib.DataBase.Storage.BufferStorageBaseDataDefinition(
    hTank=2.145,
    hLowerPortDemand=0.1,
    hUpperPortDemand=2.1,
    hLowerPortSupply=0.1,
    hUpperPortSupply=2.1,
    hHC1Up=1.60,
    hHC1Low=0.1,
    hHC2Up=0.7,
    hHC2Low=0.1,
    hHR=1,
    dTank=1.090,
    sWall=0.005,
    sIns=0.12,
    lambdaWall=50,
    lambdaIns=0.045,
    hTS1=0.1,
    hTS2=2.1,
    rhoIns=373,
    cIns=1000,
    rhoWall=373,
    cWall=1000,
    roughness=2.5e-5,
    pipeHC1=AixLib.DataBase.Pipes.Copper.Copper_22x1_5(),
    pipeHC2=DataBase.Pipes.Copper.Copper_28x1(),
    lengthHC1=118,
    lengthHC2=22);

equation

end Data_VariableVolume;
