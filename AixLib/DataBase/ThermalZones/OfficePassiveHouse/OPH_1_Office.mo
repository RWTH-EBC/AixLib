within AixLib.DataBase.ThermalZones.OfficePassiveHouse;
record OPH_1_Office "Office zone of office building"
  extends AixLib.DataBase.ThermalZones.ZoneBaseRecord(
    T_start = 293.15,
    VAir = 6700.0,
    AZone = 1675.0,
    alphaRad = 5,
    lat = 0.87266462599716,
    nOrientations = 5,
    AWin = {108.5, 19.0, 108.5, 19.0, 0},
    ATransparent = {108.5, 19.0, 108.5, 19.0, 0},
    alphaWin = 2.7,
    RWin = 0.017727777777,
    gWin = 0.78,
    UWin= 2.1,
    ratioWinConRad = 0.09,
    AExt = {244.12, 416.33, 244.12, 416.33, 208.16},
    alphaExt = 2.19,
    nExt = 1,
    RExt = {1.4142107968e-05},
    RExtRem = 0.000380773816236,
    CExt = {492976267.489},
    AInt = 5862.5,
    alphaInt = 2.27,
    nInt = 1,
    RInt = {1.13047235829e-05},
    CInt = {1402628013.98},
    AFloor = 0,
    alphaFloor = 0,
    nFloor = 1,
    RFloor = {0.001},
    RFloorRem = 0.001,
    CFloor = {0.001},
    ARoof = 0,
    alphaRoof = 0,
    nRoof = 1,
    RRoof = {0.001},
    RRoofRem = 0.001,
    CRoof = {0.001},
    nOrientationsRoof = 1,
    tiltRoof = {0},
    aziRoof = {0},
    wfRoof = {1},
    aRoof = 0.7,
    aExt = 0.7,
    TSoil = 283.15,
    alphaWallOut = 20.0,
    alphaRadWall = 5,
    alphaWinOut = 20.0,
    alphaRoofOut = 20,
    alphaRadRoof = 5,
    tiltExtWalls = {1.5707963267949, 1.5707963267949, 1.5707963267949, 1.5707963267949, 0},
    aziExtWalls = {0, 1.5707963267949, 3.1415926535898, 4.7123889803847, 0},
    wfWall = {0.2, 0.2, 0.2, 0.2, 0.1},
    wfWin = {0.25, 0.25, 0.25, 0.25, 0},
    wfGro = 0.1,
    nrPeople = 83.75,
    ratioConvectiveHeatPeople = 0.5,
    nrPeopleMachines = 117.25,
    ratioConvectiveHeatMachines = 0.6,
    lightingPower = 12.5,
    ratioConvectiveHeatLighting = 0.6,
    useConstantACHrate = false,
    baseACH = 0.2,
    maxUserACH = 1,
    maxOverheatingACH = {3.0, 2.0},
    maxSummerACH = {1.0, 273.15 + 10, 273.15 + 17},
    winterReduction = {0.2,273.15,273.15 + 10},
    withAHU = true,
    minAHU = 0,
    maxAHU = 12,
    hHeat = 167500,
    lHeat = 0,
    KRHeat = 1000,
    TNHeat = 1,
    HeaterOn = true,
    hCool = 0,
    lCool = -1,
    KRCool = 1000,
    TNCool = 1,
    CoolerOn = false);
  annotation (Documentation(revisions="<html>
 <ul>
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
end OPH_1_Office;
