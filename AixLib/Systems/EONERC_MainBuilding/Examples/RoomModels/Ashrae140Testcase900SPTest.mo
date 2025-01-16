within AixLib.Systems.EONERC_MainBuilding.Examples.RoomModels;
model Ashrae140Testcase900SPTest
  "Model of a ERC-Thermal Zone Including CCA and AHU"
  extends Modelica.Icons.Example;
    package MediumWater = AixLib.Media.Water
    annotation (choicesAllMatching=true);
    package MediumAir = AixLib.Media.AirIncompressible
    annotation (choicesAllMatching=true);
  TABS.Tabs
       tabs1(
    redeclare package Medium = MediumWater,
    m_flow_nominal=0.1,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_22x1_5(),
    area=48,
    thickness=0.1,
    alpha=20,
    length=50,
    throttlePumpHot(Kv=2, redeclare
        HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
        PumpInterface(pump(redeclare
            AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))),
    throttlePumpCold(Kv=10, redeclare
        HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
        PumpInterface(pump(redeclare
            AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))))
    annotation (Placement(transformation(extent={{84,-102},{104,-80}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone thermalZone1(
    redeclare package Medium = MediumAir,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    redeclare AixLib.Systems.EONERC_MainBuilding.BaseClasses.ASHRAE140_900
      zoneParam,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    recOrSep=false,
    Heater_on=false,
    Cooler_on=false,
    nPorts=2)
     "Thermal zone"
    annotation (Placement(transformation(extent={{10,-64},{66,-6}})));
  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/ASHRAE140.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-92,20},{-72,40}})));

  ModularAHU.GenericAHU genericAHU1(
    fanSup(init=Modelica.Blocks.Types.Init.NoInit),
    fanRet(init=Modelica.Blocks.Types.Init.NoInit),
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    T_amb=293.15,
    m1_flow_nominal=129/3600*3,
    m2_flow_nominal=0.1,
    T_start=293.15,
    usePreheater=false,
    useHumidifierRet=false,
    useHumidifier=false,
    preheater(redeclare HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
        length=1,
        Kv=6.3,
        valveCharacteristic=AixLib.Fluid.Actuators.Valves.Data.LinearLinear(),
        redeclare
          HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per))), dynamicHX(
        dp1_nominal=50,
        dp2_nominal=1000,
        tau1=5,
        tau2=15,
        dT_nom=30,
        Q_nom=60000)),
    cooler(redeclare AixLib.Systems.HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_10x0_6(),
        length=10,
        Kv=3,
        valveCharacteristic=Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))),
        dynamicHX(
        dp1_nominal=5,
        dp2_nominal=5000,
        dT_nom=10,
        Q_nom=2000)),
    heater(redeclare AixLib.Systems.HydraulicModules.Admix hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_10x0_6(),
        length=10,
        Kv=3,
        valveCharacteristic=Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))),
        dynamicHX(
        dp1_nominal=5,
        dp2_nominal=5000,
        dT_nom=20,
        Q_nom=2000)),
    final dynamicHX(
      dp1_nominal=150,
      dp2_nominal=150,
      dT_nom=10,
      Q_nom=2000),
    humidifier(
      dp_nominal=20,
      mWat_flow_nominal=1,
      TLiqWat_in=288.15),
    humidifierRet(
      dp_nominal=20,
      mWat_flow_nominal=0.5,
      TLiqWat_in=288.15))
    annotation (Placement(transformation(extent={{-28,-92},{8,-66}})));

  Fluid.Sources.Boundary_pT boundaryExhaustAir(redeclare package Medium =
        MediumAir, nPorts=1)
                          annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={-54,-70})));
  BoundaryConditions.WeatherData.Bus        weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{-60,-18},{-26,14}}),
    iconTransformation(extent={{-150,388},{-130,408}})));
  BaseClasses.ZoneBus Bus
    annotation (Placement(transformation(extent={{-2,30},{18,50}})));
  Fluid.Sources.Boundary_pT boundaryOutsideAir1(
    use_X_in=true,
    use_Xi_in=false,
    use_T_in=true,
    redeclare package Medium = MediumAir,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={-54,-80})));
  Utilities.Psychrometrics.X_pTphi x_pTphi1
    annotation (Placement(transformation(extent={{-70,-68},{-62,-60}})));
  Fluid.Sources.Boundary_pT        bouWaterhot(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=318.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={3,-117})));
  Fluid.Sources.Boundary_pT        bouWaterhot1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=318.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={21,-113})));
  Fluid.Sources.Boundary_pT        bouWatercold(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=285.15,
    nPorts=2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={54,-150})));
  Fluid.Sources.Boundary_pT        bouWatercold1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=285.15,
    nPorts=2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={30,-150})));
  Fluid.Sources.Boundary_pT        bouWaterhot2(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=308.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={81,-119})));
  Fluid.Sources.Boundary_pT        bouWaterhot3(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=308.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={63,-113})));
  ModularAHU.Controller.CtrAHUBasic ctrAhu(
    usePreheater=false,
    useExternalTset=true,
    k=1000,
    Ti=60,
    VFlowSet=3*129/3600,
    ctrCo(
      k=0.03,
      Ti=120,
      rpm_pump=3000),
    ctrRh(
      k=0.03,
      Ti=120,
      rpm_pump=3000))
    annotation (Placement(transformation(extent={{-58,-50},{-38,-30}})));
  Controller.CtrTabsQflow ctrTabsQflow(
    ctrThrottleHotQFlow(
      k=0.00003,
      Ti=280,
      rpm_pump=2000),
    ctrThrottleColdQFlow(
      k=0.00003,
      Ti=280,
      rpm_pump=3000),
    ctrPump(rpm_pump=3000))
    annotation (Placement(transformation(extent={{-58,-28},{-38,-8}})));
  Modelica.Blocks.Interfaces.RealOutput QFlowCold "Value of Real output"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput QFlowHeat "Value of Real output"
    annotation (Placement(transformation(extent={{100,80},{120,100}})));
  BaseClasses.EnergyCalc coolEnergyCalc annotation (Placement(transformation(
          rotation=0, extent={{60,50},{80,70}})));
  BaseClasses.EnergyCalc hotEnergyCalc annotation (Placement(transformation(
          rotation=0, extent={{60,80},{80,100}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=thermalZone1.ROM.intWallRC.thermCapInt[
        1].T) annotation (Placement(transformation(extent={{164,34},{184,54}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=thermalZone1.ROM.extWallRC.thermCapExt[
        1].T) annotation (Placement(transformation(extent={{162,10},{182,30}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=thermalZone1.ROM.resWin.port_b.T)
    annotation (Placement(transformation(extent={{164,-12},{184,8}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=tabs1.heatCapacitor.T)
    annotation (Placement(transformation(extent={{164,-36},{184,-16}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=thermalZone1.ROM.roofRC.thermCapExt[
        1].T)
    annotation (Placement(transformation(extent={{166,-56},{186,-36}})));
  Modelica.Blocks.Interfaces.RealOutput T_IntWall "Value of Real output"
    annotation (Placement(transformation(extent={{202,34},{222,54}})));
  Modelica.Blocks.Interfaces.RealOutput T_ExtWall "Value of Real output"
    annotation (Placement(transformation(extent={{200,10},{220,30}})));
  Modelica.Blocks.Interfaces.RealOutput T_Win "Value of Real output"
    annotation (Placement(transformation(extent={{202,-12},{222,8}})));
  Modelica.Blocks.Interfaces.RealOutput T_Tabs "Value of Real output"
    annotation (Placement(transformation(extent={{202,-36},{222,-16}})));
  Modelica.Blocks.Interfaces.RealOutput T_Roof "Value of Real output"
    annotation (Placement(transformation(extent={{204,-56},{224,-36}})));
  Modelica.Blocks.Interfaces.RealOutput T_amb "Value of Real output"
    annotation (Placement(transformation(extent={{204,-80},{224,-60}})));
  Modelica.Blocks.Interfaces.RealOutput solar_radiation "Value of Real output"
    annotation (Placement(transformation(extent={{202,-104},{222,-84}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=4)
    annotation (Placement(transformation(extent={{168,-94},{180,-82}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=thermalZone1.ROM.radHeatSol[
        1].Q_flow)
    annotation (Placement(transformation(extent={{114,-88},{134,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression7(y=thermalZone1.ROM.radHeatSol[
        4].Q_flow)
    annotation (Placement(transformation(extent={{116,-134},{136,-114}})));
  Modelica.Blocks.Sources.RealExpression realExpression8(y=thermalZone1.ROM.radHeatSol[
        3].Q_flow)
    annotation (Placement(transformation(extent={{114,-118},{134,-98}})));
  Modelica.Blocks.Sources.RealExpression realExpression9(y=thermalZone1.ROM.radHeatSol[
        2].Q_flow)
    annotation (Placement(transformation(extent={{114,-102},{134,-82}})));
  Modelica.Blocks.Interfaces.RealOutput TAirRoom "Indoor air temperature"
    annotation (Placement(transformation(extent={{126,-24},{146,-4}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{100,123},{112,135}})));
  Modelica.Blocks.Math.Add add2
    annotation (Placement(transformation(extent={{100,159},{112,171}})));
  Modelica.Blocks.Interfaces.RealOutput Q_Tabs "Value of Real output"
    annotation (Placement(transformation(extent={{130,119},{150,139}})));
  Modelica.Blocks.Interfaces.RealOutput Q_Ahu "Value of Real output"
    annotation (Placement(transformation(extent={{130,155},{150,175}})));
  Modelica.Blocks.Interfaces.RealOutput Q_Tabs_ctr
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{-6,184},{14,204}})));
  Modelica.Blocks.Math.Gain gain(k=0.001)
    annotation (Placement(transformation(extent={{-32,184},{-12,204}})));

  Modelica.Blocks.Sources.CombiTimeTable QTabs_set(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="UserProfiles",
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/UserProfiles_18599_SIA_Besprechung_Sitzung_Seminar.txt"),
    columns={2},
    tableOnFile=false,
    table=[0,0; 86400,0; 86400,5000; 97200,5000; 97200,0; 529200,0; 529200,5000;
        540000,5000; 540000,0; 799200,0; 799200,5000; 810000,5000; 810000,0;
        982800,0; 982800,5000; 993600,5000; 993600,0; 1080000,0; 1080000,0;
        1090800,0; 1090800,0; 1522800,0; 1522800,0; 1533600,0; 1533600,0;
        1792800,0; 1792800,0; 1803600,0; 1803600,0; 1976400,0; 1976400,0;
        1987200,0; 1987200,0; 2073600,0; 2160000,0; 2160000,5000; 2170800,5000;
        2170800,0; 2602800,0; 2602800,5000; 2613600,5000; 2613600,0; 2872800,0;
        2872800,5000; 2883600,5000; 2883600,0; 3056400,0; 3056400,5000; 3067200,
        5000; 3067200,0; 3153600,0; 3153600,5000; 3164400,5000; 3164400,0;
        3596400,0; 3596400,1000; 3607200,1000; 3607200,0; 3866400,0; 3866400,
        1000; 3877200,1000; 3877200,0; 4050000,0; 4050000,2000; 4060800,2000;
        4060800,0; 4147200,0; 4147200,1000; 4158000,1000; 4158000,0; 4590000,0;
        4590000,3000; 4600800,3000; 4600800,0; 4860000,0; 4860000,3000; 4870800,
        3000; 4870800,0; 5043600,0; 5043600,0; 5054400,0; 5054400,0; 5140800,0;
        5140800,0; 5151600,0; 5151600,0; 5583600,0; 5583600,0; 5594400,0;
        5594400,0; 5853600,0; 5853600,0; 5864400,0; 5864400,0; 6037200,0;
        6037200,0; 6048000,0; 6048000,0; 6134400,0; 6134400,0; 6145200,0;
        6145200,0; 6231600,0; 6231600,1000; 6242400,1000; 6242400,0; 6674400,0;
        6674400,2000; 6685200,5000; 6685200,0; 6944400,0; 6944400,2000; 6955200,
        4000; 6955200,0; 7128000,0; 7128000,3000; 7138800,2000; 7138800,0;
        7225200,0; 7225200,3000; 7236000,1000; 7236000,0; 7668000,0; 7668000,
        3000; 7678800,1000; 7678800,0; 7938000,0; 7938000,5000; 7948800,1000;
        7948800,0; 8121600,0],
    offset={0},
    shiftTime=0) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={-99,-20})));

  Modelica.Blocks.Sources.RealExpression realExpression5(y=-tabs1.pipe.heatPort.Q_flow)
    annotation (Placement(transformation(extent={{168,-138},{188,-118}})));
  Modelica.Blocks.Interfaces.RealOutput Q_tabs_del "Value of Real output"
    annotation (Placement(transformation(extent={{198,-138},{218,-118}}),
        iconTransformation(extent={{190,-136},{210,-116}})));
  Modelica.Blocks.Sources.RealExpression realExpression10(y=tabs1.pipe.heatPort.T)
    annotation (Placement(transformation(extent={{166,-158},{186,-138}})));
  Modelica.Blocks.Interfaces.RealOutput T_Tabs_Pipe "Value of Real output"
    annotation (Placement(transformation(extent={{204,-158},{224,-138}}),
        iconTransformation(extent={{222,-170},{242,-150}})));
  Modelica.Blocks.Sources.CombiTimeTable internalGains4(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    columns={2,3,4},
    tableOnFile=false,
    table=[0,0,0.1,0,0; 3540,0,0.1,0,0; 3600,0,0.1,0,0; 7140,0,0.1,0,0; 7200,0,
        0.1,0,0; 10740,0,0.1,0,0; 10800,0,0.1,0,0; 14340,0,0.1,0,0; 14400,0,0.1,
        0,0; 17940,0,0.1,0,0; 18000,0,0.1,0,0; 21540,0,0.1,0,0; 21600,0,0.1,0,0;
        25140,0,0.1,0,0; 25200,0,0.1,0,0; 28740,0,0.1,0,0; 28800,0,0.1,0,0;
        32340,0,0.1,0,0; 32400,0.6,0.6,1,1; 35940,0.6,0.6,1,1; 36000,1,1,1,1;
        39540,1,1,1,1; 39600,0.4,0.4,1,1; 43140,0.4,0.4,1,1; 43200,0,0.1,0,0;
        46740,0,0.1,0,0; 46800,0,0.1,0,0; 50340,0,0.1,0,0; 50400,0.6,0.6,1,1;
        53940,0.6,0.6,1,1; 54000,1,1,1,1; 57540,1,1,1,1; 57600,0.4,0.4,1,1;
        61140,0.4,0.4,1,1; 61200,0,0.1,0,0; 64740,0,0.1,0,0; 64800,0,0.1,0,0;
        68340,0,0.1,0,0; 68400,0,0.1,0,0; 71940,0,0.1,0,0; 72000,0,0.1,0,0;
        75540,0,0.1,0,0; 75600,0,0.1,0,0; 79140,0,0.1,0,0; 79200,0,0.1,0,0;
        82740,0,0.1,0,0; 82800,0,0.1,0,0; 86340,0,0.1,0,0; 86400,0,0,0,0; 89940,
        0,0,0,0; 90000,0,0,0,0; 93540,0,0,0,0; 93600,0,0,0,0; 97140,0,0,0,0;
        97200,0,0,0,0; 100740,0,0,0,0; 100800,0,0,0,0; 104340,0,0,0,0; 104400,0,
        0,0,0; 107940,0,0,0,0; 108000,0,0,0,0; 111540,0,0,0,0; 111600,0,0,0,0;
        115140,0,0,0,0; 115200,0,0,0,0; 118740,0,0,0,0; 118800,0,0,0,0; 122340,
        0,0,0,0; 122400,0,0,0,0; 125940,0,0,0,0; 126000,0,0,0,0; 129540,0,0,0,0;
        129600,0,0,0,0; 133140,0,0,0,0; 133200,0,0,0,0; 136740,0,0,0,0; 136800,
        0,0,0,0; 140340,0,0,0,0; 140400,0,0,0,0; 143940,0,0,0,0; 144000,0,0,0,0;
        147540,0,0,0,0; 147600,0,0,0,0; 151140,0,0,0,0; 151200,0,0,0,0; 154740,
        0,0,0,0; 154800,0,0,0,0; 158340,0,0,0,0; 158400,0,0,0,0; 161940,0,0,0,0;
        162000,0,0,0,0; 165540,0,0,0,0; 165600,0,0,0,0; 169140,0,0,0,0; 169200,
        0,0,0,0; 172740,0,0,0,0; 172800,0,0,0,0; 176340,0,0,0,0; 176400,0,0,0,0;
        179940,0,0,0,0; 180000,0,0,0,0; 183540,0,0,0,0; 183600,0,0,0,0; 187140,
        0,0,0,0; 187200,0,0,0,0; 190740,0,0,0,0; 190800,0,0,0,0; 194340,0,0,0,0;
        194400,0,0,0,0; 197940,0,0,0,0; 198000,0,0,0,0; 201540,0,0,0,0; 201600,
        0,0,0,0; 205140,0,0,0,0; 205200,0,0,0,0; 208740,0,0,0,0; 208800,0,0,0,0;
        212340,0,0,0,0; 212400,0,0,0,0; 215940,0,0,0,0; 216000,0,0,0,0; 219540,
        0,0,0,0; 219600,0,0,0,0; 223140,0,0,0,0; 223200,0,0,0,0; 226740,0,0,0,0;
        226800,0,0,0,0; 230340,0,0,0,0; 230400,0,0,0,0; 233940,0,0,0,0; 234000,
        0,0,0,0; 237540,0,0,0,0; 237600,0,0,0,0; 241140,0,0,0,0; 241200,0,0,0,0;
        244740,0,0,0,0; 244800,0,0,0,0; 248340,0,0,0,0; 248400,0,0,0,0; 251940,
        0,0,0,0; 252000,0,0,0,0; 255540,0,0,0,0; 255600,0,0,0,0; 259140,0,0,0,0;
        259200,0,0.1,0,0; 262740,0,0.1,0,0; 262800,0,0.1,0,0; 266340,0,0.1,0,0;
        266400,0,0.1,0,0; 269940,0,0.1,0,0; 270000,0,0.1,0,0; 273540,0,0.1,0,0;
        273600,0,0.1,0,0; 277140,0,0.1,0,0; 277200,0,0.1,0,0; 280740,0,0.1,0,0;
        280800,0,0.1,0,0; 284340,0,0.1,0,0; 284400,0,0.1,0,0; 287940,0,0.1,0,0;
        288000,0,0.1,0,0; 291540,0,0.1,0,0; 291600,0.6,0.6,1,1; 295140,0.6,0.6,
        1,1; 295200,1,1,1,1; 298740,1,1,1,1; 298800,0.4,0.4,1,1; 302340,0.4,0.4,
        1,1; 302400,0,0.1,0,0; 305940,0,0.1,0,0; 306000,0,0.1,0,0; 309540,0,0.1,
        0,0; 309600,0.6,0.6,1,1; 313140,0.6,0.6,1,1; 313200,1,1,1,1; 316740,1,1,
        1,1; 316800,0.4,0.4,1,1; 320340,0.4,0.4,1,1; 320400,0,0.1,0,0; 323940,0,
        0.1,0,0; 324000,0,0.1,0,0; 327540,0,0.1,0,0; 327600,0,0.1,0,0; 331140,0,
        0.1,0,0; 331200,0,0.1,0,0; 334740,0,0.1,0,0; 334800,0,0.1,0,0; 338340,0,
        0.1,0,0; 338400,0,0.1,0,0; 341940,0,0.1,0,0; 342000,0,0.1,0,0; 345540,0,
        0.1,0,0; 345600,0,0.1,0,0; 349140,0,0.1,0,0; 349200,0,0.1,0,0; 352740,0,
        0.1,0,0; 352800,0,0.1,0,0; 356340,0,0.1,0,0; 356400,0,0.1,0,0; 359940,0,
        0.1,0,0; 360000,0,0.1,0,0; 363540,0,0.1,0,0; 363600,0,0.1,0,0; 367140,0,
        0.1,0,0; 367200,0,0.1,0,0; 370740,0,0.1,0,0; 370800,0,0.1,0,0; 374340,0,
        0.1,0,0; 374400,0,0.1,0,0; 377940,0,0.1,0,0; 378000,0.6,0.6,1,1; 381540,
        0.6,0.6,1,1; 381600,1,1,1,1; 385140,1,1,1,1; 385200,0.4,0.4,1,1; 388740,
        0.4,0.4,1,1; 388800,0,0.1,0,0; 392340,0,0.1,0,0; 392400,0,0.1,0,0;
        395940,0,0.1,0,0; 396000,0.6,0.6,1,1; 399540,0.6,0.6,1,1; 399600,1,1,1,
        1; 403140,1,1,1,1; 403200,0.4,0.4,1,1; 406740,0.4,0.4,1,1; 406800,0,0.1,
        0,0; 410340,0,0.1,0,0; 410400,0,0.1,0,0; 413940,0,0.1,0,0; 414000,0,0.1,
        0,0; 417540,0,0.1,0,0; 417600,0,0.1,0,0; 421140,0,0.1,0,0; 421200,0,0.1,
        0,0; 424740,0,0.1,0,0; 424800,0,0.1,0,0; 428340,0,0.1,0,0; 428400,0,0.1,
        0,0; 431940,0,0.1,0,0; 432000,0,0.1,0,0; 435540,0,0.1,0,0; 435600,0,0.1,
        0,0; 439140,0,0.1,0,0; 439200,0,0.1,0,0; 442740,0,0.1,0,0; 442800,0,0.1,
        0,0; 446340,0,0.1,0,0; 446400,0,0.1,0,0; 449940,0,0.1,0,0; 450000,0,0.1,
        0,0; 453540,0,0.1,0,0; 453600,0,0.1,0,0; 457140,0,0.1,0,0; 457200,0,0.1,
        0,0; 460740,0,0.1,0,0; 460800,0,0.1,0,0; 464340,0,0.1,0,0; 464400,0.6,
        0.6,1,1; 467940,0.6,0.6,1,1; 468000,1,1,1,1; 471540,1,1,1,1; 471600,0.4,
        0.4,1,1; 475140,0.4,0.4,1,1; 475200,0,0.1,0,0; 478740,0,0.1,0,0; 478800,
        0,0.1,0,0; 482340,0,0.1,0,0; 482400,0.6,0.6,1,1; 485940,0.6,0.6,1,1;
        486000,1,1,1,1; 489540,1,1,1,1; 489600,0.4,0.4,1,1; 493140,0.4,0.4,1,1;
        493200,0,0.1,0,0; 496740,0,0.1,0,0; 496800,0,0.1,0,0; 500340,0,0.1,0,0;
        500400,0,0.1,0,0; 503940,0,0.1,0,0; 504000,0,0.1,0,0; 507540,0,0.1,0,0;
        507600,0,0.1,0,0; 511140,0,0.1,0,0; 511200,0,0.1,0,0; 514740,0,0.1,0,0;
        514800,0,0.1,0,0; 518340,0,0.1,0,0; 518400,0,0.1,0,0; 521940,0,0.1,0,0;
        522000,0,0.1,0,0; 525540,0,0.1,0,0; 525600,0,0.1,0,0; 529140,0,0.1,0,0;
        529200,0,0.1,0,0; 532740,0,0.1,0,0; 532800,0,0.1,0,0; 536340,0,0.1,0,0;
        536400,0,0.1,0,0; 539940,0,0.1,0,0; 540000,0,0.1,0,0; 543540,0,0.1,0,0;
        543600,0,0.1,0,0; 547140,0,0.1,0,0; 547200,0,0.1,0,0; 550740,0,0.1,0,0;
        550800,0.6,0.6,1,1; 554340,0.6,0.6,1,1; 554400,1,1,1,1; 557940,1,1,1,1;
        558000,0.4,0.4,1,1; 561540,0.4,0.4,1,1; 561600,0,0.1,0,0; 565140,0,0.1,
        0,0; 565200,0,0.1,0,0; 568740,0,0.1,0,0; 568800,0.6,0.6,1,1; 572340,0.6,
        0.6,1,1; 572400,1,1,1,1; 575940,1,1,1,1; 576000,0.4,0.4,1,1; 579540,0.4,
        0.4,1,1; 579600,0,0.1,0,0; 583140,0,0.1,0,0; 583200,0,0.1,0,0; 586740,0,
        0.1,0,0; 586800,0,0.1,0,0; 590340,0,0.1,0,0; 590400,0,0.1,0,0; 593940,0,
        0.1,0,0; 594000,0,0.1,0,0; 597540,0,0.1,0,0; 597600,0,0.1,0,0; 601140,0,
        0.1,0,0; 601200,0,0.1,0,0; 604740,0,0.1,0,0])
    "Table with profiles for internal gains"
    annotation(Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=90,
        origin={60,-88})));
  Modelica.Blocks.Sources.CombiTimeTable T_set(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="UserProfiles",
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/UserProfiles_18599_SIA_Besprechung_Sitzung_Seminar.txt"),
    columns={2},
    tableOnFile=false,
    table=[0,291.15; 86400,291.15; 86400,291.15; 97200,291.15; 97200,291.15;
        529200,291.15; 529200,291.15; 540000,291.15; 540000,291.15; 799200,
        291.15; 799200,291.15; 810000,291.15; 810000,291.15; 982800,291.15;
        982800,291.15; 993600,291.15; 993600,291.15; 1080000,291.15; 1080000,
        298.15; 1090800,298.15; 1090800,291.15; 1522800,291.15; 1522800,298.15;
        1533600,298.15; 1533600,291.15; 1792800,291.15; 1792800,298.15; 1803600,
        298.15; 1803600,291.15; 1976400,291.15; 1976400,298.15; 1987200,298.15;
        1987200,291.15; 2073600,291.15; 2160000,291.15; 2160000,298.15; 2170800,
        298.15; 2170800,291.15; 2602800,291.15; 2602800,298.15; 2613600,298.15;
        2613600,291.15; 2872800,291.15; 2872800,298.15; 2883600,298.15; 2883600,
        291.15; 3056400,291.15; 3056400,298.15; 3067200,298.15; 3067200,291.15;
        3153600,291.15; 3153600,298.15; 3164400,298.15; 3164400,291.15; 3596400,
        291.15; 3596400,291.15; 3607200,291.15; 3607200,291.15; 3866400,291.15;
        3866400,291.15; 3877200,291.15; 3877200,291.15; 4050000,291.15; 4050000,
        291.15; 4060800,291.15; 4060800,291.15; 4147200,291.15; 4147200,291.15;
        4158000,291.15; 4158000,291.15; 4590000,291.15; 4590000,291.15; 4600800,
        291.15; 4600800,291.15; 4860000,291.15; 4860000,291.15; 4870800,291.15;
        4870800,291.15; 5043600,291.15; 5043600,293.15; 5054400,293.15; 5054400,
        291.15; 5140800,291.15; 5140800,293.15; 5151600,293.15; 5151600,291.15;
        5583600,291.15; 5583600,297.15; 5594400,297.15; 5594400,291.15; 5853600,
        291.15; 5853600,298.15; 5864400,298.15; 5864400,291.15; 6037200,291.15;
        6037200,294.15; 6048000,294.15; 6048000,291.15; 6134400,291.15; 6134400,
        294.15; 6145200,294.15; 6145200,291.15; 6231600,291.15; 6231600,292.15;
        6242400,292.15; 6242400,291.15; 6674400,291.15; 6674400,293.15; 6685200,
        298.15; 6685200,291.15; 6944400,291.15; 6944400,291.15; 6955200,296.15;
        6955200,291.15; 7128000,291.15; 7128000,293.15; 7138800,296.15; 7138800,
        291.15; 7225200,291.15; 7225200,298.15; 7236000,292.15; 7236000,291.15;
        7668000,291.15; 7668000,298.15; 7678800,292.15; 7678800,291.15; 7938000,
        291.15; 7938000,297.15; 7948800,298.15; 7948800,291.15; 8121600,291.15],
    offset={0},
    shiftTime=0) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={-99,-40})));

equation
  connect(weaDat.weaBus,thermalZone1.weaBus) annotation (Line(
      points={{-72,30},{8,30},{8,-17.6},{10,-17.6}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-72,30},{-43,30},{-43,-2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(tabs1.heatPort,thermalZone1.intGainsConv) annotation (Line(points={{94,
          -78.9},{94,-33.84},{66.56,-33.84}},                       color={191,
          0,0}));
  connect(genericAHU1.port_b1,thermalZone1.ports[1]) annotation (Line(points={{8.16364,-80.1818},{36,
          -80.1818},{36,-55.88},{34.71,-55.88}},                 color={0,127,
          255}));
  connect(genericAHU1.port_a2,thermalZone1.ports[2]) annotation (Line(points={{8.16364,-70.7273},{46,
          -70.7273},{46,-55.88},{41.29,-55.88}},               color={0,127,255}));
  connect(boundaryExhaustAir.ports[1],genericAHU1.port_b2) annotation (Line(
        points={{-50,-70},{-50,-70.7273},{-28,-70.7273}},    color={0,127,255}));
  connect(thermalZone1.TAir, Bus.TZoneMea) annotation (Line(points={{68.8,-11.8},
          {86.4,-11.8},{86.4,40.05},{8.05,40.05}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boundaryOutsideAir1.T_in, weaBus.TDryBul) annotation (Line(points={{-58.8,
          -81.6},{-86,-81.6},{-86,-2},{-43,-2}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(x_pTphi1.X, boundaryOutsideAir1.X_in) annotation (Line(points={{-61.6,
          -64},{-60,-64},{-60,-78.4},{-58.8,-78.4}},
                                                   color={0,0,127}));
  connect(x_pTphi1.X, boundaryOutsideAir1.X_in) annotation (Line(points={{-61.6,
          -64},{-60,-64},{-60,-78.4},{-58.8,-78.4}},
                                                   color={0,0,127}));
  connect(boundaryOutsideAir1.ports[1], genericAHU1.port_a1) annotation (Line(
        points={{-50,-80},{-50,-80.1818},{-28,-80.1818}}, color={0,127,255}));
  connect(x_pTphi1.T, weaBus.TDryBul) annotation (Line(points={{-70.8,-64},{-86,
          -64},{-86,-2},{-43,-2}},
                              color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(x_pTphi1.phi, weaBus.relHum) annotation (Line(points={{-70.8,-66.4},{-70.8,
          -66},{-86,-66},{-86,-2},{-43,-2}},
                                           color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(x_pTphi1.p_in, weaBus.pAtm) annotation (Line(points={{-70.8,-61.6},{-70,
          -61.6},{-70,-62},{-86,-62},{-86,-2},{-43,-2}},
                                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(bouWaterhot.ports[1], genericAHU1.port_a5) annotation (Line(points={{3,-112},
          {-4,-112},{-4,-92},{-3.45455,-92}},       color={0,127,255}));
  connect(bouWaterhot1.ports[1], genericAHU1.port_b5) annotation (Line(points={{21,-108},
          {20,-108},{20,-102},{0,-102},{0,-92},{-0.34545,-92}},        color={0,
          127,255}));
  connect(bouWatercold1.ports[1], genericAHU1.port_a4) annotation (Line(points={{29,-140},
          {-10,-140},{-10,-92}},         color={0,127,255}));
  connect(bouWatercold.ports[1], tabs1.port_b2) annotation (Line(points={{53,-140},
          {102,-140},{102,-101.78}},
                                color={0,127,255}));
  connect(bouWatercold1.ports[2], tabs1.port_a2) annotation (Line(points={{31,-140},
          {30,-140},{30,-132},{98,-132},{98,-102}},
                                                color={0,127,255}));
  connect(genericAHU1.port_b4, bouWatercold.ports[2]) annotation (Line(points={{
          -6.72727,-92},{-6,-92},{-6,-134},{54,-134},{54,-140},{55,-140}},
                                                                         color={
          0,127,255}));
  connect(bouWaterhot2.ports[1], tabs1.port_b1)
    annotation (Line(points={{81,-114},{90,-114},{90,-102}},
                                                          color={0,127,255}));
  connect(bouWaterhot3.ports[1], tabs1.port_a1)
    annotation (Line(points={{63,-108},{86,-108},{86,-102}},
                                                          color={0,127,255}));
  connect(ctrTabsQflow.tabsBus, Bus.tabsBus) annotation (Line(
      points={{-38,-18},{-10,-18},{-10,40.05},{8.05,40.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(tabs1.tabsBus, Bus.tabsBus) annotation (Line(
      points={{83.9,-90.89},{78,-90.89},{78,40},{44,40},{44,40.05},{8.05,40.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(genericAHU1.genericAHUBus, Bus.ahuBus) annotation (Line(
      points={{-10,-65.8818},{-10,40.05},{8.05,40.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrAhu.genericAHUBus, genericAHU1.genericAHUBus) annotation (Line(
      points={{-38,-39.9},{-20,-39.9},{-20,-40},{-10,-40},{-10,-65.8818}},
      color={255,204,51},
      thickness=0.5));
  connect(coolEnergyCalc.vFlow2, Bus.tabsBus.coldThrottleBus.VFlowInMea)
    annotation (Line(points={{65,49},{65,40},{8.05,40},{8.05,40.05}},
                    color={0,0,127}));
  connect(coolEnergyCalc.Tin2, Bus.tabsBus.coldThrottleBus.TFwrdInMea)
    annotation (Line(points={{59,57},{8.05,57},{8.05,40.05}},    color={0,0,127}));
  connect(coolEnergyCalc.Tout2, Bus.tabsBus.coldThrottleBus.TRtrnOutMea)
    annotation (Line(points={{59,53},{52,53},{52,40},{8.05,40},{8.05,40.05}},
                          color={0,0,127}));
  connect(coolEnergyCalc.vFlow1, Bus.ahuBus.coolerBus.hydraulicBus.VFlowInMea)
    annotation (Line(points={{65,71},{8.05,71},{8.05,40.05}},    color={0,0,127}));
  connect(coolEnergyCalc.Tin1, Bus.ahuBus.coolerBus.hydraulicBus.TFwrdInMea)
    annotation (Line(points={{59,67},{59,66},{8.05,66},{8.05,40.05}},
                                    color={0,0,127}));
  connect(coolEnergyCalc.Tout1, Bus.ahuBus.coolerBus.hydraulicBus.TRtrnOutMea)
    annotation (Line(points={{59,63},{8.05,63},{8.05,40.05}},    color={0,0,127}));
  connect(coolEnergyCalc.y1, QFlowCold) annotation (Line(points={{81,60},{110,60}},
                                       color={0,0,127}));
  connect(hotEnergyCalc.vFlow2, Bus.tabsBus.hotThrottleBus.VFlowInMea)
    annotation (Line(points={{65,79},{66,79},{66,76},{8,76},{8,58},{8.05,58},{8.05,
          40.05}},                                                        color=
         {0,0,127}));
  connect(hotEnergyCalc.Tout2, Bus.tabsBus.hotThrottleBus.TRtrnOutMea)
    annotation (Line(points={{59,83},{8.05,83},{8.05,40.05}},    color={0,0,127}));
  connect(hotEnergyCalc.Tin2, Bus.tabsBus.hotThrottleBus.TFwrdInMea)
    annotation (Line(points={{59,87},{8.05,87},{8.05,40.05}},    color={0,0,127}));
  connect(hotEnergyCalc.vFlow1, Bus.ahuBus.heaterBus.hydraulicBus.VFlowInMea)
    annotation (Line(points={{65,101},{66,101},{66,102},{8.05,102},{8.05,40.05}},
        color={0,0,127}));
  connect(hotEnergyCalc.y1, QFlowHeat)
    annotation (Line(points={{81,90},{110,90}}, color={0,0,127}));
  connect(realExpression.y, T_IntWall)
    annotation (Line(points={{185,44},{212,44}}, color={0,0,127}));
  connect(realExpression1.y, T_ExtWall)
    annotation (Line(points={{183,20},{210,20}}, color={0,0,127}));
  connect(realExpression2.y, T_Win)
    annotation (Line(points={{185,-2},{212,-2}}, color={0,0,127}));
  connect(realExpression3.y, T_Tabs)
    annotation (Line(points={{185,-26},{212,-26}}, color={0,0,127}));
  connect(realExpression4.y, T_Roof)
    annotation (Line(points={{187,-46},{214,-46}}, color={0,0,127}));
  connect(T_amb, weaBus.TDryBul) annotation (Line(points={{214,-70},{92,-70},{92,
          -2},{-4,-2},{-4,16},{-43,16},{-43,-2}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(realExpression6.y, multiSum.u[1]) annotation (Line(points={{135,-78},
          {152,-78},{152,-89.575},{168,-89.575}}, color={0,0,127}));
  connect(realExpression9.y, multiSum.u[2]) annotation (Line(points={{135,-92},
          {152,-92},{152,-88.525},{168,-88.525}}, color={0,0,127}));
  connect(realExpression8.y, multiSum.u[3]) annotation (Line(points={{135,-108},
          {168,-108},{168,-87.475}}, color={0,0,127}));
  connect(realExpression7.y, multiSum.u[4]) annotation (Line(points={{137,-124},
          {137,-107},{168,-107},{168,-86.425}}, color={0,0,127}));
  connect(multiSum.y, solar_radiation) annotation (Line(points={{181.02,-88},{
          194,-88},{194,-94},{212,-94}}, color={0,0,127}));
  connect(thermalZone1.TAir, TAirRoom) annotation (Line(points={{68.8,-11.8},{
          68.8,-10},{86,-10},{86,0},{118,0},{118,-14},{136,-14}}, color={0,0,
          127}));
  connect(coolEnergyCalc.y3, add1.u2) annotation (Line(points={{81,51},{88,51},
          {88,77},{94,77},{94,125.4},{98.8,125.4}}, color={0,0,127}));
  connect(coolEnergyCalc.y2, add2.u2) annotation (Line(points={{81,69},{88,69},
          {88,161},{98.8,161},{98.8,161.4}}, color={0,0,127}));
  connect(hotEnergyCalc.y3, add1.u1) annotation (Line(points={{81,81},{92,81},{
          92,132.6},{98.8,132.6}}, color={0,0,127}));
  connect(hotEnergyCalc.y2, add2.u1) annotation (Line(points={{81,99},{80,99},{
          80,167},{98.8,167},{98.8,168.6}}, color={0,0,127}));
  connect(Q_Ahu, add2.y)
    annotation (Line(points={{140,165},{112.6,165}}, color={0,0,127}));
  connect(Q_Tabs, add1.y)
    annotation (Line(points={{140,129},{112.6,129}}, color={0,0,127}));
  connect(ctrTabsQflow.Q_flow1, gain.u) annotation (Line(points={{-37.2,-9},{
          -22,-9},{-22,124},{-34,124},{-34,194}}, color={0,0,127}));
  connect(gain.y, Q_Tabs_ctr)
    annotation (Line(points={{-11,194},{4,194}}, color={0,0,127}));
  connect(hotEnergyCalc.Tin1, Bus.ahuBus.heaterBus.hydraulicBus.TFwrdInMea)
    annotation (Line(points={{59,97},{8.05,97},{8.05,40.05}}, color={0,0,127}));
  connect(hotEnergyCalc.Tout1, Bus.ahuBus.coolerBus.hydraulicBus.TRtrnOutMea)
    annotation (Line(points={{59,93},{8.05,93},{8.05,40.05}}, color={0,0,127}));
  connect(realExpression5.y, Q_tabs_del)
    annotation (Line(points={{189,-128},{208,-128}}, color={0,0,127}));
  connect(realExpression10.y, T_Tabs_Pipe)
    annotation (Line(points={{187,-148},{214,-148}}, color={0,0,127}));
  connect(internalGains4.y, thermalZone1.intGains) annotation (Line(points={{60,
          -80.3},{60,-70},{60,-59.36},{60.4,-59.36}}, color={0,0,127}));
  connect(QTabs_set.y[1], ctrTabsQflow.QFlowSet) annotation (Line(points={{
          -91.3,-20},{-66,-20},{-66,-17.9},{-58.3,-17.9}}, color={0,0,127}));
  connect(T_set.y[1], ctrAhu.Tset)
    annotation (Line(points={{-91.3,-40},{-60,-40}}, color={0,0,127}));
  annotation (experiment(
      StopTime=8121600,
      Interval=60,
      __Dymola_Algorithm="Cvode"),
    Diagram(coordinateSystem(extent={{-100,-160},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-160},{100,100}})));
end Ashrae140Testcase900SPTest;
