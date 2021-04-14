within AixLib.Systems.Benchmark.BaseClasses;
record BenchmarkCanteen "Canteen zone of  benchmark building"
  extends AixLib.DataBase.ThermalZones.ZoneBaseRecord(
    T_start=293.15,
    VAir=1800.0,
    AZone=600.0,
    hRad=5,
    lat=0.87266462599716,
    nOrientations=2,
    AWin={40,40},
    ATransparent={40,40},
    hConWin=12,
    RWin=1/(1.3*80),
    gWin=0.25,
    UWin=1.3,
    ratioWinConRad=0.09,
    AExt={20,20},
    hConExt=20,
    nExt=1,
    RExt={1/(0.3*40)},
    RExtRem=0.000380773816236,
    CExt={2*20*0.3*2100*880},
    AInt=2*30*3,
    hConInt=20,
    nInt=1,
    RInt={1/(2*0.3*30*3)},
    CInt={2*30*3*0.3*2100*880},
    AFloor=600,
    hConFloor=10,
    nFloor=1,
    RFloor={1/(0.16*600)},
    RFloorRem=1,
    CFloor={0.001},
    ARoof=600,
    hConRoof=30,
    nRoof=1,
    RRoof={1/(0.1814*600)},
    RRoofRem=0.00001,
    CRoof={20*30*0.3*2100*880},
    nOrientationsRoof=1,
    tiltRoof={0},
    aziRoof={0},
    wfRoof={1},
    aRoof=0.7,
    aExt=0.7,
    TSoil=283.15,
    hConWallOut=20.0,
    hRadWall=5,
    hConWinOut=20.0,
    hConRoofOut=20,
    hRadRoof=5,
    tiltExtWalls={1.5707963267949,1.5707963267949},
    aziExtWalls={3.1415926535898,0},
    wfWall={0.45,0.45},
    wfWin={0.5,0.5},
    wfGro=0.1,
    specificPeople=1/14,
    activityDegree=1.2,
    fixedHeatFlowRatePersons=125/600,
    ratioConvectiveHeatPeople=0.5,
    internalGainsMoistureNoPeople=0.5,
    internalGainsMachinesSpecific=213/600,
    ratioConvectiveHeatMachines=0.6,
    lightingPowerSpecific=2210/600,
    ratioConvectiveHeatLighting=0.6,
    useConstantACHrate=false,
    baseACH=0.2,
    maxUserACH=1,
    maxOverheatingACH={3.0,2.0},
    maxSummerACH={1.0,273.15 + 10,273.15 + 17},
    winterReduction={0.2,273.15,273.15 + 10},
    withAHU=false,
    minAHU=0,
    maxAHU=12,
    hHeat=167500,
    lHeat=0,
    KRHeat=1000,
    TNHeat=1,
    HeaterOn=false,
    hCool=0,
    lCool=-1,
    KRCool=1000,
    TNCool=1,
    CoolerOn=false,
        TThresholdHeater=273.15 + 15,
    TThresholdCooler=273.15 + 22,
    withIdealThresholds=false);                     //not area specific: W_per_person/area => input will be number of persons
  annotation (Documentation(revisions="<html>
 <ul>
  <li>
  February 28, 2019, by Niklas Huelsenbeck, dja, mre:<br/>
  Adapting nrPeople and nrPeopleMachines to area specific approach 
  </li>
  <li>
  September 27, 2016, by Moritz Lauster:<br/>
  Reimplementation.
  </li>
  <li>
  June, 2015, by Moritz Lauster:<br/>
  Implemented.
  </li>
 </ul>
 </html>", info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Zone &quot;Office&quot; of an example building according to an office building with passive house standard. The building is divided in six zones, this is a typical zoning for an office building. </span></p>
</html>"));
end BenchmarkCanteen;
