within AixLib.DataBase.Storage;
record Wastewater_500l "Wastewater storage data for a 500 l storage"
  extends BufferStorageBaseDataDefinition(
    hTank=1.643 - hLowerPorts,
    hHC1Up=1.6,
    hHC1Low=0.1,
    hHC2Up=0.7,
    hHC2Low=hHC2Up,
    hHR=1,
    hLowerPorts=0.148/2,
    hUpperPorts=hTank - hLowerPorts,
    dTank=0.650,
    sWall=0.005,
    sIns=0.08,
    lambdaWall=50,
    lambdaIns=0.045,
    hTS1=hLowerPorts,
    hTS2=hUpperPorts,
    rhoIns=373,
    cIns=1000,
    rhoWall=373,
    cWall=1000,
    roughness=2.5e-5,
    pipeHC1=AixLib.DataBase.Pipes.Copper.Copper_22x1_5(),
    pipeHC2=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
    lengthHC1=20,
    lengthHC2=Modelica.Constants.eps);

  annotation (Icon(graphics),               Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Buffer Storage: Buderus Logalux SF 500 l</p>
<h4><font color=\"#008000\">References</font></h4>
<p>Record is used with <a
href=\"HVAC.Components.BufferStorage.BufferStorageHeatingcoils\">HVAC.Components.BufferStorage.BufferStorageHeatingcoils</a></p>
</html>"));
end Wastewater_500l;
