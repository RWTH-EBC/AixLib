within AixLib.ThermalZones.ReducedOrder.Examples;
model MultizoneEquippedMine "Illustrates the use of MultizoneEquipped"
  import AixLib;
  extends Modelica.Icons.Example;

  AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneEquippedTest
                                                               multizone(
    buildingID=1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    VAir=33500,
    ABuilding=8375,
    ASurTot=12744.27,
    numZones=numZones,
    zoneParam={
        Output_Schwimmbad_Modell.Hallenbad.Hallenbad_DataBase.Hallenbad_Schwimmhalle()},
    use_moisture_balance=true,
    internalGainsMode=1,
    use_swimmingPools_MZ=true,
    heatAHU=true,
    coolAHU=true,
    dehuAHU=true,
    huAHU=true,
    BPFDehuAHU=0.2,
    HRS=false,
    sampleRateAHU=1800,
    effFanAHU_sup=0.7,
    effFanAHU_eta=0.7,
    effHRSAHU_enabled=0.8,
    effHRSAHU_disabled=0.2,
    redeclare package Medium = AixLib.Media.Air,
    zone(ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(
            thermCapInt(each der_T(fixed=true))))),
    T_start=293.15,
    dpAHU_sup=80000000,
    dpAHU_eta=80000000)
    "Multizone"
    annotation (Placement(transformation(extent={{32,-8},{52,12}})));

  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-82,30},{-62,50}})));
  Modelica.Blocks.Sources.CombiTimeTable tableInternalGains(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="Internals",
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/Internals_Input_6Zone_SIA.txt"),
    columns=2:(1 + 3*numZones))
    "Profiles for internal gains"
    annotation (Placement(transformation(extent={{72,-42},{56,-26}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow[numZones]
    "Radiative heat flow of additional internal gains"
    annotation (Placement(transformation(extent={{-14,-64},{6,-44}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=500,
    freqHz=1/86400,
    offset=500)
    "Sinusoidal excitation for additional internal gains"
    annotation (Placement(transformation(extent={{-90,-74},{-70,-54}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1[numZones]
    "Convective heat flow of additional internal gains"
    annotation (Placement(transformation(extent={{-14,-86},{6,-66}})));
  Modelica.Blocks.Math.Gain gain(k=0.5)
    "Split additional internal gains into radiative an convective"
    annotation (Placement(transformation(extent={{-56,-60},{-44,-48}})));
  Modelica.Blocks.Math.Gain gain1(k=0.5)
    "Split additional internal gains into radiative an convective"
    annotation (Placement(transformation(extent={{-56,-82},{-44,-70}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=numZones)
    "Replicates sinusoidal excitation for numZones" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-30,-54})));
  Modelica.Blocks.Routing.Replicator replicator1(nout=numZones)
    "Replicates sinusoidal excitation for numZones" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-30,-76})));
  Modelica.Blocks.Sources.CombiTimeTable tableTSet(
    tableOnFile=true,
    tableName="Tset",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/Tset_6Zone.txt"),
    columns=2:(1 + numZones))
    "Set points for heater"
    annotation (Placement(transformation(extent={{72,-66},{56,-50}})));
  Modelica.Blocks.Sources.Constant const[numZones](each k=0)
    "Set point for cooler"
    annotation (Placement(transformation(extent={{72,-90},{56,-74}})));

  Modelica.Blocks.Sources.CombiTimeTable tableOpeningHours(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="OpeningHours",
    columns=2:16,
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Output_Schwimmbad_Modell/Hallenbad/OpeningHours_Hallenbad.txt"))  "Boundary condition: Opening Hours of swiming pools"
    annotation (Placement(transformation(extent={{-76,-26},{-60,-10}})));
  parameter Integer numZones=1 "Number of zones";
  Modelica.Blocks.Sources.Constant const1[numZones](each k=0.2)
    "Infiltration rate"
    annotation (Placement(transformation(extent={{-36,-38},{-26,-28}})));
  Modelica.Blocks.Routing.Replicator replicatorTemperatureVentilation(nout=
        numZones)
    "Replicates dry bulb air temperature for numZones"
    annotation (Placement(transformation(
    extent={{-5,-5},{5,5}},
    rotation=0,
    origin={-15,-5})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{-66,-2},{-32,30}}),
    iconTransformation(extent={{-70,-12},{-50,8}})));
  Modelica.Blocks.Sources.Constant const2[numZones](each k=0.2)
    "Infiltration rate"
    annotation (Placement(transformation(extent={{-4,18},{6,28}})));
  Modelica.Blocks.Sources.CombiTimeTable tableAHU(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="AHU",
    columns=2:5,
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/AHU_Input_6Zone_SIA_4Columns.txt"))
    "Boundary conditions for air handling unit"
    annotation (Placement(transformation(extent={{-22,64},{-6,80}})));
equation
  connect(weaDat.weaBus, multizone.weaBus) annotation (Line(
      points={{-62,40},{-32,40},{-32,6},{34,6}},
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
  connect(tableTSet.y, multizone.TSetHeat) annotation (Line(points={{55.2,-58},
          {36.8,-58},{36.8,-9}}, color={0,0,127}));
  connect(const.y, multizone.TSetCool) annotation (Line(points={{55.2,-82},{
          34.6,-82},{34.6,-9}}, color={0,0,127}));
  connect(tableOpeningHours.y[2], multizone.openingHours) annotation (Line(
        points={{-59.2,-18},{6,-18},{6,-9},{45.6,-9}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, multizone.intGainsConv) annotation (Line(
        points={{6,-54},{6,-29},{34,-29},{34,-6.2}}, color={191,0,0}));
  connect(prescribedHeatFlow1.port, multizone.intGainsRad) annotation (Line(
        points={{6,-76},{20,-76},{20,-3},{34,-3}}, color={191,0,0}));
  connect(weaBus.TDryBul,replicatorTemperatureVentilation. u) annotation (Line(
      points={{-49,14},{-44,14},{-44,-12},{-21,-12},{-21,-5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-62,40},{-56,40},{-56,14},{-49,14}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(multizone.ventHum, const2.y) annotation (Line(points={{33,4.4},{20.5,
          4.4},{20.5,23},{6.5,23}}, color={0,0,127}));
  connect(multizone.ventTemp, replicatorTemperatureVentilation.y) annotation (
      Line(points={{33,2},{12,2},{12,-5},{-9.5,-5}}, color={0,0,127}));
  connect(const1.y, multizone.ventRate) annotation (Line(points={{-25.5,-33},{
          3.25,-33},{3.25,-0.6},{33,-0.6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31536000,
      Interval=3600,
      __Dymola_Algorithm="Cvode"),
    Documentation(revisions="<html><ul>
  <li>September 29, 2016, by Moritz Lauster:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>
  This example illustrates the use of <a href=
  \"AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneEquipped\">AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneEquipped</a>.
  Parameter set is for an office building build as passive house. All
  boundary conditions are generic to show how to apply different kinds
  of boundary conditions. The results should show typical profiles for
  indoor air temperatures, but are not related to a specific building
  or measurement data.
</p>
</html>"));
end MultizoneEquippedMine;
