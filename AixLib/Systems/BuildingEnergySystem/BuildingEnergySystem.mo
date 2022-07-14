within AixLib.Systems.BuildingEnergySystem;
model BuildingEnergySystem
  extends Modelica.Icons.Example;
  BoundaryConditions.WeatherData.Old.WeatherTRY.Weather        Weather(
    Latitude=49.5,
    Longitude=8.5,
    GroundReflection=0.2,
    tableName="wetter",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    SOD=AixLib.DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_RoofN_Roof_S(),
    Wind_dir=false,
    Wind_speed=true,
    Air_temp=true,
    fileName="modelica://AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt",
    WeatherData(tableOnFile=false, table=weatherDataDay.weatherData))
    annotation (Placement(transformation(extent={{340,156},{268,204}})));

  ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope.WholeHouseBuildingEnvelope        OFD(
    redeclare DataBase.Walls.Collections.OFD.WSchV1995Heavy wallTypes,
    energyDynamicsWalls=Modelica.Fluid.Types.Dynamics.FixedInitial,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T0_air=294.15,
    TWalls_start=292.15,
    redeclare model WindowModel =
        ThermalZones.HighOrder.Components.WindowsDoors.WindowSimple,
    redeclare DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995 Type_Win,
    redeclare model CorrSolarGainWin =
        ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorGSimple,
    use_infiltEN12831=true,
    n50=if TIR == 1 or TIR == 2 then 3 else if TIR == 3 then 4 else 6,
    withDynamicVentilation=true,
    UValOutDoors=if TIR == 1 then 1.8 else 2.9) annotation (Placement(transformation(extent={{200,-58},
            {334,86}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempOutside
    annotation (Placement(transformation(extent={{10.375,-10.375},{-10.375,10.375}},
        rotation=90,
        origin={189.625,129.625})));

  HeatPumpSystems.HeatPumpSystem heatPumpSystem(
    redeclare package Medium_con = Medium_sin,
    redeclare package Medium_eva = Medium_sou,
    dataTable=AixLib.DataBase.HeatPump.EN255.Vitocal350BWH113(),
    use_deFro=false,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    refIneFre_constant=0.01,
    dpEva_nominal=0,
    deltaM_con=0.1,
    use_opeEnvFroRec=true,
    tableUpp=[-100,100; 100,100],
    minIceFac=0,
    use_chiller=true,
    calcPel_deFro=100,
    minRunTime(displayUnit="min"),
    minLocTime(displayUnit="min"),
    use_antLeg=false,
    use_refIne=true,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    minTimeAntLeg(displayUnit="min") = 900,
    scalingFactor=1,
    use_tableData=false,
    dpCon_nominal=0,
    use_conCap=true,
    CCon=3000,
    use_evaCap=true,
    CEva=3000,
    Q_flow_nominal=5000,
    cpEva=4180,
    cpCon=4180,
    use_secHeaGen=false,
    redeclare model TSetToNSet = Controls.HeatPump.BaseClasses.OnOffHP (hys=5),
    use_sec=true,
    QCon_nominal=10000,
    P_el_nominal=2500,
    redeclare model PerDataHea =
        AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D (
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
        dataTable=
            AixLib.DataBase.HeatPump.EN255.Vitocal350BWH113(
            tableP_ele=[0,-5.0,0.0,5.0,10.0,15.0; 35,3750,3750,3750,3750,3833;
            45,4833,4917,4958,5042,5125; 55,5583,5667,5750,5833,5958; 65,7000,
            7125,7250,7417,7583]),
        printAsserts=false,
        extrapolation=false),
    redeclare function HeatingCurveFunction =
        Controls.SetPoints.Functions.HeatingCurveFunction (TDesign=328.15),
    use_minRunTime=true,
    use_minLocTime=true,
    use_runPerHou=true,
    pre_n_start=true,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12 perEva,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 perCon,
    TCon_nominal=313.15,
    TCon_start=313.15,
    TEva_start=283.15,
    use_revHP=false,
    VCon=0.004,
    VEva=0.004)
    annotation (Placement(transformation(extent={{-280,-46},{-214,46}})));
  Fluid.Storage.BufferStorage bufferStorage(
    redeclare package Medium = Medium,
    useHeatingCoil1=false,
    useHeatingCoil2=false,
    useHeatingRod=false,
    n=5,
    hConIn=100,
    hConOut=10,
    redeclare final model HeatTransfer =
        AixLib.Fluid.Storage.BaseClasses.HeatTransferBuoyancyWetter)
    annotation (Placement(transformation(extent={{-106,-30},{-74,10}})));
  Fluid.Sources.Boundary_pT        sin(
    nPorts=1,
    redeclare package Medium = Medium_sou,
    p=200000,
    T=281.15) "Fluid sink on source side"
    annotation (Placement(transformation(extent={{-322,-64},{-302,-44}})));
  Fluid.Sources.Boundary_pT        sou(
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = Medium_sou)
              "Fluid source on source side"
    annotation (Placement(transformation(extent={{-172,-62},{-192,-42}})));
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    annotation (choicesAllMatching=true);
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature      tempOutside1(T=290.15)
    annotation (Placement(transformation(extent={{10.375,-10.375},{-10.375,10.375}},
        rotation=180,
        origin={-100.375,-96.375})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature tempGround[5](T=282.65)
    annotation (Placement(transformation(
        extent={{10.375,-10.375},{-10.375,10.375}},
        rotation=180,
        origin={231.625,-86.375})));
  Modelica.Blocks.Sources.CombiTimeTable NaturalVentilation(
    columns={2,3,4,5,7},
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableOnFile=false,
    table=VentilationProfile.Profile)                                                                                                                                                                         annotation(Placement(transformation(extent={{10,10},
            {-10,-10}},
        rotation=180,
        origin={151,51})));
  Fluid.Movers.DpControlledMovers.DpControlled_dp pum
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
equation
  connect(Weather.SolarRadiation_OrientedSurfaces[1], OFD.North) annotation (
      Line(points={{322.72,153.6},{322.72,92},{350,92},{350,35.6},{338.02,35.6}},
                                                              color={255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[2], OFD.East) annotation (
      Line(points={{322.72,153.6},{322.72,92},{350,92},{350,14},{338.02,14}},
                                                                color={255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[3], OFD.South) annotation (
      Line(points={{322.72,153.6},{322.72,92},{350,92},{350,-7.6},{338.02,-7.6}},
                                                                color={255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[4], OFD.West) annotation (
      Line(points={{322.72,153.6},{322.72,92},{350,92},{350,-29.2},{338.02,
          -29.2}},                                                color={255,128,
          0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[5], OFD.SolarRadiationPort_RoofN)
    annotation (Line(points={{322.72,153.6},{322.72,92},{350,92},{350,78.8},{
          338.02,78.8}},                                                  color=
         {255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[6], OFD.SolarRadiationPort_RoofS)
    annotation (Line(points={{322.72,153.6},{322.72,92},{350,92},{350,57.2},{
          338.02,57.2}},                                                  color=
         {255,128,0}));
  connect(Weather.WindSpeed, OFD.WindSpeedPort) annotation (Line(points={{265.6,
          194.4},{252,194.4},{252,112},{180,112},{180,64.4},{193.3,64.4}},
                                                       color={0,0,127}));
  connect(tempOutside.port, OFD.thermOutside) annotation (Line(points={{189.625,
          119.25},{188,119.25},{188,96},{200,96},{200,84.56}}, color={191,0,0}));
  connect(Weather.AirTemp, tempOutside.T) annotation (Line(points={{265.6,187.2},
          {189.625,187.2},{189.625,142.075}}, color={0,0,127}));
  connect(heatPumpSystem.T_oda, Weather.AirTemp) annotation (Line(points={{-284.95,
          25.9571},{-324,25.9571},{-324,180},{-326,180},{-326,198},{264,198},{
          264,187.2},{265.6,187.2}},
                                 color={0,0,127}));
  connect(heatPumpSystem.port_b2, sin.ports[1]) annotation (Line(points={{-280,
          -32.8571},{-302,-32.8571},{-302,-54}},
                                       color={0,127,255}));
  connect(sou.ports[1], heatPumpSystem.port_a2) annotation (Line(points={{-192,
          -52},{-198,-52},{-198,-32.8571},{-214,-32.8571}},
                                                       color={0,127,255}));
  connect(sou.T_in, Weather.AirTemp) annotation (Line(points={{-170,-48},{-160,
          -48},{-160,-80},{-348,-80},{-348,180},{265.6,180},{265.6,187.2}},
        color={0,0,127}));
  connect(bufferStorage.fluidportBottom1, heatPumpSystem.port_a1) annotation (
      Line(points={{-95.4,-30.4},{-95.4,-64},{-172,-64},{-172,72},{-306,72},{
          -306,6},{-280,6},{-280,6.57143}}, color={0,127,255}));
  connect(heatPumpSystem.port_b1, bufferStorage.fluidportTop1) annotation (Line(
        points={{-214,6.57143},{-136,6.57143},{-136,26},{-95.6,26},{-95.6,10.2}},
        color={0,127,255}));
  connect(tempOutside1.port, bufferStorage.heatportOutside) annotation (Line(
        points={{-90,-96.375},{-68,-96.375},{-68,-8.8},{-74.4,-8.8}}, color={
          191,0,0}));
  connect(tempGround.port, OFD.groundTemp) annotation (Line(points={{242,
          -86.375},{267,-86.375},{267,-58}}, color={191,0,0}));
  connect(NaturalVentilation.y[1], OFD.AirExchangePort[1]) annotation (Line(
        points={{162,51},{162,46.7273},{193.3,46.7273}},             color={0,0,
          127}));
  connect(NaturalVentilation.y[1], OFD.AirExchangePort[6]) annotation (Line(
        points={{162,51},{162,50},{193.3,50}},                     color={0,0,127}));
  connect(NaturalVentilation.y[2], OFD.AirExchangePort[2]) annotation (Line(
        points={{162,51},{162,47.3818},{193.3,47.3818}},           color={0,0,127}));
  connect(NaturalVentilation.y[2], OFD.AirExchangePort[7]) annotation (Line(
        points={{162,51},{162,50.6545},{193.3,50.6545}},           color={0,0,127}));
  connect(NaturalVentilation.y[3], OFD.AirExchangePort[4]) annotation (Line(
        points={{162,51},{162,48.6909},{193.3,48.6909}},           color={0,0,127}));
  connect(NaturalVentilation.y[3], OFD.AirExchangePort[9]) annotation (Line(
        points={{162,51},{162,51.9636},{193.3,51.9636}},           color={0,0,127}));
  connect(NaturalVentilation.y[4], OFD.AirExchangePort[5]) annotation (Line(
        points={{162,51},{162,49.3455},{193.3,49.3455}},           color={0,0,127}));
  connect(NaturalVentilation.y[4], OFD.AirExchangePort[10]) annotation (Line(
        points={{162,51},{162,52.6182},{193.3,52.6182}},           color={0,0,127}));
  connect(NaturalVentilation.y[5], OFD.AirExchangePort[3]) annotation (Line(
        points={{162,51},{162,48.0364},{193.3,48.0364}},           color={0,0,127}));
  connect(NaturalVentilation.y[5], OFD.AirExchangePort[8]) annotation (Line(
        points={{162,51},{162,51.3091},{193.3,51.3091}},           color={0,0,127}));
  connect(NaturalVentilation.y[5], OFD.AirExchangePort[11]) annotation (Line(
        points={{162,51},{162,53.2727},{193.3,53.2727}},           color={0,0,127}));
  connect(OFD.uppFloDown, OFD.groFloUp) annotation (Line(points={{200,31.28},{
          182,31.28},{182,14},{200,14}}, color={191,0,0}));
  connect(OFD.groFloDown, OFD.groPlateUp) annotation (Line(points={{200,-26.32},
          {188,-26.32},{188,-43.6},{200,-43.6}}, color={191,0,0}));
  connect(bufferStorage.fluidportTop2, pum.port_a) annotation (Line(points={{
          -85,10.2},{-85,30},{-60,30}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-340,-200},
            {340,200}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-340,-200},{340,200}}),
        graphics={Rectangle(
          extent={{340,100},{140,-100}},
          lineColor={28,108,200},
          lineThickness=1), Text(
          extent={{176,104},{342,138}},
          textColor={28,108,200},
          textString="Building"),                                                                                                               Rectangle(extent={{299,
              -134},{338,-194}},                                                                                                                                                          lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{302,
              -148},{338,-186}},                                                                                                                                                     lineColor={0,0,255},
          textString="1-Bedroom
2-Child1
3-Corridor
4-Bath
5-Child2",horizontalAlignment=TextAlignment.Left),                                                                                                                                                                                                        Text(extent={{301,
              -146},{317,-135}},                                                                                                                                                                        lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "UF"), Rectangle(extent={{218,
              -132},{260,-192}},                                                                                                                                                                              lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{223,
              -144},{239,-133}},                                                                                                                                                      lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "GF"),                                                                                                                       Text(extent={{221,
              -146},{260,-183}},                                                                                                                                                                        lineColor={0,0,255},
          textString="1-Livingroom
2-Hobby
3-Corridor
4-WC
5-Kitchen",
          horizontalAlignment=TextAlignment.Left)}));
end BuildingEnergySystem;
