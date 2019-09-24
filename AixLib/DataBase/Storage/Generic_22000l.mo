within AixLib.DataBase.Storage;
record Generic_22000l
  extends BufferStorageBaseDataDefinition(
    hTank=3,
    hLowerPorts=0.05,
    hUpperPorts=2.95,
    hHC1Up=2.9,
    hHC1Low=0.1,
    hHC2Up=2.9,
    hHC2Low=0.1,
    hHR=1,
    dTank=6.111,
    sWall=0.005,
    sIns=0.14,
    lambdaWall=60,
    lambdaIns=0.040,
    hTS1=0.05,
    hTS2=2.95,
    rhoIns=45,
    cIns=1400,
    rhoWall=7850,
    cWall=400,
    roughness=2.5e-5,
    pipeHC1=AixLib.DataBase.Pipes.Copper.Copper_66_7x1_2(),
    pipeHC2=AixLib.DataBase.Pipes.Copper.Copper_66_7x1_2(),
    lengthHC1=150,
    lengthHC2=275);

  annotation (Icon(graphics),               Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Buffer Storage: Generic 2000 l</p>
<h4><font color=\"#008000\">References</font></h4>
<p>Base data definition for record used with <a
href=\"AixLib.Fluid.Storage.Storage\">AixLib.Fluid.Storage.Storage</a> and <a
href=\"AixLib.Fluid.Storage.BufferStorage\">AixLib.Fluid.Storage.BufferStorage</a> </p>
</html>"));
end Generic_22000l;
