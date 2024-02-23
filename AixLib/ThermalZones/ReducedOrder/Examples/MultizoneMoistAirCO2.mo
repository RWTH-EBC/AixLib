within AixLib.ThermalZones.ReducedOrder.Examples;
model MultizoneMoistAirCO2
  "Illustrates the use of MultizoneMoistAirCO2"
  import AixLib;
  extends Modelica.Icons.Example;
  replaceable package Medium = AixLib.Media.Air (extraPropertiesNames={"C_flow"});

  AixLib.ThermalZones.ReducedOrder.Multizone.Multizone multizone(
    buildingID=1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    VAir=33500,
    ABuilding=8375,
    ASurTot=12744.27,
    numZones=5,
    zoneParam={AixLib.DataBase.ThermalZones.OfficePassiveHouse.OPH_1_Office(),
        AixLib.DataBase.ThermalZones.OfficePassiveHouse.OPH_1_Office(),
        AixLib.DataBase.ThermalZones.OfficePassiveHouse.OPH_1_Office(),
        AixLib.DataBase.ThermalZones.OfficePassiveHouse.OPH_1_Office(),
        AixLib.DataBase.ThermalZones.OfficePassiveHouse.OPH_1_Office()},
    use_C_flow=true,
    use_moisture_balance=true,
    internalGainsMode=3,
    zone(ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(
            thermCapInt(each der_T(fixed=true))))),
    redeclare package Medium = Medium,
    T_start=293.15) "Multizone"
    annotation (Placement(transformation(extent={{32,-8},{52,12}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-72,76})));
  Modelica.Blocks.Sources.CombiTimeTable tableInternalGains(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="Internals",
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/Internals_Input_6Zone_SIA.txt"),
    columns=2:16)
    "Profiles for internal gains"
    annotation (Placement(transformation(extent={{72,-42},{56,-26}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow[5]
    "Radiative heat flow of additional internal gains"
    annotation (Placement(transformation(extent={{-14,-64},{6,-44}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=500,
    f=1/86400,
    offset=500) "Sinusoidal excitation for additional internal gains"
    annotation (Placement(transformation(extent={{-90,-74},{-70,-54}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1[5]
    "Convective heat flow of additional internal gains"
    annotation (Placement(transformation(extent={{-14,-86},{6,-66}})));
  Modelica.Blocks.Math.Gain gain(k=0.5)
    "Split additional internal gains into radiative an convective"
    annotation (Placement(transformation(extent={{-56,-60},{-44,-48}})));
  Modelica.Blocks.Math.Gain gain1(k=0.5)
    "Split additional internal gains into radiative an convective"
    annotation (Placement(transformation(extent={{-56,-82},{-44,-70}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=5)
    "Replicates sinusoidal excitation for numZones" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-30,-54})));
  Modelica.Blocks.Routing.Replicator replicator1(nout=5)
    "Replicates sinusoidal excitation for numZones" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-30,-76})));
  Modelica.Blocks.Sources.Constant ventRate[5](each k=0.2) "ventilation rate"
    annotation (Placement(transformation(extent={{-36,-28},{-20,-12}})));

  AixLib.Utilities.Psychrometrics.X_pTphi
                                   x_pTphi
    "Converter for relative humidity to absolute humidity"
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{-112,-24},{-78,8}}),
    iconTransformation(extent={{-70,-12},{-50,8}})));
  Modelica.Blocks.Routing.Replicator replicator2(nout=5)
    "Replicates sinusoidal excitation for numZones" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-60,8})));
  Modelica.Blocks.Routing.Replicator replicator3(nout=5)
    "Replicates sinusoidal excitation for numZones" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-46,-10})));
  Modelica.Blocks.Sources.Constant TSet[5](each k=0)
    "Dummy for heater cooler (not existing in record)"
    annotation (Placement(transformation(extent={{68,-64},{58,-54}})));
equation
  connect(weaDat.weaBus, multizone.weaBus) annotation (Line(
      points={{-72,66},{-32,66},{-32,6},{34,6}},
      color={255,204,51},
      thickness=0.5));
  connect(tableInternalGains.y, multizone.intGains)
    annotation (Line(points={{55.2,-34},{48,-34},{48,-9}}, color={0,0,127}));
  connect(gain.y, replicator.u)
    annotation (Line(points={{-43.4,-54},{-37.2,-54}}, color={0,0,127}));
  connect(sine.y, gain.u) annotation (Line(points={{-69,-64},{-62,-64},{-62,-54},
          {-57.2,-54}}, color={0,0,127}));
  connect(sine.y, gain1.u) annotation (Line(points={{-69,-64},{-62,-64},{-62,-76},
          {-57.2,-76}}, color={0,0,127}));
  connect(gain1.y, replicator1.u)
    annotation (Line(points={{-43.4,-76},{-37.2,-76}}, color={0,0,127}));
  connect(replicator1.y, prescribedHeatFlow1.Q_flow)
    annotation (Line(points={{-23.4,-76},{-14,-76}}, color={0,0,127}));
  connect(replicator.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-23.4,
          -54},{-18.7,-54},{-14,-54}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, multizone.intGainsRad) annotation (Line(
        points={{6,-54},{18,-54},{18,-22},{18,-2},{18,-3},{34,-3}},
                                color={191,0,0}));
  connect(prescribedHeatFlow1.port, multizone.intGainsConv) annotation (Line(
        points={{6,-76},{18,-76},{26,-76},{26,-6.2},{34,-6.2}},
                                                            color={191,0,0}));
  connect(ventRate.y, multizone.ventRate) annotation (Line(points={{-19.2,-20},
          {-2,-20},{-2,-0.6},{33,-0.6}}, color={0,0,127}));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-72,66},{-95,66},{-95,-8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weaBus.pAtm,x_pTphi. p_in) annotation (Line(
      points={{-95,-8},{-96,-8},{-96,-14},{-82,-14}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul,x_pTphi. T) annotation (Line(
      points={{-95,-8},{-96,-8},{-96,-20},{-82,-20}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.relHum,x_pTphi. phi) annotation (Line(
      points={{-95,-8},{-96,-8},{-96,-26},{-82,-26}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, replicator2.u) annotation (Line(
      points={{-95,-8},{-82,-8},{-82,8},{-67.2,8}},
      color={255,204,51},
      thickness=0.5));
  connect(multizone.ventTemp, replicator2.y) annotation (Line(points={{33,2},{
          -48,2},{-48,8},{-53.4,8}}, color={0,0,127}));
  connect(x_pTphi.X[1], replicator3.u) annotation (Line(points={{-59,-20},{-56,
          -20},{-56,-10},{-53.2,-10}}, color={0,0,127}));
  connect(multizone.ventHum, replicator3.y) annotation (Line(points={{33,4.4},{
          -28,4.4},{-28,-10},{-39.4,-10}}, color={0,0,127}));
  connect(TSet.y, multizone.TSetHeat) annotation (Line(points={{57.5,-59},{36.8,
          -59},{36.8,-9}}, color={0,0,127}));
  connect(TSet.y, multizone.TSetCool) annotation (Line(points={{57.5,-59},{34.6,
          -59},{34.6,-9}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(Tolerance=1e-6, StopTime=3.1536e+007, Interval=3600),
    Documentation(revisions="<html><ul>
  <li>April, 2019, by Martin Kremer:<br/>
    First Implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  This example illustrates the use of <a href=
  \"AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneMoistAirEquipped\">
  AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneMoistAirEquipped</a>.
  Parameter set is for an office building build as passive house. All
  boundary conditions are generic to show how to apply different kinds
  of boundary conditions. The results should show typical profiles for
  indoor air temperatures, but are not related to a specific building
  or measurement data.
</p>
</html>"),
__Dymola_Commands(file=
  "modelica://AixLib/Resources/Scripts/Dymola/ThermalZones/ReducedOrder/Examples/MultizoneMoistAirCO2.mos"
        "Simulate and plot"));
end MultizoneMoistAirCO2;
