within AixLib.Systems.Benchmark.BaseClasses;
record BenchmarkWorkshop "Workshop zone of  benchmark building"
  extends AixLib.DataBase.ThermalZones.ZoneBaseRecord(
    T_start=293.15,
    VAir=2700.0,
    AZone=900.0,
    hRad=5,
    lat=0.87266462599716,
    nOrientations=3,
    AWin={60,60,60},
    ATransparent={60,60,60},
    hConWin=12,
    RWin=1/(1.3*180),
    gWin=0.25,
    UWin=1.3,
    ratioWinConRad=0.09,
    AExt={30,30,30},
    hConExt=20,
    nExt=1,
    RExt={1/(0.3*90)},
    RExtRem=0.1,
    CExt={3*30*0.3*2100*880},
    AInt=90,
    hConInt=20,
    nInt=1,
    RInt={1/(0.3*30*3)},
    CInt={30*3*0.3*2100*880},
    AFloor=900,
    hConFloor=10,
    nFloor=1,
    RFloor={1/(0.16*100)},
    RFloorRem=1,
    CFloor={0.001},
    ARoof=900,
    hConRoof=30,
    nRoof=1,
    RRoof={1/(0.1814*900)},
    RRoofRem=1,
    CRoof={30*30*0.3*2100*880},
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
    tiltExtWalls={1.5707963267949,1.5707963267949,1.5707963267949},
    aziExtWalls={3.1415926535898,0,1.5707963267949},
    wfWall={0.3,0.3,0.3},
    wfWin={0.333,0.333,0.333},
    wfGro=0.1,
    specificPeople=1/14,
    activityDegree=1.2,
    fixedHeatFlowRatePersons=209/900,
    ratioConvectiveHeatPeople=0.5,
    internalGainsMoistureNoPeople=0.5,
    internalGainsMachinesSpecific=200/900,
    ratioConvectiveHeatMachines=0.6,
    lightingPowerSpecific=4737/900,
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
end BenchmarkWorkshop;
