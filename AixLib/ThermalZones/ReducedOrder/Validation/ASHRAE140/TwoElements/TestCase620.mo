within AixLib.ThermalZones.ReducedOrder.Validation.ASHRAE140.TwoElements;
model TestCase620 "Test case 620"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Interfaces.RealOutput annualHeatingLoad "in MWh"
    annotation (Placement(transformation(extent={{142,-45},{162,-25}})));
  Modelica.Blocks.Interfaces.RealOutput annualCoolingLoad "in MWh"
    annotation (Placement(transformation(extent={{142,-63},{162,-43}})));
  Modelica.Blocks.Interfaces.RealOutput powerLoad "in kW"
    annotation (Placement(transformation(extent={{142,-92},{162,-72}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    TDryBulSou=AixLib.BoundaryConditions.Types.DataSource.Input,
    HInfHorSou=AixLib.BoundaryConditions.Types.DataSource.Input,
    HSou=AixLib.BoundaryConditions.Types.RadiationDataSource.Input_HDirNor_HGloHor,
    filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/WeatherData/ASHRAE140.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-98,68},{-78,88}})));
  AixLib.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil[5](
    each outSkyCon=true,
    each outGroCon=true,
    each rho=0.2,
    til={1.5707963267949,1.5707963267949,1.5707963267949,0,1.5707963267949},
    each lat=0.69394291059295,
    azi={0,1.5707963267949,3.1415926535898,0,-1.5707963267949})
    "Calculates diffuse solar radiation on titled surface for all directions"
    annotation (Placement(transformation(extent={{-68,36},{-48,56}})));
  AixLib.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil[5](
    til={1.5707963267949,1.5707963267949,1.5707963267949,0,1.5707963267949},
    each lat=0.69394291059295,
    azi={0,1.5707963267949,3.1415926535898,0,-1.5707963267949})
    "Calculates direct solar radiation on titled surface for all directions"
    annotation (Placement(transformation(extent={{-68,68},{-48,88}})));
  AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane
    corGDoublePane(n=5,
    UWin=3.046492744695893)
    "Correction factor for solar transmission"
    annotation (Placement(transformation(extent={{6,70},{26,90}})));
  AixLib.ThermalZones.ReducedOrder.RC.TwoElements thermalZoneTwoElements(
    VAir=129.60000000000002,
    hConExt=2.2309677419354843,
    hConWin=3.16,
    gWin=0.789,
    ratioWinConRad=0.03,
    nExt=1,
    RExt={0.000233924171895},
    CExt={1002578.02625},
    hRad=5.129999999999999,
    AInt=48.0,
    hConInt=4.130000000000001,
    nInt=1,
    RInt={0.00123677311011},
    CInt={935138.308506},
    RWin=0.0133333333333,
    RExtRem=0.0191529907385,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    extWallRC(thermCapExt(each der_T(fixed=true))),
    intWallRC(thermCapInt(each der_T(fixed=true))),
    nOrientations=5,
    nPorts=2,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    AWin={0.0,6.0,0.0,0.0,6.0},
    ATransparent={0.0,6.0,0.0,0.0,6.0},
    AExt={21.6,10.200000000000003,21.6,48.0,10.200000000000003}) "Thermal zone"
    annotation (Placement(transformation(extent={{44,14},{92,50}})));
  AixLib.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007WithWindow eqAirTemp(
    n=5,
    wfGro=0,
    withLongwave=true,
    aExt=0.6,
    hConWallOut=24.670000000000005,
    hRad=4.63,
    hConWinOut=16.37,
    wfWin={0.0,0.5,0.0,0.0,0.5},
    wfWall={0.23263907377078896,0.10985734039176147,0.23263907377078896,0.31500717167489906,0.10985734039176147},
    TGro=286.15) "Computes equivalent air temperature" annotation (Placement(transformation(extent={{-24,2},{-4,22}})));
  Modelica.Blocks.Math.Add solRad[5]
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
  Modelica.Blocks.Sources.Constant const[5](each k=0)
    "Sets sunblind signal to zero (open)"
    annotation (Placement(transformation(extent={{-20,30},{-14,36}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus "Weather data bus"
    annotation (Placement(
    transformation(extent={{-100,6},{-66,38}}),  iconTransformation(
    extent={{-70,-12},{-50,8}})));
  Modelica.Blocks.Sources.Constant hConWall(k=29.3*111.60000000000001) "Outdoor coefficient of heat transfer for walls"
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
  Modelica.Blocks.Sources.Constant Inf(k=0.41) "Infiltration rate in 1/h"
    annotation (Placement(transformation(extent={{-98,-36},{-86,-24}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow hea "Ideal heater"
    annotation (Placement(transformation(extent={{56,-70},{76,-50}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC_hea
    "Convert set temperature from degC to Kelvin"
    annotation (Placement(transformation(extent={{-6,-66},{6,-54}})));
  AixLib.Controls.Continuous.LimPID conHea(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0,
    Ti=1) "Heating controller"
    annotation (Placement(transformation(extent={{14,-68},{30,-52}})));
  Modelica.Blocks.Math.Gain gainHea(k=1e6) "Gain for heating controller"
    annotation (Placement(transformation(extent={{38,-66},{50,-54}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    "Sensor for ideal heater"
    annotation (Placement(transformation(extent={{92,-66},{80,-54}})));
  Modelica.Blocks.Sources.Constant SouTSetH(k=20) "Set temperature heater"
    annotation (Placement(transformation(extent={{-24,-66},{-12,-54}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow coo "Ideal cooler"
    annotation (Placement(transformation(extent={{56,-96},{76,-76}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC_coo
    "Convert set temperature from degC to Kelvin"
    annotation (Placement(transformation(extent={{-6,-92},{6,-80}})));
  AixLib.Controls.Continuous.LimPID conCoo(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=0,
    yMin=-1,
    Ti=1) "Cooling controller"
    annotation (Placement(transformation(extent={{14,-94},{30,-78}})));
  Modelica.Blocks.Math.Gain gainCoo(k=1e6) "Gain for cooling controller"
    annotation (Placement(transformation(extent={{38,-92},{50,-80}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor coolFlowSensor
    "Sensor for ideal cooler"
    annotation (Placement(transformation(extent={{92,-92},{80,-80}})));
  Modelica.Blocks.Sources.Constant SouTSetC(k=27) "Set temperature cooler"
    annotation (Placement(transformation(extent={{-24,-92},{-12,-80}})));
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
  Modelica.Blocks.Continuous.Integrator integrator
    "Integrated annual cooling load"
    annotation (Placement(transformation(extent={{107,-58.5},{118,-47.5}})));
  Modelica.Blocks.Continuous.Integrator integrator1
    "Integrated annual heating load"
    annotation (Placement(transformation(extent={{107,-40.5},{118,-29.5}})));
  Modelica.Blocks.Math.Gain gainIntHea(k=1/(1000*1000*3600))
    "Converts to MWh"
    annotation (Placement(transformation(extent={{126,-41},{138,-29}})));
  Modelica.Blocks.Math.Gain gainIntCoo(k=1/(1000*1000*3600))
    "Converts to MWh"
    annotation (Placement(transformation(extent={{126,-59},{138,-47}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=2)
    "Sum of heating and cooling power"
    annotation (Placement(transformation(extent={{126,-97},{136,-87}})));
  Modelica.Blocks.Math.Gain gain2(k=-1) "Changes sign"
    annotation (Placement(transformation(extent={{108,-96},{118,-85}})));
  Modelica.Blocks.Math.Gain gain3(k=-1) "Changes sign"
    annotation (Placement(transformation(extent={{106,-80},{116,-69}})));
  Modelica.Blocks.Math.Gain gainPowLoa(k=0.001) "Converts to kW"
    annotation (Placement(transformation(extent={{126,-76},{138,-64}})));

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
  connect(weaDat.weaBus, HDifTil[5].weaBus)
    annotation (Line(
    points={{-78,78},{-74,78},{-74,46},{-68,46}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus, HDirTil[5].weaBus)
    annotation (Line(
    points={{-78,78},{-73,78},{-68,78}},
    color={255,204,51},
    thickness=0.5));
  connect(intGaiRad.port, thermalZoneTwoElements.intGainsRad) annotation (Line(
        points={{88,-24},{96,-24},{96,40},{92,40}}, color={191,0,0}));
  connect(thermalConductorWin.solid, thermalZoneTwoElements.window)
    annotation (
     Line(points={{38,37},{40,37},{40,36},{44,36}},   color={191,0,0}));
  connect(prescribedTemperature1.port, thermalConductorWin.fluid)
    annotation (Line(points={{20,36},{28,36},{28,37}}, color={191,0,0}));
  connect(thermalZoneTwoElements.extWall, thermalConductorWall.solid)
    annotation (Line(points={{44,28},{40,28},{40,17},{36,17}},
    color={191,0,0}));
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
  connect(intGaiCon.port, thermalZoneTwoElements.intGainsConv) annotation (Line(
        points={{88,-40},{94,-40},{94,36},{92,36}}, color={191,0,0}));
  connect(corGDoublePane.solarRadWinTrans, thermalZoneTwoElements.solRad)
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
  connect(Inf.y, gain.u) annotation (Line(points={{-85.4,-30},{-85.4,-30},{-81.4,
          -30}}, color={0,0,127}));
  connect(ventilationIn.ports[1], thermalZoneTwoElements.ports[1]) annotation (
      Line(points={{-34,-38},{-30,-38},{-30,-10},{81.475,-10},{81.475,14.05}},
        color={0,127,255}));
  connect(ventilationOut.ports[1], thermalZoneTwoElements.ports[2]) annotation (
     Line(points={{-34,-70},{-26,-70},{-26,-14},{84.525,-14},{84.525,14.05}},
        color={0,127,255}));
  connect(from_degC_hea.y, conHea.u_s)
    annotation (Line(points={{6.6,-60},{12.4,-60}}, color={0,0,127}));
  connect(conHea.y, gainHea.u)
    annotation (Line(points={{30.8,-60},{36.8,-60}}, color={0,0,127}));
  connect(gainHea.y, hea.Q_flow)
    annotation (Line(points={{50.6,-60},{56,-60}}, color={0,0,127}));
  connect(hea.port, heatFlowSensor.port_b)
    annotation (Line(points={{76,-60},{80,-60}}, color={191,0,0}));
  connect(heatFlowSensor.port_a, thermalZoneTwoElements.intGainsConv)
    annotation (Line(points={{92,-60},{94,-60},{94,34},{94,36},{92,36}},
                                                                 color={191,0,0}));
  connect(SouTSetH.y, from_degC_hea.u) annotation (Line(points={{-11.4,-60},{-11.4,
          -60},{-7.2,-60}}, color={0,0,127}));
  connect(conHea.u_m, thermalZoneTwoElements.TAir) annotation (Line(points={{22,
          -69.6},{22,-69.6},{22,-73},{98,-73},{98,48},{93,48}}, color={0,0,127}));
  connect(from_degC_coo.y, conCoo.u_s)
    annotation (Line(points={{6.6,-86},{12.4,-86}}, color={0,0,127}));
  connect(conCoo.y, gainCoo.u)
    annotation (Line(points={{30.8,-86},{36.8,-86}}, color={0,0,127}));
  connect(gainCoo.y, coo.Q_flow)
    annotation (Line(points={{50.6,-86},{56,-86}}, color={0,0,127}));
  connect(coo.port,coolFlowSensor. port_b)
    annotation (Line(points={{76,-86},{80,-86}}, color={191,0,0}));
  connect(coolFlowSensor.port_a, thermalZoneTwoElements.intGainsConv)
    annotation (Line(points={{92,-86},{94,-86},{94,8},{94,36},{92,36}}, color={191,
          0,0}));
  connect(SouTSetC.y, from_degC_coo.u) annotation (Line(points={{-11.4,-86},{-11.4,
          -86},{-7.2,-86}}, color={0,0,127}));
  connect(conCoo.u_m, thermalZoneTwoElements.TAir) annotation (Line(points={{22,
          -95.6},{22,-95.6},{22,-99},{98,-99},{98,48},{93,48}}, color={0,0,127}));
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
  connect(coolFlowSensor.Q_flow, gain2.u) annotation (Line(points={{86,-92},{86,
          -94},{100,-94},{100,-90.5},{107,-90.5}}, color={0,0,127}));
  connect(gain2.y, multiSum.u[1]) annotation (Line(points={{118.5,-90.5},{120,
          -90.5},{120,-90.25},{126,-90.25}}, color={0,0,127}));
  connect(heatFlowSensor.Q_flow, gain3.u) annotation (Line(points={{86,-66},{86,
          -66},{86,-74},{86,-74.5},{96,-74.5},{105,-74.5}}, color={0,0,127}));
  connect(gain3.y, multiSum.u[2]) annotation (Line(points={{116.5,-74.5},{
          121.25,-74.5},{121.25,-93.75},{126,-93.75}}, color={0,0,127}));
  connect(gainIntHea.y, annualHeatingLoad) annotation (Line(points={{138.6,-35},
          {140.3,-35},{152,-35}}, color={0,0,127}));
  connect(gainIntHea.u, integrator1.y) annotation (Line(points={{124.8,-35},{
          121.4,-35},{118.55,-35}}, color={0,0,127}));
  connect(gainIntCoo.y, annualCoolingLoad) annotation (Line(points={{138.6,-53},
          {141.3,-53},{152,-53}}, color={0,0,127}));
  connect(gainIntCoo.u, integrator.y) annotation (Line(points={{124.8,-53},{
          121.4,-53},{118.55,-53}}, color={0,0,127}));
  connect(gain3.y, integrator1.u) annotation (Line(points={{116.5,-74.5},{122,
          -74.5},{122,-64},{102,-64},{102,-35},{105.9,-35}}, color={0,0,127}));
  connect(gain2.y, integrator.u) annotation (Line(points={{118.5,-90.5},{118.5,
          -62},{105.9,-62},{105.9,-53}}, color={0,0,127}));
  connect(multiSum.y, gainPowLoa.u) annotation (Line(points={{136.85,-92},{138,
          -92},{138,-82},{124.8,-82},{124.8,-70}}, color={0,0,127}));
  connect(gainPowLoa.y, powerLoad) annotation (Line(points={{138.6,-70},{140,
          -70},{140,-82},{152,-82}}, color={0,0,127}));
  annotation (experiment(
      StopTime=3.1536e+007,
      Interval=3600),
    Diagram(coordinateSystem(extent={{-140,-100},{160,100}}), graphics={
        Rectangle(
          extent={{102,100},{160,-100}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{85,99},{146,91}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Outputs"),
        Rectangle(
          extent={{-25,-48},{101,-100}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{33,-91},{94,-99}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Heater"),
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
          extent={{-140,100},{-2,-7}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-1,100},{101,-7}},
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
          extent={{49,99},{110,91}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Thermal Zone")}),
    Icon(coordinateSystem(extent={{-140,-100},{160,100}})),
    Documentation(revisions="<html><ul>
  <li>March 17, 2017, by Moritz Lauster:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>
  Test Case 620 of the ASHRAE 140-2007: Calculation of heating/cooling
  loads for room version light excited by internal and external gains
  but with windows to the east and west.
</p>
<h4>
  Boundary conditions
</h4>
<ul>
  <li>yearly profile for outdoor air temperature and solar radiation in
  hourly steps
  </li>
  <li>constant set temperatures of heating and cooling
  </li>
  <li>constant internal gains and infiltration rate
  </li>
</ul>
</html>"));
end TestCase620;
