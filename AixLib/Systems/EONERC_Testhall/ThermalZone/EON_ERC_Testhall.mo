within AixLib.Systems.EONERC_Testhall.ThermalZone;
model EON_ERC_Testhall
ThermalZones.ReducedOrder.ThermalZone.ThermalZone thermalzone(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=288.15,
    internalGainsMode=1,
    use_C_flow=false,
    use_moisture_balance=false,
    redeclare package Medium = AixLib.Media.Air,
    redeclare
      AixLib.Systems.EONERC_Testhall.ThermalZone.TeaserOutput.EON_ERC_Testhall.EON_ERC_Testhall_DataBase.EON_ERC_Testhall_Hall1
      zoneParam(
      T_start=288.15,
      AExt={95.91,389.64,711.0,629.0,389.64},
      specificPeople=0.01,
      activityDegree=1,
      fixedHeatFlowRatePersons=40,
      ratioConvectiveHeatPeople=0.2,
      internalGainsMachinesSpecific=1,
      lightingPowerSpecific=0.2,
      HeaterOn=false),
    redeclare model corG =
        ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
    use_MechanicalAirExchange=false,
    use_NaturalAirExchange=false,
    nPorts=2) "ThermalZone"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

  Modelica.Blocks.Sources.CombiTimeTable tableInternalGains(
    tableOnFile=true,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="Internals",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/ThermalZone/TeaserOutput/EON_ERC_Testhall/InternalGains_EON_ERC_Testhall.txt"),
    columns=2:4)
    "Profiles for internal gains"
    annotation (Placement(transformation(extent={{60,-60},{40,-40}})));

  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports[2](redeclare
      each final package Medium = AixLib.Media.Air)
    "Auxilliary fluid inlets and outlets to indoor air volume" annotation (
      Placement(transformation(extent={{-51,-110},{47,-86}}),
        iconTransformation(extent={{-45,-104},{49,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsRad_port
   "Radiative internal gains" annotation (Placement(
        transformation(extent={{90,30},{110,10}}),iconTransformation(extent={{-108,
            14},{-88,34}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsConv_port
   "convective internal gains" annotation (Placement(
        transformation(extent={{90,-10},{110,-30}}),
                                                  iconTransformation(extent={{-108,
            -20},{-88,0}})));
  BoundaryConditions.WeatherData.Bus
      weaBus "Weather data bus" annotation (Placement(transformation(extent={{-120,
            -20},{-80,20}}),     iconTransformation(extent={{-108,54},{-88,74}})));
equation
  connect(thermalzone.intGainsRad, intGainsRad_port) annotation (Line(points={{20.4,
          6.8},{20.4,38},{66,38},{66,20},{100,20}}, color={191,0,0}));
  connect(thermalzone.intGainsConv, intGainsConv_port) annotation (Line(points={{20.4,
          0.8},{66,0.8},{66,-20},{100,-20}},      color={191,0,0}));
  connect(ports, thermalzone.ports) annotation (Line(points={{-2,-98},{-2,-54},
          {0,-54},{0,-14.4}},
                         color={0,127,255}));
  connect(tableInternalGains.y[1], thermalzone.intGains[3])
    annotation (Line(points={{39,-50},{16,-50},{16,-16}},
                                                       color={0,0,127}));
  connect(tableInternalGains.y[3], thermalzone.intGains[1])
    annotation (Line(points={{39,-50},{16,-50},{16,-17.6}},
                                                         color={0,0,127}));
  connect(tableInternalGains.y[2], thermalzone.intGains[2])
    annotation (Line(points={{39,-50},{16,-50},{16,-16.8}},
                                                         color={0,0,127}));
  connect(thermalzone.weaBus, weaBus) annotation (Line(
      points={{-20,12},{-32,12},{-32,0},{-100,0}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{96,20},{242,-32}},
          textColor={0,0,0},
          textString="Testhall
")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end EON_ERC_Testhall;
