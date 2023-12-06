within AixLib.Systems.EONERC_Testhall.ThermalZone;
model EON_ERC_Testhall
ThermalZones.ReducedOrder.ThermalZone.ThermalZone thermalzone(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    internalGainsMode=1,
    use_C_flow=false,
    use_moisture_balance=false,
    redeclare package Medium = AixLib.Media.Air,
    redeclare
      AixLib.Systems.EONERC_Testhall.ThermalZone.TeaserOutput.EON_ERC_Testhall.EON_ERC_Testhall_DataBase.EON_ERC_Testhall_Hall1
      zoneParam(T_start=288.15),
    redeclare model corG =
        ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
    use_MechanicalAirExchange=false,
    use_NaturalAirExchange=false,
    nPorts=2)                    "ThermalZone"
    annotation (Placement(transformation(extent={{-6,26},{14,46}})));
  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Systems/EONERC_Testhall/ThermalZone/TeaserOutput/DEU_BW_Mannheim_107290_TRY2010_12_Jahr_BBSR.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-94,64},{-74,84}})));

  Modelica.Blocks.Sources.CombiTimeTable tableInternalGains(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="Internals",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/ThermalZone/TeaserOutput/EON_ERC_Testhall/InternalGains_EON_ERC_Testhall.txt"),
    columns=2:4)
    "Profiles for internal gains"
    annotation (Placement(transformation(extent={{60,-8},{44,8}})));

  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports[2](redeclare
      each final package Medium = AixLib.Media.Air)
    "Auxilliary fluid inlets and outlets to indoor air volume" annotation (
      Placement(transformation(extent={{-49,-104},{49,-80}}),
        iconTransformation(extent={{-45,-104},{49,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsRad_port
   "Radiative internal gains" annotation (Placement(
        transformation(extent={{72,60},{92,40}}), iconTransformation(extent={{-108,
            14},{-88,34}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsConv_port
   "convective internal gains" annotation (Placement(
        transformation(extent={{72,40},{92,20}}), iconTransformation(extent={{-108,
            -20},{-88,0}})));
  Modelica.Blocks.Sources.Constant T_Set(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-66,12},{-46,32}})));
equation
  connect(weaDat.weaBus, thermalzone.weaBus) annotation (Line(
      points={{-74,74},{-12,74},{-12,42},{-6,42}},
      color={255,204,51},
      thickness=0.5));
  connect(tableInternalGains.y, thermalzone.intGains)
    annotation (Line(points={{43.2,0},{12,0},{12,27.6}}, color={0,0,127}));
  connect(thermalzone.intGainsRad, intGainsRad_port) annotation (Line(points={{14.2,
          39.4},{14.2,38},{66,38},{66,50},{82,50}}, color={191,0,0}));
  connect(thermalzone.intGainsConv, intGainsConv_port) annotation (Line(points={
          {14.2,36.4},{66,36.4},{66,30},{82,30}}, color={191,0,0}));
  connect(ports, thermalzone.ports) annotation (Line(points={{0,-92},{0,22},{4,
          22},{4,28.8}}, color={0,127,255}));
  connect(T_Set.y, thermalzone.TSetHeat) annotation (Line(points={{-45,22},{-12,
          22},{-12,37.2},{-5.6,37.2}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,68},{100,-100}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,68},{100,68},{0,86},{-100,68}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-76,8},{72,-78}},
          textColor={0,0,0},
          textString="Testhall
")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end EON_ERC_Testhall;
