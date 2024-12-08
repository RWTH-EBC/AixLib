within AixLib.ThermalZones.ReducedOrder.Examples;
model MultizoneInterzonalsFixedHeater
  "A single-family building with interzonal heat transfer, heated with the same power as in a real-world case. This is the example generated as var D by the TEASER example 11"

  AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneEquipped multizone(
    buildingID=0,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    VAir=650.4175459028824,
    ABuilding=289.33669130351973,
    ASurTot=1053.4606419289657,
    numZones=3,
    nZonCon=2,
    zonConPaiArr={{1,3},{2,4}},
    use_izeCon=true,
    internalGainsMode=1,
    use_C_flow=false,
    use_moisture_balance=false,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    zoneParam={
        DataBase.ThermalZones.MultizoneInterzonalsFixedHeater.MorschenichSfhFixedHeater_attic(),
        DataBase.ThermalZones.MultizoneInterzonalsFixedHeater.MorschenichSfhFixedHeater_basement(),
        DataBase.ThermalZones.MultizoneInterzonalsFixedHeater.MorschenichSfhFixedHeater_storey_1()},
    heatAHU=false,
    coolAHU=false,
    dehuAHU=false,
    huAHU=false,
    BPFDehuAHU=0.2,
    HRS=false,
    sampleRateAHU=1800,
    effFanAHU_sup=0.7,
    effFanAHU_eta=0.7,
    effHRSAHU_enabled=0.8,
    effHRSAHU_disabled=0.2,
    dpAHU_sup=800,
    dpAHU_eta=800,
    zone(ROM(
        extWallRC(thermCapExt(each der_T(fixed=true))),
        intWallRC(thermCapInt(each der_T(fixed=true))),
        floorRC(thermCapExt(each der_T(fixed=true))),
        roofRC(thermCapExt(each der_T(fixed=true))),
        izeRC(extWalRC(thermCapExt(each der_T(fixed=true)))))),
    redeclare model corG =
        AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
    redeclare model AHUMod = AixLib.Airflow.AirHandlingUnit.NoAHU) "Multizone"
    annotation (Placement(transformation(extent={{32,-8},{52,12}})));

  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/DataBase/ThermalZones/MultizoneInterzonalsFixedHeater/DEU_NW_Morschenich_for_MultizoneInterzonalsFixedHeaterExample.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-82,30},{-62,50}})));

  Modelica.Blocks.Sources.CombiTimeTable tableInternalGains(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="Internals",
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/DataBase/ThermalZones/MultizoneInterzonalsFixedHeater/InternalGains_MorschenichSfhFixedHeater.txt"),
    columns=2:10)
    "Profiles for internal gains"
    annotation (Placement(transformation(extent={{72,-42},{56,-26}})));

  Modelica.Blocks.Sources.CombiTimeTable tableAHU(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="AHU",
    columns=2:5,
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/DataBase/ThermalZones/MultizoneInterzonalsFixedHeater/AHU_MorschenichSfhFixedHeater.txt"))
    "Boundary conditions for air handling unit"
    annotation (Placement(transformation(extent={{-64,-6},{-48,10}})));

  Modelica.Blocks.Sources.CombiTimeTable tableTSet(
    tableOnFile=true,
    tableName="Tset",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/DataBase/ThermalZones/MultizoneInterzonalsFixedHeater/TsetHeat_MorschenichSfhFixedHeater.txt"),
    columns=2:4)
    "Set points for heater"
    annotation (Placement(transformation(extent={{72,-66},{56,-50}})));

  Modelica.Blocks.Sources.CombiTimeTable tableTSetCool(
    tableOnFile=true,
    tableName="Tset",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/DataBase/ThermalZones/MultizoneInterzonalsFixedHeater/TsetCool_MorschenichSfhFixedHeater.txt"),
    columns=2:4)
    "Set points for cooler"
    annotation (Placement(transformation(extent={{72,-90},{56,-74}})));
   Modelica.Blocks.Sources.CombiTimeTable tableIntGainsRad(
    tableOnFile=true,
    tableName="IntGainsConvRad",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/DataBase/ThermalZones/MultizoneInterzonalsFixedHeater/MorschenichSfhFixedHeater_AddIntGains.txt"),
    columns=2:4)
    "Additional internal gains (radiative)"
    annotation (Placement(transformation(extent={{-64,-34},{-48,-18}})));

   Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowRad[3]
    annotation (Placement(transformation(extent={{-22,-36},{-2,-16}})));

   Modelica.Blocks.Sources.CombiTimeTable tableIntGainsConv(
    tableOnFile=true,
    tableName="IntGainsConvRad",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/DataBase/ThermalZones/MultizoneInterzonalsFixedHeater/MorschenichSfhFixedHeater_AddIntGains.txt"),
    columns=5:7)
    "Additional internal gains (convective)"
    annotation (Placement(transformation(extent={{-64,-72},{-48,-56}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowConv[3]
    annotation (Placement(transformation(extent={{-24,-74},{-4,-54}})));

equation
  connect(weaDat.weaBus, multizone.weaBus) annotation (Line(
      points={{-62,40},{-32,40},{-32,6},{34,6}},
      color={255,204,51},
      thickness=0.5));

  connect(tableInternalGains.y, multizone.intGains)
    annotation (Line(points={{55.2,-34},{48,-34},{48,-9}}, color={0,0,127}));

  connect(tableAHU.y, multizone.AHU)
    annotation (Line(points={{-47.2,2},{14,2},{33,2}}, color={0,0,127}));

  connect(tableTSet.y, multizone.TSetHeat) annotation (Line(points={{55.2,-58},
          {36.8,-58},{36.8,-9}}, color={0,0,127}));

  connect(tableTSetCool.y, multizone.TSetCool) annotation (Line(points={{55.2,-82},
          {34.6,-82},{34.6,-9}}, color={0,0,127}));

  connect(tableIntGainsRad.y, heatFlowRad.Q_flow)
    annotation (Line(points={{-47.2,-26},{-22,-26}}, color={0,0,127}));

  connect(heatFlowRad.port, multizone.intGainsRad) annotation (Line(points={{-2,
          -26},{16,-26},{16,-3},{34,-3}}, color={191,0,0}));

  connect(heatFlowConv.port, multizone.intGainsConv) annotation (Line(points={{-4,
          -64},{20,-64},{20,-6.2},{34,-6.2}}, color={191,0,0}));

  connect(tableIntGainsConv.y, heatFlowConv.Q_flow)
    annotation (Line(points={{-47.2,-64},{-24,-64}}, color={0,0,127}));

  annotation (experiment(
      StartTime=1497600,
      StopTime=5155200,
      Interval=3600),
      __Dymola_Commands(file="Resources/Scripts/Dymola/ThermalZones/ReducedOrder/Examples/MultizoneInterzonalsFixedHeater.mos"
        "Simulate and plot"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
    Documentation(revisions="<html><ul>
  <li>December 8, 2024, by Philip Groesdonk:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>
  This example illustrates the use of <a href=
  \"AixLib.ThermalZones.ReducedOrder.RC.FiveElements\">AixLib.ThermalZones.ReducedOrder.RC.FiveElements</a>.
  Parameter set is for a single family building with three zones, one heated
  and two unheated. They are connected with interzonal elements. The building
  and the boundary conditions represent the building of variation D as 
  produced by example 11 in TEASER and as presented by Philip Groesdonk et al.
  at the International Modelica Conference 2023 (<a href=\"https://doi.org/10.3384/ecp204577\">DOI:10.3384/ecp204577</a>).
</p>
</html>"));
end MultizoneInterzonalsFixedHeater;
