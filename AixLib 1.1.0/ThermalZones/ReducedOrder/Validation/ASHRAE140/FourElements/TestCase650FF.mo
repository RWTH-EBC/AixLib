within AixLib.ThermalZones.ReducedOrder.Validation.ASHRAE140.FourElements;
model TestCase650FF "Test case 650 free float"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Interfaces.RealOutput freeFloatTemperature(unit="degC")
    "Free floating temperature"
      annotation (Placement(transformation(extent={{124,66},{144,86}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    TDryBulSou=AixLib.BoundaryConditions.Types.DataSource.Input,
    HInfHorSou=AixLib.BoundaryConditions.Types.DataSource.Input,
    HSou=AixLib.BoundaryConditions.Types.RadiationDataSource.Input_HDirNor_HGloHor,
    filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/WeatherData/ASHRAE140.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-98,68},{-78,88}})));
  AixLib.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil[4](
    each outSkyCon=true,
    each outGroCon=true,
    each rho=0.2,
    til={1.5707963267949,1.5707963267949,1.5707963267949,1.5707963267949},
    each lat=0.69394291059295,
    azi={0,1.5707963267949,3.1415926535898,-1.5707963267949})
    "Calculates diffuse solar radiation on titled surface for all directions"
    annotation (Placement(transformation(extent={{-68,36},{-48,56}})));
  AixLib.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil[4](
    til={1.5707963267949,1.5707963267949,1.5707963267949,1.5707963267949},
    each lat=0.69394291059295,
    azi={0,1.5707963267949,3.1415926535898,-1.5707963267949})
    "Calculates direct solar radiation on titled surface for all directions"
    annotation (Placement(transformation(extent={{-68,68},{-48,88}})));
  AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane
    corGDoublePane(
    UWin=3.046492744695893, n=4)
    "Correction factor for solar transmission"
    annotation (Placement(transformation(extent={{6,70},{26,90}})));
  AixLib.ThermalZones.ReducedOrder.RC.FourElements thermalZoneFourElements(
    VAir=129.60000000000002,
    hConWin=3.16,
    gWin=0.789,
    ratioWinConRad=0.03,
    nExt=1,
    hRad=5.129999999999999,
    AInt=48.0,
    hConInt=4.130000000000001,
    nInt=1,
    RInt={0.00123677311011},
    CInt={935138.308506},
    RWin=0.0133333333333,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    extWallRC(thermCapExt(each der_T(fixed=true))),
    intWallRC(thermCapInt(each der_T(fixed=true))),
    nPorts=2,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    AFloor=0,
    hConFloor=0,
    nFloor=1,
    RFloor={0.1},
    RFloorRem=0.1,
    CFloor={0.1},
    roofRC(thermCapExt(each der_T(fixed=true))),
    nOrientations=4,
    AExt={9.600000000000001,16.200000000000003,21.6,16.200000000000003},
    hConExt=3.160000000000001,
    RExt={0.000401763119801},
    RExtRem=0.0277316600608,
    CExt={620991.387295},
    ARoof=48.0,
    hConRoof=1.0,
    nRoof=1,
    RRoof={0.000550791436374},
    CRoof={381586.716241},
    AWin={12.0,0.0,0.0,0.0},
    ATransparent={12.0,0.0,0.0,0.0},
    RRoofRem=0.061807839516) "Thermal zone" annotation (Placement(transformation(extent={{44,14},{92,50}})));
  AixLib.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007WithWindow eqAirTemp(
    wfGro=0,
    withLongwave=true,
    aExt=0.6,
    hConWallOut=24.670000000000005,
    hRad=4.63,
    hConWinOut=16.37,
    n=4,
    wfWall={0.15094339622641512,0.2547169811320755,0.33962264150943394,0.2547169811320755},
    wfWin={1.0,0.0,0.0,0.0},
    TGro=286.15) "Computes equivalent air temperature" annotation (Placement(transformation(extent={{-24,2},{-4,22}})));
  Modelica.Blocks.Math.Add solRad[4]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{-38,22},{-28,32}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    "Prescribed temperature for exterior walls outdoor surface temperature"
    annotation (Placement(transformation(extent={{8,10},{20,22}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature1
    "Prescribed temperature for windows outdoor surface temperature"
    annotation (Placement(transformation(extent={{8,30},{20,42}})));
  Modelica.Thermal.HeatTransfer.Components.Convection thermalConductorWin
    "Outdoor convective heat transfer of windows"
    annotation (Placement(transformation(extent={{38,32},{28,42}})));
  Modelica.Thermal.HeatTransfer.Components.Convection thermalConductorWall
    "Outdoor convective heat transfer of walls"
    annotation (Placement(transformation(extent={{36,22},{26,12}})));
  Modelica.Blocks.Sources.Constant const[4](each k=0)
    "Sets sunblind signal to zero (open)"
    annotation (Placement(transformation(extent={{-20,30},{-14,36}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus "Weather data bus"
    annotation (Placement(
    transformation(extent={{-100,6},{-66,38}}),  iconTransformation(
    extent={{-70,-12},{-50,8}})));
  Modelica.Blocks.Sources.Constant hConWall(k=29.3*63.60000000000001) "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}}, rotation=90)));
  Modelica.Blocks.Sources.Constant hConWin(k=21.0*12.0) "Outdoor coefficient of heat transfer for windows"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}}, rotation=90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow intGaiRad
    "Radiative heat flow of internal gains"
    annotation (Placement(transformation(extent={{68,-34},{88,-14}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow intGaiCon
    "Convective heat flow of internal gains"
    annotation (Placement(transformation(extent={{68,-50},{88,-30}})));
  Modelica.Blocks.Sources.Constant souIntGai(k=200) "Internal gains in W"
    annotation (Placement(transformation(extent={{-2,-33},{11,-20}})));
  Modelica.Blocks.Math.Gain gainRad(k=0.6) "Radiant part"
    annotation (Placement(transformation(extent={{38,-29},{48,-19}})));
  Modelica.Blocks.Math.Gain gainCon(k=0.4) "Convective part"
    annotation (Placement(transformation(extent={{38,-45},{48,-35}})));
  Modelica.Blocks.Math.Gain gain(k=0.0441)
    "Conversion to kg/s"
    annotation (Placement(transformation(extent={{-80,-37},{-66,-23}})));
  AixLib.Fluid.Sources.MassFlowSource_T ventilationIn(
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa)
    "Fan"
    annotation (Placement(transformation(extent={{-54,-48},{-34,-28}})));
  AixLib.Fluid.Sources.MassFlowSource_T ventilationOut(
    use_m_flow_in=true,
    use_T_in=false,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa)
    "Fan"
    annotation (Placement(transformation(extent={{-54,-80},{-34,-60}})));
  Modelica.Blocks.Math.Gain gain1(k=-1) "Reverses ventilation rate"
    annotation (Placement(transformation(extent={{-82,-69},{-68,-55}})));
  Modelica.Blocks.Sources.CombiTimeTable souWea(
    tableOnFile=true,
    columns={2,3,4},
    tableName="Table",
    fileName=Modelica.Utilities.Files.loadResource(
    "modelica://AixLib/Resources/WeatherData/WeatherData_Ashrae140_LOM.mat"))
    "Weather data"
    annotation (Placement(transformation(extent={{-136,74},{-116,94}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    "Addition of hemispherical and terrestrial radiation"
    annotation (Placement(transformation(extent={{-134,52},{-122,64}})));
  Modelica.Blocks.Math.Division division "Mean value of radiation"
    annotation (Placement(transformation(extent={{-116,48},{-104,60}})));
  Modelica.Blocks.Sources.Constant numRad(k=2) "Number of radiation ports"
    annotation (Placement(transformation(extent={{-134,36},{-122,48}})));
  Modelica.Blocks.Sources.CombiTimeTable souRad(
    tableOnFile=true,
    tableName="Table",
    columns={2,3},
    fileName=Modelica.Utilities.Files.loadResource(
    "modelica://AixLib/Resources/WeatherData/Weatherdata_ASHARE140.mat"))
    "Solar radiation data"
    annotation (Placement(transformation(extent={{-136,4},{-116,24}})));
  AixLib.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTilRoof[1](
    til={0},
    each lat=0.69394291059295,
    azi={0})
    "Calculates direct solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-68,124},{-48,144}})));
  AixLib.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTilRoof[1](
    til={0},
    each lat=0.69394291059295,
    azi={0})
    "Calculates diffuse solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-68,96},{-48,116}})));
  AixLib.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007 eqAirTempVDI(
    aExt=0.6,
    wfGro=0,
    hConWallOut=24.670000000000005,
    hRad=4.63,
    n=1,
    wfWall={1.0},
    wfWin={0},
    TGro=285.15) "Computes equivalent air temperature for roof" annotation (Placement(transformation(extent={{30,110},{50,130}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperatureRoof
    "Prescribed temperature for roof outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},rotation=-90,
    origin={67,84})));
  Modelica.Thermal.HeatTransfer.Components.Convection thermalConductorRoof
    "Outdoor convective heat transfer of roof"
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},rotation=-90,
    origin={67,67})));
  Modelica.Blocks.Sources.Constant hConRoof(k=29.3*48) "Outdoor coefficient of heat transfer for roof"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}}, rotation=0)));
  Modelica.Blocks.Sources.Constant const1[1](each k=0)
    "Sets sunblind signal to zero (open)" annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=90,
        origin={40,151})));
  Modelica.Blocks.Math.Add solRadRoof[1]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{4,126},{14,136}})));
  Modelica.Blocks.Sources.CombiTimeTable InfVen(
    columns={2},
    tableOnFile=false,
    tableName="NoName",
    fileName="NoName",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,11.21; 25200,11.21; 25200,0.41; 64800,0.41; 64800,11.21; 86400,11.21])
    annotation (Placement(transformation(extent={{-98,-36},{-86,-24}})));
  Modelica.Blocks.Math.UnitConversions.To_degC to_degC
    "Indoor air temperature in degC"
    annotation (Placement(transformation(extent={{122,40},{134,52}})));

equation
  connect(eqAirTemp.TEqAirWin, prescribedTemperature1.T)
    annotation (Line(
    points={{-3,15.8},{0,15.8},{0,36},{6.8,36}},   color={0,0,127}));
  connect(eqAirTemp.TEqAir, prescribedTemperature.T)
    annotation (Line(points={{-3,12},{4,12},{4,16},{6.8,16}},
    color={0,0,127}));
  connect(weaDat.weaBus, weaBus)
    annotation (Line(
    points={{-78,78},{-74,78},{-74,34},{-84,34},{-84,28},{-83,28},{-83,22}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%second",
    index=1,
    extent={{6,3},{6,3}}));
  connect(weaBus.TDryBul, eqAirTemp.TDryBul)
    annotation (Line(
    points={{-83,22},{-83,14},{-38,14},{-38,6},{-26,6}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%first",
    index=-1,
    extent={{-6,3},{-6,3}}));
  connect(const.y, eqAirTemp.sunblind)
    annotation (Line(points={{-13.7,33},{-12,33},{-12,24},{-14,24}},
    color={0,0,127}));
  connect(HDifTil.HSkyDifTil, corGDoublePane.HSkyDifTil)
    annotation (Line(
    points={{-47,52},{-28,52},{-6,52},{-6,82},{4,82}}, color={0,0,127}));
  connect(HDirTil.H, corGDoublePane.HDirTil)
    annotation (Line(points={{-47,78},{-10,78},{-10,86},{4,86}},
    color={0,0,127}));
  connect(HDirTil.H,solRad. u1)
    annotation (Line(points={{-47,78},{-42,78},{-42,30},{-39,30}},
                   color={0,0,127}));
  connect(HDirTil.inc, corGDoublePane.inc)
    annotation (Line(points={{-47,74},{4,74}},        color={0,0,127}));
  connect(HDifTil.H,solRad. u2)
    annotation (Line(points={{-47,46},{-44,46},{-44,24},{-39,24}},
                 color={0,0,127}));
  connect(HDifTil.HGroDifTil, corGDoublePane.HGroDifTil)
    annotation (Line(
    points={{-47,40},{-4,40},{-4,78},{4,78}}, color={0,0,127}));
  connect(solRad.y, eqAirTemp.HSol)
    annotation (Line(points={{-27.5,27},{-26,27},{-26,18}},
    color={0,0,127}));
  connect(weaDat.weaBus, HDifTil[1].weaBus)
    annotation (Line(
    points={{-78,78},{-74,78},{-74,46},{-68,46}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus, HDirTil[1].weaBus)
    annotation (Line(
    points={{-78,78},{-73,78},{-68,78}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus, HDifTil[2].weaBus)
    annotation (Line(
    points={{-78,78},{-74,78},{-74,46},{-68,46}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus, HDirTil[2].weaBus)
    annotation (Line(
    points={{-78,78},{-73,78},{-68,78}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus, HDifTil[3].weaBus)
    annotation (Line(
    points={{-78,78},{-74,78},{-74,46},{-68,46}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus, HDirTil[3].weaBus)
    annotation (Line(
    points={{-78,78},{-73,78},{-68,78}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus, HDifTil[4].weaBus)
    annotation (Line(
    points={{-78,78},{-74,78},{-74,46},{-68,46}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus, HDirTil[4].weaBus)
    annotation (Line(
    points={{-78,78},{-73,78},{-68,78}},
    color={255,204,51},
    thickness=0.5));
  connect(intGaiRad.port, thermalZoneFourElements.intGainsRad) annotation (Line(
        points={{88,-24},{96,-24},{96,40},{92,40}}, color={191,0,0}));
  connect(thermalConductorWin.solid, thermalZoneFourElements.window)
    annotation (Line(points={{38,37},{40,37},{40,36},{44,36}}, color={191,0,0}));
  connect(prescribedTemperature1.port, thermalConductorWin.fluid)
    annotation (Line(points={{20,36},{28,36},{28,37}}, color={191,0,0}));
  connect(thermalZoneFourElements.extWall, thermalConductorWall.solid)
    annotation (Line(points={{44,28},{40,28},{40,17},{36,17}}, color={191,0,0}));
  connect(thermalConductorWall.fluid, prescribedTemperature.port)
    annotation (Line(points={{26,17},{24,17},{24,16},{20,16}},
                                                           color={191,0,0}));
  connect(hConWall.y, thermalConductorWall.Gc) annotation (Line(points={{0,4.4},{0,12},{31,12}}, color={0,0,127}));
  connect(hConWin.y, thermalConductorWin.Gc) annotation (Line(points={{0,-4.4},{0,42},{33,42}}, color={0,0,127}));
  connect(weaBus.TBlaSky, eqAirTemp.TBlaSky)
    annotation (Line(
    points={{-83,22},{-58,22},{-58,18},{-32,18},{-32,12},{-26,12}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%first",
    index=-1,
    extent={{-6,3},{-6,3}}));
  connect(intGaiCon.port, thermalZoneFourElements.intGainsConv) annotation (
      Line(points={{88,-40},{94,-40},{94,36},{92,36}}, color={191,0,0}));
  connect(corGDoublePane.solarRadWinTrans, thermalZoneFourElements.solRad)
    annotation (Line(points={{27,80},{34,80},{40,80},{40,47},{43,47}}, color={0,
          0,127}));
  connect(gainRad.y, intGaiRad.Q_flow) annotation (Line(points={{48.5,-24},{68,
          -24}},          color={0,0,127}));
  connect(gainCon.y, intGaiCon.Q_flow)
    annotation (Line(points={{48.5,-40},{58,-40},{68,-40}},
                                                   color={0,0,127}));
  connect(souIntGai.y, gainCon.u) annotation (Line(points={{11.65,-26.5},{23.825,
          -26.5},{23.825,-40},{37,-40}}, color={0,0,127}));
  connect(souIntGai.y, gainRad.u) annotation (Line(points={{11.65,-26.5},{23.825,
          -26.5},{23.825,-24},{37,-24}}, color={0,0,127}));
  connect(gain.y,ventilationIn. m_flow_in)
    annotation (Line(points={{-65.3,-30},{-56,-30}}, color={0,0,127}));
  connect(gain.y,gain1. u)
    annotation (Line(points={{-65.3,-30},{-64,-30},{-64,-46},{-90,-46},{-90,-62},
          {-83.4,-62}},                    color={0,0,127}));
  connect(gain1.y,ventilationOut. m_flow_in)
    annotation (Line(points={{-67.3,-62},{-56,-62}}, color={0,0,127}));
  connect(weaBus.TDryBul, ventilationIn.T_in) annotation (Line(
      points={{-83,22},{-83,-14},{-60,-14},{-60,-34},{-56,-34}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(ventilationIn.ports[1], thermalZoneFourElements.ports[1]) annotation (
     Line(points={{-34,-38},{-30,-38},{-30,-10},{81.475,-10},{81.475,14.05}},
        color={0,127,255}));
  connect(ventilationOut.ports[1], thermalZoneFourElements.ports[2])
    annotation (Line(points={{-34,-70},{-26,-70},{-26,-14},{84.525,-14},{84.525,
          14.05}}, color={0,127,255}));
  connect(souWea.y[1], weaDat.TDryBul_in) annotation (Line(points={{-115,84},{-110,
          84},{-110,87},{-99,87}}, color={0,0,127}));
  connect(souWea.y[2], add.u1) annotation (Line(points={{-115,84},{-115,84},{-110,
          84},{-110,70},{-138,70},{-138,61.6},{-135.2,61.6}}, color={0,0,127}));
  connect(souWea.y[3], add.u2) annotation (Line(points={{-115,84},{-110,84},{-110,
          70},{-138,70},{-138,54.4},{-135.2,54.4}}, color={0,0,127}));
  connect(add.y, division.u1) annotation (Line(points={{-121.4,58},{-117.2,58},{
          -117.2,57.6}}, color={0,0,127}));
  connect(numRad.y, division.u2) annotation (Line(points={{-121.4,42},{-117.2,42},
          {-117.2,50.4}}, color={0,0,127}));
  connect(division.y, weaDat.HInfHor_in) annotation (Line(points={{-103.4,54},{-100,
          54},{-100,62},{-104,62},{-104,68.5},{-99,68.5}}, color={0,0,127}));
  connect(souRad.y[1], weaDat.HDirNor_in) annotation (Line(points={{-115,14},{-106,
          14},{-94,14},{-94,64},{-102,64},{-102,67},{-99,67}}, color={0,0,127}));
  connect(souRad.y[2], weaDat.HGloHor_in) annotation (Line(points={{-115,14},{-94,
          14},{-94,64},{-102,64},{-102,65},{-99,65}}, color={0,0,127}));
  connect(HDirTilRoof.H, solRadRoof.u1)
    annotation (Line(points={{-47,134},{-47,134},{3,134}},
                                                        color={0,0,127}));
  connect(prescribedTemperatureRoof.port,thermalConductorRoof. fluid)
    annotation (Line(points={{67,78},{67,78},{67,72}}, color={191,0,0}));
  connect(thermalConductorRoof.Gc, hConRoof.y) annotation (Line(points={{72,67},{-4.4,67},{-4.4,0}}, color={0,0,127}));
  connect(eqAirTempVDI.TEqAir,prescribedTemperatureRoof. T) annotation (Line(
        points={{51,120},{56,120},{56,98},{67,98},{67,91.2}},
                                                            color={0,0,127}));
  connect(const1.y, eqAirTempVDI.sunblind) annotation (Line(points={{40,147.7},{
          40,147.7},{40,132}}, color={0,0,127}));
  connect(HDifTilRoof.H, solRadRoof.u2) annotation (Line(points={{-47,106},{-22,
          106},{-22,128},{3,128}}, color={0,0,127}));
  connect(weaDat.weaBus, HDifTilRoof[1].weaBus) annotation (Line(
      points={{-78,78},{-74,78},{-74,106},{-68,106}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, HDirTilRoof[1].weaBus) annotation (Line(
      points={{-78,78},{-74,78},{-74,134},{-68,134}},
      color={255,204,51},
      thickness=0.5));
  connect(solRadRoof.y, eqAirTempVDI.HSol) annotation (Line(points={{14.5,131},{
          22,131},{22,126},{28,126}}, color={0,0,127}));
  connect(weaBus.TBlaSky, eqAirTempVDI.TBlaSky) annotation (Line(
      points={{-83,22},{-70,22},{-70,122},{16,122},{16,120},{28,120}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul, eqAirTempVDI.TDryBul) annotation (Line(
      points={{-83,22},{-82,22},{-82,14},{-72,14},{-72,94},{16,94},{16,114},{28,
          114}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(thermalConductorRoof.solid, thermalZoneFourElements.roof)
    annotation (Line(points={{67,62},{66.9,62},{66.9,50}}, color={191,0,0}));
  connect(gain.u, InfVen.y[1]) annotation (Line(points={{-81.4,-30},{-85.4,-30},
          {-85.4,-30}}, color={0,0,127}));
  connect(to_degC.y,freeFloatTemperature)  annotation (Line(points={{134.6,46},{
          142,46},{142,64},{114,64},{114,76},{134,76}},  color={0,0,127}));
  connect(thermalZoneFourElements.TAir, to_degC.u) annotation (Line(points={{93,48},
          {106,48},{106,46},{120.8,46}}, color={0,0,127}));
  annotation (experiment(
      StopTime=3.1536e+007,
      Interval=3600),
    Diagram(coordinateSystem(extent={{-140,-100},{160,160}}), graphics={
        Rectangle(
          extent={{102,160},{160,-100}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{89,155},{150,147}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Outputs"),
        Rectangle(
          extent={{-25,-48},{101,-100}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-25,-8},{101,-47}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-33,-39},{28,-47}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Internal Gains"),
        Rectangle(
          extent={{-106,-8},{-26,-100}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-97,-89},{-36,-97}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Infiltration"),
        Rectangle(
          extent={{-140,160},{-2,-7}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-1,160},{101,-7}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-131,3},{-70,-5}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Weather"),
        Text(
          extent={{45,155},{106,147}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Thermal Zone"),
        Text(
          extent={{33,-91},{94,-99}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Heater")}),
    Icon(coordinateSystem(extent={{-140,-100},{160,160}})),
    Documentation(revisions="<html><ul>
  <li>March 17, 2017, by Moritz Lauster:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>
  Test Case 650FF of the ASHRAE 140-2007: Calculation of free float
  indoor air temperature for room version light excited by internal and
  external gains.
</p>
<h4>
  Boundary conditions
</h4>
<ul>
  <li>yearly profile for outdoor air temperature and solar radiation in
  hourly steps
  </li>
  <li>constant internal gains and daily profile for infiltration rate
  </li>
</ul>
</html>"));
end TestCase650FF;
