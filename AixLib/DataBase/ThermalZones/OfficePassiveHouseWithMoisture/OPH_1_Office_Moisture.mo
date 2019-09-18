within AixLib.DataBase.ThermalZones.OfficePassiveHouseWithMoisture;
record OPH_1_Office_Moisture "Office zone of office building considering moisture balance"
  extends AixLib.DataBase.ThermalZones.ZoneBaseRecord(
    T_start=293.15,
    VAir=6700.0,
    AZone=1675.0,
    hRad=5,
    lat=0.87266462599716,
    nOrientations=5,
    AWin={108.5,19.0,108.5,19.0,0},
    ATransparent={108.5,19.0,108.5,19.0,0},
    hConvWin=2.7,
    RWin=0.017727777777,
    gWin=0.78,
    UWin=2.1,
    ratioWinConRad=0.09,
    AExt={244.12,416.33,244.12,416.33,208.16},
    hConvExt=2.19,
    nExt=1,
    RExt={1.4142107968e-05},
    RExtRem=0.000380773816236,
    CExt={492976267.489},
    AInt=5862.5,
    hConvInt=2.27,
    nInt=1,
    RInt={1.13047235829e-05},
    CInt={1402628013.98},
    AFloor=0,
    hConvFloor=0,
    nFloor=1,
    RFloor={0.001},
    RFloorRem=0.001,
    CFloor={0.001},
    ARoof=0,
    hConvRoof=0,
    nRoof=1,
    RRoof={0.001},
    RRoofRem=0.001,
    CRoof={0.001},
    nOrientationsRoof=1,
    tiltRoof={0},
    aziRoof={0},
    wfRoof={1},
    aRoof=0.7,
    aExt=0.7,
    TSoil=283.15,
    hConvWallOut=20.0,
    hConvRadWall=5,
    hConvWinOut=20.0,
    hConvRoofOut=20,
    hRadRoof=5,
    tiltExtWalls={1.5707963267949,1.5707963267949,1.5707963267949,1.5707963267949,0},
    aziExtWalls={0,1.5707963267949,3.1415926535898,4.7123889803847,0},
    wfWall={0.2,0.2,0.2,0.2,0.1},
    wfWin={0.25,0.25,0.25,0.25,0},
    wfGro=0.1,
    specificPeople=1/14,
    activityDegree=1.2,
    fixedHeatFlowRatePersons=70,
    ratioConvectiveHeatPeople=0.5,
    internalGainsMoistureNoPeople=0.5,
    internalGainsMachinesSpecific=7.0,
    ratioConvectiveHeatMachines=0.6,
    lightingPowerSpecific=12.5,
    ratioConvectiveHeatLighting=0.6,
    useConstantACHrate=false,
    baseACH=0.2,
    maxUserACH=1,
    maxOverheatingACH={3.0,2.0},
    maxSummerACH={1.0,273.15 + 10,273.15 + 17},
    winterReduction={0.2,273.15,273.15 + 10},
    withAHU=true,
    minAHU=0,
    maxAHU=12,
    hHeat=167500,
    lHeat=0,
    KRHeat=1000,
    TNHeat=1,
    HeaterOn=true,
    hCool=0,
    lCool=-1,
    KRCool=1000,
    TNCool=1,
    CoolerOn=false);
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
end OPH_1_Office_Moisture;
