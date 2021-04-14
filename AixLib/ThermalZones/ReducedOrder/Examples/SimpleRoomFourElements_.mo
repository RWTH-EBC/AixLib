within AixLib.ThermalZones.ReducedOrder.Examples;
model SimpleRoomFourElements_
  "Illustrates the use of a thermal zone with four heat conduction elements"
  extends Modelica.Icons.Example;
  parameter String weatherdata=Modelica.Utilities.Files.loadResource(
        "modelica:/AixLib/Resources/weatherdata/Test.mos");

  SolarGain.CorrectionGDoublePane corGDouPan(UWin=2.1, n=2)
    "Correction factor for solar transmission"
    annotation (Placement(transformation(extent={{6,44},{26,64}})));
  RC.FourElements thermalZoneFourElements(
    VAir=52.5,
    hConExt=2.7,
    hConWin=2.7,
    gWin=1,
    ratioWinConRad=0.09,
    nExt=1,
    RExt={0.00331421908725},
    CExt={5259932.23},
    hRad=5,
    AInt=60.5,
    hConInt=2.12,
    nInt=1,
    RInt={0.000668895639141},
    CInt={12391363.86},
    RWin=0.01642857143,
    RExtRem=0.1265217391,
    AFloor=11.5,
    hConFloor=2.7,
    nFloor=1,
    RFloor={0.00331421908725},
    RFloorRem=0.1265217391,
    CFloor={5259932.23},
    ARoof=11.5,
    hConRoof=2.7,
    nRoof=1,
    RRoof={0.00331421908725},
    RRoofRem=0.1265217391,
    CRoof={5259932.23},
    nOrientations=2,
    AWin={7,7},
    ATransparent={7,7},
    AExt={3.5,8},
    redeclare package Medium = Modelica.Media.Air.SimpleAir,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    extWallRC(thermCapExt(each der_T(fixed=true))),
    intWallRC(thermCapInt(each der_T(fixed=true))),
    floorRC(thermCapExt(each der_T(fixed=true))),
    T_start=295.15,
    roofRC(thermCapExt(each der_T(fixed=true)))) "Thermal zone"
    annotation (Placement(transformation(extent={{44,-2},{92,34}})));
  EquivalentAirTemperature.VDI6007WithWindow eqAirTemp(
    wfGro=0,
    withLongwave=true,
    aExt=0.7,
    hConWallOut=20,
    hRad=5,
    hConWinOut=20,
    n=2,
    wfWall={0.3043478260869566,0.6956521739130435},
    wfWin={0.5,0.5},
    TGro=285.15) "Computes equivalent air temperature"
    annotation (Placement(transformation(extent={{-24,-14},{-4,6}})));
  Modelica.Blocks.Math.Add solRad[2]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{-38,6},{-28,16}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
    "Prescribed temperature for exterior walls outdoor surface temperature"
    annotation (Placement(transformation(extent={{8,-6},{20,6}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem1
    "Prescribed temperature for windows outdoor surface temperature"
    annotation (Placement(transformation(extent={{8,14},{20,26}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWin
    "Outdoor convective heat transfer of windows"
    annotation (Placement(transformation(extent={{38,16},{28,26}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWall
    "Outdoor convective heat transfer of walls"
    annotation (Placement(transformation(extent={{36,6},{26,-4}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perRad
    "Radiative heat flow of persons"
    annotation (Placement(transformation(extent={{48,-42},{68,-22}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perCon
    "Convective heat flow of persons"
    annotation (Placement(transformation(extent={{48,-62},{68,-42}})));
  Modelica.Blocks.Sources.CombiTimeTable intGai(
    table=[0,0,0,0; 3600,0,0,0; 7200,0,0,0; 10800,0,0,0; 14400,0,0,0; 18000,0,0,
        0; 21600,0,0,0; 25200,0,0,0; 25200,80,80,200; 28800,80,80,200; 32400,80,
        80,200; 36000,80,80,200; 39600,80,80,200; 43200,80,80,200; 46800,80,80,200;
        50400,80,80,200; 54000,80,80,200; 57600,80,80,200; 61200,80,80,200; 61200,
        0,0,0; 64800,0,0,0; 72000,0,0,0; 75600,0,0,0; 79200,0,0,0; 82800,0,0,0;
        86400,0,0,0],
    columns={2,3,4},
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic) "Table with profiles for persons (radiative and convective) and machines
    (convective)"
    annotation (Placement(transformation(extent={{6,-60},{22,-44}})));
  Modelica.Blocks.Sources.Constant const[2](each k=0)
    "Sets sunblind signal to zero (open)"
    annotation (Placement(transformation(extent={{-20,14},{-14,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow macConv
    "Convective heat flow of machines"
    annotation (Placement(transformation(extent={{48,-84},{68,-64}})));
  Modelica.Blocks.Sources.Constant hConWall(k=25*11.5)
    "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}}, rotation=90,
    origin={30,-16})));
  Modelica.Blocks.Sources.Constant hConWin(k=20*14)
    "Outdoor coefficient of heat transfer for windows"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
    rotation=90,origin={32,38})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemFloor
    "Prescribed temperature for floor plate outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
    rotation=90,origin={67,-12})));
  Modelica.Blocks.Sources.Constant TSoil(k=283.15)
    "Outdoor surface temperature for floor plate"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
    rotation=180,origin={84,-22})));
  EquivalentAirTemperature.VDI6007 eqAirTempVDI(
    aExt=0.7,
    n=1,
    wfWall={1},
    wfWin={0},
    wfGro=0,
    hConWallOut=20,
    hRad=5,
    TGro=285.15) "Computes equivalent air temperature for roof"
    annotation (Placement(transformation(extent={{30,74},{50,94}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemRoof
    "Prescribed temperature for roof outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},rotation=-90,
    origin={67,64})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConRoof
    "Outdoor convective heat transfer of roof"
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},rotation=-90,
    origin={67,47})));
  Modelica.Blocks.Sources.Constant hConRoof(k=25*11.5)
    "Outdoor coefficient of heat transfer for roof"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},origin={86,47})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    "Sets sunblind signal to zero (open)"
    annotation (Placement(transformation(extent={{68,90},{62,96}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow macConv1
    "Convective heat flow of machines"
    annotation (Placement(transformation(extent={{44,-100},{64,-80}})));
  Modelica.Blocks.Interfaces.RealInput Q_flow
    annotation (Placement(transformation(extent={{-114,-92},{-74,-52}})));
  Modelica.Blocks.Interfaces.RealOutput TAir "Indoor air temperature"
    annotation (Placement(transformation(extent={{100,22},{120,42}})));
  Modelica.Blocks.Sources.Constant const2(k={0,0})
    annotation (Placement(transformation(extent={{-66,46},{-46,66}})));
  Modelica.Blocks.Sources.Cosine cosine(
    amplitude=10,
    freqHz=0.0000234,
    offset=280)
    annotation (Placement(transformation(extent={{-96,10},{-76,30}})));
equation
  connect(eqAirTemp.TEqAirWin, preTem1.T)
    annotation (Line(points={{-3,-0.2},{0,-0.2},{0,20},{6.8,20}},
    color={0,0,127}));
  connect(eqAirTemp.TEqAir, preTem.T)
    annotation (Line(points={{-3,-4},{4,-4},{4,0},{6.8,0}},
    color={0,0,127}));
  connect(intGai.y[1], perRad.Q_flow)
    annotation (Line(points={{22.8,-52},{28,-52},{28,-32},{48,-32}},
    color={0,0,127}));
  connect(intGai.y[2], perCon.Q_flow)
    annotation (Line(points={{22.8,-52},{36,-52},{48,-52}}, color={0,0,127}));
  connect(intGai.y[3], macConv.Q_flow)
    annotation (Line(points={{22.8,-52},{28,-52},{28,-74},{48,-74}},
    color={0,0,127}));
  connect(const.y, eqAirTemp.sunblind)
    annotation (Line(points={{-13.7,17},{-12,17},{-12,8},{-14,8}},
    color={0,0,127}));
  connect(solRad.y, eqAirTemp.HSol)
    annotation (Line(points={{-27.5,11},{-26,11},{-26,2}},
    color={0,0,127}));
  connect(perRad.port, thermalZoneFourElements.intGainsRad)
    annotation (
    Line(points={{68,-32},{84,-32},{100,-32},{100,24},{92,24}},
    color={191,0,0}));
  connect(theConWin.solid, thermalZoneFourElements.window)
    annotation (Line(points={{38,21},{40,21},{40,20},{44,20}},   color=
    {191,0,0}));
  connect(preTem1.port, theConWin.fluid)
    annotation (Line(points={{20,20},{28,20},{28,21}}, color={191,0,0}));
  connect(thermalZoneFourElements.extWall, theConWall.solid)
    annotation (Line(points={{44,12},{40,12},{40,1},{36,1}},
    color={191,0,0}));
  connect(theConWall.fluid, preTem.port)
    annotation (Line(points={{26,1},{24,1},{24,0},{20,0}}, color={191,0,0}));
  connect(hConWall.y, theConWall.Gc)
    annotation (Line(points={{30,-11.6},{30,-4},{31,-4}}, color={0,0,127}));
  connect(hConWin.y, theConWin.Gc)
    annotation (Line(points={{32,33.6},{32,26},{33,26}}, color={0,0,127}));
  connect(macConv.port, thermalZoneFourElements.intGainsConv)
    annotation (
    Line(points={{68,-74},{82,-74},{96,-74},{96,20},{92,20}}, color={191,
    0,0}));
  connect(perCon.port, thermalZoneFourElements.intGainsConv)
    annotation (
    Line(points={{68,-52},{96,-52},{96,20},{92,20}}, color={191,0,0}));
  connect(preTemFloor.port, thermalZoneFourElements.floor)
    annotation (Line(points={{67,-6},{68,-6},{68,-2}}, color={191,0,0}));
  connect(TSoil.y, preTemFloor.T)
  annotation (Line(points={{79.6,-22},{67,-22},{67,-19.2}}, color={0,0,127}));
  connect(preTemRoof.port, theConRoof.fluid)
    annotation (Line(points={{67,58},{67,58},{67,52}}, color={191,0,0}));
  connect(theConRoof.solid, thermalZoneFourElements.roof)
    annotation (Line(points={{67,42},{66.9,42},{66.9,34}}, color={191,0,0}));
  connect(eqAirTempVDI.TEqAir, preTemRoof.T)
    annotation (Line(
    points={{51,84},{67,84},{67,71.2}}, color={0,0,127}));
  connect(theConRoof.Gc, hConRoof.y)
    annotation (Line(points={{72,47},{81.6,47},{81.6,47}},color={0,0,127}));
  connect(const1.y, eqAirTempVDI.sunblind[1])
    annotation (Line(points={{61.7,93},{56,93},{56,98},{40,98},{40,96}},
                                      color={0,0,127}));
  connect(corGDouPan.solarRadWinTrans, thermalZoneFourElements.solRad)
    annotation (Line(points={{27,54},{40,54},{40,31},{43,31}}, color={0,0,127}));
  connect(macConv1.port, thermalZoneFourElements.intGainsConv) annotation (Line(
        points={{64,-90},{96,-90},{96,20},{92,20}}, color={191,0,0}));
  connect(macConv1.Q_flow, Q_flow) annotation (Line(points={{44,-90},{-26,-90},
          {-26,-72},{-94,-72}}, color={0,0,127}));
  connect(thermalZoneFourElements.TAir, TAir)
    annotation (Line(points={{93,32},{110,32}}, color={0,0,127}));
  connect(cosine.y, eqAirTemp.TBlaSky) annotation (Line(points={{-75,20},{-52,20},
          {-52,-4},{-26,-4}}, color={0,0,127}));
  connect(cosine.y, eqAirTemp.TDryBul) annotation (Line(points={{-75,20},{-50,20},
          {-50,-10},{-26,-10}}, color={0,0,127}));
  connect(cosine.y, eqAirTempVDI.TBlaSky) annotation (Line(points={{-75,20},{-24.5,
          20},{-24.5,84},{28,84}}, color={0,0,127}));
  connect(cosine.y, eqAirTempVDI.TDryBul) annotation (Line(points={{-75,20},{-24,
          20},{-24,78},{28,78}}, color={0,0,127}));
  connect(const2.y, corGDouPan.HDirTil[1]) annotation (Line(points={{-45,56},{-20,
          56},{-20,59},{4,59}}, color={0,0,127}));
  connect(const2.y, corGDouPan.HSkyDifTil[1]) annotation (Line(points={{-45,56},
          {-20,56},{-20,55},{4,55}}, color={0,0,127}));
  connect(const2.y, corGDouPan.HGroDifTil[1]) annotation (Line(points={{-45,56},
          {-19.5,56},{-19.5,51},{4,51}}, color={0,0,127}));
  connect(const2.y, corGDouPan.inc[2]) annotation (Line(points={{-45,56},{-20,56},
          {-20,49},{4,49}}, color={0,0,127}));
  annotation ( Documentation(info="<html>
  <p>This example shows the application of
  <a href=\"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">
  AixLib.ThermalZones.ReducedOrder.RC.FourElements</a>
  in combination with
  <a href=\"AixLib.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007WithWindow\">
 AixLib.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007WithWindow</a>
  and
  <a href=\"AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane\">
  AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane</a>.
  Solar radiation on tilted surface is calculated using models of
  AixLib. The thermal zone is a simple room defined in Guideline
  VDI 6007 Part 1 (VDI, 2012). All models, parameters and inputs
  except sunblinds, separate handling of heat transfer through
  windows, an extra wall element for ground floor (with additional
  area), an extra wall element for roof (with additional area) and
  solar radiation are similar to the ones defined for the
  guideline&apos;s test room. For solar radiation, the example
  relies on the standard weather file in AixLib.</p>
  <p>The idea of the example is to show a typical application of
  all sub-models and to use the example in unit tests. The results
  are reasonable, but not related to any real use case or measurement
  data.</p>
  <h4>References</h4>
  <p>VDI. German Association of Engineers Guideline VDI
  6007-1 March 2012. Calculation of transient thermal response of
  rooms and buildings - modelling of rooms.</p>
  </html>", revisions="<html>
  <ul>
  <li>
  July 11, 2019, by Katharina Brinkmann:<br/>
  Renamed <code>alphaWall</code> to <code>hConWall</code>,
  <code>alphaRoof</code> to <code>hConRoof</code>,
  <code>alphaWin</code> to <code>hConWin</code>
  </li>
  <li>
  April 27, 2016, by Michael Wetter:<br/>
  Removed call to <code>Modelica.Utilities.Files.loadResource</code>
  as this did not work for the regression tests.
  </li>
  <li>February 25, 2016, by Moritz Lauster:<br/>
  Implemented.
  </li>
  </ul>
  </html>"),
  experiment(Tolerance=1e-6, StopTime=3.1536e+007, Interval=3600),
  __Dymola_Commands(file=
  "modelica://AixLib/Resources/Scripts/Dymola/ThermalZones/ReducedOrder/Examples/SimpleRoomFourElements.mos"
        "Simulate and plot"));
end SimpleRoomFourElements_;
