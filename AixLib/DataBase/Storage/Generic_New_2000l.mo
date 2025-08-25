within AixLib.DataBase.Storage;
record Generic_New_2000l "Pseudo storage with 2000 l (standing)"
  extends BufferStorageBaseDataDefinition(
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

  annotation (Icon(graphics),               Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Buffer Storage: Generic 2000 l
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Base data definition for record used with <a href=
  \"AixLib.Fluid.Storage.Storage\">AixLib.Fluid.Storage.Storage</a> and
  <a href=
  \"AixLib.Fluid.Storage.BufferStorage\">AixLib.Fluid.Storage.BufferStorage</a>
</p>
</html>"));
end Generic_New_2000l;
