within AixLib.Systems.Benchmark.Examples.RoomModels;
model SimpleRoomVolFlowCtrl_no_ahu_cca
    extends Modelica.Icons.Example;
    package MediumWater = AixLib.Media.Water
    annotation (choicesAllMatching=true);
    package MediumAir = AixLib.Media.AirIncompressible
    annotation (choicesAllMatching=true);

  AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone
                                                    thermalZone1(
    redeclare package Medium = MediumAir,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    zoneParam=AixLib.Systems.Benchmark.BaseClasses.BenchmarkCanteen(),
    ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
            each der_T(fixed=true)))),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    recOrSep=false,
    Heater_on=false,
    Cooler_on=false,
    nPorts=2) "Thermal zone"
    annotation (Placement(transformation(extent={{6,22},{56,68}})));

  AixLib.BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{-76,54},{-42,86}}),
    iconTransformation(extent={{-150,388},{-130,408}})));

  Modelica.Blocks.Interfaces.RealOutput TAirRoom "Indoor air temperature"
    annotation (Placement(transformation(extent={{86,50},{106,70}})));
  Modelica.Blocks.Interfaces.RealInput internal_gain_1 annotation (Placement(
        transformation(extent={{-118,-42},{-98,-22}}), iconTransformation(
          extent={{-118,-42},{-98,-22}})));
  Modelica.Blocks.Interfaces.RealInput internal_gain_2 annotation (Placement(
        transformation(extent={{-118,-58},{-98,-38}}), iconTransformation(
          extent={{-118,-42},{-98,-22}})));
  Modelica.Blocks.Interfaces.RealInput internal_gain_3 annotation (Placement(
        transformation(extent={{-118,-72},{-98,-52}}), iconTransformation(
          extent={{-118,-42},{-98,-22}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsConv1
    "Convective internal gains"
    annotation (Placement(transformation(extent={{-40,-96},{-20,-76}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-76,-96},{-56,-76}})));
  Modelica.Blocks.Interfaces.RealInput Q_flow_cca annotation (Placement(
        transformation(extent={{-112,-96},{-92,-76}}), iconTransformation(
          extent={{-112,-96},{-92,-76}})));
  Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-74,8},{-54,28}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_ahu
    "Prescribed mass flow rate"
    annotation (Placement(transformation(extent={{-122,6},{-82,46}})));
  Modelica.Blocks.Interfaces.RealInput T_in_ahu
    "Prescribed boundary temperature"
    annotation (Placement(transformation(extent={{-122,-22},{-82,18}})));
  Fluid.Sources.Boundary_pT        bou1(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-70,32},{-56,46}})));
  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,

    computeWetBulbTemperature=false,
    filNam=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-126,52},{-106,72}})));
equation
  connect(weaBus, thermalZone1.weaBus) annotation (Line(
      points={{-59,70},{6,70},{6,45}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(thermalZone1.TAir, TAirRoom)
    annotation (Line(points={{58.5,58.8},{96,58.8},{96,60}}, color={0,0,127}));
  connect(internal_gain_1, thermalZone1.intGains[1]) annotation (Line(points={{
          -108,-32},{-28,-32},{-28,23.84},{51,23.84}}, color={0,0,127}));
  connect(internal_gain_2, thermalZone1.intGains[2]) annotation (Line(points={{
          -108,-48},{-28,-48},{-28,25.68},{51,25.68}}, color={0,0,127}));
  connect(internal_gain_3, thermalZone1.intGains[3]) annotation (Line(points={{
          -108,-62},{-30,-62},{-30,27.52},{51,27.52}}, color={0,0,127}));
  connect(thermalZone1.intGainsConv, intGainsConv1) annotation (Line(points={{
          56,33.5},{38,33.5},{38,-84},{-30,-84},{-30,-86}}, color={191,0,0}));
  connect(prescribedHeatFlow.port, intGainsConv1)
    annotation (Line(points={{-56,-86},{-30,-86}}, color={191,0,0}));
  connect(prescribedHeatFlow.Q_flow, Q_flow_cca) annotation (Line(points={{-76,
          -86},{-90,-86},{-90,-84},{-102,-84},{-102,-86}}, color={0,0,127}));
  connect(boundary.ports[1], thermalZone1.ports[1]) annotation (Line(points={{
          -54,18},{32,18},{32,28.44},{25.125,28.44}}, color={0,127,255}));
  connect(boundary.m_flow_in, m_flow_ahu)
    annotation (Line(points={{-76,26},{-102,26}}, color={0,0,127}));
  connect(boundary.T_in, T_in_ahu) annotation (Line(points={{-76,22},{-86,22},{
          -86,-2},{-102,-2}}, color={0,0,127}));
  connect(bou1.ports[1], thermalZone1.ports[2]) annotation (Line(points={{-56,
          39},{-18,39},{-18,28.44},{36.875,28.44}}, color={0,127,255}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-106,62},{-84,62},{-84,70},{-59,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=36000, __Dymola_Algorithm="Dassl"));
end SimpleRoomVolFlowCtrl_no_ahu_cca;
