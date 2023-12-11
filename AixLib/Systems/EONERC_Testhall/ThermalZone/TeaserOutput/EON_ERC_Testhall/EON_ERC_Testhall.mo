within AixLib.Systems.EONERC_Testhall.ThermalZone.TeaserOutput.EON_ERC_Testhall;
model EON_ERC_Testhall
  "This is the simulation model of EON_ERC_Testhall with traceable ID 0"

ThermalZones.ReducedOrder.ThermalZone.ThermalZone            multizone(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    internalGainsMode = 1,
        use_C_flow = false,
        use_moisture_balance = false,
        redeclare package Medium = Modelica.Media.Air.SimpleAir,
    redeclare
      AixLib.Systems.EONERC_Testhall.ThermalZone.TeaserOutput.EON_ERC_Testhall.EON_ERC_Testhall_DataBase.EON_ERC_Testhall_Hall1
      zoneParam,
   redeclare model corG =
        AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
    use_NaturalAirExchange=true) "Multizone"
    annotation (Placement(transformation(extent={{-12,-16},{8,4}})));

  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/ThermalZone/TeaserOutput/DEU_BW_Mannheim_107290_TRY2010_12_Jahr_BBSR.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-82,30},{-62,50}})));

  Modelica.Blocks.Sources.CombiTimeTable tableInternalGains(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="Internals",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/ThermalZone/TeaserOutput/EON_ERC_Testhall/InternalGains_EON_ERC_Testhall.txt"),
    columns=2:4)
    "Profiles for internal gains"
    annotation (Placement(transformation(extent={{72,-42},{56,-26}})));

  Modelica.Blocks.Sources.CombiTimeTable tableTSet(
    tableOnFile=true,
    tableName="Tset",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/ThermalZone/TeaserOutput/EON_ERC_Testhall/TsetHeat_EON_ERC_Testhall.txt"),
    columns=2:2)
    "Set points for heater"
    annotation (Placement(transformation(extent={{-72,-8},{-56,8}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow thermalzone_intGains_rad(alpha=0)
    annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={38,26})));
  Modelica.Blocks.Sources.Constant intGains_rad(k=0)
    annotation (Placement(transformation(extent={{80,18},{64,34}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow thermalzone_intGains_conv(alpha=0)
    annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={38,-4})));
  Modelica.Blocks.Sources.Constant intGains_conv(k=0)
    annotation (Placement(transformation(extent={{80,-12},{64,4}})));
equation
  connect(weaDat.weaBus, multizone.weaBus) annotation (Line(
      points={{-62,40},{-18,40},{-18,0},{-12,0}},
      color={255,204,51},
      thickness=0.5));

  connect(tableInternalGains.y, multizone.intGains)
    annotation (Line(points={{55.2,-34},{6,-34},{6,-14.4}},color={0,0,127}));

  connect(intGains_rad.y, thermalzone_intGains_rad.Q_flow)
    annotation (Line(points={{63.2,26},{44,26}}, color={0,0,127}));
  connect(intGains_conv.y, thermalzone_intGains_conv.Q_flow)
    annotation (Line(points={{63.2,-4},{44,-4}}, color={0,0,127}));
  connect(thermalzone_intGains_rad.port, multizone.intGainsRad) annotation (
      Line(points={{32,26},{14,26},{14,-2.6},{8.2,-2.6}}, color={191,0,0}));
  connect(multizone.intGainsConv, thermalzone_intGains_conv.port)
    annotation (Line(points={{8.2,-5.6},{8.2,-4},{32,-4}}, color={191,0,0}));
  connect(tableTSet.y[1], multizone.TSetHeat) annotation (Line(points={{-55.2,0},
          {-22,0},{-22,-4.8},{-11.6,-4.8}}, color={0,0,127}));
  annotation (experiment(
      StopTime=10000,
      Interval=3600,
      __Dymola_Algorithm="Cvode"),
      __Dymola_experimentSetupOutput(equidistant=true,
      events=false),
      __Dymola_Commands(file=
        "Resources/Scripts/Dymola/EON_ERC_Testhall/EON_ERC_Testhall.mos"
      "Simulate and Plot"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Line(points={{80,-82}}, color={28,108,200}),
        Rectangle(
          extent={{-80,20},{80,-80}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-80,20},{0,100},{80,20}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-52,-10},{62,-48}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="TB")}));
end EON_ERC_Testhall;
