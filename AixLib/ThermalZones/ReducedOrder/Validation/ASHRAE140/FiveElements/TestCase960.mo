within AixLib.ThermalZones.ReducedOrder.Validation.ASHRAE140.FiveElements;
model TestCase960 "Test case 960"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Interfaces.RealOutput annHeaLoa "annual heating load in MWh"
    annotation (Placement(transformation(extent={{142,-44},{162,-24}})));
  Modelica.Blocks.Interfaces.RealOutput annCooLoa "annual cooling load in MWh"
    annotation (Placement(transformation(extent={{142,-62},{162,-42}})));
  Modelica.Blocks.Interfaces.RealOutput powLoa "power load in kW"
    annotation (Placement(transformation(extent={{142,-91},{162,-71}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    TDryBulSou=AixLib.BoundaryConditions.Types.DataSource.Input,
    HInfHorSou=AixLib.BoundaryConditions.Types.DataSource.Input,
    HSou=AixLib.BoundaryConditions.Types.RadiationDataSource.Input_HDirNor_HGloHor,
    filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/WeatherData/ASHRAE140.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-202,84},{-182,104}})));
  AixLib.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil[4](
    each outSkyCon=true,
    each outGroCon=true,
    each rho=0.2,
    til={1.5707963267949,1.5707963267949,1.5707963267949,1.5707963267949},
    azi={0,1.5707963267949,3.1415926535898,-1.5707963267949})
    "Calculates diffuse solar radiation on titled surface for all directions"
    annotation (Placement(transformation(extent={{-68,36},{-48,56}})));
  AixLib.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil[4](til
      ={1.5707963267949,1.5707963267949,1.5707963267949,1.5707963267949}, azi={
        0,1.5707963267949,3.1415926535898,-1.5707963267949})
    "Calculates direct solar radiation on titled surface for all directions"
    annotation (Placement(transformation(extent={{-68,68},{-48,88}})));
  AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane corGvaDouPan(UWin=3.046492744695893, n=4)
    "Correction factor for solar transmission"
    annotation (Placement(transformation(extent={{6,70},{26,90}})));
  AixLib.ThermalZones.ReducedOrder.RC.FiveElements bacZoneFivEle(
    VAir=129.60000000000002,
    hConWin=3.16,
    gWin=0.789,
    ratioWinConRad=0.03,
    nExt=1,
    hRad=0.2420686281307021,
    AInt=0.0,
    hConInt=4.130000000000001,
    nInt=1,
    RInt={0.00123677311011},
    CInt={935138.308506},
    RWin=0.0133333333333,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    extWallRC(thermCapExt(each der_T(fixed=true))),
    intWallRC(thermCapInt(each der_T(fixed=true))),
    nIze=1,
    AIze={48.90700957621479},
    hConIze={2.2},
    nIzeRC=1,
    RIze={{0.0013357135289553492}},
    RIzeRem={0.0066827048152285455},
    CIze={{8184026.966222254}},
    othZoneInd={2},
    zoneInd=1,
    nPorts=2,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    AFloor=48.0,
    hConFloor=2.2,
    nFloor=1,
    RFloor={0.001236773110105941},
    RFloorRem=0.5248792983184654,
    CFloor={935138.3085064382},
    roofRC(thermCapExt(each der_T(fixed=true))),
    nOrientations=4,
    AExt={0.0,14.0,10.0,14.0},
    hConExt=2.2,
    RExt={0.0006724245899823317},
    RExtRem=0.046414041575431206,
    CExt={371032.5898932695},
    ARoof=48.0,
    hConRoof=1.7999999999999998,
    nRoof=1,
    RRoof={0.000550791436374201},
    CRoof={381586.7162407001},
    AWin={0.0,0.0,0.0,0.0},
    ATransparent={0.0,0.0,0.0,0.0},
    RRoofRem=0.06180783951600674)
    "Thermal zone representation of the back zone"
    annotation (Placement(transformation(extent={{44,14},{92,50}})));
  AixLib.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007WithWindow
    TEquAir(
    wfGro=0,
    withLongwave=true,
    aExt=0.6,
    hConWallOut=11.9,
    hRad=9.700000000000001,
    hConWinOut=16.37,
    n=4,
    wfWall={0.0,0.3684210526315789,0.26315789473684215,0.3684210526315789},
    wfWin={1.0,0.0,0.0,0.0},
    TGro=286.15) "Computes equivalent air temperature" annotation (Placement(
        transformation(extent={{-24,2},{-4,22}})));
  Modelica.Blocks.Math.Add solRad[4]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{-38,22},{-28,32}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TPreExtWal
    "Prescribed temperature for exterior walls outdoor surface temperature"
    annotation (Placement(transformation(extent={{8,10},{20,22}})));
  Modelica.Thermal.HeatTransfer.Components.Convection conHeaWal
    "Outdoor convective heat transfer of walls"
    annotation (Placement(transformation(extent={{36,22},{26,12}})));
  Modelica.Blocks.Sources.Constant const[4](each k=0)
    "Sets sunblind signal to zero (open)"
    annotation (Placement(transformation(extent={{-20,30},{-14,36}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus "Weather data bus"
    annotation (Placement(
    transformation(extent={{-100,6},{-66,38}}),  iconTransformation(
    extent={{-70,-12},{-50,8}})));
  Modelica.Blocks.Sources.Constant hConWal(k=11.9*54)
    "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}}, rotation=90)));
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
  Modelica.Blocks.Math.Gain gain(k=0.0365616)
    "Conversion to kg/s"
    annotation (Placement(transformation(extent={{-80,-37},{-66,-23}})));
  AixLib.Fluid.Sources.MassFlowSource_T venIn(
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa) "Fan in"
    annotation (Placement(transformation(extent={{-54,-48},{-34,-28}})));
  AixLib.Fluid.Sources.MassFlowSource_T venOut(
    use_m_flow_in=true,
    use_T_in=false,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa) "Fan out"
    annotation (Placement(transformation(extent={{-54,-80},{-34,-60}})));
  Modelica.Blocks.Math.Gain gain1(k=-1) "Reverses ventilation rate"
    annotation (Placement(transformation(extent={{-82,-69},{-68,-55}})));
  Modelica.Blocks.Sources.Constant Inf(k=0.41) "Infiltration rate in 1/h"
    annotation (Placement(transformation(extent={{-98,-36},{-86,-24}})));
  Modelica.Blocks.Sources.CombiTimeTable souWea(
    tableOnFile=true,
    columns={2,3,4},
    tableName="Table",
    fileName=Modelica.Utilities.Files.loadResource(
    "modelica://AixLib/Resources/WeatherData/WeatherData_Ashrae140_LOM.txt"))
    "Weather data"
    annotation (Placement(transformation(extent={{-240,90},{-220,110}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    "Addition of hemispherical and terrestrial radiation"
    annotation (Placement(transformation(extent={{-238,68},{-226,80}})));
  Modelica.Blocks.Math.Division divRad "Mean value of radiation"
    annotation (Placement(transformation(extent={{-220,64},{-208,76}})));
  Modelica.Blocks.Sources.Constant numRad(k=2) "Number of radiation ports"
    annotation (Placement(transformation(extent={{-238,52},{-226,64}})));
  Modelica.Blocks.Sources.CombiTimeTable souRad(
    tableOnFile=true,
    tableName="Table",
    columns={2,3},
    fileName=Modelica.Utilities.Files.loadResource(
    "modelica://AixLib/Resources/WeatherData/Weatherdata_ASHARE140.txt"))
    "Solar radiation data"
    annotation (Placement(transformation(extent={{-240,20},{-220,40}})));
  AixLib.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTilRoo[1](
     til={0}, azi={0})
    "Calculates direct solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-68,124},{-48,144}})));
  AixLib.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTilRoo[1](til={0},
      azi={0})
    "Calculates diffuse solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-68,96},{-48,116}})));
  AixLib.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007 TAirEquRoo(
    aExt=0.6,
    wfGro=0,
    hConWallOut=14.399999999999999,
    hRad=7.400000000000001,
    n=1,
    wfWall={1.0},
    wfWin={0},
    TGro=285.15) "Computes equivalent air temperature for roof" annotation (Placement(
        transformation(extent={{30,110},{50,130}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TPreRoo
    "Prescribed temperature for roof outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}}, rotation=-90,
        origin={68,86})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConRoo
    "Outdoor convective heat transfer of roof"
    annotation (Placement(transformation(extent={{5,-5},{-5,5}}, rotation=-90,
        origin={68,64})));
  Modelica.Blocks.Sources.Constant hConRoo(k=14.399999999999999*48)
    "Outdoor coefficient of heat transfer for roof"
    annotation (Placement(transformation(extent={{92,64},{84,72}}, rotation=0)));
  Modelica.Blocks.Sources.Constant const1[1](each k=0)
    "Sets sunblind signal to zero (open)" annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=90,
        origin={40,151})));
  Modelica.Blocks.Math.Add solRadRoo[1]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{4,126},{14,136}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow hea "Ideal heater"
    annotation (Placement(transformation(extent={{56,-70},{76,-50}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degCelHea
    "Convert set temperature from degC to Kelvin"
    annotation (Placement(transformation(extent={{-4,-66},{8,-54}})));
  AixLib.Controls.Continuous.LimPID conHea(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0,
    Ti=1) "Heating controller"
    annotation (Placement(transformation(extent={{14,-68},{30,-52}})));
  Modelica.Blocks.Math.Gain gainHea(k=1e6) "Gain for heating controller"
    annotation (Placement(transformation(extent={{38,-66},{50,-54}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heaFlowSen
    "Sensor for ideal heater"
    annotation (Placement(transformation(extent={{92,-66},{80,-54}})));
  Modelica.Blocks.Sources.Constant SouTSetH(k=20) "Set temperature heater"
    annotation (Placement(transformation(extent={{-22,-66},{-10,-54}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow coo "Ideal cooler"
    annotation (Placement(transformation(extent={{56,-96},{76,-76}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degCelCoo
    "Convert set temperature for cooling from degC to Kelvin"
    annotation (Placement(transformation(extent={{-4,-92},{8,-80}})));
  AixLib.Controls.Continuous.LimPID conCoo(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=0,
    yMin=-1,
    Ti=1) "Cooling controller"
    annotation (Placement(transformation(extent={{14,-94},{30,-78}})));
  Modelica.Blocks.Math.Gain gainCoo(k=1e6) "Gain for cooling controller"
    annotation (Placement(transformation(extent={{38,-92},{50,-80}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor cooFlowSen
    "Sensor for ideal cooler"
    annotation (Placement(transformation(extent={{92,-92},{80,-80}})));
  Modelica.Blocks.Sources.Constant SouTSetC(k=27) "Set temperature cooler"
    annotation (Placement(transformation(extent={{-22,-92},{-10,-80}})));
  Modelica.Blocks.Continuous.Integrator annCooLoaInt
    "Integrated annual cooling load"
    annotation (Placement(transformation(extent={{107,-57.5},{118,-46.5}})));
  Modelica.Blocks.Continuous.Integrator annHeaLoaInt
    "Integrated annual heating load"
    annotation (Placement(transformation(extent={{107,-39.5},{118,-28.5}})));
  Modelica.Blocks.Math.Gain gainIntHea(k=1/(1000*1000*3600))
    "Converts to MWh"
    annotation (Placement(transformation(extent={{126,-40},{138,-28}})));
  Modelica.Blocks.Math.Gain gainIntCoo(k=1/(1000*1000*3600))
    "Converts to MWh"
    annotation (Placement(transformation(extent={{126,-58},{138,-46}})));
  Modelica.Blocks.Math.MultiSum heaCooPowSum(nu=2)
    "Sum of heating and cooling power"
    annotation (Placement(transformation(extent={{126,-96},{136,-86}})));
  Modelica.Blocks.Math.Gain sigCha2(k=-1) "Changes sign"
    annotation (Placement(transformation(extent={{108,-95},{118,-84}})));
  Modelica.Blocks.Math.Gain sigCha(k=-1) "Changes sign"
    annotation (Placement(transformation(extent={{106,-79},{116,-68}})));
  Modelica.Blocks.Math.Gain gainPowLoa(k=0.001) "Converts to kW"
    annotation (Placement(transformation(extent={{126,-75},{138,-63}})));

  AixLib.BoundaryConditions.SolarIrradiation.DiffusePerez        HDifTilSun[4](
    each outSkyCon=true,
    each outGroCon=true,
    each rho=0.2,
    til={1.5707963267949,1.5707963267949,1.5707963267949,1.5707963267949},
    azi={0,1.5707963267949,3.1415926535898,-1.5707963267949})
    "Calculates diffuse solar radiation on titled surface for all directions"
    annotation (Placement(transformation(extent={{-10,314},{10,334}})));
  AixLib.BoundaryConditions.SolarIrradiation.DirectTiltedSurface        HDirTilSun[4](til={
        1.5707963267949,1.5707963267949,1.5707963267949,1.5707963267949}, azi={
        0,1.5707963267949,3.1415926535898,-1.5707963267949})
    "Calculates direct solar radiation on titled surface for all directions"
    annotation (Placement(transformation(extent={{-10,346},{10,366}})));
  AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane
    corGvaDouPan1(UWin=3.046492744695893, n=4)
    "Correction factor for solar transmission"
    annotation (Placement(transformation(extent={{64,348},{84,368}})));
  AixLib.ThermalZones.ReducedOrder.RC.FiveElements sunZoneFivEle(
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    VAir=43.2,
    hConExt=2.2,
    hConWin=2.4,
    gWin=0.769,
    ratioWinConRad=0.03,
    nExt=1,
    RExt={0.0030708458762418525},
    CExt={2814538.948716655},
    hRad=0.17299996026466882,
    AInt=0.0,
    hConInt=4.130000000000001,
    nInt=1,
    RInt={0.000157524},
    CInt={1723511.394},
    RWin=0.01650833333333333,
    RExtRem=0.0850597494991632,
    AFloor=16,
    hConFloor=2.2,
    nFloor=1,
    RFloor={0.0014733104663563208},
    RFloorRem=1.5763889682947054,
    CFloor={1791100.0760575545},
    ARoof=48,
    hConRoof=1.8,
    nRoof=1,
    RRoof={0.000550791436374201},
    RRoofRem=0.06180783951600674,
    CRoof={381586.7162407001},
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    extWallRC(thermCapExt(each der_T(fixed=true))),
    intWallRC(thermCapInt(each der_T(fixed=true))),
    floorRC(thermCapExt(each der_T(fixed=true))),
    roofRC(thermCapExt(each der_T(fixed=true))),
    nOrientations=4,
    AWin={12.0,0.0,0.0,0.0},
    ATransparent={12.0,0.0,0.0,0.0},
    nIze=1,
    AIze={48.90700957621479},
    hConIze={2.2},
    nIzeRC=1,
    RIze={{0.0066827048152285455}},
    RIzeRem={0.0013357135289553492},
    CIze={{8184026.966222254}},
    othZoneInd={1},
    zoneInd=2,
    nPorts=2,
    AExt={9.600000000000001,5.4,0.0,5.4})
    "Thermal zone representation of the sun zone"
    annotation (Placement(transformation(extent={{102,292},{150,328}})));
  AixLib.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007WithWindow
    TEquAirWalSun(
    wfGro=0,
    withLongwave=true,
    aExt=0.6,
    hConWallOut=11.9,
    hRad=9.7,
    hConWinOut=8,
    n=4,
    wfWall={0.47058823529411764,0.2647058823529412,0.0,0.2647058823529412},
    wfWin={1.0,0.0,0.0,0.0},
    TGro=286.15) "Computes equivalent air temperature"
    annotation (Placement(transformation(extent={{34,280},{54,300}})));
  Modelica.Blocks.Math.Add solRadSun[4]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{20,300},{30,310}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TPreWalSun
    "Prescribed temperature for exterior walls outdoor surface temperature"
    annotation (Placement(transformation(extent={{66,288},{78,300}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TPreWinSun
    "Prescribed temperature for windows outdoor surface temperature"
    annotation (Placement(transformation(extent={{66,308},{78,320}})));
  Modelica.Thermal.HeatTransfer.Components.Convection conHeaWinSun
    "Outdoor convective heat transfer of windows"
    annotation (Placement(transformation(extent={{96,310},{86,320}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWalSun
    "Outdoor convective heat transfer of walls"
    annotation (Placement(transformation(extent={{94,300},{84,290}})));
  Modelica.Blocks.Sources.Constant constSun[4](each k=0)
    "Sets sunblind signal to zero (open)"
    annotation (Placement(transformation(extent={{38,308},{44,314}})));
  Modelica.Blocks.Sources.Constant hConWalSun(k=11.9*20.4)
    "Outdoor coefficient of heat transfer for walls" annotation (Placement(
        transformation(extent={{-4,-4},{4,4}}, rotation=90,
        origin={86,278})));
  Modelica.Blocks.Sources.Constant hConWin(k=8*12.0)    "Outdoor coefficient of heat transfer for windows"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}}, rotation=90,
        origin={90,330})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow intGaiRadSun
    "Radiative heat flow of internal gains"
    annotation (Placement(transformation(extent={{126,244},{146,264}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow intGaiConSun
    "Convective heat flow of internal gains"
    annotation (Placement(transformation(extent={{126,228},{146,248}})));
  Modelica.Blocks.Sources.Constant souIntGaiSun(k=0) "Internal gains in W"
    annotation (Placement(transformation(extent={{56,245},{69,258}})));
  Modelica.Blocks.Math.Gain gainRadSun(k=0.6) "Radiant part"
    annotation (Placement(transformation(extent={{96,249},{106,259}})));
  Modelica.Blocks.Math.Gain gainConSun(k=0.4) "Convective part"
    annotation (Placement(transformation(extent={{96,233},{106,243}})));
  Modelica.Blocks.Math.Gain gainSun(k=0.0121872)
                                              "Conversion to kg/s"
    annotation (Placement(transformation(extent={{-22,241},{-8,255}})));
  AixLib.Fluid.Sources.MassFlowSource_T venInSun(
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa)
    "Air flow fan inwards for sun zone"
    annotation (Placement(transformation(extent={{4,230},{24,250}})));
  AixLib.Fluid.Sources.MassFlowSource_T venOutSun(
    use_m_flow_in=true,
    use_T_in=false,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa)
    "Air flow fand outwards for sun zone"
    annotation (Placement(transformation(extent={{4,198},{24,218}})));
  Modelica.Blocks.Math.Gain gain1Sun(k=-1) "Reverses ventilation rate"
    annotation (Placement(transformation(extent={{-24,209},{-10,223}})));
  Modelica.Blocks.Sources.Constant InfSun(k=0.414)
                                                 "Infiltration rate in 1/h"
    annotation (Placement(transformation(extent={{-40,242},{-28,254}})));
  AixLib.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTilRooSun[
    1](til={0}, azi={0})
    "Calculates direct solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-10,402},{10,422}})));
  AixLib.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTilRooSun[1](til
      ={0}, azi={0})
    "Calculates diffuse solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-10,374},{10,394}})));
  AixLib.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007 TEquAirRooSun(
    aExt=0.6,
    wfGro=0,
    hConWallOut=14.399999999999999,
    hRad=7.400000000000001,
    n=1,
    wfWall={1.0},
    wfWin={0},
    TGro=285.15) "Computes equivalent air temperature for roof"
    annotation (Placement(transformation(extent={{88,388},{108,408}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TPreRooSun
    "Prescribed temperature for roof outdoor surface temperature" annotation (Placement(
        transformation(extent={{-6,-6},{6,6}}, rotation=-90,
        origin={130,376})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConRooSun
    "Outdoor convective heat transfer of roof" annotation (Placement(
        transformation(extent={{7.5,-7.5},{-7.5,7.5}},
                                               rotation=-90,
        origin={124.5,346.5})));
  Modelica.Blocks.Sources.Constant hConRooSun(k=14.399999999999999*16)
    "Outdoor coefficient of heat transfer for roof" annotation (Placement(
        transformation(extent={{156,342},{148,350}}, rotation=0)));
  Modelica.Blocks.Sources.Constant const1Sun[1](each k=0)
    "Sets sunblind signal to zero (open)" annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=90,
        origin={98,429})));
  Modelica.Blocks.Math.Add solRadRooSun[1]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{62,404},{72,414}})));
  Modelica.Blocks.Math.UnitConversions.To_degC TIndDegCel
    "Indoor air temperature in degC"
    annotation (Placement(transformation(extent={{180,318},{192,330}})));
  Modelica.Blocks.Interfaces.RealOutput TFreFlo(unit="degC")
    "Free floating temperature"
      annotation (Placement(transformation(extent={{182,344},{202,364}})));
equation
  connect(TEquAir.TEqAir, TPreExtWal.T) annotation (Line(points={{-3,12},{4,12},
          {4,16},{6.8,16}}, color={0,0,127}));
  connect(weaDat.weaBus, weaBus)
    annotation (Line(
    points={{-182,94},{-74,94},{-74,46},{-84,46},{-84,22},{-83,22}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%second",
    index=1,
    extent={{6,3},{6,3}}));
  connect(weaBus.TDryBul, TEquAir.TDryBul) annotation (Line(
      points={{-82.915,22.08},{-82.915,14},{-38,14},{-38,6},{-26,6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(const.y, TEquAir.sunblind) annotation (Line(points={{-13.7,33},{-12,33},
          {-12,24},{-14,24}}, color={0,0,127}));
  connect(HDifTil.HSkyDifTil, corGvaDouPan.HSkyDifTil) annotation (Line(points=
          {{-47,52},{-28,52},{-6,52},{-6,82},{4,82}}, color={0,0,127}));
  connect(HDirTil.H, corGvaDouPan.HDirTil) annotation (Line(points={{-47,78},{-10,
          78},{-10,86},{4,86}}, color={0,0,127}));
  connect(HDirTil.H,solRad. u1)
    annotation (Line(points={{-47,78},{-42,78},{-42,30},{-39,30}},
                   color={0,0,127}));
  connect(HDirTil.inc, corGvaDouPan.inc)
    annotation (Line(points={{-47,74},{4,74}}, color={0,0,127}));
  connect(HDifTil.H,solRad. u2)
    annotation (Line(points={{-47,46},{-44,46},{-44,24},{-39,24}},
                 color={0,0,127}));
  connect(HDifTil.HGroDifTil, corGvaDouPan.HGroDifTil) annotation (Line(points=
          {{-47,40},{-4,40},{-4,78},{4,78}}, color={0,0,127}));
  connect(solRad.y, TEquAir.HSol)
    annotation (Line(points={{-27.5,27},{-26,27},{-26,18}}, color={0,0,127}));
  connect(weaDat.weaBus, HDifTil[1].weaBus)
    annotation (Line(
    points={{-182,94},{-74,94},{-74,46},{-68,46}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus, HDirTil[1].weaBus)
    annotation (Line(
    points={{-182,94},{-74,94},{-74,78},{-68,78}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus, HDifTil[2].weaBus)
    annotation (Line(
    points={{-182,94},{-74,94},{-74,46},{-68,46}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus, HDirTil[2].weaBus)
    annotation (Line(
    points={{-182,94},{-74,94},{-74,78},{-68,78}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus, HDifTil[3].weaBus)
    annotation (Line(
    points={{-182,94},{-74,94},{-74,46},{-68,46}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus, HDirTil[3].weaBus)
    annotation (Line(
    points={{-182,94},{-74,94},{-74,78},{-68,78}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus, HDifTil[4].weaBus)
    annotation (Line(
    points={{-182,94},{-74,94},{-74,46},{-68,46}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus, HDirTil[4].weaBus)
    annotation (Line(
    points={{-182,94},{-74,94},{-74,78},{-68,78}},
    color={255,204,51},
    thickness=0.5));
  connect(intGaiRad.port, bacZoneFivEle.intGainsRad) annotation (Line(points={{88,
          -24},{96,-24},{96,40},{92,40}}, color={191,0,0}));
  connect(bacZoneFivEle.extWall, conHeaWal.solid) annotation (Line(points={{44,28},
          {40,28},{40,17},{36,17}}, color={191,0,0}));
  connect(conHeaWal.fluid, TPreExtWal.port) annotation (Line(points={{26,17},{24,
          17},{24,16},{20,16}}, color={191,0,0}));
  connect(hConWal.y, conHeaWal.Gc)
    annotation (Line(points={{0,4.4},{31,4.4},{31,12}}, color={0,0,127}));
  connect(weaBus.TBlaSky, TEquAir.TBlaSky) annotation (Line(
      points={{-82.915,22.08},{-58,22.08},{-58,18},{-32,18},{-32,12},{-26,12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));

  connect(intGaiCon.port, bacZoneFivEle.intGainsConv) annotation (Line(points={{
          88,-40},{94,-40},{94,36},{92,36}}, color={191,0,0}));
  connect(corGvaDouPan.solarRadWinTrans, bacZoneFivEle.solRad) annotation (Line(
        points={{27,80},{34,80},{40,80},{40,47},{43,47}}, color={0,0,127}));
  connect(gainRad.y, intGaiRad.Q_flow) annotation (Line(points={{48.5,-24},{68,
          -24}},          color={0,0,127}));
  connect(gainCon.y, intGaiCon.Q_flow)
    annotation (Line(points={{48.5,-40},{58,-40},{68,-40}},
                                                   color={0,0,127}));
  connect(souIntGai.y, gainCon.u) annotation (Line(points={{11.65,-26.5},{23.825,
          -26.5},{23.825,-40},{37,-40}}, color={0,0,127}));
  connect(souIntGai.y, gainRad.u) annotation (Line(points={{11.65,-26.5},{23.825,
          -26.5},{23.825,-24},{37,-24}}, color={0,0,127}));
  connect(gain.y, venIn.m_flow_in)
    annotation (Line(points={{-65.3,-30},{-56,-30}}, color={0,0,127}));
  connect(gain.y,gain1. u)
    annotation (Line(points={{-65.3,-30},{-64,-30},{-64,-46},{-90,-46},{-90,-62},
          {-83.4,-62}},                    color={0,0,127}));
  connect(gain1.y, venOut.m_flow_in)
    annotation (Line(points={{-67.3,-62},{-56,-62}}, color={0,0,127}));
  connect(weaBus.TDryBul, venIn.T_in) annotation (Line(
      points={{-82.915,22.08},{-82.915,-14},{-60,-14},{-60,-34},{-56,-34}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(Inf.y, gain.u) annotation (Line(points={{-85.4,-30},{-85.4,-30},{-81.4,
          -30}}, color={0,0,127}));
  connect(venIn.ports[1], bacZoneFivEle.ports[1]) annotation (Line(points={{-34,
          -38},{-30,-38},{-30,-10},{82.2375,-10},{82.2375,14.05}}, color={0,127,
          255}));
  connect(venOut.ports[1], bacZoneFivEle.ports[2]) annotation (Line(points={{-34,
          -70},{-26,-70},{-26,-14},{83.7625,-14},{83.7625,14.05}}, color={0,127,
          255}));
  connect(souWea.y[1], weaDat.TDryBul_in) annotation (Line(points={{-219,100},{
          -210,100},{-210,103},{-203,103}},
                                   color={0,0,127}));
  connect(souWea.y[2], add.u1) annotation (Line(points={{-219,100},{-214,100},{
          -214,82},{-222,82},{-222,84},{-244,84},{-244,77.6},{-239.2,77.6}},
                                                              color={0,0,127}));
  connect(souWea.y[3], add.u2) annotation (Line(points={{-219,100},{-214,100},{
          -214,82},{-222,82},{-222,84},{-244,84},{-244,70.4},{-239.2,70.4}},
                                                    color={0,0,127}));
  connect(add.y, divRad.u1) annotation (Line(points={{-225.4,74},{-226,73.6},{-221.2,
          73.6}}, color={0,0,127}));
  connect(numRad.y, divRad.u2) annotation (Line(points={{-225.4,58},{-226,58},{-226,
          60},{-221.2,60},{-221.2,66.4}}, color={0,0,127}));
  connect(divRad.y, weaDat.HInfHor_in) annotation (Line(points={{-207.4,70},{-203,
          70},{-203,86}}, color={0,0,127}));
  connect(souRad.y[1], weaDat.HDirNor_in) annotation (Line(points={{-219,30},{
          -200,30},{-200,78},{-204,78},{-204,83},{-203,83}},   color={0,0,127}));
  connect(souRad.y[2], weaDat.HGloHor_in) annotation (Line(points={{-219,30},{
          -200,30},{-200,78},{-204,78},{-204,81},{-203,81}},
                                                      color={0,0,127}));
  connect(HDirTilRoo.H, solRadRoo.u1)
    annotation (Line(points={{-47,134},{-47,134},{3,134}}, color={0,0,127}));
  connect(TPreRoo.port, theConRoo.fluid)
    annotation (Line(points={{68,80},{68,69}},     color={191,0,0}));
  connect(theConRoo.Gc, hConRoo.y)
    annotation (Line(points={{73,64},{83.6,64},{83.6,68}},
                                                      color={0,0,127}));
  connect(TAirEquRoo.TEqAir, TPreRoo.T) annotation (Line(points={{51,120},{68,
          120},{68,93.2}},         color={0,0,127}));
  connect(const1.y,TAirEquRoo.sunblind)  annotation (Line(points={{40,147.7},{40,
          147.7},{40,132}}, color={0,0,127}));
  connect(HDifTilRoo.H, solRadRoo.u2) annotation (Line(points={{-47,106},{-22,106},
          {-22,128},{3,128}}, color={0,0,127}));
  connect(weaDat.weaBus, HDifTilRoo[1].weaBus) annotation (Line(
      points={{-182,94},{-74,94},{-74,106},{-68,106}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, HDirTilRoo[1].weaBus) annotation (Line(
      points={{-182,94},{-74,94},{-74,134},{-68,134}},
      color={255,204,51},
      thickness=0.5));
  connect(solRadRoo.y, TAirEquRoo.HSol) annotation (Line(points={{14.5,131},{22,
          131},{22,126},{28,126}}, color={0,0,127}));
  connect(weaBus.TBlaSky,TAirEquRoo.TBlaSky)  annotation (Line(
      points={{-82.915,22.08},{-70,22.08},{-70,122},{16,122},{16,120},{28,120}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));

  connect(weaBus.TDryBul,TAirEquRoo.TDryBul)  annotation (Line(
      points={{-82.915,22.08},{-82,22.08},{-82,14},{-72,14},{-72,94},{16,94},{16,
          114},{28,114}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(theConRoo.solid, bacZoneFivEle.roof)
    annotation (Line(points={{68,59},{68,56},{66.9,56},{66.9,50}},
                                                          color={191,0,0}));
  connect(from_degCelHea.y, conHea.u_s) annotation (Line(points={{8.6,-60},{8.6,
          -60},{12.4,-60}}, color={0,0,127}));
  connect(conHea.y,gainHea. u)
    annotation (Line(points={{30.8,-60},{30.8,-60},{36.8,-60}},
                                                     color={0,0,127}));
  connect(gainHea.y,hea. Q_flow)
    annotation (Line(points={{50.6,-60},{50.6,-60},{56,-60}},
                                                   color={0,0,127}));
  connect(SouTSetH.y, from_degCelHea.u) annotation (Line(points={{-9.4,-60},{-9.4,
          -60},{-5.2,-60}}, color={0,0,127}));
  connect(from_degCelCoo.y, conCoo.u_s) annotation (Line(points={{8.6,-86},{8.6,
          -86},{12.4,-86}}, color={0,0,127}));
  connect(conCoo.y,gainCoo. u)
    annotation (Line(points={{30.8,-86},{30.8,-86},{36.8,-86}},
                                                     color={0,0,127}));
  connect(gainCoo.y,coo. Q_flow)
    annotation (Line(points={{50.6,-86},{50.6,-86},{56,-86}},
                                                   color={0,0,127}));
  connect(SouTSetC.y, from_degCelCoo.u) annotation (Line(points={{-9.4,-86},{-9.4,
          -86},{-5.2,-86}}, color={0,0,127}));
  connect(cooFlowSen.Q_flow, sigCha2.u) annotation (Line(points={{86,-92.6},{86,
          -94},{103,-94},{103,-89.5},{107,-89.5}}, color={0,0,127}));
  connect(heaFlowSen.Q_flow, sigCha.u) annotation (Line(points={{86,-66.6},{86,
          -66.6},{86,-74},{90,-74},{86,-74},{96,-74},{96,-73.5},{105,-73.5}},
        color={0,0,127}));
  connect(hea.port, heaFlowSen.port_b)
    annotation (Line(points={{76,-60},{78,-60},{80,-60}}, color={191,0,0}));
  connect(coo.port, cooFlowSen.port_b)
    annotation (Line(points={{76,-86},{78,-86},{80,-86}}, color={191,0,0}));
  connect(sigCha2.y, heaCooPowSum.u[1]) annotation (Line(points={{118.5,-89.5},{
          120,-89.5},{120,-91.875},{126,-91.875}}, color={0,0,127}));
  connect(sigCha.y, heaCooPowSum.u[2]) annotation (Line(points={{116.5,-73.5},{
          121.25,-73.5},{121.25,-90.125},{126,-90.125}}, color={0,0,127}));
  connect(gainIntHea.y, annHeaLoa) annotation (Line(points={{138.6,-34},{140.3,-34},
          {152,-34}}, color={0,0,127}));
  connect(gainIntHea.u, annHeaLoaInt.y) annotation (Line(points={{124.8,-34},{121.4,
          -34},{118.55,-34}}, color={0,0,127}));
  connect(gainIntCoo.y, annCooLoa) annotation (Line(points={{138.6,-52},{141.3,-52},
          {152,-52}}, color={0,0,127}));
  connect(gainIntCoo.u, annCooLoaInt.y) annotation (Line(points={{124.8,-52},{121.4,
          -52},{118.55,-52}}, color={0,0,127}));
  connect(sigCha.y, annHeaLoaInt.u) annotation (Line(points={{116.5,-73.5},{122,
          -73.5},{122,-63},{102,-63},{102,-34},{105.9,-34}}, color={0,0,127}));
  connect(sigCha2.y, annCooLoaInt.u) annotation (Line(points={{118.5,-89.5},{118.5,
          -61},{105.9,-61},{105.9,-52}}, color={0,0,127}));
  connect(heaCooPowSum.y, gainPowLoa.u) annotation (Line(points={{136.85,-91},{138,
          -91},{138,-81},{124.8,-81},{124.8,-69}}, color={0,0,127}));
  connect(gainPowLoa.y, powLoa) annotation (Line(points={{138.6,-69},{140,-69},{
          140,-81},{152,-81}}, color={0,0,127}));
  connect(heaFlowSen.port_a, bacZoneFivEle.intGainsConv) annotation (Line(
        points={{92,-60},{94,-60},{94,36},{92,36}}, color={191,0,0}));
  connect(cooFlowSen.port_a, bacZoneFivEle.intGainsConv) annotation (Line(
        points={{92,-86},{94,-86},{94,36},{92,36}}, color={191,0,0}));
  connect(conHea.u_m, bacZoneFivEle.TAir) annotation (Line(points={{22,-69.6},{22,
          -70},{102,-70},{102,48},{93,48}}, color={0,0,127}));
  connect(conCoo.u_m, bacZoneFivEle.TAir) annotation (Line(points={{22,-95.6},{22,
          -98},{102,-98},{102,48},{93,48}}, color={0,0,127}));
  connect(TEquAirWalSun.TEqAirWin, TPreWinSun.T) annotation (Line(points={{55,293.8},
          {58,293.8},{58,314},{64.8,314}}, color={0,0,127}));
  connect(TEquAirWalSun.TEqAir, TPreWalSun.T) annotation (Line(points={{55,290},
          {62,290},{62,294},{64.8,294}}, color={0,0,127}));
  connect(weaBus.TDryBul, TEquAirWalSun.TDryBul) annotation (Line(
      points={{-82.915,22.08},{-98,22.08},{-98,284},{32,284}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(constSun.y, TEquAirWalSun.sunblind) annotation (Line(points={{44.3,311},
          {46,311},{46,302},{44,302}}, color={0,0,127}));
  connect(HDifTilSun.HSkyDifTil, corGvaDouPan1.HSkyDifTil) annotation (Line(
        points={{11,330},{52,330},{52,360},{62,360}}, color={0,0,127}));
  connect(HDirTilSun.H, corGvaDouPan1.HDirTil) annotation (Line(points={{11,356},
          {48,356},{48,364},{62,364}}, color={0,0,127}));
  connect(HDirTilSun.H,solRadSun. u1) annotation (Line(points={{11,356},{16,356},
          {16,308},{19,308}}, color={0,0,127}));
  connect(HDirTilSun.inc, corGvaDouPan1.inc)
    annotation (Line(points={{11,352},{62,352}}, color={0,0,127}));
  connect(HDifTilSun.H,solRadSun. u2) annotation (Line(points={{11,324},{14,324},
          {14,302},{19,302}}, color={0,0,127}));
  connect(HDifTilSun.HGroDifTil, corGvaDouPan1.HGroDifTil) annotation (Line(
        points={{11,318},{54,318},{54,356},{62,356}}, color={0,0,127}));
  connect(solRadSun.y, TEquAirWalSun.HSol)
    annotation (Line(points={{30.5,305},{32,305},{32,296}}, color={0,0,127}));
  connect(weaDat.weaBus,HDifTilSun [1].weaBus) annotation (Line(
      points={{-182,94},{-124,94},{-124,324},{-10,324}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,HDirTilSun [1].weaBus) annotation (Line(
      points={{-182,94},{-124,94},{-124,324},{-28,324},{-28,356},{-10,356}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,HDifTilSun [2].weaBus) annotation (Line(
      points={{-182,94},{-124,94},{-124,324},{-10,324}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,HDirTilSun [2].weaBus) annotation (Line(
      points={{-182,94},{-124,94},{-124,324},{-28,324},{-28,356},{-10,356}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,HDifTilSun [3].weaBus) annotation (Line(
      points={{-182,94},{-124,94},{-124,324},{-10,324}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,HDirTilSun [3].weaBus) annotation (Line(
      points={{-182,94},{-124,94},{-124,324},{-28,324},{-28,356},{-10,356}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,HDifTilSun [4].weaBus) annotation (Line(
      points={{-182,94},{-124,94},{-124,324},{-10,324}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,HDirTilSun [4].weaBus) annotation (Line(
      points={{-182,94},{-124,94},{-124,324},{-28,324},{-28,356},{-10,356}},
      color={255,204,51},
      thickness=0.5));
  connect(intGaiRadSun.port, sunZoneFivEle.intGainsRad) annotation (Line(points
        ={{146,254},{154,254},{154,318},{150,318}}, color={191,0,0}));
  connect(conHeaWinSun.solid, sunZoneFivEle.window) annotation (Line(points={{96,
          315},{98,315},{98,314},{102,314}}, color={191,0,0}));
  connect(TPreWinSun.port, conHeaWinSun.fluid)
    annotation (Line(points={{78,314},{86,314},{86,315}}, color={191,0,0}));
  connect(sunZoneFivEle.extWall, theConWalSun.solid) annotation (Line(points={{102,
          306},{98,306},{98,295},{94,295}}, color={191,0,0}));
  connect(theConWalSun.fluid, TPreWalSun.port) annotation (Line(points={{84,295},
          {82,295},{82,294},{78,294}}, color={191,0,0}));
  connect(hConWalSun.y, theConWalSun.Gc)
    annotation (Line(points={{86,282.4},{86,284},{89,284},{89,290}},
                                                        color={0,0,127}));
  connect(hConWin.y, conHeaWinSun.Gc)
    annotation (Line(points={{90,325.6},{91,326},{91,320}}, color={0,0,127}));
  connect(weaBus.TBlaSky, TEquAirWalSun.TBlaSky) annotation (Line(
      points={{-82.915,22.08},{-98,22.08},{-98,306},{12,306},{12,290},{32,290}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));

  connect(intGaiConSun.port, sunZoneFivEle.intGainsConv) annotation (Line(
        points={{146,238},{152,238},{152,314},{150,314}}, color={191,0,0}));
  connect(corGvaDouPan1.solarRadWinTrans, sunZoneFivEle.solRad) annotation (
      Line(points={{85,358},{98,358},{98,325},{101,325}}, color={0,0,127}));
  connect(gainRadSun.y,intGaiRadSun. Q_flow)
    annotation (Line(points={{106.5,254},{126,254}},
                                                   color={0,0,127}));
  connect(gainConSun.y,intGaiConSun. Q_flow)
    annotation (Line(points={{106.5,238},{126,238}},        color={0,0,127}));
  connect(souIntGaiSun.y,gainConSun. u) annotation (Line(points={{69.65,251.5},
          {81.825,251.5},{81.825,238},{95,238}},color={0,0,127}));
  connect(souIntGaiSun.y,gainRadSun. u) annotation (Line(points={{69.65,251.5},
          {81.825,251.5},{81.825,254},{95,254}},color={0,0,127}));
  connect(gainSun.y, venInSun.m_flow_in)
    annotation (Line(points={{-7.3,248},{2,248}}, color={0,0,127}));
  connect(gainSun.y,gain1Sun. u) annotation (Line(points={{-7.3,248},{-6,248},{
          -6,232},{-32,232},{-32,216},{-25.4,216}},   color={0,0,127}));
  connect(gain1Sun.y, venOutSun.m_flow_in)
    annotation (Line(points={{-9.3,216},{2,216}}, color={0,0,127}));
  connect(weaBus.TDryBul, venInSun.T_in) annotation (Line(
      points={{-82.915,22.08},{-98,22.08},{-98,244},{2,244}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(InfSun.y,gainSun. u) annotation (Line(points={{-27.4,248},{-23.4,248}},
                        color={0,0,127}));
  connect(venInSun.ports[1], sunZoneFivEle.ports[1]) annotation (Line(points={{24,240},
          {28,240},{28,268},{140.238,268},{140.238,292.05}},      color={0,127,255}));
  connect(venOutSun.ports[1], sunZoneFivEle.ports[2]) annotation (Line(points={{24,208},
          {32,208},{32,264},{141.762,264},{141.762,292.05}},         color={0,127,
          255}));
  connect(HDirTilRooSun.H, solRadRooSun.u1)
    annotation (Line(points={{11,412},{61,412}}, color={0,0,127}));
  connect(TPreRooSun.port, theConRooSun.fluid)
    annotation (Line(points={{130,370},{130,360},{140,360},{140,356},{124.5,356},
          {124.5,354}},                                     color={191,0,0}));
  connect(theConRooSun.Gc, hConRooSun.y)
    annotation (Line(points={{132,346.5},{132,346},{147.6,346}},
                                                         color={0,0,127}));
  connect(TEquAirRooSun.TEqAir, TPreRooSun.T) annotation (Line(points={{109,398},
          {130,398},{130,383.2}}, color={0,0,127}));
  connect(const1Sun.y, TEquAirRooSun.sunblind)
    annotation (Line(points={{98,425.7},{98,410}}, color={0,0,127}));
  connect(HDifTilRooSun.H, solRadRooSun.u2) annotation (Line(points={{11,384},{36,
          384},{36,406},{61,406}}, color={0,0,127}));
  connect(weaDat.weaBus, HDifTilRooSun[1].weaBus) annotation (Line(
      points={{-182,94},{-124,94},{-124,324},{-28,324},{-28,384},{-10,384}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, HDirTilRooSun[1].weaBus) annotation (Line(
      points={{-182,94},{-124,94},{-124,324},{-28,324},{-28,412},{-10,412}},
      color={255,204,51},
      thickness=0.5));
  connect(solRadRooSun.y, TEquAirRooSun.HSol) annotation (Line(points={{72.5,
          409},{80,409},{80,404},{86,404}}, color={0,0,127}));
  connect(weaBus.TBlaSky, TEquAirRooSun.TBlaSky) annotation (Line(
      points={{-82.915,22.08},{-98,22.08},{-98,306},{-12,306},{-12,328},{-14,
          328},{-14,428},{80,428},{80,398},{86,398}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul, TEquAirRooSun.TDryBul) annotation (Line(
      points={{-82.915,22.08},{-98,22.08},{-98,344},{-60,344},{-60,372},{58,372},
          {58,392},{86,392}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(theConRooSun.solid, sunZoneFivEle.roof)
    annotation (Line(points={{124.5,339},{124.5,338},{126,338},{126,334},{124.9,
          334},{124.9,328}},                                 color={191,0,0}));
  connect(sunZoneFivEle.TAir, TIndDegCel.u) annotation (Line(points={{151,326},
          {174,326},{174,324},{178.8,324}}, color={0,0,127}));
  connect(TIndDegCel.y, TFreFlo) annotation (Line(points={{192.6,324},{200,324},
          {200,342},{172,342},{172,354},{192,354}}, color={0,0,127}));
  connect(sunZoneFivEle.ize, bacZoneFivEle.ize) annotation (Line(points={{147.5,
          327.8},{146,327.8},{146,332},{156,332},{156,56},{89.5,56},{89.5,49.8}},
        color={191,0,0}));
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
          extent={{-256,160},{-2,-7}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-1,160},{101,-7}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-235,19},{-174,11}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Weather"),
        Text(
          extent={{45,155},{106,147}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Back Zone"),
        Text(
          extent={{33,-91},{94,-99}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Heater"),
        Rectangle(
          extent={{33,270},{159,231}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{25,239},{86,231}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Internal Gains"),
        Rectangle(
          extent={{-48,270},{32,178}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-39,189},{22,181}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Infiltration"),
        Rectangle(
          extent={{-82,438},{56,271}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{57,438},{159,271}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-73,281},{-12,273}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Weather"),
        Text(
          extent={{103,433},{164,425}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Sun Zone"),
        Rectangle(
          extent={{160,438},{218,178}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{147,433},{208,425}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Outputs")}),
    Icon(coordinateSystem(extent={{-140,-100},{160,160}})),
    Documentation(revisions="<html><ul>
  <li>March 17, 2017, by Moritz Lauster:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>
  Test Case 600 of the ASHRAE 140-2007: Calculation of heating/cooling
  loads for room version light excited by internal and external gains.
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
end TestCase960;
