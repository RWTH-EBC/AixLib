within AixLib.DataBase.ThermalZones.MultizoneInterzonalsFixedHeater;
record MorschenichSfhFixedHeater_attic
  "Record for attic of MorschenichSfhFixedHeater example"
  extends AixLib.DataBase.ThermalZones.ZoneBaseRecord(
    T_start = 293.15,
    withAirCap = true,
    VAir = 75.78795696372634,
    AZone = 50.52377022336238,
    hRad = 7.750349138760984,
    lat = 0.88645272708792,
    nOrientations = 2,
    AWin = {0.14869610304800834, 0.0854780546614556},
    ATransparent = {0.14869610304800834, 0.0854780546614556},
    hConWin = 2.7000000000000006,
    RWin = 1.5215845888330657,
    gWin = 0.6,
    UWin= 1.9004689468829974,
    ratioWinConRad = 0.02,
    AExt = {7.82825722254796, 8.06360011905509},
    hConExt = 2.7000000000000006,
    nExt = 1,
    RExt = {0.004230796101479976},
    RExtRem = 0.02032557242299069,
    CExt = {6273497.6266179895},
    AInt = 0.0,
    hConInt = 0.0,
    nInt = 1,
    RInt = {0.0},
    CInt = {0.0},
    AFloor = 0.0,
    hConFloor = 0.0,
    nFloor = 1,
    RFloor = {0.0},
    RFloorRem =  0.0,
    CFloor = {0.0},
    ARoof = 75.72370770529446,
    hConRoof = 4.999999999999999,
    nRoof = 1,
    RRoof = {1.9138990862524574e-05},
    RRoofRem = 9.569495530074631e-05,
    CRoof = {2362579.5220066374},
    nOrientationsRoof = 2,
    tiltRoof = {0.8377580409572781, 0.8552113334772214},
    aziRoof = {1.239183768915974, -1.902408884673819},
    wfRoof = {0.5020416925535248, 0.49795830744647523},
    aRoof = 0.4,
    aExt = 0.5999999999999999,
    nIze = 1,
    AIze = {50.52377022336238},
    hConIze = {5.0},
    nIzeRC = 1,
    RIze = {{0.01989650625627703}},
    RIzeRem = {0.003523280978428377},
    CIze = {{7416783.851736545}},
    othZoneInd = {3},
    zoneInd = 1,
    TSoil = 286.15,
    TSoiDatSou = AixLib.BoundaryConditions.GroundTemperature.DataSourceGroTem.File,
    TSoiOffTim = 6004800,
    TSoiAmp = 0,
    TSoiFil = Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/LowOrder_ExampleData/t_soil_MorschenichSfhFixedHeater.txt"),
    hConWallOut = 20.0,
    hRadWall = 5.0,
    hConWinOut = 20.0,
    hConRoofOut = 19.999999999999996,
    hRadRoof = 4.999999999999999,
    tiltExtWalls = {1.5707963267948966, 1.5707963267948966},
    aziExtWalls = {-0.47123889803846897, 2.670353755551324},
    wfWall = {0.49259548800847114, 0.5074045119915288},
    wfWin = {0.6349808386307645, 0.36501916136923546},
    wfGro = 0.0,
    specificPeople = 0.02,
    internalGainsMoistureNoPeople = 0.5,
    fixedHeatFlowRatePersons = 70,
    activityDegree = 1.2,
    ratioConvectiveHeatPeople = 0.5,
    internalGainsMachinesSpecific = 2.0,
    ratioConvectiveHeatMachines = 0.75,
    lightingPowerSpecific = 7.0,
    ratioConvectiveHeatLighting = 0.5,
    useConstantACHrate = true,
    baseACH = 10.0,
    maxUserACH = 1.0,
    maxOverheatingACH = {3.0, 2.0},
    maxSummerACH = {1.0, 283.15, 290.15},
    winterReduction = {0.2, 273.15, 283.15},
    maxIrr = {10000.0, 10000.0},
    shadingFactor = {0.0, 0.0},
    withAHU = false,
    minAHU = 0.3,
    maxAHU = 0.6,
    hHeat = 25655.980698795167,
    lHeat = 0,
    KRHeat = 10000,
    TNHeat = 1,
    HeaterOn = false,
    hCool = 0,
    lCool = -25655.980698795167,
    heaLoadFacOut = 801.749396837349,
    heaLoadFacGrd = 0.0,
    KRCool = 10000,
    TNCool = 1,
    CoolerOn = false,
    withIdealThresholds = false,
    TThresholdHeater = 288.15,
    TThresholdCooler = 295.15);
end MorschenichSfhFixedHeater_attic;
