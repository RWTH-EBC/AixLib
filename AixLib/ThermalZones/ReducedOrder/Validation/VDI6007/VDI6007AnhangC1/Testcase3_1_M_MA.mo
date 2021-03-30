within AixLib.ThermalZones.ReducedOrder.Validation.VDI6007.VDI6007AnhangC1;
model Testcase3_1_M_MA "VDI 6007 Anhang C1 Test case 3.1 model"
  extends Modelica.Icons.Example;
  RC.TwoElements thermalZoneTwoElements(
    hConExt = 3.4035830618892504,
    hConWin = 2.6999999999999997,
    gWin = 0.64,
    nExt=1,
    nInt=1,
    ratioWinConRad = 0.07,
    AInt = 57.26,
    RWin = 0.017688475953143712,
    hRad = 5.0,
    RExt = {0.00893636412272357},
    RExtRem = 0.049946042835872874,
    CExt = {4025391.7132654707},
    RInt = {0.003746438296267089},
    CInt = {9295884.709826564},
    hConInt = 2.3725462801257424,
    indoorPortIntWalls=false,
    VAir = 52.5,
    nOrientations = 2,
    redeclare final package Medium = Modelica.Media.Air.SimpleAir,
    AWin = {0.0, 0.0},
    ATransparent = {5.13, 0.0},
    AExt = {13.260000000000002, 19.5},
    extWallRC(thermCapExt(each T(fixed=true))),
    T_start=295.15,
    intWallRC(thermCapInt(each T(fixed=true))),
    nPorts=2)
    "Thermal zone"
    annotation (Placement(transformation(extent={{20,52},{68,88}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWall
    "Outdoor convective heat transfer"
    annotation (Placement(transformation(extent={{12,72},{0,60}})));
  Modelica.Blocks.Sources.Constant hConWall(k=25*13.260000000000002)
    "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(
    transformation(
    extent={{-4,-4},{4,4}},
    rotation=90,
    origin={6,50})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
    "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-20,60},{-8,72}})));
  EquivalentAirTemperature.VDI6007 eqAirTemp(
    aExt=0.6,
    hConWallOut=20,
    hRad=5,
    withLongwave=true,
    n=2,
    wfWall = {0.19216566924621095, 0.34813212447347686},
    wfWin = {0.45970220628031216, 0.0},
    wfGro = 0,
    TGro=288.15)
    "Equivalent air temperature"
    annotation (Placement(transformation(extent={{-58,42},{-38,62}})));
  Modelica.Blocks.Sources.CombiTimeTable intGaiMisc(
    tableOnFile=true,
    tableName="Sonstiges_One_week_MA",
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/VDI6007C1_Testcases/Sonstiges_One_week_MA.txt"),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,0; 3600,0; 7200,0; 10800,0; 14400,0; 18000,0; 21600,0; 25200,0; 28800,
        150; 32400,300; 36000,300; 39600,300; 43200,300; 46800,150; 50400,300; 54000,
        300; 57600,300; 61200,150; 64800,0; 68400,0; 72000,0; 75600,0; 79200,0;
        82800,0; 86400,0; 90000,0; 93600,0; 97200,0; 100800,0; 104400,0; 108000,
        0; 111600,0; 115200,150; 118800,300; 122400,300; 126000,300; 129600,300;
        133200,150; 136800,300; 140400,300; 144000,300; 147600,150; 151200,0; 154800,
        0; 158400,0; 162000,0; 165600,0; 169200,0; 172800,0; 176400,0; 180000,0;
        183600,0; 187200,0; 190800,0; 194400,0; 198000,0; 201600,150; 205200,300;
        208800,300; 212400,300; 216000,300; 219600,150; 223200,300; 226800,300;
        230400,300; 234000,150; 237600,0; 241200,0; 244800,0; 248400,0; 252000,0;
        255600,0; 259200,0; 262800,0; 266400,0; 270000,0; 273600,0; 277200,0; 280800,
        0; 284400,0; 288000,0; 291600,0; 295200,0; 298800,0; 302400,0; 306000,0;
        309600,0; 313200,0; 316800,0; 320400,0; 324000,0; 327600,0; 331200,0; 334800,
        0; 338400,0; 342000,0; 345600,0; 349200,0; 352800,0; 356400,0; 360000,0;
        363600,0; 367200,0; 370800,0; 374400,0; 378000,0; 381600,0; 385200,0; 388800,
        0; 392400,0; 396000,0; 399600,0; 403200,0; 406800,0; 410400,0; 414000,0;
        417600,0; 421200,0; 424800,0; 428400,0; 432000,0; 435600,0; 439200,0; 442800,
        0; 446400,0; 450000,0; 453600,0; 457200,0; 460800,150; 464400,300; 468000,
        300; 471600,300; 475200,300; 478800,150; 482400,300; 486000,300; 489600,
        300; 493200,150; 496800,0; 500400,0; 504000,0; 507600,0; 511200,0; 514800,
        0; 518400,0; 522000,0; 525600,0; 529200,0; 532800,0; 536400,0; 540000,0;
        543600,0; 547200,150; 550800,300; 554400,300; 558000,300; 561600,300; 565200,
        150; 568800,300; 572400,300; 576000,300; 579600,150; 583200,0; 586800,0;
        590400,0; 594000,0; 597600,0; 601200,0; 604800,0],
    columns={2}) "Table with other internal gains for one week"
    annotation (Placement(transformation(extent={{-6,-2},{10,14}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow ligCon
    "Convective heat flow lighting"
    annotation (Placement(transformation(extent={{50,-26},{70,-6}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow ligRad
    "Radiative heat flow lighting"
    annotation (Placement(transformation(extent={{50,-42},{70,-22}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow miscCon
    "Convective heat flow others"
    annotation (Placement(transformation(extent={{50,4},{70,24}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow miscRad
    "Radiative heat flow others"
    annotation (Placement(transformation(extent={{50,-12},{70,8}})));
  Modelica.Blocks.Math.Gain gain(k=1.2/3600)
    "Conversion to kg/s (rho_air=1.2 kg/m^3)"
    annotation (Placement(transformation(extent={{-124,-1},{-110,13}})));
  Fluid.Sources.MassFlowSource_T        ventilationIn(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    nPorts=1)
    "Fan"
    annotation (Placement(transformation(extent={{-94,-12},{-74,8}})));
  Modelica.Blocks.Math.Gain gain1(k=-1) "Reverses ventilation rate"
    annotation (Placement(transformation(extent={{-126,-33},{-112,-19}})));
  Fluid.Sources.MassFlowSource_T        ventilationOut(
    use_m_flow_in=true,
    use_T_in=false,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    nPorts=1)
    "Fan"
    annotation (Placement(transformation(extent={{-94,-44},{-74,-24}})));
  Modelica.Blocks.Sources.CombiTimeTable InfVen(
    columns={2},
    tableOnFile=false,
    tableName="NoName",
    fileName="NoName",
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,15; 3600,15; 7200,15; 10800,15; 14400,15; 18000,15; 21600,15; 25200,
        15; 28800,60; 32400,60; 36000,60; 39600,60; 43200,60; 46800,60; 50400,60;
        54000,60; 57600,60; 61200,60; 64800,15; 68400,15; 72000,15; 75600,15; 79200,
        15; 82800,15; 86400,15; 90000,15; 93600,15; 97200,15; 100800,15; 104400,
        15; 108000,15; 111600,15; 115200,60; 118800,60; 122400,60; 126000,60; 129600,
        60; 133200,60; 136800,60; 140400,60; 144000,60; 147600,60; 151200,15; 154800,
        15; 158400,15; 162000,15; 165600,15; 169200,15; 172800,15; 176400,15; 180000,
        15; 183600,15; 187200,15; 190800,15; 194400,15; 198000,15; 201600,60; 205200,
        60; 208800,60; 212400,60; 216000,60; 219600,60; 223200,60; 226800,60; 230400,
        60; 234000,60; 237600,15; 241200,15; 244800,15; 248400,15; 252000,15; 255600,
        15; 259200,15; 262800,15; 266400,15; 270000,15; 273600,15; 277200,15; 280800,
        15; 284400,15; 288000,15; 291600,15; 295200,15; 298800,15; 302400,15; 306000,
        15; 309600,15; 313200,15; 316800,15; 320400,15; 324000,15; 327600,15; 331200,
        15; 334800,15; 338400,15; 342000,15; 345600,15; 349200,15; 352800,15; 356400,
        15; 360000,15; 363600,15; 367200,15; 370800,15; 374400,15; 378000,15; 381600,
        15; 385200,15; 388800,15; 392400,15; 396000,15; 399600,15; 403200,15; 406800,
        15; 410400,15; 414000,15; 417600,15; 421200,15; 424800,15; 428400,15; 432000,
        15; 435600,15; 439200,15; 442800,15; 446400,15; 450000,15; 453600,15; 457200,
        15; 460800,60; 464400,60; 468000,60; 471600,60; 475200,60; 478800,60; 482400,
        60; 486000,60; 489600,60; 493200,60; 496800,15; 500400,15; 504000,15; 507600,
        15; 511200,15; 514800,15; 518400,15; 522000,15; 525600,15; 529200,15; 532800,
        15; 536400,15; 540000,15; 543600,15; 547200,60; 550800,60; 554400,60; 558000,
        60; 561600,60; 565200,60; 568800,60; 572400,60; 576000,60; 579600,60; 583200,
        15; 586800,15; 590400,15; 594000,15; 597600,15; 601200,15; 604800,15])
    "Infiltration in m^3/h for one week"
    annotation (Placement(transformation(extent={{-150,0},{-138,12}})));
  BoundaryConditions.WeatherData.Bus        weaBus "Weather data bus"
    annotation (Placement(
    transformation(extent={{-120,28},{-86,60}}), iconTransformation(
    extent={{-70,-12},{-50,8}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow hea "Ideal heater"
    annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC_hea
    "Convert set temperature from degC to Kelvin"
    annotation (Placement(transformation(extent={{-82,-66},{-70,-54}})));
  Controls.Continuous.LimPID        conHea(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    yMax=1,
    yMin=0,
    Ti=4) "Heating controller"
    annotation (Placement(transformation(extent={{-62,-68},{-46,-52}})));
  Modelica.Blocks.Math.Gain gainHea(k=1500) "Heating Power"
    annotation (Placement(transformation(extent={{-38,-66},{-26,-54}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow coo "Ideal cooler"
    annotation (Placement(transformation(extent={{-20,-96},{0,-76}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC_coo
    "Convert set temperature from degC to Kelvin"
    annotation (Placement(transformation(extent={{-82,-92},{-70,-80}})));
  Controls.Continuous.LimPID        conCoo(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=18,
    yMax=0,
    yMin=-1,
    Ti=2300)
          "Cooling controller"
    annotation (Placement(transformation(extent={{-62,-94},{-46,-78}})));
  Modelica.Blocks.Math.Gain gainCoo(k=1180) "Cooling Power"
    annotation (Placement(transformation(extent={{-38,-92},{-26,-80}})));
  BoundaryConditions.InternalGains.Humans.HumanSensibleHeatTemperatureDependent
    humanSensibleHeatTemperatureDependent(
    specificPersons=2/18.75,
    ratioConvectiveHeat=0.5,
    roomArea=18.75,
    activityDegree=2)
    annotation (Placement(transformation(extent={{50,-58},{70,-38}})));
  Modelica.Blocks.Sources.CombiTimeTable intGaiPer(
    tableOnFile=true,
    tableName="Personen_One_week_MA",
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/VDI6007C1_Testcases/Personen_One_week_MA.txt"),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,0; 3600,0; 7200,0; 10800,0; 14400,0; 18000,0; 21600,0; 25200,0; 28800,
        1; 32400,2; 36000,2; 39600,2; 43200,2; 46800,1; 50400,2; 54000,2; 57600,
        2; 61200,1; 64800,0; 68400,0; 72000,0; 75600,0; 79200,0; 82800,0; 86400,
        0; 90000,0; 93600,0; 97200,0; 100800,0; 104400,0; 108000,0; 111600,0; 115200,
        1; 118800,2; 122400,2; 126000,2; 129600,2; 133200,1; 136800,2; 140400,2;
        144000,2; 147600,1; 151200,0; 154800,0; 158400,0; 162000,0; 165600,0; 169200,
        0; 172800,0; 176400,0; 180000,0; 183600,0; 187200,0; 190800,0; 194400,0;
        198000,0; 201600,1; 205200,2; 208800,2; 212400,2; 216000,2; 219600,1; 223200,
        2; 226800,2; 230400,2; 234000,1; 237600,0; 241200,0; 244800,0; 248400,0;
        252000,0; 255600,0; 259200,0; 262800,0; 266400,0; 270000,0; 273600,0; 277200,
        0; 280800,0; 284400,0; 288000,0; 291600,0; 295200,0; 298800,0; 302400,0;
        306000,0; 309600,0; 313200,0; 316800,0; 320400,0; 324000,0; 327600,0; 331200,
        0; 334800,0; 338400,0; 342000,0; 345600,0; 349200,0; 352800,0; 356400,0;
        360000,0; 363600,0; 367200,0; 370800,0; 374400,0; 378000,0; 381600,0; 385200,
        0; 388800,0; 392400,0; 396000,0; 399600,0; 403200,0; 406800,0; 410400,0;
        414000,0; 417600,0; 421200,0; 424800,0; 428400,0; 432000,0; 435600,0; 439200,
        0; 442800,0; 446400,0; 450000,0; 453600,0; 457200,0; 460800,1; 464400,2;
        468000,2; 471600,2; 475200,2; 478800,1; 482400,2; 486000,2; 489600,2; 493200,
        1; 496800,0; 500400,0; 504000,0; 507600,0; 511200,0; 514800,0; 518400,0;
        522000,0; 525600,0; 529200,0; 532800,0; 536400,0; 540000,0; 543600,0; 547200,
        1; 550800,2; 554400,2; 558000,2; 561600,2; 565200,1; 568800,2; 572400,2;
        576000,2; 579600,1; 583200,0; 586800,0; 590400,0; 594000,0; 597600,0; 601200,
        0; 604800,0],
    columns={2})
    "Table with number of people in the room for one week (Wed-Tue)"
    annotation (Placement(transformation(extent={{16,-56},{32,-40}})));

  Modelica.Blocks.Math.Gain ratioConRad(k=0.5)
    "Ratio of convective to radiative heat"
    annotation (Placement(transformation(extent={{30,0},{42,12}})));
  Modelica.Blocks.Sources.CombiTimeTable intGaiLigh(
    tableOnFile=true,
    tableName="Beleuchtung_One_year_MA_(1-3+10-12WZ,Rest_CDD)",
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/VDI6007C1_Testcases/Beleuchtung_One_year_MA_(1-3+10-12WZ,Rest_CDD).txt"),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,0; 3600,0; 7200,0; 10800,0; 14400,0; 18000,0; 21600,0; 25200,0; 28800,
        150; 32400,300; 36000,300; 39600,300; 43200,300; 46800,150; 50400,300; 54000,
        300; 57600,300; 61200,150; 64800,0; 68400,0; 72000,0; 75600,0; 79200,0;
        82800,0; 86400,0; 90000,0; 93600,0; 97200,0; 100800,0; 104400,0; 108000,
        0; 111600,0; 115200,150; 118800,300; 122400,300; 126000,300; 129600,300;
        133200,150; 136800,300; 140400,300; 144000,300; 147600,150; 151200,0; 154800,
        0; 158400,0; 162000,0; 165600,0; 169200,0; 172800,0; 176400,0; 180000,0;
        183600,0; 187200,0; 190800,0; 194400,0; 198000,0; 201600,150; 205200,300;
        208800,300; 212400,300; 216000,300; 219600,150; 223200,300; 226800,300;
        230400,300; 234000,150; 237600,0; 241200,0; 244800,0; 248400,0; 252000,0;
        255600,0; 259200,0; 262800,0; 266400,0; 270000,0; 273600,0; 277200,0; 280800,
        0; 284400,0; 288000,0; 291600,0; 295200,0; 298800,0; 302400,0; 306000,0;
        309600,0; 313200,0; 316800,0; 320400,0; 324000,0; 327600,0; 331200,0; 334800,
        0; 338400,0; 342000,0; 345600,0; 349200,0; 352800,0; 356400,0; 360000,0;
        363600,0; 367200,0; 370800,0; 374400,0; 378000,0; 381600,0; 385200,0; 388800,
        0; 392400,0; 396000,0; 399600,0; 403200,0; 406800,0; 410400,0; 414000,0;
        417600,0; 421200,0; 424800,0; 428400,0; 432000,0; 435600,0; 439200,0; 442800,
        0; 446400,0; 450000,0; 453600,0; 457200,0; 460800,150; 464400,300; 468000,
        300; 471600,300; 475200,300; 478800,150; 482400,300; 486000,300; 489600,
        300; 493200,150; 496800,0; 500400,0; 504000,0; 507600,0; 511200,0; 514800,
        0; 518400,0; 522000,0; 525600,0; 529200,0; 532800,0; 536400,0; 540000,0;
        543600,0; 547200,150; 550800,300; 554400,300; 558000,300; 561600,300; 565200,
        150; 568800,300; 572400,300; 576000,300; 579600,150; 583200,0; 586800,0;
        590400,0; 594000,0; 597600,0; 601200,0; 604800,0],
    columns={2}) "Table with internal lightning gains for one year?"
    annotation (Placement(transformation(extent={{-2,-32},{14,-16}})));

  Modelica.Blocks.Math.Gain ratioConRad1(k=0.5)
    "Ratio of convective to radiative heat"
    annotation (Placement(transformation(extent={{30,-30},{42,-18}})));
  Modelica.Blocks.Sources.CombiTimeTable setTempHeat(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    table=[0,18; 3600,18; 7200,18; 10800,18; 14400,18; 18000,18; 21600,18; 25200,
        22; 28800,22; 32400,22; 36000,22; 39600,22; 43200,22; 46800,22; 50400,22;
        54000,22; 57600,22; 61200,22; 64800,22; 68400,18; 72000,18; 75600,18; 79200,
        18; 82800,18; 86400,18; 90000,18; 93600,18; 97200,18; 100800,18; 104400,
        18; 108000,18; 111600,22; 115200,22; 118800,22; 122400,22; 126000,22; 129600,
        22; 133200,22; 136800,22; 140400,22; 144000,22; 147600,22; 151200,22; 154800,
        18; 158400,18; 162000,18; 165600,18; 169200,18; 172800,18; 176400,18; 180000,
        18; 183600,18; 187200,18; 190800,18; 194400,18; 198000,22; 201600,22; 205200,
        22; 208800,22; 212400,22; 216000,22; 219600,22; 223200,22; 226800,22; 230400,
        22; 234000,22; 237600,22; 241200,18; 244800,18; 248400,18; 252000,18; 255600,
        18; 259200,18; 262800,18; 266400,18; 270000,18; 273600,18; 277200,18; 280800,
        18; 284400,18; 288000,18; 291600,18; 295200,18; 298800,18; 302400,18; 306000,
        18; 309600,18; 313200,18; 316800,18; 320400,18; 324000,18; 327600,18; 331200,
        18; 334800,18; 338400,18; 342000,18; 345600,18; 349200,18; 352800,18; 356400,
        18; 360000,18; 363600,18; 367200,18; 370800,18; 374400,18; 378000,18; 381600,
        18; 385200,18; 388800,18; 392400,18; 396000,18; 399600,18; 403200,18; 406800,
        18; 410400,18; 414000,18; 417600,18; 421200,18; 424800,18; 428400,18; 432000,
        18; 435600,18; 439200,18; 442800,18; 446400,18; 450000,18; 453600,18; 457200,
        22; 460800,22; 464400,22; 468000,22; 471600,22; 475200,22; 478800,22; 482400,
        22; 486000,22; 489600,22; 493200,22; 496800,22; 500400,18; 504000,18; 507600,
        18; 511200,18; 514800,18; 518400,18; 522000,18; 525600,18; 529200,18; 532800,
        18; 536400,18; 540000,18; 543600,22; 547200,22; 550800,22; 554400,22; 558000,
        22; 561600,22; 565200,22; 568800,22; 572400,22; 576000,22; 579600,22; 583200,
        22; 586800,18; 590400,18; 594000,18; 597600,18; 601200,18; 604800,18])
    "Set temperature for convective heater"
    annotation (Placement(transformation(extent={{-114,-68},{-98,-52}})));
  Modelica.Blocks.Sources.CombiTimeTable setTempCool(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    table=[0,100; 3600,100; 7200,100; 10800,100; 14400,100; 18000,100; 21600,100;
        25200,26; 28800,26; 32400,26; 36000,26; 39600,26; 43200,26; 46800,26; 50400,
        26; 54000,26; 57600,26; 61200,26; 64800,26; 68400,100; 72000,100; 75600,
        100; 79200,100; 82800,100; 86400,100; 90000,100; 93600,100; 97200,100; 100800,
        100; 104400,100; 108000,100; 111600,26; 115200,26; 118800,26; 122400,26;
        126000,26; 129600,26; 133200,26; 136800,26; 140400,26; 144000,26; 147600,
        26; 151200,26; 154800,100; 158400,100; 162000,100; 165600,100; 169200,100;
        172800,100; 176400,100; 180000,100; 183600,100; 187200,100; 190800,100;
        194400,100; 198000,26; 201600,26; 205200,26; 208800,26; 212400,26; 216000,
        26; 219600,26; 223200,26; 226800,26; 230400,26; 234000,26; 237600,26; 241200,
        100; 244800,100; 248400,100; 252000,100; 255600,100; 259200,100; 262800,
        100; 266400,100; 270000,100; 273600,100; 277200,100; 280800,100; 284400,
        100; 288000,100; 291600,100; 295200,100; 298800,100; 302400,100; 306000,
        100; 309600,100; 313200,100; 316800,100; 320400,100; 324000,100; 327600,
        100; 331200,100; 334800,100; 338400,100; 342000,100; 345600,100; 349200,
        100; 352800,100; 356400,100; 360000,100; 363600,100; 367200,100; 370800,
        100; 374400,100; 378000,100; 381600,100; 385200,100; 388800,100; 392400,
        100; 396000,100; 399600,100; 403200,100; 406800,100; 410400,100; 414000,
        100; 417600,100; 421200,100; 424800,100; 428400,100; 432000,100; 435600,
        100; 439200,100; 442800,100; 446400,100; 450000,100; 453600,100; 457200,
        26; 460800,26; 464400,26; 468000,26; 471600,26; 475200,26; 478800,26; 482400,
        26; 486000,26; 489600,26; 493200,26; 496800,26; 500400,100; 504000,100;
        507600,100; 511200,100; 514800,100; 518400,100; 522000,100; 525600,100;
        529200,100; 532800,100; 536400,100; 540000,100; 543600,26; 547200,26; 550800,
        26; 554400,26; 558000,26; 561600,26; 565200,26; 568800,26; 572400,26; 576000,
        26; 579600,26; 583200,26; 586800,100; 590400,100; 594000,100; 597600,100;
        601200,100; 604800,100]) "Set temperature for cooling ceiling"
    annotation (Placement(transformation(extent={{-114,-94},{-98,-78}})));
  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.TemperaturesAndSkyCover,
    filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/WeatherData/VDI2078_MA_City_Mannheim.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-146,58},{-126,78}})));

  BoundaryConditions.SolarIrradiation.DiffusePerez        HDifTil[2](
    each outSkyCon=true,
    each outGroCon=true,
    each rho=0.2,
    til={1.5707963267949,0},
    each lat=0.86393797973719,
    azi={3.1415926535898,0})
    "Calculates diffuse solar radiation on titled surface for all directions"
    annotation (Placement(transformation(extent={{-104,128},{-84,148}})));
  BoundaryConditions.SolarIrradiation.DirectTiltedSurface        HDirTil[2](
    til={1.5707963267949,0},
    each lat=0.86393797973719,
    azi={3.1415926535898,0})
    "Calculates direct solar radiation on titled surface for all directions"
    annotation (Placement(transformation(extent={{-102,164},{-82,184}})));
  SolarGain.CorrectionGDoublePane
    corGDoublePane(n=2, UWin=1.4)
    "Correction factor for solar transmission"
    annotation (Placement(transformation(extent={{-28,166},{-8,186}})));
  Modelica.Blocks.Math.Add solRad[2]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{-72,118},{-62,128}})));
  SolarGain.SimpleExternalShading simpleExternalShading(
    final nOrientations=2,
    final gValues={0.64,0.0},
    final maxIrrs={200,0.0})
    annotation (Placement(transformation(extent={{-44,74},{-38,80}})));
equation
  connect(theConWall.solid, thermalZoneTwoElements.extWall)
    annotation (Line(points={{12,66},{20,66}},color={191,0,0}));
  connect(hConWall.y, theConWall.Gc)
    annotation (Line(points={{6,54.4},{6,60}},   color={0,0,127}));
  connect(eqAirTemp.TEqAir,preTem. T)
    annotation (Line(points={{-37,52},{-34,52},{-34,66},{-21.2,66}},
    color={0,0,127}));
  connect(preTem.port, theConWall.fluid)
    annotation (Line(points={{-8,66},{0,66}},   color={191,0,0}));
  connect(ligCon.port, thermalZoneTwoElements.intGainsConv) annotation (Line(
        points={{70,-16},{98,-16},{98,74},{68,74}}, color={191,0,0}));
  connect(ligRad.port, thermalZoneTwoElements.intGainsRad) annotation (Line(
        points={{70,-32},{106,-32},{106,78},{68,78}}, color={191,0,0}));
  connect(gain.y,gain1. u)
    annotation (Line(points={{-109.3,6},{-108,6},{-108,-10},{-134,-10},{-134,-26},
          {-127.4,-26}},                   color={0,0,127}));
  connect(gain1.y,ventilationOut. m_flow_in)
    annotation (Line(points={{-111.3,-26},{-96,-26}},color={0,0,127}));
  connect(gain.u,InfVen. y[1])
    annotation (Line(points={{-125.4,6},{-137.4,6}},   color={0,0,127}));
  connect(gain.y,ventilationIn. m_flow_in)
    annotation (Line(points={{-109.3,6},{-96,6}},    color={0,0,127}));
  connect(weaBus.TDryBul,ventilationIn. T_in) annotation (Line(
      points={{-103,44},{-103,36},{-102,36},{-102,2},{-96,2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul, eqAirTemp.TDryBul)
    annotation (Line(
    points={{-103,44},{-103,36},{-76,36},{-76,46},{-60,46}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%first",
    index=-1,
    extent={{-6,3},{-6,3}}));
  connect(weaBus.TBlaSky, eqAirTemp.TBlaSky)
    annotation (Line(
    points={{-103,44},{-96,44},{-96,52},{-60,52}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%first",
    index=-1,
    extent={{-6,3},{-6,3}}));
  connect(miscCon.port, thermalZoneTwoElements.intGainsConv) annotation (Line(
        points={{70,14},{98,14},{98,74},{68,74}},   color={191,0,0}));
  connect(miscRad.port, thermalZoneTwoElements.intGainsRad) annotation (Line(
        points={{70,-2},{106,-2},{106,78},{68,78}},   color={191,0,0}));
  connect(from_degC_hea.y,conHea. u_s)
    annotation (Line(points={{-69.4,-60},{-63.6,-60}},
                                                    color={0,0,127}));
  connect(conHea.y,gainHea. u)
    annotation (Line(points={{-45.2,-60},{-39.2,-60}},
                                                     color={0,0,127}));
  connect(gainHea.y,hea. Q_flow)
    annotation (Line(points={{-25.4,-60},{-20,-60}},
                                                   color={0,0,127}));
  connect(conHea.u_m, thermalZoneTwoElements.TAir) annotation (Line(points={{-54,
          -69.6},{-54,-71},{144,-71},{144,86},{69,86}},         color={0,0,127}));
  connect(from_degC_coo.y,conCoo. u_s)
    annotation (Line(points={{-69.4,-86},{-63.6,-86}},
                                                    color={0,0,127}));
  connect(conCoo.y,gainCoo. u)
    annotation (Line(points={{-45.2,-86},{-39.2,-86}},
                                                     color={0,0,127}));
  connect(gainCoo.y,coo. Q_flow)
    annotation (Line(points={{-25.4,-86},{-20,-86}},
                                                   color={0,0,127}));
  connect(conCoo.u_m, thermalZoneTwoElements.TAir) annotation (Line(points={{-54,
          -95.6},{-54,-97},{144,-97},{144,86},{69,86}},         color={0,0,127}));
  connect(humanSensibleHeatTemperatureDependent.convHeat,
    thermalZoneTwoElements.intGainsConv) annotation (Line(points={{69,-42},{120,
          -42},{120,74},{68,74}}, color={191,0,0}));
  connect(humanSensibleHeatTemperatureDependent.radHeat, thermalZoneTwoElements.intGainsRad)
    annotation (Line(points={{69,-54},{130,-54},{130,78},{68,78}}, color={95,95,
          95}));
  connect(hea.port, thermalZoneTwoElements.intGainsConv) annotation (Line(
        points={{0,-60},{84,-60},{84,74},{68,74}}, color={191,0,0}));
  connect(thermalZoneTwoElements.intGainsConv,
    humanSensibleHeatTemperatureDependent.TRoom) annotation (Line(points={{68,74},
          {84,74},{84,-39},{51,-39}}, color={191,0,0}));
  connect(ratioConRad1.y, ligCon.Q_flow) annotation (Line(points={{42.6,-24},{46,
          -24},{46,-16},{50,-16}}, color={0,0,127}));
  connect(ratioConRad1.y, ligRad.Q_flow) annotation (Line(points={{42.6,-24},{46,
          -24},{46,-32},{50,-32}}, color={0,0,127}));
  connect(ratioConRad.y, miscCon.Q_flow) annotation (Line(points={{42.6,6},{46,6},
          {46,14},{50,14}}, color={0,0,127}));
  connect(ratioConRad.y, miscRad.Q_flow) annotation (Line(points={{42.6,6},{46,6},
          {46,-2},{50,-2}}, color={0,0,127}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-126,68},{-103,68},{-103,44}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(HDifTil.HSkyDifTil,corGDoublePane. HSkyDifTil)
   annotation (Line(
    points={{-83,144},{-40,144},{-40,178},{-30,178}},  color={0,0,127}));
  connect(HDirTil.H,corGDoublePane. HDirTil)
    annotation (Line(points={{-81,174},{-44,174},{-44,182},{-30,182}},
    color={0,0,127}));
  connect(HDirTil.H,solRad. u1)
    annotation (Line(points={{-81,174},{-76,174},{-76,126},{-73,126}},
                   color={0,0,127}));
  connect(HDirTil.inc,corGDoublePane. inc)
    annotation (Line(points={{-81,170},{-30,170}},    color={0,0,127}));
  connect(HDifTil.H,solRad. u2)
    annotation (Line(points={{-83,138},{-78,138},{-78,120},{-73,120}},
                 color={0,0,127}));
  connect(HDifTil.HGroDifTil,corGDoublePane. HGroDifTil)
    annotation (Line(
    points={{-83,132},{-38,132},{-38,174},{-30,174}},
                                              color={0,0,127}));
  connect(weaDat.weaBus,HDifTil [1].weaBus)
    annotation (Line(
    points={{-126,68},{-126,138},{-104,138}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus,HDirTil [1].weaBus)
    annotation (Line(
    points={{-126,68},{-156,68},{-156,174},{-102,174}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus,HDifTil [2].weaBus)
    annotation (Line(
    points={{-126,68},{-126,138},{-104,138}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus,HDirTil [2].weaBus)
    annotation (Line(
    points={{-126,68},{-156,68},{-156,174},{-102,174}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus,HDifTil [3].weaBus)
    annotation (Line(
    points={{-126,68},{-126,138},{-104,138}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus,HDirTil [3].weaBus)
    annotation (Line(
    points={{-126,68},{-156,68},{-156,174},{-102,174}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus,HDifTil [4].weaBus)
    annotation (Line(
    points={{-126,68},{-126,138},{-104,138}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus,HDirTil [4].weaBus)
    annotation (Line(
    points={{-126,68},{-156,68},{-156,174},{-102,174}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus,HDifTil [5].weaBus)
    annotation (Line(
    points={{-126,68},{-126,138},{-104,138}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus,HDirTil [5].weaBus)
    annotation (Line(
    points={{-126,68},{-156,68},{-156,174},{-102,174}},
    color={255,204,51},
    thickness=0.5));
  connect(solRad.y, eqAirTemp.HSol)
    annotation (Line(points={{-61.5,123},{-60,123},{-60,58}},
    color={0,0,127}));
  connect(intGaiPer.y[1], humanSensibleHeatTemperatureDependent.uRel)
    annotation (Line(points={{32.8,-48},{50,-48}}, color={0,0,127}));
  connect(intGaiLigh.y[1], ratioConRad1.u)
    annotation (Line(points={{14.8,-24},{28.8,-24}}, color={0,0,127}));
  connect(intGaiMisc.y[1], ratioConRad.u)
    annotation (Line(points={{10.8,6},{28.8,6}}, color={0,0,127}));
  connect(setTempHeat.y[1], from_degC_hea.u)
    annotation (Line(points={{-97.2,-60},{-83.2,-60}}, color={0,0,127}));
  connect(setTempCool.y[1], from_degC_coo.u)
    annotation (Line(points={{-97.2,-86},{-83.2,-86}}, color={0,0,127}));
  connect(simpleExternalShading.corrIrr, thermalZoneTwoElements.solRad)
    annotation (Line(points={{-38.06,77.24},{-9.03,77.24},{-9.03,85},{19,85}},
        color={0,0,127}));
  connect(coo.port, thermalZoneTwoElements.hkRadExtWalls)
    annotation (Line(points={{0,-86},{68,-86},{68,52}}, color={191,0,0}));
  connect(ventilationIn.ports[1], thermalZoneTwoElements.ports[1]) annotation (
      Line(points={{-74,-2},{-8,-2},{-8,52.05},{57.475,52.05}}, color={0,127,
          255}));
  connect(ventilationOut.ports[1], thermalZoneTwoElements.ports[2]) annotation
    (Line(points={{-74,-34},{-8,-34},{-8,52.05},{60.525,52.05}}, color={0,127,
          255}));
  connect(simpleExternalShading.shadingFactor, eqAirTemp.sunblind) annotation (
      Line(points={{-37.94,74.6},{-37.94,69.3},{-48,69.3},{-48,64}}, color={0,0,
          127}));
  connect(solRad.y, simpleExternalShading.solRadTot) annotation (Line(points={{
          -61.5,123},{-61.5,99.5},{-44.06,99.5},{-44.06,77.06}}, color={0,0,127}));
  connect(corGDoublePane.solarRadWinTrans, simpleExternalShading.solRadWin)
    annotation (Line(points={{-7,176},{-26,176},{-26,78.92},{-44.12,78.92}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -100},{160,100}})),                                  Diagram(
        coordinateSystem(                           extent={{-160,-100},{160,100}})));
end Testcase3_1_M_MA;
