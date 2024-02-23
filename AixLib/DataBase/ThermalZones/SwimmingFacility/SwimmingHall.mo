within AixLib.DataBase.ThermalZones.SwimmingFacility;
record SwimmingHall "Swimming facility - Swimming hall"
  extends AixLib.DataBase.ThermalZones.ZoneBaseRecord(
    T_start = 305.15,
    withAirCap = true,
    VAir = 8215.0,
    AZone = 1325.0,
    hRad = 4.999999999999999,
    lat = 0.88645272708792,
    nOrientations = 4,
    AWin = {234.8, 154.256, 0.001, 18.6},
    ATransparent = {234.8, 154.256, 0.001, 18.6},
    hConWin = 2.7000000000000006,
    RWin = 0.002651937979922045,
    gWin = 0.67,
    UWin= 0.7993916878977316,
    ratioWinConRad = 0.03,
    AExt = {267.8, 154.256, 0.001, 62.0},
    hConExt = 2.6999999999999997,
    nExt = 1,
    RExt = {8.812807013524674e-05},
    RExtRem = 0.008465535712214946,
    CExt = {196846965.02638808},
    AInt = 297.6,
    hConInt = 2.7,
    nInt = 1,
    RInt = {0.000669412044811479},
    CInt = {38220884.26056525},
    AFloor = 552.0,
    hConFloor = 1.7000000000000002,
    nFloor = 1,
    RFloor = {0.000118732321526489},
    RFloorRem =  0.004636896916793544,
    CFloor = {285630073.87987393},
    ARoof = 1325.0,
    hConRoof = 1.7000000000000002,
    nRoof = 1,
       RRoof = {2.173460394952809e-05},
    RRoofRem = 0.004842295944118755,
    CRoof = {39709445.85946224},
    nOrientationsRoof = 1,
    tiltRoof = {0.0},
    aziRoof = {0.0},
    wfRoof = {1.0},
    aRoof = 0.5,
    aExt = 0.5,
    TSoil = 286.15,
    hConWallOut = 20.0,
    hRadWall = 5.0,
    hConWinOut = 20.0,
    hConRoofOut = 20.000000000000007,
    hRadRoof = 5.0,
    tiltExtWalls = {1.5707963267948966, 1.5707963267948966, 1.5707963267948966, 1.5707963267948966},
    aziExtWalls = {0.0, 1.5707963267948966, -1.5707963267948966, 3.141592653589793},
    wfWall = {0.5532406307521635, 0.3186732141049505, 2.0658724075883626e-06, 0.12808408927047849},
    wfWin = {0.575974409859269, 0.37839654415354085, 2.4530426314278916e-06, 0.045626592944558786},
    wfGro = 0.0,
    specificPeople = 0.05,
    internalGainsMoistureNoPeople = 0.0,
    fixedHeatFlowRatePersons = 120,
    activityDegree = 3.0,
    ratioConvectiveHeatPeople = 0.5,
    internalGainsMachinesSpecific = 0.0,
    ratioConvectiveHeatMachines = 0.75,
    lightingPowerSpecific = 10.5,
    ratioConvectiveHeatLighting = 0.9,
    useConstantACHrate = true,
    baseACH = 0.4,
    maxUserACH = 0.0,
    maxOverheatingACH = {3.0, 2.0},
    maxSummerACH = {1.0, 283.15, 290.15},
    winterReduction = {0.2, 273.15, 283.15},
    maxIrr = {100.0, 100.0, 100.0, 100.0},
    shadingFactor = {1.0, 1.0, 1.0, 1.0},
    withAHU = true,
    minAHU = 0.0,
    maxAHU = 174.3,
    hHeat = 2000000.0,
    lHeat = 0,
    KRHeat = 10000,
    TNHeat = 300,
    HeaterOn = false,
    hCool = 0,
    lCool = -2000000.0,
    KRCool = 10000,
    TNCool = 1,
    heaLoadFacOut=0,
    heaLoadFacGrd=0,
    CoolerOn = false,
    withIdealThresholds = false,
    TThresholdHeater = 303.15,
    TThresholdCooler = 308.15);
  annotation (Documentation(revisions="<html><ul>
  <li>November 27, 2019, by David Jansen:<br/>
    Integrate threshold for heater and cooler.
  </li>
  <li>February 28, 2019, by Niklas Huelsenbeck, dja, mre:<br/>
    Adapting nrPeople and nrPeopleMachines to area specific approach
  </li>
  <li>September 27, 2016, by Moritz Lauster:<br/>
    Reimplementation.
  </li>
  <li>June, 2015, by Moritz Lauster:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>
  <span style=\"font-family: MS Shell Dlg 2;\">Zone \"Office\" of an
  example building according to an office building with passive house
  standard. The building is divided in six zones, this is a typical
  zoning for an office building.</span>
</p>
</html>"));
end SwimmingHall;
