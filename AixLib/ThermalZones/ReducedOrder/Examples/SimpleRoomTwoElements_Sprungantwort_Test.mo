within AixLib.ThermalZones.ReducedOrder.Examples;
model SimpleRoomTwoElements_Sprungantwort_Test
  "Illustrates the use of a thermal zone with two heat conduction elements"
  extends Modelica.Icons.Example;

  RC.TwoElements thermalZoneTwoElements(
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
    nOrientations=2,
    AWin={7,7},
    ATransparent={7,7},
    AExt={3.5,8},
    redeclare package Medium = Modelica.Media.Air.SimpleAir,
    extWallRC(thermCapExt(each der_T(fixed=true))),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=295.15,
    intWallRC(thermCapInt(each der_T(fixed=true)))) "Thermal zone"
    annotation (Placement(transformation(extent={{44,-2},{92,34}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWin
    "Outdoor convective heat transfer of windows"
    annotation (Placement(transformation(extent={{38,16},{28,26}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWall
    "Outdoor convective heat transfer of walls"
    annotation (Placement(transformation(extent={{36,6},{26,-4}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perRad
    "Radiative heat flow of persons"
    annotation (Placement(transformation(extent={{70,-42},{90,-22}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perCon
    "Convective heat flow of persons"
    annotation (Placement(transformation(extent={{70,-62},{90,-42}})));
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
    annotation (Placement(transformation(extent={{44,-60},{60,-44}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow macConv
    "Convective heat flow of machines"
    annotation (Placement(transformation(extent={{70,-84},{90,-64}})));
  Modelica.Blocks.Sources.Constant hConWall(k=25*11.5)
    "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(
    transformation(
    extent={{-4,-4},{4,4}},
    rotation=90,
    origin={30,-16})));
  Modelica.Blocks.Sources.Constant hConWin(k=20*14)
    "Outdoor coefficient of heat transfer for windows"
    annotation (Placement(
    transformation(
    extent={{4,-4},{-4,4}},
    rotation=90,
    origin={32,38})));

  Modelica.Blocks.Sources.Constant const(k=0)
    "Solar radiation"
    annotation (Placement(transformation(extent={{16,44},{26,54}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature preTem2(T=273.15)
    "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-4,8},{8,20}})));
  Utilities.Sources.HeaterCoolerVDI6007AC1.HeaterCoolerWithTabs6007C1
    heaterCoolerWithTabs6007C1_1
    annotation (Placement(transformation(extent={{-44,-60},{-12,-40}})));
equation
  connect(intGai.y[1], perRad.Q_flow)
    annotation (Line(points={{60.8,-52},{66,-52},{66,-32},{70,-32}},
                                      color={0,0,127}));
  connect(intGai.y[2], perCon.Q_flow)
    annotation (Line(points={{60.8,-52},{70,-52}},          color={0,0,127}));
  connect(intGai.y[3], macConv.Q_flow)
    annotation (Line(points={{60.8,-52},{66,-52},{66,-74},{70,-74}},
                                      color={0,0,127}));
  connect(perRad.port, thermalZoneTwoElements.intGainsRad)
    annotation (Line(
    points={{90,-32},{100,-32},{100,24},{92,24}},
    color={191,0,0}));
  connect(theConWin.solid, thermalZoneTwoElements.window)
    annotation (
     Line(points={{38,21},{40,21},{40,20},{44,20}},   color={191,0,0}));
  connect(thermalZoneTwoElements.extWall, theConWall.solid)
    annotation (Line(points={{44,12},{40,12},{40,1},{36,1}},
    color={191,0,0}));
  connect(hConWall.y, theConWall.Gc)
    annotation (Line(points={{30,-11.6},{30,-4},{31,-4}}, color={0,0,127}));
  connect(hConWin.y, theConWin.Gc)
    annotation (Line(points={{32,33.6},{32,26},{33,26}}, color={0,0,127}));
  connect(macConv.port, thermalZoneTwoElements.intGainsConv)
    annotation (
    Line(points={{90,-74},{96,-74},{96,20},{92,20}},          color={191,
    0,0}));
  connect(perCon.port, thermalZoneTwoElements.intGainsConv)
    annotation (
    Line(points={{90,-52},{96,-52},{96,20},{92,20}}, color={191,0,0}));
  connect(const.y, thermalZoneTwoElements.solRad[1])
    annotation (Line(points={{26.5,49},{43,49},{43,30.5}},  color={0,0,127}));
  connect(preTem2.port, theConWin.fluid) annotation (Line(points={{8,14},{18,14},
          {18,21},{28,21}}, color={191,0,0}));
  connect(preTem2.port, theConWall.fluid)
    annotation (Line(points={{8,14},{18,14},{18,1},{26,1}}, color={191,0,0}));
  annotation ( Documentation(info="<html>
  <p>This example shows the application of
  <a href=\"AixLib.ThermalZones.ReducedOrder.RC.TwoElements\">
  AixLib.ThermalZones.ReducedOrder.RC.TwoElements</a>
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
  windows and solar radiation are similar to the ones defined for
  the guideline&apos;s test room. For solar radiation, the example
  relies on the standard weather file in AixLib.</p>
  <p>The idea of the example is to show a typical application of
  all sub-models and to use the example in unit tests. The results
  are reasonable, but not related to any real use case or
  measurement data.</p>
  <h4>References</h4>
  <p>VDI. German Association of Engineers Guideline VDI
  6007-1 March 2012. Calculation of transient thermal response of
  rooms and buildings - modelling of rooms.</p>
  </html>", revisions="<html>
  <ul>
  <li>
  July 11, 2019, by Katharina Brinkmann:<br/>
  Renamed <code>alphaWall</code> to <code>hConWall</code>,
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
  "modelica://AixLib/Resources/Scripts/Dymola/ThermalZones/ReducedOrder/Examples/SimpleRoomTwoElements.mos"
        "Simulate and plot"));
end SimpleRoomTwoElements_Sprungantwort_Test;
